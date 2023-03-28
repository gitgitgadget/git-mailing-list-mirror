Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72798C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjC1Rw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjC1RwF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:52:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB08EF86
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:52:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r11so13079772wrr.12
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680025921;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmj7G5fGY0hImw6A9/VhQbthQ0wp76okCqdydvvftEE=;
        b=ob1SiLm4u8cQDM020XKzUfwC4WL4vujgJLnewZt30lg+54YQhi1SV0HQDJ+GpzG8OJ
         5fjrl7kA1ri5YizS38hjWq5QeqlDQ4w9h/b5L4IDjnRiI8IxIKayHRqszmmAaXqj+oPa
         i5gm0hAyZ/97pu7vbWil+OZ1B6YM09KLc7Ydwkb4oNKtThYu/G+ZOlV/OMW8F5eiYsL+
         Xl98Ut8hIochVoyUT3lWHqAxQYl8KaBpaeKrIB2pcXaqJvmxTBhE8DKrMEq2ssxaR8X/
         WtA1FiqgMt+MoEfWARo91eopINUZZ5AUqKb7mQOSS918OUpRdZmLYUsyMVmv0DKQigI5
         Lg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025921;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmj7G5fGY0hImw6A9/VhQbthQ0wp76okCqdydvvftEE=;
        b=pSc06tGu20jmA1h5qAvIsyNgwu5wlfOJH1HPnI8zxvWQ1BGku/QZMb0Hrw2AdUv+ZZ
         +gnsPC0nOrUAEQwRKjhNw8OjMfZXepLY4/gXeFWMKJbivOkHjIzZdVni9/okF2zqhnuK
         ilyhlQBcwwGBkgF7Ueija/ANuuVh2vJbqw7yy8VcbjPaAT+huPLhg7YKDunOXTJGmy3o
         SZLGdqOciiZ+K8krQ3yTWC7SHCQLN6VwA2wxYkSN2PZQgvluNns3mrVeu+5ZznJmZ+m/
         GRceDSzNX5ZSp5t4h7/0ME9qdNIr7H0+TtMNPteMOLX+c0wsbdVPhvmEoxm/hTkuFB/2
         d03w==
X-Gm-Message-State: AAQBX9evMoJQKPLHMI39/xFfcnGsIFEZmDe4NjNb0P5+E37pv8DpK+Oo
        y/VzIZ3+5wntl/u5+/27ybtNo7Ep89M=
X-Google-Smtp-Source: AKy350bhIQL3EZX9L530jAs+Tu61/BU0vyFnbaUEig2mmZD+2UhbQfRhzhTKU+whjqlqQC3GlLV0gQ==
X-Received: by 2002:a5d:6344:0:b0:2d3:f610:8410 with SMTP id b4-20020a5d6344000000b002d3f6108410mr12043432wrw.0.1680025920685;
        Tue, 28 Mar 2023 10:52:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8-20020adfdb88000000b002cff06039d7sm28088126wri.39.2023.03.28.10.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:52:00 -0700 (PDT)
Message-Id: <eb843e6f08dcc143b71378750cca5efe553a377d.1680025914.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com>
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
        <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Mar 2023 17:51:53 +0000
Subject: [PATCH v3 7/8] config: report cached filenames in die_bad_number()
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

If, when parsing numbers from config, die_bad_number() is called, it
reports the filename and config source type if we were parsing a config
file, but not if we were iterating a config_set (it defaults to a less
specific error message). Most call sites don't parse config files
because config is typically read once and cached, so we only report
filename and config source type in "git config --type" (since "git
config" always parses config files).

This could have been fixed when we taught the current_config_*
functions to respect config_set values (0d44a2dacc (config: return
configset value for current_config_ functions, 2016-05-26), but it was
hard to spot then and we might have just missed it (I didn't find
mention of die_bad_number() in the original ML discussion [1].)

Fix this by refactoring the current_config_* functions into variants
that don't BUG() when we aren't reading config, and using the resulting
functions in die_bad_number(). "git config --get[-regexp] --type=int"
cannot use the non-refactored version because it parses the int value
_after_ parsing the config file, which would run into the BUG().

Since the refactored functions aren't public, they use "struct
config_reader".

1. https://lore.kernel.org/git/20160518223712.GA18317@sigill.intra.peff.net/

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c               | 65 +++++++++++++++++++++++++++++-------------
 config.h               |  1 +
 t/helper/test-config.c | 17 +++++++++++
 t/t1308-config-set.sh  |  9 ++++++
 4 files changed, 72 insertions(+), 20 deletions(-)

diff --git a/config.c b/config.c
index 3756322ec96..46c5a9a7d51 100644
--- a/config.c
+++ b/config.c
@@ -1311,39 +1311,48 @@ int git_parse_ssize_t(const char *value, ssize_t *ret)
 	return 1;
 }
 
+static int reader_config_name(struct config_reader *reader, const char **out);
+static int reader_origin_type(struct config_reader *reader,
+			      enum config_origin_type *type);
 NORETURN
-static void die_bad_number(struct config_source *cf, const char *name,
+static void die_bad_number(struct config_reader *reader, const char *name,
 			   const char *value)
 {
 	const char *error_type = (errno == ERANGE) ?
 		N_("out of range") : N_("invalid unit");
 	const char *bad_numeric = N_("bad numeric config value '%s' for '%s': %s");
+	const char *config_name = NULL;
+	enum config_origin_type config_origin = CONFIG_ORIGIN_UNKNOWN;
 
 	if (!value)
 		value = "";
 
-	if (!(cf && cf->name))
+	/* Ignoring the return value is okay since we handle missing values. */
+	reader_config_name(reader, &config_name);
+	reader_origin_type(reader, &config_origin);
+
+	if (!config_name)
 		die(_(bad_numeric), value, name, _(error_type));
 
-	switch (cf->origin_type) {
+	switch (config_origin) {
 	case CONFIG_ORIGIN_BLOB:
 		die(_("bad numeric config value '%s' for '%s' in blob %s: %s"),
-		    value, name, cf->name, _(error_type));
+		    value, name, config_name, _(error_type));
 	case CONFIG_ORIGIN_FILE:
 		die(_("bad numeric config value '%s' for '%s' in file %s: %s"),
-		    value, name, cf->name, _(error_type));
+		    value, name, config_name, _(error_type));
 	case CONFIG_ORIGIN_STDIN:
 		die(_("bad numeric config value '%s' for '%s' in standard input: %s"),
 		    value, name, _(error_type));
 	case CONFIG_ORIGIN_SUBMODULE_BLOB:
 		die(_("bad numeric config value '%s' for '%s' in submodule-blob %s: %s"),
-		    value, name, cf->name, _(error_type));
+		    value, name, config_name, _(error_type));
 	case CONFIG_ORIGIN_CMDLINE:
 		die(_("bad numeric config value '%s' for '%s' in command line %s: %s"),
-		    value, name, cf->name, _(error_type));
+		    value, name, config_name, _(error_type));
 	default:
 		die(_("bad numeric config value '%s' for '%s' in %s: %s"),
-		    value, name, cf->name, _(error_type));
+		    value, name, config_name, _(error_type));
 	}
 }
 
@@ -1351,7 +1360,7 @@ int git_config_int(const char *name, const char *value)
 {
 	int ret;
 	if (!git_parse_int(value, &ret))
-		die_bad_number(the_reader.source, name, value);
+		die_bad_number(&the_reader, name, value);
 	return ret;
 }
 
@@ -1359,7 +1368,7 @@ int64_t git_config_int64(const char *name, const char *value)
 {
 	int64_t ret;
 	if (!git_parse_int64(value, &ret))
-		die_bad_number(the_reader.source, name, value);
+		die_bad_number(&the_reader, name, value);
 	return ret;
 }
 
@@ -1367,7 +1376,7 @@ unsigned long git_config_ulong(const char *name, const char *value)
 {
 	unsigned long ret;
 	if (!git_parse_ulong(value, &ret))
-		die_bad_number(the_reader.source, name, value);
+		die_bad_number(&the_reader, name, value);
 	return ret;
 }
 
@@ -1375,7 +1384,7 @@ ssize_t git_config_ssize_t(const char *name, const char *value)
 {
 	ssize_t ret;
 	if (!git_parse_ssize_t(value, &ret))
-		die_bad_number(the_reader.source, name, value);
+		die_bad_number(&the_reader, name, value);
 	return ret;
 }
 
@@ -3839,14 +3848,23 @@ int parse_config_key(const char *var,
 	return 0;
 }
 
-const char *current_config_origin_type(void)
+static int reader_origin_type(struct config_reader *reader,
+			      enum config_origin_type *type)
 {
-	int type;
 	if (the_reader.config_kvi)
-		type = the_reader.config_kvi->origin_type;
+		*type = reader->config_kvi->origin_type;
 	else if(the_reader.source)
-		type = the_reader.source->origin_type;
+		*type = reader->source->origin_type;
 	else
+		return 1;
+	return 0;
+}
+
+const char *current_config_origin_type(void)
+{
+	enum config_origin_type type = CONFIG_ORIGIN_UNKNOWN;
+
+	if (reader_origin_type(&the_reader, &type))
 		BUG("current_config_origin_type called outside config callback");
 
 	switch (type) {
@@ -3885,14 +3903,21 @@ const char *config_scope_name(enum config_scope scope)
 	}
 }
 
-const char *current_config_name(void)
+static int reader_config_name(struct config_reader *reader, const char **out)
 {
-	const char *name;
 	if (the_reader.config_kvi)
-		name = the_reader.config_kvi->filename;
+		*out = reader->config_kvi->filename;
 	else if (the_reader.source)
-		name = the_reader.source->name;
+		*out = reader->source->name;
 	else
+		return 1;
+	return 0;
+}
+
+const char *current_config_name(void)
+{
+	const char *name;
+	if (reader_config_name(&the_reader, &name))
 		BUG("current_config_name called outside config callback");
 	return name ? name : "";
 }
diff --git a/config.h b/config.h
index 7606246531a..66c8b996e15 100644
--- a/config.h
+++ b/config.h
@@ -56,6 +56,7 @@ struct git_config_source {
 };
 
 enum config_origin_type {
+	CONFIG_ORIGIN_UNKNOWN = 0,
 	CONFIG_ORIGIN_BLOB,
 	CONFIG_ORIGIN_FILE,
 	CONFIG_ORIGIN_STDIN,
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 4ba9eb65606..26e79168f6a 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -30,6 +30,9 @@
  * iterate -> iterate over all values using git_config(), and print some
  *            data for each
  *
+ * git_config_int -> iterate over all values using git_config() and print the
+ *                   integer value for the entered key or die
+ *
  * Examples:
  *
  * To print the value with highest priority for key "foo.bAr Baz.rock":
@@ -54,6 +57,17 @@ static int iterate_cb(const char *var, const char *value, void *data UNUSED)
 	return 0;
 }
 
+static int parse_int_cb(const char *var, const char *value, void *data)
+{
+	const char *key_to_match = data;
+
+	if (!strcmp(key_to_match, var)) {
+		int parsed = git_config_int(value, value);
+		printf("%d\n", parsed);
+	}
+	return 0;
+}
+
 static int early_config_cb(const char *var, const char *value, void *vdata)
 {
 	const char *key = vdata;
@@ -176,6 +190,9 @@ int cmd__config(int argc, const char **argv)
 	} else if (!strcmp(argv[1], "iterate")) {
 		git_config(iterate_cb, NULL);
 		goto exit0;
+	} else if (argc == 3 && !strcmp(argv[1], "git_config_int")) {
+		git_config(parse_int_cb, (void *) argv[2]);
+		goto exit0;
 	}
 
 	die("%s: Please check the syntax and the function name", argv[0]);
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index b38e158d3b2..9733bed30a9 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -120,6 +120,10 @@ test_expect_success 'find integer value for a key' '
 	check_config get_int lamb.chop 65
 '
 
+test_expect_success 'parse integer value during iteration' '
+	check_config git_config_int lamb.chop 65
+'
+
 test_expect_success 'find string value for a key' '
 	check_config get_string case.baz hask &&
 	check_config expect_code 1 get_string case.ba "Value not found for \"case.ba\""
@@ -134,6 +138,11 @@ test_expect_success 'find integer if value is non parse-able' '
 	check_config expect_code 128 get_int lamb.head
 '
 
+test_expect_success 'non parse-able integer value during iteration' '
+	check_config expect_code 128 git_config_int lamb.head 2>result &&
+	grep "fatal: bad numeric config value .* in file \.git/config" result
+'
+
 test_expect_success 'find bool value for the entered key' '
 	check_config get_bool goat.head 1 &&
 	check_config get_bool goat.skin 0 &&
-- 
gitgitgadget

