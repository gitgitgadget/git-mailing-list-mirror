Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DF5EB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 19:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjF1T1F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 15:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjF1T0x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 15:26:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810D22134
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 12:26:45 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fa94ea1caaso2846725e9.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 12:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687980403; x=1690572403;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5d66zPjc78uw36gh22BpFIIH6C/B33K7vEwi4j9BT5A=;
        b=nVu+gjvTqfu8gnuS2gv1llIYJ1uoAiGtTRe+oFPHBJltqjgJKZ1PBFkox+DhI18XJe
         oDp+IGMQzrBDgTOKJP05VQ39zIMXx0zBavN8QmJef+eom/8HteAzFzyINtC75xnSsVAQ
         zHoDE/pTQ48pSfMMwEMhbUhcxfpKLFjR2okco4ZsG2CVrgskJuGoffR5effNpcN1QUk6
         s/vr002BzSS4k/iI3h+YNp9Sx6JX5Z9UH+SqPT5qf9vq3kyYT7WDepOmdtR/Nv1UqQo6
         bTGUK7LIf3TtEmikmP9vloyhqTeTkztXlbLIZYqYaXjNW2WB+MXSRQnUPknsoiuj/+hm
         jMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687980403; x=1690572403;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5d66zPjc78uw36gh22BpFIIH6C/B33K7vEwi4j9BT5A=;
        b=RwEk9G+k/jwruvjFvrpk/JR0pvpDyeI9ClpSw3OMqHPb/c7qIr/GCH5m1/M4TETVak
         4+Mw21YEac037gR3jdLbC0nrwxiZFCueN+Asm7/x9kDBC+WZXaqaFG5BmL7Jfh+t8jKi
         fFwsWZd0XCg51lzp2ZHuFN+9IHg8CWvCA8DwjpgTSOsLWeU7dPTXFQWpklsHKr+405ay
         Mpd82qlaBl3AoJEyMTrlo0cqKJYufaUJ3IdCotflZ3b8EgSmlDSSoAx4cfNRDSaXMFPd
         Mr4lCXPRvADco2R6LFddouduod2whfbxw03caGQbiFPDoIGKtg30N+8LCvhO+ol6qe8r
         Dbtg==
X-Gm-Message-State: AC+VfDyOG+f9YrikHjN6OmBBxTUW5vdIwGKQbet7OQCWLomOB8UXHBFN
        ka5+29sdoJs3BBlI6GbY2oAJBulKYMY=
X-Google-Smtp-Source: ACHHUZ6A4zElxRgkegjKm33iKr7fAcR/axs48d0nyiHhExIwl01OO8rUL2XydvGaZ+Cdfek4nwB38g==
X-Received: by 2002:a7b:c8c4:0:b0:3fa:8c8b:716 with SMTP id f4-20020a7bc8c4000000b003fa8c8b0716mr2416470wml.1.1687980403529;
        Wed, 28 Jun 2023 12:26:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11-20020a7bc4cb000000b003fbab76165asm3950150wmk.48.2023.06.28.12.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 12:26:43 -0700 (PDT)
Message-Id: <4776600e790d6d4ffcba8ff4cb648b7100e08c31.1687980393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v5.git.git.1687980390.gitgitgadget@gmail.com>
References: <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>
        <pull.1497.v5.git.git.1687980390.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Jun 2023 19:26:28 +0000
Subject: [PATCH v5 09/11] config.c: remove config_reader from configsets
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

Remove the last usage of "struct config_reader" from configsets by
copying the "kvi" arg instead of recomputing "kvi" from
config_reader.source. Since we no longer need to pass both "struct
config_reader" and "struct config_set" in a single "void *cb", remove
"struct configset_add_data" too.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 45 +++++++++++----------------------------------
 1 file changed, 11 insertions(+), 34 deletions(-)

diff --git a/config.c b/config.c
index 4e3c4dcf415..50dbd89a6d6 100644
--- a/config.c
+++ b/config.c
@@ -2311,8 +2311,7 @@ int config_with_options(config_fn_t fn, void *data,
 	return ret;
 }
 
-static void configset_iter(struct config_reader *reader, struct config_set *set,
-			   config_fn_t fn, void *data)
+static void configset_iter(struct config_set *set, config_fn_t fn, void *data)
 {
 	int i, value_index;
 	struct string_list *values;
@@ -2406,7 +2405,6 @@ static int configset_find_element(struct config_set *set, const char *key,
 }
 
 static int configset_add_value(const struct key_value_info *kvi_p,
-			       struct config_reader *reader,
 			       struct config_set *set, const char *key,
 			       const char *value)
 {
@@ -2437,13 +2435,7 @@ static int configset_add_value(const struct key_value_info *kvi_p,
 	l_item->e = e;
 	l_item->value_index = e->value_list.nr - 1;
 
-	if (!reader->source)
-		BUG("configset_add_value has no source");
-	if (reader->source->name) {
-		kvi_from_source(reader->source, kvi_p->scope, kv_info);
-	} else {
-		kvi_from_param(kv_info);
-	}
+	*kv_info = *kvi_p;
 	si->util = kv_info;
 
 	return 0;
@@ -2491,28 +2483,18 @@ void git_configset_clear(struct config_set *set)
 	set->list.items = NULL;
 }
 
-struct configset_add_data {
-	struct config_set *config_set;
-	struct config_reader *config_reader;
-};
-#define CONFIGSET_ADD_INIT { 0 }
-
 static int config_set_callback(const char *key, const char *value,
 			       const struct config_context *ctx,
 			       void *cb)
 {
-	struct configset_add_data *data = cb;
-	configset_add_value(ctx->kvi, data->config_reader, data->config_set,
-			    key, value);
+	struct config_set *set = cb;
+	configset_add_value(ctx->kvi, set, key, value);
 	return 0;
 }
 
 int git_configset_add_file(struct config_set *set, const char *filename)
 {
-	struct configset_add_data data = CONFIGSET_ADD_INIT;
-	data.config_reader = &the_reader;
-	data.config_set = set;
-	return git_config_from_file(config_set_callback, filename, &data);
+	return git_config_from_file(config_set_callback, filename, set);
 }
 
 int git_configset_get_value(struct config_set *set, const char *key,
@@ -2678,7 +2660,6 @@ int git_configset_get_pathname(struct config_set *set, const char *key, const ch
 static void repo_read_config(struct repository *repo)
 {
 	struct config_options opts = { 0 };
-	struct configset_add_data data = CONFIGSET_ADD_INIT;
 
 	opts.respect_includes = 1;
 	opts.commondir = repo->commondir;
@@ -2690,10 +2671,8 @@ static void repo_read_config(struct repository *repo)
 		git_configset_clear(repo->config);
 
 	git_configset_init(repo->config);
-	data.config_set = repo->config;
-	data.config_reader = &the_reader;
-
-	if (config_with_options(config_set_callback, &data, NULL, repo, &opts) < 0)
+	if (config_with_options(config_set_callback, repo->config, NULL,
+				repo, &opts) < 0)
 		/*
 		 * config_with_options() normally returns only
 		 * zero, as most errors are fatal, and
@@ -2725,7 +2704,7 @@ static void repo_config_clear(struct repository *repo)
 void repo_config(struct repository *repo, config_fn_t fn, void *data)
 {
 	git_config_check_init(repo);
-	configset_iter(&the_reader, repo->config, fn, data);
+	configset_iter(repo->config, fn, data);
 }
 
 int repo_config_get(struct repository *repo, const char *key)
@@ -2832,19 +2811,17 @@ static void read_protected_config(void)
 		.ignore_worktree = 1,
 		.system_gently = 1,
 	};
-	struct configset_add_data data = CONFIGSET_ADD_INIT;
 
 	git_configset_init(&protected_config);
-	data.config_set = &protected_config;
-	data.config_reader = &the_reader;
-	config_with_options(config_set_callback, &data, NULL, NULL, &opts);
+	config_with_options(config_set_callback, &protected_config, NULL,
+			    NULL, &opts);
 }
 
 void git_protected_config(config_fn_t fn, void *data)
 {
 	if (!protected_config.hash_initialized)
 		read_protected_config();
-	configset_iter(&the_reader, &protected_config, fn, data);
+	configset_iter(&protected_config, fn, data);
 }
 
 /* Functions used historically to read configuration from 'the_repository' */
-- 
gitgitgadget

