From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH (take 2)] Use diff-tree -p instead of "git diff" in
 git-export.
Date: Wed, 27 Apr 2005 16:18:30 -0700
Message-ID: <7vsm1bdd15.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 01:13:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQviQ-0001RN-TU
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 01:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVD0XSg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 19:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVD0XSe
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 19:18:34 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:52714 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262091AbVD0XSc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 19:18:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050427231830.MBKC12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 27 Apr 2005 19:18:30 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Now diff-tree can produce patch itself, there is no reason to
depend on Cogito to show diff in the git-export output anymore.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

This is a reworked patch---we just made -p to imply recursive so
we can just say diff-tree -p, not diff-tree -p -r like I said in
the previous patch.

git-export.c |    2 +-
1 files changed, 1 insertion(+), 1 deletion(-)

--- k/git-export.c
+++ l/git-export.c
@@ -18,7 +18,7 @@ void show_commit(struct commit *commit)
 		char *against = sha1_to_hex(commit->parents->item->object.sha1);
 		printf("\n\n======== diff against %s ========\n", against);
 		fflush(NULL);
-		sprintf(cmdline, "git diff -r %s:%s", against, hex);
+		sprintf(cmdline, "diff-tree -p %s %s", against, hex);
 		system(cmdline);
 	}
 	printf("======== end ========\n\n");

