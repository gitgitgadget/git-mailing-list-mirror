Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4ADEB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 19:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjFTToo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjFTToR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 15:44:17 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3431F1739
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-311394406d0so2655809f8f.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687290245; x=1689882245;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bl/kaHAXQV1IJdSYqT7aUlIAQAxYd4yoZ0swYbg9fH8=;
        b=QUhb7VU6szp8oqcBIGvdFeCb8IjnnIAlyZeBDItwDC0tDVw/28TJXz7YiSvCEFM+W9
         RejCzVPVNmvZQ1zula2gLheo9aZLH7kO1jjBHZMTbLUqpg1IKeW9pe7Gx1oVoWzZcJ7o
         i+svnQkjfyz6zlLdFByoby6ID0agfdwVjdfrWUYOMAu0xDl4CPGw4oXmpQfuat6oW0xb
         lkbpqJ63EQes8LWGc8llmZgGy4bGtK7N5XOsjr9zq98T/NsGKT+hkuEOnkPccRzTcDST
         JvMC/yPMBwEshXr9L6f2/s3iQ4Qj5aNZESQmsT1O/+Y0rR/JdM9XDioMAAzMj4bJFolR
         DtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290245; x=1689882245;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bl/kaHAXQV1IJdSYqT7aUlIAQAxYd4yoZ0swYbg9fH8=;
        b=fgs6gbjuAyZRuukTfAY0NkbStjGqfa1RlChizptyQvcLqN4Q+5ngdOd7MXEa+jEzLq
         Zno9eGhc4AlaDeBZKjVK2s3ymlBxnIdE7aoAlRtms5u4xdkDvQRhjjumqCFUzKyqFepd
         0ul4qxZiYbKDmZMMxn77mMxxVDZhQ4VGrIT7fgmUu3SQxPUdAi8jbeUWUhsZCKT5A45E
         lLrsiw6rC3fUyPxEuFdVifx/BuI4xIu88ZbHcvkxZ9LSZQl4GuHk67+F1Lq2HZRIW8yW
         6PjCix77AzUXSELT2jskbzX1eRClcx+IDy7qhMOZrsCpjQiEgPF4b3y/KEx35rtRAxwk
         kQUA==
X-Gm-Message-State: AC+VfDzBOnw9QOdYECLjGbtSvF6la31efbiGyLy9mZXbg4uZtUiuMzmd
        a1zDhUw0rjCxHfSqkfMPCRUQyWQGwjk=
X-Google-Smtp-Source: ACHHUZ65PxKoKSDsLQwubfE3y0+nMqafn+bBp2PZAaq8yZ+DAmZntJZ2gBZF3c9VkBS0daslK1JPRA==
X-Received: by 2002:adf:f203:0:b0:311:19df:dac7 with SMTP id p3-20020adff203000000b0031119dfdac7mr8929977wro.28.1687290245395;
        Tue, 20 Jun 2023 12:44:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d6545000000b003113bd9ecaesm2601982wrv.116.2023.06.20.12.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:44:04 -0700 (PDT)
Message-Id: <484d553cc7da360b134e7cfcc02e587073b1f9fa.1687290233.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
References: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
        <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jun 2023 19:43:51 +0000
Subject: [PATCH v3 12/12] config: pass source to config_parser_event_fn_t
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

..so that the callback can use a "struct config_source" parameter
instead of "config_reader.source". "struct config_source" is internal to
config.c, so we are adding a pointer to a struct defined in config.c
into a public function signature defined in config.h, but this is okay
because this function has only ever been (and probably ever will be)
used internally by config.c.

As a result, the_reader isn't used anywhere, so "struct config_reader"
is obsolete (it was only intended to be used with the_reader). Remove
them.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 77 ++++++++++----------------------------------------------
 config.h |  6 +++++
 2 files changed, 19 insertions(+), 64 deletions(-)

diff --git a/config.c b/config.c
index 04c7db6f1be..c58e44b15c5 100644
--- a/config.c
+++ b/config.c
@@ -66,40 +66,6 @@ struct config_source {
 };
 #define CONFIG_SOURCE_INIT { 0 }
 
-struct config_reader {
-	/*
-	 * These members record the "current" config source, which can be
-	 * accessed by parsing callbacks.
-	 *
-	 * The "source" variable will be non-NULL only when we are actually
-	 * parsing a real config source (file, blob, cmdline, etc).
-	 */
-	struct config_source *source;
-};
-/*
- * Where possible, prefer to accept "struct config_reader" as an arg than to use
- * "the_reader". "the_reader" should only be used if that is infeasible, e.g. in
- * a public function.
- */
-static struct config_reader the_reader;
-
-static inline void config_reader_push_source(struct config_reader *reader,
-					     struct config_source *top)
-{
-	top->prev = reader->source;
-	reader->source = top;
-}
-
-static inline struct config_source *config_reader_pop_source(struct config_reader *reader)
-{
-	struct config_source *ret;
-	if (!reader->source)
-		BUG("tried to pop config source, but we weren't reading config");
-	ret = reader->source;
-	reader->source = reader->source->prev;
-	return ret;
-}
-
 static int pack_compression_seen;
 static int zlib_compression_seen;
 
@@ -750,14 +716,9 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	struct strvec to_free = STRVEC_INIT;
 	int ret = 0;
 	char *envw = NULL;
-	struct config_source source = CONFIG_SOURCE_INIT;
 	struct key_value_info kvi = KVI_INIT;
 
-	source.origin_type = CONFIG_ORIGIN_CMDLINE;
-	config_reader_push_source(&the_reader, &source);
-
 	kvi_from_param(&kvi);
-
 	env = getenv(CONFIG_COUNT_ENVIRONMENT);
 	if (env) {
 		unsigned long count;
@@ -814,7 +775,6 @@ out:
 	strbuf_release(&envvar);
 	strvec_clear(&to_free);
 	free(envw);
-	config_reader_pop_source(&the_reader);
 	return ret;
 }
 
@@ -1043,7 +1003,7 @@ static int do_event(struct config_source *cs, enum config_event_t type,
 
 	if (data->previous_type != CONFIG_EVENT_EOF &&
 	    data->opts->event_fn(data->previous_type, data->previous_offset,
-				 offset, data->opts->event_fn_data) < 0)
+				 offset, cs, data->opts->event_fn_data) < 0)
 		return -1;
 
 	data->previous_type = type;
@@ -2005,8 +1965,7 @@ int git_default_config(const char *var, const char *value,
  * fgetc, ungetc, ftell of top need to be initialized before calling
  * this function.
  */
-static int do_config_from(struct config_reader *reader,
-			  struct config_source *top, config_fn_t fn,
+static int do_config_from(struct config_source *top, config_fn_t fn,
 			  void *data, enum config_scope scope,
 			  const struct config_options *opts)
 {
@@ -2019,21 +1978,17 @@ static int do_config_from(struct config_reader *reader,
 	top->total_len = 0;
 	strbuf_init(&top->value, 1024);
 	strbuf_init(&top->var, 1024);
-	config_reader_push_source(reader, top);
 	kvi_from_source(top, scope, &kvi);
 
 	ret = git_parse_source(top, fn, &kvi, data, opts);
 
-	/* pop config-file parsing state stack */
 	strbuf_release(&top->value);
 	strbuf_release(&top->var);
-	config_reader_pop_source(reader);
 
 	return ret;
 }
 
-static int do_config_from_file(struct config_reader *reader,
-			       config_fn_t fn,
+static int do_config_from_file(config_fn_t fn,
 			       const enum config_origin_type origin_type,
 			       const char *name, const char *path, FILE *f,
 			       void *data, enum config_scope scope,
@@ -2052,7 +2007,7 @@ static int do_config_from_file(struct config_reader *reader,
 	top.do_ftell = config_file_ftell;
 
 	flockfile(f);
-	ret = do_config_from(reader, &top, fn, data, scope, opts);
+	ret = do_config_from(&top, fn, data, scope, opts);
 	funlockfile(f);
 	return ret;
 }
@@ -2060,8 +2015,8 @@ static int do_config_from_file(struct config_reader *reader,
 static int git_config_from_stdin(config_fn_t fn, void *data,
 				 enum config_scope scope)
 {
-	return do_config_from_file(&the_reader, fn, CONFIG_ORIGIN_STDIN, "",
-				   NULL, stdin, data, scope, NULL);
+	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin,
+				   data, scope, NULL);
 }
 
 int git_config_from_file_with_options(config_fn_t fn, const char *filename,
@@ -2075,9 +2030,8 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
 		BUG("filename cannot be NULL");
 	f = fopen_or_warn(filename, "r");
 	if (f) {
-		ret = do_config_from_file(&the_reader, fn, CONFIG_ORIGIN_FILE,
-					  filename, filename, f, data, scope,
-					  opts);
+		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename,
+					  filename, f, data, scope, opts);
 		fclose(f);
 	}
 	return ret;
@@ -2108,7 +2062,7 @@ int git_config_from_mem(config_fn_t fn,
 	top.do_ungetc = config_buf_ungetc;
 	top.do_ftell = config_buf_ftell;
 
-	return do_config_from(&the_reader, &top, fn, data, scope, opts);
+	return do_config_from(&top, fn, data, scope, opts);
 }
 
 int git_config_from_blob_oid(config_fn_t fn,
@@ -2201,8 +2155,7 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
 
-static int do_git_config_sequence(struct config_reader *reader,
-				  const struct config_options *opts,
+static int do_git_config_sequence(const struct config_options *opts,
 				  config_fn_t fn, void *data)
 {
 	int ret = 0;
@@ -2291,7 +2244,7 @@ int config_with_options(config_fn_t fn, void *data,
 		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
 					       data, config_source->scope);
 	} else {
-		ret = do_git_config_sequence(&the_reader, opts, fn, data);
+		ret = do_git_config_sequence(opts, fn, data);
 	}
 
 	if (inc.remote_urls) {
@@ -3000,7 +2953,6 @@ void git_die_config(const char *key, const char *err, ...)
  */
 
 struct config_store_data {
-	struct config_reader *config_reader;
 	size_t baselen;
 	char *key;
 	int do_not_match;
@@ -3046,11 +2998,10 @@ static int matches(const char *key, const char *value,
 		(value && !regexec(store->value_pattern, value, 0, NULL, 0));
 }
 
-static int store_aux_event(enum config_event_t type,
-			   size_t begin, size_t end, void *data)
+static int store_aux_event(enum config_event_t type, size_t begin, size_t end,
+			   struct config_source *cs, void *data)
 {
 	struct config_store_data *store = data;
-	struct config_source *cs = store->config_reader->source;
 
 	ALLOC_GROW(store->parsed, store->parsed_nr + 1, store->parsed_alloc);
 	store->parsed[store->parsed_nr].begin = begin;
@@ -3371,8 +3322,6 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	size_t contents_sz;
 	struct config_store_data store = CONFIG_STORE_INIT;
 
-	store.config_reader = &the_reader;
-
 	/* parse-key returns negative; flip the sign to feed exit(3) */
 	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
 	if (ret)
diff --git a/config.h b/config.h
index 8841b7a1cf6..f663cdd8e1b 100644
--- a/config.h
+++ b/config.h
@@ -73,6 +73,7 @@ enum config_event_t {
 	CONFIG_EVENT_ERROR
 };
 
+struct config_source;
 /*
  * The parser event function (if not NULL) is called with the event type and
  * the begin/end offsets of the parsed elements.
@@ -82,6 +83,7 @@ enum config_event_t {
  */
 typedef int (*config_parser_event_fn_t)(enum config_event_t type,
 					size_t begin_offset, size_t end_offset,
+					struct config_source *cs,
 					void *event_fn_data);
 
 struct config_options {
@@ -101,6 +103,10 @@ struct config_options {
 
 	const char *commondir;
 	const char *git_dir;
+	/*
+	 * event_fn and event_fn_data are for internal use only. Handles events
+	 * emitted by the config parser.
+	 */
 	config_parser_event_fn_t event_fn;
 	void *event_fn_data;
 	enum config_error_action {
-- 
gitgitgadget
