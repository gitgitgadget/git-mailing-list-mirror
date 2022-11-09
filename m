Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E39C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 19:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiKITfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 14:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiKITe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 14:34:58 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4F52A97F
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 11:34:48 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x2so28612908edd.2
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 11:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fp2ADUq9H+OrZqqS0de/tl40ZiufXURea2/Gn/AWjEE=;
        b=DmzxeUrPhEV1hbM0eHrTBNSJHILZBo8QgA7zqR5wSmEtx5riMrE+k5gmJyTLcP7SLr
         ksHLeDOQTOuxKXA2Qhq9fs5YhXIVvk9es1JO3eWnPAANxfwFN4S6cSLG8Qf1wceR6c2K
         +u3gmDW5XyvJB/GgJOhsut1kvKhrBCDlgpZJw93mFs+4MDzFXYYOC9eznQshDaIz0+yR
         KYirJ73/ev6dtCZnF6ZZNiaLPzqN5N9C3wq7ck5/FtrdgMeW8AVkLVI7PEPSFqu3j7va
         be3aW5TzGbTQHWaSVuJsH/H5DlPuGa3I8hslk4Z0hPWUStvPYTSoqfbaPy9bKQbHUXVr
         6cvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fp2ADUq9H+OrZqqS0de/tl40ZiufXURea2/Gn/AWjEE=;
        b=zP67eagFOkhhvTEp6suEnjAbR6jApTYarVTMCl0fTn3Q8tgZXln2qLf4mUnos823Jd
         pt60V1uODKkSJGHTa6yggo0FAVjLCPDgRfmXDSp9jK3YNjHG/hLLASKfTPf4KOJtOykx
         LjwRof98PNLFrj/li3dBeCA0T3SzvSouNNw5tpN20/GBey4o/RsNNbJSwzdwSbEx7yiM
         jBzTuQcE9sBrsbo4q0ouH9fdGJClpIBNdWIfFlsz3MeXDwN22ykwlD5f5nYPCLCaTio4
         F9fWm8tGTXIeWqGTZgnsanj/YRzjpl/dSbXycrokGCqj2SUUw0uaaEUmJLFC7GIh/rda
         DGuA==
X-Gm-Message-State: ACrzQf1azWMmfGCbJH2LBY6+KGDIKAQlgZ83t2E99pH3bFrqvWLVv7a3
        kFZo8gYsWDUPCVnoOYcnccjzWOZUcC1nFw==
X-Google-Smtp-Source: AMsMyM4s9Tb7V3xFwuevYOeQCiqdZqN8XM2Gt5/w5S5G7X9e/8hCXzfUDJfYKb04shLJ+uJu+07x6A==
X-Received: by 2002:a05:6402:274c:b0:461:9cbd:8ad5 with SMTP id z12-20020a056402274c00b004619cbd8ad5mr61741585edd.349.1668022486283;
        Wed, 09 Nov 2022 11:34:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q21-20020a056402041500b004589da5e5cesm7387566edv.41.2022.11.09.11.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:34:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 6/8] submodule--helper: convert "{update,clone}" to their own "--super-prefix"
Date:   Wed,  9 Nov 2022 20:34:34 +0100
Message-Id: <RFC-patch-6.8-78ebf0e2abf-20221109T192315Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
References: <20221109004708.97668-1-chooglen@google.com> <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with a preceding commit to convert "absorbgitdirs", we can convert
"submodule--helper status" to use its own "--super-prefix", instead of
relying on the global "--super-prefix" argument to "git".

We need to convert both of these away from the global "--super-prefix"
at the same time, because "update" will call "clone", but "clone"
itself didn't make use of the global "--super-prefix" for displaying
paths. It was only on the list of sub-commands that accepted it
because "update"'s use of it would set it in its environment.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 45 ++++++++++++++++---------------------
 git.c                       |  2 +-
 2 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 40939b0b18e..e13615eb939 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -131,13 +131,6 @@ static char *get_submodule_displaypath_sp(const char *path, const char *prefix,
 	}
 }
 
-static char *get_submodule_displaypath(const char *path, const char *prefix)
-{
-	const char *super_prefix = get_super_prefix();
-
-	return get_submodule_displaypath_sp(path, prefix, super_prefix);
-}
-
 static char *compute_rev_name(const char *sub_path, const char* object_id)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -446,11 +439,13 @@ static int starts_with_dot_dot_slash(const char *const path)
 
 struct init_cb {
 	const char *prefix;
+	const char *super_prefix;
 	unsigned int flags;
 };
 #define INIT_CB_INIT { 0 }
 
 static void init_submodule(const char *path, const char *prefix,
+			   const char *super_prefix,
 			   unsigned int flags)
 {
 	const struct submodule *sub;
@@ -458,7 +453,7 @@ static void init_submodule(const char *path, const char *prefix,
 	const char *upd;
 	char *url = NULL, *displaypath;
 
-	displaypath = get_submodule_displaypath(path, prefix);
+	displaypath = get_submodule_displaypath_sp(path, prefix, super_prefix);
 
 	sub = submodule_from_path(the_repository, null_oid(), path);
 
@@ -534,7 +529,8 @@ static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data
 {
 	struct init_cb *info = cb_data;
 
-	init_submodule(list_item->name, info->prefix, info->flags);
+	init_submodule(list_item->name, info->prefix, info->super_prefix,
+		       info->flags);
 }
 
 static int module_init(int argc, const char **argv, const char *prefix)
@@ -802,6 +798,7 @@ struct summary_cb {
 	int argc;
 	const char **argv;
 	const char *prefix;
+	const char *super_prefix;
 	unsigned int cached: 1;
 	unsigned int for_status: 1;
 	unsigned int files: 1;
@@ -963,7 +960,8 @@ static void generate_submodule_summary(struct summary_cb *info,
 		dst_abbrev = xstrndup(oid_to_hex(&p->oid_dst), 7);
 	}
 
-	displaypath = get_submodule_displaypath(p->sm_path, info->prefix);
+	displaypath = get_submodule_displaypath_sp(p->sm_path, info->prefix,
+						   info->super_prefix);
 
 	if (!missing_src && !missing_dst) {
 		struct child_process cp_rev_list = CHILD_PROCESS_INIT;
@@ -1904,6 +1902,7 @@ static void submodule_update_clone_release(struct submodule_update_clone *suc)
 
 struct update_data {
 	const char *prefix;
+	const char *super_prefix;
 	char *displaypath;
 	enum submodule_update_type update_default;
 	struct object_id suboid;
@@ -1979,7 +1978,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	enum submodule_update_type update_type;
 	char *key;
 	const struct update_data *ud = suc->update_data;
-	char *displaypath = get_submodule_displaypath(ce->name, ud->prefix);
+	char *displaypath = get_submodule_displaypath_sp(ce->name, ud->prefix,
+							 ud->super_prefix);
 	struct strbuf sb = STRBUF_INIT;
 	int needs_cloning = 0;
 	int need_free_url = 0;
@@ -2459,11 +2459,11 @@ static void update_data_to_args(const struct update_data *update_data,
 {
 	enum submodule_update_type update_type = update_data->update_default;
 
+	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
 	if (update_data->displaypath) {
 		strvec_push(args, "--super-prefix");
 		strvec_pushf(args, "%s/", update_data->displaypath);
 	}
-	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
 	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
 	if (update_data->quiet)
 		strvec_push(args, "--quiet");
@@ -2628,8 +2628,9 @@ static int update_submodules(struct update_data *update_data)
 		if (code)
 			goto fail;
 
-		update_data->displaypath = get_submodule_displaypath(
-			update_data->sm_path, update_data->prefix);
+		update_data->displaypath = get_submodule_displaypath_sp(
+			update_data->sm_path, update_data->prefix,
+			update_data->super_prefix);
 		code = update_submodule(update_data);
 		FREE_AND_NULL(update_data->displaypath);
 fail:
@@ -2654,7 +2655,9 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	struct list_objects_filter_options filter_options =
 		LIST_OBJECTS_FILTER_INIT;
 	int ret;
+	const char *super_prefix = NULL;
 	struct option module_update_options[] = {
+		OPT__SUPER_PREFIX(&super_prefix),
 		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
 		OPT_BOOL(0, "init", &opt.init,
 			 N_("initialize uninitialized submodules before update")),
@@ -2720,6 +2723,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 
 	opt.filter_options = &filter_options;
 	opt.prefix = prefix;
+	opt.super_prefix = super_prefix;
 
 	if (opt.update_default)
 		opt.update_strategy.type = opt.update_default;
@@ -2751,6 +2755,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 			module_list_active(&list);
 
 		info.prefix = opt.prefix;
+		info.super_prefix = super_prefix;
 		if (opt.quiet)
 			info.flags |= OPT_QUIET;
 
@@ -3377,8 +3382,6 @@ static int module_add(int argc, const char **argv, const char *prefix)
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 {
-	const char *cmd = argv[0];
-	const char *subcmd;
 	parse_opt_subcommand_fn *fn = NULL;
 	const char *const usage[] = {
 		N_("git submodule--helper <command>"),
@@ -3402,16 +3405,6 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
-	subcmd = argv[0];
-
-	if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
-	    get_super_prefix())
-		/*
-		 * xstrfmt() rather than "%s %s" to keep the translated
-		 * string identical to git.c's.
-		 */
-		die(_("%s doesn't support --super-prefix"),
-		    xstrfmt("'%s %s'", cmd, subcmd));
 
 	return fn(argc, argv, prefix);
 }
diff --git a/git.c b/git.c
index b1b7e1a837e..2bca22cfd9a 100644
--- a/git.c
+++ b/git.c
@@ -610,7 +610,7 @@ static struct cmd_struct commands[] = {
 	{ "stash", cmd_stash, RUN_SETUP | NEED_WORK_TREE },
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
-	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX },
+	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP },
 	{ "switch", cmd_switch, RUN_SETUP | NEED_WORK_TREE },
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 	{ "tag", cmd_tag, RUN_SETUP | DELAY_PAGER_CONFIG },
-- 
2.38.0.1467.g709fbdff1a9

