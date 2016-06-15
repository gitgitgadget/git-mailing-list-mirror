From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: What's cooking in git/spearce.git (Oct 2008, #01; Mon, 06)
Date: Mon, 6 Oct 2008 09:59:43 -0700
Message-ID: <20081006165943.GG8203@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 06 19:07:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmtSK-0005CL-9I
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 19:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbYJFQ7p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Oct 2008 12:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753505AbYJFQ7p
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 12:59:45 -0400
Received: from george.spearce.org ([209.20.77.23]:54475 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbYJFQ7o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 12:59:44 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9FA4A3835F; Mon,  6 Oct 2008 16:59:43 +0000 (UTC)
Content-Disposition: inline
X-master-at: 276328ffb87cefdc515bee5f09916aea6e0244ed
X-next-at: 395ff9bd88b9cf14617c5e2f461878c4969726f3
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97603>

What's cooking in git/spearce.git (Oct 2008, #01; Mon, 06)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their nam=
es.

Topics aren't sorted by name; I have tried to cluster them together
to tell the story of how 'next' and 'pu' have evolved this past week.

----------------------------------------------------------------
[New Topics]

* sp/describe-docs (Tue Sep 30 11:55:16 2008 -0700) 1 commit
 . docs: Improve the description of describe --tags

I'm probably going to drop this topic if I can ever get around to
formally writing and posting sp/describe-lwtag for review.

* sp/describe-lwtag (Tue Sep 30 12:03:41 2008 -0700) 1 commit
 - [WIP] Change meaning of --tags and --all

Modifies "git describe --tags" to allow matching against lightweight
tags even when an annotated tag is found in the history.  Its not
in next because I haven't formally written a commit message and
posted the patch for discussion on the list.

This is a fairly significant change in behavior.  Its most certainly
1.6.1 material, but many argue the change is the _correct_ behavior
and the current behavior in 1.6.0 is buggy.

* jk/diff-convfilter (Sun Oct 5 17:43:45 2008 -0400) 4 commits
 - diff: add filter for converting binary to text
 - diff: introduce diff.<driver>.binary
 - diff: unify external diff and funcname parsing code
 - t4012: use test_cmp instead of cmp

A general cleanup on how diff drivers are implemented.  Its still
missing documentation updates and tests but doesn't break anything
current as far as I can tell.  It needs more review before it can
be slated for 'next'.

* pb/rename-rowin32 (Fri Oct 3 12:20:43 2008 +0200) 1 commit
 - Do not rename read-only files during a push

Supposedly fixes pack file renames on Windows, but it makes the
test suite fail on Linux.  I haven't debugged why yet.  Its very
likely we need a replacement patch before this can move forward.

* gb/formatpatch-autonbr (Thu Oct 2 16:55:39 2008 -0400) 1 commit
 - format-patch: autonumber by default

=46ails the test suite; some of the test vectors need to be updated
to account for the new default.  Someone who cares about this
change should follow through on the test suite update, or this may
get dropped.

* sh/maint-intrebase (Wed Oct 1 01:11:07 2008 -0500) 1 commit
 + Fix interactive rebase on dropped commits.

This merged to next, then was reverted out this morning, due to
the introduction of the sh/maint-rebase3.  Its dead and will be
dropped from the next "What's cooking" release notes.

* sh/maint-rebase3 (Sun Oct 5 23:26:52 2008 -0500) 1 commit
 - rebase--interactive: fix parent rewriting for dropped commits

A replacement for sh/maint-intrebase.  Its in pu because I have
gotten 3 different versions of this patch, two of them posted a
full 4 days after I merged the first version into next.  I felt
burned by the patch author for not keeping up with my tree, so I'm
not merging the patch to next.

At this point its going to sit in pu until Junio comes back.
I think the topic needs a few more days to settle to see if the
patch author is going to submit any more revisions.

* ns/rebase-noverify (Mon Oct 6 14:14:29 2008 +0900) 1 commit
 + rebase --no-verify

This adds --no-verify to git rebase, to avoid the pre-rebase hook.
Lacks documentation but otherwise looks sound.

* mv/merge-noff (Fri Oct 3 14:04:47 2008 +0200) 1 commit
 + builtin-commit: use reduce_heads() only when appropriate

=46ixes "git merge --no-ff --no-commit".

* dp/cywginstat (Tue Sep 30 17:53:47 2008 +0400) 3 commits
 + cygwin: Use native Win32 API for stat
 + mingw: move common functionality to win32.h
 + add have_git_dir() function

Performance improvement for Cygwin, bypassing the Cygwin stat
function and using one more like MinGW uses.  Probably ready for
master on the next round.  Several Cygwin users have given praise
to the series.

* js/objc-funchdr (Wed Oct 1 00:46:34 2008 +0100) 1 commit
 + Teach git diff about Objective-C syntax

Adds support for Objective-C function headers.  I don't use
Objective-C so I can't comment on how good/bad the patterns are
for the language.  Feedback (and improvements if necessary) from
Objective-C users would be appreciated.

* dm/svn-branch (Sat Oct 4 19:35:17 2008 -0700) 1 commit
 + Add git-svn branch to allow branch creation in SVN repositories

Adds "git svn branch" to build branches remotely in SVN.

Might be ready for master, it has an ACK from Eric.  Slated into next
just because I wasn't sure if Junio merges such things immediately
into master or lets them cook for a bit.

* pb/gitweb (Fri Oct 3 07:41:25 2008 -0700) 7 commits
 + Merge branch 'pb/gitweb-tagcloud' into pb/gitweb
 + gitweb: Support for simple project search form
 + gitweb: Make the by_tag filter delve in forks as well
 + gitweb: Support for tag clouds
 + gitweb: Add support for extending the action bar with custom links
 + gitweb: Sort the list of forks on the summary page by age
 + gitweb: Clean-up sorting of project list

I may have been a bad interm maintainer here by shoving together
two different gitweb series from Pasky.  Overall the combined set
looks ready to me.

* ph/parseopt (Thu Oct 2 14:59:20 2008 +0200) 3 commits
 + parse-opt: migrate builtin-merge-file.
 + parse-opt: migrate git-merge-base.
 + parse-opt: migrate fmt-merge-msg.

* rz/grepz (Wed Oct 1 18:11:15 2008 +0200) 1 commit
 + git grep: Add "-z/--null" option as in GNU's grep.

* mv/merge-refresh (Fri Oct 3 15:02:31 2008 +0200) 1 commit
 + builtin-merge: refresh the index before calling a strategy

* bc/xdiffnl (Wed Oct 1 14:28:26 2008 -0500) 1 commit
 + xdiff-interface.c: strip newline (and cr) from line before pattern
   matching

* ae/preservemerge (Mon Sep 29 22:28:57 2008 +0200) 1 commit
 + rebase: Support preserving merges in non-interactive mode

These last five all look ready for master, but should cook longer
than just a few days.

----------------------------------------------------------------
[Old New Topics]

* mw/sendemail (Sun Sep 28 07:51:21 2008 +0300) 10 commits
 + bash completion: Add --[no-]validate to "git send-email"
 + send-email: signedoffcc -> signedoffbycc, but handle both
 + Docs: send-email: Create logical groupings for man text
 + Docs: send-email: Create logical groupings for --help text
 + Docs: send-email: Remove unnecessary config variable description
 + Docs: send-email: --chain_reply_to -> --[no-]chain-reply-to
 + send-email: change --no-validate to boolean --[no-]validate
 + Docs: send-email: Man page option ordering
 + Docs: send-email usage text much sexier
 + Docs: send-email's usage text and man page mention same options

This series looks pretty good to me.  It probably can merge to
master on the next "What's cooking" cycle.

----------------------------------------------------------------
[Dropped Topics]

* sg/merge-options (Sun Apr 6 03:23:47 2008 +0200) 1 commit
 + merge: remove deprecated summary and diffstat options and config
   variables

This has been reverted from next and is being dropped.  Its too
soon to remove a feature that was just added in 1.5.6 timeframe.
Perhaps in 1.7.0 this can be revisited.

----------------------------------------------------------------
[Stuck Topics]

* nd/narrow (Wed Oct 1 11:04:09 2008 +0700) 9 commits
 - grep: skip files outside sparse checkout area
 - checkout_entry(): CE_NO_CHECKOUT on checked out entries.
 - Prevent diff machinery from examining worktree outside sparse
   checkout
 - ls-files: Add tests for --sparse and friends
 - update-index: add --checkout/--no-checkout to update
   CE_NO_CHECKOUT bit
 - update-index: refactor mark_valid() in preparation for new options
 - ls-files: add options to support sparse checkout
 - Introduce CE_NO_CHECKOUT bit
 - Extend index to save more flags

Recently updated with a repost.  I've been too swamped at day-job
to actively review the series.  There has been some discussion on
list about it so its not stalled, but it needs more eyeballs.

* gb/gitweb-pathinfo (Thu Oct 2 02:10:34 2008 +0200) 6 commits
 - gitweb: generate parent..current URLs
 - gitweb: parse parent..current syntax from pathinfo
 - gitweb: use_pathinfo filenames start with /
 - gitweb: generate project/action/hash URLs
 - gitweb: refactor input parameters parse/validation
 - gitweb: parse project/action/hash_base:filename PATH_INFO

Still going through revisions on the git ML.  Its great work and
is heading in the right direction.  But the discussion and patch
generation rate is too high to merge the topic into next just yet.

So its waiting for a re-roll of the series once discussion settles
down and there is a final patch series available.

----------------------------------------------------------------
[Stalled -- Needs Action to Proceed (or to be dropped)]

* pb/submodule (Fri Sep 12 23:09:19 2008 +0200) 1 commit
 - t7400: Add short "git submodule add" testsuite

Still waiting for a reroll.  Should be dropped next week if we
don't get one during this coming week.

* bd/blame (Thu Aug 21 18:22:01 2008 -0500) 5 commits
 - Use xdiff caching to improve git blame performance
 - Allow xdiff machinery to cache hash results for a file
 - Always initialize xpparam_t to 0
 - Bypass textual patch generation and parsing in git blame
 - Allow alternate "low-level" emit function from xdl_diff

(jc: R=C3=A9ne had good comments on how the callback should be
 structured.)

* kb/am-directory (Fri Aug 29 15:27:50 2008 -0700) 1 commit
 - git-am: Pass the --directory option through to git-apply

(jc: I think this is still buggy and drops the option when am stops
 with conflicts.)

All three of these are stalled.  I'm not going to drop them just
yet, but Junio's comments still hold.  If there's no action on
these next week we may seem them drop off.

----------------------------------------------------------------
[Will be merged to 'master/maint' soon]

* jc/add-ita (Thu Aug 21 01:44:53 2008 -0700) 1 commit
 + git-add --intent-to-add (-N)

Teaches "git add" to record only the intent to add a path later.
(jc: I rerolled this without the fake empty blob object.)

* mg/verboseprune (Mon Sep 29 18:49:52 2008 +0200) 1 commit
 + make prune report removed objects on -v

This is a pretty trivial new feature.

* pb/commit-where (Fri Oct 3 22:13:49 2008 -0400) 4 commits
 + tutorial: update output of git commit
 + reformat informational commit message
 + git commit: Reformat output somewhat
 + builtin-commit.c: show on which branch a commit was added

I think this topic is settled for now.

* jk/maint-soliconv (Fri Oct 3 02:39:36 2008 -0400) 1 commit
 + Makefile: do not set NEEDS_LIBICONV for Solaris 8

* sg/maint-intrebase-msghook (Fri Oct 3 11:33:20 2008 +0200) 2 commits
 + rebase -i: remove leftover debugging
 + rebase -i: proper prepare-commit-msg hook argument when squashing

* bc/maint-stashref (Thu Oct 2 18:52:11 2008 -0500) 1 commit
 + git-stash.sh: fix flawed fix of invalid ref handling (commit
   da65e7c1)

The latter three are ready for 'maint'.  I felt burned by a bad
commit into made directly into maint earlier in the week so these
wound up getting queued into 'next' first, even though they are
certainly maint material.

----------------------------------------------------------------
[Actively Cooking]

* tr/workflow-doc (Sat Sep 13 18:11:01 2008 +0200) 2 commits
 + Documentation: Refer to git-rebase(1) to warn against rewriting
 + Documentation: new upstream rebase recovery section in git-rebase

(jc: My impression from the last round of discusson on the third
 patch in this series (not queued here) was that as long as we
 do not present it as "One True Workflow", the description was
 a good starting point, possibly others to add other recommended
 flows later.)

I haven't looked at this series yet.  Based on Junio's remarks above
I'm looking for more input on this series before it goes anywhere.

* lt/time-reject-fractional-seconds (Sat Aug 16 21:25:40 2008 -0700) 1 =
commit
 + date/time: do not get confused by fractional seconds

I need to look at this in more detail.  I suspect we can merge
this to master soon, but its been kicking around since Aug 16th.
I need to look at it to see if there's any obvious reason why Junio
has no notes on this branch and why it hasn't merged yet.

----------------------------------------------------------------
[On Hold]

* jc/post-simplify (Fri Aug 15 01:34:51 2008 -0700) 2 commits
 - revision --simplify-merges: incremental simplification
 - revision --simplify-merges: prepare for incremental simplification

(jc: I started making this incremental but the progress is not
 so great.)

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 - git-am --forge: add Signed-off-by: line for the author
 - git-am: clean-up Signed-off-by: lines
 - stripspace: add --log-clean option to clean up signed-off-by:
   lines
 - stripspace: use parse_options()
 - Add "git am -s" test
 - git-am: refactor code to add signed-off-by line for the committer

(jc: The one at second from the tip needs reworking.)

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 - "git push": tellme-more protocol extension

This is a great idea, but IIRC its implementation has a deadlock
during communication between the peers.  Someone needs to pick up
this topic and resolve the deadlock before it can continue.

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 - blame: show "previous" information in --porcelain/--incremental
   format
 - git-blame: refactor code to emit "porcelain format" output

* jc/merge-whitespace (Sun Feb 24 23:29:36 2008 -0800) 1 commit
 . WIP: start teaching the --whitespace=3Dfix to merge machinery

This has a merge conflict with `next` and isn't even in pu right now.

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

(jc: This would be the right thing to do for command line use,
 but gitk will be hit due to tcl/tk's limitation, so I am holding
 this back for now.)

--=20
Shawn.
