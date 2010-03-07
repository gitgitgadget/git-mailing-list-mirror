From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/12] tag: support column output with --columns
Date: Sun,  7 Mar 2010 19:09:41 +0700
Message-ID: <1267963785-473-9-git-send-email-pclouds@gmail.com>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 13:14:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoFNM-0000oh-Tb
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 13:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041Ab0CGMNk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 07:13:40 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:64105 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087Ab0CGMNh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 07:13:37 -0500
Received: by mail-pz0-f194.google.com with SMTP id 32so2186152pzk.4
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 04:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=dDlx+9EMrO+1aDqLMrq+181WvjNdoHS4Bd3DmjMyjeY=;
        b=qsyfr/sfYJiclupVykR0tLIl6mKvtxZpAeWr+HhiEFX9Ak5vxix0oU4b7+d9IACS1r
         fXGCPyBGJdn77ND+bNlSxQR7hu27kSY/vAIeu5aqGm4D0nX0H0kUZA7ZKx2nIOmRcsCE
         eZUvSnatnVzZZlkkPRwuq8O5ekXuJcD1xcWHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=pVjbG4wVZjeE9uYoUeyEMuFPhCeZWeVKgp5uh4YT9PMqBsYK36jrxU96wIMu2QB9oM
         Ru5FcSHw0AHrinnq4wDk1TGDPZrtm6rNwGCZRafMdM88AL5R9LTz7a6RxaljvpjBe2ws
         yDM08ZMvy7vdVeIKizJka6ev/+uYFqltBwSvg=
Received: by 10.114.9.14 with SMTP id 14mr2369261wai.117.1267964016746;
        Sun, 07 Mar 2010 04:13:36 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 20sm3595484pzk.7.2010.03.07.04.13.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 04:13:36 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 19:10:21 +0700
X-Mailer: git-send-email 1.7.0.1.370.gd3c5
In-Reply-To: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141686>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-tag.txt |   11 ++++++++++-
 builtin/tag.c             |   17 ++++++++++++++---
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 31c78a8..1ef8df2 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
-'git tag' [-n[<num>]] -l [--contains <commit>] [<pattern>]
+'git tag' [-n[<num>]] -l [--columns | --no-columns]
+	[--contains <commit>] [<pattern>]
 'git tag' -v <tagname>...
=20
 DESCRIPTION
@@ -71,6 +72,14 @@ OPTIONS
 	List tags with names that match the given pattern (or all if no patte=
rn is given).
 	Typing "git tag" without arguments, also lists all tags.
=20
+--columns::
+	Show tags in columns. This option is only applicable if `git tag` is
+	used to list tags.
+
+--no-columns::
+	Show tags in a single list. This option is used to override core.colu=
mns
+	if set. This option is only applicable if `git tag` is used to list t=
ags.
+
 --contains <commit>::
 	Only list tags which contain the specified commit.
=20
diff --git a/builtin/tag.c b/builtin/tag.c
index 4ef1c4f..1304bec 100644
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
@@ -369,7 +370,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 	struct ref_lock *lock;
=20
 	int annotate =3D 0, sign =3D 0, force =3D 0, lines =3D -1,
-		list =3D 0, delete =3D 0, verify =3D 0;
+		list =3D 0, delete =3D 0, verify =3D 0, column_output =3D 0;
 	const char *msgfile =3D NULL, *keyid =3D NULL;
 	struct msg_arg msg =3D { 0, STRBUF_INIT };
 	struct commit_list *with_commit =3D NULL;
@@ -391,6 +392,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 		OPT_STRING('u', NULL, &keyid, "key-id",
 					"use another key to sign the tag"),
 		OPT_BOOLEAN('f', "force", &force, "replace the tag if exists"),
+		OPT_BOOLEAN(0, "columns", &column_output, "show tag list in columns"=
),
=20
 		OPT_GROUP("Tag listing options"),
 		{
@@ -403,6 +405,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 	};
=20
 	git_config(git_tag_config, NULL);
+	column_output =3D core_column_output;
=20
 	argc =3D parse_options(argc, argv, prefix, options, git_tag_usage, 0)=
;
=20
@@ -421,9 +424,17 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
=20
 	if (list + delete + verify > 1)
 		usage_with_options(git_tag_usage, options);
-	if (list)
-		return list_tags(argv[0], lines =3D=3D -1 ? 0 : lines,
+	if (list) {
+		int ret;
+
+		if (column_output)
+			start_columnizer(NULL);
+		ret =3D  list_tags(argv[0], lines =3D=3D -1 ? 0 : lines,
 				 with_commit);
+		if (column_output)
+			stop_columnizer();
+		return ret;
+	}
 	if (lines !=3D -1)
 		die("-n option is only allowed with -l.");
 	if (with_commit)
--=20
1.7.0.1.370.gd3c5
