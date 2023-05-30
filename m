Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7A0C7EE24
	for <git@archiver.kernel.org>; Tue, 30 May 2023 18:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjE3SnP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 14:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjE3Smz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 14:42:55 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79280106
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3078a3f3b5fso4801525f8f.0
        for <git@vger.kernel.org>; Tue, 30 May 2023 11:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685472147; x=1688064147;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niAwLlpaWFr8zmWjPi4PR7Dwkq6Hcs4tAKtgAT3oi5g=;
        b=E53fDMAk/TX9wznWti1t/IFpaWGgAzrtew/+iQVMptBwoAMcfkyDDpVA1DEkSXSRB9
         9IyiKuNYmh+M+i4hUjh0TLUtv5v9W8a+ea4tlHn/PzRDMn5k+jPnATnXtEjGTE1WxvZv
         00GwcIDmqXk2nXIwBitWzzpWnywCwtwbs0SurJOJjHu/p9fwYayEdhAbQd1rx8ZqINo3
         mPAoxDUM9Ga9UY3hHXp0MNMdgUYTmv6hBnqybYQXqRAjXWxq+THuwSEywFCc0hVixSR1
         K4YeVrRiKwO4//dnJdxATGa4d2ywjLJEfGEK+yPn09msfchitkyBkJcV+0Sgy9f+s8en
         GXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685472147; x=1688064147;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niAwLlpaWFr8zmWjPi4PR7Dwkq6Hcs4tAKtgAT3oi5g=;
        b=MhCPO+6zCeR1R3Vv1jIjKTC/QTrKEDTwqah7bRIAjjov1k9pl+oj1w7XjlbiH9bYeU
         //FlKAGztt3KdrsMmU7A9XfSZ4aqibjZXmJW4K3o9N889RkjWn6ydA7hYElR4HGStleC
         r1mpvxM666Ni8v4zEKdlUdNIYWRpvepV16+nPPLkXjhiycXged8Vstt63s63/dY+rTmQ
         gMy00GwTvJKVp/ThuLFHxJRk0V3GcOhAgM6dGvXgQNyZrJCz109yrX95zgobNFcDjkUh
         U3ON77Y4a0IvuTjXs/1o+83OLA6as9A9WY7OX5rBls5xhn8twlRISeoV0ZaMtYWbxB9c
         PpBg==
X-Gm-Message-State: AC+VfDwd+dNOWWI23Ou1r0m75tbX2niP/gBoK4kgtmN31WHEWm8EuHDd
        TKSc+o3+Ulf7kCeodGTI3CNAY4blvf8=
X-Google-Smtp-Source: ACHHUZ5gxjphTw9guJYxyDHI/18CHswVfsRMntGVWahiPkNkW26rBb5X2bxv2p54mjuGAondT86eJA==
X-Received: by 2002:adf:cf10:0:b0:2f9:8e93:d376 with SMTP id o16-20020adfcf10000000b002f98e93d376mr2358367wrj.56.1685472147356;
        Tue, 30 May 2023 11:42:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10-20020adfee8a000000b0030aefd11892sm4036518wro.41.2023.05.30.11.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 11:42:26 -0700 (PDT)
Message-Id: <9e35b5b1f4dbdeafca5be7516477dc033b7643a6.1685472134.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
        <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 May 2023 18:42:12 +0000
Subject: [PATCH v2 14/14] config: pass source to config_parser_event_fn_t
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

..so that the callback can use a "struct config_source" parameter
instead of "config_reader.source". "struct config_source" is internal to
config.c, but this refactor is okay because this function has only ever
been (and probably ever will be) used internally by config.c.

As a result, the_reader isn't used anywhere, so "struct config_reader"
is obsolete (it was only intended to be used with the_reader). Remove
them.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 77 ++++++++++----------------------------------------------
 config.h |  6 +++++
 2 files changed, 19 insertions(+), 64 deletions(-)

diff --git a/config.c b/config.c
index 09950b46127..c8d941ca627 100644
--- a/config.c
+++ b/config.c
@@ -59,40 +59,6 @@ struct config_source {
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
 
@@ -738,14 +704,9 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	struct strvec to_free = STRVEC_INIT;
 	int ret = 0;
 	char *envw = NULL;
-	struct config_source source = CONFIG_SOURCE_INIT;
 	struct key_value_info kvi = { 0 };
 
-	source.origin_type = CONFIG_ORIGIN_CMDLINE;
-	config_reader_push_source(&the_reader, &source);
-
 	kvi_from_param(&kvi);
-
 	env = getenv(CONFIG_COUNT_ENVIRONMENT);
 	if (env) {
 		unsigned long count;
@@ -802,7 +763,6 @@ out:
 	strbuf_release(&envvar);
 	strvec_clear(&to_free);
 	free(envw);
-	config_reader_pop_source(&the_reader);
 	return ret;
 }
 
@@ -1028,7 +988,7 @@ static int do_event(struct config_source *cs, enum config_event_t type,
 
 	if (data->previous_type != CONFIG_EVENT_EOF &&
 	    data->opts->event_fn(data->previous_type, data->previous_offset,
-				 offset, data->opts->event_fn_data) < 0)
+				 offset, cs, data->opts->event_fn_data) < 0)
 		return -1;
 
 	data->previous_type = type;
@@ -1986,8 +1946,7 @@ int git_default_config(const char *var, const char *value,
  * fgetc, ungetc, ftell of top need to be initialized before calling
  * this function.
  */
-static int do_config_from(struct config_reader *reader,
-			  struct config_source *top, config_fn_t fn,
+static int do_config_from(struct config_source *top, config_fn_t fn,
 			  void *data, enum config_scope scope,
 			  const struct config_options *opts)
 {
@@ -2000,21 +1959,17 @@ static int do_config_from(struct config_reader *reader,
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
@@ -2033,7 +1988,7 @@ static int do_config_from_file(struct config_reader *reader,
 	top.do_ftell = config_file_ftell;
 
 	flockfile(f);
-	ret = do_config_from(reader, &top, fn, data, scope, opts);
+	ret = do_config_from(&top, fn, data, scope, opts);
 	funlockfile(f);
 	return ret;
 }
@@ -2041,8 +1996,8 @@ static int do_config_from_file(struct config_reader *reader,
 static int git_config_from_stdin(config_fn_t fn, void *data,
 				 enum config_scope scope)
 {
-	return do_config_from_file(&the_reader, fn, CONFIG_ORIGIN_STDIN, "",
-				   NULL, stdin, data, scope, NULL);
+	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin,
+				   data, scope, NULL);
 }
 
 int git_config_from_file_with_options(config_fn_t fn, const char *filename,
@@ -2056,9 +2011,8 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
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
@@ -2089,7 +2043,7 @@ int git_config_from_mem(config_fn_t fn,
 	top.do_ungetc = config_buf_ungetc;
 	top.do_ftell = config_buf_ftell;
 
-	return do_config_from(&the_reader, &top, fn, data, scope, opts);
+	return do_config_from(&top, fn, data, scope, opts);
 }
 
 int git_config_from_blob_oid(config_fn_t fn,
@@ -2182,8 +2136,7 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
 
-static int do_git_config_sequence(struct config_reader *reader,
-				  const struct config_options *opts,
+static int do_git_config_sequence(const struct config_options *opts,
 				  config_fn_t fn, void *data)
 {
 	int ret = 0;
@@ -2272,7 +2225,7 @@ int config_with_options(config_fn_t fn, void *data,
 		ret = git_config_from_blob_ref(fn, repo, config_source->blob,
 					       data, config_source->scope);
 	} else {
-		ret = do_git_config_sequence(&the_reader, opts, fn, data);
+		ret = do_git_config_sequence(opts, fn, data);
 	}
 
 	if (inc.remote_urls) {
@@ -2978,7 +2931,6 @@ void git_die_config(const char *key, const char *err, ...)
  */
 
 struct config_store_data {
-	struct config_reader *config_reader;
 	size_t baselen;
 	char *key;
 	int do_not_match;
@@ -3024,11 +2976,10 @@ static int matches(const char *key, const char *value,
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
@@ -3349,8 +3300,6 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	size_t contents_sz;
 	struct config_store_data store = CONFIG_STORE_INIT;
 
-	store.config_reader = &the_reader;
-
 	/* parse-key returns negative; flip the sign to feed exit(3) */
 	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
 	if (ret)
diff --git a/config.h b/config.h
index 123917d1b0a..eaf24aba25d 100644
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
