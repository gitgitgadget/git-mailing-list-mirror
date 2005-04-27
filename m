From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Use diff-tree -p -r instead of "git diff" in git-export.
Date: Wed, 27 Apr 2005 15:26:16 -0700
Message-ID: <7vd5sfeu0n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 00:24:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQuwL-0004sx-Vm
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 00:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVD0W2N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 18:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVD0W1O
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 18:27:14 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:50592 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262064AbVD0W0T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 18:26:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050427222616.JZOW19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 27 Apr 2005 18:26:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Now diff-tree can produce patch itself, there is no reason to
depend on Cogito to show diff in the git-export output anymore.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

git-export.c |    2 +-
1 files changed, 1 insertion(+), 1 deletion(-)

# - diff.c: don't add extra '/' to pathname
# + 04/27 15:23 Use diff-tree -p in git-export.
--- k/git-export.c
+++ l/git-export.c
@@ -18,7 +18,7 @@ void show_commit(struct commit *commit)
 		char *against = sha1_to_hex(commit->parents->item->object.sha1);
 		printf("\n\n======== diff against %s ========\n", against);
 		fflush(NULL);
-		sprintf(cmdline, "git diff -r %s:%s", against, hex);
+		sprintf(cmdline, "diff-tree -p -r %s %s", against, hex);
 		system(cmdline);
 	}
 	printf("======== end ========\n\n");

