From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 6/6] git-branch: remove D/F check done by hand.
Date: Sat, 30 Sep 2006 15:30:52 -0700
Message-ID: <7v4pup9ecj.fsf@assigned-by-dhcp.cox.net>
References: <20060930220158.d331bb7c.chriscool@tuxfamily.org>
	<7vmz8hccxl.fsf@assigned-by-dhcp.cox.net>
	<7v1wptc7ou.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Oct 01 00:31:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTnMZ-00031M-1O
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 00:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbWI3Wa4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 18:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWI3Waz
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 18:30:55 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:62343 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751530AbWI3Way (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Sep 2006 18:30:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060930223053.JZHA2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Sat, 30 Sep 2006 18:30:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UmWv1V00Y1kojtg0000000
	Sat, 30 Sep 2006 18:30:56 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28160>

Now ref creation codepath in lock_ref_sha1() and friends notices
the directory/file conflict situation, we do not do this by hand
in git-branch anymore.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-branch.sh |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/git-branch.sh b/git-branch.sh
index c616830..bf84b30 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -121,16 +121,6 @@ then
 	done
 fi
 
-branchdir=$(dirname $branchname)
-while test "$branchdir" != "."
-do
-	if git-show-ref --verify --quiet -- "refs/heads/$branchdir"
-	then
-		die "$branchdir already exists."
-	fi
-	branchdir=$(dirname $branchdir)
-done
-
 prev=''
 if git-show-ref --verify --quiet -- "refs/heads/$branchname"
 then
-- 
1.4.2.1.g5a98f
