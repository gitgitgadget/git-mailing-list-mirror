From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/14] imap-send.c: remove namespace fields from struct imap
Date: Mon, 14 Jan 2013 06:32:41 +0100
Message-ID: <1358141566-26081-10-git-send-email-mhagger@alum.mit.edu>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 06:41:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tucnu-0005p0-MV
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 06:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883Ab3ANFl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 00:41:29 -0500
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:55724 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751098Ab3ANFl2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 00:41:28 -0500
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jan 2013 00:41:28 EST
X-AuditID: 12074414-b7f9b6d0000008b3-02-50f398c04f5b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 19.31.02227.0C893F05; Mon, 14 Jan 2013 00:33:52 -0500 (EST)
Received: from michael.fritz.box (p57A25AA5.dip.t-dialin.net [87.162.90.165])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0E5Wt2q026427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Jan 2013 00:33:51 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqHtgxucAgw0L1S26rnQzWTT0XmG2
	uL1iPrPFj5YeZgcWj7/vPzB5POvdw+hx8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGcsaH7EW
	9CtULDx8kK2B8YBEFyMnh4SAiUTTmpfMELaYxIV769lAbCGBy4wSj+YqdDFyAdlnmSR2bH/F
	CpJgE9CVWNTTzARiiwioSUxsO8QCYjMLpEh0PO9mBLGFBXwkfs3/A1bDIqAqMeX5W7ChvAKu
	Es9XvGCEWKYg8XrnJbCZnEDx7x9PMUMsdpF4eKqZbQIj7wJGhlWMcok5pbm6uYmZOcWpybrF
	yYl5ealFuhZ6uZkleqkppZsYIeEjsoPxyEm5Q4wCHIxKPLybSz4HCLEmlhVX5h5ilORgUhLl
	De8HCvEl5adUZiQWZ8QXleakFh9ilOBgVhLhDa0DyvGmJFZWpRblw6SkOViUxHm/LVb3ExJI
	TyxJzU5NLUgtgsnKcHAoSfCGTgdqFCxKTU+tSMvMKUFIM3FwgggukA08QBtqQAp5iwsSc4sz
	0yGKTjEqSonzpoIkBEASGaV5cANgkf6KURzoH2HeJpAqHmCSgOt+BTSYCWjw2QvvQQaXJCKk
	pBoY+XM6m/hUpz3vbIrlqV5/f7f+70PHGPdYXsjaoHdu/WOXl6l5vncN9xxfsm/7Nsfuif3c
	rlw/giLeKTyUUg77F/Tz7jGe6VEe66flzfM9c3SK7EveqRf/vPJONdrRXyqh7mJvXrJ47YLz
	z97ekbj54Ww6o8nuBbr6k+5oimwP2RAsw5DyybBUTomlOCPRUIu5qDgRAPPREWLP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213446>

They are unused, and their removal means that a bunch of list-related
infrastructure can be disposed of.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 74 +++++++------------------------------------------------------
 1 file changed, 8 insertions(+), 66 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 5238c74..9616e80 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -99,15 +99,6 @@ static struct imap_server_conf server = {
 	NULL,	/* auth_method */
 };
 
-#define NIL	(void *)0x1
-#define LIST	(void *)0x2
-
-struct imap_list {
-	struct imap_list *next, *child;
-	char *val;
-	int len;
-};
-
 struct imap_socket {
 	int fd[2];
 	SSL *ssl;
@@ -124,7 +115,6 @@ struct imap_cmd;
 
 struct imap {
 	int uidnext; /* from SELECT responses */
-	struct imap_list *ns_personal, *ns_other, *ns_shared; /* NAMESPACE info */
 	unsigned caps, rcaps; /* CAPABILITY results */
 	/* command queue */
 	int nexttag, num_in_progress, literal_pending;
@@ -554,34 +544,9 @@ static int imap_exec_m(struct imap_store *ctx, struct imap_cmd_cb *cb,
 	}
 }
 
-static int is_atom(struct imap_list *list)
-{
-	return list && list->val && list->val != NIL && list->val != LIST;
-}
-
-static int is_list(struct imap_list *list)
-{
-	return list && list->val == LIST;
-}
-
-static void free_list(struct imap_list *list)
-{
-	struct imap_list *tmp;
-
-	for (; list; list = tmp) {
-		tmp = list->next;
-		if (is_list(list))
-			free_list(list->child);
-		else if (is_atom(list))
-			free(list->val);
-		free(list);
-	}
-}
-
-static int parse_imap_list_l(char **sp, struct imap_list **curp, int level)
+static int skip_imap_list_l(char **sp, int level)
 {
-	struct imap_list *cur;
-	char *s = *sp, *p;
+	char *s = *sp;
 
 	for (;;) {
 		while (isspace((unsigned char)*s))
@@ -590,36 +555,23 @@ static int parse_imap_list_l(char **sp, struct imap_list **curp, int level)
 			s++;
 			break;
 		}
-		*curp = cur = xmalloc(sizeof(*cur));
-		curp = &cur->next;
-		cur->val = NULL; /* for clean bail */
 		if (*s == '(') {
 			/* sublist */
 			s++;
-			cur->val = LIST;
-			if (parse_imap_list_l(&s, &cur->child, level + 1))
+			if (skip_imap_list_l(&s, level + 1))
 				goto bail;
 		} else if (*s == '"') {
 			/* quoted string */
 			s++;
-			p = s;
 			for (; *s != '"'; s++)
 				if (!*s)
 					goto bail;
-			cur->len = s - p;
 			s++;
-			cur->val = xmemdupz(p, cur->len);
 		} else {
 			/* atom */
-			p = s;
 			for (; *s && !isspace((unsigned char)*s); s++)
 				if (level && *s == ')')
 					break;
-			cur->len = s - p;
-			if (cur->len == 3 && !memcmp("NIL", p, 3))
-				cur->val = NIL;
-			else
-				cur->val = xmemdupz(p, cur->len);
 		}
 
 		if (!level)
@@ -628,22 +580,15 @@ static int parse_imap_list_l(char **sp, struct imap_list **curp, int level)
 			goto bail;
 	}
 	*sp = s;
-	*curp = NULL;
 	return 0;
 
 bail:
-	*curp = NULL;
 	return -1;
 }
 
-static struct imap_list *parse_list(char **sp)
+static void skip_list(char **sp)
 {
-	struct imap_list *head;
-
-	if (!parse_imap_list_l(sp, &head, 0))
-		return head;
-	free_list(head);
-	return NULL;
+	skip_imap_list_l(sp, 0);
 }
 
 static void parse_capability(struct imap *imap, char *cmd)
@@ -722,9 +667,9 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 			}
 
 			if (!strcmp("NAMESPACE", arg)) {
-				imap->ns_personal = parse_list(&cmd);
-				imap->ns_other = parse_list(&cmd);
-				imap->ns_shared = parse_list(&cmd);
+				skip_list(&cmd);
+				skip_list(&cmd);
+				skip_list(&cmd);
 			} else if (!strcmp("OK", arg) || !strcmp("BAD", arg) ||
 				   !strcmp("NO", arg) || !strcmp("BYE", arg)) {
 				if ((resp = parse_response_code(ctx, NULL, cmd)) != RESP_OK)
@@ -834,9 +779,6 @@ static void imap_close_server(struct imap_store *ictx)
 		imap_exec(ictx, NULL, "LOGOUT");
 		socket_shutdown(&imap->buf.sock);
 	}
-	free_list(imap->ns_personal);
-	free_list(imap->ns_other);
-	free_list(imap->ns_shared);
 	free(imap);
 }
 
-- 
1.8.0.3
