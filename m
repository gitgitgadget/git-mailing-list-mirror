Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A26F41FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 00:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757484AbcLCAbJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 19:31:09 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35702 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753334AbcLCAat (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 19:30:49 -0500
Received: by mail-pf0-f180.google.com with SMTP id i88so54907505pfk.2
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 16:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xEVJg064h2lb+RNp6I8tKGW/khptu6Dfp92VmBAMxFU=;
        b=TX7GnaMtIhySmLMlqLeG+JrbObytMJPbqQO55urqHqIfDtnOdnSNBjC0z+K+wPAjfm
         ZsYdL/WVUvnhS2CQ9LKGjbOM9aU4Kt60d8L3dIKsqVYufbWCfJxBd7oT+isv4oNJddX+
         EFg8zdO4sHyeoCx6gPdtpCvPqHJtbPv5EgcxOn3sGc96ij2AbCXa9b1K2txhCLOhbdN1
         /vrdG91BpS+vGHPAcj8ekbKBNj8gEap36VXBcT6lh1rFAr0CpMfzPg5LWcfso/S9gSyj
         u698aiUaW3lKsIlt44/UAZqsaVFlrpZCpO+cdam0WiXB4gBWvIsMrAgzTMED7NwCU+9i
         PLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xEVJg064h2lb+RNp6I8tKGW/khptu6Dfp92VmBAMxFU=;
        b=CdQ+e3dPpgwyWIzwtzJX+Ve5r5Q9bTWT325maBXlmkFu2cRCEOCkuCEqBjsp6/bXwu
         rE9eifz/obb3gydTwjXrBOivTpQkRM3Zbo5xdDLCoUZmeimV7/z14mLkfQYaGkp9916C
         3eAppQ6XGh06yZH6frvz+ZNTX3pCyZEAaI0B5Gcoka4ETYuJPapBGr+SpR2SGTpqdDcQ
         6CgDaUbyC/Oc3uA3D1IzOY0JbPFp8SzXYQ+8w6Zkp7bas03CikPXAIz48x+pFYOizkuT
         /f5XmYTAAKPkgv8hQikUk6g6SLJUBAWGR/HwOdieTREJ48pivSG1rDY4g7eULCMepbQv
         uFCA==
X-Gm-Message-State: AKaTC020hgbe1Jz6zBtdBTBNDiEJ4iJEVU1U5G2i2Q7JryqK0UaWCgf2GLyDscvEiXGvEW7o
X-Received: by 10.99.60.11 with SMTP id j11mr84604577pga.26.1480725035078;
        Fri, 02 Dec 2016 16:30:35 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id a68sm10246895pgc.31.2016.12.02.16.30.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 16:30:34 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, David.Turner@twosigma.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        hvoigt@hvoigt.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv2 01/17] submodule.h: add extern keyword to functions
Date:   Fri,  2 Dec 2016 16:30:06 -0800
Message-Id: <20161203003022.29797-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161203003022.29797-1-sbeller@google.com>
References: <20161203003022.29797-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the upcoming series will add a lot of functions to the submodule
header, let's first make the header consistent to the rest of the project
by adding the extern keyword to functions.

As per the CodingGuidelines we try to stay below 80 characters per line,
so adapt all those functions to stay below 80 characters that are already
using more than one line.  Those function using just one line are better
kept in one line than breaking them up into multiple lines just for the
goal of staying below the character limit as it makes grepping
for functions easier if they are one liners.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.h | 57 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/submodule.h b/submodule.h
index d9e197a948..5db0b53b3f 100644
--- a/submodule.h
+++ b/submodule.h
@@ -29,50 +29,53 @@ struct submodule_update_strategy {
 };
 #define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED, NULL}
 
-int is_staging_gitmodules_ok(void);
-int update_path_in_gitmodules(const char *oldpath, const char *newpath);
-int remove_path_from_gitmodules(const char *path);
-void stage_updated_gitmodules(void);
-void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
+extern int is_staging_gitmodules_ok(void);
+extern int update_path_in_gitmodules(const char *oldpath, const char *newpath);
+extern int remove_path_from_gitmodules(const char *path);
+extern void stage_updated_gitmodules(void);
+extern void set_diffopt_flags_from_submodule_config(struct diff_options *,
 		const char *path);
-int submodule_config(const char *var, const char *value, void *cb);
-void gitmodules_config(void);
-int parse_submodule_update_strategy(const char *value,
+extern int submodule_config(const char *var, const char *value, void *cb);
+extern void gitmodules_config(void);
+extern int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
-const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
-void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
-void show_submodule_summary(FILE *f, const char *path,
+extern const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
+extern void handle_ignore_submodules_arg(struct diff_options *, const char *);
+extern void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset);
-void show_submodule_inline_diff(FILE *f, const char *path,
+extern void show_submodule_inline_diff(FILE *f, const char *path,
 		const char *line_prefix,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset,
 		const struct diff_options *opt);
-void set_config_fetch_recurse_submodules(int value);
-void check_for_new_submodule_commits(unsigned char new_sha1[20]);
-int fetch_populated_submodules(const struct argv_array *options,
+extern void set_config_fetch_recurse_submodules(int value);
+extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
+extern int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
 			       int quiet, int max_parallel_jobs);
-unsigned is_submodule_modified(const char *path, int ignore_untracked);
-int submodule_uses_gitfile(const char *path);
-int ok_to_remove_submodule(const char *path);
-int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
-		    const unsigned char a[20], const unsigned char b[20], int search);
-int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name,
-		struct string_list *needs_pushing);
-int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
-void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
-int parallel_submodules(void);
+extern unsigned is_submodule_modified(const char *path, int ignore_untracked);
+extern int submodule_uses_gitfile(const char *path);
+extern int ok_to_remove_submodule(const char *path);
+extern int merge_submodule(unsigned char result[20], const char *path,
+			   const unsigned char base[20],
+			   const unsigned char a[20],
+			   const unsigned char b[20], int search);
+extern int find_unpushed_submodules(unsigned char new_sha1[20],
+				    const char *remotes_name,
+				    struct string_list *needs_pushing);
+extern int push_unpushed_submodules(unsigned char new_sha1[20],
+				    const char *remotes_name);
+extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
+extern int parallel_submodules(void);
 
 /*
  * Prepare the "env_array" parameter of a "struct child_process" for executing
  * a submodule by clearing any repo-specific envirionment variables, but
  * retaining any config in the environment.
  */
-void prepare_submodule_repo_env(struct argv_array *out);
-
+extern void prepare_submodule_repo_env(struct argv_array *out);
 #endif
-- 
2.11.0.rc2.28.g2673dad

