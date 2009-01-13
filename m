From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v7 5/5] lstat_cache(): introduce clear_lstat_cache()
 function
Date: Tue, 13 Jan 2009 13:29:08 +0100
Message-ID: <1231849748-8244-6-git-send-email-barvik@broadpark.no>
References: <1231849748-8244-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Pete Harlan <pgit@pcharlan.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 13:31:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMiQV-0007vI-LR
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 13:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758433AbZAMM32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 07:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758397AbZAMM31
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 07:29:27 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:58286 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758331AbZAMM30 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 07:29:26 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDE0016RTCZOM10@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Tue, 13 Jan 2009 13:29:23 +0100 (CET)
Received: from localhost.localdomain ([84.48.79.194])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KDE00L11TCKJ9C0@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Tue, 13 Jan 2009 13:29:23 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2.GIT
In-reply-to: <1231849748-8244-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105494>

If you want to completely clear the contents of the lstat_cache(), then
call this new function.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 cache.h    |    1 +
 symlinks.c |    7 +++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index f4452a8..468daf6 100644
--- a/cache.h
+++ b/cache.h
@@ -723,6 +723,7 @@ extern int has_symlink_leading_path(int len, const char *name);
 extern int has_symlink_or_noent_leading_path(int len, const char *name);
 extern int has_dirs_only_path(int len, const char *name, int prefix_len);
 extern void invalidate_lstat_cache(int len, const char *name);
+extern void clear_lstat_cache(void);
 
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
diff --git a/symlinks.c b/symlinks.c
index 3b1c3da..7a634cb 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -183,6 +183,13 @@ void invalidate_lstat_cache(int len, const char *name)
 	}
 }
 
+/* Completely clear the contents of the cache!
+ */
+void clear_lstat_cache(void)
+{
+	reset_lstat_cache(0, 0);
+}
+
 #define USE_ONLY_LSTAT  0
 
 /* Return non-zero if path 'name' has a leading symlink component.
-- 
1.6.0.2.GIT
