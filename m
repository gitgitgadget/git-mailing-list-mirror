From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2008, #01; Tue, 02)
Date: Tue, 02 Dec 2008 22:59:07 -0800
Message-ID: <7vmyfdhhhg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 08:00:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7liq-0000Zl-Pf
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 08:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbYLCG7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 01:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752616AbYLCG7P
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 01:59:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33172 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbYLCG7O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 01:59:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B79C717FB0;
	Wed,  3 Dec 2008 01:59:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6020917FA3; Wed, 
 3 Dec 2008 01:59:08 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E422CE5A-C107-11DD-BAB7-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102218>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

As we have already passed -rc1, things queued in 'next' let alone 'pu' are
unlikely to be merged to 'master' by the end of year unless otherwise
noted.

----------------------------------------------------------------
[New Topics]

* gb/gitweb-patch (Sat Nov 29 14:41:11 2008 +0100) 2 commits
 - [DONTMERGE: wait for signoff] gitweb: links to patch action in
   commitdiff and shortlog view
 - gitweb: add patch view

* lt/reset-merge (Mon Dec 1 09:30:31 2008 -0800) 1 commit
 + Add 'merge' mode to 'git reset'

Unfortunately, I cannot write down a good use case in what circumstances
this is needed, even though I do recall that I occasionally (perhaps once
every two months) needed to do "read-tree -m -u" myself in the past, and
this patch brings that feature close to Porcelain.  On the other hand, the
existing "reset --mixed" is very easily explained ("after starting to add
changes to the staging area, you realized that you screwed up, and you
want to redo it from scratch").  Therefore, I cannot justify what the log
message of this change claims myself.

* jc/rm-i-t-a (Fri Nov 28 19:56:34 2008 -0800) 5 commits
 + git add --intent-to-add: do not let an empty blob be committed by
   accident
 + git add --intent-to-add: fix removal of cached emptiness
 + builtin-rm.c: explain and clarify the "local change" logic
 + Merge branch 'nd/narrow' (early part) into jc/add-i-t-a
 + Extend index to save more flags

As intent-to-add index entry is a new feature for 1.6.1, it probably is a
good idea to merge this to 'master'.  Nitpicks and bugfixes are very much
appreciated.

* wp/add-patch-find (Thu Nov 27 04:08:03 2008 +0000) 3 commits
 - In add --patch, Handle K,k,J,j slightly more gracefully.
 - Add / command in add --patch
 - git-add -i/-p: Change prompt separater from slash to comma

There are some other useful bits and pieces around this area exchanged on
the list with the author of these patches.  I think it would become a
useful series after reassembling their pieces.  Waiting for v2.

* jn/gitweb-utf8 (Mon Dec 1 19:01:42 2008 +0100) 1 commit
 - gitweb: Fix handling of non-ASCII characters in inserted HTML
   files.

Possibly a bugfix worthy to have in 1.6.1.

* jc/clone-symref-2 (Sat Nov 29 23:38:21 2008 -0800) 7 commits
 - clone: test the new HEAD detection logic
 - Merge commit 'HEAD@{2}' into HEAD
 - upload-pack: send the HEAD information
 - clone: find the current branch more explicitly
 - connect.c::read_extra_info(): find where HEAD points at
 - connect.c::read_extra_info(): prepare to receive more than server
   capabilities
 - get_remote_heads(): refactor code to read "server capabilities"

This is no way meant for 1.6.1, let alone next, yet.

----------------------------------------------------------------
[Graduated to "master"]

* cr/remote-update-v (Tue Nov 18 19:04:02 2008 +0800) 1 commit
 + git-remote: add verbose mode to git remote update

* rs/strbuf-expand (Sun Nov 23 00:16:59 2008 +0100) 6 commits
 + remove the unused files interpolate.c and interpolate.h
 + daemon: deglobalize variable 'directory'
 + daemon: inline fill_in_extra_table_entries()
 + daemon: use strbuf_expand() instead of interpolate()
 + merge-recursive: use strbuf_expand() instead of interpolate()
 + add strbuf_expand_dict_cb(), a helper for simple cases

* mv/fast-export (Sun Nov 23 12:55:54 2008 +0100) 2 commits
 + fast-export: use an unsorted string list for extra_refs
 + Add new testcase to show fast-export does not always exports all
   tags

* st/levenshtein (Thu Nov 20 14:27:27 2008 +0100) 2 commits
 + Document levenshtein.c
 + Fix deletion of last character in levenshtein distance

* js/mingw-rename-fix (Wed Nov 19 17:25:27 2008 +0100) 1 commit
 + compat/mingw.c: Teach mingw_rename() to replace read-only files

* mv/clone-strbuf (Fri Nov 21 01:45:01 2008 +0100) 3 commits
 + builtin_clone: use strbuf in cmd_clone()
 + builtin-clone: use strbuf in clone_local() and
   copy_or_link_directory()
 + builtin-clone: use strbuf in guess_dir_name()

* pw/maint-p4 (Wed Nov 26 13:52:15 2008 -0500) 1 commit
 - git-p4: fix keyword-expansion regex

* cc/bisect-skip (Sun Nov 23 22:02:49 2008 +0100) 1 commit
 - bisect: teach "skip" to accept special arguments like "A..B"

Should be in 1.6.1-rc1.

* lt/preload-lstat (Mon Nov 17 09:01:20 2008 -0800) 2 commits
 + Fix index preloading for racy dirty case
 + Add cache preload facility

* ta/quiet-pull (Mon Nov 17 23:09:30 2008 +0100) 2 commits
 + Retain multiple -q/-v occurrences in git pull
 + Teach/Fix pull/fetch -q/-v options

* ph/send-email (Tue Nov 11 00:54:02 2008 +0100) 4 commits
 + git send-email: ask less questions when --compose is used.
 + git send-email: add --annotate option
 + git send-email: interpret unknown files as revision lists
 + git send-email: make the message file name more specific.

After merging these to 'master' I found a breakage which I hopefully
fixed.

----------------------------------------------------------------
[Will merge to "master" soon]

What are you looking for?  We are in -rc ;-)

----------------------------------------------------------------
[On Hold]

* cb/mergetool (Thu Nov 13 12:41:15 2008 +0000) 3 commits
 - [DONTMERGE] Add -k/--keep-going option to mergetool
 - Add -y/--no-prompt option to mergetool
 - Fix some tab/space inconsistencies in git-mergetool.sh

Jeff had good comments on the last one; the discussion needs concluded,
and also waiting for comments from the original author (Ted).

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 + blame: show "previous" information in --porcelain/--incremental
   format
 + git-blame: refactor code to emit "porcelain format" output

* ds/uintmax-config (Mon Nov 3 09:14:28 2008 -0900) 1 commit
 - autoconf: Enable threaded delta search when pthreads are supported

Rebased to 'master', that introduced NO_PTHREADS.

* cc/bisect-replace (Mon Nov 24 22:20:30 2008 +0100) 9 commits
 - bisect: add "--no-replace" option to bisect without using replace
   refs
 - rev-list: make it possible to disable replacing using "--no-
   bisect-replace"
 - bisect: use "--bisect-replace" options when checking merge bases
 - merge-base: add "--bisect-replace" option to use fixed up revs
 - commit: add "bisect_replace_all" prototype to "commit.h"
 - rev-list: add "--bisect-replace" to list revisions with fixed up
   history
 - Documentation: add "git bisect replace" documentation
 - bisect: add test cases for "git bisect replace"
 - bisect: add "git bisect replace" subcommand

I really hate the idea of introducing a potentially much more useful
replacement of the existing graft mechanism and tie it very tightly to
bisect, making it unusable from outside.

 (1) I do not think "bisect replace" workflow is a practical and usable
     one;

 (2) The underlying mechanism to express "this object replaces that other
     object" is much easier to work with than what the graft does which is
     "the parents of this commit are these", and idea to use the normal
     ref to point at them means this can potentially be used for
     transferring the graft information across repositories, which the
     current graft mechanism cannot do.

 (3) Because I like the aspect (2) of this series so much, it deeply
     disappoints and troubles me that this is implemented minimally near
     the surface, and that it is controlled by the "bisect" Porcelain
     alone, by explicitly passing command line arguments.

I think a mechanism like this should be added to replace grafts, but it
should always be enabled for normal revision traversal operation, while
always disabled for object enumeration and transfer operation (iow, fsck,
fetch and push should use the real ancestry information recorded in the
underlying objects, while rev-list, log, etc. should always use the
replaced objects).  I have a suspicion that even cat-file could honor it.

* nd/narrow (Sun Nov 30 17:54:38 2008 +0700) 18 commits
 - wt-status: show sparse checkout info
 - Introduce default sparse patterns (core.defaultsparse)
 - checkout: add new options to support sparse checkout
 - clone: support sparse checkout with --sparse-checkout option
 - unpack_trees(): add support for sparse checkout
 - unpack_trees(): keep track of unmerged entries
 - Introduce "sparse patterns"
 - Merge branch 'master' into nd/narrow
 + t2104: touch portability fix
 + grep: skip files outside sparse checkout area
 + checkout_entry(): CE_NO_CHECKOUT on checked out entries.
 + Prevent diff machinery from examining worktree outside sparse
   checkout
 + ls-files: Add tests for --sparse and friends
 + update-index: add --checkout/--no-checkout to update
   CE_NO_CHECKOUT bit
 + update-index: refactor mark_valid() in preparation for new options
 + ls-files: add options to support sparse checkout
 + Introduce CE_NO_CHECKOUT bit
 + Extend index to save more flags

Kicked back to 'on hold' until 1.6.1 final by popular(?) demand.

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 - "git push": tellme-more protocol extension

This seems to have a deadlock during communication between the peers.
Someone needs to pick up this topic and resolve the deadlock before it can
continue.

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use,
but gitk will be hit due to tcl/tk's limitation, so I am holding
this back for now.

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 - git-am --forge: add Signed-off-by: line for the author
 - git-am: clean-up Signed-off-by: lines
 - stripspace: add --log-clean option to clean up signed-off-by:
   lines
 - stripspace: use parse_options()
 - Add "git am -s" test
 - git-am: refactor code to add signed-off-by line for the committer
