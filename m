Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57143209B4
	for <e@80x24.org>; Tue, 13 Dec 2016 20:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966205AbcLMU4f (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 15:56:35 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34181 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941126AbcLMU4d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 15:56:33 -0500
Received: by mail-pg0-f49.google.com with SMTP id x23so51404208pgx.1
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 12:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=38ugOrry3Zzm0AVz4/7nSO3oah22MM3ol2TT76ACA3I=;
        b=IQM9dEX8LXS1SiGhQwL/xSsTdvc2PgAr8kML+cj54D5WPM4P0QzVeMyh6EpTbvfnfY
         J+9JB6x6B/xptP3emd5Dr6eGIeQZrPgPmgwiMuXOayoBsI/PrU1y/64w0Zr4zTWOidSG
         41fMyELz3TG/KE/bT1PLeZ9jjX7lYeSqcKIubsFPfTl18SGvX9V/bL9BCchyLDXjy2dl
         S2LNLJLz7i0wclaV3RjvOtpXtByxLjJSuuZQ1td8nBfb9RCnEzLilzWcs+q8Cc/NunlV
         KOmQqhceg6H8vppMFINN1ntElwACULDD7z2A7x/+J/lU8qWHqg6MMw4o8VGQjOgiRq4W
         +9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=38ugOrry3Zzm0AVz4/7nSO3oah22MM3ol2TT76ACA3I=;
        b=UyiQwI64NEG7zuOLd0eDb5Oejf5gO1VO6O6HmsA0goWYN4MYH+0fAW6nU/pN0O7KJA
         kyDZdExp1q1zNuXoHN3vGta1hwzM6eua4J+CUdKQj+FuaCVQexgI/2Rg9gd1OfqgnNrh
         nMSw47nyOGOUYel6Ucp9Cmqke3ZPnnKHpNEq43p7gqFGA9/mK17QT3jFhfwwKnLJhS74
         MQBan09KvbSGkr47Rg+u4CZ/16YFE68079l0FivXGZ0LmfQhSItC3n/urQUzRj7Bzavb
         1tkNv1Ml7v0IAk5vdduqdn4cZlqHMSsSJXJrtkh8SQGgQRqzeQi4XOeROWj0JSf0AR0D
         v2pA==
X-Gm-Message-State: AKaTC02POawVMQNQvKR2El/F65n7H/TG53RJhdgkkxt8tTkatgP3d/h6JEvix4Z+NAbIx5W0
X-Received: by 10.84.202.163 with SMTP id x32mr37797763pld.46.1481662591394;
        Tue, 13 Dec 2016 12:56:31 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:5b5:8785:ab45:d22f])
        by smtp.gmail.com with ESMTPSA id l11sm82016003pfb.28.2016.12.13.12.56.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 12:56:30 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, David.Turner@twosigma.com, bmwill@google.com,
        sandals@crustytoothpaste.net, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 1/5] submodule.h: add extern keyword to functions
Date:   Tue, 13 Dec 2016 12:56:18 -0800
Message-Id: <20161213205622.841-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.35.g26e18c9
In-Reply-To: <20161213205622.841-1-sbeller@google.com>
References: <20161213205622.841-1-sbeller@google.com>
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
 submodule.h | 55 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/submodule.h b/submodule.h
index 6229054b99..61fb610749 100644
--- a/submodule.h
+++ b/submodule.h
@@ -29,50 +29,55 @@ struct submodule_update_strategy {
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
+extern void prepare_submodule_repo_env(struct argv_array *out);
 
 #define ABSORB_GITDIR_RECURSE_SUBMODULES (1<<0)
 extern void absorb_git_dir_into_superproject(const char *prefix,
-- 
2.11.0.rc2.35.g26e18c9

