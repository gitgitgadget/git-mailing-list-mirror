From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/7] merge: add --rename-file
Date: Wed, 20 Jan 2016 18:06:06 +0700
Message-ID: <1453287968-26000-6-git-send-email-pclouds@gmail.com>
References: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 12:07:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLqbN-0003Vn-I9
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 12:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbcATLHA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2016 06:07:00 -0500
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36666 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964817AbcATLG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 06:06:56 -0500
Received: by mail-pa0-f65.google.com with SMTP id a20so250338pag.3
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 03:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2daOwyUklm44Kji9jAS/Ejd5Qe0NJsp4rWf2EaO5E0c=;
        b=rfNMqa77t/81RG05WgvoR2ixbjFs62vPFilypr2ffZ4+jzD1Fvp3k6lkQp086dNGWe
         14kOAHoa/xiC93wj86yRl79hECzgnnpur1nOkp1/mfkRvsD7pPckkI553h59WJZLStbv
         ULdWmIb71b7lKLdacVX2t8mmtP5VvCy49084yrMaXtwXiPxMY+91sEfrjaqM7FDZ6Y/Z
         yA+MpNvRu+WKG1x6Q6DSvnrcbtcWOpTpZfL+96yd5zKao50j/Skhyc8PiUw8WSMxsMAc
         dF7aSFClTI279jwwn95jWmgdYvzhEOPSTOspawJ5+DEB1O/ArjEhML6PgvkXz6/x+6d1
         jG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=2daOwyUklm44Kji9jAS/Ejd5Qe0NJsp4rWf2EaO5E0c=;
        b=L4mbHbaWNlBax26dG6LhUR+MSLOu6M3gBhRuUSb8JXl7o6A8gz8boWOR/biFZyxvpn
         npOmlqhIhYBZwEBSMda4t4esB13LI2qPpCkoq6AV5RitNuGqZzwUEN/BMdGxa4fJq8pQ
         b65TnIrgIraIRw1uoEFm+o9tB2t2k6zpWbZb4Nff8ZF7FBYnDz5M21n/de0lZ9j01vlK
         XpbbHGC2zfGxwUSWXsOVYQETHzAjcHhaviuOp/0kgUILC56dUgOMrJDRrZc2nG8SIGPJ
         /yJTURE+0mUZ0DhbiLHo1Fzk57fY7lKyxibJuiGnMmARjJ5tAlSKbqtltf+ZPPQ5lWi4
         ZiBA==
X-Gm-Message-State: ALoCoQmSdgER3AcxOmbC8lyNr5hKXndnhrB075l0BtcOa1k1DzUTMWWQ9+1IXBHL/3W4hvw17jqk7kue13ifdMpsq/7QLKDNOg==
X-Received: by 10.66.149.7 with SMTP id tw7mr51797168pab.72.1453288015995;
        Wed, 20 Jan 2016 03:06:55 -0800 (PST)
Received: from lanh ([115.72.43.83])
        by smtp.gmail.com with ESMTPSA id m87sm48001690pfi.47.2016.01.20.03.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2016 03:06:54 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Jan 2016 18:06:51 +0700
X-Mailer: git-send-email 2.7.0.125.g9eec362
In-Reply-To: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284452>

=46or one-time amateurs, --rename-file could be used to specify what pa=
th
should be renamed to what path between heads and the merge base, when
they hit big merge conflicts because diff fails to recognize renames
correctly.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/merge.c   | 9 +++++++++
 merge-recursive.c | 1 +
 merge-recursive.h | 1 +
 3 files changed, 11 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 15bf95b..95a6c26 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -67,6 +67,8 @@ static int abort_current_merge;
 static int show_progress =3D -1;
 static int default_to_upstream =3D 1;
 static const char *sign_commit;
+static const char *rename_file;
+static struct strbuf manual_renames =3D STRBUF_INIT;
=20
 static struct strategy all_strategy[] =3D {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -225,6 +227,7 @@ static struct option builtin_merge_options[] =3D {
 	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored=
 files (default)")),
+	OPT_FILENAME(0, "rename-file", &rename_file, N_("--rename-file to dif=
f")),
 	OPT_END()
 };
=20
@@ -664,6 +667,8 @@ static int try_merge_strategy(const char *strategy,=
 struct commit_list *common,
 		o.renormalize =3D option_renormalize;
 		o.show_rename_progress =3D
 			show_progress =3D=3D -1 ? isatty(2) : show_progress;
+		if (manual_renames.len)
+			o.manual_renames =3D manual_renames.buf;
=20
 		for (x =3D 0; x < xopts_nr; x++)
 			if (parse_merge_opt(&o, xopts[x]))
@@ -1255,6 +1260,10 @@ int cmd_merge(int argc, const char **argv, const=
 char *prefix)
 		usage_with_options(builtin_merge_usage,
 			builtin_merge_options);
=20
+	if (rename_file &&
+	    strbuf_read_file(&manual_renames, rename_file, 0) =3D=3D -1)
+		die(_("unable to read %s"), rename_file);
+
 	if (!head_commit) {
 		struct commit *remote_head;
 		/*
diff --git a/merge-recursive.c b/merge-recursive.c
index 8eabde2..ec7e044 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -492,6 +492,7 @@ static struct string_list *get_renames(struct merge=
_options *o,
 	opts.rename_score =3D o->rename_score;
 	opts.show_rename_progress =3D o->show_rename_progress;
 	opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
+	opts.manual_renames =3D o->manual_renames;
 	diff_setup_done(&opts);
 	diff_tree_sha1(o_tree->object.oid.hash, tree->object.oid.hash, "", &o=
pts);
 	diffcore_std(&opts);
diff --git a/merge-recursive.h b/merge-recursive.h
index 9e090a3..898b169 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -27,6 +27,7 @@ struct merge_options {
 	struct string_list current_file_set;
 	struct string_list current_directory_set;
 	struct string_list df_conflict_file_set;
+	const char *manual_renames;
 };
=20
 /* merge_trees() but with recursive ancestor consolidation */
--=20
2.7.0.125.g9eec362
