Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BC9C761AF
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjC1RwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjC1RwE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:52:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61066EC55
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:52:01 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t4so7863213wra.7
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680025919;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dnhUZOb4gchAzO3NZrajGYFaK0JwbYAObXMtWCIw4Y=;
        b=jviqV6y+WP6YrRoR6ObcUTfPv0TbUgMo0W0wwdsVIovxZUL0YEJA+sb+FEFN0EyP+M
         1d+IeJHzDCTtA5VvBINIRIVOA+PwrRoN/1+MdnzVDsJbWdwBZVQmWyxnCaDkMqrlnmlZ
         XP8coGQlJo434ulskrT86xEIbjQ1GTwyctcq1vZuISEnS2SXUHmGMmbqmt6zCFJXSCz3
         x9sFw3YLwoOES3WzU8pVL95pC4R6FEbvluUo2RG5dod28vD5U2H0AI9/ylP1CbjSh/1s
         GL5LZiFR64olT6RlWOUyoDrBzDv++6TE7osKEBgNrQDXByooyDErhNB7hZJ7fKh9DDXx
         UjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025919;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dnhUZOb4gchAzO3NZrajGYFaK0JwbYAObXMtWCIw4Y=;
        b=LcIwHWbxXNFp4Ch15cAuFmEUPkuBDIVtZ61OXsJavf/DxwxezKnkWsXAmAERo7VOnJ
         hCJcwGxdyN7oSSeRBJx8OWgKMUJmwcGc+kIqepBx6YdbNDxDIZ1EddH2QkS2FqA2VhDE
         28WZI+yYV0fiaNqgtIf6O+jPtgmvcHhQPvnBBvIp6k4c1g+mzGFYI6c6PWC/NaACaYVo
         y+ssIghjyrC+aAZA3GGLnP10dyt0yAUCrg9ekaI8S7KGemnUGoeuu7nNsU4O3ipUKLvB
         yScWu3RjCx9WlGYsGHvAjPuIDXm+FSnq36bqLSvsLJ9f+4JgKGkJveh4DzUW9ODmwcOn
         OBDg==
X-Gm-Message-State: AAQBX9d0zlOmhnqogaxXCJdpIf9QEM+SMMqHs5R5hFFobKXcN8EbwuDR
        i8Z7J8hmdvJpDgzeP94zMcDoXgx+ZPA=
X-Google-Smtp-Source: AKy350aqBIlwggUmnqeD4yeNOeZv9wbKZBo85oSGJdHCBcvhmiZ9wzDuw/Q2jiX5AbcvFJLeWdS+2w==
X-Received: by 2002:adf:fa4c:0:b0:2da:75c5:e127 with SMTP id y12-20020adffa4c000000b002da75c5e127mr11766800wrr.23.1680025919340;
        Tue, 28 Mar 2023 10:51:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600001ce00b002da76acfee1sm15858449wrx.28.2023.03.28.10.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:51:59 -0700 (PDT)
Message-Id: <c79eaf74f89803dbc117a80ef6da65898aaa23e5.1680025914.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com>
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
        <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Mar 2023 17:51:51 +0000
Subject: [PATCH v3 5/8] config.c: remove current_config_kvi
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Add ".config_kvi" to "struct config_reader" and replace
"current_config_kvi" with "the_reader.config_kvi", plumbing "struct
config_reader" where necesssary.

Also, introduce a setter function for ".config_kvi", which allows us to
enforce the contraint that only one of ".source" and ".config_kvi" can
be set at a time (as documented in the comments). Because of this
constraint, we know that "populate_remote_urls()" was never touching
"current_config_kvi" when iterating through config files, so it doesn't
need to store and restore that value.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 82 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 43 insertions(+), 39 deletions(-)

diff --git a/config.c b/config.c
index cb6ff134f5f..71ee36f069b 100644
--- a/config.c
+++ b/config.c
@@ -52,7 +52,24 @@ struct config_source {
 #define CONFIG_SOURCE_INIT { 0 }
 
 struct config_reader {
+	/*
+	 * These members record the "current" config source, which can be
+	 * accessed by parsing callbacks.
+	 *
+	 * The "source" variable will be non-NULL only when we are actually
+	 * parsing a real config source (file, blob, cmdline, etc).
+	 *
+	 * The "config_kvi" variable will be non-NULL only when we are feeding
+	 * cached config from a configset into a callback.
+	 *
+	 * They cannot be non-NULL at the same time. If they are both NULL, then
+	 * we aren't parsing anything (and depending on the function looking at
+	 * the variables, it's either a bug for it to be called in the first
+	 * place, or it's a function which can be reused for non-config
+	 * purposes, and should fall back to some sane behavior).
+	 */
 	struct config_source *source;
+	struct key_value_info *config_kvi;
 };
 /*
  * Where possible, prefer to accept "struct config_reader" as an arg than to use
@@ -61,27 +78,6 @@ struct config_reader {
  */
 static struct config_reader the_reader;
 
-/*
- * FIXME The comments are temporarily out of date since "cf_global" has been
- * moved to the_reader, but not current_*.
- *
- * These variables record the "current" config source, which
- * can be accessed by parsing callbacks.
- *
- * The "cf_global" variable will be non-NULL only when we are actually
- * parsing a real config source (file, blob, cmdline, etc).
- *
- * The "current_config_kvi" variable will be non-NULL only when we are feeding
- * cached config from a configset into a callback.
- *
- * They should generally never be non-NULL at the same time. If they are both
- * NULL, then we aren't parsing anything (and depending on the function looking
- * at the variables, it's either a bug for it to be called in the first place,
- * or it's a function which can be reused for non-config purposes, and should
- * fall back to some sane behavior).
- */
-static struct key_value_info *current_config_kvi;
-
 /*
  * Similar to the variables above, this gives access to the "scope" of the
  * current value (repo, global, etc). For cached values, it can be found via
@@ -95,6 +91,8 @@ static enum config_scope current_parsing_scope;
 static inline void config_reader_push_source(struct config_reader *reader,
 					     struct config_source *top)
 {
+	if (reader->config_kvi)
+		BUG("source should not be set while iterating a config set");
 	top->prev = reader->source;
 	reader->source = top;
 }
@@ -109,6 +107,14 @@ static inline struct config_source *config_reader_pop_source(struct config_reade
 	return ret;
 }
 
+static inline void config_reader_set_kvi(struct config_reader *reader,
+					 struct key_value_info *kvi)
+{
+	if (kvi && reader->source)
+		BUG("kvi should not be set while parsing a config source");
+	reader->config_kvi = kvi;
+}
+
 static int pack_compression_seen;
 static int zlib_compression_seen;
 
@@ -377,20 +383,17 @@ static void populate_remote_urls(struct config_include_data *inc)
 {
 	struct config_options opts;
 
-	struct key_value_info *store_kvi = current_config_kvi;
 	enum config_scope store_scope = current_parsing_scope;
 
 	opts = *inc->opts;
 	opts.unconditional_remote_url = 1;
 
-	current_config_kvi = NULL;
 	current_parsing_scope = 0;
 
 	inc->remote_urls = xmalloc(sizeof(*inc->remote_urls));
 	string_list_init_dup(inc->remote_urls);
 	config_with_options(add_remote_url, inc->remote_urls, inc->config_source, &opts);
 
-	current_config_kvi = store_kvi;
 	current_parsing_scope = store_scope;
 }
 
@@ -2257,7 +2260,8 @@ int config_with_options(config_fn_t fn, void *data,
 	return ret;
 }
 
-static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
+static void configset_iter(struct config_reader *reader, struct config_set *cs,
+			   config_fn_t fn, void *data)
 {
 	int i, value_index;
 	struct string_list *values;
@@ -2269,14 +2273,14 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 		value_index = list->items[i].value_index;
 		values = &entry->value_list;
 
-		current_config_kvi = values->items[value_index].util;
+		config_reader_set_kvi(reader, values->items[value_index].util);
 
 		if (fn(entry->key, values->items[value_index].string, data) < 0)
 			git_die_config_linenr(entry->key,
-					      current_config_kvi->filename,
-					      current_config_kvi->linenr);
+					      reader->config_kvi->filename,
+					      reader->config_kvi->linenr);
 
-		current_config_kvi = NULL;
+		config_reader_set_kvi(reader, NULL);
 	}
 }
 
@@ -2614,7 +2618,7 @@ static void repo_config_clear(struct repository *repo)
 void repo_config(struct repository *repo, config_fn_t fn, void *data)
 {
 	git_config_check_init(repo);
-	configset_iter(repo->config, fn, data);
+	configset_iter(&the_reader, repo->config, fn, data);
 }
 
 int repo_config_get_value(struct repository *repo,
@@ -2720,7 +2724,7 @@ void git_protected_config(config_fn_t fn, void *data)
 {
 	if (!protected_config.hash_initialized)
 		read_protected_config();
-	configset_iter(&protected_config, fn, data);
+	configset_iter(&the_reader, &protected_config, fn, data);
 }
 
 /* Functions used historically to read configuration from 'the_repository' */
@@ -3827,8 +3831,8 @@ int parse_config_key(const char *var,
 const char *current_config_origin_type(void)
 {
 	int type;
-	if (current_config_kvi)
-		type = current_config_kvi->origin_type;
+	if (the_reader.config_kvi)
+		type = the_reader.config_kvi->origin_type;
 	else if(the_reader.source)
 		type = the_reader.source->origin_type;
 	else
@@ -3873,8 +3877,8 @@ const char *config_scope_name(enum config_scope scope)
 const char *current_config_name(void)
 {
 	const char *name;
-	if (current_config_kvi)
-		name = current_config_kvi->filename;
+	if (the_reader.config_kvi)
+		name = the_reader.config_kvi->filename;
 	else if (the_reader.source)
 		name = the_reader.source->name;
 	else
@@ -3884,16 +3888,16 @@ const char *current_config_name(void)
 
 enum config_scope current_config_scope(void)
 {
-	if (current_config_kvi)
-		return current_config_kvi->scope;
+	if (the_reader.config_kvi)
+		return the_reader.config_kvi->scope;
 	else
 		return current_parsing_scope;
 }
 
 int current_config_line(void)
 {
-	if (current_config_kvi)
-		return current_config_kvi->linenr;
+	if (the_reader.config_kvi)
+		return the_reader.config_kvi->linenr;
 	else
 		return the_reader.source->linenr;
 }
-- 
gitgitgadget

