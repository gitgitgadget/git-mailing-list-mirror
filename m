From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2009, #05; Wed, 23)
Date: Tue, 22 Sep 2009 23:56:11 -0700
Message-ID: <7vhbuui1ys.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 08:56:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqLm3-0007oE-VZ
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 08:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbZIWG4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 02:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754156AbZIWG4O
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 02:56:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120AbZIWG4N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 02:56:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E41D3DB86;
	Wed, 23 Sep 2009 02:56:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=IL5t
	0eD3oA+Con/nWRbofBUZyD4=; b=qtc6fOoyukUjEHzqiZcQ6HbXelm1IXB/XB7a
	Lt3AUx19oDAziq+lwOTGofHUQN2rUCgbfa9vYoW3gyDfuyY8AF3BB7DnJBZ3E73f
	B3DaNQP6dYqVyJo5bmLzNcWlm0z/sZe+EJjgRgFufLVJ76xurLus7f9Pdp6yR2RD
	T9WkdwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=hGU
	+Zt5fY86sQXWROGHEsTLFrwe+X6ZBDm0bHyZ6cf1mSKDOqdG5OQiWKQ6Kr/oNxAq
	pRJ8iwwRuBzolQYZyhO40Ycb2fgXLhVv9tasBwahoNV20SJqnvFnIbU8kOVhwO1M
	LYmSaeEH2hHMh38UFW+5J1cg0bsYHU48rdjzJIWc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DA313DB84;
	Wed, 23 Sep 2009 02:56:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7934E3DB83; Wed, 23 Sep
 2009 02:56:13 -0400 (EDT)
X-master-at: a6dbf8814f433a7fbfa9cde6333c98019f6db1e4
X-next-at: a9dd6c4e8ab38f5c4af9c0710381d3844f1d904f
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2FF8E182-A80E-11DE-B8EF-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128971>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

In 1.7.0, we plan to correct handful of warts in the interfaces everybody
agrees that they were mistakes.  The resulting system may not be strictly
backward compatible.  Currently planeed changes are:

 * refuse push to update the checked out branch in a non-bare repo by
   default

   Make "git push" into a repository to update the branch that is checked
   out fail by default.  You can countermand this default by setting a
   configuration variable in the receiving repository.

   http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007

 * refuse push to delete the current branch by default

   Make "git push $there :$killed" to delete the branch that is pointed at
   by its HEAD fail by default.  You can countermand this default by
   setting a configuration variable in the receiving repository.

   http://thread.gmane.org/gmane.comp.version-control.git/108862/focus=108936

 * git-send-email won't make deep threads by default

   Many people said that by default when sending more than 2 patches the
   threading git-send-email makes by default is hard to read, and they
   prefer the default be one cover letter and each patch as a direct
   follow-up to the cover letter.  You can countermand this by setting a
   configuration variable.

   http://article.gmane.org/gmane.comp.version-control.git/109790

 * git-status won't be "git-commit --dry-run" anymore

   http://thread.gmane.org/gmane.comp.version-control.git/125989/focus=125993

 * "git-diff -w --exit-code" will exit success if only differences it
   found are whitespace changes that are stripped away from the output.

   http://thread.gmane.org/gmane.comp.version-control.git/119731/focus=119751

We are in pre-release feature freeze.  'next' will hold topics meant for
1.6.6 and 1.7.0.

Tonight's tip of 'master' is 1.6.5-rc2, and I'll disappear for about a
week.  Hopefully when I come back in early October all the regressions are
found and already squashed ;-)

--------------------------------------------------
[New Topics]

* jc/fix-tree-walk (2009-09-14) 9 commits
 - read-tree --debug-unpack
 - unpack-trees.c: look ahead in the index
 - unpack-trees.c: prepare for looking ahead in the index
 - traverse_trees(): handle D/F conflict case sanely
 - more D/F conflict tests
 - tests: move convenience regexp to match object names to test-lib.sh
 - unpack_callback(): use unpack_failed() consistently
 - unpack-trees: typofix
 - diff-lib.c: fix misleading comments on oneway_diff()

This is my replacement for Linus's lt/maint-traverse-trees-fix patch.  It
is not so much as a counter-proposal; I originally thought it might make
sense to walk the index and drive the walker to return the entries from
trees to match entries from the index, but I ended up doing pretty much
what Linus outlined --- walk the trees, and have the index walker follow
it.  It turned out that the index side also needed some hairy look-ahead,
and I am only half satisfied with the current status of the series.

To fix the resolve merge regression seen in t6035, git-merge-resolve needs
to be rewritten not to use the one-path-at-a-time "git merge-index".

* jp/fetch-tag-match (2009-09-17) 1 commit
 - fetch: Speed up fetch by rewriting find_non_local_tags

I did not have much energy left while dealing with the "fix-tree-walk"
series, so I just queued this without reading nor thinking about it very
much.  I personally liked my version that had far smaller number of lines
changed (which means I can be fairly certain that it did not introduce any
regression), but perhaps the majorly rewritten logic this patch gives us
may be easier to follow and maintain.  We'll see.

* jg/log-format-body-indent (2009-09-19) 1 commit
 - [NEEDSWORK: tests] git-log --format: Add %B tag with %B(x) option

* jl/submodule-add-noname (2009-09-22) 1 commit
 - git submodule add: make the <path> parameter optional

--------------------------------------------------
[Stalled]

* je/send-email-no-subject (2009-08-05) 1 commit
  (merged to 'next' on 2009-08-30 at b6455c2)
 + send-email: confirm on empty mail subjects

The existing tests cover the positive case (i.e. as long as the user says
"yes" to the "do you really want to send this message that lacks subject",
the message is sent) of this feature, but the feature itself needs its own
test to verify the negative case (i.e. does it correctly stop if the user
says "no"?)

* jh/cvs-helper (2009-08-18) 8 commits
 - More fixes to the git-remote-cvs installation procedure
 - Fix the Makefile-generated path to the git_remote_cvs package in git-remote-cvs
 - Add simple selftests of git-remote-cvs functionality
 - git-remote-cvs: Remote helper program for CVS repositories
 - 2/2: Add Python support library for CVS remote helper
 - 1/2: Add Python support library for CVS remote helper
 - Basic build infrastructure for Python scripts
 - Allow helpers to request marks for fast-import
 (this branch uses db/vcs-helper-rest.)

Builds on db/vcs-helper.  There is a re-roll planned.

* ne/rev-cache (2009-09-07) 7 commits
 - support for commit grafts, slight change to general mechanism
 - support for path name caching in rev-cache
 - full integration of rev-cache into git, completed test suite
 - administrative functions for rev-cache, start of integration into git
 - support for non-commit object caching in rev-cache
 - basic revision cache system, no integration or features
 - man page and technical discussion for rev-cache

Tonight's 'pu' ships with this and this series seems to break a few
tests.  I didn't debug.

--------------------------------------------------
[Cooking]

* jc/maint-blank-at-eof (2009-09-15) 0 commits.
 (this branch uses jc/maint-1.6.0-blank-at-eof.)

The series does not have a commit of its own but is a preparation for
merging the original jc/1.6.0-maint-blank-at-eof topic to 'maint' and then
'master'.  It is a fix for longstanding bug and 1.6.5 will not contain
this topic.

* db/vcs-helper-rest (2009-09-03) 6 commits
 - Allow helpers to report in "list" command that the ref is unchanged
 - Add support for "import" helper command
 - Add a config option for remotes to specify a foreign vcs
 - Allow programs to not depend on remotes having urls
 - Allow fetch to modify refs
 - Use a function to determine whether a remote is valid
 (this branch is used by jh/cvs-helper.)

This holds the remainder of the db/vcs-helper topic that has already
merged for 1.6.5.

* jh/notes (2009-09-12) 13 commits
 - Selftests verifying semantics when loading notes trees with various fanouts
 - Teach the notes lookup code to parse notes trees with various fanout schemes
 - notes.[ch] fixup: avoid old-style declaration
 - Teach notes code to free its internal data structures on request.
 - Add '%N'-format for pretty-printing commit notes
 - Add flags to get_commit_notes() to control the format of the note string
 - t3302-notes-index-expensive: Speed up create_repo()
 - fast-import: Add support for importing commit notes
 - Teach "-m <msg>" and "-F <file>" to "git notes edit"
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes
 (this branch uses sr/gfi-options.)

Rerolled and queued.

* jn/gitweb-show-size (2009-09-07) 1 commit
 - gitweb: Add 'show-sizes' feature to show blob sizes in tree view

* lt/maint-traverse-trees-fix (2009-09-06) 1 commit.
 . Prepare 'traverse_trees()' for D/F conflict lookahead

Ejected from 'pu' (see jc/fix-tree-walk above).

* jc/maint-1.6.0-blank-at-eof (2009-09-14) 15 commits.
  (merged to 'next' on 2009-09-15 at 9cbfa00)
 + diff -B: colour whitespace errors
 + diff.c: emit_add_line() takes only the rest of the line
 + diff.c: split emit_line() from the first char and the rest of the line
 + diff.c: shuffling code around
 + diff --whitespace: fix blank lines at end
  (merged to 'next' on 2009-09-07 at 165dc3c)
 + core.whitespace: split trailing-space into blank-at-{eol,eof}
 + diff --color: color blank-at-eof
 + diff --whitespace=warn/error: fix blank-at-eof check
 + diff --whitespace=warn/error: obey blank-at-eof
 + diff.c: the builtin_diff() deals with only two-file comparison
 + apply --whitespace: warn blank but not necessarily empty lines at EOF
 + apply --whitespace=warn/error: diagnose blank at EOF
 + apply.c: split check_whitespace() into two
 + apply --whitespace=fix: detect new blank lines at eof correctly
 + apply --whitespace=fix: fix handling of blank lines at the eof
 (this branch is used by jc/maint-blank-at-eof.)

This is a fix for an ancient bug (or inconsistent set of features); the
topic is based on an ancient codebase and is designed to be merged
upwards.  jc/maint-blank-at-eof serves that purpose.

Will not be in 1.6.5.

* jn/gitweb-blame (2009-09-01) 5 commits
 - gitweb: Minify gitweb.js if JSMIN is defined
 - gitweb: Create links leading to 'blame_incremental' using JavaScript
  (merged to 'next' on 2009-09-07 at 3622199)
 + gitweb: Colorize 'blame_incremental' view during processing
 + gitweb: Incremental blame (using JavaScript)
 + gitweb: Add optional "time to generate page" info in footer

Ajax-y blame.

* sr/gfi-options (2009-09-06) 6 commits
  (merged to 'next' on 2009-09-07 at 5f6b0ff)
 + fast-import: test the new option command
 + fast-import: add option command
 + fast-import: test the new feature command
 + fast-import: add feature command
 + fast-import: put marks reading in it's own function
 + fast-import: put option parsing code in separate functions
 (this branch is used by jh/notes.)

Ping?

* nd/sparse (2009-08-20) 19 commits
 - sparse checkout: inhibit empty worktree
 - Add tests for sparse checkout
 - read-tree: add --no-sparse-checkout to disable sparse checkout support
 - unpack-trees(): ignore worktree check outside checkout area
 - unpack_trees(): apply $GIT_DIR/info/sparse-checkout to the final index
 - unpack-trees(): "enable" sparse checkout and load $GIT_DIR/info/sparse-checkout
 - unpack-trees.c: generalize verify_* functions
 - unpack-trees(): add CE_WT_REMOVE to remove on worktree alone
 - Introduce "sparse checkout"
 - dir.c: export excluded_1() and add_excludes_from_file_1()
 - excluded_1(): support exclude files in index
 - unpack-trees(): carry skip-worktree bit over in merged_entry()
 - Read .gitignore from index if it is skip-worktree
 - Avoid writing to buffer in add_excludes_from_file_1()
 - Teach Git to respect skip-worktree bit (writing part)
 - Teach Git to respect skip-worktree bit (reading part)
 - Introduce "skip-worktree" bit in index, teach Git to get/set this bit
 - Add test-index-version
 - update-index: refactor mark_valid() in preparation for new options

--------------------------------------------------
[For 1.7.0]

* jk/1.7.0-status (2009-09-05) 5 commits
 - docs: note that status configuration affects only long format
  (merged to 'next' on 2009-09-07 at 8a7c563)
 + commit: support alternate status formats
 + status: add --porcelain output format
 + status: refactor format option parsing
 + status: refactor short-mode printing to its own function
 (this branch uses jc/1.7.0-status.)

Gives the --short output format to post 1.7.0 "git commit --dry-run" that
is similar to that of post 1.7.0 "git status".

* jc/1.7.0-status (2009-09-05) 4 commits
  (merged to 'next' on 2009-09-06 at 19d4beb)
 + status: typo fix in usage
  (merged to 'next' on 2009-08-22 at b3507bb)
 + git status: not "commit --dry-run" anymore
 + git stat -s: short status output
 + git stat: the beginning of "status that is not a dry-run of commit"
 (this branch is used by jk/1.7.0-status.)

With this, "git status" is no longer "git commit --dry-run".

* jc/1.7.0-send-email-no-thread-default (2009-08-22) 1 commit
  (merged to 'next' on 2009-08-22 at 5106de8)
 + send-email: make --no-chain-reply-to the default

* jc/1.7.0-diff-whitespace-only-status (2009-08-30) 4 commits.
  (merged to 'next' on 2009-08-30 at 0623572)
 + diff.c: fix typoes in comments
  (merged to 'next' on 2009-08-27 at 81fb2bd)
 + Make test case number unique
  (merged to 'next' on 2009-08-02 at 9c08420)
 + diff: Rename QUIET internal option to QUICK
 + diff: change semantics of "ignore whitespace" options

This changes exit code from "git diff --ignore-whitespace" and friends
when there is no actual output.  It is a backward incompatible change, but
we could argue that it is a bugfix.

* jc/1.7.0-push-safety (2009-02-09) 2 commits
  (merged to 'next' on 2009-08-02 at 38b82fe)
 + Refuse deleting the current branch via push
 + Refuse updating the current branch in a non-bare repository via push

--------------------------------------------------
[I have been too busy to purge these]

* jc/log-tz (2009-03-03) 1 commit.
 - Allow --date=local --date=other-format to work as expected

Maybe some people care about this.  I dunno.

* jc/mailinfo-remove-brackets (2009-07-15) 1 commit.
 - mailinfo: -b option keeps [bracketed] strings that is not a [PATCH] marker

Maybe some people care about this.  I dunno.

* lt/read-directory (2009-05-15) 3 commits.
 . Add initial support for pathname conversion to UTF-8
 . read_directory(): infrastructure for pathname character set conversion
 . Add 'fill_directory()' helper function for directory traversal

* cc/reset-merge (2009-09-16) 4 commits
 . reset: add test cases for "--merge-safe" option
 . reset: add option "--merge-safe" to "git reset"
 . reset: use "unpack_trees()" directly instead of "git read-tree"
 . reset: add a few tests for "git reset --merge"

* cc/sequencer-rebase-i (2009-08-28) 15 commits
 . rebase -i: use "git sequencer--helper --cherry-pick"
 . sequencer: add "--cherry-pick" option to "git sequencer--helper"
 . sequencer: add "do_commit()" and related functions working on "next_commit"
 . pick: libify "pick_help_msg()"
 . revert: libify cherry-pick and revert functionnality
 . rebase -i: use "git sequencer--helper --fast-forward"
 . sequencer: let "git sequencer--helper" callers set "allow_dirty"
 . sequencer: add "--fast-forward" option to "git sequencer--helper"
 . sequencer: add "do_fast_forward()" to perform a fast forward
 . rebase -i: use "git sequencer--helper --reset-hard"
 . sequencer: add "--reset-hard" option to "git sequencer--helper"
 . sequencer: add "reset_almost_hard()" and related functions
 . rebase -i: use "git sequencer--helper --make-patch"
 . sequencer: add "make_patch" function to save a patch
 . sequencer: add "builtin-sequencer--helper.c"
