Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEF8C001DE
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 23:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjGaXuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 19:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjGaXuA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 19:50:00 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FFB1BE6
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 16:49:52 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bb83eb84e5so52917025ad.1
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 16:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690847392; x=1691452192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IltbKIl/Wq5qmvu86I0yaKvu6MaZ/RepGR/92Z6jm6U=;
        b=t2ZvH4ZxFDBtglHQN15RST8U1thV7Jp8HesKpEqU5qsBWI9ej5n1QfpRz1zBMwOD/x
         GtlFQGxALJV0lndYFZcWN1/gh8dilnl9OCz3l8owG73dwyC2FoqWpdNezxx1VjkS9rzz
         EK3uf070NIDhKz5gMrrp1eojuFDX45zte1kIwfJ/Cp1tadPtrotneM7RlCu2xvmhlw73
         /MxmMjPR4MEPcS0a5Xr7gfv+g+P/KZOOu2p3KwZCKtVmXvz0c5fCEUXkVuZrwbGDaie4
         cJSbnpqLYNNbRz4Pvm5tqm7sSf62fHpjqlMhtaocGKBV65aH9jlkifoDMQrCNJ1r2HtP
         VeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690847392; x=1691452192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IltbKIl/Wq5qmvu86I0yaKvu6MaZ/RepGR/92Z6jm6U=;
        b=awbP6Kof6EYoYC76qUSWwjRYhj/ArYRxb5z0xZONgVrkWA/cDj817oOHrzEbn93QFD
         n7PJtUpBivAKW7444tU+nBkbvtZXBHu+JRilEjzkpNtFssZYG3nd2Y5w7MbLwYi8NQyg
         qXqawYbD/t40L4VIuS59wsk11SF+qsNs7Ui1hSqDX9VpSREN2RrGooeD2reYakdREOxd
         mLKWAFrgITZO+BHjy+QdJO/6eYgvqo+C9K1GHmA2uehE3lDWe0Hjgi2z06uDMKncUyod
         Zw2Jma6/KDH7KrADox3JQq4j0CdWZ0qLvDWdC3IKse9u3jlwH+3SWdwlSMU3y4X4bFh8
         eylg==
X-Gm-Message-State: ABy/qLZcgBPFajvz037PI82ZwEhqH1A0NDEfsjttNnvhSZ5xrzVTCCyc
        0Tn0ZilOKt5pC5jMtcLj01eP0Q+5nXIINqwd484cPBIwiEoKiXod4Bck+FZTNu/xhfvA4a0DI72
        NJdbu5rDyZ9+/uHpfqmdJo/h+VR/y43s/ZGHl9nCJL9a9T6GARh30pEc0faKt11w=
X-Google-Smtp-Source: APBJJlFBcGMO+Oxg3yaw8LClF5hcJdjOEK3pAObxMiPl6QkJ4+eNFFYyz9lQ3QX89eo2k/Lf19tqBsbLKzdIlg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:fa0d:b0:1bb:a13a:c21e with SMTP
 id la13-20020a170902fa0d00b001bba13ac21emr43087plb.10.1690847391363; Mon, 31
 Jul 2023 16:49:51 -0700 (PDT)
Date:   Mon, 31 Jul 2023 16:46:38 -0700
In-Reply-To: <20230731234910.94149-1-chooglen@google.com>
Mime-Version: 1.0
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com> <20230731234910.94149-1-chooglen@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230731234910.94149-2-chooglen@google.com>
Subject: [RFC PATCH v1.5 1/5] config: return positive from git_config_parse_key()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index 1c75cbc43d..8a2840f0a8 100644
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
index 85c5f35132..ca77ca17a4 100644
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
index 6332d74904..40966cb682 100644
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
index b6908e295f..2aafc7f9cb 100644
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
index 387d336c91..3202b0f884 100755
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
2.41.0.585.gd2178a4bd4-goog

