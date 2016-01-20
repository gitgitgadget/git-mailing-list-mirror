From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/7] diff-no-index: do not take a redundant prefix argument
Date: Wed, 20 Jan 2016 18:06:02 +0700
Message-ID: <1453287968-26000-2-git-send-email-pclouds@gmail.com>
References: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 12:06:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLqay-0003OR-LV
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 12:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbcATLGd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2016 06:06:33 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34932 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964792AbcATLGb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 06:06:31 -0500
Received: by mail-pf0-f196.google.com with SMTP id 65so260687pff.2
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 03:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PiVzJelxDuy0f04lZP3+oYQyifdHBJzMI+3T4iCYhso=;
        b=HPEgxP0T+qhX5671YG0ZQkuwnGTkfBD00h4un0R8LpDOqCR3jJ34hJy1k/jNc7DadF
         vgFvCFTE4Wl+RIbwlgi5n2RQ3Ws03MxxqEw5zQ95nS+jE+x5MUjKnjtep6aEwU+04bsF
         rrnuKpq/A9bxvn+ZDwxs8MR8eN453R1yH85rSv/rm1PMqXuru1fzHHPIgMVAOGylW7KC
         +3+KER19npALVQqp/9XjBcYdPMZBlEYoiR1NUQ9MOZVYc0iaBll0UeTpsG8uATVZ1/9C
         WBdSnDiQgbe5lIc3FuQ+nl0ee2/jWeq4s+UPgbcZhDoQFZBzuBgkHlLd3jawwHFWFZyP
         dxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=PiVzJelxDuy0f04lZP3+oYQyifdHBJzMI+3T4iCYhso=;
        b=YOnwhoflZaT/+h7eUYWW7bRyUh3Aaesl6+OXtUcQHabbDcu9gDhpaPheIQQsliVfqm
         c+TIDQKO8grbl2Us68hdZIOL2Ux/nAXIUriUDLp/m9r+zaKS4jfxZegGIKWAZGy6SDJr
         FhH2bOEY9qkZXH4SkiNvDQtKriTIXJQBsXih3qgG3vMkI25085eorKqxj1mLItDjz3IC
         Hw18jwPwUuX0zH9bn7TqaT0xexR0WRBpz/gBDBaV6KBUp705ZC0ReWa1pfr3dHuKnc3W
         YJr/n5uYwijffjUTcyzlTabqL34d/q6Me3rs1TdqnTP+82ML4Q/b8HTwPm7xPAYmSYgR
         eneg==
X-Gm-Message-State: ALoCoQlHLhkHKLUx3hFz39PCU9raCRejA/MicUCHMILobpEV8jyW9kYDzVMGRP+lFbLZ60wHGyJ2Y6Jdl7GxcVIig1RWG4stHA==
X-Received: by 10.98.0.135 with SMTP id 129mr51707454pfa.156.1453287990774;
        Wed, 20 Jan 2016 03:06:30 -0800 (PST)
Received: from lanh ([115.72.43.83])
        by smtp.gmail.com with ESMTPSA id p66sm47984741pfi.34.2016.01.20.03.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2016 03:06:29 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Jan 2016 18:06:26 +0700
X-Mailer: git-send-email 2.7.0.125.g9eec362
In-Reply-To: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284447>

Prefix is already set up in "revs". The same prefix should be used for
all options parsing. So kill the last argument. This patch does not
actually change anything because the only caller does use the same
prefix for init_revisions() and diff_no_index().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/diff.c  | 2 +-
 diff-no-index.c | 4 ++--
 diff.h          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index ed0acca..52c98a9 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -341,7 +341,7 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 	}
 	if (no_index)
 		/* If this is a no-index diff, just run it and exit there. */
-		diff_no_index(&rev, argc, argv, prefix);
+		diff_no_index(&rev, argc, argv);
=20
 	/* Otherwise, we are doing the usual "git" diff */
 	rev.diffopt.skip_stat_unmatch =3D !!diff_auto_refresh_index;
diff --git a/diff-no-index.c b/diff-no-index.c
index 8e0fd27..491e842 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -237,12 +237,12 @@ static void fixup_paths(const char **path, struct=
 strbuf *replacement)
 }
=20
 void diff_no_index(struct rev_info *revs,
-		   int argc, const char **argv,
-		   const char *prefix)
+		   int argc, const char **argv)
 {
 	int i, prefixlen;
 	const char *paths[2];
 	struct strbuf replacement =3D STRBUF_INIT;
+	const char *prefix =3D revs->prefix;
=20
 	diff_setup(&revs->diffopt);
 	for (i =3D 1; i < argc - 2; ) {
diff --git a/diff.h b/diff.h
index f7208ad..f61ee54 100644
--- a/diff.h
+++ b/diff.h
@@ -345,7 +345,7 @@ extern int diff_flush_patch_id(struct diff_options =
*, unsigned char *);
=20
 extern int diff_result_code(struct diff_options *, int);
=20
-extern void diff_no_index(struct rev_info *, int, const char **, const=
 char *);
+extern void diff_no_index(struct rev_info *, int, const char **);
=20
 extern int index_differs_from(const char *def, int diff_flags);
=20
--=20
2.7.0.125.g9eec362
