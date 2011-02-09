From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/16] Add core.column
Date: Wed,  9 Feb 2011 19:24:34 +0700
Message-ID: <1297254284-3729-7-git-send-email-pclouds@gmail.com>
References: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 13:27:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn98W-0007KS-LJ
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 13:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803Ab1BIM1D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 07:27:03 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47853 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab1BIM1C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 07:27:02 -0500
Received: by mail-iw0-f174.google.com with SMTP id 9so74477iwn.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 04:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=VyqBpKl55kUhwcbvlrTR397qtBYNgnvK7+8hGK8YqUY=;
        b=vsKns0AKx/FvI+BImG60rbUr08YIy4aSauS7AtO6JqOkPaja4wJLFzV8Hsnnz/1/Bg
         jzwJX+Ex8zDrU8nODtF3oaA0VhWbXjWoHTC3o/UuMqTummN+L7DD/ltwu3OTTPavyCYx
         +Z96UpzaM5K25xv3+2YSaGmIyjDZeGNwL3w/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Dy+ZtueDPGW3ib+Xy6gGf7PAq16S+dFMUSOT+v7S9jA7L9it23PSOgq17LQ8FSaIzF
         3iTC/YewaNat6dfogeP3Bi7A+V8gZxxb4f6KnE7MTAYAdFjjkW0zHwPRjelxZc9DGQx3
         zcO6lnpaZMjotqDpxFr7xk79TkYycDYPhLzpc=
Received: by 10.42.240.69 with SMTP id kz5mr7790977icb.367.1297254422082;
        Wed, 09 Feb 2011 04:27:02 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id jv9sm224228icb.1.2011.02.09.04.26.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 04:27:01 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 09 Feb 2011 19:25:31 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166410>

=46IXME: should probably go as color.* (i.e. column.*)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |   11 ++++++++
 cache.h                  |    1 +
 column.c                 |   64 ++++++++++++++++++++++++++++++++++++++=
++++++++
 column.h                 |    1 +
 config.c                 |    4 +++
 environment.c            |    1 +
 6 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c5e1835..45b5f5b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -567,6 +567,17 @@ core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
=20
+core.column::
+	Specify whether a command should output in columns. Only commands
+	that support `--column` will be affected by this. This variable
+	consists of a list of tokens separated by either spaces or commas:
+	`never` (do not output in columns), `auto` (output in columns if
+	the output is to a terminal), `always` (always output in
+	columns), `column` (fill column before row), `row` (fill row
+	before column), `dense` (unequal column width).
+	Setting `--column` or `--no-column` will override this
+	variable. This option defaults to never.
+
 add.ignore-errors::
 add.ignoreErrors::
 	Tells 'git add' to continue adding files when some files cannot be
diff --git a/cache.h b/cache.h
index d83d68c..b370657 100644
--- a/cache.h
+++ b/cache.h
@@ -559,6 +559,7 @@ extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern int core_column;
=20
 enum safe_crlf {
 	SAFE_CRLF_FALSE =3D 0,
diff --git a/column.c b/column.c
index e7facf4..615a698 100644
--- a/column.c
+++ b/column.c
@@ -206,3 +206,67 @@ void display_columns(const struct string_list *lis=
t, int mode, int width, int pa
 		die("BUG: invalid mode %d", MODE(mode));
 	}
 }
+
+static int parse_column_option(const char *arg, int len, int *mode)
+{
+	int negate =3D !strncmp(arg, "no", 2);
+
+	if (negate)
+		arg +=3D 2;
+
+	if (!negate && !strncmp(arg, "column", 6)) {
+		*mode &=3D ~COL_MODE;
+		*mode |=3D COL_MODE_COLUMN;
+		return 0;
+	}
+	else if (!negate && !strncmp(arg, "row", 3)) {
+		*mode &=3D ~COL_MODE;
+		*mode |=3D COL_MODE_ROW;
+		return 0;
+	}
+	else if (!strncmp(arg, "dense", 5)) {
+		if (negate)
+			*mode &=3D ~COL_DENSE;
+		else
+			*mode |=3D COL_DENSE;
+		return 0;
+	}
+	else
+		return error("unsupported style '%s'", arg);
+	return 0;
+}
+
+int git_config_column(const char *var, const char *value, int stdout_i=
s_tty)
+{
+	const char *sep =3D " ,";
+	int enable =3D 0;
+
+	while (*value) {
+		int len =3D strcspn(value, sep);
+		if (len) {
+			if (!strncasecmp(value, "never", 5))
+				enable =3D 0;
+			else if (!strncasecmp(value, "always", 6))
+				enable =3D 1;
+			else if (!strncasecmp(value, "auto", 4)) {
+				if (stdout_is_tty < 0)
+					stdout_is_tty =3D isatty(1);
+				if (stdout_is_tty || (pager_in_use() && pager_use_color))
+					enable =3D 1;
+			}
+			else if (!parse_column_option(value, len, &core_column))
+				;
+			else
+				return -1;
+
+			value +=3D len;
+		}
+		value +=3D strspn(value, sep);
+	}
+	if (!enable)
+		core_column =3D 0;
+	else if (MODE(core_column) =3D=3D COL_MODE_PLAIN)
+		core_column |=3D COL_MODE_COLUMN;
+
+	return 0;
+}
diff --git a/column.h b/column.h
index cef354d..0749793 100644
--- a/column.h
+++ b/column.h
@@ -10,5 +10,6 @@
=20
 extern int term_columns(void);
 extern void display_columns(const struct string_list *list, int mode, =
int width, int padding, const char *indent);
+extern int git_config_column(const char *var, const char *value, int s=
tdout_is_tty);
=20
 #endif
diff --git a/config.c b/config.c
index 625e051..68a432a 100644
--- a/config.c
+++ b/config.c
@@ -9,6 +9,7 @@
 #include "exec_cmd.h"
 #include "strbuf.h"
 #include "quote.h"
+#include "column.h"
=20
 #define MAXNAME (256)
=20
@@ -660,6 +661,9 @@ static int git_default_core_config(const char *var,=
 const char *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.column"))
+		return git_config_column(var, value, -1);
+
 	/* Add other config variables here and to Documentation/config.txt. *=
/
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 9564475..b420ea2 100644
--- a/environment.c
+++ b/environment.c
@@ -56,6 +56,7 @@ char *notes_ref_name;
 int grafts_replace_parents =3D 1;
 int core_apply_sparse_checkout;
 struct startup_info *startup_info;
+int core_column;
=20
 /* Parallel index stat data preload? */
 int core_preload_index =3D 0;
--=20
1.7.2.2
