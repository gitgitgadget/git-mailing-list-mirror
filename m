Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8DE21F424
	for <e@80x24.org>; Wed, 25 Apr 2018 16:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755490AbeDYQbj (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 12:31:39 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34198 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755421AbeDYQbc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 12:31:32 -0400
Received: by mail-lf0-f68.google.com with SMTP id m13-v6so12186047lfc.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/1tPocaY0dAzHbUJ+WJ/vAHkSUDjE7LDdl6fCM5cho8=;
        b=FFuuphijW4hoLVCIiWSAKyC91FIoZwth7ymXjav8EgKdQpwus7GaY+s/R+ht1mtMFH
         7YmqMMO7L1u6j0GVe7+1i2N2uJrYU0hQLBNaAhx2FH3NtI/jg//W88n1234FddEw4XJ5
         j5sGFQlHqO4koDUNEOLSGEJVqwX9rUzCxIr1CBxLddRu+1bx1tUU64+Z2KAm49VS+dht
         ScbOMK7knFHoUeeD1xMCq8h25HjSapFENjdkPwEpVUR0vQP20NE6KF/vxFxV5a0Z86bv
         p953hKFD2/cWP1gDd0moc7+lGdmDjhaeEE0DRQQW4RS+xAj7GwWzTqao3yESRPSvAr6P
         hlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/1tPocaY0dAzHbUJ+WJ/vAHkSUDjE7LDdl6fCM5cho8=;
        b=F9Z8NORgvKXWqEI+S02ee87crsER3IRLiYo3I4Ea/ChOOwXDRmjO/94vrhX4WjpEGb
         +xW0GTLsANujv0iReKv78jDbj9+Tt884ZjYsY3HPba8tYX3N7dsi8EU70eaqiXxrEv/L
         77H6vzPlc0FC2Uq4NcnnGiMIA8o7vP2/LgA5LJz7YAVjkus+u5shlEIFXhhHycNV4KIV
         1MCxCDVe+JlOZQfUKEoqc9v+jeQ+xHgE/18JDLC0aKjqWTaS9cTJyungSYlLPt6zAnRy
         7hh7KJ9R/BXW1Yg1b4WA6S2NldWJHdLR1uUpjpM7fnKfkeTofFMBLhtMs8v0htzwAChd
         HF1w==
X-Gm-Message-State: ALQs6tCCHay5PgEZ9HsjUPJhs9RwPz3UpuiLxA9CI1lsh4Nvql0x3Qce
        yosGpNXvhIpUzfpWE+g0X8c=
X-Google-Smtp-Source: AIpwx48RqXr2imxA1pAa1g86RJm7y1dZTuJ78rMEsnoihszsbhZ3jyYQV4wMjsqJyPxr/ey+47T3Tg==
X-Received: by 10.46.129.217 with SMTP id s25mr19499830ljg.36.1524673890822;
        Wed, 25 Apr 2018 09:31:30 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t24sm518370ljg.65.2018.04.25.09.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 09:31:29 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v4/wip 03/12] help: use command-list.h for common command list
Date:   Wed, 25 Apr 2018 18:30:58 +0200
Message-Id: <20180425163107.10399-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.519.gb89679a4aa
In-Reply-To: <20180425163107.10399-1-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com>
 <20180425163107.10399-1-pclouds@gmail.com>
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
 command-list.txt    |  10 ----
 generate-cmdlist.sh |   4 +-
 help.c              | 135 ++++++++++++++++++++++++++++++++------------
 4 files changed, 103 insertions(+), 50 deletions(-)

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
index 9ba9911f09..88968160e3 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -6,7 +6,7 @@ die () {
 }
 
 command_list () {
-	sed '1,/^### command list/d;/^#/d' "$1"
+	grep -v '^#' "$1"
 }
 
 get_categories() {
@@ -67,7 +67,7 @@ echo "/* Automatically generated by generate-cmdlist.sh */
 struct cmdname_help {
 	const char *name;
 	const char *help;
-	uint32_t group;
+	uint32_t category;
 };
 "
 if [ -z "$2" ]
diff --git a/help.c b/help.c
index 60071a9bea..5b4a2f1b4f 100644
--- a/help.c
+++ b/help.c
@@ -5,13 +5,104 @@
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
+static void extract_cmds(struct cmdname_help **p_cmds, uint32_t mask)
+{
+	int i, nr = 0;
+	struct cmdname_help *cmds;
+
+	ALLOC_ARRAY(cmds, ARRAY_SIZE(command_list) + 1);
+
+	for (i = 0; i < ARRAY_SIZE(command_list); i++) {
+		const struct cmdname_help *cmd = command_list + i;
+		const char *name;
+
+		if (!(cmd->category & mask))
+			continue;
+
+		cmds[nr] = *cmd;
+
+		if (skip_prefix(cmd->name, "git-", &name))
+			cmds[nr].name = name;
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
@@ -190,42 +281,10 @@ void list_commands(unsigned int colopts,
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
@@ -285,6 +344,7 @@ const char *help_unknown_cmd(const char *cmd)
 {
 	int i, n, best_similarity = 0;
 	struct cmdnames main_cmds, other_cmds;
+	struct cmdname_help *common_cmds;
 
 	memset(&main_cmds, 0, sizeof(main_cmds));
 	memset(&other_cmds, 0, sizeof(other_cmds));
@@ -299,6 +359,8 @@ const char *help_unknown_cmd(const char *cmd)
 	QSORT(main_cmds.names, main_cmds.cnt, cmdname_compare);
 	uniq(&main_cmds);
 
+	extract_cmds(&common_cmds, common_mask);
+
 	/* This abuses cmdname->len for levenshtein distance */
 	for (i = 0, n = 0; i < main_cmds.cnt; i++) {
 		int cmp = 0; /* avoid compiler stupidity */
@@ -313,10 +375,10 @@ const char *help_unknown_cmd(const char *cmd)
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
@@ -329,6 +391,7 @@ const char *help_unknown_cmd(const char *cmd)
 		main_cmds.names[i]->len =
 			levenshtein(cmd, candidate, 0, 2, 1, 3) + 1;
 	}
+	FREE_AND_NULL(common_cmds);
 
 	QSORT(main_cmds.names, main_cmds.cnt, levenshtein_compare);
 
-- 
2.17.0.519.gb89679a4aa

