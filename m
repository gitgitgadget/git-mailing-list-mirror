From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 13/13] tag: add --column
Date: Fri,  3 Feb 2012 20:34:38 +0700
Message-ID: <1328276078-27955-14-git-send-email-pclouds@gmail.com>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 14:32:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtJFf-000062-Oj
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 14:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756481Ab2BCNc1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 08:32:27 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47389 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756472Ab2BCNcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 08:32:25 -0500
Received: by mail-pw0-f46.google.com with SMTP id u11so2900162pbd.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 05:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nLxKfU5OzAZtQUaLMvXNreEw6osfvzDYaKTo2A/xo3o=;
        b=tAdhtHQo3umtf+tv4LWjDHpsokooKXo8cbYFF65Di9GqW05nxnqLcM+U9gNiW5/QIh
         2j/JKRPaFzMjjWRNRmxI2icNXwye+CfApFGwTChBT3IWFNBe8tW93vgIF4cYstoR3k3B
         iG/6i4qDq0b07zrIGUbeEd2WRMTlQvi3Fl+o0=
Received: by 10.68.238.68 with SMTP id vi4mr17596725pbc.65.1328275945573;
        Fri, 03 Feb 2012 05:32:25 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id r9sm13131778pbi.6.2012.02.03.05.32.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 05:32:24 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Fri, 03 Feb 2012 20:36:34 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189770>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt  |    4 ++++
 Documentation/git-tag.txt |   11 ++++++++++-
 Makefile                  |    2 +-
 builtin/tag.c             |   25 ++++++++++++++++++++++---
 4 files changed, 37 insertions(+), 5 deletions(-)

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
index 31f02e8..cecbe5c 100644
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
+static int colopts;
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
@@ -421,6 +428,8 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 	};
=20
 	git_config(git_tag_config, NULL);
+	if (!colopts)
+		colopts =3D git_colopts;
=20
 	memset(&opt, 0, sizeof(opt));
=20
@@ -441,9 +450,19 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
=20
 	if (list + delete + verify > 1)
 		usage_with_options(git_tag_usage, options);
-	if (list)
-		return list_tags(argv, lines =3D=3D -1 ? 0 : lines,
-				 with_commit);
+	if (list) {
+		int ret;
+		if (lines =3D=3D -1) {
+			struct column_options copts;
+			memset(&copts, 0, sizeof(copts));
+			copts.padding =3D 2;
+			run_column_filter(colopts, &copts);
+		}
+		ret =3D list_tags(argv, lines =3D=3D -1 ? 0 : lines, with_commit);
+		if (lines =3D=3D -1)
+			stop_column_filter();
+		return ret;
+	}
 	if (lines !=3D -1)
 		die(_("-n option is only allowed with -l."));
 	if (with_commit)
--=20
1.7.8.36.g69ee2
