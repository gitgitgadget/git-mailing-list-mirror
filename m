Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA60C433F5
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 01:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348957AbiFABQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 21:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240650AbiFABQS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 21:16:18 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924B495A0F
        for <git@vger.kernel.org>; Tue, 31 May 2022 18:16:16 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q7so253686wrg.5
        for <git@vger.kernel.org>; Tue, 31 May 2022 18:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PuyDv2h+4bOCEwFVNntQlmQfXzah9urxwyHVk0RMF5c=;
        b=T+AwY1gkrJSJbG5qFnJLt302LlT9MhYZba9iDWTUnpQ+UYDkNlGFQeQFTdzWPcPfPQ
         zbWyrzPFkRYSkncx11AsV0WoFgciZGmxeUkLumdzhXVEiIy4rzRae9A+GodKOb2/E3+B
         llJkBPOhMYjStJoJKYX+JxXE+EPsstbk82j6oaffTfCszzRxNgW4qZld7/fgWp6RRGTb
         i1jctBnbGxLSD+nqxIh62aT1S4TW82d8Vk9jVxCJul6lqdRiecPOZut8tRP8C2dSTdZu
         GKsj+hp/jm72J9AujamBZb1sbfcZwSC1hWBSB3pEb2JiUl4ZkY6lEQDwFLpDt0oDj1c2
         mIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PuyDv2h+4bOCEwFVNntQlmQfXzah9urxwyHVk0RMF5c=;
        b=3BRdrpMscCMCD30xwA2CLXAQWjIq3/P/rqR0ayxaOPyf0cKflt87z1SxyzzRwyLQFI
         D8FfMkeC09MMdzGn7qzOuvT93eNVHhOQ+0BAyHWiBiC2YBAOxDgywZRnKRZPKqarAQsV
         xCKnRM0eTdM6umCoMH1MDGsXojC6sigZH6tZyVl6I3pf+xNLMV4S83O3m48G0Ykshr/p
         arXtjq+mSMoigRSnEFemTjks5LMP1GE5EI4XN8b0xMokAaCMGULfd8H1Jr5NFWQiuogp
         N3omjZH60PxLnjN8GO5a4dEjUFkaSuX7vBR6+8IQ7ylnY+ReyfWRlyeqTvx6Sj3i0e6N
         IbHA==
X-Gm-Message-State: AOAM531PVTlWviZUPbwaSFyrkAW8+DjxxCEYg2FuBpp/YXHnEsupC8XH
        ZVg2DlCd4JTirhFYM2K0iupvABZbRnA=
X-Google-Smtp-Source: ABdhPJyRHYgU9KTBAKXrXhdTzSiaw1AALTBTNgdcPh6ElnM8xjz5X44lzuhsQeyPPO+278/tIzwCEw==
X-Received: by 2002:a05:6000:15c7:b0:210:472:e0e8 with SMTP id y7-20020a05600015c700b002100472e0e8mr25672609wry.365.1654046174445;
        Tue, 31 May 2022 18:16:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d13-20020adfef8d000000b0020fc40d006bsm126014wro.17.2022.05.31.18.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 18:16:13 -0700 (PDT)
Message-Id: <pull.1237.v3.git.1654046173.gitgitgadget@gmail.com>
In-Reply-To: <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
References: <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Jun 2022 01:16:11 +0000
Subject: [PATCH v3 0/2] fetch: create fetch.credentialsInUrl config
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
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users can specify credentials in their URL using the
username:password@domain format. This is potentially hazardous since the URL
is stored in plaintext and can also appear in trace2 logs and other places.
Add a new config option that allows warnings or failures when discovering
URLs with this format. The default behavior does not change in this series,
although we may want to move to the warn state by default in the future.

This is a modified version of the patch I submitted a while ago [1].

Based on the feedback, changing the behavior to fail by default was not a
good approach. Further, the idea to stop storing the credentials in config
and redirect them to a credential manager was already considered by Peff [2]
but not merged.

This patch does what should be the simplest thing we can do: create a config
option that will cause the user to get a warning or a failure, depending on
its value. The default is to ignore the setting, identical to the current
behavior. We can talk about changing this default to "warn" in the future,
but it would be safest to release with ignore as the default until we are
sure that we are not going to start warning on false positives.

This patch would be sufficient for the interested internal parties that want
to prevent users from storing credentials this way. System administrators
can modify system-level Git config into "die" mode to prevent this behavior.

[1]
https://lore.kernel.org/git/pull.945.git.1619807844627.gitgitgadget@gmail.com
Reject passwords in URLs (April 2021).

[2]
https://lore.kernel.org/git/20190519050724.GA26179@sigill.intra.peff.net/
Re: Git ransom campaign incident report - May 2019


Updates in v3
=============

 * Because of some flaky behavior around SIGPIPE, the URL check needed to
   move to be earlier in the command.
 * For this reason, I moved the cred check into remote.c's valid_remote()
   check. This changed the previous BUG() statements into early returns.
 * I repeated the check with the test suite to see if this parsing fails on
   any existing cases, but it is worth double-checking the parsing rules.
 * Documentation is more consistent about using placeholders.
 * A test for the "allow" case is now included.
 * A new patch is added that creates the warn_once() helper. This reduces
   multiple advisory warnings with the same text from being written by the
   same process.


Updates in v2
=============

 * Documentation is slightly expanded to include the fact that Git stores
   the given URL as plaintext in its config.
 * The new method has a new documentation comment that details the necessary
   preconditions.
 * "ignore" is now "allow"
 * Additional checks on colon_ptr are added.
 * Use strbuf_splice() instead of custom string-walking logic.
 * Use "" instead of asterisks.
 * Config value checks are no longer case sensitive.

Thanks, -Stolee

Derrick Stolee (2):
  remote: create fetch.credentialsInUrl config
  usage: add warn_once() helper for repeated warnings

 Documentation/config/fetch.txt | 14 ++++++++++
 git-compat-util.h              |  1 +
 remote.c                       | 48 ++++++++++++++++++++++++++++++++++
 t/t5601-clone.sh               | 17 ++++++++++++
 usage.c                        | 22 ++++++++++++++++
 5 files changed, 102 insertions(+)


base-commit: f9b95943b68b6b8ca5a6072f50a08411c6449b55
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1237%2Fderrickstolee%2Fcreds-in-url-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1237/derrickstolee/creds-in-url-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1237

Range-diff vs v2:

 1:  364f5c37c70 ! 1:  083a918e9b1 urlmatch: create fetch.credentialsInUrl config
     @@ Metadata
      Author: Derrick Stolee <derrickstolee@github.com>
      
       ## Commit message ##
     -    urlmatch: create fetch.credentialsInUrl config
     +    remote: create fetch.credentialsInUrl config
      
          Users sometimes provide a "username:password" combination in their
          plaintext URLs. Since Git stores these URLs in plaintext in the
     @@ Commit message
          advice about setting fetch.credentialsInUrl=ignore for users who still
          want to follow this pattern (and not receive the warning).
      
     +    An earlier version of this change injected the logic into
     +    url_normalize() in urlmatch.c. While most code paths that parse URLs
     +    eventually normalize the URL, that normalization does not happen early
     +    enough in the stack to avoid attempting connections to the URL first. By
     +    inserting a check into the remote validation, we identify the issue
     +    before making a connection. In the old code path, this was revealed by
     +    testing the new t5601-clone.sh test under --stress, resulting in an
     +    instance where the return code was 13 (SIGPIPE) instead of 128 from the
     +    die().
     +
     +    Since we are not deep within url_normalize(), we need to do our own
     +    parsing to detect if there is a "username:password@domain" section. We
     +    begin by detecting the first '@' symbol in the URL. We then detect if
     +    there is a scheme such as "https://" by finding the first slash. If that
     +    slash does not exist or is after the first '@' symbol, then we consider
     +    the scheme to be complete before the URL. Finally, we look for a colon
     +    between the scheme and the '@' symbol, indicating a "username:password"
     +    string. Replace the password with "<redacted>" when writing the error
     +    message.
     +
          As an attempt to ensure the parsing logic did not catch any
          unintentional cases, I modified this change locally to to use the "die"
          option by default. Running the test suite succeeds except for the
     @@ Documentation/config/fetch.txt: fetch.writeCommitGraph::
      +
      +fetch.credentialsInUrl::
      +	A URL can contain plaintext credentials in the form
     -+	`protocol://<user>:<password>@domain/path`. Using such URLs is not
     -+	recommended as it exposes the password in multiple ways, including
     -+	Git storing the URL as plaintext in the repository config. The
     -+	`fetch.credentialsInUrl` option provides instruction for how Git
     ++	`<protocol>://<user>:<password>@<domain>/<path>`. Using such URLs
     ++	is not recommended as it exposes the password in multiple ways,
     ++	including Git storing the URL as plaintext in the repository config.
     ++	The `fetch.credentialsInUrl` option provides instruction for how Git
      +	should react to seeing such a URL, with these values:
      ++
      +* `allow` (default): Git will proceed with its activity without warning.
     @@ Documentation/config/fetch.txt: fetch.writeCommitGraph::
      +* `die`: Git will write a failure message to `stderr` when parsing a URL
      +  with a plaintext credential.
      
     - ## t/t5601-clone.sh ##
     -@@ t/t5601-clone.sh: test_expect_success 'clone respects GIT_WORK_TREE' '
     - 
     - '
     - 
     -+test_expect_success 'clone warns or fails when using username:password' '
     -+	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username:password@localhost attempt1 2>err &&
     -+	grep "warning: URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" err &&
     -+	test_must_fail git -c fetch.credentialsInUrl=die clone https://username:password@localhost attempt2 2>err &&
     -+	grep "fatal: URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" err
     -+'
     -+
     -+test_expect_success 'clone does not detect username:password when it is https://username@domain:port/' '
     -+	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username@localhost:8080 attempt3 2>err &&
     -+	! grep "uses plaintext credentials" err
     -+'
     -+
     - test_expect_success 'clone from hooks' '
     - 
     - 	test_create_repo r0 &&
     -
     - ## urlmatch.c ##
     -@@
     - #include "cache.h"
     - #include "urlmatch.h"
     -+#include "config.h"
     - 
     - #define URL_ALPHA "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
     - #define URL_DIGIT "0123456789"
     -@@ urlmatch.c: static int match_host(const struct url_info *url_info,
     - 	return (!url_len && !pat_len);
     - }
     + ## remote.c ##
     +@@ remote.c: struct counted_string {
     + 	const char *s;
     + };
       
      +/*
     -+ * Call this method when we have detected credentials within the 'url' in
     -+ * the form
     ++ * Check if the given URL is of the following form:
      + *
      + *     scheme://username:password@domain[:port][/path]
      + *
     -+ * The 'scheme_len' value should be equal to the string length of the
     -+ * "scheme://" portion of the URL.
     ++ * Specifically, see if the ":password@" section of the URL appears.
      + *
      + * The fetch.credentialsInUrl config indicates what to do on such a URL,
     -+ * either ignoring, warning, or die()ing. The latter two modes write a
     ++ * either ignoring, warning, or erroring. The latter two modes write a
      + * redacted URL to stderr.
      + */
     -+static void detected_credentials_in_url(const char *url, size_t scheme_len)
     ++static void check_if_creds_in_url(const char *url)
      +{
     -+	const char *value;
     -+	const char *at_ptr;
     -+	const char *colon_ptr;
     ++	const char *value, *scheme_ptr, *colon_ptr, *at_ptr;
      +	struct strbuf redacted = STRBUF_INIT;
      +
      +	/* "allow" is the default behavior. */
     @@ urlmatch.c: static int match_host(const struct url_info *url_info,
      +	    !strcmp("allow", value))
      +		return;
      +
     -+	at_ptr = strchr(url, '@');
     -+	colon_ptr = strchr(url + scheme_len + 3, ':');
     ++	if (!(at_ptr = strchr(url, '@')))
     ++		return;
      +
     -+	/*
     -+	 * Let's do some defensive programming to ensure the given
     -+	 * URL is of the proper format.
     -+	 */
     -+	if (!colon_ptr)
     -+		BUG("failed to find colon in url '%s' with scheme_len %"PRIuMAX,
     -+		    url, (uintmax_t) scheme_len);
     -+	if (colon_ptr > at_ptr)
     -+		BUG("input url '%s' does not include credentials",
     -+		    url);
     ++	if (!(scheme_ptr = strchr(url, '/')) ||
     ++	    scheme_ptr > at_ptr)
     ++		scheme_ptr = url;
     ++
     ++	if (!(colon_ptr = strchr(scheme_ptr, ':')))
     ++		return;
      +
      +	/* Include the colon when creating the redacted URL. */
      +	colon_ptr++;
     @@ urlmatch.c: static int match_host(const struct url_info *url_info,
      +	strbuf_release(&redacted);
      +}
      +
     - static char *url_normalize_1(const char *url, struct url_info *out_info, char allow_globs)
     + static int valid_remote(const struct remote *remote)
       {
     - 	/*
     -@@ urlmatch.c: static char *url_normalize_1(const char *url, struct url_info *out_info, char al
     - 	 */
     ++	for (int i = 0; i < remote->url_nr; i++)
     ++		check_if_creds_in_url(remote->url[i]);
     ++
     + 	return (!!remote->url) || (!!remote->foreign_vcs);
     + }
     + 
     +
     + ## t/t5601-clone.sh ##
     +@@ t/t5601-clone.sh: test_expect_success 'clone respects GIT_WORK_TREE' '
     + 
     + '
       
     - 	size_t url_len = strlen(url);
     -+	const char *orig_url = url;
     - 	struct strbuf norm;
     - 	size_t spanned;
     - 	size_t scheme_len, user_off=0, user_len=0, passwd_off=0, passwd_len=0;
     -@@ urlmatch.c: static char *url_normalize_1(const char *url, struct url_info *out_info, char al
     - 			}
     - 			colon_ptr = strchr(norm.buf + scheme_len + 3, ':');
     - 			if (colon_ptr) {
     -+				detected_credentials_in_url(orig_url, scheme_len);
     - 				passwd_off = (colon_ptr + 1) - norm.buf;
     - 				passwd_len = norm.len - passwd_off;
     - 				user_len = (passwd_off - 1) - (scheme_len + 3);
     ++test_expect_success 'clone warns or fails when using username:password' '
     ++	test_must_fail git -c fetch.credentialsInUrl=allow clone https://username:password@localhost attempt1 2>err &&
     ++	! grep "URL '\''https://username:<redacted>@localhost'\'' uses plaintext credentials" err &&
     ++	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username:password@localhost attempt1 2>err &&
     ++	grep "warning: URL '\''https://username:<redacted>@localhost'\'' uses plaintext credentials" err &&
     ++	test_must_fail git -c fetch.credentialsInUrl=die clone https://username:password@localhost attempt2 2>err &&
     ++	grep "fatal: URL '\''https://username:<redacted>@localhost'\'' uses plaintext credentials" err
     ++'
     ++
     ++test_expect_success 'clone does not detect username:password when it is https://username@domain:port/' '
     ++	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username@localhost:8080 attempt3 2>err &&
     ++	! grep "uses plaintext credentials" err
     ++'
     ++
     + test_expect_success 'clone from hooks' '
     + 
     + 	test_create_repo r0 &&
 -:  ----------- > 2:  8e29ac807c6 usage: add warn_once() helper for repeated warnings

-- 
gitgitgadget
