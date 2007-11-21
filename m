From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Wed, 21 Nov 2007 01:23:31 -0800
Message-ID: <7vsl30eyuk.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
	<7vir4d40sw.fsf@gitster.siamese.dyndns.org>
	<7vwsso3poo.fsf@gitster.siamese.dyndns.org>
	<7vfxz89x9q.fsf@gitster.siamese.dyndns.org>
	<7vabpctx3b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 10:24:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuloi-00021s-29
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 10:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759061AbXKUJXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 04:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbXKUJXo
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 04:23:44 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:37601 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756286AbXKUJXg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 04:23:36 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 587F62F0;
	Wed, 21 Nov 2007 04:23:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 94B5C9714A;
	Wed, 21 Nov 2007 04:23:54 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65624>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

Just in case anybody is wondering, this message is updated with
the help with a new script UWC in 'todo' branch these days (I
have 'todo' checked out in Meta/ directory, so the script is
called Meta/UWC and uses Meta/git-topic.perl script etc.)

----------------------------------------------------------------
[Will cook further in 'next' and then merge to 'master' soon]

* jc/move-gitk (Sat Nov 17 10:51:16 2007 -0800) 1 commit
 + Move gitk to its own subdirectory

I have a phoney Makefile under the subdirectory for gitk, but
hopefully with the next pull from Paulus I can replace it with
the real thing, along with the i18n stuff.

* cc/bisect (Tue Nov 20 06:39:53 2007 +0100) 7 commits
 + Bisect reset: do nothing when not bisecting.
 + Bisect: use "$GIT_DIR/BISECT_NAMES" to check if we are bisecting.
 + Bisect visualize: use "for-each-ref" to list all good refs.
 + git-bisect: modernize branch shuffling hack
 + git-bisect: use update-ref to mark good/bad commits
 + git-bisect: war on "sed"
 + Bisect reset: remove bisect refs that may have been packed.

Will merge by the weekend (if I can find time, that is).

* mh/rebase-skip-hard (Thu Nov 8 08:03:06 2007 +0100) 1 commit
 + Do git reset --hard HEAD when using git rebase --skip

After seeing a conflicted rebase, you may decide to skip that
patch but then you would need "git reset --hard" before saying
"git rebase --skip".  This teaches "git rebase --skip" to
automatically discard the conflicted rebase for you.

Will merge by the weekend.

* tt/help (Sun Nov 11 19:57:57 2007 -0500) 2 commits
 + Remove hint to use "git help -a"
 + Make the list of common commands more exclusive

Some people on the list may find the exact list of commands
somewhat debatable.  We can fine-tune that in-tree ('pu' does
not count as "in-tree").

* js/mingw-fallouts (Sat Nov 17 23:09:28 2007 +0100) 13 commits
 + fetch-pack: Prepare for a side-band demultiplexer in a thread.
 + rehabilitate some t5302 tests on 32-bit off_t machines
 + Allow ETC_GITCONFIG to be a relative path.
 + Introduce git_etc_gitconfig() that encapsulates access of
   ETC_GITCONFIG.
 + Allow a relative builtin template directory.
 + Close files opened by lock_file() before unlinking.
 + builtin run_command: do not exit with -1.
 + Move #include <sys/select.h> and <sys/ioctl.h> to git-compat-
   util.h.
 + Use is_absolute_path() in sha1_file.c.
 + Skip t3902-quoted.sh if the file system does not support funny
   names.
 + t5302-pack-index: Skip tests of 64-bit offsets if necessary.
 + t7501-commit.sh: Not all seds understand option -i
 + t5300-pack-object.sh: Split the big verify-pack test into smaller
   parts.

A set of good general clean-up patches.

----------------------------------------------------------------
[Actively cooking]

* jk/send-pack (Tue Nov 20 06:18:01 2007 -0500) 29 commits
 - send-pack: cluster ref status reporting
 + send-pack: fix "everything up-to-date" message
 + send-pack: tighten remote error reporting
 + make "find_ref_by_name" a public function
 + Fix warning about bitfield in struct ref
 + send-pack: assign remote errors to each ref
 + send-pack: check ref->status before updating tracking refs
 + send-pack: track errors for each ref
 + Merge branch 'aw/mirror-push' into jk/send-pack
 + Merge branch 'ar/send-pack-remote-track' into jk/send-pack
 + Merge branch 'db/remote-builtin' into jk/send-pack
 + git-push: add documentation for the newly added --mirror mode
 + Add tests for git push'es mirror mode
 + Update the tracking references only if they were succesfully
   updated on remote
 + Add a test checking if send-pack updated local tracking branches
   correctly
 + git-push: plumb in --mirror mode
 + Teach send-pack a mirror mode
 + Merge master into aw/mirror-push
 + Merge branch 'jk/terse-push' into aw/mirror-push
 + send-pack: segfault fix on forced push
 + Reteach builtin-ls-remote to understand remotes
 + send-pack: require --verbose to show update of tracking refs
 + receive-pack: don't mention successful updates
 + more terse push output
 + Build in ls-remote
 + Build-in send-pack, with an API for other programs to call.
 + Use built-in send-pack.
 + Build-in peek-remote, using transport infrastructure.
 + Miscellaneous const changes and utilities

Various improvements on status reporting and error handling by
send-pack, and implementation of "mirror" pushing.

* sb/clean (Wed Nov 14 23:00:54 2007 -0600) 3 commits
 + Teach git clean to use setup_standard_excludes()
 + git-clean: Fix error message if clean.requireForce is not set.
 + Make git-clean a builtin

It has a subtle change in behaviour but it does not quite
qualify as a regression.  Will merge to "next" shortly.  We can
fix the corner case semantics in-tree.  I also adjusted the
error message to match the fix from Hannes on 'master'.

* js/reflog-delete (Wed Oct 17 02:50:45 2007 +0100) 1 commit
 + Teach "git reflog" a subcommand to delete single entries

----------------------------------------------------------------
[Approaching 'next']

* kh/commit (Sun Nov 18 01:52:55 2007 -0800) 21 commits
 - builtin-commit: fix partial-commit support
 - Fix add_files_to_cache() to take pathspec, not user specified list
   of files
 - Export three helper functions from ls-files
 - builtin-commit: run commit-msg hook with correct message file
 - builtin-commit: do not color status output shown in the message
   template
 - file_exists(): dangling symlinks do exist
 - Replace "runstatus" with "status" in the tests
 - t7501-commit: Add test for git commit <file> with dirty index.
 - builtin-commit: Clean up an unused variable and a debug fprintf().
 - Call refresh_cache() when updating the user index for --only
   commits.
 - builtin-commit: Add newline when showing which commit was created
 - builtin-commit: resurrect behavior for multiple -m options
 - builtin-commit --s: add a newline if the last line was not a S-o-b
 - builtin-commit: fix --signoff
 - git status: show relative paths when run in a subdirectory
 - builtin-commit: Refresh cache after adding files.
 - builtin-commit: fix reflog message generation
 - launch_editor(): read the file, even when EDITOR=:
 - Port git commit to C.
 - Export launch_editor() and make it accept ':' as a no-op editor.
 - Add testcase for amending and fixing author in git commit.

There are still a few regressions that keep this series out of
'next', including the lossage of "-v" (final diff review).

By the way, I am meaning to squash the part that introduces and
then fixes builtin-commit.c into a smaller number of commits for
future readability and bisectability (currently the series is
not bisectable).

----------------------------------------------------------------
[Stalled]

* sp/refspec-match (Sun Nov 18 17:13:08 2007 +0100) 6 commits
 - push: Add '--current', which pushes only the current branch
 - push: Add '--matching' option and print warning if it should be
   used
 - refactor fetch's ref matching to use refname_match()
 - push: use same rules as git-rev-parse to resolve refspecs
 - add refname_match()
 - push: support pushing HEAD to real branch name

("Stalled" is my fault, not the author's) This changes the
semantics slightly but I think it is a move in the right
direction.  Perhaps merge the early parts to 'next'; I am not
entirely happy with the updated --current patch which does not
appear in this queue.

* jc/spht (Fri Nov 2 17:46:55 2007 -0700) 3 commits
 + core.whitespace: add test for diff whitespace error highlighting
 + git-diff: complain about >=8 consecutive spaces in initial indent
 + War on whitespace: first, a bit of retreat.

Teaching "git apply --whitespace=[warn|strip]" to honor the same
configuration would be a good addition, but this could go to
'master' as is.

* cr/tag-options (Fri Nov 9 14:42:56 2007 +0100) 1 commit
 - Make builtin-tag.c use parse_options.

This changes the handling of multiple -m options without much
good reason.  It should be a simple fix, once we know what we
want.  I think the existing behaviour of refusing multiple -m
is probably the most sane at this point.

* dz/color-addi (Sat Nov 10 18:03:44 2007 -0600) 3 commits
 - Added diff hunk coloring to git-add--interactive
 - Let git-add--interactive read colors from .gitconfig
 - Added basic color support to git add --interactive

This series has improved quite a bit since the last round, but
another round was requested from the list.  Waiting for
refinements.

* nd/maint-work-tree-fix (Sat Nov 3 20:18:06 2007 +0700) 1 commit
 + Add missing inside_work_tree setting in setup_git_directory_gently

There was an additional patch, which still had issues Dscho
pointed out.  Waiting for refinements.

* ss/dirty-rebase (Thu Nov 1 22:30:24 2007 +0100) 3 commits
 - Make git-svn rebase --dirty pass along --dirty to git-rebase.
 - Implement --dirty for git-rebase--interactive.
 - Introduce --dirty option to git-rebase, allowing you to start from
   a dirty state.

This seems to be optimized for the --dirty case too much.  I'd
prefer an implementation that make rebases without --dirty to
pay no penalty (if that is possible, otherwise "as little as
possible").

----------------------------------------------------------------
[Others]

* jc/branch-contains (Sun Nov 18 22:22:00 2007 -0800) 3 commits
 - git-branch --contains: doc and test
 - git-branch --contains=commit
 - parse-options: Allow to hide options from the default usage.

Contains Pierre's "hidable options with --help-all" patch.  I
think this is ready to be in 'next'.

* jc/maint-format-patch-encoding (Fri Nov 2 17:55:31 2007 -0700) 2 commits
 - test format-patch -s: make sure MIME content type is shown as
   needed
 - format-patch -s: add MIME encoding header if signer's name
   requires so

This is to apply to 'maint' later; the equivalent fix is already
in 'master'.

* lt/maint-rev-list-gitlink (Sun Nov 11 23:35:23 2007 +0000) 1 commit
 - Fix rev-list when showing objects involving submodules

This is to apply to 'maint' later; the equivalent fix is already
in 'next' and will be merged to 'master' soon.

* jc/pathspec (Thu Sep 13 13:38:19 2007 -0700) 3 commits
 - pathspec_can_match(): move it from builtin-ls-tree.c to tree.c
 - ls-tree.c: refactor show_recursive() and rename it.
 - tree-diff.c: split out a function to match a single pattern.

* jk/rename (Tue Oct 30 00:24:42 2007 -0400) 3 commits
 - handle renames using similarity engine
 - introduce generic similarity library
 - change hash table calling conventions

* jc/cherry-pick (Tue Nov 13 12:38:51 2007 -0800) 1 commit
 - revert/cherry-pick: start refactoring call to merge_recursive

* jc/nu (Sun Oct 14 22:07:34 2007 -0700) 3 commits
 - merge-nu: a new merge backend without using unpack_trees()
 - read_tree: take an explicit index structure
 - gcc 4.2.1 -Werror -Wall -ansi -pedantic -std=c99: minimum fix

The second one could probably be used to replace the use of
path-list in the tip commit on the kh/commit series.
