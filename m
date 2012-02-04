From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 12/12] tag: add --column
Date: Sat,  4 Feb 2012 22:59:16 +0700
Message-ID: <1328371156-4009-13-git-send-email-pclouds@gmail.com>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
 <1328371156-4009-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 16:56:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rthyk-00077q-1Z
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 16:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976Ab2BDP4g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 10:56:36 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36432 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753Ab2BDP4f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 10:56:35 -0500
Received: by mail-pz0-f46.google.com with SMTP id p15so3553938dad.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 07:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=z9BdsnwiZJVHNuXw/M0Eq1Mpgk+IuP7OmhgTARyX/eQ=;
        b=bvdyvQ9iNHem7l9Qj11b9UQ+zzz3dDnH3HhPF89A2RXV1TEBc1f0MOOlx16GA3ay5O
         +Cqsjw0f3dwf7Zz6E5iMtFbKK7+FjTA+aqNc2dEJOP86GgffVEnmA3m24S3tRhNBcx+u
         Y2CIZXqpQAwNT33Un/gjFJeA+wB5X31TMqhTo=
Received: by 10.68.220.227 with SMTP id pz3mr26352210pbc.86.1328370995677;
        Sat, 04 Feb 2012 07:56:35 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id j5sm22425447pbe.1.2012.02.04.07.56.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 07:56:34 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Sat, 04 Feb 2012 23:01:01 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328371156-4009-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189885>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt  |    4 ++++
 Documentation/git-tag.txt |   11 ++++++++++-
 Makefile                  |    2 +-
 builtin/tag.c             |   30 +++++++++++++++++++++++++++---
 t/t7004-tag.sh            |   44 +++++++++++++++++++++++++++++++++++++=
+++++++
 5 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ebb210c..145336a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -855,6 +855,10 @@ column.status::
 	Specify whether to output untracked files in `git status` in columns.
 	See `column.ui` for details.
=20
+column.tag::
+	Specify whether to output tag listing in `git tag` in columns.
+	See `column.ui` for details.
+
 commit.status::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 53ff5f6..5ead91e 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
-'git tag' [-n[<num>]] -l [--contains <commit>] [<pattern>...]
+'git tag' [-n[<num>]] -l [--contains <commit>]
+	[--column[=3D<options>] | --no-column] [<pattern>...]
 'git tag' -v <tagname>...
=20
 DESCRIPTION
@@ -83,6 +84,14 @@ OPTIONS
 	using fnmatch(3)).  Multiple patterns may be given; if any of
 	them matches, the tag is shown.
=20
+--column[=3D<options>]::
+--no-column::
+	Display tag listing in columns. See configuration variable
+	column.tag for option syntax.`--column` and `--no-column`
+	without options are equivalent to 'always' and 'never' respectively.
++
+This option is only applicable when listing tags without annotation li=
nes.
+
 --contains <commit>::
 	Only list tags which contain the specified commit.
=20
diff --git a/Makefile b/Makefile
index b2644bc..eb7b6fc 100644
--- a/Makefile
+++ b/Makefile
@@ -2116,7 +2116,7 @@ builtin/prune.o builtin/reflog.o reachable.o: rea=
chable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o url.o http-backend.o: url.h
-builtin/branch.o builtin/commit.o column.o help.o pager.o: column.h
+builtin/branch.o builtin/commit.o builtin/tag.o column.o help.o pager.=
o: column.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.=
h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h ur=
l.h
=20
diff --git a/builtin/tag.c b/builtin/tag.c
index 31f02e8..d01f918 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -15,6 +15,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "gpg-interface.h"
+#include "column.h"
=20
 static const char * const git_tag_usage[] =3D {
 	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<he=
ad>]",
@@ -30,6 +31,8 @@ struct tag_filter {
 	struct commit_list *with_commit;
 };
=20
+static unsigned int colopts;
+
 static int match_pattern(const char **patterns, const char *ref)
 {
 	/* no pattern means match everything */
@@ -230,6 +233,9 @@ static int git_tag_config(const char *var, const ch=
ar *value, void *cb)
 	int status =3D git_gpg_config(var, value, cb);
 	if (status)
 		return status;
+	status =3D git_column_config(var, value, "tag", &colopts);
+	if (status <=3D 0)
+		return status;
 	return git_default_config(var, value, cb);
 }
=20
@@ -409,6 +415,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 		OPT_STRING('u', "local-user", &keyid, "key-id",
 					"use another key to sign the tag"),
 		OPT__FORCE(&force, "replace the tag if exists"),
+		OPT_COLUMN(0, "column", &colopts, "show tag list in columns" ),
=20
 		OPT_GROUP("Tag listing options"),
 		{
@@ -424,6 +431,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
=20
 	memset(&opt, 0, sizeof(opt));
=20
+	colopts &=3D ~COL_ENABLED_SET;
 	argc =3D parse_options(argc, argv, prefix, options, git_tag_usage, 0)=
;
=20
 	if (keyid) {
@@ -441,9 +449,25 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
=20
 	if (list + delete + verify > 1)
 		usage_with_options(git_tag_usage, options);
-	if (list)
-		return list_tags(argv, lines =3D=3D -1 ? 0 : lines,
-				 with_commit);
+	if (list && lines !=3D -1) {
+		/* only die when --column is given explicitly */
+		if ((colopts & (COL_ENABLED_SET | COL_ENABLED)) =3D=3D (COL_ENABLED_=
SET | COL_ENABLED))
+			die(_("--column and -n are incompatible"));
+		colopts =3D 0;
+	}
+	if (list) {
+		int ret;
+		if (lines =3D=3D -1 && colopts & COL_ENABLED) {
+			struct column_options copts;
+			memset(&copts, 0, sizeof(copts));
+			copts.padding =3D 2;
+			run_column_filter(colopts, &copts);
+		}
+		ret =3D list_tags(argv, lines =3D=3D -1 ? 0 : lines, with_commit);
+		if (lines =3D=3D -1 && colopts & COL_ENABLED)
+			stop_column_filter();
+		return ret;
+	}
 	if (lines !=3D -1)
 		die(_("-n option is only allowed with -l."));
 	if (with_commit)
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index e93ac73..579a298 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -263,6 +263,50 @@ test_expect_success 'tag -l can accept multiple pa=
tterns' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'listing tags in column' '
+	COLUMNS=3D40 git tag -l --column=3Drow >actual &&
+	cat >expected <<\EOF &&
+a1      aa1     cba     t210    t211
+v0.2.1  v1.0    v1.0.1  v1.1.3
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'listing tags in column with column.*' '
+	git config column.tag row &&
+	git config column.ui dense &&
+	COLUMNS=3D40 git tag -l >actual &&
+	git config --unset column.ui &&
+	git config --unset column.tag &&
+	cat >expected <<\EOF &&
+a1      aa1   cba     t210    t211
+v0.2.1  v1.0  v1.0.1  v1.1.3
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'listing tag with -n --column should fail' '
+	test_must_fail git tag --column -n
+'
+
+test_expect_success 'listing tags -n in column with column.ui ignored'=
 '
+	git config column.ui "row dense" &&
+	COLUMNS=3D40 git tag -l -n >actual &&
+	git config --unset column.ui &&
+	cat >expected <<\EOF &&
+a1              Foo
+aa1             Foo
+cba             Foo
+t210            Foo
+t211            Foo
+v0.2.1          Foo
+v1.0            Foo
+v1.0.1          Foo
+v1.1.3          Foo
+EOF
+	test_cmp expected actual
+'
+
 # creating and verifying lightweight tags:
=20
 test_expect_success \
--=20
1.7.8.36.g69ee2
