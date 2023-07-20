Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AD7C001DC
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 22:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGTWSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 18:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGTWSP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 18:18:15 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0697D196
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 15:17:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso10766665e9.0
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 15:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689891438; x=1690496238;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Mn0kQlY7ElND2K/H7K6mJw5tojucNtmRybo7bllu1M=;
        b=Sdc3MDEKBfvR9d7mE44Ija3Kf4qQqq0ukKtlc75f1oW9PwcXHjBgbCcwu8/vqfx+p0
         1jyBcCzEzoNi7oZwPt2vdba313VtuM4XUuT0GKbq9v6zR2p9eJM3+vpUM+XnjCuAukU4
         NUSwsw6dJnNG7dskc769VK8h5GZsaQ+PkGTor/UtqQ5rDz36v6CdgDZon6j4c7Kkj5nm
         b1gUHJAdEwSn8tv4a+TcERvXYXQmV+WVpkjqLJC0nkH0uFkj5a3tGxt8Q8eXq36qfdL2
         VV2eJ4i4GhmyrFJ7wrczGsjQOywKI85DD/UPQlMlv1a7DEaZlghG92ATi2Uq9wpQ4zxg
         Ht1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689891438; x=1690496238;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Mn0kQlY7ElND2K/H7K6mJw5tojucNtmRybo7bllu1M=;
        b=M72l4BYvMvGbdsz6PmWX7k9uxSbzUxpB0ziQoXScqSzktpd40huVKHq98+xcU6+yhP
         hJ6Bwz5moeYYnP0t36wAa/FD2WZWyeRNSRbC5djLC94BqvuTvEIEVBXND+hnRIqTwegx
         cDIymnYrJ5du3reFj5cYFGCC2nLPbE1FruSVnxcKZ2mP9V6LxmLZ6eAnmalgzE+mvf/C
         Xb028GV9TzkPd73CopFYHeLoawhyo44uW4B8ZRq+tWoN2FcQAKnPkaYQLluqzYg5ELn/
         0D7Q8bj0jXCP94bn6Gf3lCGpscG2rowLHA0X2zxSUh/y4xEP0s6XxSnbeDvoZytmJbms
         10kA==
X-Gm-Message-State: ABy/qLYVXUX+lA6/mesKi8xltXVK2oLAb3vPC4yYb9SMaB8JLrApP4oE
        0vMn17kdLRO1i5t4Y+Q+JmbRoeTdRrI=
X-Google-Smtp-Source: APBJJlGZREYcpryxF/oByTfi9zaZ6IJqXRy3jVnvqOfTFUS6gltaV3r8ZaH+zwmxmcjRZBa/sBpdVw==
X-Received: by 2002:a5d:5185:0:b0:314:dea:f1f8 with SMTP id k5-20020a5d5185000000b003140deaf1f8mr64644wrv.11.1689891437778;
        Thu, 20 Jul 2023 15:17:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10-20020adff0ca000000b00314367cf43asm2392100wro.106.2023.07.20.15.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 15:17:17 -0700 (PDT)
Message-ID: <99244816307b822bd8ffcbff8690ef449c797a23.1689891436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Jul 2023 22:17:15 +0000
Subject: [PATCH 1/2] config: return positive from git_config_parse_key()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

git_config_parse_key() returns #define-d error codes, but negated. This
negation is merely a convenience to other parts of config.c that don't
bother inspecting the return value before passing it along. But:

a) There's no good reason why those callers couldn't negate the value
   themselves.

b) In other callers, this value eventually gets fed to exit(3), and
   those callers need to sanitize the negative value (and they sometimes
   do so lossily, by overriding the return value with
   CONFIG_INVALID_KEY).

c) We want to move that into a separate library, and returning only
   negative values no longer makes as much sense.

Change git_config_parse_key() to return positive values instead, and
adjust callers accordingly. Callers that sanitize the negative sign for
exit(3) now pass the return value opaquely, fixing a bug where "git
config <key with no section or name>" results in a different exit code
depending on whether we are setting or getting config. Callers that
wanted to pass along a negative value now negate the return value
themselves.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/config.c   |  3 +--
 config.c           | 16 ++++++++--------
 config.h           |  2 +-
 submodule-config.c |  4 ++--
 t/t1300-config.sh  | 16 ++++++++++++++++
 5 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 1c75cbc43df..8a2840f0a8c 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -362,8 +362,7 @@ static int get_value(const char *key_, const char *regex_, unsigned flags)
 			goto free_strings;
 		}
 	} else {
-		if (git_config_parse_key(key_, &key, NULL)) {
-			ret = CONFIG_INVALID_KEY;
+		if ((ret = git_config_parse_key(key_, &key, NULL))) {
 			goto free_strings;
 		}
 	}
diff --git a/config.c b/config.c
index 85c5f35132c..ca77ca17a47 100644
--- a/config.c
+++ b/config.c
@@ -534,8 +534,9 @@ static inline int iskeychar(int c)
  * Auxiliary function to sanity-check and split the key into the section
  * identifier and variable name.
  *
- * Returns 0 on success, -1 when there is an invalid character in the key and
- * -2 if there is no section name in the key.
+ * Returns 0 on success, CONFIG_INVALID_KEY when there is an invalid character
+ * in the key and CONFIG_NO_SECTION_OR_NAME if there is no section name in the
+ * key.
  *
  * store_key - pointer to char* which will hold a copy of the key with
  *             lowercase section and variable name
@@ -555,12 +556,12 @@ int git_config_parse_key(const char *key, char **store_key, size_t *baselen_)
 
 	if (last_dot == NULL || last_dot == key) {
 		error(_("key does not contain a section: %s"), key);
-		return -CONFIG_NO_SECTION_OR_NAME;
+		return CONFIG_NO_SECTION_OR_NAME;
 	}
 
 	if (!last_dot[1]) {
 		error(_("key does not contain variable name: %s"), key);
-		return -CONFIG_NO_SECTION_OR_NAME;
+		return CONFIG_NO_SECTION_OR_NAME;
 	}
 
 	baselen = last_dot - key;
@@ -596,7 +597,7 @@ int git_config_parse_key(const char *key, char **store_key, size_t *baselen_)
 
 out_free_ret_1:
 	FREE_AND_NULL(*store_key);
-	return -CONFIG_INVALID_KEY;
+	return CONFIG_INVALID_KEY;
 }
 
 static int config_parse_pair(const char *key, const char *value,
@@ -2346,7 +2347,7 @@ static int configset_find_element(struct config_set *set, const char *key,
 	 * `key` may come from the user, so normalize it before using it
 	 * for querying entries from the hashmap.
 	 */
-	ret = git_config_parse_key(key, &normalized_key, NULL);
+	ret = -git_config_parse_key(key, &normalized_key, NULL);
 	if (ret)
 		return ret;
 
@@ -3334,8 +3335,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	size_t contents_sz;
 	struct config_store_data store = CONFIG_STORE_INIT;
 
-	/* parse-key returns negative; flip the sign to feed exit(3) */
-	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
+	ret = git_config_parse_key(key, &store.key, &store.baselen);
 	if (ret)
 		goto out_free;
 
diff --git a/config.h b/config.h
index 6332d749047..40966cb6828 100644
--- a/config.h
+++ b/config.h
@@ -23,7 +23,7 @@
 
 struct object_id;
 
-/* git_config_parse_key() returns these negated: */
+/* git_config_parse_key() returns these: */
 #define CONFIG_INVALID_KEY 1
 #define CONFIG_NO_SECTION_OR_NAME 2
 /* git_config_set_gently(), git_config_set_multivar_gently() return the above or these: */
diff --git a/submodule-config.c b/submodule-config.c
index b6908e295f4..2aafc7f9cbe 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -824,8 +824,8 @@ int print_config_from_gitmodules(struct repository *repo, const char *key)
 	char *store_key;
 
 	ret = git_config_parse_key(key, &store_key, NULL);
-	if (ret < 0)
-		return CONFIG_INVALID_KEY;
+	if (ret)
+		return ret;
 
 	config_from_gitmodules(config_print_callback, repo, store_key);
 
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 387d336c91f..3202b0f8843 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2590,4 +2590,20 @@ test_expect_success 'includeIf.hasconfig:remote.*.url forbids remote url in such
 	grep "fatal: remote URLs cannot be configured in file directly or indirectly included by includeIf.hasconfig:remote.*.url" err
 '
 
+# Exit codes
+test_expect_success '--get with bad key' '
+	# Also exits with 1 if the value is not found
+	test_expect_code 1 git config --get "bad.name\n" 2>err &&
+	grep "error: invalid key" err &&
+	test_expect_code 2 git config --get "bad." 2>err &&
+	grep "error: key does not contain variable name" err
+'
+
+test_expect_success 'set with bad key' '
+	test_expect_code 1 git config "bad.name\n" var 2>err &&
+	grep "error: invalid key" err &&
+	test_expect_code 2 git config "bad." var 2>err &&
+	grep "error: key does not contain variable name" err
+'
+
 test_done
-- 
gitgitgadget

