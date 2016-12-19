Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB7AE1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 23:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933087AbcLSX2t (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 18:28:49 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:36566 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932826AbcLSX2q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 18:28:46 -0500
Received: by mail-io0-f178.google.com with SMTP id 136so166257498iou.3
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 15:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ngdzyMcpQqt7yOSlTLHMvS5bRY+yxD04FM7r36eQKEo=;
        b=mnHajxo36yzP44j86Cku/sMGNyy2fv7yqz5Tk98ZnmLNTIzekaQoJubfh2X1tJY8N/
         122X3qG/LEZTKPqlE9L60mGSbGD4B7+Ji5Y9FLAOb5uaonZT1UFB6/o4Enb3KjrF56V3
         3UvoLMo1Qm7JcxZK08UxiOHduWQ3C8tl9XbQnkSJ5Fw1NYmcvt799E1wfdMvcWCXrW8p
         gy+fNTfyCOX7wmkxDaxzmrVnqscYZnUpeA6DZE1VcjAORvY1jo8cN8A+LzFNsYHEa07o
         KivVmxVTNLbam31YyuzsyCsBpY4C/I268FboVal4zJm9IE8bfdOYFRHhRQe5hLbgMyvO
         bvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ngdzyMcpQqt7yOSlTLHMvS5bRY+yxD04FM7r36eQKEo=;
        b=U3FS3seU1nOGNBd/Ir6VECbTQGfUazQgkxB9sRQGLt8W3+VTHZGitSl5NU/pYH3gNy
         zkHQky4YWbNckC7PTtCDejKQ6j0dgJh3obcD6ffV2uJG7Fnta9ufiCefMtN1k/CqSeJ8
         VyBkQtsm9XsSy9L1h5zIETYOpaJGoJ9yf8iX/+Ikq0oWoP+iSvNcwlMehOSy5RHRcKWU
         eFVncrBANhIM+w4FC4i6xaFYYZ542s62AofpNhH7SK9ZAvwQeuuxLWeqyQ/iRYfRrdJw
         YCZzk3awXi+u3cu96WkCZZ9hd1UV5B+/hZxFd4D1kFsUq6ywqbLEth6VA+62UsJOZQtJ
         ksUQ==
X-Gm-Message-State: AIkVDXJMdt/+Bh1wop3zQnDc/byk/2K1WyQyRH11GXYckyUDtu4voNTxyWHOPdxIUh7pmTDl
X-Received: by 10.107.142.194 with SMTP id q185mr19976866iod.147.1482190125524;
        Mon, 19 Dec 2016 15:28:45 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2c2e:3e21:f7c2:2ccc])
        by smtp.gmail.com with ESMTPSA id f187sm1416823ita.7.2016.12.19.15.28.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Dec 2016 15:28:44 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com,
        sandals@crustytoothpaste.net, David.Turner@twosigma.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 1/5] submodule.h: add extern keyword to functions
Date:   Mon, 19 Dec 2016 15:28:24 -0800
Message-Id: <20161219232828.5075-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.53.gb7b3fba.dirty
In-Reply-To: <20161219232828.5075-1-sbeller@google.com>
References: <20161219232828.5075-1-sbeller@google.com>
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
2.11.0.rc2.53.gb7b3fba.dirty

