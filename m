From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Fix off-by-one error in show-diff
Date: Sat, 16 Apr 2005 22:56:29 -0700
Message-ID: <7vsm1q0wvm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 07:52:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN2iA-0000x6-S8
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 07:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVDQF4c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 01:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVDQF4c
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 01:56:32 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:35286 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261266AbVDQF4b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 01:56:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050417055628.ERDS2123.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Apr 2005 01:56:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The patch to introduce shell safety to show-diff has an
off-by-one error.  Here is an fix.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 show-diff.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

show-diff.c: 8a24ff62b85a6e23469e3f0e7a20170dfe543ebf
--- show-diff.c
+++ show-diff.c	2005-04-16 22:53:11.000000000 -0700
@@ -27,8 +27,8 @@
 	int cnt, c;
 	char *cp;
 
-	/* count single quote characters */ 
-	for (cnt = 0, cp = src; *cp; cnt++, cp++)
+	/* count bytes needed to store the quoted string. */ 
+	for (cnt = 1, cp = src; *cp; cnt++, cp++)
 		if (*cp == '\'')
 			cnt += 3;
 

