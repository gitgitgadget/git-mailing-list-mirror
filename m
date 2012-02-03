From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 10/13] branch: add --column
Date: Fri,  3 Feb 2012 20:34:35 +0700
Message-ID: <1328276078-27955-11-git-send-email-pclouds@gmail.com>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 14:32:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtJFM-0008Ny-Lh
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 14:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756374Ab2BCNcG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 08:32:06 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39200 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756242Ab2BCNcE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 08:32:04 -0500
Received: by mail-pz0-f46.google.com with SMTP id p15so2737801dad.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 05:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VqopDSF4O0Vir6JjF7I/JTjZila4fQC2EiRVzki+djw=;
        b=AYsENDafXDtvSaKKWzoEDXpw6K3pVt7PT3DaH9Z80AI+2ZVBBOJojgIUpJD1+FOk1E
         Q2cnaL+SpqT6XL3KcqdpjQI+3CbSzEJRMsux5d66W8lrLrITUDlW4TYjILUpeICWIvuK
         x8YC3Mj73FrrlujbdDYSGAftZswsRP14QOvD4=
Received: by 10.68.194.196 with SMTP id hy4mr17457511pbc.105.1328275920909;
        Fri, 03 Feb 2012 05:32:00 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id x4sm13110979pbx.16.2012.02.03.05.31.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 05:31:59 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Fri, 03 Feb 2012 20:36:10 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189768>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt     |    4 ++++
 Documentation/git-branch.txt |    9 +++++++++
 Makefile                     |    2 +-
 builtin/branch.c             |   26 +++++++++++++++++++++++---
 4 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5216598..c14db27 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -847,6 +847,10 @@ column.ui::
 +
 	This option defaults to 'never'.
=20
+column.branch::
+	Specify whether to output branch listing in `git branch` in columns.
+	See `column.ui` for details.
+
 commit.status::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
index 0427e80..ba5cccb 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git branch' [--color[=3D<when>] | --no-color] [-r | -a]
 	[--list] [-v [--abbrev=3D<length> | --no-abbrev]]
+	[--column[=3D<options>] | --no-column]
 	[(--merged | --no-merged | --contains) [<commit>]] [<pattern>...]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branch=
name> [<start-point>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
@@ -107,6 +108,14 @@ OPTIONS
 	default to color output.
 	Same as `--color=3Dnever`.
=20
+--column[=3D<options>]::
+--no-column::
+	Display branch listing in columns. See configuration variable
+	column.branch for option syntax.`--column` and `--no-column`
+	without options are equivalent to 'always' and 'never' respectively.
++
+This option is only applicable in non-verbose mode.
+
 -r::
 --remotes::
 	List or delete (if used with -d) the remote-tracking branches.
diff --git a/Makefile b/Makefile
index 92700ca..061f6e5 100644
--- a/Makefile
+++ b/Makefile
@@ -2116,7 +2116,7 @@ builtin/prune.o builtin/reflog.o reachable.o: rea=
chable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o url.o http-backend.o: url.h
-column.o help.o pager.o: column.h
+builtin/branch.o column.o help.o pager.o: column.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.=
h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h ur=
l.h
=20
diff --git a/builtin/branch.c b/builtin/branch.c
index 7095718..d78690a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -15,6 +15,8 @@
 #include "branch.h"
 #include "diff.h"
 #include "revision.h"
+#include "string-list.h"
+#include "column.h"
=20
 static const char * const builtin_branch_usage[] =3D {
 	"git branch [options] [-r | -a] [--merged | --no-merged]",
@@ -53,6 +55,9 @@ static enum merge_filter {
 } merge_filter;
 static unsigned char merge_filter_ref[20];
=20
+static struct string_list output =3D STRING_LIST_INIT_DUP;
+static int colopts;
+
 static int parse_branch_color_slot(const char *var, int ofs)
 {
 	if (!strcasecmp(var+ofs, "plain"))
@@ -70,6 +75,9 @@ static int parse_branch_color_slot(const char *var, i=
nt ofs)
=20
 static int git_branch_config(const char *var, const char *value, void =
*cb)
 {
+	int status =3D git_column_config(var, value, "branch", &colopts);
+	if (status <=3D 0)
+		return status;
 	if (!strcmp(var, "color.branch")) {
 		branch_use_color =3D git_config_colorbool(var, value);
 		return 0;
@@ -474,7 +482,7 @@ static void print_ref_item(struct ref_item *item, i=
nt maxwidth, int verbose,
 	else if (verbose)
 		/* " f7c0c00 [ahead 58, behind 197] vcs-svn: drop obj_pool.h" */
 		add_verbose_info(&out, item, verbose, abbrev);
-	printf("%s\n", out.buf);
+	print_cell(&output, colopts, out.buf);
 	strbuf_release(&name);
 	strbuf_release(&out);
 }
@@ -727,6 +735,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 			PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG,
 			opt_parse_merge_filter, (intptr_t) "HEAD",
 		},
+		OPT_COLUMN(0, "column", &colopts, "list branches in columns" ),
 		OPT_END(),
 	};
=20
@@ -749,6 +758,9 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 	}
 	hashcpy(merge_filter_ref, head_sha1);
=20
+	if (!colopts)
+		colopts =3D git_colopts | COL_ANSI;
+
 	argc =3D parse_options(argc, argv, prefix, options, builtin_branch_us=
age,
 			     0);
=20
@@ -763,9 +775,17 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
=20
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
-	else if (list)
-		return print_ref_list(kinds, detached, verbose, abbrev,
+	else if (list) {
+		int ret;
+		if (verbose)
+			colopts =3D 0;
+
+		ret =3D print_ref_list(kinds, detached, verbose, abbrev,
 				      with_commit, argv);
+		print_columns(&output, colopts, NULL);
+		string_list_clear(&output, 0);
+		return ret;
+	}
 	else if (edit_description) {
 		const char *branch_name;
 		if (detached)
--=20
1.7.8.36.g69ee2
