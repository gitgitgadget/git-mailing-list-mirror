Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A30C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbiF3VUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237326AbiF3VUD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:20:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD404F1A5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:20:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i25so339694wrc.13
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D14P9bRSfzs4PGO2QYU5H2mNn9nUCxmip9duVa6DOTk=;
        b=UumH4QtgE/4biKHbxoKMCTsQNAyVXVLqG1UqCjt5UZWSvZVdsk2Ty+/B/5qdEZ5TcU
         Lb6N66gfkgKCFQCB7YWJFnM+BkdQWp7iWh1aCGGonQTisMUm3c+WjEc2ZYFGDFcKCEXz
         55ye0iKE7hWp0Pkr2SH3rswwXdDnH2y7ThHthPURWAIiRgMzxu4QmghWWGlKw87F8LN7
         7+Z8Cz1S7DGZz7AfdDk9CXU7Mby+IzL85YOsx2qZwTTZ7LlnKWnuI3NMs9oS46JXGDj+
         wflaZh1e28Os76a9+orsfVnUqNZX5ekScAdt6EyzJBfHhNpV3oDtP2TP9YHzu/k3vv1B
         WyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=D14P9bRSfzs4PGO2QYU5H2mNn9nUCxmip9duVa6DOTk=;
        b=HUcgQKHfZLWvhx9Y0NrgmAXTFZktJJtV/8W3yH7FQwlNCXzNW3fgXHQeLNln2Ohmwh
         erUoe09WCCYv1ELE7d0yljyHdsBkOdHNcPlOsw0uqYRzNW5NBwXn3xNn5o8oKBMk+kwl
         +Lv7ig0YRnE2mw0VYQRXJV6rPhPDKMMwv2swmDhGYLQxItM5ZonfvqJcMshyaEGIp0F+
         uLbyPyTjrXUxzDTy7aKLKXgEmhUHON0Y34chUpVCf3v8m8haCPq0w3oejDcMGGWS3iS9
         UQrOm4u3Emw9NfGvmVJrk0kZIldOVu1hsCXYn4LEhUKQ3bM/MRzkzWXT3a04rj1yUqfI
         8mkw==
X-Gm-Message-State: AJIora/pVOYLcJYi3ZPoGCZZ75WWUzV+EzctiSLx2WbxbuEUKfhfc01n
        QBiqIJiNwM01oa5volxQfKimq6bqzk0=
X-Google-Smtp-Source: AGRyM1tkIZCgOY+RClz9AVdYq9AFqS/1zlI3IN02KJNzTS9hQtmgMPlXa3/UqaKoptKOmYWVc1Vb/A==
X-Received: by 2002:a5d:5887:0:b0:21b:c5d0:fd4b with SMTP id n7-20020a5d5887000000b0021bc5d0fd4bmr10861556wrf.244.1656624000004;
        Thu, 30 Jun 2022 14:20:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x2-20020a7bc202000000b0039c18d3fe27sm7721621wmi.19.2022.06.30.14.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:19:59 -0700 (PDT)
Message-Id: <1d8b6b244dca5908a10e952a7a1ec4f92103f144.1656623978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
        <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 21:19:37 +0000
Subject: [PATCH v2 17/18] submodule--helper update: use --super-prefix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Unlike the other subcommands, "git submodule--helper update" uses the
"--recursive-prefix" flag instead of "--super-prefix". The two flags are
otherwise identical (they only serve to compute the 'display path' of a
submodule), except that there is a dedicated helper function to get the
value of "--super-prefix".

This inconsistency exists because "git submodule update" used to pass
"--recursive-prefix" between shell and C (introduced in [1]) before
"--super-prefix" was introduced (in [2]), and for simplicity, we kept
this name when "git submodule--helper update" was created.

Remove "--recursive-prefix" and its associated code from "git
submodule--helper update", replacing it with "--super-prefix".

To use "--super-prefix", module_update is marked with
SUPPORT_SUPER_PREFIX. Note that module_clone must also be marked with
SUPPORT_SUPER_PREFIX, otherwise the "git submodule--helper clone"
subprocess will fail check because "--super-prefix" is propagated via
the environment.

[1] 48308681b0 (git submodule update: have a dedicated helper for
cloning, 2016-02-29)
[2] 74866d7579 (git: make super-prefix option, 2016-10-07)

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 360309195fb..41177332dd8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -477,22 +477,18 @@ static int starts_with_dot_dot_slash(const char *const path)
 
 struct init_cb {
 	const char *prefix;
-	const char *superprefix;
 	unsigned int flags;
 };
 #define INIT_CB_INIT { 0 }
 
 static void init_submodule(const char *path, const char *prefix,
-			   const char *superprefix, unsigned int flags)
+			   unsigned int flags)
 {
 	const struct submodule *sub;
 	struct strbuf sb = STRBUF_INIT;
 	char *upd = NULL, *url = NULL, *displaypath;
 
-	/* try superprefix from the environment, if it is not passed explicitly */
-	if (!superprefix)
-		superprefix = get_super_prefix();
-	displaypath = do_get_submodule_displaypath(path, prefix, superprefix);
+	displaypath = do_get_submodule_displaypath(path, prefix, get_super_prefix());
 
 	sub = submodule_from_path(the_repository, null_oid(), path);
 
@@ -566,7 +562,7 @@ static void init_submodule(const char *path, const char *prefix,
 static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data)
 {
 	struct init_cb *info = cb_data;
-	init_submodule(list_item->name, info->prefix, info->superprefix, info->flags);
+	init_submodule(list_item->name, info->prefix, info->flags);
 }
 
 static int module_init(int argc, const char **argv, const char *prefix)
@@ -1878,7 +1874,6 @@ struct submodule_update_clone {
 
 struct update_data {
 	const char *prefix;
-	const char *recursive_prefix;
 	const char *displaypath;
 	enum submodule_update_type update_default;
 	struct object_id suboid;
@@ -1954,7 +1949,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 
 	displaypath = do_get_submodule_displaypath(ce->name,
 						   suc->update_data->prefix,
-						   suc->update_data->recursive_prefix);
+						   get_super_prefix());
 
 	if (ce_stage(ce)) {
 		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath);
@@ -2416,11 +2411,11 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 {
 	enum submodule_update_type update_type = update_data->update_default;
 
-	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
-	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
 	if (update_data->displaypath)
-		strvec_pushf(args, "--recursive-prefix=%s/",
+		strvec_pushf(args, "--super-prefix=%s/",
 			     update_data->displaypath);
+	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
+	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
 	if (update_data->quiet)
 		strvec_push(args, "--quiet");
 	if (update_data->force)
@@ -2468,7 +2463,7 @@ static int update_submodule(struct update_data *update_data)
 
 	update_data->displaypath = do_get_submodule_displaypath(update_data->sm_path,
 								update_data->prefix,
-								update_data->recursive_prefix);
+								get_super_prefix());
 
 	determine_submodule_update_strategy(the_repository, update_data->just_cloned,
 					    update_data->sm_path, update_data->update_default,
@@ -2592,10 +2587,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "prefix", &opt.prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
-		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix,
-			   N_("path"),
-			   N_("path into the working tree, across nested "
-			      "submodule boundaries")),
 		OPT_SET_INT(0, "checkout", &opt.update_default,
 			N_("use the 'checkout' update strategy (default)"),
 			SM_UPDATE_CHECKOUT),
@@ -2681,7 +2672,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 			module_list_active(&list);
 
 		info.prefix = opt.prefix;
-		info.superprefix = opt.recursive_prefix;
 		if (opt.quiet)
 			info.flags |= OPT_QUIET;
 
@@ -3378,9 +3368,9 @@ struct cmd_struct {
 static struct cmd_struct commands[] = {
 	{"list", module_list, 0},
 	{"name", module_name, 0},
-	{"clone", module_clone, 0},
+	{"clone", module_clone, SUPPORT_SUPER_PREFIX},
 	{"add", module_add, 0},
-	{"update", module_update, 0},
+	{"update", module_update, SUPPORT_SUPER_PREFIX},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, 0},
-- 
gitgitgadget

