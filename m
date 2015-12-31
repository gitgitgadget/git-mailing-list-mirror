From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/7] diff.c: add new arguments to emit_line_0()
Date: Thu, 31 Dec 2015 19:37:36 +0700
Message-ID: <1451565457-18756-7-git-send-email-pclouds@gmail.com>
References: <1451565457-18756-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 31 13:38:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEcUs-0001gB-Pb
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 13:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbbLaMiW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Dec 2015 07:38:22 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:32961 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbbLaMiU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2015 07:38:20 -0500
Received: by mail-pf0-f176.google.com with SMTP id q63so119901649pfb.0
        for <git@vger.kernel.org>; Thu, 31 Dec 2015 04:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NMsEir3+G0dR7whST0pRWhySdr1MHPqqHFsiNzu9Qvw=;
        b=Hepfj0ijDrolHkLKMImO4xpaAnWRUQN+/Zsw462A86wKxTZ6KvhRU3Zo7t+XZ5qgvC
         0iU1P4/h4thanycLduhBwIqOs/yGRVVcucrzbnr39y7kM4c36k4KW+ZDd4LC6iEZY+L4
         uEQd26ZAjJSxYZQJKSSmjUY4tJsY8nFuTwymor4NE6ltSvPA6NMbMuYWeYys489jGgIB
         icVN0n3x3FciKRYWNMfY4Z5lMrN6BQ3M/iXIact7zQSUtsbDr/tqVI53sISdEpKO7w7n
         baACqYcNnA+Np8Uaz4BtJ4pMc/mqrQCkq8DofaaJ+pwxDeVO7PxR+i3iyc1QPICd8kXa
         Hbsw==
X-Received: by 10.98.42.75 with SMTP id q72mr102417241pfq.10.1451565500453;
        Thu, 31 Dec 2015 04:38:20 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id 7sm96737432pfb.62.2015.12.31.04.38.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Dec 2015 04:38:18 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 31 Dec 2015 19:38:17 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451565457-18756-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283242>

This patch is no-op, to reduce noise in the next one.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index 3b7317e..47d22e3 100644
--- a/diff.c
+++ b/diff.c
@@ -458,7 +458,9 @@ struct tagged_pointer {
 };
=20
 static void emit_line_0(struct diff_options *o, const char *set, const=
 char *reset,
-			int first, const char *line, int len)
+			int first, const char *line, int len,
+			struct tagged_pointer *begin,
+			struct tagged_pointer *end)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
 	int nofirst;
@@ -497,7 +499,7 @@ static void emit_line_0(struct diff_options *o, con=
st char *set, const char *res
 static void emit_line(struct diff_options *o, const char *set, const c=
har *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, reset, line[0], line+1, len-1);
+	emit_line_0(o, set, reset, line[0], line+1, len-1, NULL, NULL);
 }
=20
 static int new_blank_line_at_eof(struct emit_callback *ecbdata, const =
char *line, int len)
@@ -516,7 +518,9 @@ static void emit_line_checked(const char *reset,
 			      const char *line, int len,
 			      enum color_diff color,
 			      unsigned ws_error_highlight,
-			      char sign)
+			      char sign,
+			      struct tagged_pointer *begin,
+			      struct tagged_pointer *end)
 {
 	const char *set =3D diff_get_color(ecbdata->color_diff, color);
 	const char *ws =3D NULL;
@@ -528,13 +532,16 @@ static void emit_line_checked(const char *reset,
 	}
=20
 	if (!ws)
-		emit_line_0(ecbdata->opt, set, reset, sign, line, len);
+		emit_line_0(ecbdata->opt, set, reset, sign,
+			    line, len, begin, end);
 	else if (sign =3D=3D '+' && new_blank_line_at_eof(ecbdata, line, len)=
)
 		/* Blank line at EOF - paint '+' as well */
-		emit_line_0(ecbdata->opt, ws, reset, sign, line, len);
+		emit_line_0(ecbdata->opt, ws, reset, sign,
+			    line, len, begin, end);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(ecbdata->opt, set, reset, sign, "", 0);
+		emit_line_0(ecbdata->opt, set, reset, sign,
+			    "", 0, NULL, NULL);
 		ws_check_emit(line, len, ecbdata->ws_rule,
 			      ecbdata->opt->file, set, reset, ws);
 	}
@@ -545,7 +552,8 @@ static void emit_add_line(const char *reset,
 			  const char *line, int len)
 {
 	emit_line_checked(reset, ecbdata, line, len,
-			  DIFF_FILE_NEW, WSEH_NEW, '+');
+			  DIFF_FILE_NEW, WSEH_NEW, '+',
+			  NULL, NULL);
 }
=20
 static void emit_del_line(const char *reset,
@@ -553,7 +561,8 @@ static void emit_del_line(const char *reset,
 			  const char *line, int len)
 {
 	emit_line_checked(reset, ecbdata, line, len,
-			  DIFF_FILE_OLD, WSEH_OLD, '-');
+			  DIFF_FILE_OLD, WSEH_OLD, '-',
+			  NULL, NULL);
 }
=20
 static void emit_context_line(const char *reset,
@@ -561,7 +570,8 @@ static void emit_context_line(const char *reset,
 			      const char *line, int len)
 {
 	emit_line_checked(reset, ecbdata, line, len,
-			  DIFF_CONTEXT, WSEH_CONTEXT, ' ');
+			  DIFF_CONTEXT, WSEH_CONTEXT, ' ',
+			  NULL, NULL);
 }
=20
 static void emit_hunk_header(struct emit_callback *ecbdata,
@@ -682,7 +692,7 @@ static void emit_rewrite_lines(struct emit_callback=
 *ecb,
 						     DIFF_CONTEXT);
 		putc('\n', ecb->opt->file);
 		emit_line_0(ecb->opt, context, reset, '\\',
-			    nneof, strlen(nneof));
+			    nneof, strlen(nneof), NULL, NULL);
 	}
 }
=20
@@ -1301,7 +1311,8 @@ static void diff_words_flush_unified(struct emit_=
callback *ecb,
 		assert(end_line->tag =3D=3D TAG_END_LINE);
 		emit_line_checked(reset, ecb, begin_line->str,
 				  end_line->str - begin_line->str,
-				  color, ws_error_highlight, sign);
+				  color, ws_error_highlight, sign,
+				  NULL, NULL);
 	}
 	b->mark_nr =3D 0;
 }
--=20
2.3.0.rc1.137.g477eb31
