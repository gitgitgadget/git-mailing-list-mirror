Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58052C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 19:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjDUTNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 15:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjDUTN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 15:13:27 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB84510F6
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f1950f569eso5920795e9.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682104403; x=1684696403;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPQP1phttm/F7weW3TLGo1HrwI3jSy7Egsz6Ae3JUas=;
        b=K+nC7pA9MNcV3VUN3fyGEKU61Tk5c28NtbcH5rhy57BSvI/zVqpK0ic1bhFZgeFYdZ
         2wW1R1TTOLhFt2JYzXOYNzRAyX3coc/HTG9NHNC/V49d72P8p6VI/CAIIB50GG9f41D+
         oBMw3e5IxPCeGH4Mmf3zSk3jPOtLgC8lYQGcjOmhcVKaWng573DJU9be5W7EJKihiEPT
         gHXpwFuZYIu6Vs8ZnTEn8g6TvviCJCWgsH6i0wXNVeELD4PjZvsScG34shMGYnCqWDYA
         B/4xYYkAtwRrvqp/Zm2fvSDcVN1S3IqWLPYdHge45KWJOTKzLiA9xrs7h8F7w9Edwsip
         cCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104403; x=1684696403;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPQP1phttm/F7weW3TLGo1HrwI3jSy7Egsz6Ae3JUas=;
        b=lq1RjskOb8mw6q4a2rof/g33LWdRRQOI4kYiHSvM74VU7YgsFEovWaiZEvXyayWK9f
         +HJYHL9BzlTt7YdJfKQ3ERp0xBNS6dH66sPKVYzMUQu2DOE05tPPUQg+/dB8r//NobRZ
         RczW+7XrLVNcN1z0LYDR48xuG3Pq0LSNWIkBRdpzeU3WoKg4cb/jwmywWhWNYGOyU8Zz
         BaNUM4qN2PEG18QtthC5wQwDu5KDlk5xgSs9HyTUhyT5CTDJETxbmh0RLub2LE5Sw5Co
         az2xvRJx05PEvif/LeaOEHzSJ3y2ESgjopdCJqgS+xX+AsEKG+pyhxU932UkkN7X7dAQ
         PrUA==
X-Gm-Message-State: AAQBX9dZiFOJTQ4IeLmaUbWwNlaR3GmbEUrbWBCinVS59vEqtMk+DqyE
        xAID78WBtK5PcJSYcXbygWCcuWIbzdM=
X-Google-Smtp-Source: AKy350bvV7dFSSi3y3OLgZHVcYBOj8Mpjty3Kli0KlwYrW0zmoyx4r2X04bySEszlTEs1S0aBtXV4A==
X-Received: by 2002:a1c:7404:0:b0:3f1:7123:5f82 with SMTP id p4-20020a1c7404000000b003f171235f82mr2803420wmc.12.1682104402826;
        Fri, 21 Apr 2023 12:13:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c358e00b003f188f608b9sm6035946wmq.8.2023.04.21.12.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:13:22 -0700 (PDT)
Message-Id: <b407fe1ed1d9cf4d9d79f900c48864fe4eab9568.1682104398.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 19:13:08 +0000
Subject: [PATCH 04/14] config: add kvi.path, use it to evaluate includes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Include directives are evaluated using the path of the config file. To
reduce the dependence on "config_reader.source", add a new
"key_value_info.path" member and use that instead of
"config_source.path".

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 40 ++++++++++++++++++++--------------------
 config.h |  1 +
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/config.c b/config.c
index 3369b32d065..b952a4b118d 100644
--- a/config.c
+++ b/config.c
@@ -199,7 +199,7 @@ static const char include_depth_advice[] = N_(
 "from\n"
 "	%s\n"
 "This might be due to circular includes.");
-static int handle_path_include(struct config_source *cs, const char *path,
+static int handle_path_include(struct key_value_info *kvi, const char *path,
 			       struct config_include_data *inc)
 {
 	int ret = 0;
@@ -221,14 +221,14 @@ static int handle_path_include(struct config_source *cs, const char *path,
 	if (!is_absolute_path(path)) {
 		char *slash;
 
-		if (!cs || !cs->path) {
+		if (!kvi || !kvi->path) {
 			ret = error(_("relative config includes must come from files"));
 			goto cleanup;
 		}
 
-		slash = find_last_dir_sep(cs->path);
+		slash = find_last_dir_sep(kvi->path);
 		if (slash)
-			strbuf_add(&buf, cs->path, slash - cs->path + 1);
+			strbuf_add(&buf, kvi->path, slash - kvi->path + 1);
 		strbuf_addstr(&buf, path);
 		path = buf.buf;
 	}
@@ -236,12 +236,11 @@ static int handle_path_include(struct config_source *cs, const char *path,
 	if (!access_or_die(path, R_OK, 0)) {
 		if (++inc->depth > MAX_INCLUDE_DEPTH)
 			die(_(include_depth_advice), MAX_INCLUDE_DEPTH, path,
-			    !cs ? "<unknown>" :
-			    cs->name ? cs->name :
+			    !kvi ? "<unknown>" :
+			    kvi->filename ? kvi->filename :
 			    "the command line");
 		ret = git_config_from_file_with_options(git_config_include, path, inc,
-							current_config_scope(),
-							NULL);
+							kvi->scope, NULL);
 		inc->depth--;
 	}
 cleanup:
@@ -256,7 +255,7 @@ static void add_trailing_starstar_for_dir(struct strbuf *pat)
 		strbuf_addstr(pat, "**");
 }
 
-static int prepare_include_condition_pattern(struct config_source *cs,
+static int prepare_include_condition_pattern(struct key_value_info *kvi,
 					     struct strbuf *pat)
 {
 	struct strbuf path = STRBUF_INIT;
@@ -273,11 +272,11 @@ static int prepare_include_condition_pattern(struct config_source *cs,
 	if (pat->buf[0] == '.' && is_dir_sep(pat->buf[1])) {
 		const char *slash;
 
-		if (!cs || !cs->path)
+		if (!kvi || !kvi->path)
 			return error(_("relative config include "
 				       "conditionals must come from files"));
 
-		strbuf_realpath(&path, cs->path, 1);
+		strbuf_realpath(&path, kvi->path, 1);
 		slash = find_last_dir_sep(path.buf);
 		if (!slash)
 			BUG("how is this possible?");
@@ -292,7 +291,7 @@ static int prepare_include_condition_pattern(struct config_source *cs,
 	return prefix;
 }
 
-static int include_by_gitdir(struct config_source *cs,
+static int include_by_gitdir(struct key_value_info *kvi,
 			     const struct config_options *opts,
 			     const char *cond, size_t cond_len, int icase)
 {
@@ -309,7 +308,7 @@ static int include_by_gitdir(struct config_source *cs,
 
 	strbuf_realpath(&text, git_dir, 1);
 	strbuf_add(&pattern, cond, cond_len);
-	prefix = prepare_include_condition_pattern(cs, &pattern);
+	prefix = prepare_include_condition_pattern(kvi, &pattern);
 
 again:
 	if (prefix < 0)
@@ -442,16 +441,16 @@ static int include_by_remote_url(struct config_include_data *inc,
 					     inc->remote_urls);
 }
 
-static int include_condition_is_true(struct config_source *cs,
+static int include_condition_is_true(struct key_value_info *kvi,
 				     struct config_include_data *inc,
 				     const char *cond, size_t cond_len)
 {
 	const struct config_options *opts = inc->opts;
 
 	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
-		return include_by_gitdir(cs, opts, cond, cond_len, 0);
+		return include_by_gitdir(kvi, opts, cond, cond_len, 0);
 	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
-		return include_by_gitdir(cs, opts, cond, cond_len, 1);
+		return include_by_gitdir(kvi, opts, cond, cond_len, 1);
 	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
 		return include_by_branch(cond, cond_len);
 	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
@@ -467,7 +466,6 @@ static int kvi_fn(config_fn_t fn, const char *key, const char *value,
 static int git_config_include(const char *var, const char *value, void *data)
 {
 	struct config_include_data *inc = data;
-	struct config_source *cs = inc->config_reader->source;
 	struct key_value_info *kvi = inc->config_reader->config_kvi;
 	const char *cond, *key;
 	size_t cond_len;
@@ -482,16 +480,16 @@ static int git_config_include(const char *var, const char *value, void *data)
 		return ret;
 
 	if (!strcmp(var, "include.path"))
-		ret = handle_path_include(cs, value, inc);
+		ret = handle_path_include(kvi, value, inc);
 
 	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
-	    cond && include_condition_is_true(cs, inc, cond, cond_len) &&
+	    cond && include_condition_is_true(kvi, inc, cond, cond_len) &&
 	    !strcmp(key, "path")) {
 		config_fn_t old_fn = inc->fn;
 
 		if (inc->opts->unconditional_remote_url)
 			inc->fn = forbid_remote_url;
-		ret = handle_path_include(cs, value, inc);
+		ret = handle_path_include(kvi, value, inc);
 		inc->fn = old_fn;
 	}
 
@@ -683,6 +681,7 @@ static void kvi_from_param(struct key_value_info *out)
 	out->linenr = -1;
 	out->origin_type = CONFIG_ORIGIN_CMDLINE;
 	out->scope = CONFIG_SCOPE_COMMAND;
+	out->path = NULL;
 }
 
 int git_config_parse_parameter(const char *text,
@@ -1077,6 +1076,7 @@ static void kvi_from_source(struct config_source *cs,
 	out->origin_type = cs->origin_type;
 	out->linenr = cs->linenr;
 	out->scope = scope;
+	out->path = cs->path;
 }
 
 static int git_parse_source(struct config_source *cs, config_fn_t fn,
diff --git a/config.h b/config.h
index 27d1718ac7b..f8bab9fdef4 100644
--- a/config.h
+++ b/config.h
@@ -674,6 +674,7 @@ struct key_value_info {
 	int linenr;
 	enum config_origin_type origin_type;
 	enum config_scope scope;
+	const char *path;
 	struct key_value_info *prev;
 };
 
-- 
gitgitgadget

