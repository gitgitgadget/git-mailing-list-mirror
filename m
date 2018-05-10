Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 102FE1F406
	for <e@80x24.org>; Thu, 10 May 2018 14:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965523AbeEJOTh (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 10:19:37 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41529 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935607AbeEJOTe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 10:19:34 -0400
Received: by mail-lf0-f68.google.com with SMTP id o123-v6so3206370lfe.8
        for <git@vger.kernel.org>; Thu, 10 May 2018 07:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NNVDVNvzdb1oHNgjvgd2mrH1PiJ8NMSdUzMh9fMZdRE=;
        b=AbuyGT/CoQCNA2No+B2/jCG+lSwYAGgZMYjhPoV002mFZmc22JbCXS5zacB2UJXad6
         NWUIr5B1Y6Hmf/lgtkOv8fqnUHqUD20fLDHqBD3Vsx9V4y94EeLD5sGy5IdNU0AWFUMH
         4rdw663xbODQBR7Cis3trpM8k63Zyp3CifoLiXfUui/HSJq8jejqdO5nt+hNVu+hjGMB
         QnTHLlJFhF49vtl+UCKp8TxYgB1yh9YnfHyJCKapuRXLqYRaRKXrnpEqwloWgZ3oyqXj
         ITOffqrYt1P3//DXYVSDtu21TCLVpqIY2BC/NxBsEMwZKx0kd+dkEDDmPxPAVjKAbMQm
         +7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NNVDVNvzdb1oHNgjvgd2mrH1PiJ8NMSdUzMh9fMZdRE=;
        b=ccUEIH+l2EsvVAL8bMPdTQbc/hio2mBiC9YEa+lSojxFjq+JDxpvW1HO9wxKqVbbkp
         cQogiaFo0hVE/+euHI+Qi6rX+j1ddeDRVmBDlkZYNkMB9UMl/JIGoJb46IR/JXAimCjs
         1dFekllvhd1dTcAfiiaQ5AKpLmc5JyiVTyP045kefnPnsIYCyJvhl/LnGNtd8fSOFnBh
         gmtFoOroYGXA0MkHhJz0Osrh4UqwWoRnb7j0/84HRlfiRbajeJTKL+h6uHneERkyqPiX
         Xx4I3zcCJlHRA3VEoou5QCx6idtRQMOqLJK0fXUe8omgYfIFPyr8Da5HISCVL7yG1pAr
         qScA==
X-Gm-Message-State: ALKqPweBcSi5wAHWYxbohjuEWcRMsQ6lHtScPrvrDIh3lMOIet+tF5YV
        2Y/MHT/ESrnMLY3bCa6o1q0scA==
X-Google-Smtp-Source: AB8JxZobrk//9+SAWqrN58lO3zBHlu99n2/uP+chSQE4+qs3Q1ewYR10ToEJ5SrYDiDYhPGF90vHIA==
X-Received: by 2002:a2e:1055:: with SMTP id j82-v6mr1390223lje.94.1525961972297;
        Thu, 10 May 2018 07:19:32 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g2-v6sm194296ljj.82.2018.05.10.07.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 07:19:31 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/9] Add and use generic name->id mapping code for color slot parsing
Date:   Thu, 10 May 2018 16:19:19 +0200
Message-Id: <20180510141927.23590-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180510141927.23590-1-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard coding the name-to-id mapping in C code, keep it in an
array and use a common function to do the parsing. This reduces code
and also allows us to list all possible color slots later.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/branch.c | 28 +++++++++----------------
 builtin/clean.c  | 28 +++++++++----------------
 builtin/commit.c | 33 ++++++++++++++----------------
 config.c         | 13 ++++++++++++
 config.h         |  4 ++++
 diff.c           | 53 +++++++++++++++++++-----------------------------
 log-tree.c       | 35 ++++++++------------------------
 7 files changed, 82 insertions(+), 112 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 5bd2a0dd48..b41f332589 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -55,26 +55,18 @@ enum color_branch {
 	BRANCH_COLOR_UPSTREAM = 5
 };
 
+static const char *color_branch_slots[] = {
+	[BRANCH_COLOR_RESET]	= "reset",
+	[BRANCH_COLOR_PLAIN]	= "plain",
+	[BRANCH_COLOR_REMOTE]	= "remote",
+	[BRANCH_COLOR_LOCAL]	= "local",
+	[BRANCH_COLOR_CURRENT]	= "current",
+	[BRANCH_COLOR_UPSTREAM] = "upstream",
+};
+
 static struct string_list output = STRING_LIST_INIT_DUP;
 static unsigned int colopts;
 
-static int parse_branch_color_slot(const char *slot)
-{
-	if (!strcasecmp(slot, "plain"))
-		return BRANCH_COLOR_PLAIN;
-	if (!strcasecmp(slot, "reset"))
-		return BRANCH_COLOR_RESET;
-	if (!strcasecmp(slot, "remote"))
-		return BRANCH_COLOR_REMOTE;
-	if (!strcasecmp(slot, "local"))
-		return BRANCH_COLOR_LOCAL;
-	if (!strcasecmp(slot, "current"))
-		return BRANCH_COLOR_CURRENT;
-	if (!strcasecmp(slot, "upstream"))
-		return BRANCH_COLOR_UPSTREAM;
-	return -1;
-}
-
 static int git_branch_config(const char *var, const char *value, void *cb)
 {
 	const char *slot_name;
@@ -86,7 +78,7 @@ static int git_branch_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 	if (skip_prefix(var, "color.branch.", &slot_name)) {
-		int slot = parse_branch_color_slot(slot_name);
+		int slot = LOOKUP_CONFIG(color_branch_slots, slot_name);
 		if (slot < 0)
 			return 0;
 		if (!value)
diff --git a/builtin/clean.c b/builtin/clean.c
index fad533a0a7..0ccd95e693 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -42,6 +42,15 @@ enum color_clean {
 	CLEAN_COLOR_ERROR = 5
 };
 
+static const char *color_interactive_slots[] = {
+	[CLEAN_COLOR_ERROR]  = "error",
+	[CLEAN_COLOR_HEADER] = "header",
+	[CLEAN_COLOR_HELP]   = "help",
+	[CLEAN_COLOR_PLAIN]  = "plain",
+	[CLEAN_COLOR_PROMPT] = "prompt",
+	[CLEAN_COLOR_RESET]  = "reset",
+};
+
 static int clean_use_color = -1;
 static char clean_colors[][COLOR_MAXLEN] = {
 	[CLEAN_COLOR_ERROR] = GIT_COLOR_BOLD_RED,
@@ -82,23 +91,6 @@ struct menu_stuff {
 	void *stuff;
 };
 
-static int parse_clean_color_slot(const char *var)
-{
-	if (!strcasecmp(var, "reset"))
-		return CLEAN_COLOR_RESET;
-	if (!strcasecmp(var, "plain"))
-		return CLEAN_COLOR_PLAIN;
-	if (!strcasecmp(var, "prompt"))
-		return CLEAN_COLOR_PROMPT;
-	if (!strcasecmp(var, "header"))
-		return CLEAN_COLOR_HEADER;
-	if (!strcasecmp(var, "help"))
-		return CLEAN_COLOR_HELP;
-	if (!strcasecmp(var, "error"))
-		return CLEAN_COLOR_ERROR;
-	return -1;
-}
-
 static int git_clean_config(const char *var, const char *value, void *cb)
 {
 	const char *slot_name;
@@ -113,7 +105,7 @@ static int git_clean_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 	if (skip_prefix(var, "color.interactive.", &slot_name)) {
-		int slot = parse_clean_color_slot(slot_name);
+		int slot = LOOKUP_CONFIG(color_interactive_slots, slot_name);
 		if (slot < 0)
 			return 0;
 		if (!value)
diff --git a/builtin/commit.c b/builtin/commit.c
index 37fcb55ab0..bee5825bd2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -66,6 +66,18 @@ N_("If you wish to skip this commit, use:\n"
 "Then \"git cherry-pick --continue\" will resume cherry-picking\n"
 "the remaining commits.\n");
 
+static const char *color_status_slots[] = {
+	[WT_STATUS_HEADER]	  = "header",
+	[WT_STATUS_UPDATED]	  = "updated",
+	[WT_STATUS_CHANGED]	  = "changed",
+	[WT_STATUS_UNTRACKED]	  = "untracked",
+	[WT_STATUS_NOBRANCH]	  = "noBranch",
+	[WT_STATUS_UNMERGED]	  = "unmerged",
+	[WT_STATUS_LOCAL_BRANCH]  = "localBranch",
+	[WT_STATUS_REMOTE_BRANCH] = "remoteBranch",
+	[WT_STATUS_ONBRANCH]	  = "branch",
+};
+
 static const char *use_message_buffer;
 static struct lock_file index_lock; /* real index */
 static struct lock_file false_lock; /* used only for partial commits */
@@ -1176,25 +1188,10 @@ static int dry_run_commit(int argc, const char **argv, const char *prefix,
 
 static int parse_status_slot(const char *slot)
 {
-	if (!strcasecmp(slot, "header"))
-		return WT_STATUS_HEADER;
-	if (!strcasecmp(slot, "branch"))
-		return WT_STATUS_ONBRANCH;
-	if (!strcasecmp(slot, "updated") || !strcasecmp(slot, "added"))
+	if (!strcasecmp(slot, "added"))
 		return WT_STATUS_UPDATED;
-	if (!strcasecmp(slot, "changed"))
-		return WT_STATUS_CHANGED;
-	if (!strcasecmp(slot, "untracked"))
-		return WT_STATUS_UNTRACKED;
-	if (!strcasecmp(slot, "nobranch"))
-		return WT_STATUS_NOBRANCH;
-	if (!strcasecmp(slot, "unmerged"))
-		return WT_STATUS_UNMERGED;
-	if (!strcasecmp(slot, "localBranch"))
-		return WT_STATUS_LOCAL_BRANCH;
-	if (!strcasecmp(slot, "remoteBranch"))
-		return WT_STATUS_REMOTE_BRANCH;
-	return -1;
+
+	return LOOKUP_CONFIG(color_status_slots, slot);
 }
 
 static int git_status_config(const char *k, const char *v, void *cb)
diff --git a/config.c b/config.c
index c698988f5e..69ea707f36 100644
--- a/config.c
+++ b/config.c
@@ -3041,3 +3041,16 @@ enum config_scope current_config_scope(void)
 	else
 		return current_parsing_scope;
 }
+
+int lookup_config(const char **mapping, int nr_mapping, const char *var)
+{
+	int i;
+
+	for (i = 0; i < nr_mapping; i++) {
+		const char *name = mapping[i];
+
+		if (name && !strcasecmp(var, name))
+			return i;
+	}
+	return -1;
+}
diff --git a/config.h b/config.h
index ef70a9cac1..cf35ab74db 100644
--- a/config.h
+++ b/config.h
@@ -231,4 +231,8 @@ struct key_value_info {
 extern NORETURN void git_die_config(const char *key, const char *err, ...) __attribute__((format(printf, 2, 3)));
 extern NORETURN void git_die_config_linenr(const char *key, const char *filename, int linenr);
 
+#define LOOKUP_CONFIG(mapping, var) \
+	lookup_config(mapping, ARRAY_SIZE(mapping), var)
+int lookup_config(const char **mapping, int nr_mapping, const char *var);
+
 #endif /* CONFIG_H */
diff --git a/diff.c b/diff.c
index 1289df4b1f..6f781a2c57 100644
--- a/diff.c
+++ b/diff.c
@@ -69,6 +69,25 @@ static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_FAINT_ITALIC,	/* NEW_MOVED_ALTERNATIVE_DIM */
 };
 
+static const char *color_diff_slots[] = {
+	[DIFF_CONTEXT]		      = "context",
+	[DIFF_METAINFO]		      = "meta",
+	[DIFF_FRAGINFO]		      = "frag",
+	[DIFF_FILE_OLD]		      = "old",
+	[DIFF_FILE_NEW]		      = "new",
+	[DIFF_COMMIT]		      = "commit",
+	[DIFF_WHITESPACE]	      = "whitespace",
+	[DIFF_FUNCINFO]		      = "func",
+	[DIFF_FILE_OLD_MOVED]	      = "oldMoved",
+	[DIFF_FILE_OLD_MOVED_ALT]     = "oldMovedAlternative",
+	[DIFF_FILE_OLD_MOVED_DIM]     = "oldMovedDimmed",
+	[DIFF_FILE_OLD_MOVED_ALT_DIM] = "oldMovedAlternativeDimmed",
+	[DIFF_FILE_NEW_MOVED]	      = "newMoved",
+	[DIFF_FILE_NEW_MOVED_ALT]     = "newMovedAlternative",
+	[DIFF_FILE_NEW_MOVED_DIM]     = "newMovedDimmed",
+	[DIFF_FILE_NEW_MOVED_ALT_DIM] = "newMovedAlternativeDimmed",
+};
+
 static NORETURN void die_want_option(const char *option_name)
 {
 	die(_("option '%s' requires a value"), option_name);
@@ -76,39 +95,9 @@ static NORETURN void die_want_option(const char *option_name)
 
 static int parse_diff_color_slot(const char *var)
 {
-	if (!strcasecmp(var, "context") || !strcasecmp(var, "plain"))
+	if (!strcasecmp(var, "plain"))
 		return DIFF_CONTEXT;
-	if (!strcasecmp(var, "meta"))
-		return DIFF_METAINFO;
-	if (!strcasecmp(var, "frag"))
-		return DIFF_FRAGINFO;
-	if (!strcasecmp(var, "old"))
-		return DIFF_FILE_OLD;
-	if (!strcasecmp(var, "new"))
-		return DIFF_FILE_NEW;
-	if (!strcasecmp(var, "commit"))
-		return DIFF_COMMIT;
-	if (!strcasecmp(var, "whitespace"))
-		return DIFF_WHITESPACE;
-	if (!strcasecmp(var, "func"))
-		return DIFF_FUNCINFO;
-	if (!strcasecmp(var, "oldmoved"))
-		return DIFF_FILE_OLD_MOVED;
-	if (!strcasecmp(var, "oldmovedalternative"))
-		return DIFF_FILE_OLD_MOVED_ALT;
-	if (!strcasecmp(var, "oldmoveddimmed"))
-		return DIFF_FILE_OLD_MOVED_DIM;
-	if (!strcasecmp(var, "oldmovedalternativedimmed"))
-		return DIFF_FILE_OLD_MOVED_ALT_DIM;
-	if (!strcasecmp(var, "newmoved"))
-		return DIFF_FILE_NEW_MOVED;
-	if (!strcasecmp(var, "newmovedalternative"))
-		return DIFF_FILE_NEW_MOVED_ALT;
-	if (!strcasecmp(var, "newmoveddimmed"))
-		return DIFF_FILE_NEW_MOVED_DIM;
-	if (!strcasecmp(var, "newmovedalternativedimmed"))
-		return DIFF_FILE_NEW_MOVED_ALT_DIM;
-	return -1;
+	return LOOKUP_CONFIG(color_diff_slots, var);
 }
 
 static int parse_dirstat_params(struct diff_options *options, const char *params_string,
diff --git a/log-tree.c b/log-tree.c
index d1c0bedf24..093efb477e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -27,6 +27,14 @@ static char decoration_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_BOLD_BLUE,	/* GRAFTED */
 };
 
+static const char *color_decorate_slots[] = {
+	[DECORATION_REF_LOCAL]	= "branch",
+	[DECORATION_REF_REMOTE] = "remoteBranch",
+	[DECORATION_REF_TAG]	= "tag",
+	[DECORATION_REF_STASH]	= "stash",
+	[DECORATION_REF_HEAD]	= "HEAD",
+};
+
 static const char *decorate_get_color(int decorate_use_color, enum decoration_type ix)
 {
 	if (want_color(decorate_use_color))
@@ -34,34 +42,9 @@ static const char *decorate_get_color(int decorate_use_color, enum decoration_ty
 	return "";
 }
 
-static int parse_decorate_color_slot(const char *slot)
-{
-	/*
-	 * We're comparing with 'ignore-case' on
-	 * (because config.c sets them all tolower),
-	 * but let's match the letters in the literal
-	 * string values here with how they are
-	 * documented in Documentation/config.txt, for
-	 * consistency.
-	 *
-	 * We love being consistent, don't we?
-	 */
-	if (!strcasecmp(slot, "branch"))
-		return DECORATION_REF_LOCAL;
-	if (!strcasecmp(slot, "remoteBranch"))
-		return DECORATION_REF_REMOTE;
-	if (!strcasecmp(slot, "tag"))
-		return DECORATION_REF_TAG;
-	if (!strcasecmp(slot, "stash"))
-		return DECORATION_REF_STASH;
-	if (!strcasecmp(slot, "HEAD"))
-		return DECORATION_REF_HEAD;
-	return -1;
-}
-
 int parse_decorate_color_config(const char *var, const char *slot_name, const char *value)
 {
-	int slot = parse_decorate_color_slot(slot_name);
+	int slot = LOOKUP_CONFIG(color_decorate_slots, slot_name);
 	if (slot < 0)
 		return 0;
 	if (!value)
-- 
2.17.0.705.g3525833791

