# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/backend/board'
require 'test/unit'

class BoardTest < Test::Unit::TestCase
  def test_dimension
    dimension = 5
    number_mines = 1
    board = Board.new(dimension, number_mines)
    assert_equal(dimension, board.dimension)
  end

  def test_mine_count
    dimension = 4
    number_mines = 1
    board = Board.new(dimension, number_mines)
    count = 0
    board.cells.each do |row|
      row.each do |cell|
        count += 1 if cell.has_mine
      end
    end
    assert_equal(number_mines, count)
  end

  def test_mine_neighbours
    mine_cells = [0, 3]
    board = Board.new(2, 2, mine_cells)
    values = []
    board.cells.each do |row|
      row.each do |cell|
        values.append(cell.value)
      end
    end
    assert_equal([1, 2, 2, 1], values)
  end

  def test_validate_position_user_enters_a_letter
    dimension = 4
    number_mines = 1
    board = Board.new(dimension, number_mines)
    result = board.validate_position('a')
    assert_equal(false, result)
  end

  def test_validate_position_user_enters_out_of_dimension_value
    dimension = 4
    number_mines = 1
    board = Board.new(dimension, number_mines)
    result = board.validate_position('8')
    assert_equal(false, result)
    result = board.validate_position('-1')
    assert_equal(false, result)
  end

  def test_validate_position_user_enters_correct_value
    dimension = 4
    number_mines = 1
    board = Board.new(dimension, number_mines)
    result = board.validate_position('2')
    assert_equal(true, result)
  end

  def test_check_flags_limit
    mine_cells = [0, 3]
    board = Board.new(2, 2, mine_cells)
    board.make_move(board.cells[0][0], '2')
    board.make_move(board.cells[1][1], '2')
    check = board.check_flags('2')
    assert_equal(true, check)
  end

  def test_check_flags
    mine_cells = [0, 3]
    board = Board.new(2, 2, mine_cells)
    board.make_move(board.cells[0][0], '2')
    check = board.check_flags('2')
    assert_equal(false, check)
  end
end
