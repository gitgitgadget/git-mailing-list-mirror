Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A0CECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiHaXPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiHaXOz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:14:55 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521A3DA9
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so422745wmb.4
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Wh6AkCo5h0AC6stoz4WJGwnkr0B8J3jS899jv7xtxho=;
        b=lSBw6CppDwn3576+c5lGCrKeXH4VcytTK6tHOZi1pA/LVGANzLmv+p0BvQgUtL3zuT
         2KXiWFifbVYlzFf8iPokT5LkRgq6YJhgj5l9xXYGaskBS550FHpT40T0OCUHXuat1pVA
         m+VPhYqASftjK1Fy4b1UzJL4g5z7O2OvyhXJJ1nlTqLPidqPHjrd+GnkyOKbFvl09NYU
         oE2LXCxOItVA7kCtAO2Tdn8Esc8B8Hz3uryl70sjeGwxUG1pGAelztj0SJWOsr5OABt8
         wbRqZ8O4FLbRnMnhK4a2KMcErlQ4kIxOlowYFUv02+yuChNFK9Gqw0pnfOeQUp7lE3P1
         qb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Wh6AkCo5h0AC6stoz4WJGwnkr0B8J3jS899jv7xtxho=;
        b=izoZtm0X+WKMP9cXYXy9YUsqMLanZM1Z74GBSZs/Rn3zmKZf9d6iK7LPMtPe3a8bA/
         yzvSNvG5US7+V82ii184+Leo3ffeoMWNfyNBNCm3UyZflkDOqsDh6DLh7FQw4B4fZ7IQ
         gw81ZPo4SHzKX7piA0APtCnyv4pNyeJ+/NC9vdOvjGrq8et/RrkSZ7zShJSZai53BCe7
         peqDU7MrmUOGKMW4jzCRfN8fz4HG0YrP29cGNmFGdWxv5YysIN7Lnf1kWlvToHoJCPfp
         svhb07pkXrXVy+ieaHDjDAW07+I9kmYFp73cBWEKn8Lb/nDXEv3y8UGiW9hxECdapNm/
         JRwg==
X-Gm-Message-State: ACgBeo2VxPJbkNQLhzIzcRFxeDAFkHnAkK9g7KHgPDmhvXyQdhMEtd1u
        jaa3f4UGp/Pe24s2a47rpjtpurFl6yignA==
X-Google-Smtp-Source: AA6agR7spp4bu6WHeHtzlWQEArcR6m793O5OSMkLn3nmgTUisy5hFkkIGHU4nsNIJooZGApyZ6N3AQ==
X-Received: by 2002:a05:600c:6025:b0:3a6:ff6:de7e with SMTP id az37-20020a05600c602500b003a60ff6de7emr3258830wmb.173.1661987685831;
        Wed, 31 Aug 2022 16:14:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c058e00b003a5ad7f6de2sm3484666wmd.15.2022.08.31.16.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:14:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 03/17] submodule--helper: fix most "struct pathspec" memory leaks
Date:   Thu,  1 Sep 2022 01:14:10 +0200
Message-Id: <patch-v7-03.17-3e1948ddc02-20220831T231003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
References: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call clear_pathspec() at the end of various functions that work with
and allocate a "struct pathspec".

In some cases the zero-initialization here isn't strictly needed, but
as we're moving to a "goto cleanup" pattern let's make sure that it's
safe to call clear_pathspec(), we don't want the data to be
uninitialized.

E.g. for module_foreach() we can see from looking at
module_list_compute() that if it returns non-zero that the "pathspec"
will always have been initialized. But relying on that both assumes
knowledge about parse_pathspec(), and would set up a fragile pattern
going forward.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 74 +++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 23 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b51a5074b42..2f8603a6bb5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -379,7 +379,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 static int module_foreach(int argc, const char **argv, const char *prefix)
 {
 	struct foreach_cb info = FOREACH_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	struct option module_foreach_options[] = {
 		OPT__QUIET(&info.quiet, N_("suppress output of entering each submodule command")),
@@ -391,12 +391,13 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 		N_("git submodule foreach [--quiet] [--recursive] [--] <command>"),
 		NULL
 	};
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, module_foreach_options,
 			     git_submodule_helper_usage, 0);
 
 	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
-		return 1;
+		goto cleanup;
 
 	info.argc = argc;
 	info.argv = argv;
@@ -404,7 +405,10 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, runcommand_in_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 static int starts_with_dot_slash(const char *const path)
@@ -515,7 +519,7 @@ static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data
 static int module_init(int argc, const char **argv, const char *prefix)
 {
 	struct init_cb info = INIT_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 	struct option module_init_options[] = {
@@ -526,12 +530,13 @@ static int module_init(int argc, const char **argv, const char *prefix)
 		N_("git submodule init [<options>] [<path>]"),
 		NULL
 	};
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, module_init_options,
 			     git_submodule_helper_usage, 0);
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+		goto cleanup;
 
 	/*
 	 * If there are no path args and submodule.active is set then,
@@ -546,7 +551,10 @@ static int module_init(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, init_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 struct status_cb {
@@ -693,7 +701,7 @@ static void status_submodule_cb(const struct cache_entry *list_item,
 static int module_status(int argc, const char **argv, const char *prefix)
 {
 	struct status_cb info = STATUS_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 	struct option module_status_options[] = {
@@ -706,12 +714,13 @@ static int module_status(int argc, const char **argv, const char *prefix)
 		N_("git submodule status [--quiet] [--cached] [--recursive] [<path>...]"),
 		NULL
 	};
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, module_status_options,
 			     git_submodule_helper_usage, 0);
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+		goto cleanup;
 
 	info.prefix = prefix;
 	if (quiet)
@@ -719,7 +728,10 @@ static int module_status(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, status_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 struct module_cb {
@@ -1261,7 +1273,7 @@ static void sync_submodule_cb(const struct cache_entry *list_item, void *cb_data
 static int module_sync(int argc, const char **argv, const char *prefix)
 {
 	struct sync_cb info = SYNC_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 	int recursive = 0;
@@ -1275,12 +1287,13 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 		N_("git submodule sync [--quiet] [--recursive] [<path>]"),
 		NULL
 	};
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, module_sync_options,
 			     git_submodule_helper_usage, 0);
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+		goto cleanup;
 
 	info.prefix = prefix;
 	if (quiet)
@@ -1290,7 +1303,10 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, sync_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 struct deinit_cb {
@@ -1399,7 +1415,7 @@ static void deinit_submodule_cb(const struct cache_entry *list_item,
 static int module_deinit(int argc, const char **argv, const char *prefix)
 {
 	struct deinit_cb info = DEINIT_CB_INIT;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 	int force = 0;
@@ -1414,6 +1430,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 		N_("git submodule deinit [--quiet] [-f | --force] [--all | [--] [<path>...]]"),
 		NULL
 	};
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, module_deinit_options,
 			     git_submodule_helper_usage, 0);
@@ -1428,7 +1445,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 		die(_("Use '--all' if you really want to deinitialize all submodules"));
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+		goto cleanup;
 
 	info.prefix = prefix;
 	if (quiet)
@@ -1438,7 +1455,10 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 
 	for_each_listed_submodule(&list, deinit_submodule_cb, &info);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 struct module_clone_data {
@@ -2543,7 +2563,7 @@ static int update_submodules(struct update_data *update_data)
 
 static int module_update(int argc, const char **argv, const char *prefix)
 {
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options = { 0 };
 	int ret;
@@ -2620,8 +2640,8 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		opt.update_strategy.type = opt.update_default;
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0) {
-		list_objects_filter_release(&filter_options);
-		return 1;
+		ret = 1;
+		goto cleanup;
 	}
 
 	if (pathspec.nr)
@@ -2632,8 +2652,10 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		struct init_cb info = INIT_CB_INIT;
 
 		if (module_list_compute(argc, argv, opt.prefix,
-					&pathspec, &list) < 0)
-			return 1;
+					&pathspec, &list) < 0) {
+			ret = 1;
+			goto cleanup;
+		}
 
 		/*
 		 * If there are no path args and submodule.active is set then,
@@ -2650,7 +2672,9 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	}
 
 	ret = update_submodules(&opt);
+cleanup:
 	list_objects_filter_release(&filter_options);
+	clear_pathspec(&pathspec);
 	return ret;
 }
 
@@ -2734,7 +2758,7 @@ static int push_check(int argc, const char **argv, const char *prefix)
 static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct pathspec pathspec;
+	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	unsigned flags = ABSORB_GITDIR_RECURSE_SUBMODULES;
 	struct option embed_gitdir_options[] = {
@@ -2749,17 +2773,21 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 		N_("git submodule absorbgitdirs [<options>] [<path>...]"),
 		NULL
 	};
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, embed_gitdir_options,
 			     git_submodule_helper_usage, 0);
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
-		return 1;
+		goto cleanup;
 
 	for (i = 0; i < list.nr; i++)
 		absorb_git_dir_into_superproject(list.entries[i]->name, flags);
 
-	return 0;
+	ret = 0;
+cleanup:
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 static int module_config(int argc, const char **argv, const char *prefix)
-- 
2.37.3.1420.g76f8a3d556c

