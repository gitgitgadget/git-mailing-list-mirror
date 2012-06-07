From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/6] merge-recursive: remove i18n legos in conflict messages
Date: Thu,  7 Jun 2012 19:05:12 +0700
Message-ID: <1339070715-31417-3-git-send-email-pclouds@gmail.com>
References: <0001-Remove-i18n-legos-in-notifying-new-branch-tracking-s.patch>
 <1339070715-31417-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 14:10:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScbXY-0000rV-Bx
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 14:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466Ab2FGMKE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 08:10:04 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35289 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294Ab2FGMKC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 08:10:02 -0400
Received: by dady13 with SMTP id y13so787685dad.19
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 05:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uUJwODMsyTn6NMJF7z+1eE2j8U4w9lCpYDArlFkRZlw=;
        b=V7RJDPtCvImBM7efYZM+NgudD9JOIYCcAHUtqpiucsROoEjtIMXSgBBEiREW07j9+b
         58RBjRm0I8y1eHaIVsH0QKJZuVXOkMBZ9XsIk+wb1fcGSTgblKiL/ekEoshNWXqYh0vF
         5FxKyJH2BVcRxEehEJN8umX+HfYrqsKxqo53DS3c7h109XbMNB9DIkvN5YaQrG25iWGE
         zkfaj9a/eSCpOYyjSGadRvxSfeXySaLspLKX/lDhA17QcTOX6oBBR3FyNXBBwy/zHC1f
         poIMv+IRmJ5gmFvlYmqbKEoXi8p80/040+iyJkilaRs5QwqsNjkj18tLOd190xdT+/sH
         WXmg==
Received: by 10.68.232.103 with SMTP id tn7mr8246556pbc.86.1339071002171;
        Thu, 07 Jun 2012 05:10:02 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.55.113])
        by mx.google.com with ESMTPS id iu6sm3926906pbc.35.2012.06.07.05.09.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jun 2012 05:10:01 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 07 Jun 2012 19:05:43 +0700
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1339070715-31417-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199397>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 The two sentence strings are broken down to one sentence each. Less wo=
rk for
 translators when these are marked i18n.

 merge-recursive.c |   60 ++++++++++++++++++++++++++++++++++++++-------=
-------
 1 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 680937c..1f16e04 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1018,9 +1018,28 @@ static void handle_change_delete(struct merge_op=
tions *o,
 				 const unsigned char *o_sha, int o_mode,
 				 const unsigned char *a_sha, int a_mode,
 				 const unsigned char *b_sha, int b_mode,
-				 const char *change, const char *change_past)
+				 const char *change)
 {
 	char *renamed =3D NULL;
+	struct strbuf sb =3D STRBUF_INIT;
+	int idx;
+
+	const char *msg[] =3D {
+		"CONFLICT (rename/delete): %s deleted in %s and renamed in %s.",
+		"CONFLICT (modify/delete): %s deleted in %s and modified in %s.",
+	};
+	const char *renamed_msg[] =3D {
+		"CONFLICT (rename/delete): %s deleted in %s and renamed in %s.",
+		"CONFLICT (modify/delete): %s deleted in %s and modified in %s.",
+	};
+
+	if (!strcmp(change, "rename"))
+		idx =3D 0;
+	else if (!strcmp(change, "modify"))
+		idx =3D 1;
+	else
+		die("BUG: unsupport action %s", change);
+
 	if (dir_in_way(path, !o->call_depth)) {
 		renamed =3D unique_path(o, path, a_sha ? o->branch1 : o->branch2);
 	}
@@ -1034,22 +1053,30 @@ static void handle_change_delete(struct merge_o=
ptions *o,
 		remove_file_from_cache(path);
 		update_file(o, 0, o_sha, o_mode, renamed ? renamed : path);
 	} else if (!a_sha) {
-		output(o, 1, "CONFLICT (%s/delete): %s deleted in %s "
-		       "and %s in %s. Version %s of %s left in tree%s%s.",
-		       change, path, o->branch1,
-		       change_past, o->branch2, o->branch2, path,
-		       NULL =3D=3D renamed ? "" : " at ",
-		       NULL =3D=3D renamed ? "" : renamed);
+		if (renamed) {
+			strbuf_addf(&sb, renamed_msg[idx], path, o->branch1, o->branch2);
+			strbuf_addf(&sb, " Version %s of %s left in tree at %s.",
+				    o->branch2, path, renamed);
+		} else {
+			strbuf_addf(&sb, msg[idx], path, o->branch1, o->branch2);
+			strbuf_addf(&sb, " Version %s of %s left in tree.",
+				    o->branch2, path);
+		}
+		output(o, 1, "%s", sb.buf);
+
 		update_file(o, 0, b_sha, b_mode, renamed ? renamed : path);
 	} else {
-		output(o, 1, "CONFLICT (%s/delete): %s deleted in %s "
-		       "and %s in %s. Version %s of %s left in tree%s%s.",
-		       change, path, o->branch2,
-		       change_past, o->branch1, o->branch1, path,
-		       NULL =3D=3D renamed ? "" : " at ",
-		       NULL =3D=3D renamed ? "" : renamed);
-		if (renamed)
+		if (renamed) {
+			strbuf_addf(&sb, renamed_msg[idx], path, o->branch2, o->branch1);
+			strbuf_addf(&sb, " Version %s of %s left in tree at %s.",
+				    o->branch2, path, renamed);
 			update_file(o, 0, a_sha, a_mode, renamed);
+		} else {
+			strbuf_addf(&sb, msg[idx], path, o->branch2, o->branch1);
+			strbuf_addf(&sb, " Version %s of %s left in tree.",
+				    o->branch2, path);
+		}
+		output(o, 1, "%s", sb.buf);
 		/*
 		 * No need to call update_file() on path when !renamed, since
 		 * that would needlessly touch path.  We could call
@@ -1058,6 +1085,7 @@ static void handle_change_delete(struct merge_opt=
ions *o,
 		 */
 	}
 	free(renamed);
+	strbuf_release(&sb);
 }
=20
 static void conflict_rename_delete(struct merge_options *o,
@@ -1085,7 +1113,7 @@ static void conflict_rename_delete(struct merge_o=
ptions *o,
 			     orig->sha1, orig->mode,
 			     a_sha, a_mode,
 			     b_sha, b_mode,
-			     "rename", "renamed");
+			     "rename");
=20
 	if (o->call_depth) {
 		remove_file_from_cache(dest->path);
@@ -1568,7 +1596,7 @@ static void handle_modify_delete(struct merge_opt=
ions *o,
 			     o_sha, o_mode,
 			     a_sha, a_mode,
 			     b_sha, b_mode,
-			     "modify", "modified");
+			     "modify");
 }
=20
 static int merge_content(struct merge_options *o,
--=20
1.7.8
