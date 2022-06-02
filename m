Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90845CCA47B
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 17:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbiFBRVB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 13:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237513AbiFBRU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 13:20:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80C52162BF
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 10:20:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q7so7300207wrg.5
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 10:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9BVZE0mJqrTZl91A68kpJmcfAkERR25wvszUzaBlt04=;
        b=i94SG1T9Mk5jbir/s0UDBMdBcTKxwu0H2EJbYF2G6lAtRVq+76Uy6j2UYnfVPEApSD
         i0LBSjYtJSH5HBfJeNRc8mNM/jhSuLZYqIANLlDnhVXmLfgIWNBABf68A3453uDiOS6z
         jrNu3Sgwdh8NhHJ3G092pA5NPqp8y+7Ogr6AJJqrHdj+fakOoukBAtqnNZBOMzVu/Vd1
         flq9tmtI9MHOkt8fYIMxOF3/ranzwd4lf+JQiYYEu3kIjMAXwP4q0RZnCj/NRRV2PT2O
         w0yvnPe76P+p7/I/lOnRGkg4Jg4wiyZVjoutMLJxJHL4e3T7AghgcADJUN64zkYpNRzI
         p1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9BVZE0mJqrTZl91A68kpJmcfAkERR25wvszUzaBlt04=;
        b=thJkBn8NwqxXPQIoeCsB/FaITKspOpZuinJRSIUx5bZldQKv2nap7+YTY0ayQ6ni5s
         YMnpvudawtEBbKSf6ugV8x9YbPFDI/6MswnDldUJPk6EJULID8BI/OhUHn4atayrRSJe
         1OFZXshH4QGP2klhMh6AsjqhOtHRSKajrL6hgWCSY8OQhJpf5LTjRz+nLVw0ga+7ZJCM
         E8uJ0yYFKD91CcJXmHM5mIsB08YReDVgZM8Q8LOiaVb7hec/ojg+5NZf9zEbdehyPdRX
         5TtGpQfnHhXZzVosWMODRZPD5rhMnzDSIX8KPhIJqgn59gjphicXuepFWu7RmdXVUMxu
         DSmw==
X-Gm-Message-State: AOAM533TKbPmE/zWK+bgMVtx3m5AXk9vl/sV6gAwgrJWbY/R/7qlHxW1
        2rka36chPtEOJlMF21EK89o3hcnXuImqM1q+
X-Google-Smtp-Source: ABdhPJxSw+wYUTUWP3Km74FvIx3hEM7c1WjHREy/387S7943dVd38eD8JvLxHnv6Huutxtls/ds/iw==
X-Received: by 2002:adf:f84d:0:b0:213:169f:28cb with SMTP id d13-20020adff84d000000b00213169f28cbmr3507146wrq.539.1654190436360;
        Thu, 02 Jun 2022 10:20:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h42-20020a05600c49aa00b003973d425a7fsm6229847wmp.41.2022.06.02.10.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 10:20:35 -0700 (PDT)
Message-Id: <pull.1237.v4.git.1654190434908.gitgitgadget@gmail.com>
In-Reply-To: <pull.1237.v3.git.1654046173.gitgitgadget@gmail.com>
References: <pull.1237.v3.git.1654046173.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Jun 2022 17:20:34 +0000
Subject: [PATCH v4] remote: create fetch.credentialsInUrl config
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

An earlier version of this change injected the logic into
url_normalize() in urlmatch.c. While most code paths that parse URLs
eventually normalize the URL, that normalization does not happen early
enough in the stack to avoid attempting connections to the URL first. By
inserting a check into the remote validation, we identify the issue
before making a connection. In the old code path, this was revealed by
testing the new t5601-clone.sh test under --stress, resulting in an
instance where the return code was 13 (SIGPIPE) instead of 128 from the
die().

However, we can reuse the parsing information from url_normalize() in
order to benefit from its well-worn parsing logic. We can use the struct
url_info that is created in that method to replace the password with
"<redacted>" in our error messages. This comes with a slight downside
that the normalized URL might look slightly different from the input URL
(for instance, the normalized version adds a closing slash). This should
not hinder users figuring out what the problem is and being able to fix
the issue.

As an attempt to ensure the parsing logic did not catch any
unintentional cases, I modified this change locally to to use the "die"
option by default. Running the test suite succeeds except for the
explicit username:password URLs used in t5550-http-fetch-dumb.sh and
t5541-http-push-smart.sh. This means that all other tested URLs did not
trigger this logic.

The tests show that the proper error messages appear (or do not
appear), but also count the number of error messages. When only warning,
each process validates the remote URL and outputs a warning. This
happens twice for clone, three times for fetch, and once for push.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    remote: create fetch.credentialsInUrl config
    
    Users can specify credentials in their URL using the
    username:password@domain format. This is potentially hazardous since the
    URL is stored in plaintext and can also appear in trace2 logs and other
    places. Add a new config option that allows warnings or failures when
    discovering URLs with this format. The default behavior does not change
    in this series, although we may want to move to the warn state by
    default in the future.
    
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
    
    
    Updates in v4
    =============
    
     * The warn_once() patch is dropped in favor of using a different
       location for the check (remotes_remote_get_1() instead of
       valid_remote()).
     * The parsing logic is removed in favor of using the output url_info
       from url_normalize().
     * Tests for 'fetch' and 'push' are added.
     * This requires updating the topic to be on a more-recent version of
       'master' because some change since the previous base caused 'git
       push' to output the warning only once, not twice.
    
    
    Updates in v3
    =============
    
     * Because of some flaky behavior around SIGPIPE, the URL check needed
       to move to be earlier in the command.
     * For this reason, I moved the cred check into remote.c's
       valid_remote() check. This changed the previous BUG() statements into
       early returns.
     * I repeated the check with the test suite to see if this parsing fails
       on any existing cases, but it is worth double-checking the parsing
       rules.
     * Documentation is more consistent about using placeholders.
     * A test for the "allow" case is now included.
     * A new patch is added that creates the warn_once() helper. This
       reduces multiple advisory warnings with the same text from being
       written by the same process.
    
    
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1237%2Fderrickstolee%2Fcreds-in-url-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1237/derrickstolee/creds-in-url-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1237

Range-diff vs v3:

 1:  083a918e9b1 ! 1:  5fb038402d6 remote: create fetch.credentialsInUrl config
     @@ Commit message
          instance where the return code was 13 (SIGPIPE) instead of 128 from the
          die().
      
     -    Since we are not deep within url_normalize(), we need to do our own
     -    parsing to detect if there is a "username:password@domain" section. We
     -    begin by detecting the first '@' symbol in the URL. We then detect if
     -    there is a scheme such as "https://" by finding the first slash. If that
     -    slash does not exist or is after the first '@' symbol, then we consider
     -    the scheme to be complete before the URL. Finally, we look for a colon
     -    between the scheme and the '@' symbol, indicating a "username:password"
     -    string. Replace the password with "<redacted>" when writing the error
     -    message.
     +    However, we can reuse the parsing information from url_normalize() in
     +    order to benefit from its well-worn parsing logic. We can use the struct
     +    url_info that is created in that method to replace the password with
     +    "<redacted>" in our error messages. This comes with a slight downside
     +    that the normalized URL might look slightly different from the input URL
     +    (for instance, the normalized version adds a closing slash). This should
     +    not hinder users figuring out what the problem is and being able to fix
     +    the issue.
      
          As an attempt to ensure the parsing logic did not catch any
          unintentional cases, I modified this change locally to to use the "die"
     @@ Commit message
          t5541-http-push-smart.sh. This means that all other tested URLs did not
          trigger this logic.
      
     +    The tests show that the proper error messages appear (or do not
     +    appear), but also count the number of error messages. When only warning,
     +    each process validates the remote URL and outputs a warning. This
     +    happens twice for clone, three times for fetch, and once for push.
     +
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## Documentation/config/fetch.txt ##
     @@ Documentation/config/fetch.txt: fetch.writeCommitGraph::
      +  with a plaintext credential.
      
       ## remote.c ##
     -@@ remote.c: struct counted_string {
     - 	const char *s;
     - };
     +@@
     + #include "cache.h"
     + #include "config.h"
     + #include "remote.h"
     ++#include "urlmatch.h"
     + #include "refs.h"
     + #include "refspec.h"
     + #include "object-store.h"
     +@@ remote.c: const char *remote_ref_for_branch(struct branch *branch, int for_push)
     + 	return NULL;
     + }
       
     -+/*
     -+ * Check if the given URL is of the following form:
     -+ *
     -+ *     scheme://username:password@domain[:port][/path]
     -+ *
     -+ * Specifically, see if the ":password@" section of the URL appears.
     -+ *
     -+ * The fetch.credentialsInUrl config indicates what to do on such a URL,
     -+ * either ignoring, warning, or erroring. The latter two modes write a
     -+ * redacted URL to stderr.
     -+ */
     -+static void check_if_creds_in_url(const char *url)
     ++static void validate_remote_url(struct remote *remote)
      +{
     -+	const char *value, *scheme_ptr, *colon_ptr, *at_ptr;
     ++	int i;
     ++	const char *value;
      +	struct strbuf redacted = STRBUF_INIT;
      +
     -+	/* "allow" is the default behavior. */
      +	if (git_config_get_string_tmp("fetch.credentialsinurl", &value) ||
      +	    !strcmp("allow", value))
      +		return;
      +
     -+	if (!(at_ptr = strchr(url, '@')))
     -+		return;
     ++	for (i = 0; i < remote->url_nr; i++) {
     ++		struct url_info url_info = { NULL };
     ++		url_normalize(remote->url[i], &url_info);
      +
     -+	if (!(scheme_ptr = strchr(url, '/')) ||
     -+	    scheme_ptr > at_ptr)
     -+		scheme_ptr = url;
     ++		if (!url_info.passwd_len)
     ++			goto loop_cleanup;
      +
     -+	if (!(colon_ptr = strchr(scheme_ptr, ':')))
     -+		return;
     ++		strbuf_add(&redacted, url_info.url, url_info.passwd_off);
     ++		strbuf_addstr(&redacted, "<redacted>");
     ++		strbuf_addstr(&redacted, url_info.url + url_info.passwd_off + url_info.passwd_len);
      +
     -+	/* Include the colon when creating the redacted URL. */
     -+	colon_ptr++;
     -+	strbuf_addstr(&redacted, url);
     -+	strbuf_splice(&redacted, colon_ptr - url, at_ptr - colon_ptr,
     -+		      "<redacted>", 10);
     ++		if (!strcmp("warn", value))
     ++			warning(_("URL '%s' uses plaintext credentials"), redacted.buf);
     ++		if (!strcmp("die", value))
     ++			die(_("URL '%s' uses plaintext credentials"), redacted.buf);
      +
     -+	if (!strcmp("warn", value))
     -+		warning(_("URL '%s' uses plaintext credentials"), redacted.buf);
     -+	if (!strcmp("die", value))
     -+		die(_("URL '%s' uses plaintext credentials"), redacted.buf);
     ++loop_cleanup:
     ++		free(url_info.url);
     ++	}
      +
      +	strbuf_release(&redacted);
      +}
      +
     - static int valid_remote(const struct remote *remote)
     - {
     -+	for (int i = 0; i < remote->url_nr; i++)
     -+		check_if_creds_in_url(remote->url[i]);
     + static struct remote *
     + remotes_remote_get_1(struct remote_state *remote_state, const char *name,
     + 		     const char *(*get_default)(struct remote_state *,
     +@@ remote.c: remotes_remote_get_1(struct remote_state *remote_state, const char *name,
     + 		add_url_alias(remote_state, ret, name);
     + 	if (!valid_remote(ret))
     + 		return NULL;
     ++
     ++	validate_remote_url(ret);
      +
     - 	return (!!remote->url) || (!!remote->foreign_vcs);
     + 	return ret;
       }
       
      
     + ## t/t5516-fetch-push.sh ##
     +@@ t/t5516-fetch-push.sh: This test checks the following functionality:
     + * --porcelain output format
     + * hiderefs
     + * reflogs
     ++* URL validation
     + '
     + 
     + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     +@@ t/t5516-fetch-push.sh: test_expect_success 'refuse to push a hidden ref, and make sure do not pollute t
     + 	test_dir_is_empty testrepo/.git/objects/pack
     + '
     + 
     ++test_expect_success 'fetch warns or fails when using username:password' '
     ++	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
     ++	test_must_fail git -c fetch.credentialsInUrl=allow fetch https://username:password@localhost 2>err &&
     ++	! grep "$message" err &&
     ++
     ++	test_must_fail git -c fetch.credentialsInUrl=warn fetch https://username:password@localhost 2>err &&
     ++	grep "warning: $message" err >warnings &&
     ++	test_line_count = 3 warnings &&
     ++
     ++	test_must_fail git -c fetch.credentialsInUrl=die fetch https://username:password@localhost 2>err &&
     ++	grep "fatal: $message" err >warnings &&
     ++	test_line_count = 1 warnings
     ++'
     ++
     ++
     ++test_expect_success 'push warns or fails when using username:password' '
     ++	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
     ++	test_must_fail git -c fetch.credentialsInUrl=allow push https://username:password@localhost 2>err &&
     ++	! grep "$message" err &&
     ++
     ++	test_must_fail git -c fetch.credentialsInUrl=warn push https://username:password@localhost 2>err &&
     ++	grep "warning: $message" err >warnings &&
     ++	test_must_fail git -c fetch.credentialsInUrl=die push https://username:password@localhost 2>err &&
     ++	grep "fatal: $message" err >warnings &&
     ++	test_line_count = 1 warnings
     ++'
     ++
     + test_done
     +
       ## t/t5601-clone.sh ##
      @@ t/t5601-clone.sh: test_expect_success 'clone respects GIT_WORK_TREE' '
       
       '
       
      +test_expect_success 'clone warns or fails when using username:password' '
     ++	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
      +	test_must_fail git -c fetch.credentialsInUrl=allow clone https://username:password@localhost attempt1 2>err &&
     -+	! grep "URL '\''https://username:<redacted>@localhost'\'' uses plaintext credentials" err &&
     -+	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username:password@localhost attempt1 2>err &&
     -+	grep "warning: URL '\''https://username:<redacted>@localhost'\'' uses plaintext credentials" err &&
     -+	test_must_fail git -c fetch.credentialsInUrl=die clone https://username:password@localhost attempt2 2>err &&
     -+	grep "fatal: URL '\''https://username:<redacted>@localhost'\'' uses plaintext credentials" err
     ++	! grep "$message" err &&
     ++
     ++	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username:password@localhost attempt2 2>err &&
     ++	grep "warning: $message" err >warnings &&
     ++	test_line_count = 2 warnings &&
     ++
     ++	test_must_fail git -c fetch.credentialsInUrl=die clone https://username:password@localhost attempt3 2>err &&
     ++	grep "fatal: $message" err >warnings &&
     ++	test_line_count = 1 warnings
      +'
      +
      +test_expect_success 'clone does not detect username:password when it is https://username@domain:port/' '
 2:  8e29ac807c6 < -:  ----------- usage: add warn_once() helper for repeated warnings


 Documentation/config/fetch.txt | 14 +++++++++++++
 remote.c                       | 37 ++++++++++++++++++++++++++++++++++
 t/t5516-fetch-push.sh          | 28 +++++++++++++++++++++++++
 t/t5601-clone.sh               | 19 +++++++++++++++++
 4 files changed, 98 insertions(+)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index cd65d236b43..0db7fe85bb8 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -96,3 +96,17 @@ fetch.writeCommitGraph::
 	merge and the write may take longer. Having an updated commit-graph
 	file helps performance of many Git commands, including `git merge-base`,
 	`git push -f`, and `git log --graph`. Defaults to false.
+
+fetch.credentialsInUrl::
+	A URL can contain plaintext credentials in the form
+	`<protocol>://<user>:<password>@<domain>/<path>`. Using such URLs
+	is not recommended as it exposes the password in multiple ways,
+	including Git storing the URL as plaintext in the repository config.
+	The `fetch.credentialsInUrl` option provides instruction for how Git
+	should react to seeing such a URL, with these values:
++
+* `allow` (default): Git will proceed with its activity without warning.
+* `warn`: Git will write a warning message to `stderr` when parsing a URL
+  with a plaintext credential.
+* `die`: Git will write a failure message to `stderr` when parsing a URL
+  with a plaintext credential.
diff --git a/remote.c b/remote.c
index 930fdc9c2f6..1f4a95e9840 100644
--- a/remote.c
+++ b/remote.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "remote.h"
+#include "urlmatch.h"
 #include "refs.h"
 #include "refspec.h"
 #include "object-store.h"
@@ -614,6 +615,39 @@ const char *remote_ref_for_branch(struct branch *branch, int for_push)
 	return NULL;
 }
 
+static void validate_remote_url(struct remote *remote)
+{
+	int i;
+	const char *value;
+	struct strbuf redacted = STRBUF_INIT;
+
+	if (git_config_get_string_tmp("fetch.credentialsinurl", &value) ||
+	    !strcmp("allow", value))
+		return;
+
+	for (i = 0; i < remote->url_nr; i++) {
+		struct url_info url_info = { NULL };
+		url_normalize(remote->url[i], &url_info);
+
+		if (!url_info.passwd_len)
+			goto loop_cleanup;
+
+		strbuf_add(&redacted, url_info.url, url_info.passwd_off);
+		strbuf_addstr(&redacted, "<redacted>");
+		strbuf_addstr(&redacted, url_info.url + url_info.passwd_off + url_info.passwd_len);
+
+		if (!strcmp("warn", value))
+			warning(_("URL '%s' uses plaintext credentials"), redacted.buf);
+		if (!strcmp("die", value))
+			die(_("URL '%s' uses plaintext credentials"), redacted.buf);
+
+loop_cleanup:
+		free(url_info.url);
+	}
+
+	strbuf_release(&redacted);
+}
+
 static struct remote *
 remotes_remote_get_1(struct remote_state *remote_state, const char *name,
 		     const char *(*get_default)(struct remote_state *,
@@ -639,6 +673,9 @@ remotes_remote_get_1(struct remote_state *remote_state, const char *name,
 		add_url_alias(remote_state, ret, name);
 	if (!valid_remote(ret))
 		return NULL;
+
+	validate_remote_url(ret);
+
 	return ret;
 }
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4dfb080433e..4497617db7f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -12,6 +12,7 @@ This test checks the following functionality:
 * --porcelain output format
 * hiderefs
 * reflogs
+* URL validation
 '
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
@@ -1813,4 +1814,31 @@ test_expect_success 'refuse to push a hidden ref, and make sure do not pollute t
 	test_dir_is_empty testrepo/.git/objects/pack
 '
 
+test_expect_success 'fetch warns or fails when using username:password' '
+	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
+	test_must_fail git -c fetch.credentialsInUrl=allow fetch https://username:password@localhost 2>err &&
+	! grep "$message" err &&
+
+	test_must_fail git -c fetch.credentialsInUrl=warn fetch https://username:password@localhost 2>err &&
+	grep "warning: $message" err >warnings &&
+	test_line_count = 3 warnings &&
+
+	test_must_fail git -c fetch.credentialsInUrl=die fetch https://username:password@localhost 2>err &&
+	grep "fatal: $message" err >warnings &&
+	test_line_count = 1 warnings
+'
+
+
+test_expect_success 'push warns or fails when using username:password' '
+	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
+	test_must_fail git -c fetch.credentialsInUrl=allow push https://username:password@localhost 2>err &&
+	! grep "$message" err &&
+
+	test_must_fail git -c fetch.credentialsInUrl=warn push https://username:password@localhost 2>err &&
+	grep "warning: $message" err >warnings &&
+	test_must_fail git -c fetch.credentialsInUrl=die push https://username:password@localhost 2>err &&
+	grep "fatal: $message" err >warnings &&
+	test_line_count = 1 warnings
+'
+
 test_done
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 4a61f2c901e..d03c19f5e07 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -71,6 +71,25 @@ test_expect_success 'clone respects GIT_WORK_TREE' '
 
 '
 
+test_expect_success 'clone warns or fails when using username:password' '
+	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
+	test_must_fail git -c fetch.credentialsInUrl=allow clone https://username:password@localhost attempt1 2>err &&
+	! grep "$message" err &&
+
+	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username:password@localhost attempt2 2>err &&
+	grep "warning: $message" err >warnings &&
+	test_line_count = 2 warnings &&
+
+	test_must_fail git -c fetch.credentialsInUrl=die clone https://username:password@localhost attempt3 2>err &&
+	grep "fatal: $message" err >warnings &&
+	test_line_count = 1 warnings
+'
+
+test_expect_success 'clone does not detect username:password when it is https://username@domain:port/' '
+	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username@localhost:8080 attempt3 2>err &&
+	! grep "uses plaintext credentials" err
+'
+
 test_expect_success 'clone from hooks' '
 
 	test_create_repo r0 &&

base-commit: 2668e3608e47494f2f10ef2b6e69f08a84816bcb
-- 
gitgitgadget
