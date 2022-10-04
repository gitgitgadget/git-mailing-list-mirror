Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497FEC433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 12:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJDMet (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 08:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJDMej (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 08:34:39 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D686A5A3FA
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 05:34:31 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bk15so21090096wrb.13
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 05:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=23xdSrTs1L8KeO1BbMKQpiLa02wLnB63jG2LCHd+drg=;
        b=OL4eagC1my2ANjhb3pyDZ5oArl0JgoGO+6t4maxKVvosA497dTDRnBRO7FoWOpCP78
         ek4XbCh7UYgjftNU2C53wrqTnC6wqgC60OxuxPbYim+6Pg8aADckGreittSWI2cb8mT7
         xS9aIPg6BOoz3kc/opqyTWqxyuCYsetNSs72ySKEbe6jX3RhfExvUOVSnhxrMdm/Y+Qj
         RtnXfit2zUy2qBOsC6Wf8tzkwcLWG5uIqCCnxhILodBNupYUWU1cGYhJvR5VrDaDc1sz
         xy9l6U0yn5x+QZJ9KwzJPSjPq61a8sNz8x0YQLf5rnqtiEZSYyuY9RH0DhFH2X4788JU
         4ccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=23xdSrTs1L8KeO1BbMKQpiLa02wLnB63jG2LCHd+drg=;
        b=Y5Y/GV97nYjJ9TXUpB2yVapy2BVOsNTXnq3dyG5LboOar1kLEJjUR+SWZo/glULGi8
         8mVOQlGxw/yb72LMJNWcPzKkrafW29qAO4fhwo61fkpwJSkpo1q3kUE+ZkNXVduXJ/Tw
         Sjc881qO2dgSR20aflrdxn+meU0+ZgK5ftj7KKawHRCcSFJgfIylhkq/ybl7wJjHq9nM
         Yk1+d0S9f8HaDcig4SR64sftRg0yYqLmr01aPV0fi+ZZyhCkw01jKytHFDhPjCC7MX6+
         VGBpliUXvT0sHaXMaCtMI/SIzIhIUcg6R5T3w2JV4ZycNmH+t9LR4QcxLvXJoN0bMWw9
         E5Bg==
X-Gm-Message-State: ACrzQf32z3Dpkw4FNN7BoSZ1eMhEumPGJ9CnNiZmBouYjdxc/jWquSVS
        X9DS+6WRX5gTopHpWQE8sqDFiYPgGLo=
X-Google-Smtp-Source: AMsMyM56nwoXRpZFPestz4y8egzw7m4SB0SUsq9Yof1kef1ZLDQGBazxOvv84iMKpu9bTuXpH9eU/w==
X-Received: by 2002:a5d:6508:0:b0:22e:1af4:57f9 with SMTP id x8-20020a5d6508000000b0022e1af457f9mr10291679wru.539.1664886870093;
        Tue, 04 Oct 2022 05:34:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2-20020a05600c0a0200b003b48dac344esm21334545wmp.43.2022.10.04.05.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 05:34:29 -0700 (PDT)
Message-Id: <0ecae3a44b360fbb03a52b73536f83c457a6668d.1664886860.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
References: <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
        <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 12:34:17 +0000
Subject: [PATCH v3 6/9] bundle-uri: parse bundle list in config format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
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

Create bundle_uri_parse_config_format() to parse a file in config format
and convert that into a 'struct bundle_list' filled with its
understanding of the contents.

Be careful to use error_action CONFIG_ERROR_ERROR when calling
git_config_from_file_with_options() because the default action for
git_config_from_file() is to die() on a parsing error.  The current
warning isn't particularly helpful if it arises to a user, but it will
be made more verbose at a higher layer later.

Update 'test-tool bundle-uri' to take this config file format as input.
It uses a filename instead of stdin because there is no existing way to
parse a FILE pointer in the config machinery. Using
git_config_from_mem() is overly complicated and more likely to introduce
bugs than this simpler version.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c                | 27 ++++++++++++++++++++
 bundle-uri.h                |  9 +++++++
 t/helper/test-bundle-uri.c  | 49 +++++++++++++++++++++++++++---------
 t/t5750-bundle-uri-parse.sh | 50 +++++++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+), 12 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index c02e7f62eb1..3d44ec2b1e6 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -173,6 +173,33 @@ static int bundle_list_update(const char *key, const char *value,
 	return 0;
 }
 
+static int config_to_bundle_list(const char *key, const char *value, void *data)
+{
+	struct bundle_list *list = data;
+	return bundle_list_update(key, value, list);
+}
+
+int bundle_uri_parse_config_format(const char *uri,
+				   const char *filename,
+				   struct bundle_list *list)
+{
+	int result;
+	struct config_options opts = {
+		.error_action = CONFIG_ERROR_ERROR,
+	};
+
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
 static char *find_temp_filename(void)
 {
 	int fd;
diff --git a/bundle-uri.h b/bundle-uri.h
index 0e56ab2ae5a..bc13d4c9929 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -62,6 +62,15 @@ int for_all_bundles_in_list(struct bundle_list *list,
 struct FILE;
 void print_bundle_list(FILE *fp, struct bundle_list *list);
 
+/**
+ * A bundle URI may point to a bundle list where the key=value
+ * pairs are provided in config file format. This method is
+ * exposed publicly for testing purposes.
+ */
+int bundle_uri_parse_config_format(const char *uri,
+				   const char *filename,
+				   struct bundle_list *list);
+
 /**
  * Fetch data from the given 'uri' and unbundle the bundle data found
  * based on that information.
diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
index 0329c56544f..25afd393428 100644
--- a/t/helper/test-bundle-uri.c
+++ b/t/helper/test-bundle-uri.c
@@ -4,12 +4,21 @@
 #include "strbuf.h"
 #include "string-list.h"
 
-static int cmd__bundle_uri_parse(int argc, const char **argv)
+enum input_mode {
+	KEY_VALUE_PAIRS,
+	CONFIG_FILE,
+};
+
+static int cmd__bundle_uri_parse(int argc, const char **argv, enum input_mode mode)
 {
 	const char *key_value_usage[] = {
 		"test-tool bundle-uri parse-key-values <input>",
 		NULL
 	};
+	const char *config_usage[] = {
+		"test-tool bundle-uri parse-config <input>",
+		NULL
+	};
 	const char **usage = key_value_usage;
 	struct option options[] = {
 		OPT_END(),
@@ -19,21 +28,35 @@ static int cmd__bundle_uri_parse(int argc, const char **argv)
 	int err = 0;
 	FILE *fp;
 
-	argc = parse_options(argc, argv, NULL, options, usage, 0);
-	if (argc != 1)
-		goto usage;
+	if (mode == CONFIG_FILE)
+		usage = config_usage;
+
+	argc = parse_options(argc, argv, NULL, options, usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	init_bundle_list(&list);
-	fp = fopen(argv[0], "r");
-	if (!fp)
-		die("failed to open '%s'", argv[0]);
 
-	while (strbuf_getline(&sb, fp) != EOF) {
-		if (bundle_uri_parse_line(&list, sb.buf))
-			err = error("bad line: '%s'", sb.buf);
+	switch (mode) {
+	case KEY_VALUE_PAIRS:
+		if (argc != 1)
+			goto usage;
+		fp = fopen(argv[0], "r");
+		if (!fp)
+			die("failed to open '%s'", argv[0]);
+		while (strbuf_getline(&sb, fp) != EOF) {
+			if (bundle_uri_parse_line(&list, sb.buf))
+				err = error("bad line: '%s'", sb.buf);
+		}
+		fclose(fp);
+		break;
+
+	case CONFIG_FILE:
+		if (argc != 1)
+			goto usage;
+		err = bundle_uri_parse_config_format("<uri>", argv[0], &list);
+		break;
 	}
 	strbuf_release(&sb);
-	fclose(fp);
 
 	print_bundle_list(stdout, &list);
 
@@ -62,7 +85,9 @@ int cmd__bundle_uri(int argc, const char **argv)
 		goto usage;
 
 	if (!strcmp(argv[1], "parse-key-values"))
-		return cmd__bundle_uri_parse(argc - 1, argv + 1);
+		return cmd__bundle_uri_parse(argc - 1, argv + 1, KEY_VALUE_PAIRS);
+	if (!strcmp(argv[1], "parse-config"))
+		return cmd__bundle_uri_parse(argc - 1, argv + 1, CONFIG_FILE);
 	error("there is no test-tool bundle-uri tool '%s'", argv[1]);
 
 usage:
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
index fd142a66ad5..c2fe3f9c5a5 100755
--- a/t/t5750-bundle-uri-parse.sh
+++ b/t/t5750-bundle-uri-parse.sh
@@ -118,4 +118,54 @@ test_expect_success 'bundle_uri_parse_line() parsing edge cases: duplicate lines
 	test_cmp_config_output expect actual
 '
 
+test_expect_success 'parse config format: just URIs' '
+	cat >expect <<-\EOF &&
+	[bundle]
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
+	[bundle]
+		version = 1
+		mode = all
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
+	error: bad config line 1 in file in2
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

