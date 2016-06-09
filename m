From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] write_or_die: remove the unused write_or_whine() function
Date: Thu, 9 Jun 2016 23:52:22 +0100
Message-ID: <5759F326.9080101@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 00:52:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB8og-0005U7-HA
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 00:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbcFIWw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 18:52:28 -0400
Received: from avasout01.plus.net ([84.93.230.227]:44385 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbcFIWw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 18:52:27 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout01 with smtp
	id 4msQ1t0045VX2mk01msRqN; Thu, 09 Jun 2016 23:52:25 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=99_7UcXEKaq_rfXcp6gA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296938>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

Commit f0bca72d ("send-pack: use buffered I/O to talk to pack-objects",
08-06-2016) removed the last use of write_or_whine(). I had intended to
include this 'commit citation' in the commit message, but until it reaches
the next branch, I don't know how stable that information will be.

Anyway, on reflection, the subject line says everything that needs to be
said. However, you need to know which commit this one depends on. ;-)

ATB,
Ramsay Jones

 cache.h        |  1 -
 write_or_die.c | 11 -----------
 2 files changed, 12 deletions(-)

diff --git a/cache.h b/cache.h
index 84d8812..258f154 100644
--- a/cache.h
+++ b/cache.h
@@ -1767,7 +1767,6 @@ extern int copy_file(const char *dst, const char *src, int mode);
 extern int copy_file_with_time(const char *dst, const char *src, int mode);
 
 extern void write_or_die(int fd, const void *buf, size_t count);
-extern int write_or_whine(int fd, const void *buf, size_t count, const char *msg);
 extern int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg);
 extern void fsync_or_die(int fd, const char *);
 
diff --git a/write_or_die.c b/write_or_die.c
index 49e80aa..9816879 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -94,14 +94,3 @@ int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
 
 	return 1;
 }
-
-int write_or_whine(int fd, const void *buf, size_t count, const char *msg)
-{
-	if (write_in_full(fd, buf, count) < 0) {
-		fprintf(stderr, "%s: write error (%s)\n",
-			msg, strerror(errno));
-		return 0;
-	}
-
-	return 1;
-}
-- 
2.8.0
