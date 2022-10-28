Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F169FA3740
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 20:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJ1UPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 16:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJ1UPD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 16:15:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D413640BE1
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 13:15:01 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j15so7989334wrq.3
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 13:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEbtKNQludQ2CNUV9BL5HqEp9djAhuoJN08UPZbz5Bo=;
        b=aZGmQjb4rZR7szKZiXoVFR6C/657/JlBb8q/UGWGigg+f2/UddiD31vm/8IotrYps/
         c9lkznkuj/AVMxJ9nnxubrEnotWDhl1e3Z8YnvIGJctVXeebdKaNs9qmJ1K4gqZjXoIu
         lk9o4eBrUJJyWnd46WtC7fA1pzya0CZZ2lEF1pvxe91SShPkHWoR5sviYGBFT9DKpIhi
         YBXsS8yEXj7Dyxi36u/lL+SlnpioKaliluzZACrmy5tkusELi5SWT7B4fT3S97Mud4aG
         J4N4FnKnpVsG8wVI0RXpb6rEs0+w2BQgShyct2/AAY/n9yyxVpqXSdkt+HfWTXN9DLlz
         iJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEbtKNQludQ2CNUV9BL5HqEp9djAhuoJN08UPZbz5Bo=;
        b=GiCGJZMDCgYxyXQsYyYzMfchHiwsaSRahK5qMptXLZusKBgQiBLXXYMqoBKm7QMFB+
         zDH+tuIC45Dcld7tYMQorbNXpIWt9f6dlzHHsa9xF1Z6bwrLIYc0yfZVa9IfQwXUZhGt
         HICyADeXuC3IghbIoj9RQX2tyNB6h6cbr/sU1wsKbERNlkCBVWrZ7fYvIMtyuAYZ+wAG
         CCgo4TA2W2AUhtsrJi3s2EOBRZ6fObicmWdPHJgNSARr++Kg3SlB/FKeGE/L8CyjSdFm
         dVLR/guzw0UQ2JyblwON6KJczNCR79zufFS0Px/LfLL3QS4svhFKYU9c3snyJYOY6aoN
         jJgg==
X-Gm-Message-State: ACrzQf2FCGHzbFMVW1XxvlG7Bz7eyMqvtfWXLSjL2SzCWJYC8fm4xsnI
        +rQeg5VEUUGj//OFBxwUdHbAcY/2Mvs=
X-Google-Smtp-Source: AMsMyM7PiNyHKv41twpqvlRegNznDTeq6Q+HkaZQteuEdS+VCg1GK47u3h8VBd1ipfDpcGDBO3K+Tg==
X-Received: by 2002:a5d:6147:0:b0:236:aa4:6eca with SMTP id y7-20020a5d6147000000b002360aa46ecamr601372wrt.318.1666988100071;
        Fri, 28 Oct 2022 13:15:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c418600b003c6b874a0dfsm5559069wmh.14.2022.10.28.13.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 13:14:59 -0700 (PDT)
Message-Id: <06d7e15e830f7ede2aee43059b6d8666ecb00298.1666988096.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
References: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
        <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Oct 2022 20:14:50 +0000
Subject: [PATCH v3 2/8] repo-settings: add submodule_propagate_branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

When processes recurse into submodules, the child processes have to
use the same value of "submodule.propagateBranches" as the parent
process regardless of whether the process is spawned in the superproject
or submodule, otherwise the behavior may be inconsistent if the
repositories don't agree on the config.

We haven't needed a way to propagate the config because the only command
that reads "submodule.propagateBranches" is "git branch", which only has
one mode of operation with "--recurse-submodules". However, a future
commit will teach "submodule.propagateBranches" to "git submodule
update", making this necessary.

Propagate "submodule.propagateBranches" to child processes by adding a
corresponding GIT_INTERNAL_* environment variable and repository
setting, and setting the environment variable inside
prepare_submodule_repo_env(). Then, refactor builtin/branch.c to read
the repository setting.

Using an internal environment variable is a potentially leaky
abstraction because environment variables can come from sources besides
the parent process. A more robust solution would be to teach Git that
the repository is a submodule and to only read
"submodule.propagateBranches" from the superproject config. There is WIP
for this on the ML [1].

Another alternative would be to pass "-c submodule.propagateBranches" to
all child processes. This is error-prone because many different
processes are invoked directly or indirectly by "git submodule update"
(e.g. "git submodule--helper clone", "git clone", "git checkout"). With
an environment variable, we can avoid this work because
prepare_submodule_repo_env() is already called for submodule child
processes.

[1] https://lore.kernel.org/git/20220310004423.2627181-1-emilyshaffer@google.com/

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/branch.c | 11 +++--------
 cache.h          |  1 +
 repo-settings.c  | 13 +++++++++++++
 repository.h     |  1 +
 submodule.c      |  2 ++
 5 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index e0e0af43202..8279d4eeb15 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -40,7 +40,6 @@ static const char * const builtin_branch_usage[] = {
 static const char *head;
 static struct object_id head_oid;
 static int recurse_submodules = 0;
-static int submodule_propagate_branches = 0;
 
 static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
@@ -106,10 +105,6 @@ static int git_branch_config(const char *var, const char *value, void *cb)
 		recurse_submodules = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcasecmp(var, "submodule.propagateBranches")) {
-		submodule_propagate_branches = git_config_bool(var, value);
-		return 0;
-	}
 
 	return git_color_default_config(var, value, cb);
 }
@@ -723,7 +718,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
-
+	prepare_repo_settings(the_repository);
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
 	    !show_current && !unset_upstream && argc == 0)
 		list = 1;
@@ -739,7 +734,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_branch_usage, options);
 
 	if (recurse_submodules_explicit) {
-		if (!submodule_propagate_branches)
+		if (!the_repository->settings.submodule_propagate_branches)
 			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
 		if (noncreate_actions)
 			die(_("--recurse-submodules can only be used to create branches"));
@@ -747,7 +742,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	recurse_submodules =
 		(recurse_submodules || recurse_submodules_explicit) &&
-		submodule_propagate_branches;
+		the_repository->settings.submodule_propagate_branches;
 
 	if (filter.abbrev == -1)
 		filter.abbrev = DEFAULT_ABBREV;
diff --git a/cache.h b/cache.h
index 26ed03bd6de..151e1d49e77 100644
--- a/cache.h
+++ b/cache.h
@@ -505,6 +505,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
 #define GIT_PREFIX_ENVIRONMENT "GIT_PREFIX"
 #define GIT_SUPER_PREFIX_ENVIRONMENT "GIT_INTERNAL_SUPER_PREFIX"
+#define GIT_SUBMODULE_PROPAGATE_BRANCHES_ENVIRONMENT "GIT_INTERNAL_SUBMODULE_PROPAGATE_BRANCHES"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
diff --git a/repo-settings.c b/repo-settings.c
index e8b58151bc4..7ef2da9178d 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -71,6 +71,19 @@ void prepare_repo_settings(struct repository *r)
 	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0))
 		r->settings.core_multi_pack_index = 1;
 
+	/*
+	 * If the environment variable is set, assume that it was set by an
+	 * invocation of git running in a superproject with
+	 * submodule.propagateBranches set and that is recursing into this repo
+	 * as a submodule. Therefore, we should ignore whatever is set in this
+	 * repo's config.
+	 */
+	r->settings.submodule_propagate_branches =
+		git_env_bool(GIT_SUBMODULE_PROPAGATE_BRANCHES_ENVIRONMENT, -1);
+	if (r->settings.submodule_propagate_branches == -1)
+		repo_cfg_bool(r, "submodule.propagateBranches",
+			      &r->settings.submodule_propagate_branches, 0);
+
 	/*
 	 * Non-boolean config
 	 */
diff --git a/repository.h b/repository.h
index 24316ac944e..3df6fdbdd5c 100644
--- a/repository.h
+++ b/repository.h
@@ -37,6 +37,7 @@ struct repo_settings {
 	int fetch_write_commit_graph;
 	int command_requires_full_index;
 	int sparse_index;
+	int submodule_propagate_branches;
 
 	struct fsmonitor_settings *fsmonitor; /* lazily loaded */
 
diff --git a/submodule.c b/submodule.c
index bf7a2c79183..624404957fa 100644
--- a/submodule.c
+++ b/submodule.c
@@ -503,6 +503,8 @@ static void print_submodule_diff_summary(struct repository *r, struct rev_info *
 
 void prepare_submodule_repo_env(struct strvec *out)
 {
+	if (the_repository->settings.submodule_propagate_branches)
+		strvec_pushf(out, "%s=1", GIT_SUBMODULE_PROPAGATE_BRANCHES_ENVIRONMENT);
 	prepare_other_repo_env(out, DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
-- 
gitgitgadget

