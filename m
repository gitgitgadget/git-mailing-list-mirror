From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Wed, 10 Jan 2007 16:48:34 -0800
Message-ID: <7v3b6i75i5.fsf@assigned-by-dhcp.cox.net>
References: <7vr6u3cmsi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 11 01:48:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4o7d-0005C4-0h
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 01:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965266AbXAKAsq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 19:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965277AbXAKAsq
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 19:48:46 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:53374 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965266AbXAKAsp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 19:48:45 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070111004845.IYCH97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Jan 2007 19:48:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9cnu1W0021kojtg0000000; Wed, 10 Jan 2007 19:47:54 -0500
To: git@vger.kernel.org
X-master-at: 2a3a3c247e7f1f257e9c6762e48b98f08a30011a
X-next-at: b8a1bd36e034356d27f4a6f2d7588a5b50161fd6
In-Reply-To: <7vr6u3cmsi.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 10 Jan 2007 00:23:57 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36545>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* jc/detached-head (Tue Jan 9 20:39:09 2007 -0800) 9 commits
 + git-checkout: handle local changes sanely when detaching HEAD
 + git-checkout: safety check for detached HEAD checks existing refs
 + git-checkout: fix branch name output from the command
 + git-checkout: safety when coming back from the detached HEAD
   state.
 + git-checkout: rewording comments regarding detached HEAD.
 + git-checkout: do not warn detaching HEAD when it is already
   detached.
 + Detached HEAD (experimental)
 + git-branch: show detached HEAD
 + git-status: show detached HEAD

Will be merged to 'master' in a few days for v1.5.0-rc1.

* jc/bare (Sat Dec 30 23:32:38 2006 -0500) 4 commits
 + Disallow working directory commands in a bare repository.
 + git-fetch: allow updating the current branch in a bare repository.
 + Introduce is_bare_repository() and core.bare configuration
   variable
 + Move initialization of log_all_ref_updates

I munged Shawn's RFC patch and placed on top of this series.
Will be merged to 'master' in a few days for v1.5.0-rc1.

* ar/merge-recursive (Wed Jan 10 11:20:58 2007 -0800) 2 commits
 + merge-recursive: do not use on-file index when not needed.
 + Speed-up recursive by flushing index only once for all entries

I did not see much improvement (maybe a largish kernel merge
going from 2.5 seconds to slightly less than one second) but
this seems safe and the change removes a lot more code than it
adds which must mean it is good.  Perhaps in v1.5.0-rc1 but I do
not think it is a must-have.  Comments?


* sp/merge (Thu Dec 28 02:35:17 2006 -0500) 2 commits
 - Avoid git-fetch in `git-pull .` when possible.
 + Improve merge performance by avoiding in-index merges.

I fliped the patches around and the one that avoids the
"read-tree then merge-recursive" sequence is now in 'next'.  I
haven't done any measurements yet.  It looks obviously correct
but I am not sure if it is a v1.5.0 material.  Comments?


* sp/describe (Wed Jan 10 06:39:47 2007 -0500) 1 commit
 - Chose better tag names in git-describe after merges.

Slowing it down by 4x is very unfortunate.  I think there is a
better way to walk the ancestry than doing one at a time to
count the commits, but I did not have enough time to look at
this today.

* jc/merge-base (Tue Jan 9 02:23:42 2007 -0800) 6 commits
 - Teach "git-merge-base --check-ancestry" about refs.
 - git-merge-base: --check-ancestry option
 + in_merge_bases(): optimization
 + merge_base(): move traversal into a separate function.
 + Allow in_merge_bases() to take more than one reference commits.
 + Make merge-base a built-in.

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
* jc/diff-apply-patch (Fri Sep 22 16:17:58 2006 -0700) 1 commit
 + git-diff/git-apply: make diff output a bit friendlier to GNU patch
   (part 2)

These are on-hold.
