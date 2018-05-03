Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4082200B9
	for <e@80x24.org>; Thu,  3 May 2018 15:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeECPak (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 11:30:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:60557 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751277AbeECPah (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 11:30:37 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MOCSm-1fJmUc3lQa-005bLH; Thu, 03 May 2018 17:30:31 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/18] Add a new builtin: branch-diff
Date:   Thu,  3 May 2018 17:30:30 +0200
Message-Id: <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g0f525fc0ba7
In-Reply-To: <cover.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8Gvq54tC91qvxkJcx2mCkeswek0K0khr7Aj1T5fPcLSfDm51VXv
 Dy2l3Vsdc8NXV2AkNpikq0d6dTa7q0ZC2/3WKazCmf0pBGLM+MixRLqmncMvwgQIkAbg3ma
 BylVhiMNu3L3FBLhSxs74pcwtY7YplafIh9JxkUUt+cY+S7XchT/zRWrVBvwHcL7Z4VIIUD
 188R2WmQfyt1QJ664MicQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2OLHwQcXAN8=:4lKbFSSbjmy72r2x3RtH2j
 tnrLr/ezq9dCHHI/+ZHBKytKhmbm0hsYT3FIqPkk6v5jIWGCFu9527A7mzkn33SVYGiX2cuvs
 Dop4ssE3azL+PGHgK2Lr5H/KHvdOOqOS4E5z7ju2tJahWdHb6Z1SUZDw+fk69Tozoqi1JTwHt
 lcMBmSRaBDDGy9R9ms8a6N9EffPKZGroqwJllbvzflIMOQdRLPYhhQ8kf7fZixr3M7CVsYT+k
 gCylEn1DK1SguB5fRioPEQk7ERGlbkWNwtcyZQ1HKlRwaJHmLrwYDLcHdih+nhaVc0ckHxOZb
 bzlhWTXOURFP7R47MYztbWAehCu+ivlzbNtZqCAxDWI9t8awTmFNk3TNCR4SWDu7dWCtgIsgm
 FbX2/FDOBAC6/IuY9K0PWjPREdB6qJpSEts//P4iKanJyeMw1uoIiGg7La3KvkRcJfJkRndep
 Ds0ueslPfRSbZX9v6NHE86rrTavweTOzf0UCzM2PARaTOVjKQabXCQvj7ZFQSEbWU3mryIZ51
 i/yl3ZUMgtkuHlVtCMhEdi8QiM2tM6c+WrQY/LkDtC91DchZRSSPxCGU/TUuyNyXy/9Ay6avq
 6irzecnhe/kMr5gUYsJ9m9Cs8PmCz13P54OqXdkUqyEjIlHeSgt2S/w4hdKpDIn6Kjk7Yzfwm
 MmryhoyV91KyPWs0xlS3ZTVtmkyV59X3HqTugBawgjIXY9G9Wk3BF4Nsd1+0I8Yq7Z4b4jRPC
 x4XV+jy9MsFFv9s2sjaS+Eu+rKM5tpCBBUZ8jCg+e9BocQXdbSBJzsoFzhsmwdop8GUJwmCzo
 282NFtw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This builtin does not do a whole lot so far, apart from showing a usage
that is oddly similar to that of `git tbdiff`. And for a good reason:
the next commits will turn `branch-diff` into a full-blown replacement
for `tbdiff`.

At this point, we ignore tbdiff's color options, as they will all be
implemented later and require some patches to the diff machinery.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore            |  1 +
 Makefile              |  1 +
 builtin.h             |  1 +
 builtin/branch-diff.c | 40 ++++++++++++++++++++++++++++++++++++++++
 command-list.txt      |  1 +
 git.c                 |  1 +
 6 files changed, 45 insertions(+)
 create mode 100644 builtin/branch-diff.c

diff --git a/.gitignore b/.gitignore
index 833ef3b0b78..1346a64492f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -20,6 +20,7 @@
 /git-bisect--helper
 /git-blame
 /git-branch
+/git-branch-diff
 /git-bundle
 /git-cat-file
 /git-check-attr
diff --git a/Makefile b/Makefile
index 96f2e76a904..9b1984776d8 100644
--- a/Makefile
+++ b/Makefile
@@ -953,6 +953,7 @@ BUILTIN_OBJS += builtin/archive.o
 BUILTIN_OBJS += builtin/bisect--helper.o
 BUILTIN_OBJS += builtin/blame.o
 BUILTIN_OBJS += builtin/branch.o
+BUILTIN_OBJS += builtin/branch-diff.o
 BUILTIN_OBJS += builtin/bundle.o
 BUILTIN_OBJS += builtin/cat-file.o
 BUILTIN_OBJS += builtin/check-attr.o
diff --git a/builtin.h b/builtin.h
index 42378f3aa47..e1c4d2a529a 100644
--- a/builtin.h
+++ b/builtin.h
@@ -135,6 +135,7 @@ extern int cmd_archive(int argc, const char **argv, const char *prefix);
 extern int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_blame(int argc, const char **argv, const char *prefix);
 extern int cmd_branch(int argc, const char **argv, const char *prefix);
+extern int cmd_branch_diff(int argc, const char **argv, const char *prefix);
 extern int cmd_bundle(int argc, const char **argv, const char *prefix);
 extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout(int argc, const char **argv, const char *prefix);
diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
new file mode 100644
index 00000000000..97266cd326d
--- /dev/null
+++ b/builtin/branch-diff.c
@@ -0,0 +1,40 @@
+#include "cache.h"
+#include "parse-options.h"
+
+static const char * const builtin_branch_diff_usage[] = {
+	N_("git rebase--helper [<options>] ( A..B C..D | A...B | base A B )"),
+	NULL
+};
+
+#define COLOR_DUAL_MODE 2
+
+static int parse_creation_weight(const struct option *opt, const char *arg,
+				 int unset)
+{
+	double *d = opt->value;
+	if (unset)
+		*d = 0.6;
+	else
+		*d = atof(arg);
+	return 0;
+}
+
+int cmd_branch_diff(int argc, const char **argv, const char *prefix)
+{
+	int no_patches = 0;
+	double creation_weight = 0.6;
+	struct option options[] = {
+		OPT_BOOL(0, "no-patches", &no_patches,
+			 N_("short format (no diffs)")),
+		{ OPTION_CALLBACK,
+			0, "creation-weight", &creation_weight, N_("factor"),
+			N_("Fudge factor by which creation is weighted [0.6]"),
+			0, parse_creation_weight },
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL, options,
+			builtin_branch_diff_usage, 0);
+
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index a1fad28fd82..c89ac8f417f 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -19,6 +19,7 @@ git-archive                             mainporcelain
 git-bisect                              mainporcelain           info
 git-blame                               ancillaryinterrogators
 git-branch                              mainporcelain           history
+git-branch-diff                         mainporcelain           info
 git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
 git-check-attr                          purehelpers
diff --git a/git.c b/git.c
index f598fae7b7a..d2794fb6f5d 100644
--- a/git.c
+++ b/git.c
@@ -377,6 +377,7 @@ static struct cmd_struct commands[] = {
 	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
+	{ "branch-diff", cmd_branch_diff, RUN_SETUP | USE_PAGER },
 	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "cat-file", cmd_cat_file, RUN_SETUP },
 	{ "check-attr", cmd_check_attr, RUN_SETUP },
-- 
2.17.0.395.g6a618d6010f.dirty


