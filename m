From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/4] Use tree_from_tree_or_commit() in read-tree.
Date: Tue, 19 Apr 2005 23:09:24 -0700
Message-ID: <7vekd6kmi3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 08:06:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO8Ly-0006Re-Ib
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 08:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVDTGKH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 02:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVDTGKH
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 02:10:07 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:33168 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261428AbVDTGJx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 02:09:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050420060924.WOKU18934.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 20 Apr 2005 02:09:24 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch makes read-tree accept either tree or commit.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 read-tree.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

Makefile: needs update
--- a/read-tree.c
+++ b/read-tree.c
@@ -29,11 +29,9 @@ static int read_tree(unsigned char *sha1
 	unsigned long size;
 	char type[20];
 
-	buffer = read_sha1_file(sha1, type, &size);
+	buffer = tree_from_tree_or_commit(sha1, type, &size);
 	if (!buffer)
 		return -1;
-	if (strcmp(type, "tree"))
-		return -1;
 	while (size) {
 		int len = strlen(buffer)+1;
 		unsigned char *sha1 = buffer + len;

