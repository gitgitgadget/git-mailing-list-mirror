From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH v10 5/5] lstat_cache(): introduce clear_lstat_cache() function
Date: Sun, 18 Jan 2009 16:14:54 +0100
Message-ID: <1232291694-18083-6-git-send-email-barvik@broadpark.no>
References: <1232291694-18083-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 18 16:16:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZON-0006JQ-9A
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 16:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763962AbZARPPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 10:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764000AbZARPPP
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 10:15:15 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:56577 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763882AbZARPPM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 10:15:12 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDO00A8TAD8IU70@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 18 Jan 2009 16:15:08 +0100 (CET)
Received: from localhost.localdomain ([80.203.29.59])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KDO00BSIACUNG70@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 18 Jan 2009 16:15:08 +0100 (CET)
X-Mailer: git-send-email 1.6.1.83.gd727f
In-reply-to: <1232291694-18083-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106221>

If you want to completely clear the contents of the lstat_cache(), then
call this new function.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 cache.h    |    1 +
 symlinks.c |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index efcceec..8e22c27 100644
--- a/cache.h
+++ b/cache.h
@@ -720,6 +720,7 @@ extern int has_symlink_leading_path(int len, const char *name);
 extern int has_symlink_or_noent_leading_path(int len, const char *name);
 extern int has_dirs_only_path(int len, const char *name, int prefix_len);
 extern void invalidate_lstat_cache(int len, const char *name);
+extern void clear_lstat_cache(void);
 
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
diff --git a/symlinks.c b/symlinks.c
index dbdfec4..83cecd7 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -195,6 +195,14 @@ void invalidate_lstat_cache(int len, const char *name)
 	}
 }
 
+/*
+ * Completely clear the contents of the cache
+ */
+void clear_lstat_cache(void)
+{
+	reset_lstat_cache(0, 0);
+}
+
 #define USE_ONLY_LSTAT  0
 
 /*
-- 
1.6.1.83.gd727f
