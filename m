From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 02/14] imap-send.c: remove struct msg_data
Date: Tue, 15 Jan 2013 09:06:20 +0100
Message-ID: <1358237193-8887-3-git-send-email-mhagger@alum.mit.edu>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 09:15:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv1fl-0000TQ-0i
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 09:15:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756515Ab3AOIOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 03:14:45 -0500
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:60598 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753644Ab3AOIOo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 03:14:44 -0500
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2013 03:14:44 EST
X-AuditID: 12074412-b7f216d0000008e3-26-50f50e2672d2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 5F.44.02275.62E05F05; Tue, 15 Jan 2013 03:07:02 -0500 (EST)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0F86n5O029668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Jan 2013 03:07:01 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqKvG9zXA4M0cNYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M4492gNa8FMwYpp77awNzCe
	5+1i5OSQEDCR+LX9KwuELSZx4d56ti5GLg4hgcuMEn92/mGBcM4wSfx9tIsVpIpNQFdiUU8z
	E4gtIqAmMbHtEFg3s4CDxObPjYwgtrCArcSatmNsIDaLgKrE0T9nwep5BZwlfv5eArVNQeL1
	zktgMzkFXCSu/jzGDGILAdV82XCacQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFumZ6
	uZkleqkppZsYIcEitINx/Um5Q4wCHIxKPLzGBl8ChFgTy4orcw8xSnIwKYnydnB9DRDiS8pP
	qcxILM6ILyrNSS0+xCjBwawkwuvzDqicNyWxsiq1KB8mJc3BoiTO+3Oxup+QQHpiSWp2ampB
	ahFMVoaDQ0mCV4EXaKhgUWp6akVaZk4JQpqJgxNEcIFs4AHa8IobqJC3uCAxtzgzHaLoFKOi
	lDjvHx6ghABIIqM0D24ALK5fMYoD/SPMKwqyhweYEuC6XwENZgIavGnvZ5DBJYkIKakGRtna
	skbxS7bNxS2f7IVsUiK2Bk7Z/GGt7GZpa5+w3rmSMRuVmy1/2tT7e7gsE1DUXsiyXCd1Yv2e
	h/eqzit7L703I/z0/+o9gidjN5iFBBmm3bzJ97lh3aK7+5a4L1pylMfi4fePEfMye35lKq5n
	DFRO9p3CzsR0yuro778hPm09EvXFZ+atUmIpzkg01GIuKk4EAHLKvHLGAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213617>

Now that its flags member has been deleted, all that is left is a
strbuf.  So use a strbuf directly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index f1c8f5a..29c10a4 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -68,10 +68,6 @@ struct store {
 	int recent; /* # of recent messages - don't trust this beyond the initial read */
 };
 
-struct msg_data {
-	struct strbuf data;
-};
-
 static const char imap_send_usage[] = "git imap-send < <mbox>";
 
 #undef DRV_OK
@@ -1279,7 +1275,7 @@ static void lf_to_crlf(struct strbuf *msg)
  * Store msg to IMAP.  Also detach and free the data from msg->data,
  * leaving msg->data empty.
  */
-static int imap_store_msg(struct store *gctx, struct msg_data *msg)
+static int imap_store_msg(struct store *gctx, struct strbuf *msg)
 {
 	struct imap_store *ctx = (struct imap_store *)gctx;
 	struct imap *imap = ctx->imap;
@@ -1287,11 +1283,11 @@ static int imap_store_msg(struct store *gctx, struct msg_data *msg)
 	const char *prefix, *box;
 	int ret;
 
-	lf_to_crlf(&msg->data);
+	lf_to_crlf(msg);
 	memset(&cb, 0, sizeof(cb));
 
-	cb.dlen = msg->data.len;
-	cb.data = strbuf_detach(&msg->data, NULL);
+	cb.dlen = msg->len;
+	cb.data = strbuf_detach(msg, NULL);
 
 	box = gctx->name;
 	prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
@@ -1449,7 +1445,7 @@ static int git_imap_config(const char *key, const char *val, void *cb)
 int main(int argc, char **argv)
 {
 	struct strbuf all_msgs = STRBUF_INIT;
-	struct msg_data msg = {STRBUF_INIT};
+	struct strbuf msg = STRBUF_INIT;
 	struct store *ctx = NULL;
 	int ofs = 0;
 	int r;
@@ -1511,10 +1507,10 @@ int main(int argc, char **argv)
 		unsigned percent = n * 100 / total;
 
 		fprintf(stderr, "%4u%% (%d/%d) done\r", percent, n, total);
-		if (!split_msg(&all_msgs, &msg.data, &ofs))
+		if (!split_msg(&all_msgs, &msg, &ofs))
 			break;
 		if (server.use_html)
-			wrap_in_html(&msg.data);
+			wrap_in_html(&msg);
 		r = imap_store_msg(ctx, &msg);
 		if (r != DRV_OK)
 			break;
-- 
1.8.0.3
