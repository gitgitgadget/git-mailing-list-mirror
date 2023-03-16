Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1250CC7618D
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 00:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjCPAMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 20:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjCPALy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 20:11:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D0432CE7
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 17:11:52 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso2086159wmq.1
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 17:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678925510;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Wf9k+cvBI87gxclxWwH5m1A5NDAiYtjdP+E6EFdRSk=;
        b=DLWBsxf3AIsWoksn7ZmjdqA1EqzzJsd7e8B8Co+s6a9PVwNEjzltsH4c2SX7j9cjra
         e6lwwEkL8CvOrU3TkVusCyeqFDa7Qylt9SBVMDcQpGqx6KtGdnlRPkBgFrsyuIXYTq8E
         VelPTPXSSglDBgBKoVmL1wNCZqGxgQg5yyWde6TkV47YI9ryp/U2/HoV3fC7eKqy/jjR
         AAKgFykqWcAg7DxS92qr86YlP2aVjiqGcru+XWpSxAW8rEdIN/aSneh6+0cggJ/HmV/K
         MWObfzbDbSWlSRXDyXM1B9O6uyJ0CEg7QxoAH+QoZT+blccItZQMIaRK5ltpDwX30gUl
         gEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678925510;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Wf9k+cvBI87gxclxWwH5m1A5NDAiYtjdP+E6EFdRSk=;
        b=aTwLs3wIxLu+lhqzAXYlDNQ388YdhDUFvj/ytzSDPk9twBBDUNZar8c/+Rbf9EGp/q
         yfddgqvaHScTx1am1lN9/dYoUJsNlaWL5WDDzBDV7RIYzqMITEBEqx9EocysIqn5RZHs
         1Lf0oYvgq+w4xCXUYJWoLKPBZl+kEn3gTmqp2FBMkAauBJ3bn2FRqXrkH2j+lYAQRsah
         7++Y7+ZalD8zsI1TdwBKsq3RdZF4crCQ7BNxhtB6VkokfAztBqGMLi8ckK57RGpcgsPY
         tuVZmlnIy/5J0AZRwvjlfbQ8Q6x9tbkZergxnvTlzkptxxtfavo8GvWALPvEo3SJ2kP0
         Pxyw==
X-Gm-Message-State: AO0yUKWEMA41E2+U2piNgttEAnREPh75JZa22E5OGT8L79O9zXOSn7kE
        lVtg+dXVNIqm3p/7nuFU17yKFB9l5Ac=
X-Google-Smtp-Source: AK7set8t/v9h0YqhoWenIAjovMUKio6hrsgMH12cJG8ymIPoEZMCsLXwLB5qQ9lkKPiuw8716s2PmQ==
X-Received: by 2002:a05:600c:5250:b0:3ed:4685:4618 with SMTP id fc16-20020a05600c525000b003ed46854618mr1093963wmb.34.1678925510464;
        Wed, 15 Mar 2023 17:11:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c1c0800b003ebf73acf9asm8639248wms.3.2023.03.15.17.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 17:11:50 -0700 (PDT)
Message-Id: <4347896f0a4896efe5b1410b72f5b583ad6bd9e0.1678925506.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
        <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Mar 2023 00:11:41 +0000
Subject: [PATCH v2 3/8] config.c: create config_reader and the_reader
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
 config.c | 84 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 32 deletions(-)

diff --git a/config.c b/config.c
index 517b8f64038..7de25515818 100644
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
@@ -80,20 +93,25 @@ static struct key_value_info *current_config_kvi;
  */
 static enum config_scope current_parsing_scope;
 
-static inline void config_reader_push_source(struct config_source *top)
+static inline void config_reader_push_source(struct config_reader *reader,
+					     struct config_source *top)
 {
-	if (cf_global)
-		top->prev = cf_global;
-	cf_global = top;
+	if (reader->source)
+		top->prev = reader->source;
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
+	/* FIXME remove this when cf is removed. */
+	cf_global = reader->source;
 	return ret;
 }
 
@@ -733,7 +751,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	struct config_source source = CONFIG_SOURCE_INIT;
 
 	source.origin_type = CONFIG_ORIGIN_CMDLINE;
-	config_reader_push_source(&source);
+	config_reader_push_source(&the_reader, &source);
 
 	env = getenv(CONFIG_COUNT_ENVIRONMENT);
 	if (env) {
@@ -791,7 +809,7 @@ out:
 	strbuf_release(&envvar);
 	strvec_clear(&to_free);
 	free(envw);
-	config_reader_pop_source();
+	config_reader_pop_source(&the_reader);
 	return ret;
 }
 
@@ -1326,7 +1344,7 @@ int git_config_int(const char *name, const char *value)
 {
 	int ret;
 	if (!git_parse_int(value, &ret))
-		die_bad_number(cf_global, name, value);
+		die_bad_number(the_reader.source, name, value);
 	return ret;
 }
 
@@ -1334,7 +1352,7 @@ int64_t git_config_int64(const char *name, const char *value)
 {
 	int64_t ret;
 	if (!git_parse_int64(value, &ret))
-		die_bad_number(cf_global, name, value);
+		die_bad_number(the_reader.source, name, value);
 	return ret;
 }
 
@@ -1342,7 +1360,7 @@ unsigned long git_config_ulong(const char *name, const char *value)
 {
 	unsigned long ret;
 	if (!git_parse_ulong(value, &ret))
-		die_bad_number(cf_global, name, value);
+		die_bad_number(the_reader.source, name, value);
 	return ret;
 }
 
@@ -1350,7 +1368,7 @@ ssize_t git_config_ssize_t(const char *name, const char *value)
 {
 	ssize_t ret;
 	if (!git_parse_ssize_t(value, &ret))
-		die_bad_number(cf_global, name, value);
+		die_bad_number(the_reader.source, name, value);
 	return ret;
 }
 
@@ -1956,7 +1974,8 @@ int git_default_config(const char *var, const char *value, void *cb)
  * fgetc, ungetc, ftell of top need to be initialized before calling
  * this function.
  */
-static int do_config_from(struct config_source *top, config_fn_t fn, void *data,
+static int do_config_from(struct config_reader *reader,
+			  struct config_source *top, config_fn_t fn, void *data,
 			  const struct config_options *opts)
 {
 	int ret;
@@ -1967,22 +1986,23 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data,
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
@@ -1997,15 +2017,15 @@ static int do_config_from_file(config_fn_t fn,
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
@@ -2019,8 +2039,8 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
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
@@ -2049,7 +2069,7 @@ int git_config_from_mem(config_fn_t fn,
 	top.do_ungetc = config_buf_ungetc;
 	top.do_ftell = config_buf_ftell;
 
-	return do_config_from(&top, fn, data, opts);
+	return do_config_from(&the_reader, &top, fn, data, opts);
 }
 
 int git_config_from_blob_oid(config_fn_t fn,
@@ -3798,8 +3818,8 @@ const char *current_config_origin_type(void)
 	int type;
 	if (current_config_kvi)
 		type = current_config_kvi->origin_type;
-	else if(cf_global)
-		type = cf_global->origin_type;
+	else if(the_reader.source)
+		type = the_reader.source->origin_type;
 	else
 		BUG("current_config_origin_type called outside config callback");
 
@@ -3844,8 +3864,8 @@ const char *current_config_name(void)
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
@@ -3864,7 +3884,7 @@ int current_config_line(void)
 	if (current_config_kvi)
 		return current_config_kvi->linenr;
 	else
-		return cf_global->linenr;
+		return the_reader.source->linenr;
 }
 
 int lookup_config(const char **mapping, int nr_mapping, const char *var)
-- 
gitgitgadget

