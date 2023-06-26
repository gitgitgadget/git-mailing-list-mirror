Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD77CEB64D9
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 18:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjFZSMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 14:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjFZSLt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 14:11:49 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302E310DB
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 11:11:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fa7512e599so45631045e9.2
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 11:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687803096; x=1690395096;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsvHJPvbkBnOvDjNKBB4qghkPWBWm4LnlCClojfWQp8=;
        b=dbD11fF8nzdIM8htPsNrfbLgPYxd4oFuIv3M4/vmoKP/glUaPxjTzyyKaJD1SKLW9+
         WeUuRI1XhoZpB2eQKKOxvHIjiTW096kCkpxIQA4fybxcGJkxrcUB13CmSODs95Tn1BWS
         5+vohl5WSE9hUOJGgtao6g11dgRdG0x3vJmQ9sEMtXiT06RPso/p6jOAOPc0dasQHjG/
         hliM62Zn69UZxCEdVXDOFPf8hzcV1BadeYy+ZWh1iJpuca6qDrPagCNWqClw9chQbzd6
         qURAvwIA9bfnW7ufkYvE7mlpztCxAuy7T7sSyWKX0U3itF9pQBSB+jVvSSvWWNoFzR+9
         is7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687803096; x=1690395096;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsvHJPvbkBnOvDjNKBB4qghkPWBWm4LnlCClojfWQp8=;
        b=kkI6N3/pUOypvkEIPNcJS6F7zgg9JLPegfQ5ANWQZ/bLW/YImcgBThRvs3mHDbjsVj
         qRLKRA634/TO8RwFbJvW2EdYpYzbwb+kpsMoOcIKWUTUaMJD3VOhcyFlH/i0/PGYw1OM
         eorfStxNDLXcdOal7CeOavAmpO/woMATnx56S3A3v8HUp0kwGkG+pKAOhkQvH6x74gG3
         l1merGDqJM+JtcbubdpJCeBN/6eub05MpY+SfUywNmvroc8HJ89y3ZXlrGNm5/XdhTzU
         BWy69l2Klir7psOabCmDlQhmD3+PtOIRNi4qjxssdXS3sI3T8k8AJSg/5DvkYDLNYs4o
         DD7A==
X-Gm-Message-State: AC+VfDy0l0O78wBdlcCwMTfVLL1IXeMwYmGJ83gbup2M2dCVvoovca3b
        GsxIHdO/mu6jxIR0S1mGXPaTAFggDu8=
X-Google-Smtp-Source: ACHHUZ7cx3JFmYJpHjTDqVZJx22boOx83NR1bMzqBuDqU1HXuu5bxE8uXfn6veFhZlrDPRrUFBjdIw==
X-Received: by 2002:a7b:cd85:0:b0:3fa:826d:1e93 with SMTP id y5-20020a7bcd85000000b003fa826d1e93mr6722962wmj.21.1687803096309;
        Mon, 26 Jun 2023 11:11:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2-20020a1ccc02000000b003fa74bff02asm8350394wmb.26.2023.06.26.11.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 11:11:36 -0700 (PDT)
Message-Id: <3f0f84df9721ea94981b728e76b5354d73aab2ce.1687803086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>
References: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
        <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 18:11:22 +0000
Subject: [PATCH v4 11/12] config: add kvi.path, use it to evaluate includes
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
index 4782a289363..070245065f4 100644
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

