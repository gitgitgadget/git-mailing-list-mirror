From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2009, #02; Wed, 12)
Date: Wed, 12 Aug 2009 19:14:53 -0700
Message-ID: <7vtz0co3xe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 04:15:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbPqT-0005h5-Eu
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 04:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbZHMCPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 22:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbZHMCPA
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 22:15:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59697 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbZHMCO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 22:14:59 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6DBB927325;
	Wed, 12 Aug 2009 22:14:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3A97727324; Wed, 12 Aug 2009
 22:14:54 -0400 (EDT)
X-master-at: 6ffd781226f04629eff63a684b47ad7555143312
X-next-at: e5cd0abadfa20eaf7a76784ad5802115c75eff2f
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 18E1ACE2-87AF-11DE-AF83-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125764>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

After the 1.6.5 cycle, the next release will be 1.7.0, and we will push
out the planned "push safety" change.  1.7.0 would be a good time to
introduce "justifiable" changes that are not strictly backward compatible.

During 1.6.5 cycle, 'next' will hold topics meant for 1.6.5 and 1.7.0.

----------------------------------------------------------------
[New Topics]

* ld/p4 (Thu Jul 30 00:13:46 2009 +0100) 1 commit
 - git-p4: stream from perforce to speed up clones

Waiting for Ack/Nack from stakeholders.  Probably I should merge this to
'next' soon, keep it there for a week and see if anybody screams, aka
"Nack now or forever hold your peace" ;-).

* mr/gitweb-xz (Thu Aug 6 10:28:25 2009 -0400) 3 commits
 - gitweb: add support for XZ compressed snapshots
 - gitweb: update INSTALL regarding specific snapshot settings
 - gitweb: support to globally disable a snapshot format

This should be safe as long as it does not silently enable itself for
folks who merely updated gitweb to this version without explicitly asking
for the new format (but I do not remember if that is what the patch does).

* jh/cvs-helper (Wed Aug 12 02:13:51 2009 +0200) 4 commits
 - Add simple selftests of git-remote-cvs functionality
 - Third draft of CVS remote helper program
 - Add Python support library for CVS remote helper
 - Basic build infrastructure for Python scripts

Builds on db/vcs-helper.  The last round failed its own selftest for me,
but this one seems to be Ok.  Documentation/git-remote-cvs.txt needs to be
fixed to build, though.

* bc/maint-am-email (Thu Aug 6 20:08:13 2009 -0500) 2 commits
 + git-am: print fair error message when format detection fails
 + am: allow individual e-mail files as input

It seems that the "not mbox but a single piece of e-mail" format was
something many people relied on.  I'm cooking this in 'next', and
hopefully it can graduate both to 'master' and 'maint'.

* js/maint-cover-letter-non-ascii (Mon Aug 10 18:22:22 2009 +0200) 2 commits
 + Correctly mark cover letters' encodings if they are not pure ASCII
 + Expose the has_non_ascii() function

* jc/verify-pack-stat (Fri Aug 7 15:45:30 2009 -0700) 2 commits
 + verify-pack --stat-only: show histogram without verifying
 + Merge branch 'maint' into jc/verify-pack-stat

* lt/block-sha1 (Wed Aug 12 15:47:55 2009 -0400) 15 commits
 + block-sha1: support for architectures with memory alignment
   restrictions
 + block-sha1: split the different "hacks" to be individually
   selected
 + block-sha1: move code around
 + block-sha1: improve code on large-register-set machines
 + block-sha1: improved SHA1 hashing
 + block-sha1: perform register rotation using cpp
 + block-sha1: get rid of redundant 'lenW' context
 + block-sha1: Use '(B&C)+(D&(B^C))' instead of '(B&C)|(D&(B|C))' in
   round 3
 + block-sha1: macroize the rounds a bit further
 + block-sha1: re-use the temporary array as we calculate the SHA1
 + block-sha1: make the 'ntohl()' part of the first SHA1 loop
 + block-sha1: minor fixups
 + block-sha1: try to use rol/ror appropriately
 + block-sha1: undo ctx->size change
 + Add new optimized C 'block-sha1' routines

Linus's "written in C, faster than handcrafted asm" SHA-1 implementation
with clean-up and ARM support from Nico.

* nd/sparse (Tue Aug 11 22:44:06 2009 +0700) 8 commits
 . --sparse for porcelains
 . Support sparse checkout in unpack_trees() and read-tree
 . unpack-trees.c: generalize verify_* functions
 . dir.c: export excluded_1() and add_excludes_from_file_1()
 . excluded_1(): support exclude "directories" in index
 . Read .gitignore from index if it is assume-unchanged
 . Avoid writing to buffer in add_excludes_from_file_1()
 . Prevent diff machinery from examining assume-unchanged entries on
   worktree

Privately applied but not yet queued to 'pu', expecting a minor reroll
near the tip.

* jk/maint-merge-msg-fix (Sun Aug 9 06:02:51 2009 -0400) 3 commits
 + merge: indicate remote tracking branches in merge message
 + merge: fix incorrect merge message for ambiguous tag/branch
 + add tests for merge message headings

----------------------------------------------------------------
[Graduated to "master"]

* zf/maint-gitweb-acname (Sun Aug 2 09:42:24 2009 +0200) 1 commit
 - gitweb: parse_commit_text encoding fix

* jc/maint-merge-recursive-fix (Thu Jul 30 17:38:15 2009 -0700) 1 commit
 - merge-recursive: don't segfault while handling rename clashes

* js/run-command-updates (Tue Aug 4 11:28:40 2009 +0200) 7 commits
 + run-command.c: squelch a "use before assignment" warning
 + receive-pack: remove unnecessary run_status report
 + run_command: report failure to execute the program, but optionally
   don't
 + run_command: encode deadly signal number in the return value
 + run_command: report system call errors instead of returning error
   codes
 + run_command: return exit code as positive value
 + MinGW: simplify waitpid() emulation macros

* mk/grep-max-depth (Wed Jul 22 19:52:15 2009 +0200) 1 commit
 + grep: Add --max-depth option.

* jp/symlink-dirs (Wed Jul 29 20:22:25 2009 -0700) 3 commits
 + git-checkout: be careful about untracked symlinks
 + lstat_cache: guard against full match of length of 'name'
   parameter
 + Demonstrate bugs when a directory is replaced with a symlink

----------------------------------------------------------------
[In 'next']

* bc/mailsplit-cr-at-eol (Tue Aug 4 22:31:59 2009 -0500) 4 commits
 + Allow mailsplit (and hence git-am) to handle mails with CRLF line-
   endings
 + builtin-mailsplit.c: remove read_line_with_nul() since it is no
   longer used
 + builtin-mailinfo,builtin-mailsplit: use strbufs
 + strbuf: add new function strbuf_getwholeline()

* gb/apply-ignore-whitespace (Tue Aug 4 13:16:49 2009 +0200) 1 commit
 + git apply: option to ignore whitespace differences

* cc/replace (Wed May 27 07:14:09 2009 +0200) 14 commits
 + t6050: check pushing something based on a replaced commit
 + Documentation: add documentation for "git replace"
 + Add git-replace to .gitignore
 + builtin-replace: use "usage_msg_opt" to give better error messages
 + parse-options: add new function "usage_msg_opt"
 + builtin-replace: teach "git replace" to actually replace
 + Add new "git replace" command
 + environment: add global variable to disable replacement
 + mktag: call "check_sha1_signature" with the replacement sha1
 + replace_object: add a test case
 + object: call "check_sha1_signature" with the replacement sha1
 + sha1_file: add a "read_sha1_file_repl" function
 + replace_object: add mechanism to replace objects found in
   "refs/replace/"
 + refs: add a "for_each_replace_ref" function

* jc/1.7.0-diff-whitespace-only-status (Sat May 23 01:15:35 2009 -0700) 2 commits
 + diff: Rename QUIET internal option to QUICK
 + diff: change semantics of "ignore whitespace" options

This changes exit code from "git diff --ignore-whitespace" and friends
when there is no actual output.  It is a backward incompatible change, but
we could argue that it is a bugfix.

* jc/1.7.0-push-safety (Mon Feb 9 00:19:46 2009 -0800) 2 commits
 + Refuse deleting the current branch via push
 + Refuse updating the current branch in a non-bare repository via
   push

----------------------------------------------------------------
[In 'pu']

* jn/gitweb-blame (Thu Aug 6 19:11:52 2009 +0200) 14 commits
 - gitweb: Create links leading to 'blame_incremental' using
   JavaScript
 - gitweb: Incremental blame (proof of concept)
 - gitweb: Add optional "time to generate page" info in footer
 + Revert the four topmost commits from jn/gitweb-blame topic
 + gitweb: Create links leading to 'blame_incremental' using
   JavaScript
 + gitweb: Incremental blame (proof of concept)
 + gitweb: Add optional "time to generate page" info in footer
 + gitweb: Add -partial_query option to href() subroutine
 + gitweb: Use light/dark for class names also in 'blame' view
 + gitweb: Add author initials in 'blame' view, a la "git gui blame"
 + gitweb: Mark commits with no "previous" in 'blame' view
 + gitweb: Use "previous" header of git-blame -p in 'blame' view
 + gitweb: Mark boundary commits in 'blame' view
 + gitweb: Make .error style generic

I haven't picked up Jakub's replacement to the second one from the tip.
We probably should merge up to "Use light/dark" (aef3768) to 'master' and
start the rest over.

* jc/maint-clean-nested-dir-safety (Tue Jun 30 15:33:45 2009 -0700) 1 commit
 + clean: require double -f options to nuke nested git repository and
   work tree

This probably should go in 'master' soonish.

* jc/shortstatus (Tue Aug 4 23:55:22 2009 -0700) 12 commits
 - git stat -s: short status output
 - git stat: pathspec limits, unlike traditional "git status"
 - git stat: the beginning
 + wt-status: collect untracked files in a separate "collect" phase
 + Make git_status_config() file scope static to builtin-commit.c
 + wt-status: move wt_status_colors[] into wt_status structure
 + wt-status: move many global settings to wt_status structure
 + commit: --dry-run
 + status: show worktree status of conflicted paths separately
 + wt-status.c: rework the way changes to the index and work tree are
   summarized
 + diff-index: keep the original index intact
 + diff-index: report unmerged new entries

Slowly progressing.  I've addressed issues pointed out by Jeff in his
review, and hopefully the whole thing would be ready to go.

* db/vcs-helper (Sun Aug 9 15:28:28 2009 -0400) 17 commits
 - Allow helpers to request marks for fast-import
 - Allow helpers to report in "list" command that the ref is
   unchanged
 - Add support for "import" helper command
 - transport-helper_init(): fix a memory leak in error path
 - Add a config option for remotes to specify a foreign vcs
 - Allow programs to not depend on remotes having urls
 - Allow fetch to modify refs
 - Use a function to determine whether a remote is valid
 - Use a clearer style to issue commands to remote helpers
 + Makefile: install hardlinks for git-remote-<scheme> supported by
   libcurl if possible
 + Makefile: do not link three copies of git-remote-* programs
 + Makefile: git-http-fetch does not need expat
 + http-fetch: Fix Makefile dependancies
 + Add transport native helper executables to .gitignore
 + git-http-fetch: not a builtin
 + Use an external program to implement fetching with curl
 + Add support for external programs for handling native fetches

This consolidates various previous rounds from Daniel and Johan.  It seems
that the use of colon ':' before vcs helper name needs to be corrected
before this series can go further.

* je/send-email-no-subject (Wed Aug 5 18:49:54 2009 +0200) 1 commit
 - send-email: confirm on empty mail subjects

This seems to break t9001.  Near the tip of 'pu' I have a iffy workaround.

* jh/notes (Wed Jul 29 04:25:26 2009 +0200) 8 commits
 - t3302-notes-index-expensive: Speed up create_repo()
 - fast-import: Add support for importing commit notes
 - First draft of notes tree parser with support for fanout subtrees
 - Teach "-m <msg>" and "-F <file>" to "git notes edit"
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes

* cc/sequencer-rebase-i (Wed Aug 5 22:53:00 2009 +0200) 8 commits
 - rebase -i: use "git sequencer--helper --reset-hard"
 - sequencer: add "--reset-hard" option to "git sequencer--helper"
 - sequencer: add comments about reset_almost_hard()
 - sequencer: add "reset_almost_hard()" and related functions
 - rebase -i: use "git sequencer--helper --make-patch"
 - sequencer: free memory used in "make_patch" function
 - sequencer: add "make_patch" function to save a patch
 - sequencer: add "builtin-sequencer--helper.c"

More sequencer updates.  I didn't look at the latest round that had a
handful "oops, fix that earlier botch" patches, expecting a cleaner
reroll.

* jc/mailinfo-remove-brackets (Wed Jul 15 15:31:12 2009 -0700) 1 commit
 - mailinfo: -b option keeps [bracketed] strings that is not a
   [PATCH] marker

* tr/reset-checkout-patch (Tue Jul 28 23:20:12 2009 +0200) 8 commits
 - DWIM 'git stash save -p' for 'git stash -p'
 - Merge branch 'js/stash-dwim' into tr/reset-checkout-patch
 - Make 'git stash -k' a short form for 'git stash save --keep-index'
 - Implement 'git stash save --patch'
 - Implement 'git checkout --patch'
 - Implement 'git reset --patch'
 - builtin-add: refactor the meat of interactive_add()
 - git-apply--interactive: Refactor patch mode code

Progress?

* js/stash-dwim (Mon Jul 27 20:37:10 2009 +0200) 1 commit
 - Make 'git stash -k' a short form for 'git stash save --keep-index'

This should be merged to 'next' soonish, but I keep forgetting.

* pb/tracking (Thu Jul 16 16:26:15 2009 -0500) 7 commits
 . branch.c: if remote is not config'd for branch, don't try delete
   push config
 . branch, checkout: introduce autosetuppush
 . move deletion of merge configuration to branch.c
 . remote: add per-remote autosetupmerge and autosetuprebase
   configuration
 . introduce a struct tracking_config
 . branch: install_branch_config and struct tracking refactoring
 . config: allow false and true values for branch.autosetuprebase

Has been ejected from 'pu' for some time, expecting a reroll.

* jc/log-tz (Tue Mar 3 00:45:37 2009 -0800) 1 commit
 - Allow --date=local --date=other-format to work as expected
