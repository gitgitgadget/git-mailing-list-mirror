From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/14] imap-send.c: remove msg_data::flags, which was always zero
Date: Tue, 15 Jan 2013 09:06:19 +0100
Message-ID: <1358237193-8887-2-git-send-email-mhagger@alum.mit.edu>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 09:14:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv1f3-0007ot-13
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 09:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756803Ab3AOIOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 03:14:00 -0500
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:58346 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756356Ab3AOIN7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 03:13:59 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2013 03:13:59 EST
X-AuditID: 12074412-b7f216d0000008e3-1b-50f50e2114d5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id BE.44.02275.12E05F05; Tue, 15 Jan 2013 03:06:57 -0500 (EST)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0F86n5N029668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Jan 2013 03:06:56 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqKvI9zXAYHaPhEXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGcsX7OeqeC2cMWR26vZGhjX
	8ncxcnJICJhIbP75kw3CFpO4cG89kM3FISRwmVFi3f9r7BDOGSaJIx8XsoNUsQnoSizqaWYC
	sUUE1CQmth1iAbGZBRwkNn9uZASxhQVCJPa+awSLswioStxfcAzI5uDgFXCWOHUzCWKZgsTr
	nZdYQWxOAReJqz+PMYPYQkAlXzacZpzAyLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6Z
	Xm5miV5qSukmRkioCO1gXH9S7hCjAAejEg+vscGXACHWxLLiytxDjJIcTEqivB1cXwOE+JLy
	UyozEosz4otKc1KLDzFKcDArifD6vAMq501JrKxKLcqHSUlzsCiJ8/5crO4nJJCeWJKanZpa
	kFoEk5Xh4FCS4FXgBRoqWJSanlqRlplTgpBm4uAEEVwgG3iANrziBirkLS5IzC3OTIcoOsWo
	KCXO+4cHKCEAksgozYMbAIvqV4ziQP8I84qC7OEBJgS47ldAg5mABm/a+xlkcEkiQkqqgdHp
	wN6ttk8XuGUvL9at+nmI6cG9x/7ZLQGv113Z/OetVSejSWjxC/2Nco2FVuv+W/JorPkTWKYn
	z7B1mrBBitFV4VyrF34fZ8x4dM3gsfaVxNt/+cO0f9qLvVWZFrZQbv3vcy82rNe+Gjin4dfa
	5NMvXvhyLUj/O8Pt+QIhT4YlE6cp2/BK33ZQYinOSDTUYi4qTgQAvdxVbsUCAAA= 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213615>

This removes the need for function imap_make_flags(), so delete it,
too.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 40 +++-------------------------------------
 1 file changed, 3 insertions(+), 37 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index e521e2f..f1c8f5a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -70,7 +70,6 @@ struct store {
 
 struct msg_data {
 	struct strbuf data;
-	unsigned char flags;
 };
 
 static const char imap_send_usage[] = "git imap-send < <mbox>";
@@ -225,14 +224,6 @@ static const char *cap_list[] = {
 static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd);
 
 
-static const char *Flags[] = {
-	"Draft",
-	"Flagged",
-	"Answered",
-	"Seen",
-	"Deleted",
-};
-
 #ifndef NO_OPENSSL
 static void ssl_socket_perror(const char *func)
 {
@@ -1246,23 +1237,6 @@ bail:
 	return NULL;
 }
 
-static int imap_make_flags(int flags, char *buf)
-{
-	const char *s;
-	unsigned i, d;
-
-	for (i = d = 0; i < ARRAY_SIZE(Flags); i++)
-		if (flags & (1 << i)) {
-			buf[d++] = ' ';
-			buf[d++] = '\\';
-			for (s = Flags[i]; *s; s++)
-				buf[d++] = *s;
-		}
-	buf[0] = '(';
-	buf[d++] = ')';
-	return d;
-}
-
 static void lf_to_crlf(struct strbuf *msg)
 {
 	size_t new_len;
@@ -1311,8 +1285,7 @@ static int imap_store_msg(struct store *gctx, struct msg_data *msg)
 	struct imap *imap = ctx->imap;
 	struct imap_cmd_cb cb;
 	const char *prefix, *box;
-	int ret, d;
-	char flagstr[128];
+	int ret;
 
 	lf_to_crlf(&msg->data);
 	memset(&cb, 0, sizeof(cb));
@@ -1320,17 +1293,10 @@ static int imap_store_msg(struct store *gctx, struct msg_data *msg)
 	cb.dlen = msg->data.len;
 	cb.data = strbuf_detach(&msg->data, NULL);
 
-	d = 0;
-	if (msg->flags) {
-		d = imap_make_flags(msg->flags, flagstr);
-		flagstr[d++] = ' ';
-	}
-	flagstr[d] = 0;
-
 	box = gctx->name;
 	prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
 	cb.create = 0;
-	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\" %s", prefix, box, flagstr);
+	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\" ", prefix, box);
 	imap->caps = imap->rcaps;
 	if (ret != DRV_OK)
 		return ret;
@@ -1483,7 +1449,7 @@ static int git_imap_config(const char *key, const char *val, void *cb)
 int main(int argc, char **argv)
 {
 	struct strbuf all_msgs = STRBUF_INIT;
-	struct msg_data msg = {STRBUF_INIT, 0};
+	struct msg_data msg = {STRBUF_INIT};
 	struct store *ctx = NULL;
 	int ofs = 0;
 	int r;
-- 
1.8.0.3
