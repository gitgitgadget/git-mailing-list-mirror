From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Sat, 06 Jan 2007 23:44:01 -0800
Message-ID: <7v8xgf46ym.fsf@assigned-by-dhcp.cox.net>
References: <7vwt4647g0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jan 07 08:44:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3ShP-0003O8-AA
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 08:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbXAGHoF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 02:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbXAGHoF
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 02:44:05 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:38637 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932393AbXAGHoD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 02:44:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070107074401.DVNK18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Sun, 7 Jan 2007 02:44:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 87kG1W00c1kojtg0000000; Sun, 07 Jan 2007 02:44:17 -0500
To: git@vger.kernel.org
X-master-at: 13e86efbeae5994a85cc482b3964db7298c5c6ea
X-next-at: 71bb6ea083c59115d35c36f9bfd1986d30bf92e1
In-Reply-To: <7vwt4647g0.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 01 Jan 2007 16:07:43 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36134>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

I will start merging some topics from 'next' to 'master' this
weekend.  Probably will declare -rc1 next weekend.

* jc/reflog (Sat Jan 6 22:32:41 2007 -0800) 5 commits
 + reflog --fix-stale: do not check the same trees and commits
   repeatedly.
 + reflog expire --fix-stale
 + Move traversal of reachable objects into a separate library.
 + builtin-prune: separate ref walking from reflog walking.
 + builtin-prune: make file-scope static struct to an argument.

We would want to do more interesting things on reflog data (such
as bisecting) and need to make reflog reliable for that.  We
allowed reflog to point at missing commits for too long, and
this is to clean up entries that point at commits removed with
older versions of git.

This needs to be in v1.5.0 final.

* jc/reset-remove (Fri Jan 5 01:38:56 2007 -0800) 2 commits
 + git-reset <tree> -- <path> restores absense of <path> in <tree>
 + diff-index --cached --raw: show tree entry on the LHS for unmerged
   entries.

Will merge to master.

* sp/mmap (Thu Jan 4 22:28:08 2007 -0500) 26 commits
 + Increase packedGit{Limit,WindowSize} on 64 bit systems.
 + Update packedGit config option documentation.
 + mmap: set FD_CLOEXEC for file descriptors we keep open for mmap()
 + pack-objects: fix use of use_pack().
 + Fix random segfaults in pack-objects.
 + Cleanup read_cache_from error handling.
 + Replace mmap with xmmap, better handling MAP_FAILED.
 + Release pack windows before reporting out of memory.
 + Default core.packdGitWindowSize to 1 MiB if NO_MMAP.
 + Test suite for sliding window mmap implementation.
 + Create pack_report() as a debugging aid.
 + Support unmapping windows on 'temporary' packfiles.
 + Improve error message when packfile mmap fails.
 + Ensure core.packedGitWindowSize cannot be less than 2 pages.
 + Load core configuration in git-verify-pack.
 + Fully activate the sliding window pack access.
 + Unmap individual windows rather than entire files.
 + Document why header parsing won't exceed a window.
 + Loop over pack_windows when inflating/accessing data.
 + Replace use_packed_git with window cursors.
 + Refactor how we open pack files to prepare for multiple windows.
 + Create read_or_die utility routine.
 + Use off_t for index and pack file lengths.
 + Refactor packed_git to prepare for sliding mmap windows.
 + Introduce new config option for mmap limit.
 + Replace unpack_entry_gently with unpack_entry.

Will merge to 'master'.

* jc/remote (Wed Jan 3 12:13:04 2007 -0800) 1 commit
 + git-remote

I described what's still missing in this, and the list may have
ideas to enhance it.  Will merge to 'master' and people can hack
on it there.

* jc/detached-head (Wed Jan 3 21:10:10 2007 +0100) 3 commits
 - git-branch: show detached HEAD
 - git-status: show detached HEAD
 - Detached HEAD (experimental)

I personally feel this should be in v1.5.0.final, but it is not
yet ready, unfortunately...

* jr/status (Tue Jan 2 20:26:21 2007 +0100) 4 commits
 + Improve cached content header of status output
 + Support --amend on initial commit in status output
 + Improve "nothing to commit" part of status output
 + Clarify syntax and role of git-add in status output

Will merge to 'master'.

* jc/3way (Wed Nov 29 18:53:13 2006 -0800) 1 commit
 + git-merge: preserve and merge local changes when doing fast
   forward

* jc/diff-apply-patch (Fri Sep 22 16:17:58 2006 -0700) 1 commit
 + git-diff/git-apply: make diff output a bit friendlier to GNU patch
   (part 2)

* sp/merge (Sun Dec 31 00:02:13 2006 -0500) 3 commits
 - Refresh the index before starting merge-recursive.
 - Improve merge performance by avoiding in-index merges.
 - Avoid git-fetch in `git-pull .` when possible.
* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel
* jc/explain (Mon Dec 4 19:35:04 2006 -0800) 1 commit
 - git-explain
* jc/web (Wed Nov 8 14:54:09 2006 -0800) 1 commit
 - gitweb: steal loadavg throttle from kernel.org
* jc/pickaxe (Sun Nov 5 11:52:43 2006 -0800) 1 commit
 - blame: --show-stats for easier optimization work.
