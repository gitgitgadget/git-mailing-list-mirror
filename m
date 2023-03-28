Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074BDC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjC1RwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjC1RwB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:52:01 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26C1EFA9
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:51:58 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u1so7446000wmn.5
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680025917;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfZyqL+bjTJTCrDN0yrFiy4O7WVyGVVkkFgKLOmClzI=;
        b=aHxsEiJEQiclzBLw7R2eYGWnbzRSH9v+5pEMY9Ld9tJVE7zro8U+f+UwWNccd1UoM7
         fDWm/9Kh+gxiTk+bkNpKYwnBGGFXhQ3CN5+PasXb1wwIFVPd/6TWF2h3Td0XXbZTa6yT
         +f+bvCu1qMw/cfHHaF2XIl7/T2kn2Gb/YfRpLJdJO6zAmgVaOUHha3CUTlQ9Sdi2Asg5
         jOPDH10K7G7HyOyGJmQLF4AywbnmQ0BEiwvN897XZdPRgaaI6xnMlanaBKG4n3y3tDf6
         wbrR9BavLLerGvO51hsknSmeqB3YpNi13QIQhSTPCGnjy+2sLWTTQ/00w4Y6v7AIoYYt
         6rJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025917;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfZyqL+bjTJTCrDN0yrFiy4O7WVyGVVkkFgKLOmClzI=;
        b=Q3VCaEzkpwND6jRqkOX5v4OeLnEJggDVrXQySlUKWOVkxmr2w+OavnGizpeWKn0776
         Z9Mpyi4mbZTuArltbQlG0Xx+t7osU1ziyS6Jxq5u50Xy0BUn646IwE6qWNjvOkiN5FMw
         PRaDIiSzzRq6IKh9TWkJaf6GbyPDpwaf7JxCsw3F8esqsdvETwhRiLR52PFyam+cN/yq
         CrF8rIN0WASb0MQXWv7sCcqKwbVxG78LKDBZReTDht4fQlxTILZN87jQ0oQG+jHMHoxh
         kNDGt4eBCyj+KYA2p3t5zP2+Bv1Z+luRx1Yz/nPSXHpvnruK2KMdTf6C9nfsv5KaQx6v
         DIRQ==
X-Gm-Message-State: AO0yUKX2k7RCqbADDgZHlyqNkTaBzD1sbNQ7faXM/x85VXmN32IZrhXA
        +Pam97ZAMyy8ccKVAS0L60kU2QQEFRg=
X-Google-Smtp-Source: AK7set89sC1E5U0pal3UkUYQZCurF0mvV67VpHeDtrLscB72YdL6NQuupICylUF2btrb7ldqfL2YnA==
X-Received: by 2002:a7b:cd85:0:b0:3ee:96f0:ea3c with SMTP id y5-20020a7bcd85000000b003ee96f0ea3cmr12885387wmj.7.1680025917039;
        Tue, 28 Mar 2023 10:51:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c314700b003ef66c89af0sm4423463wmo.0.2023.03.28.10.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:51:56 -0700 (PDT)
Message-Id: <39db7d8596ad6498d8fe6fe976ab85a5959e9949.1680025914.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com>
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
        <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Mar 2023 17:51:48 +0000
Subject: [PATCH v3 2/8] config.c: don't assign to "cf_global" directly
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

To make "cf_global" easier to remove, replace all direct assignments to
it with function calls. This refactor has an additional maintainability
benefit: all of these functions were manually implementing stack
pop/push semantics on "struct config_source", so replacing them with
function calls allows us to only implement this logic once.

In this process, perform some now-obvious clean ups:

- Drop some unnecessary "cf_global" assignments in
  populate_remote_urls(). Since it was introduced in 399b198489 (config:
  include file if remote URL matches a glob, 2022-01-18), it has stored
  and restored the value of "cf_global" to ensure that it doesn't get
  accidentally mutated. However, this was never necessary since
  "do_config_from()" already pushes/pops "cf_global" further down the
  call chain.

- Zero out every "struct config_source" with a dedicated initializer.
  This matters because the "struct config_source" is assigned to
  "cf_global" and we later 'pop the stack' by assigning "cf_global =
  cf_global->prev", but "cf_global->prev" could be pointing to
  uninitialized garbage.

  Fortunately, this has never bothered us since we never try to read
  "cf_global" except while iterating through config, in which case,
  "cf_global" is either set to a sensible value (when parsing a file),
  or it is ignored (when iterating a configset). Later in the series,
  zero-ing out memory will also let us enforce the constraint that
  "cf_global" and "current_config_kvi" are never non-NULL together.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/config.c b/config.c
index e4a76739365..6627fad71cf 100644
--- a/config.c
+++ b/config.c
@@ -49,6 +49,7 @@ struct config_source {
 	int (*do_ungetc)(int c, struct config_source *conf);
 	long (*do_ftell)(struct config_source *c);
 };
+#define CONFIG_SOURCE_INIT { 0 }
 
 /*
  * These variables record the "current" config source, which
@@ -79,6 +80,22 @@ static struct key_value_info *current_config_kvi;
  */
 static enum config_scope current_parsing_scope;
 
+static inline void config_reader_push_source(struct config_source *top)
+{
+	top->prev = cf_global;
+	cf_global = top;
+}
+
+static inline struct config_source *config_reader_pop_source()
+{
+	struct config_source *ret;
+	if (!cf_global)
+		BUG("tried to pop config source, but we weren't reading config");
+	ret = cf_global;
+	cf_global = cf_global->prev;
+	return ret;
+}
+
 static int pack_compression_seen;
 static int zlib_compression_seen;
 
@@ -346,14 +363,12 @@ static void populate_remote_urls(struct config_include_data *inc)
 {
 	struct config_options opts;
 
-	struct config_source *store_cf = cf_global;
 	struct key_value_info *store_kvi = current_config_kvi;
 	enum config_scope store_scope = current_parsing_scope;
 
 	opts = *inc->opts;
 	opts.unconditional_remote_url = 1;
 
-	cf_global = NULL;
 	current_config_kvi = NULL;
 	current_parsing_scope = 0;
 
@@ -361,7 +376,6 @@ static void populate_remote_urls(struct config_include_data *inc)
 	string_list_init_dup(inc->remote_urls);
 	config_with_options(add_remote_url, inc->remote_urls, inc->config_source, &opts);
 
-	cf_global = store_cf;
 	current_config_kvi = store_kvi;
 	current_parsing_scope = store_scope;
 }
@@ -715,12 +729,10 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	struct strvec to_free = STRVEC_INIT;
 	int ret = 0;
 	char *envw = NULL;
-	struct config_source source;
+	struct config_source source = CONFIG_SOURCE_INIT;
 
-	memset(&source, 0, sizeof(source));
-	source.prev = cf_global;
 	source.origin_type = CONFIG_ORIGIN_CMDLINE;
-	cf_global = &source;
+	config_reader_push_source(&source);
 
 	env = getenv(CONFIG_COUNT_ENVIRONMENT);
 	if (env) {
@@ -778,7 +790,7 @@ out:
 	strbuf_release(&envvar);
 	strvec_clear(&to_free);
 	free(envw);
-	cf_global = source.prev;
+	config_reader_pop_source();
 	return ret;
 }
 
@@ -1949,20 +1961,19 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data,
 	int ret;
 
 	/* push config-file parsing state stack */
-	top->prev = cf_global;
 	top->linenr = 1;
 	top->eof = 0;
 	top->total_len = 0;
 	strbuf_init(&top->value, 1024);
 	strbuf_init(&top->var, 1024);
-	cf_global = top;
+	config_reader_push_source(top);
 
 	ret = git_parse_source(top, fn, data, opts);
 
 	/* pop config-file parsing state stack */
 	strbuf_release(&top->value);
 	strbuf_release(&top->var);
-	cf_global = top->prev;
+	config_reader_pop_source();
 
 	return ret;
 }
@@ -1972,7 +1983,7 @@ static int do_config_from_file(config_fn_t fn,
 		const char *name, const char *path, FILE *f,
 		void *data, const struct config_options *opts)
 {
-	struct config_source top;
+	struct config_source top = CONFIG_SOURCE_INIT;
 	int ret;
 
 	top.u.file = f;
@@ -2024,7 +2035,7 @@ int git_config_from_mem(config_fn_t fn,
 			const char *name, const char *buf, size_t len,
 			void *data, const struct config_options *opts)
 {
-	struct config_source top;
+	struct config_source top = CONFIG_SOURCE_INIT;
 
 	top.u.buf.buf = buf;
 	top.u.buf.len = len;
-- 
gitgitgadget

