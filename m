Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2E2C6FD1D
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 00:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjCPAMX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 20:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjCPAL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 20:11:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425D31814C
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 17:11:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k25-20020a7bc419000000b003ed23114fa7so2075559wmi.4
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 17:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678925513;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELkzqHrf8h2ogFJaHj89QDibYfXtL4UFLw4FEHzPrx8=;
        b=lyr1HpAwFI1CAwbUVc4UDt7hya82P4OcpOba041GCm/Z907Ri0q20HkXt8JMftigXd
         ZORLpmea7+niIk89CVMuk3YwcWiyJCau62/gjKx92KYYiJ35Xl/MgL/bkEdsBemEXrDS
         QnOZn2IESt14ar6+xstBFPHVEv20KeFohnd0nD9O23ztGh3LUlEM3UbFiDy+D3qZHFRc
         xo3acnCISqeoUodjiHmmoKqhCu2DT/xR3H+vHldXoSHDzUbwc4p3NWAOYwVHeEN2585j
         DnNk0QmHlHtdiKL3jyBffgA2INFkZSRtDiWA9b3Nes/mH+kHXV4y9JypvW3BjOZqWpRv
         X3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678925513;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELkzqHrf8h2ogFJaHj89QDibYfXtL4UFLw4FEHzPrx8=;
        b=tbSwfXtuJyA8rcRLR1d8lzb+jYkv3fPzzmZnp6sQi1S4OYceyJY1zH/tA34beoxXXF
         qQY8Wo1iiTNhHQbFpQJsNSrr/rv4mdsJZ3Ty+b4wM8ciPM/4OTIHO6JJ4jnZxdoZ8d+m
         ZS+1epaIEQrL5HhZVxKwwFRM6UF0L3wf2Webwxhoise+sK+skmP9L+O6l4JYR4agL/S9
         TR/g/yTbF6U/i0QLF2smn39mS0wOhvkCOqAR7S0uPmj5jZ+hLwUBdsWKZcYtjosFLX58
         DvtdGRe2tAjM7mpv3KoD+HOBiyjkrLD0u5GO7Du04l3yC3y3+P3DZMAK+fLQZj9veN8f
         1Iig==
X-Gm-Message-State: AO0yUKWQt5bkH+qMN0jnp+Dj1B/ghX/OC/dtkwilkeq2SSaj+IR9Qxqh
        i11dq2IFBvbqf2nmFDvd601pJ5U0fLY=
X-Google-Smtp-Source: AK7set9TdS9zGRy0ZuLUgVVL1Oh357aO2rADWw8Sy1soMOse3iUuSbJEkBDqVIp8+Y60Bseym4C0lA==
X-Received: by 2002:a05:600c:c10:b0:3eb:248f:a13e with SMTP id fm16-20020a05600c0c1000b003eb248fa13emr20620719wmb.22.1678925513580;
        Wed, 15 Mar 2023 17:11:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c3b8d00b003e8dcc67bdesm3401519wms.30.2023.03.15.17.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 17:11:53 -0700 (PDT)
Message-Id: <3c83d9535a037653c7de2d462a4df3a3c43a9308.1678925506.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
References: <pull.1463.git.git.1677631097.gitgitgadget@gmail.com>
        <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Mar 2023 00:11:45 +0000
Subject: [PATCH v2 7/8] config: report cached filenames in die_bad_number()
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
functions in die_bad_number(). Refactoring is needed because "git config
--get[-regexp] --type=int" parses the int value _after_ parsing the
config file, which will run into the BUG().

Also, plumb "struct config_reader" into the new functions. This isn't
necessary per se, but this generalizes better, so it might help us avoid
yet another refactor.

1. https://lore.kernel.org/git/20160518223712.GA18317@sigill.intra.peff.net/

Signed-off-by: Glen Choo <chooglen@google.com>
---
 config.c               | 65 +++++++++++++++++++++++++++++-------------
 config.h               |  1 +
 t/helper/test-config.c | 17 +++++++++++
 t/t1308-config-set.sh  |  9 ++++++
 4 files changed, 72 insertions(+), 20 deletions(-)

diff --git a/config.c b/config.c
index 460326ae21e..da5f6381cde 100644
--- a/config.c
+++ b/config.c
@@ -1312,39 +1312,48 @@ int git_parse_ssize_t(const char *value, ssize_t *ret)
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
 
@@ -1352,7 +1361,7 @@ int git_config_int(const char *name, const char *value)
 {
 	int ret;
 	if (!git_parse_int(value, &ret))
-		die_bad_number(the_reader.source, name, value);
+		die_bad_number(&the_reader, name, value);
 	return ret;
 }
 
@@ -1360,7 +1369,7 @@ int64_t git_config_int64(const char *name, const char *value)
 {
 	int64_t ret;
 	if (!git_parse_int64(value, &ret))
-		die_bad_number(the_reader.source, name, value);
+		die_bad_number(&the_reader, name, value);
 	return ret;
 }
 
@@ -1368,7 +1377,7 @@ unsigned long git_config_ulong(const char *name, const char *value)
 {
 	unsigned long ret;
 	if (!git_parse_ulong(value, &ret))
-		die_bad_number(the_reader.source, name, value);
+		die_bad_number(&the_reader, name, value);
 	return ret;
 }
 
@@ -1376,7 +1385,7 @@ ssize_t git_config_ssize_t(const char *name, const char *value)
 {
 	ssize_t ret;
 	if (!git_parse_ssize_t(value, &ret))
-		die_bad_number(the_reader.source, name, value);
+		die_bad_number(&the_reader, name, value);
 	return ret;
 }
 
@@ -3840,14 +3849,23 @@ int parse_config_key(const char *var,
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
@@ -3886,14 +3904,21 @@ const char *config_scope_name(enum config_scope scope)
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

