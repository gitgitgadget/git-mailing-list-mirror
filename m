From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Sun, 03 Feb 2008 02:59:13 -0800
Message-ID: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 12:00:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLca0-0005o1-8l
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 12:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873AbYBCK71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 05:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754751AbYBCK71
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 05:59:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44407 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbYBCK7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 05:59:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D91505F8B;
	Sun,  3 Feb 2008 05:59:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C5A525F8A;
	Sun,  3 Feb 2008 05:59:20 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72351>

Here are the topics that have been kept out of 'master'.
Commits prefixed with '-' are only in 'pu' while commits
prefixed with '+' are in 'next'.

The topics list the commits in reverse chronological order.

I'd like to get post-release fixes to 'maint' first, tag 1.5.4.1
and merge that to 'master', and then start merging things from
'next' to 'master'.

My wish is to have small but short release cycle for 1.5.5 and
leave bigger ones cooking for 1.6.0.

----------------------------------------------------------------
[Requests for Comments]

* db/send-email-omit-cc (Tue Dec 25 19:56:29 2007 -0800) 1 commit
 - git-send-email: Generalize auto-cc recipient mechanism.

This came after 1.5.4-rc cycle started and was placed on hold.
I do not recall if there was any objection to it.

* jc/gitignore-ends-with-slash (Thu Jan 31 20:23:25 2008 -0800) 2 commits
 - gitignore: lazily find dtype
 - gitignore(5): Allow "foo/" in ignore list to match directory "foo"

This is redone after we had discussion on the list to properly
make "foo/" match only with directories and "foo" with both
files and directories without unnecessary lstat(2) calls.

* jc/apply-whitespace (Tue Jan 15 00:59:05 2008 -0800) 13 commits
 - core.whitespace: cr-at-eol
 - git-apply --whitespace=fix: fix whitespace fuzz introduced by
   previous run
 - builtin-apply.c: pass ws_rule down to match_fragment()
 - builtin-apply.c: move copy_wsfix() function a bit higher.
 - builtin-apply.c: do not feed copy_wsfix() leading '+'
 - builtin-apply.c: simplify calling site to apply_line()
 - builtin-apply.c: clean-up apply_one_fragment()
 - builtin-apply.c: mark common context lines in lineinfo structure.
 - builtin-apply.c: optimize match_beginning/end processing a bit.
 - builtin-apply.c: make it more line oriented
 - builtin-apply.c: push match-beginning/end logic down
 - builtin-apply.c: restructure "offset" matching
 - builtin-apply.c: refactor small part that matches context

* jc/sha1-lookup (Sun Dec 30 03:13:27 2007 -0800) 2 commits
 - sha1-lookup: make selection of 'middle' less aggressive
 - sha1-lookup: more memory efficient search in sorted list of SHA-1

Micro-optimization whose real world benefit is not proven.

* jc/rename (Tue Jan 29 20:54:56 2008 -0800) 1 commit
 - Optimize rename detection for a huge diff

Micro-optimization whose real world benefit is not proven.

----------------------------------------------------------------
[Will merge to 'master' after 1.5.4.1]

* ph/describe-match (Mon Dec 24 12:18:22 2007 +0100) 2 commits
 + git-name-rev: add a --(no-)undefined option.
 + git-describe: Add a --match option to limit considered tags.

* lt/in-core-index (Tue Jan 22 23:01:13 2008 -0800) 9 commits
 + lazy index hashing
 + Create pathname-based hash-table lookup into index
 + read-cache.c: introduce is_racy_timestamp() helper
 + read-cache.c: fix a couple more CE_REMOVE conversion
 + Also use unpack_trees() in do_diff_cache()
 + Make run_diff_index() use unpack_trees(), not read_tree()
 + Avoid running lstat(2) on the same cache entry.
 + index: be careful when handling long names
 + Make on-disk index representation separate from in-core one

This is about reducing number of lstat(2) calls during complex
operations, and optimizing "do we have this in the index"
queries.  Most likely this will be the first series to be merged
to 'master'.

----------------------------------------------------------------
[Actively cooking]

* jk/builtin-alias (Sun Feb 3 01:48:29 2008 -0800) 2 commits
 - Revert "Support builtin aliases"
 + Support builtin aliases

Will revert from 'next', as mentioned in the previous issue of this
message.

----------------------------------------------------------------
[Questionable]

* jc/setup (Fri Feb 1 03:13:10 2008 -0800) 3 commits
 - git-add: adjust to the get_pathspec() changes.
 - Make blame accept absolute paths
 - setup: sanitize absolute and funny paths in get_pathspec()

I suspect this would need to be rethought so that it will return
the same number of paths and make the caller choose what to do
with paths outside the repository.  This is very unfortunate.

Ideally, all of git commands that use get_pathspec() should work
on paths inside work tree and barf on paths outside work tree,
and in that sense the series as I did was fine.  But we have
bolted-on-hack commands that want to see and act on paths that
are outside of the work tree; filtering the paths outside the
work tree in get_pathspec() would break them.

If we redo this series that way, git-ls-files (especially with
its --error-unmatch), git-clean, and git-add should detect the
paths outside the work tree themselves and complain, without
relying on get_pathspec() to do the barfing for them.

* ab/pserver (Fri Dec 14 04:08:51 2007 +0000) 1 commit
 - Authentication support for pserver

This needs careful security audit and a fix to its password
database format.  Plaintext in .git/config is not acceptable.

----------------------------------------------------------------
[On hold]

* js/remote (Wed Dec 5 19:02:15 2007 +0000) 4 commits
 - Make git-remote a builtin
 - Test "git remote show" and "git remote prune"
 - parseopt: add flag to stop on first non option
 - path-list: add functions to work with unsorted lists

I might have carefully looked at this in the past but I do not
recall if there were issues.  Need re-reviewing and help from
the list is appreciated.

* bf/remote-head (Sun Dec 23 20:52:32 2007 -0500) 1 commit
 - git-remote: make add -f guess HEAD, as clone does

Likewise.

* js/reflog-delete (Fri Jan 4 19:11:37 2008 -0600) 2 commits
 + builtin-reflog.c: fix typo that accesses an unset variable
 + Teach "git reflog" a subcommand to delete single entries

There was a patch that uses this to implement "git-stash drop",
which I didn't queue, as the command name and the UI was
undecided yet.  Please resubmit for discussion and application.
Whatever the name and UI is, selective removal of stash is a
nice thing to have for 1.5.5.

* nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
 - Move all dashed-form commands to libexecdir

Scheduled for 1.6.0.  I am not sure if we should merge this to
'next' before 1.5.5.  Most active people will be on 'next' and
if we have this there, the resulting 1.5.5 release might end up
having issues that come from differences this one introduces.

* jc/cherry-pick (Mon Dec 24 00:51:01 2007 -0800) 4 commits
 - PARK: Start using replay-tree merge in cherry-pick
 - revert/cherry-pick: start refactoring call to merge_recursive
 - expose a helper function peel_to_type().
 - merge-recursive: split low-level merge functions out.

Meant to avoid merge_recursive() during cherry-pick and revert,
so that D/F conflicts can be redone right, but I got busy and
this has unfortunately stalled.

* jc/dashless (Sat Dec 1 22:09:22 2007 -0800) 2 commits
 - Prepare execv_git_cmd() for removal of builtins from the
   filesystem
 - git-shell: accept "git foo" form

We do not plan to remove git-foo form completely from the filesystem at
this point, but git-shell may need to be updated.

* jc/diff-relative (Thu Dec 6 09:48:32 2007 -0800) 1 commit
 - Make "diff" Porcelain output paths as relative to subdirectory.

* jc/git-symref (Tue Dec 11 16:42:46 2007 -0800) 1 commit
 - PARK: show-symref protocol extension.


----------------------------------------------------------------

Issues that I have looked at, but unprocessed, unconcluded
and/or lack enough discussions to proceed.

* "git-apply --whitespace=fix" context adjustment
  $gmane/72248

* pretty.c optimization (Marco)
  $gmane/72260

* zlib abstraction (Marco)
  $gmane/72262

* revision.c::limit_list() breakage (Jeff King)
  $gmane/72324
  t/t6009

* synopsys: use {} instead of () for grouping alternatives (Jari Aalto)
  $gmane/72243

* A symref file for ".git/" (Lars Hjemli)
  $gmane/72244

* safecrlf (Steffen Prohaska)
  $gmane/72285

* git-send-email unechoed interactive password (Michael Witten)
  $gmane/72220

* compat/qsort (Brian Downing)
  $gmane/72311

* unified "user's choice brower" (Christian Couder)
  $gmane/72226

* "[alias] st = status" and "cd .git && git st" (Jeff King)
  $gmane/72327
