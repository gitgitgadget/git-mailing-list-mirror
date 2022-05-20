Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8124C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352897AbiETSl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353001AbiETSlG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:41:06 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C05201A4
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:02 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u3so12645103wrg.3
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lQ9pkgB4pnr1gSnM6ANJKaQteY7wEA2x2zTT0FkShrU=;
        b=YTl0YdK8KA64lrlhpIJEflR6dzg/MrRVjf5YanyWGzEyNLzgdpmohKHi0DpC83HydN
         YxYbg7IfucKmWHZ5EuaruNNbcGKL0WLGiUsHvp6H5z23DF2cdM0V8Kjp84IKudyoVW4O
         7/d5ocm55+2uebRQ2aDXK6oziNLd/r8goXMMXr2lj9TKp6FeYTHKJKTU/Y4X/KFma3cf
         24imRru3FAzEw8n/kuRtykYoCGaBBY5daPsN3WykQCHabzLagszvjVEzdP8ii7sCiJph
         NnbJ1VDx0IDAiI/8DJjF13L0FZn9QOb++IVk7F+pt7/YAH9pOvhO1/C0VD31hLXQIbpn
         G7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lQ9pkgB4pnr1gSnM6ANJKaQteY7wEA2x2zTT0FkShrU=;
        b=6m88UKMzFdYbpj48y6ptfj2hUX63mhZ8uha7eNjjs8LilbIrf2S7wuME7S626/JzgF
         JqaJM8ewxORBUjmYVboDPTJ6Dgg+peOVJcZBaQqboV7EMLcgC78yEw7ofmh8PRyOTrdZ
         07LJfL92jDP3jyl3LWUXoSjFzoSbny3lf503IFofLIeBp56bbHhDltM+CoUoY2MsCPM5
         DY7s0TgeVJ8s0ygjxyyISJlrRyDYQEd2z2ET3TqTpJx3jGlkWfEOErI9iyWFWGwpJb6O
         slSCWdiFjoXWT9aWl2gpj/c6xHxM4hzK0/FPvoooBUZhN0Eb/Oy9YQ3CI9f/H6CAR4ok
         s5Gw==
X-Gm-Message-State: AOAM533hQIuagiTRbKMBTjBuPv5h8bO5U0nYmm0FLkTQNHA4Zp/n0hxW
        LVt1M5Qhf3HdvYFfjo7Rb/16awxvMAA=
X-Google-Smtp-Source: ABdhPJwF0wKF+dSrU4R8UY2b3CHs52xIdW8Gc/hNlS4SsaPfkRNZkBqgBvO2QBkCczUGP2e83xXGtA==
X-Received: by 2002:a05:6000:1786:b0:20e:6267:5700 with SMTP id e6-20020a056000178600b0020e62675700mr9234912wrg.600.1653072060243;
        Fri, 20 May 2022 11:41:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c42cb00b003942a244ec8sm2419343wme.13.2022.05.20.11.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:40:59 -0700 (PDT)
Message-Id: <1fd302d0e56e877c13c5d4a5a5dc128104cc5fd3.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:32 +0000
Subject: [PATCH 14/24] bundle-uri: parse bundle list in config format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When a bundle provider wants to operate independently from a Git remote,
they want to provide a single, consistent URI that users can use in
their 'git clone --bundle-uri' commands. At this point, the Git client
expects that URI to be a single bundle that can be unbundled and used to
bootstrap the rest of the clone from the Git server. This single bundle
cannot be re-used to assist with future incremental fetches.

To allow for the incremental fetch case, teach Git to understand a
bundle list that could be advertised at an independent bundle URI. Such
a bundle list is likely to be inspected by human readers, even if only
by the bundle provider creating the list. For this reason, we can take
our expected "key=value" pairs and instead format them using Git config
format.

Create parse_bundle_list_in_config_format() to parse a file in config
format and convert that into a 'struct bundle_list' filled with its
understanding of the contents.

Be careful to call git_config_from_file_with_options() because the
default action for git_config_from_file() is to die() on a parsing
error. The current warning isn't particularly helpful if it arises to a
user, but it will be made more verbose at a higher layer later.

Update 'test-tool bundle-uri' to take this config file format as input.
It uses a filename instead of stdin because there is no existing way to
parse a FILE pointer in the config machinery. Using
git_config_from_mem() is overly complicated and more likely to introduce
bugs than this simpler version. I would rather have a slightly confusing
test helper than complicated product code.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c                | 28 +++++++++++++++++++++
 bundle-uri.h                | 10 ++++++++
 t/helper/test-bundle-uri.c  | 45 ++++++++++++++++++++++++++-------
 t/t5750-bundle-uri-parse.sh | 50 +++++++++++++++++++++++++++++++++++++
 4 files changed, 124 insertions(+), 9 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 74a26ce6c00..ab4b6385fc0 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -180,6 +180,34 @@ static int bundle_list_update(const char *key, const char *value,
 	return 0;
 }
 
+static int config_to_bundle_list(const char *key, const char *value, void *data)
+{
+	struct bundle_list *list = data;
+	return bundle_list_update(key, value, list);
+}
+
+int parse_bundle_list_in_config_format(const char *uri,
+				       const char *filename,
+				       struct bundle_list *list)
+{
+	int result;
+	struct config_options opts = {
+		.error_action = CONFIG_ERROR_ERROR,
+	};
+
+	list->mode = BUNDLE_MODE_NONE;
+	result = git_config_from_file_with_options(config_to_bundle_list,
+						   filename, list,
+						   &opts);
+
+	if (!result && list->mode == BUNDLE_MODE_NONE) {
+		warning(_("bundle list at '%s' has no mode"), uri);
+		result = 1;
+	}
+
+	return result;
+}
+
 static void find_temp_filename(struct strbuf *name)
 {
 	int fd;
diff --git a/bundle-uri.h b/bundle-uri.h
index 4a12a90bf42..b0183870336 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -73,6 +73,16 @@ int for_all_bundles_in_list(struct bundle_list *list,
 struct FILE;
 void print_bundle_list(FILE *fp, struct bundle_list *list);
 
+/**
+ * A bundle URI may point to a bundle list where the key=value
+ * pairs are provided in config file format. This method is
+ * exposed publicly for testing purposes.
+ */
+
+int parse_bundle_list_in_config_format(const char *uri,
+				       const char *filename,
+				       struct bundle_list *list);
+
 /**
  * Fetch data from the given 'uri' and unbundle the bundle data found
  * based on that information.
diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
index 5cb0c9196fa..23ce0eebca3 100644
--- a/t/helper/test-bundle-uri.c
+++ b/t/helper/test-bundle-uri.c
@@ -4,27 +4,52 @@
 #include "strbuf.h"
 #include "string-list.h"
 
-static int cmd__bundle_uri_parse_key_values(int argc, const char **argv)
+enum input_mode {
+	KEY_VALUE_PAIRS,
+	CONFIG_FILE,
+};
+
+static int cmd__bundle_uri_parse(int argc, const char **argv, enum input_mode mode)
 {
-	const char *usage[] = {
+	const char *key_value_usage[] = {
 		"test-tool bundle-uri parse-key-values <in",
 		NULL
 	};
+	const char *config_usage[] = {
+		"test-tool bundle-uri parse-config <input>",
+		NULL
+	};
 	struct option options[] = {
 		OPT_END(),
 	};
+	const char **usage = key_value_usage;
 	struct strbuf sb = STRBUF_INIT;
 	struct bundle_list list;
 	int err = 0;
 
-	argc = parse_options(argc, argv, NULL, options, usage, 0);
-	if (argc)
-		goto usage;
+	if (mode == CONFIG_FILE)
+		usage = config_usage;
+
+	argc = parse_options(argc, argv, NULL, options, usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	init_bundle_list(&list);
-	while (strbuf_getline(&sb, stdin) != EOF) {
-		if (bundle_uri_parse_line(&list, sb.buf) < 0)
-			err = error("bad line: '%s'", sb.buf);
+
+	switch (mode) {
+	case KEY_VALUE_PAIRS:
+		if (argc)
+			goto usage;
+		while (strbuf_getline(&sb, stdin) != EOF) {
+			if (bundle_uri_parse_line(&list, sb.buf) < 0)
+				err = error("bad line: '%s'", sb.buf);
+		}
+		break;
+
+	case CONFIG_FILE:
+		if (argc != 1)
+			goto usage;
+		err = parse_bundle_list_in_config_format("<uri>", argv[0], &list);
+		break;
 	}
 	strbuf_release(&sb);
 
@@ -55,7 +80,9 @@ int cmd__bundle_uri(int argc, const char **argv)
 		goto usage;
 
 	if (!strcmp(argv[1], "parse-key-values"))
-		return cmd__bundle_uri_parse_key_values(argc - 1, argv + 1);
+		return cmd__bundle_uri_parse(argc - 1, argv + 1, KEY_VALUE_PAIRS);
+	if (!strcmp(argv[1], "parse-config"))
+		return cmd__bundle_uri_parse(argc - 1, argv + 1, CONFIG_FILE);
 	error("there is no test-tool bundle-uri tool '%s'", argv[1]);
 
 usage:
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
index ebb80596125..c2b7a8ce968 100755
--- a/t/t5750-bundle-uri-parse.sh
+++ b/t/t5750-bundle-uri-parse.sh
@@ -88,4 +88,54 @@ test_expect_success 'bundle_uri_parse_line() parsing edge cases: empty lines' '
 	test_cmp_config_output expect actual
 '
 
+test_expect_success 'parse config format: just URIs' '
+	cat >expect <<-\EOF &&
+	[bundle "list"]
+		version = 1
+		mode = all
+	[bundle "one"]
+		uri = http://example.com/bundle.bdl
+	[bundle "two"]
+		uri = https://example.com/bundle.bdl
+	[bundle "three"]
+		uri = file:///usr/share/git/bundle.bdl
+	EOF
+
+	test-tool bundle-uri parse-config expect >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp_config_output expect actual
+'
+
+test_expect_success 'parse config format edge cases: empty key or value' '
+	cat >in1 <<-\EOF &&
+	= bogus-value
+	EOF
+
+	cat >err1 <<-EOF &&
+	error: bad config line 1 in file in1
+	EOF
+
+	cat >expect <<-\EOF &&
+	[bundle "list"]
+		version = 1
+		mode = <unknown>
+	EOF
+
+	test_must_fail test-tool bundle-uri parse-config in1 >actual 2>err &&
+	test_cmp err1 err &&
+	test_cmp_config_output expect actual &&
+
+	cat >in2 <<-\EOF &&
+	bogus-key =
+	EOF
+
+	cat >err2 <<-EOF &&
+	warning: bundle list at '\''<uri>'\'' has no mode
+	EOF
+
+	test_must_fail test-tool bundle-uri parse-config in2 >actual 2>err &&
+	test_cmp err2 err &&
+	test_cmp_config_output expect actual
+'
+
 test_done
-- 
gitgitgadget

