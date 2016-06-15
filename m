From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2009, #03; Sun, 13)
Date: Sun, 13 Sep 2009 03:10:53 -0700
Message-ID: <7v63bnw3wy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 12:11:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmm31-0004bT-Gn
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 12:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652AbZIMKLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 06:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbZIMKLA
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 06:11:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39974 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbZIMKK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 06:10:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 815F230408;
	Sun, 13 Sep 2009 06:11:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=mrXk
	BVWn9XLIIKCXdX7a0xvzk50=; b=NMNPie+lfg5cja9iv2D1HTW0mVYewRCdMvwR
	qUB1FE0x0xgSovjQyPVknI8SGvDzmeN/z6bx/CJTYracpWtozCW1kbZtfH7p42Tk
	pop3PzLcU7y8LxX6kqaZqgx9fmaDWDYAmQdu3k8R8Y2c5RNuz3QahqHy4ND3f7Nn
	7opmrVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=dD2
	u91ZvT7NGxS9XLIkL4BltbtxjgWqvNjt8Yfs1+2NEY6x3d2TahxjZoELWOr4+qOJ
	toSN14YUlscHYXdTbPOPbg66rFyAX1v3uiV+EEGMm5Bszv4g+9l1F0jL460cwOQ+
	3ZjciVXmjx2GokZC1BUN6x8NUp3LRkAx97F9+t0U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7251530406;
	Sun, 13 Sep 2009 06:10:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E58030405; Sun, 13 Sep
 2009 06:10:55 -0400 (EDT)
X-master-at: eaf1c941bbc10f5aa67fcf64e316fb548b910cfe
X-next-at: ad50cbaea8afd009cb843c743b248c53ed6285ee
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BBFB42BA-A04D-11DE-AE41-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128349>

What's cooking in git.git (Sep 2009, #03; Sun, 13)
--------------------------------------------------

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

During 1.6.5 cycle, 'next' will hold topics meant for 1.6.5 and 1.7.0.

I tagged and pushed out 1.6.5-rc1.  As far as I am concered, all the big
topics eligible for 1.6.5 are now in, except for possibly gfi-options
series from Sverre.  Updates to subsystems (svn, gitk, gui, and gitweb)
may still need to be merged in.

I've been hoping to keep this cycle short, and I'm also hoping to tag the
real 1.6.5 before I vanish for about a week and half later in the
month. so it looks like there may have to be a 1.6.6 to include the
leftover topics.

--------------------------------------------------
[Graduated to "master"]

* jc/merge-saner-messages (2009-09-07) 1 commit
 + merge-recursive: give less scary messages when merge did not start

* rc/maint-http-no-head-pack-check (2009-09-09) 1 commit.
 + http.c: remove verification of remote packs

* db/vcs-helper (2009-09-03) 16 commits
 + Use a clearer style to issue commands to remote helpers
 + Make the "traditionally-supported" URLs a special case
  (merged to 'next' on 2009-08-07 at f3533ba)
 + Makefile: install hardlinks for git-remote-<scheme> supported by libcurl if possible
 + Makefile: do not link three copies of git-remote-* programs
 + Makefile: git-http-fetch does not need expat
 + http-fetch: Fix Makefile dependancies
 + Add transport native helper executables to .gitignore
 + git-http-fetch: not a builtin
 + Use an external program to implement fetching with curl
 + Add support for external programs for handling native fetches

Up to the part that eject -lcurl from the main "git" binary cleanly are
now in 'master', with a few fix-ups from Jim Mayering.

* cb/maint-1.6.3-grep-relative-up (2009-09-05) 2 commits.
 + grep: accept relative paths outside current working directory
 + grep: fix exit status if external_grep() punts

* jk/unwanted-advices (2009-09-09) 2 commits
 + status: make "how to stage" messages optional
 + push: make non-fast-forward help message configurable

* jt/pushinsteadof (2009-09-07) 2 commits
 + Add url.<base>.pushInsteadOf: URL rewriting for push only
 + Wrap rewrite globals in a struct in preparation for adding another set

* pk/fast-import-tars (2009-09-03) 1 commit
 + import-tars: Allow per-tar author and commit message.

* pk/fast-import-dirs (2009-09-03) 1 commit
 + Add script for importing bits-and-pieces to Git.

--------------------------------------------------
[New Topics]

* db/vcs-helper-rest (2009-09-03) 6 commits
 - Allow helpers to report in "list" command that the ref is unchanged
 - Add support for "import" helper command
 - Add a config option for remotes to specify a foreign vcs
 - Allow programs to not depend on remotes having urls
 - Allow fetch to modify refs
 - Use a function to determine whether a remote is valid
 (this branch is used by jh/cvs-helper.)

This is not exactly new.  It holds the remainder of the db/vcs-helper
topic.

--------------------------------------------------
[Stalled]

* je/send-email-no-subject (2009-08-05) 1 commit
  (merged to 'next' on 2009-08-30 at b6455c2)
 + send-email: confirm on empty mail subjects

The existing tests to covers the positive case (i.e. as long as the user
says "yes" to the "do you really want to send this message that lacks
subject", the message is sent) of this feature, but the feature itself
needs its own test to verify the negative case (i.e. does it correctly
stop if the user says "no"?)

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
 . support for commit grafts, slight change to general mechanism
 . support for path name caching in rev-cache
 . full integration of rev-cache into git, completed test suite
 . administrative functions for rev-cache, start of integration into git
 . support for non-commit object caching in rev-cache
 . basic revision cache system, no integration or features
 . man page and technical discussion for rev-cache

Replaced but I do not think this is ready for 'pu' yet.

--------------------------------------------------
[Cooking]

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
 - Prepare 'traverse_trees()' for D/F conflict lookahead

Beginning of the fix to a rather nasty longstanding issue of merging trees
with ("a" "a-b"), ("a/b" "a-b") and just ("a-b"), but my reading of it is
that it is just the first step to demonstrate one-entry lookahead and not
a full solution yet.

* jc/maint-1.6.0-blank-at-eof (2009-09-05) 10 commits.
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

This started a bit late in the cycle, and I'd rather hold it back during
this feature freeze and push it out after 1.6.5 final.

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

Perhaps 1.6.5 material but I wasn't sure.

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

* cc/sequencer-rebase-i (2009-08-28) 15 commits
 - rebase -i: use "git sequencer--helper --cherry-pick"
 - sequencer: add "--cherry-pick" option to "git sequencer--helper"
 - sequencer: add "do_commit()" and related functions working on "next_commit"
 - pick: libify "pick_help_msg()"
 - revert: libify cherry-pick and revert functionnality
 - rebase -i: use "git sequencer--helper --fast-forward"
 - sequencer: let "git sequencer--helper" callers set "allow_dirty"
 - sequencer: add "--fast-forward" option to "git sequencer--helper"
 - sequencer: add "do_fast_forward()" to perform a fast forward
 - rebase -i: use "git sequencer--helper --reset-hard"
 - sequencer: add "--reset-hard" option to "git sequencer--helper"
 - sequencer: add "reset_almost_hard()" and related functions
 - rebase -i: use "git sequencer--helper --make-patch"
 - sequencer: add "make_patch" function to save a patch
 - sequencer: add "builtin-sequencer--helper.c"

This was to be replaced with multiple bite-sized smaller topics.  We've
seen one such topic for "git reset" on the list.
