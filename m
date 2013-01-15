From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 08/14] imap-send.c: remove struct imap argument to parse_imap_list_l()
Date: Tue, 15 Jan 2013 09:06:26 +0100
Message-ID: <1358237193-8887-9-git-send-email-mhagger@alum.mit.edu>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 09:07:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv1Yd-0002aH-0O
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 09:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655Ab3AOIHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 03:07:21 -0500
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:52997 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755754Ab3AOIHT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 03:07:19 -0500
X-AuditID: 1207440f-b7f276d0000008b2-d8-50f50e36088e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 32.9F.02226.63E05F05; Tue, 15 Jan 2013 03:07:18 -0500 (EST)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0F86n5U029668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Jan 2013 03:07:17 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqGvG9zXAYFu/oUXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGec3biXrWCuQMWXK29YGxhn
	8HQxcnJICJhIXOjbwgRhi0lcuLeerYuRi0NI4DKjxINJR6GcM0wSd6+/YQapYhPQlVjU0wzW
	ISKgJjGx7RALiM0s4CCx+XMjI4gtLBAp8XtCGxuIzSKgKnG7dQcriM0r4Cwx+/B8RohtChKv
	d14Ci3MKuEhc/XkMbL4QUM2XDacZJzDyLmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6KX
	m1mil5pSuokREiz8Oxi71sscYhTgYFTi4b2p+yVAiDWxrLgy9xCjJAeTkihvB9fXACG+pPyU
	yozE4oz4otKc1OJDjBIczEoivD7vgMp5UxIrq1KL8mFS0hwsSuK86kvU/YQE0hNLUrNTUwtS
	i2CyMhwcShK8MbxAQwWLUtNTK9Iyc0oQ0kwcnCCCC2QDD9CGV9xAhbzFBYm5xZnpEEWnGBWl
	xHnNQCYIgCQySvPgBsDi+hWjONA/wrxBIFU8wJQA1/0KaDAT0OBNez+DDC5JREhJNTDqPNGd
	elW+uZn1vYDt8TOfWQ/Hf/DbxC5fzOxhMXeF9X6DZp+/R2OuOFiLmHo2G6op/Jt7+fi26zNW
	HjtapyIb3uL+0Dn3Q4X99l/n90443cShNPXHjwxvzTkmxSXifWJyk9KvvD61f7LNiu8rQ5y5
	xaYdPlS+YZvllPX/bz7W1opsfbRWudhTiaU4I9FQi7moOBEANGNuqsYCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213609>

It was always set to NULL.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 39 +++------------------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index cbbf845..29e4037 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -578,11 +578,10 @@ static void free_list(struct imap_list *list)
 	}
 }
 
-static int parse_imap_list_l(struct imap *imap, char **sp, struct imap_list **curp, int level)
+static int parse_imap_list_l(char **sp, struct imap_list **curp, int level)
 {
 	struct imap_list *cur;
 	char *s = *sp, *p;
-	int n, bytes;
 
 	for (;;) {
 		while (isspace((unsigned char)*s))
@@ -598,39 +597,7 @@ static int parse_imap_list_l(struct imap *imap, char **sp, struct imap_list **cu
 			/* sublist */
 			s++;
 			cur->val = LIST;
-			if (parse_imap_list_l(imap, &s, &cur->child, level + 1))
-				goto bail;
-		} else if (imap && *s == '{') {
-			/* literal */
-			bytes = cur->len = strtol(s + 1, &s, 10);
-			if (*s != '}')
-				goto bail;
-
-			s = cur->val = xmalloc(cur->len);
-
-			/* dump whats left over in the input buffer */
-			n = imap->buf.bytes - imap->buf.offset;
-
-			if (n > bytes)
-				/* the entire message fit in the buffer */
-				n = bytes;
-
-			memcpy(s, imap->buf.buf + imap->buf.offset, n);
-			s += n;
-			bytes -= n;
-
-			/* mark that we used part of the buffer */
-			imap->buf.offset += n;
-
-			/* now read the rest of the message */
-			while (bytes > 0) {
-				if ((n = socket_read(&imap->buf.sock, s, bytes)) <= 0)
-					goto bail;
-				s += n;
-				bytes -= n;
-			}
-
-			if (buffer_gets(&imap->buf, &s))
+			if (parse_imap_list_l(&s, &cur->child, level + 1))
 				goto bail;
 		} else if (*s == '"') {
 			/* quoted string */
@@ -673,7 +640,7 @@ static struct imap_list *parse_list(char **sp)
 {
 	struct imap_list *head;
 
-	if (!parse_imap_list_l(NULL, sp, &head, 0))
+	if (!parse_imap_list_l(sp, &head, 0))
 		return head;
 	free_list(head);
 	return NULL;
-- 
1.8.0.3
