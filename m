Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29D9C433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 13:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238187AbiE0N1V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 09:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbiE0N1T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 09:27:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC9E3057F
        for <git@vger.kernel.org>; Fri, 27 May 2022 06:27:17 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v17so1679701wrv.2
        for <git@vger.kernel.org>; Fri, 27 May 2022 06:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UQ3q0Fuy22j+nMXz7KkYxV1JEGNt/jYdR/E2m4x4HA4=;
        b=U4lBu36rrsQ6Gt8rSGoR/Y+L4aR/Af3m6grvBryk3MUfSnen2d8DaU3Zw/kI+lNl3D
         DVyeUSvTsT5qj73F6He3gbXSbZ4OQ0jaly6s++3CIc3vPQWfMKjKFLnoU9hZGmwlxEQc
         58nCqcEqhVe5YBc/Vk7cIxIHRrdgCtylxsVS2lFggs850vbyXouXnxdFqjMDiLXJsect
         Un3FHaXn89Na7oouJIVm7C3HJYb0pxaCLgW/0aahB88o4K4I5NCen6TjrVAIDe/90X/q
         Ng5bNIyu2yw1gOXxMjD5hoGstifn+YWLQ0ffus1nOdohELtMCiwUzrulOcPU3fo2T+Gj
         G8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UQ3q0Fuy22j+nMXz7KkYxV1JEGNt/jYdR/E2m4x4HA4=;
        b=WgDVRl4bXeIHJllKXZtsJrK9eFQ+yYpyGkFOpuZtJGNKpBEh3pMF5GwE/o0G8s4BaT
         tZxAdI48Fpqtu7/+kOjD97anIl17jL3gVJ0yZ4lK29JAulJybjVHdin7dpHa5/4ImHv5
         EO2b/ypsRKDlmQmyilki+lxsbfqKvaVZpSk7MCaLWedd9PPaS9PB0FqXd/2abBHlNDpp
         x1mmhLasuPAvbpe7LAun4lvUF28MHap90l/rks0yXEzdFmGLh80xTDaB1ExtEkGqy+aY
         saArMBFCOuR1WPLIB/EVKVs4PeP+ac6x+q0ENyKfa1ihn6+2FWsWrh3o2dPyrll8hkuz
         CRKg==
X-Gm-Message-State: AOAM530TQpmGOIWycmZcNf7u03KJaotU79i8J5GI6QVTK+0C3ftnGdLY
        dbS6sV83/QlbmAUl476lDXqWyfhqi6Q=
X-Google-Smtp-Source: ABdhPJy+De9DSJ+ho2DNbAJOdkfLg3DKRcU7mzMoS4NEdf/RgncB9vItXx/dAajeUVHGuyMdR1Ksww==
X-Received: by 2002:adf:eb4c:0:b0:20e:64b8:1ce8 with SMTP id u12-20020adfeb4c000000b0020e64b81ce8mr35258692wrn.609.1653658035664;
        Fri, 27 May 2022 06:27:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a21-20020a05600c069500b003942a244ed7sm2008082wmn.28.2022.05.27.06.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 06:27:14 -0700 (PDT)
Message-Id: <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
In-Reply-To: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
References: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 May 2022 13:27:13 +0000
Subject: [PATCH v2] urlmatch: create fetch.credentialsInUrl config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Users sometimes provide a "username:password" combination in their
plaintext URLs. Since Git stores these URLs in plaintext in the
.git/config file, this is a very insecure way of storing these
credentials. Credential managers are a more secure way of storing this
information.

System administrators might want to prevent this kind of use by users on
their machines.

Create a new "fetch.credentialsInUrl" config option and teach Git to
warn or die when seeing a URL with this kind of information. The warning
anonymizes the sensitive information of the URL to be clear about the
issue.

This change currently defaults the behavior to "allow" which does
nothing with these URLs. We can consider changing this behavior to
"warn" by default if we wish. At that time, we may want to add some
advice about setting fetch.credentialsInUrl=ignore for users who still
want to follow this pattern (and not receive the warning).

As an attempt to ensure the parsing logic did not catch any
unintentional cases, I modified this change locally to to use the "die"
option by default. Running the test suite succeeds except for the
explicit username:password URLs used in t5550-http-fetch-dumb.sh and
t5541-http-push-smart.sh. This means that all other tested URLs did not
trigger this logic.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    urlmatch: create fetch.credentialsInUrl config
    
    This is a modified version of the patch I submitted a while ago [1].
    
    Based on the feedback, changing the behavior to fail by default was not
    a good approach. Further, the idea to stop storing the credentials in
    config and redirect them to a credential manager was already considered
    by Peff [2] but not merged.
    
    This patch does what should be the simplest thing we can do: create a
    config option that will cause the user to get a warning or a failure,
    depending on its value. The default is to ignore the setting, identical
    to the current behavior. We can talk about changing this default to
    "warn" in the future, but it would be safest to release with ignore as
    the default until we are sure that we are not going to start warning on
    false positives.
    
    This patch would be sufficient for the interested internal parties that
    want to prevent users from storing credentials this way. System
    administrators can modify system-level Git config into "die" mode to
    prevent this behavior.
    
    [1]
    https://lore.kernel.org/git/pull.945.git.1619807844627.gitgitgadget@gmail.com
    Reject passwords in URLs (April 2021).
    
    [2]
    https://lore.kernel.org/git/20190519050724.GA26179@sigill.intra.peff.net/
    Re: Git ransom campaign incident report - May 2019
    
    
    Updates in v2
    =============
    
     * Documentation is slightly expanded to include the fact that Git
       stores the given URL as plaintext in its config.
     * The new method has a new documentation comment that details the
       necessary preconditions.
     * "ignore" is now "allow"
     * Additional checks on colon_ptr are added.
     * Use strbuf_splice() instead of custom string-walking logic.
     * Use "" instead of asterisks.
     * Config value checks are no longer case sensitive.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1237%2Fderrickstolee%2Fcreds-in-url-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1237/derrickstolee/creds-in-url-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1237

Range-diff vs v1:

 1:  cc2befb3803 ! 1:  364f5c37c70 urlmatch: create fetch.credentialsInUrl config
     @@ Commit message
          anonymizes the sensitive information of the URL to be clear about the
          issue.
      
     -    This change currently defaults the behavior to "ignore" which does
     +    This change currently defaults the behavior to "allow" which does
          nothing with these URLs. We can consider changing this behavior to
          "warn" by default if we wish. At that time, we may want to add some
          advice about setting fetch.credentialsInUrl=ignore for users who still
     @@ Commit message
          As an attempt to ensure the parsing logic did not catch any
          unintentional cases, I modified this change locally to to use the "die"
          option by default. Running the test suite succeeds except for the
     -    explicit username:password URLs used in t5550-http-fetch-dumb.s and
     +    explicit username:password URLs used in t5550-http-fetch-dumb.sh and
          t5541-http-push-smart.sh. This means that all other tested URLs did not
          trigger this logic.
      
     @@ Documentation/config/fetch.txt: fetch.writeCommitGraph::
      +fetch.credentialsInUrl::
      +	A URL can contain plaintext credentials in the form
      +	`protocol://<user>:<password>@domain/path`. Using such URLs is not
     -+	recommended as it exposes the password in multiple ways. The
     ++	recommended as it exposes the password in multiple ways, including
     ++	Git storing the URL as plaintext in the repository config. The
      +	`fetch.credentialsInUrl` option provides instruction for how Git
      +	should react to seeing such a URL, with these values:
      ++
     -+* `ignore` (default): Git will proceed with its activity without warning.
     ++* `allow` (default): Git will proceed with its activity without warning.
      +* `warn`: Git will write a warning message to `stderr` when parsing a URL
      +  with a plaintext credential.
      +* `die`: Git will write a failure message to `stderr` when parsing a URL
     @@ t/t5601-clone.sh: test_expect_success 'clone respects GIT_WORK_TREE' '
       
      +test_expect_success 'clone warns or fails when using username:password' '
      +	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username:password@localhost attempt1 2>err &&
     -+	grep "warning: URL '\''https://username:\*\*\*\*\*\*\*\*@localhost/'\'' uses plaintext credentials" err &&
     ++	grep "warning: URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" err &&
      +	test_must_fail git -c fetch.credentialsInUrl=die clone https://username:password@localhost attempt2 2>err &&
     -+	grep "fatal: URL '\''https://username:\*\*\*\*\*\*\*\*@localhost/'\'' uses plaintext credentials" err
     ++	grep "fatal: URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" err
     ++'
     ++
     ++test_expect_success 'clone does not detect username:password when it is https://username@domain:port/' '
     ++	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username@localhost:8080 attempt3 2>err &&
     ++	! grep "uses plaintext credentials" err
      +'
      +
       test_expect_success 'clone from hooks' '
     @@ urlmatch.c: static int match_host(const struct url_info *url_info,
       	return (!url_len && !pat_len);
       }
       
     ++/*
     ++ * Call this method when we have detected credentials within the 'url' in
     ++ * the form
     ++ *
     ++ *     scheme://username:password@domain[:port][/path]
     ++ *
     ++ * The 'scheme_len' value should be equal to the string length of the
     ++ * "scheme://" portion of the URL.
     ++ *
     ++ * The fetch.credentialsInUrl config indicates what to do on such a URL,
     ++ * either ignoring, warning, or die()ing. The latter two modes write a
     ++ * redacted URL to stderr.
     ++ */
      +static void detected_credentials_in_url(const char *url, size_t scheme_len)
      +{
     -+	char *value = NULL;
     ++	const char *value;
      +	const char *at_ptr;
      +	const char *colon_ptr;
     -+	struct strbuf anonymized = STRBUF_INIT;
     ++	struct strbuf redacted = STRBUF_INIT;
      +
     -+	/* "ignore" is the default behavior. */
     -+	if (git_config_get_string("fetch.credentialsinurl", &value) ||
     -+	    !strcasecmp("ignore", value))
     -+		goto cleanup;
     ++	/* "allow" is the default behavior. */
     ++	if (git_config_get_string_tmp("fetch.credentialsinurl", &value) ||
     ++	    !strcmp("allow", value))
     ++		return;
      +
      +	at_ptr = strchr(url, '@');
      +	colon_ptr = strchr(url + scheme_len + 3, ':');
      +
     ++	/*
     ++	 * Let's do some defensive programming to ensure the given
     ++	 * URL is of the proper format.
     ++	 */
      +	if (!colon_ptr)
      +		BUG("failed to find colon in url '%s' with scheme_len %"PRIuMAX,
      +		    url, (uintmax_t) scheme_len);
     ++	if (colon_ptr > at_ptr)
     ++		BUG("input url '%s' does not include credentials",
     ++		    url);
      +
     -+	/* Include everything including the colon. */
     ++	/* Include the colon when creating the redacted URL. */
      +	colon_ptr++;
     -+	strbuf_add(&anonymized, url, colon_ptr - url);
     -+
     -+	while (colon_ptr < at_ptr) {
     -+		strbuf_addch(&anonymized, '*');
     -+		colon_ptr++;
     -+	}
     -+
     -+	strbuf_addstr(&anonymized, at_ptr);
     ++	strbuf_addstr(&redacted, url);
     ++	strbuf_splice(&redacted, colon_ptr - url, at_ptr - colon_ptr,
     ++		      "<redacted>", 10);
      +
     -+	if (!strcasecmp("warn", value))
     -+		warning(_("URL '%s' uses plaintext credentials"), anonymized.buf);
     -+	if (!strcasecmp("die", value))
     -+		die(_("URL '%s' uses plaintext credentials"), anonymized.buf);
     ++	if (!strcmp("warn", value))
     ++		warning(_("URL '%s' uses plaintext credentials"), redacted.buf);
     ++	if (!strcmp("die", value))
     ++		die(_("URL '%s' uses plaintext credentials"), redacted.buf);
      +
     -+cleanup:
     -+	free(value);
     -+	strbuf_release(&anonymized);
     ++	strbuf_release(&redacted);
      +}
      +
       static char *url_normalize_1(const char *url, struct url_info *out_info, char allow_globs)


 Documentation/config/fetch.txt | 14 +++++++++
 t/t5601-clone.sh               | 12 ++++++++
 urlmatch.c                     | 56 ++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index cd65d236b43..7fd3ea89f5d 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -96,3 +96,17 @@ fetch.writeCommitGraph::
 	merge and the write may take longer. Having an updated commit-graph
 	file helps performance of many Git commands, including `git merge-base`,
 	`git push -f`, and `git log --graph`. Defaults to false.
+
+fetch.credentialsInUrl::
+	A URL can contain plaintext credentials in the form
+	`protocol://<user>:<password>@domain/path`. Using such URLs is not
+	recommended as it exposes the password in multiple ways, including
+	Git storing the URL as plaintext in the repository config. The
+	`fetch.credentialsInUrl` option provides instruction for how Git
+	should react to seeing such a URL, with these values:
++
+* `allow` (default): Git will proceed with its activity without warning.
+* `warn`: Git will write a warning message to `stderr` when parsing a URL
+  with a plaintext credential.
+* `die`: Git will write a failure message to `stderr` when parsing a URL
+  with a plaintext credential.
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 4a61f2c901e..387da74d175 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -71,6 +71,18 @@ test_expect_success 'clone respects GIT_WORK_TREE' '
 
 '
 
+test_expect_success 'clone warns or fails when using username:password' '
+	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username:password@localhost attempt1 2>err &&
+	grep "warning: URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" err &&
+	test_must_fail git -c fetch.credentialsInUrl=die clone https://username:password@localhost attempt2 2>err &&
+	grep "fatal: URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" err
+'
+
+test_expect_success 'clone does not detect username:password when it is https://username@domain:port/' '
+	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username@localhost:8080 attempt3 2>err &&
+	! grep "uses plaintext credentials" err
+'
+
 test_expect_success 'clone from hooks' '
 
 	test_create_repo r0 &&
diff --git a/urlmatch.c b/urlmatch.c
index b615adc923a..16beda37a3a 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "urlmatch.h"
+#include "config.h"
 
 #define URL_ALPHA "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
 #define URL_DIGIT "0123456789"
@@ -106,6 +107,59 @@ static int match_host(const struct url_info *url_info,
 	return (!url_len && !pat_len);
 }
 
+/*
+ * Call this method when we have detected credentials within the 'url' in
+ * the form
+ *
+ *     scheme://username:password@domain[:port][/path]
+ *
+ * The 'scheme_len' value should be equal to the string length of the
+ * "scheme://" portion of the URL.
+ *
+ * The fetch.credentialsInUrl config indicates what to do on such a URL,
+ * either ignoring, warning, or die()ing. The latter two modes write a
+ * redacted URL to stderr.
+ */
+static void detected_credentials_in_url(const char *url, size_t scheme_len)
+{
+	const char *value;
+	const char *at_ptr;
+	const char *colon_ptr;
+	struct strbuf redacted = STRBUF_INIT;
+
+	/* "allow" is the default behavior. */
+	if (git_config_get_string_tmp("fetch.credentialsinurl", &value) ||
+	    !strcmp("allow", value))
+		return;
+
+	at_ptr = strchr(url, '@');
+	colon_ptr = strchr(url + scheme_len + 3, ':');
+
+	/*
+	 * Let's do some defensive programming to ensure the given
+	 * URL is of the proper format.
+	 */
+	if (!colon_ptr)
+		BUG("failed to find colon in url '%s' with scheme_len %"PRIuMAX,
+		    url, (uintmax_t) scheme_len);
+	if (colon_ptr > at_ptr)
+		BUG("input url '%s' does not include credentials",
+		    url);
+
+	/* Include the colon when creating the redacted URL. */
+	colon_ptr++;
+	strbuf_addstr(&redacted, url);
+	strbuf_splice(&redacted, colon_ptr - url, at_ptr - colon_ptr,
+		      "<redacted>", 10);
+
+	if (!strcmp("warn", value))
+		warning(_("URL '%s' uses plaintext credentials"), redacted.buf);
+	if (!strcmp("die", value))
+		die(_("URL '%s' uses plaintext credentials"), redacted.buf);
+
+	strbuf_release(&redacted);
+}
+
 static char *url_normalize_1(const char *url, struct url_info *out_info, char allow_globs)
 {
 	/*
@@ -144,6 +198,7 @@ static char *url_normalize_1(const char *url, struct url_info *out_info, char al
 	 */
 
 	size_t url_len = strlen(url);
+	const char *orig_url = url;
 	struct strbuf norm;
 	size_t spanned;
 	size_t scheme_len, user_off=0, user_len=0, passwd_off=0, passwd_len=0;
@@ -191,6 +246,7 @@ static char *url_normalize_1(const char *url, struct url_info *out_info, char al
 			}
 			colon_ptr = strchr(norm.buf + scheme_len + 3, ':');
 			if (colon_ptr) {
+				detected_credentials_in_url(orig_url, scheme_len);
 				passwd_off = (colon_ptr + 1) - norm.buf;
 				passwd_len = norm.len - passwd_off;
 				user_len = (passwd_off - 1) - (scheme_len + 3);

base-commit: f9b95943b68b6b8ca5a6072f50a08411c6449b55
-- 
gitgitgadget
