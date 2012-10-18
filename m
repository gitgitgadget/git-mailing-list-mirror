From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/2] status: add --long for default format
Date: Thu, 18 Oct 2012 08:58:00 +0700
Message-ID: <1350525480-30395-2-git-send-email-pclouds@gmail.com>
References: <1350404569-9787-1-git-send-email-pclouds@gmail.com>
 <1350525480-30395-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 03:58:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOfNY-0001td-To
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 03:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575Ab2JRB6T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Oct 2012 21:58:19 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46482 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405Ab2JRB6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 21:58:16 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so7830523pbb.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 18:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kE0oh+XxNtiEV4Z+D2odEtq/xIeeZRdEoRtQC/VqOak=;
        b=h7jUoYhKgjz/hWVQvAcBP4lvUV/0+gI5LcoJE43t5AR4xAt1J1yPG4i5FtBr3bHpuq
         H9DNlmXsZkZiilT/vCG+FNFAVD4UA/FjO7+ykFC87kQOuH+J2ExJsNAzzz0ciHFd4O/G
         N28Ql8z/Rz0urXLxfgtL6s7eK8dC+RHyNI1G0KbS2jVK5xQvcLS8TrjUT27B4cwBJrzs
         g8GLbByli/0148l1cFS/CtgzZ9vNt4PXGa8rXAVpsyg/pexp4gRBfe6nSOo5YiEspkkr
         sTaJLzfiqa9kku1qMUY2Q1brQ8chiT5L5qrQNvPpIcHqBvvIQGnUrFH1ERHwezKiI1XS
         8KzA==
Received: by 10.68.252.133 with SMTP id zs5mr61347036pbc.152.1350525496584;
        Wed, 17 Oct 2012 18:58:16 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id h8sm13495825pay.0.2012.10.17.18.58.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Oct 2012 18:58:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 18 Oct 2012 08:58:09 +0700
X-Mailer: git-send-email 1.8.0.rc2.32.g1729c8c
In-Reply-To: <1350525480-30395-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207948>

This could be useful when the user sets an alias to "status --short"
and wants to get the default format back temporarily.

git-commit also learns --long mostly for consistency as there's little
chance that someone adds an alias for "git commit --short" then wants
a one shot --long output.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-commit.txt |  4 ++++
 Documentation/git-status.txt |  3 +++
 builtin/commit.c             | 10 ++++++++++
 3 files changed, 17 insertions(+)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index 9594ac8..3acf2e7 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -109,6 +109,10 @@ OPTIONS
 	format. See linkgit:git-status[1] for details. Implies
 	`--dry-run`.
=20
+--long::
+	When doing a dry-run, give the output in a the long-format.
+	Implies `--dry-run`.
+
 -z::
 --null::
 	When showing `short` or `porcelain` status output, terminate
diff --git a/Documentation/git-status.txt b/Documentation/git-status.tx=
t
index 67e5f53..9f1ef9a 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -38,6 +38,9 @@ OPTIONS
 	across git versions and regardless of user configuration. See
 	below for details.
=20
+--long::
+	Give the output in the long-format. This is the default.
+
 -u[<mode>]::
 --untracked-files[=3D<mode>]::
 	Show untracked files.
diff --git a/builtin/commit.c b/builtin/commit.c
index 984e29c..1dd2ec5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1063,6 +1063,8 @@ static int parse_and_validate_options(int argc, c=
onst char *argv[],
 	if (s->null_termination) {
 		if (status_format =3D=3D STATUS_FORMAT_NONE)
 			status_format =3D STATUS_FORMAT_PORCELAIN;
+		else if (status_format =3D=3D STATUS_FORMAT_LONG)
+			die(_("--long and -z are incompatible"));
 	}
 	if (status_format !=3D STATUS_FORMAT_NONE)
 		dry_run =3D 1;
@@ -1163,6 +1165,9 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 		OPT_SET_INT(0, "porcelain", &status_format,
 			    N_("machine-readable output"),
 			    STATUS_FORMAT_PORCELAIN),
+		OPT_SET_INT(0, "long", &status_format,
+			    N_("show status in long format (default)"),
+			    STATUS_FORMAT_LONG),
 		OPT_BOOLEAN('z', "null", &s.null_termination,
 			    N_("terminate entries with NUL")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg,
@@ -1193,6 +1198,8 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 	if (s.null_termination) {
 		if (status_format =3D=3D STATUS_FORMAT_NONE)
 			status_format =3D STATUS_FORMAT_PORCELAIN;
+		else if (status_format =3D=3D STATUS_FORMAT_LONG)
+			die(_("--long and -z are incompatible"));
 	}
=20
 	handle_untracked_files_arg(&s);
@@ -1393,6 +1400,9 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 		OPT_BOOLEAN(0, "branch", &s.show_branch, N_("show branch information=
")),
 		OPT_SET_INT(0, "porcelain", &status_format,
 			    N_("machine-readable output"), STATUS_FORMAT_PORCELAIN),
+		OPT_SET_INT(0, "long", &status_format,
+			    N_("show status in long format (default)"),
+			    STATUS_FORMAT_LONG),
 		OPT_BOOLEAN('z', "null", &s.null_termination,
 			    N_("terminate entries with NUL")),
 		OPT_BOOLEAN(0, "amend", &amend, N_("amend previous commit")),
--=20
1.8.0.rc2.32.g1729c8c
