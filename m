From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] (take 2) Rename confusing variable in show-diff
Date: Sat, 16 Apr 2005 18:26:52 -0700
Message-ID: <7vu0m62nxf.fsf@assigned-by-dhcp.cox.net>
References: <7vzmvy2ooq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 03:23:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMyVR-0002wb-Vz
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 03:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVDQB1D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 21:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVDQB1D
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 21:27:03 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:5367 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261235AbVDQB07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 21:26:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050417012653.MPUP13104.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Apr 2005 21:26:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Oops, sorry I screwed up and sent a wrong patch.  Please discard
the previous one.

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

 show-diff.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

show-diff.c: e52eee21c2f682bef2dba06445699cca8e34c63a
--- show-diff.c
+++ show-diff.c	2005-04-16 18:23:57.000000000 -0700
@@ -162,7 +162,7 @@
 		int changed;
 		unsigned long size;
 		char type[20];
-		void *new;
+		void *old;
 
 		if (1 <argc &&
 		    ! matches_pathspec(ce, argv+1, argc-1))
@@ -193,9 +193,9 @@
 		if (silent)
 			continue;
 
-		new = read_sha1_file(ce->sha1, type, &size);
-		show_differences(ce->name, new, size);
-		free(new);
+		old = read_sha1_file(ce->sha1, type, &size);
+		show_differences(ce->name, old, size);
+		free(old);
 	}
 	return 0;
 }


