Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B56EB64DD
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 19:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjF1T1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 15:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjF1T0y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 15:26:54 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA92130
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 12:26:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fba5a8af2cso3092345e9.3
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 12:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687980405; x=1690572405;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=si0NyXtDKie+ejsORCSJU07csLBoZIadJdO2s/tlMPY=;
        b=pod3XSOTcX0s0Tv/9mIs09MNVkFEp/3M4NTlTqpgFkpifGV0g8wBkCW8Zd/c5qDJ+F
         SrxAO671yUSnHIAt9xIxp65e/1KU38PK9kGL23BH7GE98u6XF94AyZfLp7Uy4nEqf36c
         MH1NB/uaSG4KdiEWK4yNO/k6emeIh+ygREh5HxUd87EmFAnvMepCEiC3Cqdy4CFCdXEa
         MMiOMBJEypYhDZsasvJi0OyNy8jvelgK/eZqnUHCES81+GLy1JwxNI0+NhGK8oSw2YSX
         NN7SvEUReIRMF6N2SGylJ7y+cvS8GmkvFhoIYgwhadfJnzuBPRpB/ZcMcRYwb8lWkjsp
         y9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687980405; x=1690572405;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=si0NyXtDKie+ejsORCSJU07csLBoZIadJdO2s/tlMPY=;
        b=CQRAbJ2r+BIwSbcLVY9tJ3w/kdr6Hb0UN4SOCme3dvI0egX++SWv0W5PTAf36KIzkS
         cdemSntbLL3fmxPzMrVWnG5zIarNZZoLK/lm4Vr/gNBjx1NvyoKNbAunCyYOUCZrTgxu
         +6TNN8JaF7dcbvik04IfOnz6DmOr2JjKHVJbeI3sgBYN3Ysj65UKx3vr1/91ov02hXyJ
         rclibQ7QDwMThuj5AdFiXixEMwxDtWq1eNNxE+ucwMEv/bbcwNWm7hfdGsNoHcqZlT96
         K8yrch9BbUWw7/O8kxPw/Wg6lGn2QWvlcdQF2Ea1U77OoO3OYQgsDNdPKDlzbXsFmO6E
         z2sw==
X-Gm-Message-State: AC+VfDwD1NTk24UHSkr3b5M49EE7Vy1jIah4bI7ECOefgITynxfW3Prw
        FvpZIhXIQrVB5noTzdg4FqaCaSPpyhI=
X-Google-Smtp-Source: ACHHUZ4KMboh+/wddnKSGczeMLDl+gATWnw5j4rNla4zYs6BOGbgAAXqrPU2vrbMBjPVkQ8zjVWAGA==
X-Received: by 2002:a05:600c:b43:b0:3fb:b70f:fc21 with SMTP id k3-20020a05600c0b4300b003fbb70ffc21mr66635wmr.35.1687980404448;
        Wed, 28 Jun 2023 12:26:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c294200b003fa78d1055esm14539814wmd.21.2023.06.28.12.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 12:26:44 -0700 (PDT)
Message-Id: <2b33977aba63ed21ecf74664da503750911c8dc8.1687980393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v5.git.git.1687980390.gitgitgadget@gmail.com>
References: <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>
        <pull.1497.v5.git.git.1687980390.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Jun 2023 19:26:29 +0000
Subject: [PATCH v5 10/11] config: add kvi.path, use it to evaluate includes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Include directives are evaluated using the path of the config file. To
reduce the dependence on "config_reader.source", add a new
"key_value_info.path" member and use that instead of
"config_source.path". This allows us to remove a "struct config_reader
*" field from "struct config_include_data", which will subsequently
allow us to remove "struct config_reader" entirely.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 40 +++++++++++++++++++---------------------
 config.h |  2 ++
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/config.c b/config.c
index 50dbd89a6d6..8d342d84255 100644
--- a/config.c
+++ b/config.c
@@ -162,7 +162,6 @@ struct config_include_data {
 	const struct config_options *opts;
 	struct git_config_source *config_source;
 	struct repository *repo;
-	struct config_reader *config_reader;
 
 	/*
 	 * All remote URLs discovered when reading all config files.
@@ -181,8 +180,7 @@ static const char include_depth_advice[] = N_(
 "from\n"
 "	%s\n"
 "This might be due to circular includes.");
-static int handle_path_include(struct config_source *cs,
-			       const struct key_value_info *kvi,
+static int handle_path_include(const struct key_value_info *kvi,
 			       const char *path,
 			       struct config_include_data *inc)
 {
@@ -205,14 +203,14 @@ static int handle_path_include(struct config_source *cs,
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
@@ -220,8 +218,8 @@ static int handle_path_include(struct config_source *cs,
 	if (!access_or_die(path, R_OK, 0)) {
 		if (++inc->depth > MAX_INCLUDE_DEPTH)
 			die(_(include_depth_advice), MAX_INCLUDE_DEPTH, path,
-			    !cs ? "<unknown>" :
-			    cs->name ? cs->name :
+			    !kvi ? "<unknown>" :
+			    kvi->filename ? kvi->filename :
 			    "the command line");
 		ret = git_config_from_file_with_options(git_config_include, path, inc,
 							kvi->scope, NULL);
@@ -239,7 +237,7 @@ static void add_trailing_starstar_for_dir(struct strbuf *pat)
 		strbuf_addstr(pat, "**");
 }
 
-static int prepare_include_condition_pattern(struct config_source *cs,
+static int prepare_include_condition_pattern(const struct key_value_info *kvi,
 					     struct strbuf *pat)
 {
 	struct strbuf path = STRBUF_INIT;
@@ -256,11 +254,11 @@ static int prepare_include_condition_pattern(struct config_source *cs,
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
@@ -275,7 +273,7 @@ static int prepare_include_condition_pattern(struct config_source *cs,
 	return prefix;
 }
 
-static int include_by_gitdir(struct config_source *cs,
+static int include_by_gitdir(const struct key_value_info *kvi,
 			     const struct config_options *opts,
 			     const char *cond, size_t cond_len, int icase)
 {
@@ -292,7 +290,7 @@ static int include_by_gitdir(struct config_source *cs,
 
 	strbuf_realpath(&text, git_dir, 1);
 	strbuf_add(&pattern, cond, cond_len);
-	prefix = prepare_include_condition_pattern(cs, &pattern);
+	prefix = prepare_include_condition_pattern(kvi, &pattern);
 
 again:
 	if (prefix < 0)
@@ -428,16 +426,16 @@ static int include_by_remote_url(struct config_include_data *inc,
 					     inc->remote_urls);
 }
 
-static int include_condition_is_true(struct config_source *cs,
+static int include_condition_is_true(const struct key_value_info *kvi,
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
@@ -453,7 +451,6 @@ static int git_config_include(const char *var, const char *value,
 			      void *data)
 {
 	struct config_include_data *inc = data;
-	struct config_source *cs = inc->config_reader->source;
 	const char *cond, *key;
 	size_t cond_len;
 	int ret;
@@ -467,16 +464,16 @@ static int git_config_include(const char *var, const char *value,
 		return ret;
 
 	if (!strcmp(var, "include.path"))
-		ret = handle_path_include(cs, ctx->kvi, value, inc);
+		ret = handle_path_include(ctx->kvi, value, inc);
 
 	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
-	    cond && include_condition_is_true(cs, inc, cond, cond_len) &&
+	    cond && include_condition_is_true(ctx->kvi, inc, cond, cond_len) &&
 	    !strcmp(key, "path")) {
 		config_fn_t old_fn = inc->fn;
 
 		if (inc->opts->unconditional_remote_url)
 			inc->fn = forbid_remote_url;
-		ret = handle_path_include(cs, ctx->kvi, value, inc);
+		ret = handle_path_include(ctx->kvi, value, inc);
 		inc->fn = old_fn;
 	}
 
@@ -661,6 +658,7 @@ void kvi_from_param(struct key_value_info *out)
 	out->linenr = -1;
 	out->origin_type = CONFIG_ORIGIN_CMDLINE;
 	out->scope = CONFIG_SCOPE_COMMAND;
+	out->path = NULL;
 }
 
 int git_config_parse_parameter(const char *text,
@@ -1064,6 +1062,7 @@ static void kvi_from_source(struct config_source *cs,
 	out->origin_type = cs->origin_type;
 	out->linenr = cs->linenr;
 	out->scope = scope;
+	out->path = cs->path;
 }
 
 static int git_parse_source(struct config_source *cs, config_fn_t fn,
@@ -2282,7 +2281,6 @@ int config_with_options(config_fn_t fn, void *data,
 		inc.opts = opts;
 		inc.repo = repo;
 		inc.config_source = config_source;
-		inc.config_reader = &the_reader;
 		fn = git_config_include;
 		data = &inc;
 	}
diff --git a/config.h b/config.h
index bd366ddb5ef..b5573e67a00 100644
--- a/config.h
+++ b/config.h
@@ -116,12 +116,14 @@ struct key_value_info {
 	int linenr;
 	enum config_origin_type origin_type;
 	enum config_scope scope;
+	const char *path;
 };
 #define KVI_INIT { \
 	.filename = NULL, \
 	.linenr = -1, \
 	.origin_type = CONFIG_ORIGIN_UNKNOWN, \
 	.scope = CONFIG_SCOPE_UNKNOWN, \
+	.path = NULL, \
 }
 
 /* Captures additional information that a config callback can use. */
-- 
gitgitgadget

