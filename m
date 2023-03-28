Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7857EC76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjC1RwJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjC1RwD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:52:03 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF6EF769
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:51:59 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so4657966wmq.3
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680025918;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7b8UBapYx7nFUzNPsKhT+rcEovOEPUyH/SNF0TD0xyA=;
        b=iFnh1RUN79aTuG0cqBQ0El9Ry8f1BFt5mBHk4FOlUZckbRs6u2xDeGqI7vkswohtIY
         CkraCb+V/EajH4Oz9XFZmwD2Iqwd7NbivlLjmINlLTwmozi1+1UkDpAobok7K3bB/W1W
         bRAdab49tB72efv3zStZrDUNRYj/PWSem/A2N0e/1F4HG/Nta5L4aaQD1cXBH/S6xFrX
         OWhUYPq2EINWPxVsav/uC0cWYnLkqdv9ZrZmC+/fMaYVpyRidU8o/gkBsxjbC1Zlw/s4
         Hg5tke68O6SmDrrGIKbeTzthLrhDbk2kYbxAIlNAiwdLYKD/39sJKA0iL/vQyla7lVNb
         Nz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025918;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7b8UBapYx7nFUzNPsKhT+rcEovOEPUyH/SNF0TD0xyA=;
        b=AZ/nTNU/WYhIQi6l8Br7xtymPCmTgMs4HRnWGvSw60QqDBfm22MyVHC5Ukn6QP2gG9
         8AI7nGk70ssEmIgxQtPpZvw37OJXdQXoTo+2TJXydy/+FZ+jeR1By1gs87PUIDEJ460j
         Fu/DDi7nXSk/Jx9tQQBN16mi+olS8zv76j5GNMsf/ObkyBcFmE+XisRWZFIi4HqxzC8W
         GbLj0rYHGRSKJLTUJpJ24FUADeK85MRTov2a0p6SBra9Kz9gp+YJd7D+4bz1X7Qv6SH/
         wHi1TGMYgIydLrACN5eg0s6cEpwDT3Nwkl82lyji7WSiWLSbs2pPRMGqvIk0BLY3M24g
         cYaA==
X-Gm-Message-State: AO0yUKW0d6hW5LksPrwh2rRIYlE+NEzY/bZf19FpR3MahecT2XrATw58
        RgAFVh7X+9uC3v7VCD5UUzBURw31INo=
X-Google-Smtp-Source: AK7set/+GeToeGu2wDcTGqy6qSjWDDSzsCHtAS4sEDP0AjI3k4rpLbrTJQUa7k4wZlbtpc6U8/s3Vw==
X-Received: by 2002:a7b:ce16:0:b0:3ed:9b20:c7c1 with SMTP id m22-20020a7bce16000000b003ed9b20c7c1mr11577696wmc.20.1680025917753;
        Tue, 28 Mar 2023 10:51:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m31-20020a05600c3b1f00b003ef5bb63f13sm13498360wms.10.2023.03.28.10.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:51:57 -0700 (PDT)
Message-Id: <72774fd08f3eb9ff1d449814637e584692ba2bfc.1680025914.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com>
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
        <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Mar 2023 17:51:49 +0000
Subject: [PATCH v3 3/8] config.c: create config_reader and the_reader
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

Create "struct config_reader" to hold the state of the config source
currently being read. Then, create a static instance of it,
"the_reader", and use "the_reader.source" to replace references to
"cf_global" in public functions.

This doesn't create much immediate benefit (since we're mostly replacing
static variables with a bigger static variable), but it prepares us for
a future where this state doesn't have to be global; "struct
config_reader" (or a similar struct) could be provided by the caller, or
constructed internally by a function like "do_config_from()".

A more typical approach would be to put this struct on "the_repository",
but that's a worse fit for this use case since config reading is not
scoped to a repository. E.g. we can read config before the repository is
known ("read_very_early_config()"), blatantly ignore the repo
("read_protected_config()"), or read only from a file
("git_config_from_file()"). This is especially evident in t5318 and
t9210, where test-tool and scalar parse config but don't fully
initialize "the_repository".

We could have also replaced the references to "cf_global" in callback
functions (which are the only ones left), but we'll eventually plumb
"the_reader" through the callback "*data" arg, so that would be
unnecessary churn. Until we remove "cf_global" altogether, add logic to
"config_reader_*_source()" to keep "cf_global" and "the_reader.source"
in sync.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 82 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/config.c b/config.c
index 6627fad71cf..3a28b397c4d 100644
--- a/config.c
+++ b/config.c
@@ -51,6 +51,16 @@ struct config_source {
 };
 #define CONFIG_SOURCE_INIT { 0 }
 
+struct config_reader {
+	struct config_source *source;
+};
+/*
+ * Where possible, prefer to accept "struct config_reader" as an arg than to use
+ * "the_reader". "the_reader" should only be used if that is infeasible, e.g. in
+ * a public function.
+ */
+static struct config_reader the_reader;
+
 /*
  * These variables record the "current" config source, which
  * can be accessed by parsing callbacks.
@@ -66,6 +76,9 @@ struct config_source {
  * at the variables, it's either a bug for it to be called in the first place,
  * or it's a function which can be reused for non-config purposes, and should
  * fall back to some sane behavior).
+ *
+ * FIXME "cf_global" has been replaced by "the_reader.source", remove
+ * "cf_global" once we plumb "the_reader" through all of the callback functions.
  */
 static struct config_source *cf_global;
 static struct key_value_info *current_config_kvi;
@@ -80,19 +93,24 @@ static struct key_value_info *current_config_kvi;
  */
 static enum config_scope current_parsing_scope;
 
-static inline void config_reader_push_source(struct config_source *top)
+static inline void config_reader_push_source(struct config_reader *reader,
+					     struct config_source *top)
 {
-	top->prev = cf_global;
-	cf_global = top;
+	top->prev = reader->source;
+	reader->source = top;
+	/* FIXME remove this when cf_global is removed. */
+	cf_global = reader->source;
 }
 
-static inline struct config_source *config_reader_pop_source()
+static inline struct config_source *config_reader_pop_source(struct config_reader *reader)
 {
 	struct config_source *ret;
-	if (!cf_global)
+	if (!reader->source)
 		BUG("tried to pop config source, but we weren't reading config");
-	ret = cf_global;
-	cf_global = cf_global->prev;
+	ret = reader->source;
+	reader->source = reader->source->prev;
+	/* FIXME remove this when cf_global is removed. */
+	cf_global = reader->source;
 	return ret;
 }
 
@@ -732,7 +750,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	struct config_source source = CONFIG_SOURCE_INIT;
 
 	source.origin_type = CONFIG_ORIGIN_CMDLINE;
-	config_reader_push_source(&source);
+	config_reader_push_source(&the_reader, &source);
 
 	env = getenv(CONFIG_COUNT_ENVIRONMENT);
 	if (env) {
@@ -790,7 +808,7 @@ out:
 	strbuf_release(&envvar);
 	strvec_clear(&to_free);
 	free(envw);
-	config_reader_pop_source();
+	config_reader_pop_source(&the_reader);
 	return ret;
 }
 
@@ -1325,7 +1343,7 @@ int git_config_int(const char *name, const char *value)
 {
 	int ret;
 	if (!git_parse_int(value, &ret))
-		die_bad_number(cf_global, name, value);
+		die_bad_number(the_reader.source, name, value);
 	return ret;
 }
 
@@ -1333,7 +1351,7 @@ int64_t git_config_int64(const char *name, const char *value)
 {
 	int64_t ret;
 	if (!git_parse_int64(value, &ret))
-		die_bad_number(cf_global, name, value);
+		die_bad_number(the_reader.source, name, value);
 	return ret;
 }
 
@@ -1341,7 +1359,7 @@ unsigned long git_config_ulong(const char *name, const char *value)
 {
 	unsigned long ret;
 	if (!git_parse_ulong(value, &ret))
-		die_bad_number(cf_global, name, value);
+		die_bad_number(the_reader.source, name, value);
 	return ret;
 }
 
@@ -1349,7 +1367,7 @@ ssize_t git_config_ssize_t(const char *name, const char *value)
 {
 	ssize_t ret;
 	if (!git_parse_ssize_t(value, &ret))
-		die_bad_number(cf_global, name, value);
+		die_bad_number(the_reader.source, name, value);
 	return ret;
 }
 
@@ -1955,7 +1973,8 @@ int git_default_config(const char *var, const char *value, void *cb)
  * fgetc, ungetc, ftell of top need to be initialized before calling
  * this function.
  */
-static int do_config_from(struct config_source *top, config_fn_t fn, void *data,
+static int do_config_from(struct config_reader *reader,
+			  struct config_source *top, config_fn_t fn, void *data,
 			  const struct config_options *opts)
 {
 	int ret;
@@ -1966,22 +1985,23 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data,
 	top->total_len = 0;
 	strbuf_init(&top->value, 1024);
 	strbuf_init(&top->var, 1024);
-	config_reader_push_source(top);
+	config_reader_push_source(reader, top);
 
 	ret = git_parse_source(top, fn, data, opts);
 
 	/* pop config-file parsing state stack */
 	strbuf_release(&top->value);
 	strbuf_release(&top->var);
-	config_reader_pop_source();
+	config_reader_pop_source(reader);
 
 	return ret;
 }
 
-static int do_config_from_file(config_fn_t fn,
-		const enum config_origin_type origin_type,
-		const char *name, const char *path, FILE *f,
-		void *data, const struct config_options *opts)
+static int do_config_from_file(struct config_reader *reader,
+			       config_fn_t fn,
+			       const enum config_origin_type origin_type,
+			       const char *name, const char *path, FILE *f,
+			       void *data, const struct config_options *opts)
 {
 	struct config_source top = CONFIG_SOURCE_INIT;
 	int ret;
@@ -1996,15 +2016,15 @@ static int do_config_from_file(config_fn_t fn,
 	top.do_ftell = config_file_ftell;
 
 	flockfile(f);
-	ret = do_config_from(&top, fn, data, opts);
+	ret = do_config_from(reader, &top, fn, data, opts);
 	funlockfile(f);
 	return ret;
 }
 
 static int git_config_from_stdin(config_fn_t fn, void *data)
 {
-	return do_config_from_file(fn, CONFIG_ORIGIN_STDIN, "", NULL, stdin,
-				   data, NULL);
+	return do_config_from_file(&the_reader, fn, CONFIG_ORIGIN_STDIN, "",
+				   NULL, stdin, data, NULL);
 }
 
 int git_config_from_file_with_options(config_fn_t fn, const char *filename,
@@ -2018,8 +2038,8 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
 		BUG("filename cannot be NULL");
 	f = fopen_or_warn(filename, "r");
 	if (f) {
-		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename,
-					  filename, f, data, opts);
+		ret = do_config_from_file(&the_reader, fn, CONFIG_ORIGIN_FILE,
+					  filename, filename, f, data, opts);
 		fclose(f);
 	}
 	return ret;
@@ -2048,7 +2068,7 @@ int git_config_from_mem(config_fn_t fn,
 	top.do_ungetc = config_buf_ungetc;
 	top.do_ftell = config_buf_ftell;
 
-	return do_config_from(&top, fn, data, opts);
+	return do_config_from(&the_reader, &top, fn, data, opts);
 }
 
 int git_config_from_blob_oid(config_fn_t fn,
@@ -3797,8 +3817,8 @@ const char *current_config_origin_type(void)
 	int type;
 	if (current_config_kvi)
 		type = current_config_kvi->origin_type;
-	else if(cf_global)
-		type = cf_global->origin_type;
+	else if(the_reader.source)
+		type = the_reader.source->origin_type;
 	else
 		BUG("current_config_origin_type called outside config callback");
 
@@ -3843,8 +3863,8 @@ const char *current_config_name(void)
 	const char *name;
 	if (current_config_kvi)
 		name = current_config_kvi->filename;
-	else if (cf_global)
-		name = cf_global->name;
+	else if (the_reader.source)
+		name = the_reader.source->name;
 	else
 		BUG("current_config_name called outside config callback");
 	return name ? name : "";
@@ -3863,7 +3883,7 @@ int current_config_line(void)
 	if (current_config_kvi)
 		return current_config_kvi->linenr;
 	else
-		return cf_global->linenr;
+		return the_reader.source->linenr;
 }
 
 int lookup_config(const char **mapping, int nr_mapping, const char *var)
-- 
gitgitgadget

