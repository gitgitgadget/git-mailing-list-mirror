From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/6] merge-recursive: remove i18n legos in conflict messages
Date: Thu, 31 May 2012 20:04:39 +0700
Message-ID: <1338469482-30936-4-git-send-email-pclouds@gmail.com>
References: <1338463242-10618-1-git-send-email-worldhello.net@gmail.com>
 <1338469482-30936-1-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Thu May 31 15:09:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa58B-000737-S9
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 15:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758012Ab2EaNJb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 09:09:31 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54297 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757872Ab2EaNJa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 09:09:30 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so1271684dad.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bC8drXp1Ju+YUfY+4CJgEGlEtukjaIKHWr92p0kG+lM=;
        b=gluyNhDf+Gf32jZ9xcJR7tjVWs3gjM9mphA+ctJdOmuMcCOCLh5oXtN96cN1V0+IbD
         yvk8LzoTh2p+wti8fAOL2cvLkFsoriLfcnvBM4ykCb8NxzIStbR4C5WR3vZjw1R0bPSF
         iUxR6zLk9hL8mOhp3RgmQQvIzPmaDmZxtP+jdUADfPv07umQDSdgcOIexSzJpVIchJqW
         Ziy7o1CvHdog8wloK3Jka6Mq/nIfEutPbjtrvA/hEmodN3QWuoOX7XBwR/ICBTxaD7py
         kY2bv2Gv6iG0imADcM+YdsDcBFzY6reqXmEPLLT52plV6JNvOyfTd9u2Z/9d7zH5GwRO
         bsSA==
Received: by 10.68.132.34 with SMTP id or2mr6969363pbb.118.1338469769939;
        Thu, 31 May 2012 06:09:29 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.14])
        by mx.google.com with ESMTPS id gj8sm4144138pbc.39.2012.05.31.06.09.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 06:09:29 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 31 May 2012 20:05:15 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338469482-30936-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198891>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 merge-recursive.c | 49 +++++++++++++++++++++++++++++++++--------------=
--
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 680937c..1cc6360 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1018,9 +1018,27 @@ static void handle_change_delete(struct merge_op=
tions *o,
 				 const unsigned char *o_sha, int o_mode,
 				 const unsigned char *a_sha, int a_mode,
 				 const unsigned char *b_sha, int b_mode,
-				 const char *change, const char *change_past)
+				 const char *change)
 {
 	char *renamed =3D NULL;
+	int idx;
+
+	const char *msg[] =3D {
+		"CONFLICT (rename/delete): %s deleted in %s and renamed in %s. Versi=
on %s of %s left in tree.",
+		"CONFLICT (modify/delete): %s deleted in %s and modified in %s. Vers=
ion %s of %s left in tree.",
+	};
+	const char *renamed_msg[] =3D {
+		"CONFLICT (rename/delete): %s deleted in %s and renamed in %s. Versi=
on %s of %s left in tree at %s.",
+		"CONFLICT (modify/delete): %s deleted in %s and modified in %s. Vers=
ion %s of %s left in tree at %s.",
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
@@ -1034,22 +1052,21 @@ static void handle_change_delete(struct merge_o=
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
+		if (renamed)
+			output(o, 1, renamed_msg[idx], path, o->branch1,
+			       o->branch2, o->branch2, path, renamed);
+		else
+			output(o, 1, msg[idx], path, o->branch1,
+			       o->branch2, o->branch2, path);
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
+			output(o, 1, renamed_msg[idx], path, o->branch2,
+			       o->branch1, o->branch1, path, renamed);
 			update_file(o, 0, a_sha, a_mode, renamed);
+		} else
+			output(o, 1, msg[idx], path, o->branch2,
+			       o->branch1, o->branch1, path);
 		/*
 		 * No need to call update_file() on path when !renamed, since
 		 * that would needlessly touch path.  We could call
@@ -1085,7 +1102,7 @@ static void conflict_rename_delete(struct merge_o=
ptions *o,
 			     orig->sha1, orig->mode,
 			     a_sha, a_mode,
 			     b_sha, b_mode,
-			     "rename", "renamed");
+			     "rename");
=20
 	if (o->call_depth) {
 		remove_file_from_cache(dest->path);
@@ -1568,7 +1585,7 @@ static void handle_modify_delete(struct merge_opt=
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
1.7.10.2.549.g9354186
