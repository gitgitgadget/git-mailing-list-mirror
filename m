From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/12] grep: support column output with --columns
Date: Sun,  7 Mar 2010 19:09:45 +0700
Message-ID: <1267963785-473-13-git-send-email-pclouds@gmail.com>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 13:14:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoFNP-0000oh-MA
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 13:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117Ab0CGMN6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 07:13:58 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33676 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089Ab0CGMNz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 07:13:55 -0500
Received: by mail-pw0-f46.google.com with SMTP id 8so3254848pwj.19
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 04:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=1f+y2ljFPxIPW+s6ej84PhBbQBehks25hDpzijQydNw=;
        b=L82kxwW4hWidupPnfKhuyj8r2lH5xqXfZe78p/l+jzVMcxitNF1wNO3Qd0I9WUeeEY
         0Tn8Qp/c0O66go4UR6Idc6sqD1R02tAYk9yAiUEt+RDHbCgvrPmMNoBz2o0PlXZjI1JV
         ePWjous/Z9pi37z6Xij4E2tBj8t/p9D4NCZsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=G8UTuGFmldt7dGxQfmIL8gI00Gw+F2pXwiss1GQFOVcgNcd744dkkhrUvHxCvm6H1i
         YJq1xa0rOtLqvDLLccZvSm1ialbLWpl8xFiXyPqdGLVP+F3JKc3yOJfMSoaxBEBwgBJB
         eNnxnhjFZDNkwAXD8ETYBEry/8ZAHJaFyzUjI=
Received: by 10.143.153.21 with SMTP id f21mr2294720wfo.261.1267964034824;
        Sun, 07 Mar 2010 04:13:54 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 20sm3595743pzk.7.2010.03.07.04.13.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 04:13:54 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 19:10:39 +0700
X-Mailer: git-send-email 1.7.0.1.370.gd3c5
In-Reply-To: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141688>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-grep.txt |   10 ++++++++++
 builtin/grep.c             |    9 +++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 4b32322..7bd6a4f 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -18,6 +18,7 @@ SYNOPSIS
 	   [-c | --count] [--all-match] [-q | --quiet]
 	   [--max-depth <depth>]
 	   [--color[=3D<when>] | --no-color]
+	   [--columns | --no-columns]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
@@ -123,6 +124,15 @@ OPTIONS
 	gives the default to color output.
 	Same as `--color=3Dnever`.
=20
+--columns::
+	Show matched files in columns. This option is only applicable when
+	used with --name-only or --files-without-match.
+
+--no-columns::
+	Show matched files in a single list.  This option is used to
+	override core.columns if set. This option is only applicable
+	when used with --name-only or --files-without-match.
+
 -[ABC] <context>::
 	Show `context` trailing (`A` -- after), or leading (`B`
 	-- before), or both (`C` -- context) lines, and place a
diff --git a/builtin/grep.c b/builtin/grep.c
index b8a1d5c..48c8c57 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -15,6 +15,7 @@
 #include "grep.h"
 #include "quote.h"
 #include "dir.h"
+#include "column.h"
=20
 #ifndef NO_PTHREADS
 #include "thread-utils.h"
@@ -759,6 +760,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	int cached =3D 0;
 	int seen_dashdash =3D 0;
 	int external_grep_allowed__ignored;
+	int column_output =3D 0;
 	struct grep_opt opt;
 	struct object_array list =3D { 0, 0, NULL };
 	const char **paths =3D NULL;
@@ -849,6 +851,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 			    "allow calling of grep(1) (ignored by this build)"),
 		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, "show usage",
 		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
+		OPT_BOOLEAN(0, "columns", &column_output, "show match files in colum=
ns"),
 		OPT_END()
 	};
=20
@@ -876,6 +879,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	git_config(grep_config, &opt);
 	if (opt.color =3D=3D -1)
 		opt.color =3D git_use_color_default;
+	column_output =3D core_column_output;
=20
 	/*
 	 * If there is no -- then the paths must exist in the working
@@ -967,6 +971,9 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 		paths[1] =3D NULL;
 	}
=20
+	if (opt.name_only && column_output)
+		start_columnizer(NULL);
+
 	if (!use_index) {
 		if (cached)
 			die("--cached cannot be used with --no-index.");
@@ -1002,5 +1009,7 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
 		free_grep_patterns(&opt);
 	}
=20
+	if (opt.name_only && column_output)
+		stop_columnizer();
 	return !hit;
 }
--=20
1.7.0.1.370.gd3c5
