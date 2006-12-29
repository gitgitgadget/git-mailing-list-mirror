From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] Allow non-fast-forward of remote tracking branches in default clone
Date: Thu, 28 Dec 2006 16:32:17 -0800
Message-ID: <7vk60btucu.fsf_-_@assigned-by-dhcp.cox.net>
References: <1167251519.2247.10.camel@dv>
	<7vfyb159dn.fsf@assigned-by-dhcp.cox.net>
	<1167341346.12660.17.camel@dv>
	<7vzm97tzbt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 29 01:32:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H05fa-0005pN-BE
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 01:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbWL2AcT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 19:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753932AbWL2AcT
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 19:32:19 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:41261 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902AbWL2AcS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 19:32:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061229003218.UBEW16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Dec 2006 19:32:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4QYX1W00o1kojtg0000000; Thu, 28 Dec 2006 19:32:32 -0500
To: git@vger.kernel.org
In-Reply-To: <7vzm97tzbt.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 28 Dec 2006 14:44:54 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35569>

This changes the default remote.origin.fetch configuration
created by git-clone so that it allows non-fast-forward updates.

When using the separate-remote layout with reflog enabled, it
does not make much sense to refuse to update the remote tracking
branch just because some of them do not fast-forward.  git-fetch
issues warnings on non-fast-forwardness, and the user can peek
at what the previous state was using the reflog.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-clone.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index f37eb9d..3d388de 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -388,7 +388,7 @@ then
 
 		# Set up the mappings to track the remote branches.
 		git-repo-config remote."$origin".fetch \
-			"refs/heads/*:$remote_top/*" '^$' &&
+			"+refs/heads/*:$remote_top/*" '^$' &&
 		rm -f "refs/remotes/$origin/HEAD"
 		git-symbolic-ref "refs/remotes/$origin/HEAD" \
 			"refs/remotes/$origin/$head_points_at" &&
-- 
1.5.0.rc0.gf5c587
