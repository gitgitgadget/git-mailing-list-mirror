From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 05/10] column: add column.ui for default column output settings
Date: Tue, 28 Feb 2012 18:58:46 +0700
Message-ID: <1330430331-19945-6-git-send-email-pclouds@gmail.com>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 12:59:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2LiM-0005Og-2i
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 12:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965475Ab2B1L7Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 06:59:25 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46462 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965344Ab2B1L7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 06:59:24 -0500
Received: by mail-pw0-f46.google.com with SMTP id up15so3213892pbc.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 03:59:23 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.230.101 as permitted sender) client-ip=10.68.230.101;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.230.101 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.230.101])
        by 10.68.230.101 with SMTP id sx5mr2393972pbc.26.1330430363959 (num_hops = 1);
        Tue, 28 Feb 2012 03:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GwfzK06HG0suU/n4kRB8yhLfPm5f35FK+6IyWyOkcEg=;
        b=UUY1Mq1hxHjr0PB+MtOavbAqC7ZGUM1cURWM6whp1jeuG2pzhxeEJJQpn1HvmW7nqe
         HvArhiwYEsN6Xv0ZVS50R8ieynUV/oxUGeeZ1tqJwvUI+Gk8LqJrBGf4BVYdFQ2OLHRJ
         EY8HZb7MngcgCJ8+/JXYb6zvszRCJbzD6neUM=
Received: by 10.68.230.101 with SMTP id sx5mr2065291pbc.26.1330430363908;
        Tue, 28 Feb 2012 03:59:23 -0800 (PST)
Received: from tre ([115.74.56.186])
        by mx.google.com with ESMTPS id li19sm15524128pbb.17.2012.02.28.03.59.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Feb 2012 03:59:22 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 28 Feb 2012 18:59:29 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330430331-19945-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191719>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt     |   26 ++++++++++++++++++++++++++
 Documentation/git-column.txt |    6 +++++-
 builtin/column.c             |   21 +++++++++++++++++++++
 column.c                     |   28 ++++++++++++++++++++++++++++
 column.h                     |    2 ++
 5 files changed, 82 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index abeb82b..5216598 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -821,6 +821,32 @@ color.ui::
 	`never` if you prefer git commands not to use color unless enabled
 	explicitly with some other configuration or the `--color` option.
=20
+column.ui::
+	Specify whether supported commands should output in columns.
+	This variable consists of a list of tokens separated by spaces
+	or commas:
++
+--
+`always`;;
+	always show in columns
+`never`;;
+	never show in columns
+`auto`;;
+	show in columns if the output is to the terminal
+`column`;;
+	fill columns before rows (default)
+`row`;;
+	fill rows before columns
+`dense`;;
+	make unequal size columns to utilize more space
+`nodense`;;
+	make equal size columns
+`color`;;
+	input contains ANSI escape sequence for coloring
+--
++
+	This option defaults to 'never'.
+
 commit.status::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
diff --git a/Documentation/git-column.txt b/Documentation/git-column.tx=
t
index 508b85f..94fd7ac 100644
--- a/Documentation/git-column.txt
+++ b/Documentation/git-column.txt
@@ -8,7 +8,7 @@ git-column - Display data in columns
 SYNOPSIS
 --------
 [verse]
-'git column' [--mode=3D<mode> | --rawmode=3D<n>] [--width=3D<width>]
+'git column' [--command=3D<name>] [--[raw]mode=3D<mode>] [--width=3D<w=
idth>]
 	     [--indent=3D<string>] [--nl=3D<string>] [--pading=3D<n>]
=20
 DESCRIPTION
@@ -17,6 +17,10 @@ This command formats its input into multiple columns=
=2E
=20
 OPTIONS
 -------
+--command=3D<name>::
+	Look up layout mode using configuration variable column.<name> and
+	column.ui.
+
 --mode=3D<mode>::
 	Specify layout mode. See configuration variable column.ui for option
 	syntax.
diff --git a/builtin/column.c b/builtin/column.c
index 3b0f74e..102d71b 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -11,12 +11,19 @@ static const char * const builtin_column_usage[] =3D=
 {
 };
 static unsigned int colopts;
=20
+static int column_config(const char *var, const char *value, void *cb)
+{
+	return git_column_config(var, value, cb, &colopts);
+}
+
 int cmd_column(int argc, const char **argv, const char *prefix)
 {
 	struct string_list list =3D STRING_LIST_INIT_DUP;
 	struct strbuf sb =3D STRBUF_INIT;
 	struct column_options copts;
+	const char *command =3D NULL, *real_command =3D NULL;
 	struct option options[] =3D {
+		OPT_STRING(0, "command", &real_command, "name", "lookup config vars"=
),
 		OPT_COLUMN(0, "mode", &colopts, "layout to use"),
 		OPT_INTEGER(0, "rawmode", &colopts, "layout to use"),
 		OPT_INTEGER(0, "width", &copts.width, "Maximum width"),
@@ -26,6 +33,15 @@ int cmd_column(int argc, const char **argv, const ch=
ar *prefix)
 		OPT_END()
 	};
=20
+	/* This one is special and must be the first one */
+	if (argc > 1 && !prefixcmp(argv[1], "--command=3D")) {
+		int nonitok =3D 0;
+		setup_git_directory_gently(&nonitok);
+
+		command =3D argv[1] + 10;
+		git_config(column_config, (void *)command);
+	}
+
 	memset(&copts, 0, sizeof(copts));
 	copts.width =3D term_columns();
 	copts.padding =3D 1;
@@ -33,6 +49,11 @@ int cmd_column(int argc, const char **argv, const ch=
ar *prefix)
 	if (argc)
 		usage_with_options(builtin_column_usage, options);
=20
+	if (real_command || command) {
+		if (!real_command || !command || strcmp(real_command, command))
+			die(_("--command must be the first argument"));
+	}
+
 	while (!strbuf_getline(&sb, stdin, '\n'))
 		string_list_append(&list, sb.buf);
=20
diff --git a/column.c b/column.c
index 95faec5..67bfd06 100644
--- a/column.c
+++ b/column.c
@@ -2,6 +2,7 @@
 #include "column.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "color.h"
 #include "utf8.h"
=20
 #define MODE(mode) ((mode) & COL_MODE)
@@ -361,6 +362,33 @@ int git_config_column(unsigned int *mode, const ch=
ar *value,
 	return 0;
 }
=20
+static int column_config(const char *var, const char *value,
+			 const char *key, unsigned int *colopts)
+{
+	if (git_config_column(colopts, value, -1))
+		return error("invalid %s mode %s", key, value);
+	return 0;
+}
+
+int git_column_config(const char *var, const char *value,
+		      const char *command, unsigned int *colopts)
+{
+	if (!strcmp(var, "column.ui"))
+		return column_config(var, value, "column.ui", colopts);
+
+	if (command) {
+		struct strbuf sb =3D STRBUF_INIT;
+		int ret =3D 0;
+		strbuf_addf(&sb, "column.%s", command);
+		if (!strcmp(var, sb.buf))
+			ret =3D column_config(var, value, sb.buf, colopts);
+		strbuf_release(&sb);
+		return ret;
+	}
+
+	return 0;
+}
+
 int parseopt_column_callback(const struct option *opt,
 			     const char *arg, int unset)
 {
diff --git a/column.h b/column.h
index eb03c6c..43528da 100644
--- a/column.h
+++ b/column.h
@@ -27,6 +27,8 @@ extern void print_columns(const struct string_list *l=
ist,
 			  struct column_options *opts);
 extern int git_config_column(unsigned int *mode, const char *value,
 			     int stdout_is_tty);
+extern int git_column_config(const char *var, const char *value,
+			     const char *command, unsigned int *colopts);
=20
 struct option;
 extern int parseopt_column_callback(const struct option *opt,
--=20
1.7.8.36.g69ee2
