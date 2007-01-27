From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Sat, 27 Jan 2007 00:29:18 -0800
Message-ID: <7vps90lvoh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 27 09:29:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAiwS-00071q-4D
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 09:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbXA0I3V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 03:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbXA0I3V
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 03:29:21 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:61086 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180AbXA0I3U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 03:29:20 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070127082919.ETXO16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Sat, 27 Jan 2007 03:29:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id G8UM1W01g1kojtg0000000; Sat, 27 Jan 2007 03:28:21 -0500
X-master-at: f127404c45eff139037834a6464b68fbe1798e16
X-next-at: a081d6779ca41fc9edf7fb211eead5bd907c4bc4
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37931>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* sp/describe (Sat Jan 27 01:54:21 2007 -0500) 3 commits
 - Compute accurate distances in git-describe before output.
 - Update describe documentation.
 - Teach git-describe to display distances from tags.

Meant for 1.5.0, but I haven't reviewed the code fully yet, so
it is parked in 'pu' for now.

* np/dreflog (Fri Jan 26 17:26:11 2007 -0500) 8 commits
 - add reflog when moving HEAD to a new branch
 - create_symref(): do not assume pathname from git_path() persists
   long enough
 - add logref support to git-symbolic-ref
 - move create_symref() past log_ref_write()
 - add reflog entries for HEAD when detached
 - enable separate reflog for HEAD
 - lock_ref_sha1_basic(): remember the original name of a ref when
   resolving it
 - make reflog filename independent from struct ref_lock

Perhaps 1.5.0 material, but I do not think anybody in the
current code pays attention to reflog for HEAD ("HEAD@{....}"
syntax and log or show-branch with -g option would look at the
underlying ref and prune and friends do not protect its
entries), so merge it post 1.5.0 after these issues are fixed.

* jc/fetch (Tue Jan 16 13:43:28 2007 -0800) 5 commits
 - git-fetch: rewrite expand_ref_wildcard in C
 - git-fetch: rewrite another shell loop in C
 - git-fetch: move more code into C.
 - git-fetch--tool: start rewriting parts of git-fetch in C.
 - git-fetch: split fetch_main into fetch_dumb and fetch_native

This is an early attempt to make "fetch between repositories
with thousand refs" go faster, and it seems to work as
advertised.  Backburnered as I do not personally have need for
it and haven't heard much feedback on it.

* jc/diff-apply-patch (Fri Sep 22 16:17:58 2006 -0700) 1 commit
 + git-diff/git-apply: make diff output a bit friendlier to GNU patch
   (part 2)

I kept saying this will wait until February, 6 months after its
counterpart, "part 1", was merged.  That time is just around the
corner and it is becoming tempting to have it in 1.5.0.

* js/reverse (Sat Jan 20 23:04:02 2007 +0100) 1 commit
 + Teach revision machinery about --reverse
* jc/merge-base (Tue Jan 9 02:23:42 2007 -0800) 6 commits
 - Teach "git-merge-base --check-ancestry" about refs.
 - git-merge-base: --check-ancestry option
 + in_merge_bases(): optimization
 + merge_base(): move traversal into a separate function.
 + Allow in_merge_bases() to take more than one reference commits.
 + Make merge-base a built-in.
* sp/merge (Thu Dec 28 02:35:17 2006 -0500) 1 commit
 - Avoid git-fetch in `git-pull .` when possible.
* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel
* jc/explain (Mon Dec 4 19:35:04 2006 -0800) 1 commit
 - git-explain
* jc/3way (Wed Nov 29 18:53:13 2006 -0800) 1 commit
 + git-merge: preserve and merge local changes when doing fast
   forward
* jc/web (Wed Nov 8 14:54:09 2006 -0800) 1 commit
 - gitweb: steal loadavg throttle from kernel.org
* jc/pickaxe (Sun Nov 5 11:52:43 2006 -0800) 1 commit
 - blame: --show-stats for easier optimization work.

Will rehash post 1.5.0
