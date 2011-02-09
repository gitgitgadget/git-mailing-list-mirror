From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/16] tag: add --column
Date: Wed,  9 Feb 2011 19:24:37 +0700
Message-ID: <1297254284-3729-10-git-send-email-pclouds@gmail.com>
References: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 13:27:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn98v-0007dS-2O
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 13:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829Ab1BIM10 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 07:27:26 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47853 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab1BIM1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 07:27:25 -0500
Received: by mail-iw0-f174.google.com with SMTP id 9so74477iwn.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 04:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=bZw0m3suxAi5A+ioJ9f2JETtEqD6LRR4YhOXy+QAkN0=;
        b=KnkfH1XS+ThZYfcDEuZ7+WUsrY5eXKEfI1nnl++LlFddWSOjqQbae2h7uo6z26PKLh
         CX1emLZY6saaEoV0G3O8jyrXJO5rGsvOClRpfUCQ5MupA9gw74kle6l2GafTmFvwLU5h
         JRlPiMESYWo4YypCXTANgy+qefTnjNUKLiwbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DOJ3A56RFm0SznEqCZuDFWAI7lRrJhiV8enWXjeOmKbVGw11GRtoYTGVxhuNzLeBQp
         7zdM9A7odbvNJfuhBJYE6KDs+2+Z438+cQa/Tim9V64gn3ewINWMCi0GTgVG0GGepIoz
         d7uDDbcl/yegB2nhhDs4u2VLoc4iCifRIuRZU=
Received: by 10.42.224.66 with SMTP id in2mr5038859icb.410.1297254445190;
        Wed, 09 Feb 2011 04:27:25 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id c4sm208751ict.19.2011.02.09.04.27.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 04:27:24 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 09 Feb 2011 19:25:54 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166413>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-tag.txt |    9 ++++++++-
 Makefile                  |    2 +-
 builtin/tag.c             |   21 +++++++++++++++++----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 8b169e3..89c55fb 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
-'git tag' [-n[<num>]] -l [--contains <commit>] [<pattern>]
+'git tag' [-n[<num>]] -l [--column[=3D<options>] | --no-column]
+	[--contains <commit>] [<pattern>]
 'git tag' -v <tagname>...
=20
 DESCRIPTION
@@ -71,6 +72,12 @@ OPTIONS
 	List tags with names that match the given pattern (or all if no patte=
rn is given).
 	Typing "git tag" without arguments, also lists all tags.
=20
+--column::
+--no-column::
+	Whether show tags in columns. This option is only applicable if `git
+	tag` is used to list tags without annotation lines. See core.column
+	for options.
+
 --contains <commit>::
 	Only list tags which contain the specified commit.
=20
diff --git a/Makefile b/Makefile
index a687e73..c9fd9aa 100644
--- a/Makefile
+++ b/Makefile
@@ -1958,7 +1958,7 @@ builtin/prune.o builtin/reflog.o reachable.o: rea=
chable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o http-backend.o: url.h
-column.o pager.o help.o: column.h
+column.o pager.o help.o tag.o: column.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.=
h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h ur=
l.h
=20
diff --git a/builtin/tag.c b/builtin/tag.c
index aa1f87d..2b6cae9 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -12,6 +12,8 @@
 #include "tag.h"
 #include "run-command.h"
 #include "parse-options.h"
+#include "string-list.h"
+#include "column.h"
=20
 static const char * const git_tag_usage[] =3D {
 	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<he=
ad>]",
@@ -22,6 +24,7 @@ static const char * const git_tag_usage[] =3D {
 };
=20
 static char signingkey[1000];
+static struct string_list output;
=20
 struct tag_filter {
 	const char *pattern;
@@ -52,7 +55,7 @@ static int show_reference(const char *refname, const =
unsigned char *sha1,
 		}
=20
 		if (!filter->lines) {
-			printf("%s\n", refname);
+			string_list_append(&output, refname);
 			return 0;
 		}
 		printf("%-15s ", refname);
@@ -361,7 +364,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 	struct ref_lock *lock;
=20
 	int annotate =3D 0, sign =3D 0, force =3D 0, lines =3D -1,
-		list =3D 0, delete =3D 0, verify =3D 0;
+		list =3D 0, delete =3D 0, verify =3D 0, column_mode;
 	const char *msgfile =3D NULL, *keyid =3D NULL;
 	struct msg_arg msg =3D { 0, STRBUF_INIT };
 	struct commit_list *with_commit =3D NULL;
@@ -383,6 +386,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 		OPT_STRING('u', NULL, &keyid, "key-id",
 					"use another key to sign the tag"),
 		OPT__FORCE(&force, "replace the tag if exists"),
+		OPT_COLUMN(0, "column", &column_mode, "show tag list in columns" ),
=20
 		OPT_GROUP("Tag listing options"),
 		{
@@ -395,6 +399,8 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 	};
=20
 	git_config(git_tag_config, NULL);
+	column_mode =3D core_column;
+	output.strdup_strings =3D 1;
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
+			column_mode =3D COL_MODE_PLAIN;
+		ret =3D  list_tags(argv[0], lines =3D=3D -1 ? 0 : lines,
 				 with_commit);
+		display_columns(&output, column_mode, term_columns(), 2, "");
+		return ret;
+	}
 	if (lines !=3D -1)
 		die("-n option is only allowed with -l.");
 	if (with_commit)
--=20
1.7.2.2
