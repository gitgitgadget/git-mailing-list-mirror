From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Rename confusing variable in show-diff
Date: Sat, 16 Apr 2005 18:10:29 -0700
Message-ID: <7vzmvy2ooq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 03:07:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMyFb-00025T-3G
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 03:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVDQBKj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 21:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVDQBKj
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 21:10:39 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:1244 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261231AbVDQBKb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 21:10:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050417011029.YFMV15592.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Apr 2005 21:10:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The show-diff command uses a variable "new" but it is always
used to point at the original data recorded in the dircache
before the user started editing in the working file.  Rename it
to "old" to avoid confusion.

To be applied on top of my previous patches:

    [PATCH] Optionally tell show-diff to show only named files.
    [PATCH] show-diff -z option for machine readable output.
    [PATCH] show-diff shell safety.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 show-diff.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

show-diff.c: e52eee21c2f682bef2dba06445699cca8e34c63a
--- show-diff.c
+++ show-diff.c	2005-04-16 18:05:55.000000000 -0700
@@ -162,7 +162,7 @@
 		int changed;
 		unsigned long size;
 		char type[20];
-		void *new;
+		void *old;
 
 		if (1 <argc &&
 		    ! matches_pathspec(ce, argv+1, argc-1))
@@ -193,8 +193,8 @@
 		if (silent)
 			continue;
 
-		new = read_sha1_file(ce->sha1, type, &size);
-		show_differences(ce->name, new, size);
+		old = read_sha1_file(ce->sha1, type, &size);
+		show_differences(ce->name, old, size);
 		free(new);
 	}
 	return 0;

