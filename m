From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/3] Remove unused function convert_sha1_file()
Date: Mon, 03 Sep 2007 20:08:01 +0200
Message-ID: <46DC4D81.20709@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 20:08:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISGLM-0000Ii-OR
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 20:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648AbXICSIH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 14:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753524AbXICSIG
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 14:08:06 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:49080
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753495AbXICSIF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Sep 2007 14:08:05 -0400
Received: from [10.0.1.201] (p508EFD82.dip.t-dialin.net [80.142.253.130])
	by neapel230.server4you.de (Postfix) with ESMTP id 87A72873B5;
	Mon,  3 Sep 2007 20:08:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57499>

convert_sha1_file() became unused by the previous patch -- remove it.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 cache.h   |    1 -
 convert.c |   15 ---------------
 2 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/cache.h b/cache.h
index 70abbd5..493983c 100644
--- a/cache.h
+++ b/cache.h
@@ -592,7 +592,6 @@ extern void trace_argv_printf(const char **argv, int count, const char *format,
 /* convert.c */
 extern char *convert_to_git(const char *path, const char *src, unsigned long *sizep);
 extern char *convert_to_working_tree(const char *path, const char *src, unsigned long *sizep);
-extern void *convert_sha1_file(const char *path, const unsigned char *sha1, unsigned int mode, enum object_type *type, unsigned long *size);
 
 /* diff.c */
 extern int diff_auto_refresh_index;
diff --git a/convert.c b/convert.c
index 21908b1..d77c8eb 100644
--- a/convert.c
+++ b/convert.c
@@ -687,18 +687,3 @@ char *convert_to_working_tree(const char *path, const char *src, unsigned long *
 
 	return buf;
 }
-
-void *convert_sha1_file(const char *path, const unsigned char *sha1,
-                        unsigned int mode, enum object_type *type,
-                        unsigned long *size)
-{
-	void *buffer = read_sha1_file(sha1, type, size);
-	if (S_ISREG(mode) && buffer) {
-		void *converted = convert_to_working_tree(path, buffer, size);
-		if (converted) {
-			free(buffer);
-			buffer = converted;
-		}
-	}
-	return buffer;
-}
-- 
1.5.3
