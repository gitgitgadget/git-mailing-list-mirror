Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB6CC64EC4
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 00:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCAAih (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 19:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCAAiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 19:38:25 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F761351C
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 16:38:24 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso5275386wmo.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 16:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJ52iU4UDr/bFhJSTuiqwm9GxuCBT5aVR/KmFwpB5d4=;
        b=di1Xi/9S9/KtWn8EhV8dc/koSS0bKSRpnpvlapQVIfxtOpBNl9Q6fC97Odsh0wVR3J
         ODMjHW+4KlDho4XHNW1RvD+fdEtl0Ws2mVmyqeO7Oq1e05zY7jTKk+XrClFvXTwFlf+w
         ExTh4AO5y5UOCwM3Rzch3V0RoEXxqgD7Ft4SRIw4l5AFVpeNlgrD3psostR/H0ooZe2Y
         bO6oqu4tnO0PJJ6yX+xYc9LNaTCqWmJurlwntIIbfLnunHj4XoD+i+ISzTRAINxcZ87G
         YDKAOED/0TScQspG63iQgn3mBk+cfIGoIbr15ahRr2nyp4OIfSAcFY3oyjwPEKBeYFvq
         40HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJ52iU4UDr/bFhJSTuiqwm9GxuCBT5aVR/KmFwpB5d4=;
        b=jdI8YV4pXHKfqns12SD89nXIu3U4cbpGFR3zhnFbZsSXGN1/bNbEiWsRrjXfnt1gos
         KbFIp7vCx6aou/JVZQPC0cG3n4T02TRiDf8SUZbz91cH3Gwlm6dd4ySDda8XWP55/RTV
         kCv4KUHFmilcHntyMLpVrGGfqIN4CJhGKhenUaeaiT8a6EfBTURQS5koFYlZjpD27Tdw
         u4zpc72MSB/kNARoKQWooJaQIg0TaphG51+BvCoehcnq2E1UFnbhSbqi6hlc9HD50ORJ
         zufYvsbPcUWaf6Hk3JJaUi+0YVaVnDSdTtOK7CbfZMisVblkqpNYUPtDzVgrFFO1b4pf
         EgFw==
X-Gm-Message-State: AO0yUKVbKUQmh43eNxzlWbUgIDg1hZPHty5eYYl1Qu0/Wh9NkEDabOr3
        QXU/NOkt/RvRf9XsCRgp98u+RKMuPfE=
X-Google-Smtp-Source: AK7set+g2KPLgicxRjXCEvwfHRqh6Sr1dnbCpJNAaAms5HCRbssbUxEe55RjDezu7CyPcuRii8Ws/g==
X-Received: by 2002:a05:600c:3549:b0:3eb:25ff:3446 with SMTP id i9-20020a05600c354900b003eb25ff3446mr3387633wmq.4.1677631102550;
        Tue, 28 Feb 2023 16:38:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o25-20020a05600c511900b003dfe549da4fsm19611380wms.18.2023.02.28.16.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 16:38:22 -0800 (PST)
Message-Id: <c05b33ab29dbce931f9d0ad968fe9eeedc653456.1677631097.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Mar 2023 00:38:16 +0000
Subject: [PATCH 5/6] config.c: remove current_config_kvi
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Add ".config_kvi" to "struct config_reader" and replace
"current_config_kvi" with "the_reader.config_kvi", either in-place (in
public functions) or by passing "the_reader" to the "*data" arg of
callback functions.

Also, introduce a setter function for ".config_kvi", which allows us to
enforce the contraint that only one of ".source" and ".config_kvi" can
be set at a time (as documented in the comments). Because of this
constraint, we know that "populate_remote_urls()" was never touching
"current_config_kvi" when iterating through config files, so it doesn't
need to store and restore that value.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 103 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 42 deletions(-)

diff --git a/config.c b/config.c
index 9676734b1b7..c7995148165 100644
--- a/config.c
+++ b/config.c
@@ -52,32 +52,28 @@ struct config_source {
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
 /* Only public functions should reference the_reader. */
 static struct config_reader the_reader;
 
-/*
- * FIXME The comments are temporarily out of date since "cf" been moved to
- * the_reader, but not current_*.
- *
- * These variables record the "current" config source, which
- * can be accessed by parsing callbacks.
- *
- * The "cf" variable will be non-NULL only when we are actually parsing a real
- * config source (file, blob, cmdline, etc).
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
@@ -90,6 +86,8 @@ static enum config_scope current_parsing_scope;
 static inline void config_reader_push_source(struct config_reader *reader,
 					     struct config_source *top)
 {
+	if (reader->config_kvi)
+		BUG("source should only be set when parsing a config source");
 	if (reader->source)
 		top->prev = reader->source;
 	reader->source = top;
@@ -105,6 +103,14 @@ static inline struct config_source *config_reader_pop_source(struct config_reade
 	return ret;
 }
 
+static inline void config_reader_set_kvi(struct config_reader *reader,
+					 struct key_value_info *kvi)
+{
+	if (kvi && reader->source)
+		BUG("kvi should only be set when iterating through configset");
+	reader->config_kvi = kvi;
+}
+
 static int pack_compression_seen;
 static int zlib_compression_seen;
 
@@ -373,20 +379,17 @@ static void populate_remote_urls(struct config_include_data *inc)
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
 
@@ -2253,26 +2256,34 @@ int config_with_options(config_fn_t fn, void *data,
 	return ret;
 }
 
+struct configset_iter_data {
+	struct config_reader *config_reader;
+	void *inner;
+};
+#define CONFIGSET_ITER_INIT { 0 }
+
 static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 {
 	int i, value_index;
 	struct string_list *values;
 	struct config_set_element *entry;
 	struct configset_list *list = &cs->list;
+	struct configset_iter_data *iter_data = data;
 
 	for (i = 0; i < list->nr; i++) {
+		struct key_value_info *kvi;
 		entry = list->items[i].e;
 		value_index = list->items[i].value_index;
 		values = &entry->value_list;
 
-		current_config_kvi = values->items[value_index].util;
+		kvi = values->items[value_index].util;
+		config_reader_set_kvi(iter_data->config_reader, kvi);
 
-		if (fn(entry->key, values->items[value_index].string, data) < 0)
-			git_die_config_linenr(entry->key,
-					      current_config_kvi->filename,
-					      current_config_kvi->linenr);
+		if (fn(entry->key, values->items[value_index].string, iter_data->inner) < 0)
+			git_die_config_linenr(entry->key, kvi->filename,
+					      kvi->linenr);
 
-		current_config_kvi = NULL;
+		config_reader_set_kvi(iter_data->config_reader, NULL);
 	}
 }
 
@@ -2607,10 +2618,14 @@ static void repo_config_clear(struct repository *repo)
 	git_configset_clear(repo->config);
 }
 
-void repo_config(struct repository *repo, config_fn_t fn, void *data)
+void repo_config(struct repository *repo, config_fn_t fn, void *data_inner)
 {
+	struct configset_iter_data data = CONFIGSET_ITER_INIT;
+	data.inner = data_inner;
+	data.config_reader = &the_reader;
+
 	git_config_check_init(repo);
-	configset_iter(repo->config, fn, data);
+	configset_iter(repo->config, fn, &data);
 }
 
 int repo_config_get_value(struct repository *repo,
@@ -2712,11 +2727,15 @@ static void read_protected_config(void)
 	config_with_options(config_set_callback, &data, NULL, &opts);
 }
 
-void git_protected_config(config_fn_t fn, void *data)
+void git_protected_config(config_fn_t fn, void *data_inner)
 {
+	struct configset_iter_data data = CONFIGSET_ITER_INIT;
 	if (!protected_config.hash_initialized)
 		read_protected_config();
-	configset_iter(&protected_config, fn, data);
+	data.inner = data_inner;
+	data.config_reader = &the_reader;
+
+	configset_iter(&protected_config, fn, &data);
 }
 
 /* Functions used historically to read configuration from 'the_repository' */
@@ -3823,8 +3842,8 @@ int parse_config_key(const char *var,
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
@@ -3869,8 +3888,8 @@ const char *config_scope_name(enum config_scope scope)
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
@@ -3880,16 +3899,16 @@ const char *current_config_name(void)
 
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

