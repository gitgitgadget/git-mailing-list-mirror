Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CD502023C
	for <e@80x24.org>; Thu, 24 Nov 2016 20:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965960AbcKXUzi (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Nov 2016 15:55:38 -0500
Received: from mout.gmx.net ([212.227.17.22]:65089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964897AbcKXUzh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2016 15:55:37 -0500
Received: from virtualbox ([95.208.59.199]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVIva-1cEvP33pS2-00Yl93; Thu, 24
 Nov 2016 21:55:24 +0100
Date:   Thu, 24 Nov 2016 21:55:07 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v3 1/2] difftool: add a skeleton for the upcoming builtin
In-Reply-To: <cover.1480019834.git.johannes.schindelin@gmx.de>
Message-ID: <3a10fd72cf336743891d6bc9a003cfeb5c3f0063.1480019834.git.johannes.schindelin@gmx.de>
References: <cover.1479938494.git.johannes.schindelin@gmx.de> <cover.1480019834.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hKQiz4OO0QjymZNNWLROAVhood8M8ujiRx/xODR3ug9UhltWhfV
 IYhLkUjb/Fi2TVoP2YlTH3ychsBeqO8alVatY84vyLCNA+sH3LqvFOfl2c/pGQ2FzH1WGdA
 +1hPyGpXDWNkaRZ0bQACAcY3Uo2Rgy89HzFMVgGjFRg4IcbIkml4c3MXraAFyKNl4ceTxAl
 r1O0jJC5bUrr47fu7+2Ig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WV1f8emTl70=:To2M4BG8kjNlC0Tt5im0uy
 FxgdRTewgIs94FShBfxVKtN+YYtUzK+ndEBHb1449DjA6ZOpJaqgxvLW7AsieBuBCqzhAq/UI
 Nlph6CuUC9cnyM2YYVo38L2ruOg/KP3Fq9a6lhTluALeRkMz2s7MAjQ6rH4PWfxNMY14B2enp
 L1OrcWq7Yr995OumE8hrB3HY2bxHYBsgd0LRjAdVtdblsVD9ASyb0u4NVcgFKKJKQLuh2GKiU
 qU2jJmwsG0JKEHuoQRpjo2OEEQX5B/Kk5r6AlyEbwCvSNYA4lwsno/FqzYtZ2pGuqgDE4uMzF
 t3FYc627hMf4SQbibVS28rXsvf1xKj/sRxj0mL/lAq1qevUr3IUrhAu/fsdTQceimW2wUc0zg
 mX37o9g0IPMXT1lox2M1AkS+8WLP2i0f5Vtg+Hv0It3X/yd0oJ0AY2B04cP5sMqrIJzpxgTw8
 f1bw0od0oUwWJaRoaWJW56KkZivzeX2DqFebla0eB9EsRyUV69qQuAA3Otuj5q+vfPAv8Z/ke
 Eredi0n8rv7k0X6oqEL6uH23Q+0XGS6w8ilMJ4Ie2U6X/MLIKOdm1A4ogFjmPoZhpswTCzkOQ
 2EibDyKvu8L1GRiKwTKrGQ8iZRuOZ40tUBfEPXV/CyI+dO0D93rQKWOiSaMAfBP6H9FZNvhuq
 WzBe5DAstWUkxiTijBv1DFdv2vQg4ctc27e4RXeQUYpmnty0WR7szNQil8PHwWem2chAU1wmO
 X2ikfH6hsL4GWqC2qKBFRZ4WOaVJCTVRRwmb0/mKvXssrBOG/azksRq7gPSu6jd2Hv1/RVH9F
 VTVoOve
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds a builtin difftool that still falls back to the legacy Perl
version, which has been renamed to `legacy-difftool`.

The idea is that the new, experimental, builtin difftool immediately hands
off to the legacy difftool for now, unless the config variable
difftool.useBuiltin is set to true.

This feature flag will be used in the upcoming Git for Windows v2.11.0
release, to allow early testers to opt-in to use the builtin difftool and
flesh out any bugs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore                                    |  1 +
 Makefile                                      |  3 +-
 builtin.h                                     |  1 +
 builtin/difftool.c                            | 63 +++++++++++++++++++++++++++
 git-difftool.perl => git-legacy-difftool.perl |  0
 git.c                                         |  6 +++
 t/t7800-difftool.sh                           |  2 +
 7 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 builtin/difftool.c
 rename git-difftool.perl => git-legacy-difftool.perl (100%)

diff --git a/.gitignore b/.gitignore
index 05cb58a..f96e50e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -76,6 +76,7 @@
 /git-init-db
 /git-interpret-trailers
 /git-instaweb
+/git-legacy-difftool
 /git-log
 /git-ls-files
 /git-ls-remote
diff --git a/Makefile b/Makefile
index f53fcc9..7863bc2 100644
--- a/Makefile
+++ b/Makefile
@@ -527,7 +527,7 @@ SCRIPT_LIB += git-sh-setup
 SCRIPT_LIB += git-sh-i18n
 
 SCRIPT_PERL += git-add--interactive.perl
-SCRIPT_PERL += git-difftool.perl
+SCRIPT_PERL += git-legacy-difftool.perl
 SCRIPT_PERL += git-archimport.perl
 SCRIPT_PERL += git-cvsexportcommit.perl
 SCRIPT_PERL += git-cvsimport.perl
@@ -888,6 +888,7 @@ BUILTIN_OBJS += builtin/diff-files.o
 BUILTIN_OBJS += builtin/diff-index.o
 BUILTIN_OBJS += builtin/diff-tree.o
 BUILTIN_OBJS += builtin/diff.o
+BUILTIN_OBJS += builtin/difftool.o
 BUILTIN_OBJS += builtin/fast-export.o
 BUILTIN_OBJS += builtin/fetch-pack.o
 BUILTIN_OBJS += builtin/fetch.o
diff --git a/builtin.h b/builtin.h
index b9122bc..67f8051 100644
--- a/builtin.h
+++ b/builtin.h
@@ -60,6 +60,7 @@ extern int cmd_diff_files(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_index(int argc, const char **argv, const char *prefix);
 extern int cmd_diff(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_difftool(int argc, const char **argv, const char *prefix);
 extern int cmd_fast_export(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
diff --git a/builtin/difftool.c b/builtin/difftool.c
new file mode 100644
index 0000000..53870bb
--- /dev/null
+++ b/builtin/difftool.c
@@ -0,0 +1,63 @@
+/*
+ * "git difftool" builtin command
+ *
+ * This is a wrapper around the GIT_EXTERNAL_DIFF-compatible
+ * git-difftool--helper script.
+ *
+ * This script exports GIT_EXTERNAL_DIFF and GIT_PAGER for use by git.
+ * The GIT_DIFF* variables are exported for use by git-difftool--helper.
+ *
+ * Any arguments that are unknown to this script are forwarded to 'git diff'.
+ *
+ * Copyright (C) 2016 Johannes Schindelin
+ */
+#include "builtin.h"
+#include "run-command.h"
+#include "exec_cmd.h"
+
+/*
+ * NEEDSWORK: this function can go once the legacy-difftool Perl script is
+ * retired.
+ *
+ * We intentionally avoid reading the config directly here, to avoid messing up
+ * the GIT_* environment variables when we need to fall back to exec()ing the
+ * Perl script.
+ */
+static int use_builtin_difftool(void) {
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf out = STRBUF_INIT;
+	int ret;
+
+	argv_array_pushl(&cp.args,
+			 "config", "--bool", "difftool.usebuiltin", NULL);
+	cp.git_cmd = 1;
+	if (capture_command(&cp, &out, 6))
+		return 0;
+	strbuf_trim(&out);
+	ret = !strcmp("true", out.buf);
+	strbuf_release(&out);
+	return ret;
+}
+
+int cmd_difftool(int argc, const char **argv, const char *prefix)
+{
+	/*
+	 * NEEDSWORK: Once the builtin difftool has been tested enough
+	 * and git-legacy-difftool.perl is retired to contrib/, this preamble
+	 * can be removed.
+	 */
+	if (!use_builtin_difftool()) {
+		const char *path = mkpath("%s/git-legacy-difftool",
+					  git_exec_path());
+
+		if (sane_execvp(path, (char **)argv) < 0)
+			die_errno("could not exec %s", path);
+
+		return 0;
+	}
+	prefix = setup_git_directory();
+	trace_repo_setup(prefix);
+	setup_work_tree();
+
+	die("TODO");
+}
diff --git a/git-difftool.perl b/git-legacy-difftool.perl
similarity index 100%
rename from git-difftool.perl
rename to git-legacy-difftool.perl
diff --git a/git.c b/git.c
index e8b2baf..a8e6a15 100644
--- a/git.c
+++ b/git.c
@@ -424,6 +424,12 @@ static struct cmd_struct commands[] = {
 	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
 	{ "diff-index", cmd_diff_index, RUN_SETUP },
 	{ "diff-tree", cmd_diff_tree, RUN_SETUP },
+	/*
+	 * NEEDSWORK: Once the redirection to git-legacy-difftool.perl in
+	 * builtin/difftool.c has been removed, this entry should be changed to
+	 * RUN_SETUP | NEED_WORK_TREE
+	 */
+	{ "difftool", cmd_difftool },
 	{ "fast-export", cmd_fast_export, RUN_SETUP },
 	{ "fetch", cmd_fetch, RUN_SETUP },
 	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 70a2de4..b6a6c30 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -23,6 +23,8 @@ prompt_given ()
 	test "$prompt" = "Launch 'test-tool' [Y/n]? branch"
 }
 
+# NEEDSWORK: lose all the PERL prereqs once legacy-difftool is retired.
+
 # Create a file on master and change it on branch
 test_expect_success PERL 'setup' '
 	echo master >file &&
-- 
2.10.1.583.g721a9e0


