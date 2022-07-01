Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5736C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 02:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiGACMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 22:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbiGACMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 22:12:25 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E94A5C9FF
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:12:21 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id g23-20020a056a00079700b00525285ae44eso258404pfu.13
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eUCtPsfSctwRCZhpKBSi8lmY7LmQyiCzsCMGjA6+Kgk=;
        b=YcXdyTnQUcpnbsPh32cmw2VT9zOzFaDmGlwiL4bp8moiIuH5FtbV/gViaxEaTWye6S
         cZ9/jCnhfj2QmO5SZcqRV/q4ybH2+jPwsbDLEUX48ysuXTl8CVxlX+xCkBbGJKUe/tir
         jIdu2JF8mBlV7YP7Au9tI5H/krPK57yerRqkKh74MtO7UkoTte390QhyuSWqKFCuL/Yn
         3sHjNxk3A98VWb/lGEDxhY6vwtOmlRdlbvWUr2W2pQxzpbDaPfVdD6d6klLY4EZVYBUK
         8QT9gimiokIbk6cjkKXkhLg7dKxQScCoUNYC9Rc+QCQQxk8qPV/8dc9MtEHubKQOkL6i
         HwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eUCtPsfSctwRCZhpKBSi8lmY7LmQyiCzsCMGjA6+Kgk=;
        b=Nsw3hHBp7HvM9exR7WhExlubSdD0vFgHERrSpRyi9EMOdR1zwjkYD7Svereayz/Umx
         /IJKGiB5sHFxE9a60fUKgQr0R/s6bmBSYHnuB9Sj3Wx09ORZEEuiy1eFrPbKRJV9JS+B
         5yBlvQKKnsFUnS3KLe5QV22X2BOZXe6lvv8Thln3HLa6aaJbBlGLNyIB43x+ep2YPU/e
         U8zwonCJnT9OrlC1+tM0xuHOd81+he1lFoFfqBgz0k+2zksQdS2em5KcTR8ujBZP54ww
         am9LdfbjEf1uzNH2wwiMXwDmm7V92+voyQyQRI3a/m6/qTGa+j/7dK/2p1/tI2r0dVCE
         fDsQ==
X-Gm-Message-State: AJIora8+zmWfdS+lMK44zMZzCi5SX842O0e5OfAhfocI8Rn1TVmfeV79
        ztkEF1HswWUEIeP5/XsfYEzcqUyEk9MUlUrV4OLs+nDOXFdJx+ChrRVp7eV9tLNTLBn784JNbtg
        sqGneqdDYquHqkX7DEboZylS8ESv5VnPmA2JKSL2NwPikCnfW5srz1jUxl27LX48=
X-Google-Smtp-Source: AGRyM1sSP0Un1B6unL/3FzbIdy6cFGu0rCF2Lf9q5xpbhNoD9LlwJM5TMmKX5AcpCxeQICArntrOLPtxZ+b0uw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr344126pje.0.1656641540075; Thu, 30 Jun
 2022 19:12:20 -0700 (PDT)
Date:   Thu, 30 Jun 2022 19:11:56 -0700
In-Reply-To: <20220701021157.88858-1-chooglen@google.com>
Message-Id: <20220701021157.88858-7-chooglen@google.com>
Mime-Version: 1.0
References: <20220630221147.45689-1-chooglen@google.com> <20220701021157.88858-1-chooglen@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 6/7] submodule--helper update: use --super-prefix
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
index a7b40482b8..eb84e3a98b 100644
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
@@ -1949,7 +1944,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	char *key;
 	struct update_data *ud = suc->update_data;
 	char *displaypath = do_get_submodule_displaypath(ce->name, ud->prefix,
-							 ud->recursive_prefix);
+							 get_super_prefix());
 	struct strbuf sb = STRBUF_INIT;
 	int needs_cloning = 0;
 	int need_free_url = 0;
@@ -2414,12 +2409,12 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 {
 	enum submodule_update_type update_type = update_data->update_default;
 
-	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
-	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
 	if (update_data->displaypath) {
-		strvec_push(args, "--recursive-prefix");
+		strvec_push(args, "--super-prefix");
 		strvec_pushf(args, "%s/", update_data->displaypath);
 	}
+	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
+	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
 	if (update_data->quiet)
 		strvec_push(args, "--quiet");
 	if (update_data->force)
@@ -2467,7 +2462,7 @@ static int update_submodule(struct update_data *update_data)
 
 	update_data->displaypath = do_get_submodule_displaypath(update_data->sm_path,
 								update_data->prefix,
-								update_data->recursive_prefix);
+								get_super_prefix());
 
 	determine_submodule_update_strategy(the_repository, update_data->just_cloned,
 					    update_data->sm_path, update_data->update_default,
@@ -2591,10 +2586,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
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
@@ -2680,7 +2671,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 			module_list_active(&list);
 
 		info.prefix = opt.prefix;
-		info.superprefix = opt.recursive_prefix;
 		if (opt.quiet)
 			info.flags |= OPT_QUIET;
 
@@ -3377,9 +3367,9 @@ struct cmd_struct {
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

