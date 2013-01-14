From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/14] imap-send.c: remove struct message
Date: Mon, 14 Jan 2013 06:32:37 +0100
Message-ID: <1358141566-26081-6-git-send-email-mhagger@alum.mit.edu>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 06:34:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TucgU-0007IG-Qy
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 06:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121Ab3ANFdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 00:33:41 -0500
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:55150 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751040Ab3ANFdk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 00:33:40 -0500
X-AuditID: 1207440d-b7f306d0000008b7-36-50f398b383b6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 2C.E0.02231.3B893F05; Mon, 14 Jan 2013 00:33:39 -0500 (EST)
Received: from michael.fritz.box (p57A25AA5.dip.t-dialin.net [87.162.90.165])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0E5Wt2m026427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Jan 2013 00:33:38 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqLt5xucAgyWzNSy6rnQzWTT0XmG2
	uL1iPrPFj5YeZgcWj7/vPzB5POvdw+hx8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGTPeOhbc
	4qvYsGcyawPjMe4uRk4OCQETiSdvPjBC2GISF+6tZ+ti5OIQErjMKHFi1URGCOcsk8SDpsvM
	IFVsAroSi3qamUBsEQE1iYlth1hAbGaBFImO591gk4QFLCXO7drIBmKzCKhKNG9rBOvlFXCR
	+L1nLhPENgWJ1zsvsYLYnAKuEt8/ngKrEQKqeXiqmW0CI+8CRoZVjHKJOaW5urmJmTnFqcm6
	xcmJeXmpRbpGermZJXqpKaWbGCHhw7uD8f86mUOMAhyMSjy8m0o+BwixJpYVV+YeYpTkYFIS
	5Q3vBwrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4Q2tA8rxpiRWVqUW5cOkpDlYlMR51Zao+wkJ
	pCeWpGanphakFsFkZTg4lCR4OYFxIiRYlJqeWpGWmVOCkGbi4AQRXCAbeIA2fJ4OsqG4IDG3
	ODMdougUo6KUOO9qkIQASCKjNA9uACzSXzGKA/0jzPsPpIoHmCTgul8BDWYCGnz2wnuQwSWJ
	CCmpBkb+dfqayX0/+c/rKnHvf/OCX5xvz7TqiS467TOXLDwosL1jyk+jEr+sUwI5YXqMa/dZ
	7mWQnuB3oX+pfllGqfWGOVEXon9+bBRViKmsy1yxN5RN1alZnn32Fp4nudXCdg/XLzN+tyq5
	1cuq0HH+Wb//f4Lr3u3t93ZYtKL8Ykx264YTn+0/flFiKc5INNRiLipOBABiyQen 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213438>

It was never used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 3177361..a47008b 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -33,23 +33,10 @@ typedef void *SSL;
 #include <openssl/hmac.h>
 #endif
 
-/* For message->status */
-#define M_RECENT       (1<<0) /* unsyncable flag; maildir_* depend on this being 1<<0 */
-#define M_DEAD         (1<<1) /* expunged */
-#define M_FLAGS        (1<<2) /* flags fetched */
-
-struct message {
-	struct message *next;
-	size_t size; /* zero implies "not fetched" */
-	int uid;
-	unsigned char flags, status;
-};
-
 struct store {
 	/* currently open mailbox */
 	const char *name; /* foreign! maybe preset? */
 	char *path; /* own */
-	struct message *msgs; /* own */
 	int uidvalidity;
 	unsigned char opts; /* maybe preset? */
 	/* note that the following do _not_ reflect stats from msgs, but mailbox totals */
@@ -74,8 +61,6 @@ static void imap_warn(const char *, ...);
 
 static char *next_arg(char **);
 
-static void free_generic_messages(struct message *);
-
 __attribute__((format (printf, 3, 4)))
 static int nfsnprintf(char *buf, int blen, const char *fmt, ...);
 
@@ -447,16 +432,6 @@ static char *next_arg(char **s)
 	return ret;
 }
 
-static void free_generic_messages(struct message *msgs)
-{
-	struct message *tmsg;
-
-	for (; msgs; msgs = tmsg) {
-		tmsg = msgs->next;
-		free(msgs);
-	}
-}
-
 static int nfsnprintf(char *buf, int blen, const char *fmt, ...)
 {
 	int ret;
@@ -914,7 +889,6 @@ static void imap_close_server(struct imap_store *ictx)
 static void imap_close_store(struct store *ctx)
 {
 	imap_close_server((struct imap_store *)ctx);
-	free_generic_messages(ctx->msgs);
 	free(ctx);
 }
 
-- 
1.8.0.3
