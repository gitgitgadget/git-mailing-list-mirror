From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/2] Make write_sha1_file_prepare() static
Date: Sat, 14 Oct 2006 12:45:45 +0200
Message-ID: <4530BFD9.8020809@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 14 12:45:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYh1E-0005AE-8z
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 12:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbWJNKpY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 06:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbWJNKpX
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 06:45:23 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:45803
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1752135AbWJNKpX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Oct 2006 06:45:23 -0400
Received: from [10.0.1.3] (p508E51C5.dip.t-dialin.net [80.142.81.197])
	by neapel230.server4you.de (Postfix) with ESMTP id 053EF2603D;
	Sat, 14 Oct 2006 12:45:21 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28873>

There are no callers of write_sha1_file_prepare() left outside of
sha1_file.c, so make it static.

---
 cache.h     |    6 ------
 sha1_file.c |    9 +++------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/cache.h b/cache.h
index aa3a562..c354701 100644
--- a/cache.h
+++ b/cache.h
@@ -247,12 +247,6 @@ extern void * unpack_sha1_file(void *map
 extern void * read_sha1_file(const unsigned char *sha1, char *type, unsigned long *size);
 extern int hash_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *sha1);
 extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *return_sha1);
-extern char *write_sha1_file_prepare(void *buf,
-				     unsigned long len,
-				     const char *type,
-				     unsigned char *sha1,
-				     unsigned char *hdr,
-				     int *hdrlen);
 
 extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
diff --git a/sha1_file.c b/sha1_file.c
index 6c64ec4..d111be7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1347,12 +1347,9 @@ void *read_object_with_reference(const u
 	}
 }
 
-char *write_sha1_file_prepare(void *buf,
-			      unsigned long len,
-			      const char *type,
-			      unsigned char *sha1,
-			      unsigned char *hdr,
-			      int *hdrlen)
+static char *write_sha1_file_prepare(void *buf, unsigned long len,
+                                     const char *type, unsigned char *sha1,
+                                     unsigned char *hdr, int *hdrlen)
 {
 	SHA_CTX c;
 
-- 
1.4.3.rc2.gdce3
