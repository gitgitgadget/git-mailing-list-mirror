From: Brad Roberts <braddr@gameboy2.puremagic.com>
Subject: [PATCH 08/19] rename remove_entry_at to remove_cache_entry_at and expose as a public api
Date: Thu, 21 Apr 2005 11:36:29 -0700
Message-ID: <200504211836.j3LIaTHj027552@gameboy2.puremagic.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:32:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgTV-0007yO-AB
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVDUSgw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVDUSgv
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:36:51 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:24968 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261669AbVDUSgd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 14:36:33 -0400
Received: from gameboy2.puremagic.com (root@gameboy2.puremagic.com [209.189.198.109])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3LIaRQl027902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:36:27 -0700
Received: from gameboy2.puremagic.com (braddr@localhost [127.0.0.1])
	by gameboy2.puremagic.com (8.13.3/8.13.3/Debian-3) with ESMTP id j3LIaTp4027554
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:36:29 -0700
Received: (from braddr@localhost)
	by gameboy2.puremagic.com (8.13.3/8.13.3/Submit) id j3LIaTHj027552
	for git@vger.kernel.org; Thu, 21 Apr 2005 11:36:29 -0700
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tree 68af3fb1d46759f437d15f310a9aea2931708601
parent e2acfff5e544a8c6769a9e665927092b3edd7579
author Brad Roberts <braddr@puremagic.com> 1114075605 -0700
committer Brad Roberts <braddr@gameboy2.puremagic.com> 1114075605 -0700

[PATCH] rename remove_entry_at to remove_cache_entry_at and expose as a public api

Signed-off-by: Brad Roberts <braddr@puremagic.com>
---

 cache.h      |    1 +
 read-cache.c |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

Index: cache.h
===================================================================
--- e2acfff5e544a8c6769a9e665927092b3edd7579:1/cache.h  (mode:100644 sha1:9ad6e805eafcb213c6bb4b1f8ff4d4e053fa6067)
+++ 099367f98cc063c33733d15c7a2d9737bea853d9:1/cache.h  (mode:100644 sha1:74d816c34245e0dde41643188f38cf99ca75e75f)
@@ -96,6 +96,7 @@
 extern int get_num_cache_entries();
 extern struct cache_entry * get_cache_entry(int pos);
 extern void set_cache_entry(struct cache_entry *ce, int pos);
+extern int remove_cache_entry_at(int pos);
 
 #define MTIME_CHANGED	0x0001
 #define CTIME_CHANGED	0x0002
Index: read-cache.c
===================================================================
--- e2acfff5e544a8c6769a9e665927092b3edd7579:1/read-cache.c  (mode:100644 sha1:8eaa05957a481b09116c37e43e16c5ef4e219a1e)
+++ 099367f98cc063c33733d15c7a2d9737bea853d9:1/read-cache.c  (mode:100644 sha1:286f7136bc164f3a2317bb492138d9221efb4025)
@@ -87,7 +87,7 @@
 }
 
 /* Remove entry, return true if there are more entries to go.. */
-static int remove_entry_at(int pos)
+int remove_cache_entry_at(int pos)
 {
 	active_nr--;
 	if (pos >= active_nr)
@@ -100,7 +100,7 @@
 {
 	int pos = cache_name_pos(path, strlen(path));
 	if (pos >= 0)
-		remove_entry_at(pos);
+		remove_cache_entry_at(pos);
 	return 0;
 }
 
@@ -148,7 +148,7 @@
 	if (pos < active_nr && ce_stage(ce) == 0) {
 		while (same_name(active_cache[pos], ce)) {
 			ok_to_add = 1;
-			if (!remove_entry_at(pos))
+			if (!remove_cache_entry_at(pos))
 				break;
 		}
 	}

