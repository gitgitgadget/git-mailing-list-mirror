Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8378DC7618B
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 00:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjCPAMI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 20:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjCPAL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 20:11:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0AE125B0
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 17:11:53 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id y14so12316wrq.4
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 17:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678925512;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fp3kbx1zPVFKfLCjv8tYlCI284ci22MmJwyoModsAuE=;
        b=OglDEdiQlsbXu0fZTFDupetedJ7stuwVWe8t0kqMgwCMq0/5Wx6BkPdrJhwKdHQaNG
         bb8LFxg46woPWXTl69jml39a27gSaBEd0lKpJ8LIL5gKuicgT66KYTwR97rtPucRJkHM
         wMSlSyl5eeNv/SGRGQS5Mm5orc1Nq5+P1jaLrnTsYCe6nMCuaTwfumkKdAcoKik2fNpt
         3gPCd2G8x4g1vHy7Nc7rvZZsGiTcWi79qwh9jqwCloJENS4JpcJnf42ITiVdEIzYRgPt
         FlRZZHleHRcGThMjEnO0eNdDA+5AgJOsPJDb0zvod1RoCE1M4AMGTqcC1JLA3KIBPkeV
         oSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678925512;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fp3kbx1zPVFKfLCjv8tYlCI284ci22MmJwyoModsAuE=;
        b=IM5dV74B+tQD3D2B8rNvD1cNZ7T3iU7YtfTU8hfsBrciZ0NuuD/M4o3BSQ4z5HqjqD
         dVo2O5vEG+i4/AB1QpjXGncn5XTxpVmRKHL13m3DR+16g2/Fbs4Bbe7FvEVjk7t2FVJa
         1mpwNy7LgegY2DNYYEB48r0OyBzchqNrYXNA/gZHAMLJHWpYUbbDEWQH2cEVUstftb++
         O9x2xj/srQTb9EcEBl8XXGHzDKIKN1JzzC/wQipKkSLdFhztSes5VFECsF1O9TDIP00u
         qiwmkAnYUskwexU8jiw/oCRC1+ni7kkcm+e1Nw/dQ7FCjpZb3z/TzMeD/OJlKrzy3Mx8
         hVXQ==
X-Gm-Message-State: AO0yUKUzkl1iIm7vXiTC5dSWdW6Nx8g6Szh6LmzXX/hwUWjpZOPlXwhz
        CcpBgwXn5xy0XIlTOeHr0Ousmr+0aMg=
X-Google-Smtp-Source: AK7set+7mEkLX80xzPzI8hruKmc5Px9IbI9bzB/Tz1xtMEqAMHLBqARgOlDRYprxQwdYcGeXFwWK/Q==
X-Received: by 2002:adf:fd46:0:b0:2cf:e054:65f1 with SMTP id h6-20020adffd46000000b002cfe05465f1mr3236467wrs.48.1678925512112;
        Wed, 15 Mar 2023 17:11:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3-20020a5d5143000000b002c70c99db74sm5757718wrt.86.2023.03.15.17.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 17:11:51 -0700 (PDT)
Message-Id: <afb6e3e318da3ff2f6c904459b28eac2444f0897.1678925506.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
        <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Mar 2023 00:11:43 +0000
Subject: [PATCH v2 5/8] config.c: remove current_config_kvi
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
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
index b75cde42ca6..ba9b488c40d 100644
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
 	if (reader->source)
 		top->prev = reader->source;
 	reader->source = top;
@@ -110,6 +108,14 @@ static inline struct config_source *config_reader_pop_source(struct config_reade
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
 
@@ -378,20 +384,17 @@ static void populate_remote_urls(struct config_include_data *inc)
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
 
@@ -2258,7 +2261,8 @@ int config_with_options(config_fn_t fn, void *data,
 	return ret;
 }
 
-static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
+static void configset_iter(struct config_reader *reader, struct config_set *cs,
+			   config_fn_t fn, void *data)
 {
 	int i, value_index;
 	struct string_list *values;
@@ -2270,14 +2274,14 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
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
 
@@ -2615,7 +2619,7 @@ static void repo_config_clear(struct repository *repo)
 void repo_config(struct repository *repo, config_fn_t fn, void *data)
 {
 	git_config_check_init(repo);
-	configset_iter(repo->config, fn, data);
+	configset_iter(&the_reader, repo->config, fn, data);
 }
 
 int repo_config_get_value(struct repository *repo,
@@ -2721,7 +2725,7 @@ void git_protected_config(config_fn_t fn, void *data)
 {
 	if (!protected_config.hash_initialized)
 		read_protected_config();
-	configset_iter(&protected_config, fn, data);
+	configset_iter(&the_reader, &protected_config, fn, data);
 }
 
 /* Functions used historically to read configuration from 'the_repository' */
@@ -3828,8 +3832,8 @@ int parse_config_key(const char *var,
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
@@ -3874,8 +3878,8 @@ const char *config_scope_name(enum config_scope scope)
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
@@ -3885,16 +3889,16 @@ const char *current_config_name(void)
 
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

