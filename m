Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE21C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 19:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjDUTNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 15:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjDUTN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 15:13:27 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B92B170C
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:25 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f178da21afso14740195e9.1
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682104403; x=1684696403;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3O2tWXYodpew9KhXFpPWf1Ko83c8a1VUAOnD03VJqY=;
        b=b+ofghSFVy67gxsDPPZIxQwSlZWLUY/nUk/O58jAkfhXrrI5XXvz4ylQW4PQ/Jx6uX
         JBbaz6pFoi1ln2MTn8/S1dDIgOcQPIIowJ84r5cJkp+7v4M4SgZLIn4oqqBqYMSVfy/Z
         W/MKyHQS/7RLp3XCSmWRJlnw9F4ossq4Hx6DHOTOOu0qI6uKmsJE8Nibo7pRYTZ//cJB
         AgZSrOjoaGNBokXFqkTICgza6S+xvrDGOCs2c1+/9z+zcIQ5ro+c3I349zlDrXAmcEs4
         LfVKeURGz7dO9m0aLratVkgzn6IthI4kuqQb4hApbqf7MEH+Atotuv4wez9iUMW/jowd
         qH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104403; x=1684696403;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3O2tWXYodpew9KhXFpPWf1Ko83c8a1VUAOnD03VJqY=;
        b=V6pVadVd+s8XSbaHX0zMYPr8pAVTy45Y2pXzRomYx9SX6Eeo7yrj3XVY7vJNlOpPDt
         COQ2w9CMLdNRd4iD+rbqX7R8Cl65eACbMRR61OEpWQhhm+OC8D3WAxQNa45g4MF/sQSq
         Ul81yrKR3D89Ihs26mgSx1v+TZKOX/CsEszLCsDZ6e2XxiTPatwtqgvaZegmoz4Drc03
         y+ShJV4eiqvRY03nT9YKVinvs07XmusWWS3GMmh3QvMEel9gTNOwmEgVBaNNFlbP3SHJ
         oAWEiernzyKJ3AuFbZ9y5hVEPNjz2hUxwGWYlnWZNkHOvcwwKSwghS/S1ZXcyzn8XyWN
         CiGA==
X-Gm-Message-State: AAQBX9fqI1M+RkiNehQOGNROek2XWUAzyODjqpSdGuc7TufQ97VWVS+6
        EESjPw6obDZOR4ni0g8vFN9YBZj7dJs=
X-Google-Smtp-Source: AKy350bPxYg0jR0lK0/BD8guaz/HNp/BW7Zctcd3vEK51ND+/2fbDXTBKNodUWFrkYl+mV7/MT0+nQ==
X-Received: by 2002:a05:600c:21a:b0:3f1:75b6:8c7 with SMTP id 26-20020a05600c021a00b003f175b608c7mr2625334wmi.37.1682104403312;
        Fri, 21 Apr 2023 12:13:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c310b00b003f0aefcc457sm8994864wmo.45.2023.04.21.12.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:13:23 -0700 (PDT)
Message-Id: <e80d1b5f4832edb9bd58b6024e3541a34e36f4e9.1682104398.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 19:13:09 +0000
Subject: [PATCH 05/14] config: pass source to config_parser_event_fn_t
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

This removes the last user of "config_reader.source", so remove it too.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 72 ++++++++++----------------------------------------------
 config.h |  6 +++++
 2 files changed, 18 insertions(+), 60 deletions(-)

diff --git a/config.c b/config.c
index b952a4b118d..147e422a27b 100644
--- a/config.c
+++ b/config.c
@@ -60,23 +60,6 @@ struct config_source {
 #define CONFIG_SOURCE_INIT { 0 }
 
 struct config_reader {
-	/*
-	 * These members record the "current" config source, which can be
-	 * accessed by parsing callbacks.
-	 *
-	 * The "source" variable will be non-NULL only when we are actually
-	 * parsing a real config source (file, blob, cmdline, etc).
-	 *
-	 * The "config_kvi" variable will be non-NULL only when we are feeding
-	 * cached config from a configset into a callback.
-	 *
-	 * They cannot be non-NULL at the same time. If they are both NULL, then
-	 * we aren't parsing anything (and depending on the function looking at
-	 * the variables, it's either a bug for it to be called in the first
-	 * place, or it's a function which can be reused for non-config
-	 * purposes, and should fall back to some sane behavior).
-	 */
-	struct config_source *source;
 	struct key_value_info *config_kvi;
 };
 /*
@@ -86,23 +69,6 @@ struct config_reader {
  */
 static struct config_reader the_reader;
 
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
 static inline void config_reader_push_kvi(struct config_reader *reader,
 					  struct key_value_info *kvi)
 {
@@ -1059,7 +1025,7 @@ static int do_event(struct config_source *cs, enum config_event_t type,
 
 	if (data->previous_type != CONFIG_EVENT_EOF &&
 	    data->opts->event_fn(data->previous_type, data->previous_offset,
-				 offset, data->opts->event_fn_data) < 0)
+				 offset, cs, data->opts->event_fn_data) < 0)
 		return -1;
 
 	data->previous_type = type;
@@ -2020,8 +1986,7 @@ int git_default_config(const char *var, const char *value, void *cb)
  * fgetc, ungetc, ftell of top need to be initialized before calling
  * this function.
  */
-static int do_config_from(struct config_reader *reader,
-			  struct config_source *top, config_fn_t fn,
+static int do_config_from(struct config_source *top, config_fn_t fn,
 			  void *data, enum config_scope scope,
 			  const struct config_options *opts)
 {
@@ -2034,21 +1999,17 @@ static int do_config_from(struct config_reader *reader,
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
@@ -2067,7 +2028,7 @@ static int do_config_from_file(struct config_reader *reader,
 	top.do_ftell = config_file_ftell;
 
 	flockfile(f);
-	ret = do_config_from(reader, &top, fn, data, scope, opts);
+	ret = do_config_from(&top, fn, data, scope, opts);
 	funlockfile(f);
 
 	return ret;
@@ -2076,8 +2037,8 @@ static int do_config_from_file(struct config_reader *reader,
 static int git_config_from_stdin(config_fn_t fn, void *data,
 				 enum config_scope scope)
 {
-	return do_config_from_file(&the_reader, fn, CONFIG_ORIGIN_STDIN, "",
-				   NULL, stdin, data, scope, NULL);
+	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin,
+				   data, scope, NULL);
 }
 
 int git_config_from_file_with_options(config_fn_t fn, const char *filename,
@@ -2091,9 +2052,8 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
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
@@ -2124,7 +2084,7 @@ int git_config_from_mem(config_fn_t fn,
 	top.do_ungetc = config_buf_ungetc;
 	top.do_ftell = config_buf_ftell;
 
-	return do_config_from(&the_reader, &top, fn, data, scope, opts);
+	return do_config_from(&top, fn, data, scope, opts);
 }
 
 int git_config_from_blob_oid(config_fn_t fn,
@@ -3019,7 +2979,6 @@ void git_die_config(const char *key, const char *err, ...)
  */
 
 struct config_store_data {
-	struct config_reader *config_reader;
 	size_t baselen;
 	char *key;
 	int do_not_match;
@@ -3065,11 +3024,10 @@ static int matches(const char *key, const char *value,
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
@@ -3389,8 +3347,6 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	size_t contents_sz;
 	struct config_store_data store = CONFIG_STORE_INIT;
 
-	store.config_reader = &the_reader;
-
 	/* parse-key returns negative; flip the sign to feed exit(3) */
 	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
 	if (ret)
@@ -3951,8 +3907,6 @@ static int reader_origin_type(struct config_reader *reader,
 {
 	if (the_reader.config_kvi)
 		*type = reader->config_kvi->origin_type;
-	else if(the_reader.source)
-		*type = reader->source->origin_type;
 	else
 		return 1;
 	return 0;
@@ -4005,8 +3959,6 @@ static int reader_config_name(struct config_reader *reader, const char **out)
 {
 	if (the_reader.config_kvi)
 		*out = reader->config_kvi->filename;
-	else if (the_reader.source)
-		*out = reader->source->name;
 	else
 		return 1;
 	return 0;
@@ -4039,7 +3991,7 @@ int current_config_line(void)
 	if (the_reader.config_kvi)
 		return the_reader.config_kvi->linenr;
 	else
-		return the_reader.source->linenr;
+		BUG("current_config_line called outside config callback");
 }
 
 int lookup_config(const char **mapping, int nr_mapping, const char *var)
diff --git a/config.h b/config.h
index f8bab9fdef4..525fc0d5e03 100644
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

