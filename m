Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B6BC64EC7
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 00:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCAAig (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 19:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCAAiY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 19:38:24 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6129EC16D
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 16:38:22 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t15so11576775wrz.7
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 16:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCc9lOosAd//zL4d2u6Z9Kr06d8OAAHP2k4PrxBPljQ=;
        b=MImYs5W8nL+PjKaVbKGjy2OZMq/5ur9azSTPjBPfJw+dzmSlqSexFHEVchIVol33aN
         eg5DKosH8fycjMEa5fpKfZeGNTdcjI5rXZhCIRHxoazCw/dJvSpvgNtvPAo5YM3+IFWS
         ARk/ejAi1p05M7eY/lGO0mD1S5t3y/1lmk0l39yx5YqnwWPlmly/AybSOIR5owbHmVQ1
         6yCMolLZRhbipTG/PFD1K57f6jMPD/cknmgNoMXUFdpQz9K7lG3uxgkXvFBeM4fKaqTQ
         +uU7JQ0PLFyTeIwgjOVARXaryQ+Mu9/wEtsC2LvV35ebaaQKH+GbqI/4yIRuxsmWWqaw
         0wwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCc9lOosAd//zL4d2u6Z9Kr06d8OAAHP2k4PrxBPljQ=;
        b=chm/7tf4BCic5zFQ63DCdmfNUHvj0dv0PZ7QctPrY9IkHWuRuXPd2pwPvhENZSKrTr
         byQ16rC6sc2o6wrnev1a4pnE8rFoyq51maxveaG59kk69UHun9imYsJMOmpLalIb68+m
         tR1ctCe0ZGw+5G2pfXOJZUmoH0D2XF5Lrwd2pjb2CmqkueUI9CAGlwvEj++rRwFCIJZ7
         e8PDZbDBHm5ehzSk/VP5LUakD8A2tsgzuUm6tMvjOW7wvRwXXZ6qtBsdjA5GcCxpt384
         1HP9N4UuQlOp9IbG9i317O4b9kn+4MJWdvPgvpu31QnKFDq1VbePI47KJfAfPSJi1KVZ
         IuUg==
X-Gm-Message-State: AO0yUKU5dOKqdqkxnoMwV6NnozcjK0xK+ETQoHWDrib0t7m2nmzEaXpj
        R+4GVqm0gh3iVgbOs5YJTGRw1Iyonjk=
X-Google-Smtp-Source: AK7set+TBxBrj7QhuP8RKCcjfMLEfXheRAJi2++FnpjO/+SmDPYam16Ij8JPoj9gnb2Ph8uDcYLQ0g==
X-Received: by 2002:a05:6000:104d:b0:2c5:899f:3412 with SMTP id c13-20020a056000104d00b002c5899f3412mr2845253wrx.26.1677631101156;
        Tue, 28 Feb 2023 16:38:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1-20020a056000018100b002c54fb024b2sm11214747wrx.61.2023.02.28.16.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 16:38:20 -0800 (PST)
Message-Id: <751ce3e927d392530038006a3f1e3a9538ce2127.1677631097.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Mar 2023 00:38:14 +0000
Subject: [PATCH 3/6] config.c: create config_reader and the_reader
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

Create "struct config_reader" to hold the state of the config source
currently being read. Then, create a static instance of it,
"the_reader", and use "the_reader.source" to replace references to "cf"
in public functions.

This doesn't create much immediate benefit (since we're mostly replacing
static variables with a bigger static variable), but it prepares us for
a future where this state doesn't have to be global; the "struct
config_reader" could be provided by the caller, or constructed
internally by a function like "do_config_from()".

A more typical approach would be to put this struct on "the_repository",
but that's a worse fit for this use case since config reading is not
scoped to a repository. E.g. we can read config before the repository is
known ("read_very_early_config()"), blatantly ignore the repo
("read_protected_config()"), or read only from a file
("git_config_from_file()"). This is especially evident in t5318 and
t9210, where test-tool and scalar parse config but don't fully
initialize "the_repository".

We could have also replaced the references to "cf" in callback functions
(which are the only ones left), but we'll eventually plumb "the_reader"
through the callback "*data" arg, which will allow us to rename "cf" to
"cs" without changing line lengths. Until we remove "cf" altogether,
add logic to "config_reader_*_source()" to keep "cf" and
"the_reader.source" in sync.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 80 +++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 32 deletions(-)

diff --git a/config.c b/config.c
index 1f89addc771..866cd54dd40 100644
--- a/config.c
+++ b/config.c
@@ -51,6 +51,12 @@ struct config_source {
 };
 #define CONFIG_SOURCE_INIT { 0 }
 
+struct config_reader {
+	struct config_source *source;
+};
+/* Only public functions should reference the_reader. */
+static struct config_reader the_reader;
+
 /*
  * These variables record the "current" config source, which
  * can be accessed by parsing callbacks.
@@ -66,6 +72,9 @@ struct config_source {
  * at the variables, it's either a bug for it to be called in the first place,
  * or it's a function which can be reused for non-config purposes, and should
  * fall back to some sane behavior).
+ *
+ * FIXME "cf" has been replaced by "the_reader.source", remove
+ * "cf" once we plumb "the_reader" through all of the callback functions.
  */
 static struct config_source *cf;
 static struct key_value_info *current_config_kvi;
@@ -79,20 +88,25 @@ static struct key_value_info *current_config_kvi;
  */
 static enum config_scope current_parsing_scope;
 
-static inline void config_state_push_source(struct config_source *top)
+static inline void config_reader_push_source(struct config_reader *reader,
+					     struct config_source *top)
 {
-	if (cf)
-		top->prev = cf;
-	cf = top;
+	if (reader->source)
+		top->prev = reader->source;
+	reader->source = top;
+	/* FIXME remove this when cf is removed. */
+	cf = reader->source;
 }
 
-static inline struct config_source *config_state_pop_source()
+static inline struct config_source *config_reader_pop_source(struct config_reader *reader)
 {
 	struct config_source *ret;
-	if (!cf)
+	if (!reader->source)
 		BUG("tried to pop config source, but we weren't reading config");
-	ret = cf;
-	cf = cf->prev;
+	ret = reader->source;
+	reader->source = reader->source->prev;
+	/* FIXME remove this when cf is removed. */
+	cf = reader->source;
 	return ret;
 }
 
@@ -732,7 +746,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	struct config_source source = CONFIG_SOURCE_INIT;
 
 	source.origin_type = CONFIG_ORIGIN_CMDLINE;
-	config_state_push_source(&source);
+	config_reader_push_source(&the_reader, &source);
 
 	env = getenv(CONFIG_COUNT_ENVIRONMENT);
 	if (env) {
@@ -790,7 +804,7 @@ out:
 	strbuf_release(&envvar);
 	strvec_clear(&to_free);
 	free(envw);
-	config_state_pop_source();
+	config_reader_pop_source(&the_reader);
 	return ret;
 }
 
@@ -1325,7 +1339,7 @@ int git_config_int(const char *name, const char *value)
 {
 	int ret;
 	if (!git_parse_int(value, &ret))
-		die_bad_number(cf, name, value);
+		die_bad_number(the_reader.source, name, value);
 	return ret;
 }
 
@@ -1333,7 +1347,7 @@ int64_t git_config_int64(const char *name, const char *value)
 {
 	int64_t ret;
 	if (!git_parse_int64(value, &ret))
-		die_bad_number(cf, name, value);
+		die_bad_number(the_reader.source, name, value);
 	return ret;
 }
 
@@ -1341,7 +1355,7 @@ unsigned long git_config_ulong(const char *name, const char *value)
 {
 	unsigned long ret;
 	if (!git_parse_ulong(value, &ret))
-		die_bad_number(cf, name, value);
+		die_bad_number(the_reader.source, name, value);
 	return ret;
 }
 
@@ -1349,7 +1363,7 @@ ssize_t git_config_ssize_t(const char *name, const char *value)
 {
 	ssize_t ret;
 	if (!git_parse_ssize_t(value, &ret))
-		die_bad_number(cf, name, value);
+		die_bad_number(the_reader.source, name, value);
 	return ret;
 }
 
@@ -1955,7 +1969,8 @@ int git_default_config(const char *var, const char *value, void *cb)
  * fgetc, ungetc, ftell of top need to be initialized before calling
  * this function.
  */
-static int do_config_from(struct config_source *top, config_fn_t fn, void *data,
+static int do_config_from(struct config_reader *reader,
+			  struct config_source *top, config_fn_t fn, void *data,
 			  const struct config_options *opts)
 {
 	int ret;
@@ -1966,22 +1981,23 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data,
 	top->total_len = 0;
 	strbuf_init(&top->value, 1024);
 	strbuf_init(&top->var, 1024);
-	config_state_push_source(top);
+	config_reader_push_source(reader, top);
 
 	ret = git_parse_source(top, fn, data, opts);
 
 	/* pop config-file parsing state stack */
 	strbuf_release(&top->value);
 	strbuf_release(&top->var);
-	config_state_pop_source();
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
@@ -1996,15 +2012,15 @@ static int do_config_from_file(config_fn_t fn,
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
@@ -2018,8 +2034,8 @@ int git_config_from_file_with_options(config_fn_t fn, const char *filename,
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
@@ -2048,7 +2064,7 @@ int git_config_from_mem(config_fn_t fn,
 	top.do_ungetc = config_buf_ungetc;
 	top.do_ftell = config_buf_ftell;
 
-	return do_config_from(&top, fn, data, opts);
+	return do_config_from(&the_reader, &top, fn, data, opts);
 }
 
 int git_config_from_blob_oid(config_fn_t fn,
@@ -3791,8 +3807,8 @@ const char *current_config_origin_type(void)
 	int type;
 	if (current_config_kvi)
 		type = current_config_kvi->origin_type;
-	else if(cf)
-		type = cf->origin_type;
+	else if(the_reader.source)
+		type = the_reader.source->origin_type;
 	else
 		BUG("current_config_origin_type called outside config callback");
 
@@ -3837,8 +3853,8 @@ const char *current_config_name(void)
 	const char *name;
 	if (current_config_kvi)
 		name = current_config_kvi->filename;
-	else if (cf)
-		name = cf->name;
+	else if (the_reader.source)
+		name = the_reader.source->name;
 	else
 		BUG("current_config_name called outside config callback");
 	return name ? name : "";
@@ -3857,7 +3873,7 @@ int current_config_line(void)
 	if (current_config_kvi)
 		return current_config_kvi->linenr;
 	else
-		return cf->linenr;
+		return the_reader.source->linenr;
 }
 
 int lookup_config(const char **mapping, int nr_mapping, const char *var)
-- 
gitgitgadget

