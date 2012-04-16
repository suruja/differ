module Differ
  module Format
    module Passage
      class << self
        def format(change, length = 0)
          (change.change? && as_change(change, length)) ||
          (change.delete? && as_delete(change, length)) ||
          (change.insert? && as_insert(change, length))
        end

      private
        def as_insert(change, length)
          { :method => :insert, :content => change.insert, :at => length }
        end

        def as_delete(change, length)
          { :method => :delete, :content => change.delete, :from => length, :to => length + change.delete.length - 1 }
        end

        def as_change(change, length)
          { :method => :change, :content => change.insert, :from => length, :to => length + change.delete.length - 1 }
        end
      end
    end
  end
end
