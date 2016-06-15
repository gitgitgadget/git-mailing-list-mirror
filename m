From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Add column layout skeleton and git-column
Date: Sat, 21 Apr 2012 11:44:32 +0700
Message-ID: <1334983472-3172-1-git-send-email-pclouds@gmail.com>
References: <xmqqlilpzpiz.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 06:47:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLSEk-0007Fb-8T
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 06:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249Ab2DUErt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Apr 2012 00:47:49 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64623 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547Ab2DUErs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 00:47:48 -0400
Received: by pbcun15 with SMTP id un15so1780945pbc.19
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 21:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YtRkKCHwD7zOAM4bcBd8bEtQUlj0NDKyxMWDyamIDSM=;
        b=UkKIcOmKGdH5Db94VHtTDUPzNOt2Xovbz4c3U6cVgmFZccnW75KgS8k2EjFCbu4U9k
         Hab81/Vx/eLorlcG/7lGAICiu2eDFrTO+LIbrTEIndcODVWlct7tppUuJzNFDRbujglI
         jqBjn3PdXvF5ntIfraolmL8IwyH77XTsUcCv/7dUR303KaZdJADvvABm+MrVhAmBWWYR
         YOHvp+yYD2dApBhmWV9ByHDPTJrlhmSg00uWe1bPkrigaIKcpVq6LbzH+HOH+wQ9Dm8n
         bDUZUp5HV3N3cJ2FVvkBRq8ieZhxxPTG3glwr9dR0GSl/0GJO779zTx50oaO/e3JaHOZ
         HCBA==
Received: by 10.68.204.234 with SMTP id lb10mr4507313pbc.161.1334983667457;
        Fri, 20 Apr 2012 21:47:47 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.45.28])
        by mx.google.com with ESMTPS id os8sm6623383pbc.14.2012.04.20.21.47.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 Apr 2012 21:47:46 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 21 Apr 2012 11:44:34 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <xmqqlilpzpiz.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196039>

A column option string consists of many token separated by either
a space or a  comma. A token belongs to one of three groups:

 - enabling: always, never and auto
 - layout mode: currently plain (which does not layout at all)
 - other future tuning flags

git-column can be used to pipe output to from a command that wants
column layout, but not to mess with its own output code. Simpler output
code can be changed to use column layout code directly.

Thanks-to: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 2012/4/21 Junio C Hamano <gitster@pobox.com>:
 > Am I looking at the correct version?  Somehow I thought you eliminat=
ed
 > this confusingly named macro in the previous round.  Two steps forwa=
rd,
 > one step backward???

 Aah.. the beautiful result of having the same series (but probably
 different versions) across several machines.. This version should be
 the right one with fixes.

 .gitignore                   |    1 +
 Documentation/config.txt     |   18 +++++
 Documentation/git-column.txt |   53 +++++++++++++
 Makefile                     |    3 +
 builtin.h                    |    1 +
 builtin/column.c             |   59 +++++++++++++++
 column.c                     |  169 ++++++++++++++++++++++++++++++++++=
++++++++
 column.h                     |   38 ++++++++++
 command-list.txt             |    1 +
 git.c                        |    1 +
 parse-options.h              |    2 +
 t/t9002-column.sh            |   45 +++++++++++
 12 files changed, 391 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-column.txt
 create mode 100644 builtin/column.c
 create mode 100644 column.c
 create mode 100644 column.h
 create mode 100755 t/t9002-column.sh

diff --git a/.gitignore b/.gitignore
index 87fcc5f..2540264 100644
--- a/.gitignore
+++ b/.gitignore
@@ -26,6 +26,7 @@
 /git-cherry-pick
 /git-clean
 /git-clone
+/git-column
 /git-commit
 /git-commit-tree
 /git-config
diff --git a/Documentation/config.txt b/Documentation/config.txt
index e55dae1..9aabef1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -836,6 +836,24 @@ color.ui::
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
+`plain`;;
+	show in one column
+--
++
+	This option defaults to 'never'.
+
 commit.status::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
diff --git a/Documentation/git-column.txt b/Documentation/git-column.tx=
t
new file mode 100644
index 0000000..9be16ee
--- /dev/null
+++ b/Documentation/git-column.txt
@@ -0,0 +1,53 @@
+git-column(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-column - Display data in columns
+
+SYNOPSIS
+--------
+[verse]
+'git column' [--command=3D<name>] [--[raw-]mode=3D<mode>] [--width=3D<=
width>]
+	     [--indent=3D<string>] [--nl=3D<string>] [--pading=3D<n>]
+
+DESCRIPTION
+-----------
+This command formats its input into multiple columns.
+
+OPTIONS
+-------
+--command=3D<name>::
+	Look up layout mode using configuration variable column.<name> and
+	column.ui.
+
+--mode=3D<mode>::
+	Specify layout mode. See configuration variable column.ui for option
+	syntax.
+
+--raw-mode=3D<n>::
+	Same as --mode but take mode encoded as a number. This is mainly used
+	by other commands that have already parsed layout mode.
+
+--width=3D<width>::
+	Specify the terminal width. By default 'git column' will detect the
+	terminal width, or fall back to 80 if it is unable to do so.
+
+--indent=3D<string>::
+	String to be printed at the beginning of each line.
+
+--nl=3D<N>::
+	String to be printed at the end of each line,
+	including newline character.
+
+--padding=3D<N>::
+	The number of spaces between columns. One space by default.
+
+
+Author
+------
+Written by Nguyen Thai Ngoc Duy <pclouds@gmail.com>
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 1fb1705..b579b6b 100644
--- a/Makefile
+++ b/Makefile
@@ -646,6 +646,7 @@ LIB_OBJS +=3D bulk-checkin.o
 LIB_OBJS +=3D bundle.o
 LIB_OBJS +=3D cache-tree.o
 LIB_OBJS +=3D color.o
+LIB_OBJS +=3D column.o
 LIB_OBJS +=3D combine-diff.o
 LIB_OBJS +=3D commit.o
 LIB_OBJS +=3D compat/obstack.o
@@ -774,6 +775,7 @@ BUILTIN_OBJS +=3D builtin/checkout-index.o
 BUILTIN_OBJS +=3D builtin/checkout.o
 BUILTIN_OBJS +=3D builtin/clean.o
 BUILTIN_OBJS +=3D builtin/clone.o
+BUILTIN_OBJS +=3D builtin/column.o
 BUILTIN_OBJS +=3D builtin/commit-tree.o
 BUILTIN_OBJS +=3D builtin/commit.o
 BUILTIN_OBJS +=3D builtin/config.o
@@ -2166,6 +2168,7 @@ builtin/prune.o builtin/reflog.o reachable.o: rea=
chable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o url.o http-backend.o: url.h
+column.o help.o pager.o: column.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.=
h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h ur=
l.h
=20
diff --git a/builtin.h b/builtin.h
index 857b9c8..338f540 100644
--- a/builtin.h
+++ b/builtin.h
@@ -61,6 +61,7 @@ extern int cmd_cherry(int argc, const char **argv, co=
nst char *prefix);
 extern int cmd_cherry_pick(int argc, const char **argv, const char *pr=
efix);
 extern int cmd_clone(int argc, const char **argv, const char *prefix);
 extern int cmd_clean(int argc, const char **argv, const char *prefix);
+extern int cmd_column(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_commit(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_commit_tree(int argc, const char **argv, const char *pr=
efix);
 extern int cmd_config(int argc, const char **argv, const char *prefix)=
;
diff --git a/builtin/column.c b/builtin/column.c
new file mode 100644
index 0000000..5ea798a
--- /dev/null
+++ b/builtin/column.c
@@ -0,0 +1,59 @@
+#include "builtin.h"
+#include "cache.h"
+#include "strbuf.h"
+#include "parse-options.h"
+#include "string-list.h"
+#include "column.h"
+
+static const char * const builtin_column_usage[] =3D {
+	"git column [options]",
+	NULL
+};
+static unsigned int colopts;
+
+static int column_config(const char *var, const char *value, void *cb)
+{
+	return git_column_config(var, value, cb, &colopts);
+}
+
+int cmd_column(int argc, const char **argv, const char *prefix)
+{
+	struct string_list list =3D STRING_LIST_INIT_DUP;
+	struct strbuf sb =3D STRBUF_INIT;
+	struct column_options copts;
+	const char *command =3D NULL, *real_command =3D NULL;
+	struct option options[] =3D {
+		OPT_STRING(0, "command", &real_command, "name", "lookup config vars"=
),
+		OPT_COLUMN(0, "mode", &colopts, "layout to use"),
+		OPT_INTEGER(0, "raw-mode", &colopts, "layout to use"),
+		OPT_INTEGER(0, "width", &copts.width, "Maximum width"),
+		OPT_STRING(0, "indent", &copts.indent, "string", "Padding space on l=
eft border"),
+		OPT_INTEGER(0, "nl", &copts.nl, "Padding space on right border"),
+		OPT_INTEGER(0, "padding", &copts.padding, "Padding space between col=
umns"),
+		OPT_END()
+	};
+
+	/* This one is special and must be the first one */
+	if (argc > 1 && !prefixcmp(argv[1], "--command=3D")) {
+		command =3D argv[1] + 10;
+		git_config(column_config, (void *)command);
+	} else
+		git_config(column_config, NULL);
+
+	memset(&copts, 0, sizeof(copts));
+	copts.width =3D term_columns();
+	copts.padding =3D 1;
+	argc =3D parse_options(argc, argv, "", options, builtin_column_usage,=
 0);
+	if (argc)
+		usage_with_options(builtin_column_usage, options);
+	if (real_command || command) {
+		if (!real_command || !command || strcmp(real_command, command))
+			die(_("--command must be the first argument"));
+	}
+	finalize_colopts(&colopts, -1);
+	while (!strbuf_getline(&sb, stdin, '\n'))
+		string_list_append(&list, sb.buf);
+
+	print_columns(&list, colopts, &copts);
+	return 0;
+}
diff --git a/column.c b/column.c
new file mode 100644
index 0000000..3349f58
--- /dev/null
+++ b/column.c
@@ -0,0 +1,169 @@
+#include "cache.h"
+#include "column.h"
+#include "string-list.h"
+#include "parse-options.h"
+
+/* Display without layout when not enabled */
+static void display_plain(const struct string_list *list,
+			  const char *indent, const char *nl)
+{
+	int i;
+
+	for (i =3D 0; i < list->nr; i++)
+		printf("%s%s%s", indent, list->items[i].string, nl);
+}
+
+void print_columns(const struct string_list *list, unsigned int colopt=
s,
+		   const struct column_options *opts)
+{
+	struct column_options nopts;
+
+	if (!list->nr)
+		return;
+	assert((colopts & COL_ENABLE_MASK) !=3D COL_AUTO);
+
+	memset(&nopts, 0, sizeof(nopts));
+	nopts.indent =3D opts && opts->indent ? opts->indent : "";
+	nopts.nl =3D opts && opts->nl ? opts->nl : "\n";
+	nopts.padding =3D opts ? opts->padding : 1;
+	nopts.width =3D opts && opts->width ? opts->width : term_columns() - =
1;
+	if (!column_active(colopts)) {
+		display_plain(list, "", "\n");
+		return;
+	}
+	switch (COL_LAYOUT(colopts)) {
+	case COL_PLAIN:
+		display_plain(list, nopts.indent, nopts.nl);
+		break;
+	default:
+		die("BUG: invalid layout mode %d", COL_LAYOUT(colopts));
+	}
+}
+
+int finalize_colopts(unsigned int *colopts, int stdout_is_tty)
+{
+	if ((*colopts & COL_ENABLE_MASK) =3D=3D COL_AUTO) {
+		if (stdout_is_tty < 0)
+			stdout_is_tty =3D isatty(1);
+		*colopts &=3D ~COL_ENABLE_MASK;
+		if (stdout_is_tty)
+			*colopts |=3D COL_ENABLED;
+	}
+	return 0;
+}
+
+struct colopt {
+	const char *name;
+	unsigned int value;
+	unsigned int mask;
+};
+
+#define LAYOUT_SET 1
+#define ENABLE_SET 2
+
+static int parse_option(const char *arg, int len, unsigned int *colopt=
s,
+			int *group_set)
+{
+	struct colopt opts[] =3D {
+		{ "always", COL_ENABLED,  COL_ENABLE_MASK },
+		{ "never",  COL_DISABLED, COL_ENABLE_MASK },
+		{ "auto",   COL_AUTO,     COL_ENABLE_MASK },
+		{ "plain",  COL_PLAIN,    COL_LAYOUT_MASK },
+	};
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(opts); i++) {
+		int arg_len =3D len, name_len;
+		const char *arg_str =3D arg;
+
+		name_len =3D strlen(opts[i].name);
+		if (arg_len !=3D name_len ||
+		    strncmp(arg_str, opts[i].name, name_len))
+			continue;
+
+		switch (opts[i].mask) {
+		case COL_ENABLE_MASK:
+			*group_set |=3D ENABLE_SET;
+			break;
+		case COL_LAYOUT_MASK:
+			*group_set |=3D LAYOUT_SET;
+			break;
+		}
+
+		if (opts[i].mask)
+			*colopts =3D (*colopts & ~opts[i].mask) | opts[i].value;
+		return 0;
+	}
+
+	return error("unsupported option '%s'", arg);
+}
+
+static int parse_config(unsigned int *colopts, const char *value)
+{
+	const char *sep =3D " ,";
+	int group_set =3D 0;
+
+	while (*value) {
+		int len =3D strcspn(value, sep);
+		if (len) {
+			if (parse_option(value, len, colopts, &group_set))
+				return -1;
+
+			value +=3D len;
+		}
+		value +=3D strspn(value, sep);
+	}
+	/*
+	 * Setting layout implies "always" if neither always, never
+	 * nor auto is specified.
+	 *
+	 * Current value in COL_ENABLE_MASK is disregarded. This means if
+	 * you set column.ui =3D auto and pass --column=3Drow, then "auto"
+	 * will become "always".
+	 */
+	if ((group_set & LAYOUT_SET) && !(group_set & ENABLE_SET))
+		*colopts =3D (*colopts & ~COL_ENABLE_MASK) | COL_ENABLED;
+	return 0;
+}
+
+static int column_config(const char *var, const char *value,
+			 const char *key, unsigned int *colopts)
+{
+	if (!value)
+		return config_error_nonbool(var);
+	if (parse_config(colopts, value))
+		return error("invalid column.%s mode %s", key, value);
+	return 0;
+}
+
+int git_column_config(const char *var, const char *value,
+		      const char *command, unsigned int *colopts)
+{
+	const char *it =3D skip_prefix(var, "column.");
+	if (!it)
+		return 0;
+
+	if (!strcmp(it, "ui"))
+		return column_config(var, value, "ui", colopts);
+
+	if (command && !strcmp(it, command))
+		return column_config(var, value, it, colopts);
+
+	return 0;
+}
+
+int parseopt_column_callback(const struct option *opt,
+			     const char *arg, int unset)
+{
+	unsigned int *colopts =3D opt->value;
+	*colopts |=3D COL_PARSEOPT;
+	*colopts &=3D ~COL_ENABLE_MASK;
+	if (unset)		/* --no-column =3D=3D never */
+		return 0;
+	/* --column =3D=3D always unless "arg" states otherwise */
+	*colopts |=3D COL_ENABLED;
+	if (arg)
+		return parse_config(colopts, arg);
+
+	return 0;
+}
diff --git a/column.h b/column.h
new file mode 100644
index 0000000..b8719b3
--- /dev/null
+++ b/column.h
@@ -0,0 +1,38 @@
+#ifndef COLUMN_H
+#define COLUMN_H
+
+#define COL_LAYOUT_MASK   0x000F
+#define COL_ENABLE_MASK   0x0030   /* always, never or auto */
+#define COL_PARSEOPT      0x0040   /* --column is given from cmdline *=
/
+
+#define COL_DISABLED      0x0000   /* must be zero */
+#define COL_ENABLED       0x0010
+#define COL_AUTO          0x0020
+
+#define COL_LAYOUT(c) ((c) & COL_LAYOUT_MASK)
+#define COL_PLAIN             15   /* one column */
+
+#define explicitly_enable_column(c) \
+	(((c) & COL_PARSEOPT) && column_active(c))
+
+struct column_options {
+	int width;
+	int padding;
+	const char *indent;
+	const char *nl;
+};
+
+struct option;
+extern int parseopt_column_callback(const struct option *, const char =
*, int);
+extern int git_column_config(const char *var, const char *value,
+			     const char *command, unsigned int *colopts);
+extern int finalize_colopts(unsigned int *colopts, int stdout_is_tty);
+static inline int column_active(unsigned int colopts)
+{
+	return (colopts & COL_ENABLE_MASK) =3D=3D COL_ENABLED;
+}
+
+extern void print_columns(const struct string_list *list, unsigned int=
 colopts,
+			  const struct column_options *opts);
+
+#endif
diff --git a/command-list.txt b/command-list.txt
index a36ee9b..fe06f15 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -20,6 +20,7 @@ git-cherry-pick                         mainporcelain
 git-citool                              mainporcelain
 git-clean                               mainporcelain
 git-clone                               mainporcelain common
+git-column                              purehelpers
 git-commit                              mainporcelain common
 git-commit-tree                         plumbingmanipulators
 git-config                              ancillarymanipulators
diff --git a/git.c b/git.c
index 3805616..ee727cb 100644
--- a/git.c
+++ b/git.c
@@ -348,6 +348,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
 		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
 		{ "clone", cmd_clone },
+		{ "column", cmd_column, RUN_SETUP_GENTLY },
 		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "config", cmd_config, RUN_SETUP_GENTLY },
diff --git a/parse-options.h b/parse-options.h
index 2e811dc..56fcafd 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -238,5 +238,7 @@ extern int parse_opt_noop_cb(const struct option *,=
 const char *, int);
 	  PARSE_OPT_OPTARG, &parse_opt_abbrev_cb, 0 }
 #define OPT__COLOR(var, h) \
 	OPT_COLOR_FLAG(0, "color", (var), (h))
+#define OPT_COLUMN(s, l, v, h) \
+	{ OPTION_CALLBACK, (s), (l), (v), "style", (h), PARSE_OPT_OPTARG, par=
seopt_column_callback }
=20
 #endif
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
new file mode 100755
index 0000000..a7f3cd9
--- /dev/null
+++ b/t/t9002-column.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description=3D'git column'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	cat >lista <<\EOF
+one
+two
+three
+four
+five
+six
+seven
+eight
+nine
+ten
+eleven
+EOF
+'
+
+test_expect_success 'never' '
+	git column --indent=3DZ --mode=3Dnever <lista >actual &&
+	test_cmp lista actual
+'
+
+test_expect_success 'always' '
+	cat >expected <<\EOF &&
+Zone
+Ztwo
+Zthree
+Zfour
+Zfive
+Zsix
+Zseven
+Zeight
+Znine
+Zten
+Zeleven
+EOF
+	git column --indent=3DZ --mode=3Dplain <lista >actual &&
+	test_cmp expected actual
+'
+
+test_done
--=20
1.7.8.36.g69ee2
