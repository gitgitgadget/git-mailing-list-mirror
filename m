From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2009, #03; Wed, 29)
Date: Wed, 29 Jul 2009 14:19:46 -0700
Message-ID: <7vzlanqj9p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 23:20:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWGZD-0001xw-7j
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 23:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbZG2VTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 17:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753953AbZG2VTu
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 17:19:50 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944AbZG2VTs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 17:19:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1573D19355;
	Wed, 29 Jul 2009 17:19:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 41F1019353; Wed,
 29 Jul 2009 17:19:47 -0400 (EDT)
X-master-at: e6580020057afd207b7cfb9c96905f99e13cfe4d
X-next-at: 4719968c98d7ad8352bb14916c65c094842a980d
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8C1ADA42-7C85-11DE-8AD6-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124392>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

In preparation for rewinding 'next' after a major release, one topic was
reverted and kicked back to 'pu' to give it a fresh start.

After the 1.6.5 cycle, the next release will be 1.7.0, and we will push
out the planned "push safety" change.  1.7.0 would be a good time to
introduce "justifiable" changes that are not strictly backward compatible.

During 1.6.5 cycle, 'next' will hold topics meant for 1.6.5 and 1.7.0.
I've already merged the "diff --exit-code --ignore-whitespace" change and
"push safety" change.

I'll rewind 'next' sometime this weekend.

----------------------------------------------------------------
[In 'next']

* ne/futz-upload-pack (Wed Jun 10 01:50:18 2009 +0200) 1 commit
 + Shift object enumeration out of upload-pack

* js/run-command-updates (Sat Jul 4 21:26:43 2009 +0200) 6 commits
 + receive-pack: remove unnecessary run_status report
 + run_command: report failure to execute the program, but optionally
   don't
 + run_command: encode deadly signal number in the return value
 + run_command: report system call errors instead of returning error
   codes
 + run_command: return exit code as positive value
 + MinGW: simplify waitpid() emulation macros

* sb/maint-pull-rebase (Sun Jul 19 09:45:16 2009 +0200) 2 commits
 + pull: support rebased upstream + fetch + pull --rebase
 + t5520-pull: Test for rebased upstream + fetch + pull --rebase

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

This is old 'jc/deny-delete-current-1.7.0' and 'jc/1.7.0-push-safety'
topics redone.

* sb/read-tree (Thu Jun 25 22:14:10 2009 -0700) 2 commits
 + read-tree: migrate to parse-options
 + read-tree: convert unhelpful usage()'s to helpful die()'s

* sb/parse-options (Tue Jul 7 22:15:41 2009 -0700) 4 commits
 + prune-packed: migrate to parse-options
 + verify-pack: migrate to parse-options
 + verify-tag: migrate to parse-options
 + write-tree: migrate to parse-options

Parse-options migration; should be in 'master' soonish.

* mk/grep-max-depth (Wed Jul 22 19:52:15 2009 +0200) 1 commit
 + grep: Add --max-depth option.

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

Does not seem to hurt normal operation without "replace".  The basic idea
should be easier and safer to use than the graft mechanism.  I haven't
tried the replacement myself, though.

* ns/init-mkdir (Sat Jul 25 06:59:28 2009 +0900) 1 commit
 + git init: optionally allow a directory argument

Straightforward usability change.  Should be in 'master' soonish.

* mk/init-db-parse-options (Sun Jul 12 12:24:32 2009 +0200) 1 commit
 + init-db: migrate to parse-options

* jk/maint-show-tag (Sat Jul 18 06:14:37 2009 -0400) 2 commits
 + show: add space between multiple items
 + show: suppress extra newline when showing annotated tag

* jc/apply-epoch-patch (Fri Jul 10 18:38:08 2009 -0700) 1 commit
 + apply: notice creation/removal patches produced by GNU diff

Better acceptance of some "GNU patch" output to create or remove files.

----------------------------------------------------------------
[In 'pu']

* jp/symlink-dirs (Sun Jun 14 15:08:28 2009 +0200) 2 commits
 - lstat_cache: guard against full match of length of 'name'
   parameter
 - Demonstrate bugs when a directory is replaced with a symlink

James's test scripts to expose corner case bugs in the merge and branch
switching machinery.

* jh/vcs-cvs (Mon Jul 27 03:04:17 2009 +0200) 15 commits
 - Introduce a 'marks <filename>' feature to the foreign transport
   code
 - Teach foreign transport code to perform the "capabilities" command
 - Preliminary clarifications to git-vcs documentation
 - fast-import: Add support for importing commit notes
 - Add a transport implementation using git-vcs-* helpers
 - Allow programs to not depend on remotes having urls
 - Use a function to determine whether a remote is valid
 - Add specification of git-vcs-* helper programs
 - Merge branch 'db/transport-shim' into jh/vcs-cvs
 - git-http-fetch: not a builtin
 - Use an external program to implement fetching with curl
 - Add support for external programs for handling native fetches
 - Add option for using a foreign VCS
 - Document details of transport function APIs
 - Allow late reporting of fetched hashes

With its 6th patch replaced to keep the pathname syntax of the fast-import
language, but without the commits near the tip of the old series.

* db/transport-shim (Tue Jul 28 02:08:53 2009 -0400) 3 commits
 - git-http-fetch: not a builtin
 - Use an external program to implement fetching with curl
 - Add support for external programs for handling native fetches

* jh/notes (Wed Jul 29 04:25:26 2009 +0200) 8 commits
 - t3302-notes-index-expensive: Speed up create_repo()
 - fast-import: Add support for importing commit notes
 - First draft of notes tree parser with support for fanout subtrees
 - Teach "-m <msg>" and "-F <file>" to "git notes edit"
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes

jh/vcs-cvs topic needs to be rebuilt, merging this instead of having its
own copy of "fast-import: Add support for importing commit notes".

* db/foreign-scm (Tue Mar 24 23:04:12 2009 -0400) 3 commits
 - Add option for using a foreign VCS
 - Document details of transport function APIs
 - Allow late reporting of fetched hashes

* cc/sequencer-rebase-i (Fri Jun 26 23:08:46 2009 +0200) 4 commits
 - rebase -i: use "git sequencer--helper --make-patch"
 - sequencer: free memory used in "make_patch" function
 - sequencer: add "make_patch" function to save a patch
 - sequencer: add "builtin-sequencer--helper.c"

I do not know how this will interact with what Dscho has been doing.

* jc/mailinfo-remove-brackets (Wed Jul 15 15:31:12 2009 -0700) 1 commit
 - mailinfo: -b option keeps [bracketed] strings that is not a
   [PATCH] marker

* jn/gitweb-blame (Sat Jul 25 00:44:10 2009 +0200) 10 commits
 - gitweb: Create links leading to 'blame_incremental' using
   JavaScript
 - gitweb: Incremental blame (proof of concept)
 - gitweb: Add optional "time to generate page" info in footer
 - gitweb: Add -partial_query option to href() subroutine
 - gitweb: Use light/dark for class names also in 'blame' view
 - gitweb: Add author initials in 'blame' view, a la "git gui blame"
 - gitweb: Mark commits with no "previous" in 'blame' view
 - gitweb: Use "previous" header of git-blame -p in 'blame' view
 - gitweb: Mark boundary commits in 'blame' view
 - gitweb: Make .error style generic

There may have been updates during 1.6.4-rc period that I missed.

* tr/reset-checkout-patch (Tue Jul 28 23:20:11 2009 +0200) 5 commits
 - Implement 'git stash save --patch'
 - Implement 'git checkout --patch'
 - Implement 'git reset --patch'
 - builtin-add: refactor the meat of interactive_add()
 - git-apply--interactive: Refactor patch mode code

* jc/log-tz (Tue Mar 3 00:45:37 2009 -0800) 1 commit
 - Allow --date=local --date=other-format to work as expected

* pb/tracking (Thu Jul 16 16:26:15 2009 -0500) 7 commits
 - branch.c: if remote is not config'd for branch, don't try delete
   push config
 - branch, checkout: introduce autosetuppush
 - move deletion of merge configuration to branch.c
 - remote: add per-remote autosetupmerge and autosetuprebase
   configuration
 - introduce a struct tracking_config
 - branch: install_branch_config and struct tracking refactoring
 - config: allow false and true values for branch.autosetuprebase

This has been reverted from 'next' for now to give it a fresh start.

----------------------------------------------------------------
[Dropped]

* ar/maint-1.6.2-merge-recursive-d-f (Mon May 11 21:25:36 2009 +0200) 2 commits
 . Fix for a merge where a branch has an F->D transition
 . Add a reminder test case for a merge with F/D transition

The fix the author hinted iffy is dropped for now, but the test case is
already in 'master' to remind us.
