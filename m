From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 10/11] format-patch: update append_signoff prototype
Date: Sun, 25 Nov 2012 17:45:58 -0800
Message-ID: <1353894359-6733-11-git-send-email-drafnel@gmail.com>
References: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 02:48:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcnoO-0007zF-UM
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 02:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874Ab2KZBs0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2012 20:48:26 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:57052 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846Ab2KZBsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 20:48:25 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so3474331dak.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 17:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=07NA/8768djVpj/TsguH0oZcuoTZxx0cjswQ+8HA1jo=;
        b=YhlnuZxbssfUYa+2uGct5n+yC0hUlMPs/WHcz1HOyXaV809leYvmjC/aaLfMWbiUU7
         1drWqrxI8e3aEKm9AKwxBFIurB5c+swBZwhUAeLmXJwTk6+D2h+fbj+X7LiFP6dUAZtH
         +EljjSSaheEGS9OcCsZ2TQ4ju3n1f9qUJqaLWPgwya8HP7I0vmFKAe4Vuo5DnyCfSLWA
         bgYV7/BM7fcMavrRNCZj54XS/rtuFf39CHI0i5egwzKXOF0/dJrkX5/Jl7JiPJgFRfCk
         Z6VA3o8Uf4sJYXU7kQJfe1xtpEcEsx0IqHo/YnqEbZ3EOT1d9BUVqWsG6wC3YAL4SDif
         hLyQ==
Received: by 10.68.138.229 with SMTP id qt5mr32580835pbb.122.1353894505261;
        Sun, 25 Nov 2012 17:48:25 -0800 (PST)
Received: from charliebrown.sbx05686.santaca.wayport.net (dhcp64-134-221-228.hoic.dca.wayport.net. [64.134.221.228])
        by mx.google.com with ESMTPS id ot5sm7828428pbb.29.2012.11.25.17.48.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Nov 2012 17:48:24 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210400>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

This is a preparation step for merging with append_signoff from
sequencer.c

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 builtin/log.c | 13 +------------
 log-tree.c    | 21 +++++++++++++--------
 revision.h    |  2 +-
 3 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index e7b7db1..bb48344 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1058,7 +1058,6 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
 	struct commit *origin =3D NULL, *head =3D NULL;
 	const char *in_reply_to =3D NULL;
 	struct patch_ids ids;
-	char *add_signoff =3D NULL;
 	struct strbuf buf =3D STRBUF_INIT;
 	int use_patch_format =3D 0;
 	int quiet =3D 0;
@@ -1154,16 +1153,6 @@ int cmd_format_patch(int argc, const char **argv=
, const char *prefix)
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
 			     PARSE_OPT_KEEP_DASHDASH);
=20
-	if (do_signoff) {
-		const char *committer;
-		const char *endpos;
-		committer =3D git_committer_info(IDENT_STRICT);
-		endpos =3D strchr(committer, '>');
-		if (!endpos)
-			die(_("bogus committer info %s"), committer);
-		add_signoff =3D xmemdupz(committer, endpos - committer + 1);
-	}
-
 	for (i =3D 0; i < extra_hdr.nr; i++) {
 		strbuf_addstr(&buf, extra_hdr.items[i].string);
 		strbuf_addch(&buf, '\n');
@@ -1354,7 +1343,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
 		total++;
 		start_number--;
 	}
-	rev.add_signoff =3D add_signoff;
+	rev.add_signoff =3D do_signoff;
 	while (0 <=3D --nr) {
 		int shown;
 		commit =3D list[nr];
diff --git a/log-tree.c b/log-tree.c
index 14ebf69..be8e7ab 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -253,9 +253,11 @@ static int detect_any_signoff(char *letter, int si=
ze)
 	return seen_head && seen_name;
 }
=20
-static void append_signoff(struct strbuf *sb, const char *signoff)
+static void append_signoff(struct strbuf *sb, int flags)
 {
-	static const char signed_off_by[] =3D "Signed-off-by: ";
+	char* signoff =3D xstrdup(fmt_name(getenv("GIT_COMMITTER_NAME"),
+					 getenv("GIT_COMMITTER_EMAIL")));
+	static const char sign_off_header[] =3D "Signed-off-by: ";
 	size_t signoff_len =3D strlen(signoff);
 	int has_signoff =3D 0;
 	char *cp;
@@ -274,9 +276,9 @@ static void append_signoff(struct strbuf *sb, const=
 char *signoff)
 	}
=20
 	/* First see if we already have the sign-off by the signer */
-	while ((cp =3D strstr(cp, signed_off_by))) {
+	while ((cp =3D strstr(cp, sign_off_header))) {
 		const char *s =3D cp;
-		cp +=3D strlen(signed_off_by);
+		cp +=3D strlen(sign_off_header);
=20
 		if (!has_signoff && s > sb->buf) {
 			/*
@@ -317,9 +319,10 @@ static void append_signoff(struct strbuf *sb, cons=
t char *signoff)
 	if (!has_signoff)
 		strbuf_addch(sb, '\n');
=20
-	strbuf_addstr(sb, signed_off_by);
+	strbuf_addstr(sb, sign_off_header);
 	strbuf_add(sb, signoff, signoff_len);
 	strbuf_addch(sb, '\n');
+	free(signoff);
 }
=20
 static unsigned int digits_in_number(unsigned int number)
@@ -695,8 +698,10 @@ void show_log(struct rev_info *opt)
 	/*
 	 * And then the pretty-printed message itself
 	 */
-	if (ctx.need_8bit_cte >=3D 0)
-		ctx.need_8bit_cte =3D has_non_ascii(opt->add_signoff);
+	if (ctx.need_8bit_cte >=3D 0 && opt->add_signoff)
+		ctx.need_8bit_cte =3D
+			has_non_ascii(fmt_name(getenv("GIT_COMMITTER_NAME"),
+					       getenv("GIT_COMMITTER_EMAIL")));
 	ctx.date_mode =3D opt->date_mode;
 	ctx.date_mode_explicit =3D opt->date_mode_explicit;
 	ctx.abbrev =3D opt->diffopt.abbrev;
@@ -707,7 +712,7 @@ void show_log(struct rev_info *opt)
 	pretty_print_commit(&ctx, commit, &msgbuf);
=20
 	if (opt->add_signoff)
-		append_signoff(&msgbuf, opt->add_signoff);
+		append_signoff(&msgbuf, 0);
=20
 	if ((ctx.fmt !=3D CMIT_FMT_USERFORMAT) &&
 	    ctx.notes_message && *ctx.notes_message) {
diff --git a/revision.h b/revision.h
index 059bfff..435a60b 100644
--- a/revision.h
+++ b/revision.h
@@ -137,7 +137,7 @@ struct rev_info {
 	int		numbered_files;
 	char		*message_id;
 	struct string_list *ref_message_ids;
-	const char	*add_signoff;
+	int              add_signoff;
 	const char	*extra_headers;
 	const char	*log_reencode;
 	const char	*subject_prefix;
--=20
1.8.0.284.g959048a
