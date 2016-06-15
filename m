From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2009, #05; Mon, 16)
Date: Mon, 16 Feb 2009 23:57:36 -0800
Message-ID: <7vfxid8phr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 08:59:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZKrM-0004xH-6j
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 08:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbZBQH5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 02:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbZBQH5o
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 02:57:44 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47842 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbZBQH5n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 02:57:43 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4F0F79963A;
	Tue, 17 Feb 2009 02:57:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C85DD99639; Tue,
 17 Feb 2009 02:57:38 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A6CB74B0-FCC8-11DD-B4D6-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110325>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

The master branch is slightly past 1.6.2-rc1.

As an experiment, 'next' and 'pu' stay open during this release freeze;
new topics are accepted as time permits, but people are much more strongly
encouraged to find issues on what is already on 'master', and patches to
fix them always takes precedence over what is still on 'next' and will
never graduate until 1.6.2 final.

----------------------------------------------------------------
[New Topics]

* gb/gitweb-base (Sun Feb 15 10:18:36 2009 +0100) 1 commit
 - gitweb: fix wrong base URL when non-root DirectoryIndex

Should this go in 1.6.2-rc2?

* tr/gcov (Sun Feb 15 23:25:45 2009 +0100) 8 commits
 - Test git-patch-id
 - Test rev-list --parents/--children
 - Test log --decorate
 - Test fsck a bit harder
 - Test log --graph
 - Test diff --dirstat functionality
 - Test that diff can read from stdin
 - Support coverage testing with GCC/gcov

* jc/add-p-unquote (Mon Feb 16 22:43:43 2009 -0800) 1 commit
 - git-add -i/-p: learn to unwrap C-quoted paths

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* ns/stash-keep (Thu Feb 12 06:25:14 2009 +0900) 1 commit
 - stash: --keep option just saves

Do we want to keep this one?

* lh/submodule-tree-traversal (Sun Jan 25 01:52:06 2009 +0100) 1 commit
 - archive.c: add support for --submodules[=(all|checkedout)]

Discussion stalled on the submodule selection criteria.

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 + blame: show "previous" information in --porcelain/--incremental
   format
 + git-blame: refactor code to emit "porcelain format" output

This gives Porcelains (like gitweb) the information on the commit _before_
the one that the final blame is laid on, which should save them one
rev-parse to dig further.  The line number in the "previous" information
may need refining, and sanity checking code for reference counting may
need to be resurrected before this can move forward.

I thought recent tig discussion may blow new life into it, but is this
unneeded?  If so I'd rather revert it (or discard after 1.6.2).

* db/foreign-scm (Sun Jan 11 15:12:10 2009 -0500) 3 commits
 - Support fetching from foreign VCSes
 - Add specification of git-vcs helpers
 - Add "vcs" config option in remotes

The "spec" did not seem quite well cooked yet, but in the longer term I
think something like this to allow interoperating with other SCMs as if
the other end is a native git repository is a very worthy goal.

* cc/replace (Mon Feb 2 06:13:06 2009 +0100) 11 commits
 - builtin-replace: use "usage_msg_opt" to give better error messages
 - parse-options: add new function "usage_msg_opt"
 - builtin-replace: teach "git replace" to actually replace
 - Add new "git replace" command
 - environment: add global variable to disable replacement
 - mktag: call "check_sha1_signature" with the replacement sha1
 - replace_object: add a test case
 - object: call "check_sha1_signature" with the replacement sha1
 - sha1_file: add a "read_sha1_file_repl" function
 - replace_object: add mechanism to replace objects found in
   "refs/replace/"
 - refs: add a "for_each_replace_ref" function

I think the code is much cleaner than the first round, but I am not
convinced it is doing the right thing in the connectivity traverser.  
Independent review sorely needed.

* sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
 - gitweb: Optional grouping of projects by category
 - gitweb: Split git_project_list_body in two functions
 - gitweb: Modularized git_get_project_description to be more generic

Design discussion between Jakub and Sebastien seems to have stalled, but
Jakub seems to be taking this over.

* jc/fsck (Fri Jan 30 02:33:47 2009 -0800) 4 commits
 - fsck: three levels of validation
 - verify-pack: add --quick
 - verify_pack(): allow a quicker verification for a pack with
   version 2 idx
 - pack-check.c: minor formatting fix to match coding style

J6t has a good point that if this had any value then medium level should
replace the default.  I am tempted to actually dropping this as a failed
experiment.

----------------------------------------------------------------
[Reverted]

* mh/unify-color (Fri Jan 23 01:25:23 2009 -0800) 3 commits
 ? Revert previous two commits
 ? move the color variables to color.c
 ? handle color.ui at a central place

This broke git-format-patch badly.

* js/rebase-error-a-bit-more-verbose (Sun Feb 8 21:22:18 2009 -0800) 2 commits
 ? Revert "rebase: explain why when the HEAD could not be detached"
 ? rebase: explain why when the HEAD could not be detached

This turned out to be unnecessary.

* rs/maint-1.6.0-windows-ceiling (Sat Feb 7 12:40:40 2009 -0800) 2 commits
 ? Revert "fix t1504 on Windows"
 ? fix t1504 on Windows

I'm giving a fresh start to J6t's series which contains this.

* lh/reverted-submodule-tree-traversal (Sun Jan 25 18:39:55 2009 -0800) 4 commits
 ? Revert round #1 of the series
 ? builtin-ls-tree: enable traversal of submodules
 ? archive.c: enable traversal of submodules
 ? tree.c: add support for traversal of submodules

I'm giving a fresh start to Lars's second iteration.

----------------------------------------------------------------
[Will merge to 'next' soon]

* js/send-email (Sat Feb 14 23:32:15 2009 -0500) 3 commits
 - send-email: --suppress-cc improvements
 - send-email: handle multiple Cc addresses when reading mbox message
 - send-email: allow send-email to run outside a repo

* sg/rerere-cleanup (Sat Feb 14 23:21:04 2009 +0100) 1 commit
 - rerere: remove duplicated functions

----------------------------------------------------------------
[Ready for 'master' after 1.6.2]

* jw/imap-preformatted-html (Thu Feb 12 08:58:12 2009 -0600) 1 commit
 + imap.preformattedHTML to tell Thunderbird to send non-flowed text

The patch text should be identical to Jeremy's "Virtual Patch", except
that the configuration variable was renamed per list discussion.

* jw/format-patch-attach (Thu Feb 12 09:51:55 2009 -0600) 1 commit
 + Enable setting attach as the default in .gitconfig for git-format-
   patch.

* sr/force-rebase (Fri Feb 13 23:48:01 2009 +0100) 1 commit
 + Teach rebase to rebase even if upstream is up to date

* fg/exclude-bq (Tue Feb 10 15:20:17 2009 +0100) 1 commit
 + Support "\" in non-wildcard exclusion entries

* dm/add-i-edit-abort (Thu Feb 12 00:19:41 2009 -0500) 1 commit
 + add -i: revisit hunk on editor failure

* tp/completion (Wed Feb 11 13:03:26 2009 -0500) 4 commits
 + completion: More fixes to prevent unbound variable errors
 + completion: Better __git_ps1 support when not in working directory
 + completion: Use consistent if [...] convention, not "test"
 + completion: For consistency, change "git rev-parse" to __gitdir
   calls

* js/branch-symref (Fri Feb 13 04:40:18 2009 -0500) 1 commit
 + builtin-branch: improve output when displaying remote branches

* al/ansi-color (Fri Feb 13 22:53:41 2009 +0100) 2 commits
 + builtin-branch.c: Rename branch category color names
 + Clean up use of ANSI color sequences

* kb/checkout-optim (Mon Feb 9 21:54:53 2009 +0100) 9 commits
 + lstat_cache(): print a warning if doing ping-pong between cache
   types
 + show_patch_diff(): remove a call to fstat()
 + write_entry(): use fstat() instead of lstat() when file is open
 + write_entry(): cleanup of some duplicated code
 + create_directories(): remove some memcpy() and strchr() calls
 + unlink_entry(): introduce schedule_dir_for_removal()
 + lstat_cache(): swap func(length, string) into func(string, length)
 + lstat_cache(): generalise longest_match_lstat_cache()
 + lstat_cache(): small cleanup and optimisation

* js/valgrind (Thu Feb 5 22:03:00 2009 +0100) 9 commits
 + valgrind: do not require valgrind 3.4.0 or newer
 + test-lib: avoid assuming that templates/ are in the GIT_EXEC_PATH
 + Tests: let --valgrind imply --verbose and --tee
 + Add a script to coalesce the valgrind outputs
 + t/Makefile: provide a 'valgrind' target
 + test-lib.sh: optionally output to test-results/$TEST.out, too
 + Valgrind support: check for more than just programming errors
 + valgrind: ignore ldso and more libz errors
 + Add valgrind support in test scripts

----------------------------------------------------------------
[Actively cooking]

* js/notes (Sat Feb 14 21:23:25 2009 +0100) 13 commits
 - notes: refuse to edit notes outside refs/notes/
 - t3301: use test_must_fail instead of !
 - t3301: fix confusing quoting in test for valid notes ref
 - notes: use GIT_EDITOR and core.editor over VISUAL/EDITOR
 - notes: only clean up message file when editing
 - handle empty notes gracefully
 + git notes show: test empty notes
 + git-notes: fix printing of multi-line notes
 + notes: fix core.notesRef documentation
 + Add an expensive test for git-notes
 + Speed up git notes lookup
 + Add a script to edit/inspect notes
 + Introduce commit notes

Earlier part was merged to master and then reverted there.  I probably
should rebase this after 1.6.2 to keep my sanity.

* fc/config-editor (Tue Feb 17 02:54:54 2009 +0200) 9 commits
 . config: Cleanup editor action.
 . config: Codestyle cleanups.
 . config: Don't allow extra arguments for -e or -l.
 . config: Disallow multiple config file locations.
 . config: Disallow multiple variable types.
 . config: Use parseopt.
 . config: Reorganize get_color*.
 . config: Trivial rename in preparation for parseopt.
 - config: Add new option to open an editor.

The follow-up series does not pass the test suite, and evicted from 'pu';
the first one might be 'next' worthy, though.

* js/remote-set-head (Sat Feb 14 05:30:30 2009 -0500) 5 commits
 - builtin-remote: better handling of multiple remote HEADs
 - builtin-remote: add set-head subcommand
 - builtin-remote: teach show to display remote HEAD
 - builtin-remote: move duplicated cleanup code its own function
 - builtin-clone: move locate_head() to remote.c so it can be re-used

* jk/head-lookup (Sun Feb 15 01:18:18 2009 -0500) 5 commits
 - remote: use exact HEAD lookup if it is available
 - remote: refactor guess_remote_head
 - refactor find_refs_by_name to accept const list
 - add basic http clone/fetch tests
 - test scripts: refactor start_httpd helper

Builds on top of Jay Soffian's js/remote-set-head topic.  How well do
these two work in practice in the real world?  Success stories?

----------------------------------------------------------------
[On Hold]

* jc/deny-delete-current-1.7.0 (Mon Feb 9 00:19:46 2009 -0800) 1 commit
 - receive-pack: default receive.denyDeleteCurrent to refuse

* jc/refuse-push-to-current-1.7.0 (Wed Feb 11 02:28:03 2009 -0800) 1 commit
 - Refuse updating the current branch in a non-bare repository via
   push

This is for 1.7.0.

* jc/commit-assume-also-during-merge (Thu Jan 22 22:21:49 2009 -0800) 3 commits
 - git commit: pathspec without -i/-o implies -i semantics during a
   merge
 - builtin-commit: shorten eye-sore overlong lines
 - Add "partial commit" tests during a conflicted merge

This was only meant as a weatherballoon to help facilitate discussion.

* jc/merge-convert (Mon Jan 26 16:45:01 2009 -0800) 1 commit
 - git-merge-file: allow converting the results for the work tree

This is a feature waiting for a user.  I do not need it in 1.6.2

We did not give scripted Porcelains a way to say "this temporary file I am
using for merging is for this path, so use the core.autocrlf and attributes
rules for that final path".  Instead, merge-file simply wrote out the
data in the canonical repository representation.

rerere has the same issue, but it is a lot worse.  It reads the three
files (preimage, postimage and thisimage) from the work tree in the work
tree representation, merges them without converting them to the canonical
representation first but inserts the conflict markers with the canonical
representation and writes the resulting mess out.  It needs to be fixed to
read with convert_to_git(), merge them while they are still in the
canonical representation and possibly add conflict markers, and then write
the results out after convert_to_working_tree().  It also needs to write
in binary mode as well.

[Perhaps will discard]

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 . diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 . git-am --forge: add Signed-off-by: line for the author
 . git-am: clean-up Signed-off-by: lines
 . stripspace: add --log-clean option to clean up signed-off-by:
   lines
 . stripspace: use parse_options()
 . Add "git am -s" test
 . git-am: refactor code to add signed-off-by line for the committer

* jc/post-simplify (Fri Aug 15 01:34:51 2008 -0700) 2 commits
 . revision --simplify-merges: incremental simplification
 . revision --simplify-merges: prepare for incremental simplification
