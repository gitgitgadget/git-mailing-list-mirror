From: Junio C Hamano <junkio@cox.net>
Subject: Plumbing pull request
Date: Wed, 04 May 2005 23:07:30 -0700
Message-ID: <7vr7gmkxy5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 08:01:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTZQD-00080y-Nc
	for gcvg-git@gmane.org; Thu, 05 May 2005 08:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVEEGHl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 02:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVEEGHl
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 02:07:41 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:61621 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261896AbVEEGHc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 02:07:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050505060730.HNHN23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 5 May 2005 02:07:30 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus, please pull from

    http://members.cox.net/junkio/git-jc.git

which will update the following files:

diff-cache.c           |   23 ++++++-
diff.c                 |   58 ++++++++++++++------
git-apply-patch-script |  141 +++++++++++++++++++++++++++++++++++--------------
update-cache.c         |   42 +++++++++++++-
4 files changed, 202 insertions(+), 62 deletions(-)

via the following commits:

----------------------------------------------------------------
Prepare git-apply-patch-script for symbolic links.

This patch prepares the git-apply-patch-script for the upcoming change
to store the symbolic links in the cache, being worked on by Kay
Sievers.

It currently is very anal about symbolic link changes.  It refuses to
change between a regular file and a symbolic link, and only allows
symbolic link changes if the patch is based on the same original.
----------------------------------------------------------------
Prepare diff side for upcoming symlink work.

This patch prepares the external diff interface engine for the
change to store the symbolic links in the cache, being worked on
by Kay Sievers.

The main thing it does is when comparing with the work tree, it
prepares the counterpart to the blob being compared by doing a
readlink followed by sending that result to a temporary file to
be diffed.
----------------------------------------------------------------
diff-cache shows differences for unmerged paths without --cache.

While manually resolving a merge conflict, being able to run
diff-cache without --cache option between files in the work tree
and either of the ancestor trees is helpful to verify the hand
merge result.  However, diff-cache refuses to handle unmerged
paths, even when run without --cache option.

This changes the behaviour so that the above use case will
report the differences between the compared tree and the magic
0{40} SHA1 (i.e. "look at the work tree").  When there is no
corresponding file in the work tree, or when the command is run
with "--cache" option, it continues to report "unmerged".
----------------------------------------------------------------
Do not write out new index if nothing has changed.

The git-update-cache command, especially with --refresh, may not change
anything.  In such a case, writing 1.6MB of the same thing is a waste.
----------------------------------------------------------------
Make git-prune-script executable again.

I do not know why the executable bit was lost since the change went in as
GIT pull, not via e-mail patch, but here is a fix.
----------------------------------------------------------------

