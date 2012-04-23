From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/10] i18n: apply: update say_patch_name to give translators complete sentence
Date: Mon, 23 Apr 2012 19:30:28 +0700
Message-ID: <1335184230-8870-9-git-send-email-pclouds@gmail.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 14:35:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMIU8-0005sR-5A
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 14:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755380Ab2DWMfJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Apr 2012 08:35:09 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55597 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab2DWMfI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 08:35:08 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so3837007pbc.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 05:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cnlCekoA3REEce5HiqxcPDnMHmfLlEpEMU+u+uWewmA=;
        b=Qy5eKHBDqlI3Ed3qp2aQo0yJR6syd2XpWCLmmUVLIMbHx0yxAb3JiEUfL3s6Af7b9K
         cwE/HJftBp7HsM6j4fG6coaoMPuovZfiflL7LRrLuIfDaWzE9Wwu9a7Plg+0wYXL/sYe
         J7ogDS8S75rvDggcXjDBuvUxHhW7BRDbNBVqHvqfj/OQA7fzx5mZeGL68fUIg+0z19lx
         RntsjuPPElQC3oLy2oZFajpVDQhdjButgy723Meu8VOSL3WHS2nJOmj5PcxrMq16YMmP
         syUXZKD3xX1oMyxWjE3QVC2S9+MSVaBRTYshH25s1EG1Tv4JsPCrx3kel3vY+hn59Cl9
         u2CQ==
Received: by 10.68.222.134 with SMTP id qm6mr19910784pbc.14.1335184508283;
        Mon, 23 Apr 2012 05:35:08 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.59.47])
        by mx.google.com with ESMTPS id l1sm14291508pbs.34.2012.04.23.05.35.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Apr 2012 05:35:07 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 23 Apr 2012 19:31:51 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196122>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/apply.c |   32 ++++++++++++++++++++------------
 1 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 4bb6354..c768b7f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -335,22 +335,25 @@ static void clear_image(struct image *image)
 	image->len =3D 0;
 }
=20
-static void say_patch_name(FILE *output, const char *pre,
-			   struct patch *patch, const char *post)
+/* fmt must contain _one_ %s and no other substitution */
+static void say_patch_name(FILE *output, const char *fmt, struct patch=
 *patch)
 {
-	fputs(pre, output);
+	struct strbuf sb =3D STRBUF_INIT;
+
 	if (patch->old_name && patch->new_name &&
 	    strcmp(patch->old_name, patch->new_name)) {
-		quote_c_style(patch->old_name, NULL, output, 0);
-		fputs(" =3D> ", output);
-		quote_c_style(patch->new_name, NULL, output, 0);
+		quote_c_style(patch->old_name, &sb, NULL, 0);
+		strbuf_addstr(&sb, " =3D> ");
+		quote_c_style(patch->new_name, &sb, NULL, 0);
 	} else {
 		const char *n =3D patch->new_name;
 		if (!n)
 			n =3D patch->old_name;
-		quote_c_style(n, NULL, output, 0);
+		quote_c_style(n, &sb, NULL, 0);
 	}
-	fputs(post, output);
+	fprintf(output, fmt, sb.buf);
+	fputc('\n', output);
+	strbuf_release(&sb);
 }
=20
 #define CHUNKSIZE (8192)
@@ -3172,7 +3175,7 @@ static int check_patch_list(struct patch *patch)
 	while (patch) {
 		if (apply_verbosely)
 			say_patch_name(stderr,
-				       "Checking patch ", patch, "...\n");
+				       _("Checking patch %s..."), patch);
 		err |=3D check_patch(patch);
 		patch =3D patch->next;
 	}
@@ -3536,6 +3539,7 @@ static int write_out_one_reject(struct patch *pat=
ch)
 	char namebuf[PATH_MAX];
 	struct fragment *frag;
 	int cnt =3D 0;
+	struct strbuf sb =3D STRBUF_INIT;
=20
 	for (cnt =3D 0, frag =3D patch->fragments; frag; frag =3D frag->next)=
 {
 		if (!frag->rejected)
@@ -3546,7 +3550,7 @@ static int write_out_one_reject(struct patch *pat=
ch)
 	if (!cnt) {
 		if (apply_verbosely)
 			say_patch_name(stderr,
-				       "Applied patch ", patch, " cleanly.\n");
+				       _("Applied patch %s cleanly."), patch);
 		return 0;
 	}
=20
@@ -3557,8 +3561,12 @@ static int write_out_one_reject(struct patch *pa=
tch)
 		die(_("internal error"));
=20
 	/* Say this even without --verbose */
-	say_patch_name(stderr, "Applying patch ", patch, " with");
-	fprintf(stderr, " %d rejects...\n", cnt);
+	strbuf_addf(&sb, Q_("Applying patch %%s with %d reject...",
+			    "Applying patch %%s with %d rejects...",
+			    cnt),
+		    cnt);
+	say_patch_name(stderr, sb.buf, patch);
+	strbuf_release(&sb);
=20
 	cnt =3D strlen(patch->new_name);
 	if (ARRAY_SIZE(namebuf) <=3D cnt + 5) {
--=20
1.7.8.36.g69ee2
