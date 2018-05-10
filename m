Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05F191F42D
	for <e@80x24.org>; Thu, 10 May 2018 08:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756884AbeEJIrL (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 04:47:11 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33455 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756777AbeEJIrD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 04:47:03 -0400
Received: by mail-lf0-f66.google.com with SMTP id h9-v6so837532lfi.0
        for <git@vger.kernel.org>; Thu, 10 May 2018 01:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xs2RtsxOR7oHlynQBFMHd8dkZJcDwU/ErTnWrfJQGWg=;
        b=nXM6dfutrT0wE0PRijjfPrCJoCp8859UxcO/PSQZ7QMZ6JAsFoY2bBEEZ4NyKNpvdi
         kHZz6EF1VCbUIGUt5NHl0sJq6iWFY7DoMhDkBolLpH/TDEA7ER+hsurcJNB2TfoRuGOG
         xQLU1LjJP7NMJOZb7CxfM6pookveRO1cg4f0jiQ6z1sFuggxlHYhCsijfYpllnbvmobR
         g1Kqlw7TeUn8AXk6u4BRjVuSlt3twnRNlxAnplAhtEYqdZIHABYFxElTApyhRv5C6I9F
         AvUNogmeqWxdr1GLA8aK3fnTqcEqWvc0F4B2JbIWGkLEFjgSDI/yPUB5ly6CWjNKDyvc
         U0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xs2RtsxOR7oHlynQBFMHd8dkZJcDwU/ErTnWrfJQGWg=;
        b=JlZSUMBupKtVLbUasm7o69Lc4iKw5zUKaT/74cFzmnDAzpRzB/46y3mX2cmlW6my2u
         LjMUa6ibKsy7/tSrhT9nmPKix394BU5NWzVQ4K4zxNdCBAEwGmzXxARImtxDZS2VB/55
         N0u83TfBY0QzeC8bgOvpka2M/V9AEKKh0hS7qUHUBpXlfEoM4ea5pjYVjbhQEVMe+czM
         Zlz5pNNUVTNGY3enFuSsHmXK7I1/mCWPMbi23CbeenPr5a01Sxf7RO634VRGPR35N5AW
         fUdxq2JXIAdvT5RI/enjMEwo2/t2ETq2RuI1YhDg2Aks5L5oHfW8fH/5XsRsaSbE7zeI
         oS3g==
X-Gm-Message-State: ALKqPwf38TFn71WrZy9PYEBkZ9k8+Bl7MQVIUwAMtpSJlXCj0yN5cuK8
        6zz7z3NR69JrIZYXIck06Ag=
X-Google-Smtp-Source: AB8JxZqWNvLo6Lr1SKm9pG+7/H6qTXsZs0nfe/2jq7Qs0JcdHXOgJ1lp+CyiHZ5fhKbZoBistdIbTQ==
X-Received: by 2002:a19:1054:: with SMTP id f81-v6mr434862lfi.67.1525942021623;
        Thu, 10 May 2018 01:47:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id l24-v6sm68024lje.42.2018.05.10.01.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 01:47:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v7 03/13] help: use command-list.h for common command list
Date:   Thu, 10 May 2018 10:46:42 +0200
Message-Id: <20180510084652.25880-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180510084652.25880-1-pclouds@gmail.com>
References: <20180507175222.12114-1-pclouds@gmail.com>
 <20180510084652.25880-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit added code generation for all_cmd_desc[] which
includes almost everything we need to generate common command list.
Convert help code to use that array instead and drop common_cmds[] array.

The description of each common command group is removed from
command-list.txt. This keeps this file format simpler. common-cmds.h
will not be generated correctly after this change due to the
command-list.txt format change. But it does not matter and
common-cmds.h will be removed.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile            |   4 +-
 command-list.txt    |  10 ---
 generate-cmdlist.sh |   4 +-
 help.c              | 145 +++++++++++++++++++++++++++++++++-----------
 t/t0012-help.sh     |   9 +++
 5 files changed, 122 insertions(+), 50 deletions(-)

diff --git a/Makefile b/Makefile
index 2a8913ea21..5c58b0b692 100644
--- a/Makefile
+++ b/Makefile
@@ -1914,9 +1914,9 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
 
-help.sp help.s help.o: common-cmds.h
+help.sp help.s help.o: common-cmds.h command-list.h
 
-builtin/help.sp builtin/help.s builtin/help.o: common-cmds.h GIT-PREFIX
+builtin/help.sp builtin/help.s builtin/help.o: common-cmds.h command-list.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
diff --git a/command-list.txt b/command-list.txt
index 786536aba0..3bd23201a6 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -1,13 +1,3 @@
-# common commands are grouped by themes
-# these groups are output by 'git help' in the order declared here.
-# map each common command in the command list to one of these groups.
-### common groups (do not change this line)
-init         start a working area (see also: git help tutorial)
-worktree     work on the current change (see also: git help everyday)
-info         examine the history and state (see also: git help revisions)
-history      grow, mark and tweak your common history
-remote       collaborate (see also: git help workflows)
-
 ### command list (do not change this line, also do not change alignment)
 # command name                          category [category] [category]
 git-add                                 mainporcelain           worktree
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 870d3b626a..9eb22c4ef1 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -6,7 +6,7 @@ die () {
 }
 
 command_list () {
-	sed '1,/^### command list/d;/^#/d' "$1"
+	grep -v '^#' "$1"
 }
 
 get_categories () {
@@ -65,7 +65,7 @@ echo "/* Automatically generated by generate-cmdlist.sh */
 struct cmdname_help {
 	const char *name;
 	const char *help;
-	uint32_t group;
+	uint32_t category;
 };
 "
 if test -z "$2"
diff --git a/help.c b/help.c
index 60071a9bea..2d6a3157f8 100644
--- a/help.c
+++ b/help.c
@@ -5,13 +5,114 @@
 #include "run-command.h"
 #include "levenshtein.h"
 #include "help.h"
-#include "common-cmds.h"
+#include "command-list.h"
 #include "string-list.h"
 #include "column.h"
 #include "version.h"
 #include "refs.h"
 #include "parse-options.h"
 
+struct category_description {
+	uint32_t category;
+	const char *desc;
+};
+static uint32_t common_mask =
+	CAT_init | CAT_worktree | CAT_info |
+	CAT_history | CAT_remote;
+static struct category_description common_categories[] = {
+	{ CAT_init, N_("start a working area (see also: git help tutorial)") },
+	{ CAT_worktree, N_("work on the current change (see also: git help everyday)") },
+	{ CAT_info, N_("examine the history and state (see also: git help revisions)") },
+	{ CAT_history, N_("grow, mark and tweak your common history") },
+	{ CAT_remote, N_("collaborate (see also: git help workflows)") },
+	{ 0, NULL }
+};
+
+static const char *drop_prefix(const char *name)
+{
+	const char *new_name;
+
+	if (skip_prefix(name, "git-", &new_name))
+		return new_name;
+	return name;
+
+}
+
+static void extract_cmds(struct cmdname_help **p_cmds, uint32_t mask)
+{
+	int i, nr = 0;
+	struct cmdname_help *cmds;
+
+	if (ARRAY_SIZE(command_list) == 0)
+		BUG("empty command_list[] is a sign of broken generate-cmdlist.sh");
+
+	ALLOC_ARRAY(cmds, ARRAY_SIZE(command_list) + 1);
+
+	for (i = 0; i < ARRAY_SIZE(command_list); i++) {
+		const struct cmdname_help *cmd = command_list + i;
+
+		if (!(cmd->category & mask))
+			continue;
+
+		cmds[nr] = *cmd;
+		cmds[nr].name = drop_prefix(cmd->name);
+
+		nr++;
+	}
+	cmds[nr].name = NULL;
+	*p_cmds = cmds;
+}
+
+static void print_command_list(const struct cmdname_help *cmds,
+			       uint32_t mask, int longest)
+{
+	int i;
+
+	for (i = 0; cmds[i].name; i++) {
+		if (cmds[i].category & mask) {
+			printf("   %s   ", cmds[i].name);
+			mput_char(' ', longest - strlen(cmds[i].name));
+			puts(_(cmds[i].help));
+		}
+	}
+}
+
+static int cmd_name_cmp(const void *elem1, const void *elem2)
+{
+	const struct cmdname_help *e1 = elem1;
+	const struct cmdname_help *e2 = elem2;
+
+	return strcmp(e1->name, e2->name);
+}
+
+static void print_cmd_by_category(const struct category_description *catdesc)
+{
+	struct cmdname_help *cmds;
+	int longest = 0;
+	int i, nr = 0;
+	uint32_t mask = 0;
+
+	for (i = 0; catdesc[i].desc; i++)
+		mask |= catdesc[i].category;
+
+	extract_cmds(&cmds, mask);
+
+	for (i = 0; cmds[i].name; i++, nr++) {
+		if (longest < strlen(cmds[i].name))
+			longest = strlen(cmds[i].name);
+	}
+	QSORT(cmds, nr, cmd_name_cmp);
+
+	for (i = 0; catdesc[i].desc; i++) {
+		uint32_t mask = catdesc[i].category;
+		const char *desc = catdesc[i].desc;
+
+		printf("\n%s\n", _(desc));
+		print_command_list(cmds, mask, longest);
+	}
+	free(cmds);
+}
+
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
 	struct cmdname *ent;
@@ -190,42 +291,10 @@ void list_commands(unsigned int colopts,
 	}
 }
 
-static int cmd_group_cmp(const void *elem1, const void *elem2)
-{
-	const struct cmdname_help *e1 = elem1;
-	const struct cmdname_help *e2 = elem2;
-
-	if (e1->group < e2->group)
-		return -1;
-	if (e1->group > e2->group)
-		return 1;
-	return strcmp(e1->name, e2->name);
-}
-
 void list_common_cmds_help(void)
 {
-	int i, longest = 0;
-	int current_grp = -1;
-
-	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		if (longest < strlen(common_cmds[i].name))
-			longest = strlen(common_cmds[i].name);
-	}
-
-	QSORT(common_cmds, ARRAY_SIZE(common_cmds), cmd_group_cmp);
-
 	puts(_("These are common Git commands used in various situations:"));
-
-	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		if (common_cmds[i].group != current_grp) {
-			printf("\n%s\n", _(common_cmd_groups[common_cmds[i].group]));
-			current_grp = common_cmds[i].group;
-		}
-
-		printf("   %s   ", common_cmds[i].name);
-		mput_char(' ', longest - strlen(common_cmds[i].name));
-		puts(_(common_cmds[i].help));
-	}
+	print_cmd_by_category(common_categories);
 }
 
 int is_in_cmdlist(struct cmdnames *c, const char *s)
@@ -285,6 +354,7 @@ const char *help_unknown_cmd(const char *cmd)
 {
 	int i, n, best_similarity = 0;
 	struct cmdnames main_cmds, other_cmds;
+	struct cmdname_help *common_cmds;
 
 	memset(&main_cmds, 0, sizeof(main_cmds));
 	memset(&other_cmds, 0, sizeof(other_cmds));
@@ -299,6 +369,8 @@ const char *help_unknown_cmd(const char *cmd)
 	QSORT(main_cmds.names, main_cmds.cnt, cmdname_compare);
 	uniq(&main_cmds);
 
+	extract_cmds(&common_cmds, common_mask);
+
 	/* This abuses cmdname->len for levenshtein distance */
 	for (i = 0, n = 0; i < main_cmds.cnt; i++) {
 		int cmp = 0; /* avoid compiler stupidity */
@@ -313,10 +385,10 @@ const char *help_unknown_cmd(const char *cmd)
 			die(_(bad_interpreter_advice), cmd, cmd);
 
 		/* Does the candidate appear in common_cmds list? */
-		while (n < ARRAY_SIZE(common_cmds) &&
+		while (common_cmds[n].name &&
 		       (cmp = strcmp(common_cmds[n].name, candidate)) < 0)
 			n++;
-		if ((n < ARRAY_SIZE(common_cmds)) && !cmp) {
+		if (common_cmds[n].name && !cmp) {
 			/* Yes, this is one of the common commands */
 			n++; /* use the entry from common_cmds[] */
 			if (starts_with(candidate, cmd)) {
@@ -329,6 +401,7 @@ const char *help_unknown_cmd(const char *cmd)
 		main_cmds.names[i]->len =
 			levenshtein(cmd, candidate, 0, 2, 1, 3) + 1;
 	}
+	FREE_AND_NULL(common_cmds);
 
 	QSORT(main_cmds.names, main_cmds.cnt, levenshtein_compare);
 
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 487b92a5de..c096f33505 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -49,6 +49,15 @@ test_expect_success "--help does not work for guides" "
 	test_i18ncmp expect actual
 "
 
+test_expect_success 'git help' '
+	git help >help.output &&
+	test_i18ngrep "^   clone  " help.output &&
+	test_i18ngrep "^   add    " help.output &&
+	test_i18ngrep "^   log    " help.output &&
+	test_i18ngrep "^   commit " help.output &&
+	test_i18ngrep "^   fetch  " help.output
+'
+
 test_expect_success 'generate builtin list' '
 	git --list-builtins >builtins
 '
-- 
2.17.0.705.g3525833791

