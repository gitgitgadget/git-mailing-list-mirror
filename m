Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DF0C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 22:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiF3WMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiF3WMO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 18:12:14 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482B55722C
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:12:06 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id b11-20020a17090a800b00b001ed433490b5so1983074pjn.8
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dmbphWow+fuMVC8dE0ZDP4DI6yK2ZDH6sb5Oh1qWwyk=;
        b=L6EsI4m3Xr+zPATfW27yIGM5+3cBSNFdIC3CWsxec9KEulVs9HmDkN6a6M+cQpzzve
         RsG/9tFKurQfafM/k3xmsljW25vIwgjRPFPeieDGJt6BifUztfCryvjpfn0m5qJvKKeu
         ZCX6QRqMwXtNPvkQ0mWgnS7Thx4/2xRJuGRz33jH3klFoaVWCYrE2niBXqgiDto/IEfk
         DkHPXYDhn39n04F7vUmACyEVIBkmUHNP943LgN+5iLaoX7CvXdG4fargJStb0Figmqdi
         AAcDvl3fbJiUAEXQL+o9oGWCx8XZWk2ZWQJBSBwGoMp060zIzM/XARULJZXLb1jMhtL8
         uBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dmbphWow+fuMVC8dE0ZDP4DI6yK2ZDH6sb5Oh1qWwyk=;
        b=bfQhVpBbpqYy5GtvBsAg7si/PaAGH4JhC+Auj36VfgTaprDAlC1+cuqlpm/uBE+ZY6
         QKj+2qlj/uoFKtSne5lGOG6fHIpCbaMnqSOBSJ2o3UbBWegsmXoEJz4h3CgWIrGuWNiH
         rt4670Pd6tRLchNi6YZQB6cvUUEr4XYpuUOJvw70KCebhF5ohdtK8i0s80ZZhncZ0/pt
         T0R3JuudlCsGbysxQA9so5w//s44ZEiiZe77tI+hJo7mKvAbSe9IyVM5Ql7JK+NzULYi
         PKtqjaD4n4C04crh6snlWRXf0kpvZxzmwXVkVdmFi6ppFCgICAPqd9V4forwHcuSasgH
         yygQ==
X-Gm-Message-State: AJIora8uG9LRYuQJRrl+HXnK+GNZYGcwX1PaBwBzZYkXLSLoOqpdGSxP
        Ju8N29C1QyFuvfaPiyrSKnKBpjg12HHL1c6zGkQblgHQHb0JjAp/an4Zi4WH/ypztl/A8i+NsId
        QNlq9IjZosEXwD34sC4XLqo6zzaeCVu7Lw5pX9dX3reEgW2k5X0dmdyPcEI528Ls=
X-Google-Smtp-Source: AGRyM1t/nP1nekdofcgzfeh5UTYvlbe8CzPalxq84PBi5bKe31hzpI9lVFzP1yQmMxO+hZeeNc+n+RI2B8pJrA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:988a:b0:16a:7f1b:552 with SMTP id
 s10-20020a170902988a00b0016a7f1b0552mr16665136plp.60.1656627125702; Thu, 30
 Jun 2022 15:12:05 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:11:46 -0700
In-Reply-To: <20220630221147.45689-1-chooglen@google.com>
Message-Id: <20220630221147.45689-6-chooglen@google.com>
Mime-Version: 1.0
References: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com> <20220630221147.45689-1-chooglen@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 5/6] submodule--helper update: use --super-prefix
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index 360309195f..41177332dd 100644
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
2.37.0.rc0.161.g10f37bed90-goog

