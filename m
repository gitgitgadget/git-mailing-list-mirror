From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2 09/10] format-patch: update append_signoff prototype
Date: Mon, 21 Jan 2013 00:40:26 -0800
Message-ID: <1358757627-16682-10-git-send-email-drafnel@gmail.com>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <bcasey@nvidia.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 21 09:41:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxCwg-000346-57
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 09:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111Ab3AUIlM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2013 03:41:12 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:64860 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461Ab3AUIlB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 03:41:01 -0500
Received: by mail-da0-f51.google.com with SMTP id i30so2619652dad.10
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 00:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=H9cFwC3bdD3G2GfIUWr359qYNvCWs6FfaFqVhMyh4ro=;
        b=GilJm4U4Z7uPtmsaBru9Bbtwm7npi0YZQjZZDEzKXnMGGNZtiv/STQS4gjzcI4JRv/
         MtmswRD2vVy0+0W+mn5gLRQ7Srg6McjgogapwTRhj+CB88C1HWvoYmvbOw7PMWVG59XN
         UzOxRuhdzUSj1ux5zzZh3SOhzVHRlcVn/s7T1VjCAQkllivbDiW+AILITFp9FnlOa7TL
         iciu7q+hbAlowdrGeSxvHAkcdAuc3FK68k3kz5lih8QBXnmBqElbIhTW0xSDEfxj6Zp4
         wYIsAGbsMmdnX7tp5W7GD+C5lgrLvQUnNlK014MTEgotzS0WA+SN1dK7yMDeeZG0V7b4
         eVEw==
X-Received: by 10.66.78.100 with SMTP id a4mr45500159pax.4.1358757660636;
        Mon, 21 Jan 2013 00:41:00 -0800 (PST)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-42-122.hsd1.ca.comcast.net. [98.248.42.122])
        by mx.google.com with ESMTPS id x2sm8883757paw.8.2013.01.21.00.40.59
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jan 2013 00:41:00 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
In-Reply-To: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214104>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

This is a preparation step for merging with append_signoff from
sequencer.c

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 builtin/log.c | 13 +------------
 log-tree.c    | 14 ++++++++++----
 revision.h    |  2 +-
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 8f0b2e8..59de484 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1086,7 +1086,6 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
 	struct commit *origin =3D NULL, *head =3D NULL;
 	const char *in_reply_to =3D NULL;
 	struct patch_ids ids;
-	char *add_signoff =3D NULL;
 	struct strbuf buf =3D STRBUF_INIT;
 	int use_patch_format =3D 0;
 	int quiet =3D 0;
@@ -1193,16 +1192,6 @@ int cmd_format_patch(int argc, const char **argv=
, const char *prefix)
 		rev.subject_prefix =3D strbuf_detach(&sprefix, NULL);
 	}
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
@@ -1393,7 +1382,7 @@ int cmd_format_patch(int argc, const char **argv,=
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
index 5dc45c4..83f33f4 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -253,9 +253,11 @@ static int detect_any_signoff(char *letter, int si=
ze)
 	return seen_head && seen_name;
 }
=20
-static void append_signoff(struct strbuf *sb, const char *signoff)
+static void append_signoff(struct strbuf *sb, int ignore_footer, int n=
o_dup_sob)
 {
 	static const char signed_off_by[] =3D "Signed-off-by: ";
+	char *signoff =3D xstrdup(fmt_name(getenv("GIT_COMMITTER_NAME"),
+					       getenv("GIT_COMMITTER_EMAIL")));
 	size_t signoff_len =3D strlen(signoff);
 	int has_signoff =3D 0;
 	char *cp;
@@ -275,6 +277,7 @@ static void append_signoff(struct strbuf *sb, const=
 char *signoff)
 		if (!isspace(cp[signoff_len]))
 			continue;
 		/* we already have him */
+		free(signoff);
 		return;
 	}
=20
@@ -287,6 +290,7 @@ static void append_signoff(struct strbuf *sb, const=
 char *signoff)
 	strbuf_addstr(sb, signed_off_by);
 	strbuf_add(sb, signoff, signoff_len);
 	strbuf_addch(sb, '\n');
+	free(signoff);
 }
=20
 static unsigned int digits_in_number(unsigned int number)
@@ -672,8 +676,10 @@ void show_log(struct rev_info *opt)
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
@@ -686,7 +692,7 @@ void show_log(struct rev_info *opt)
 	pretty_print_commit(&ctx, commit, &msgbuf);
=20
 	if (opt->add_signoff)
-		append_signoff(&msgbuf, opt->add_signoff);
+		append_signoff(&msgbuf, 0, 1);
=20
 	if ((ctx.fmt !=3D CMIT_FMT_USERFORMAT) &&
 	    ctx.notes_message && *ctx.notes_message) {
diff --git a/revision.h b/revision.h
index 5da09ee..01bd2b7 100644
--- a/revision.h
+++ b/revision.h
@@ -138,7 +138,7 @@ struct rev_info {
 	int		reroll_count;
 	char		*message_id;
 	struct string_list *ref_message_ids;
-	const char	*add_signoff;
+	int		add_signoff;
 	const char	*extra_headers;
 	const char	*log_reencode;
 	const char	*subject_prefix;
--=20
1.8.1.1.252.gdb33759
