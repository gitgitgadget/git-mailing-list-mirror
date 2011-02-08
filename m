From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/7] tag: support column output with --column
Date: Tue,  8 Feb 2011 22:22:20 +0700
Message-ID: <1297178541-31124-7-git-send-email-pclouds@gmail.com>
References: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 08 16:24:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmpQr-00072f-1P
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 16:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859Ab1BHPYh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Feb 2011 10:24:37 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:58751 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835Ab1BHPYg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 10:24:36 -0500
Received: by pxi15 with SMTP id 15so1140252pxi.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 07:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=giIos1F0gkNQ/4Z5kimiEcmXTdvueIUq72lO5VFRk0k=;
        b=t3qoEQjYeaYr4YTndN3hyKjJIWGRghJfUDzsWHCL+wDCRFC8kG4Wmesan6PFFAEdE6
         K4YBU0+UgQzah8GGFrpMDNBEKYE6LfT8P0rbYTDQB9qhLlN9hPQOpbwPHzvXwvnZd4Et
         WmJ2wdtkA20KtJIzMJKbXQ1+6c0SWyCURGYyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=H5qINSmU40TvezQJoNvccC9FDPETqopHBIghXeQoB8VT86Xlp7+QhdM/Mh8oI3z63D
         a8KbD1L7/PWyXdDg3Mbc7sKcfZPRqHITcPQsianCNysT4tdS/VQxTpyHZErVEc26tgeR
         XydIh8PWfF/Xfop69Kp9wFqPjjww5+vgzR1LA=
Received: by 10.142.140.3 with SMTP id n3mr17098788wfd.276.1297178676124;
        Tue, 08 Feb 2011 07:24:36 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id w22sm7707081wfd.19.2011.02.08.07.24.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Feb 2011 07:24:34 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 08 Feb 2011 22:23:08 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166358>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-tag.txt |   11 ++++++++++-
 builtin/tag.c             |   19 ++++++++++++++++---
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 8b169e3..7a3ae28 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
-'git tag' [-n[<num>]] -l [--contains <commit>] [<pattern>]
+'git tag' [-n[<num>]] -l [--[no-]column[=3D<options>[,<option>]*]]
+	[--contains <commit>] [<pattern>]
 'git tag' -v <tagname>...
=20
 DESCRIPTION
@@ -71,6 +72,14 @@ OPTIONS
 	List tags with names that match the given pattern (or all if no patte=
rn is given).
 	Typing "git tag" without arguments, also lists all tags.
=20
+--column::
+	Show tags in columns. This option is only applicable if `git tag` is
+	used to list tags without annotation lines.
+
+--no-column::
+	Show tags in a single list. This option is used to override core.colu=
mns
+	if set. This option is only applicable if `git tag` is used to list t=
ags.
+
 --contains <commit>::
 	Only list tags which contain the specified commit.
=20
diff --git a/builtin/tag.c b/builtin/tag.c
index aa1f87d..b74b8bf 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -12,6 +12,7 @@
 #include "tag.h"
 #include "run-command.h"
 #include "parse-options.h"
+#include "column.h"
=20
 static const char * const git_tag_usage[] =3D {
 	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<he=
ad>]",
@@ -22,6 +23,7 @@ static const char * const git_tag_usage[] =3D {
 };
=20
 static char signingkey[1000];
+static struct column_layout layout;
=20
 struct tag_filter {
 	const char *pattern;
@@ -52,7 +54,7 @@ static int show_reference(const char *refname, const =
unsigned char *sha1,
 		}
=20
 		if (!filter->lines) {
-			printf("%s\n", refname);
+			string_list_append(&layout.items, refname);
 			return 0;
 		}
 		printf("%-15s ", refname);
@@ -383,6 +385,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 		OPT_STRING('u', NULL, &keyid, "key-id",
 					"use another key to sign the tag"),
 		OPT__FORCE(&force, "replace the tag if exists"),
+		OPT_COLUMN(0, "column", &layout, "show tag list in columns" ),
=20
 		OPT_GROUP("Tag listing options"),
 		{
@@ -395,6 +398,9 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 	};
=20
 	git_config(git_tag_config, NULL);
+	layout.mode =3D core_column;
+	layout.width =3D term_columns();
+	layout.items.strdup_strings =3D 1;
=20
 	argc =3D parse_options(argc, argv, prefix, options, git_tag_usage, 0)=
;
=20
@@ -413,9 +419,16 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
=20
 	if (list + delete + verify > 1)
 		usage_with_options(git_tag_usage, options);
-	if (list)
-		return list_tags(argv[0], lines =3D=3D -1 ? 0 : lines,
+	if (list) {
+		int ret;
+
+		if (lines !=3D -1)
+			layout.mode =3D COL_PLAIN;
+		ret =3D  list_tags(argv[0], lines =3D=3D -1 ? 0 : lines,
 				 with_commit);
+		display_columns(&layout, 2, "");
+		return ret;
+	}
 	if (lines !=3D -1)
 		die("-n option is only allowed with -l.");
 	if (with_commit)
--=20
1.7.2.2
