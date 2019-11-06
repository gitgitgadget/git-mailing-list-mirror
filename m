Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1701F454
	for <e@80x24.org>; Wed,  6 Nov 2019 10:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfKFKE7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 05:04:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34008 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbfKFKE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 05:04:59 -0500
Received: by mail-wr1-f68.google.com with SMTP id e6so23132203wrw.1
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 02:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=llvxO2pfFZ9fa1+QpoIEOg/MLtCYspW/OAK4VC+bDq8=;
        b=IqovAKiAUjPZUif8ghksp9icAZ2s6fjNXQQEg8Pu9QWfUOVYU/tanmR5eoJNZHNoM4
         +rwEBe7uJipEp8OzVmN7L3+SBLYEdW39laBJX+walWZ+MBYr296BBEvoMVhde543b44z
         MPHJ/P5I6TF9iiyYTgE7HcHT3jfhoDpw5yyJUTza4+YiAj26h9+SN4GNSmOltFQETAaY
         lNiJnO15qaFlr7qTo/hTrHd4isg4smedVbd52kSfC9a34NuVFJGhY5ru/GnXmXw6iRUW
         PyGlnGB2u0Xke9R1jNe3cfhTScbVhRejF2bHPJSZmJemkK/mgxYZe7b0YlHivl+T0jmg
         3t/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=llvxO2pfFZ9fa1+QpoIEOg/MLtCYspW/OAK4VC+bDq8=;
        b=TYAO6LyzTJCNXJhKIr8oeERlufXeyoapwVGEpGrqHLkSyeIdUeDM5J7D5gQJPtNvkD
         fjrVtMw7Rp25W3zV9zEuG2WmtCSehObGm6xJ2Z6JFjwossRFtpFNz8E4NVTMH+91rDz2
         b4GVMTlgPG2c8lkYW8FT0+CuqxR/gw3kKdTN0EFUMBQUetbmb++m4tSJQCSphoSpcgFC
         43ZeTMe9teU1TncL1jv2fKmrPxfXNnRcRs84Aej7HyF896qt9ciV9K7wS76i80ymie5p
         DXjTjzKVtxCp8eTtRDbORuSLj2FDIeyndarOVgFMdbcYT1BLmQX6fDp3bvvI+4lI8pfj
         b+0w==
X-Gm-Message-State: APjAAAXNM/nqL1ffTJUU8oe9GAq0fnmGwg1VYh9GY572wANwjZXTLzV9
        ljXRKtXZAIwk+BNQvezIoYOiJ/gY
X-Google-Smtp-Source: APXvYqzIENhtc9o1ZThDhrTMdtTnG6t9QNOiD92+FQRjxXhmzVEjtNGb/6nrwGEozdqbVTc8hStJ8Q==
X-Received: by 2002:adf:db92:: with SMTP id u18mr1768979wri.1.1573034696073;
        Wed, 06 Nov 2019 02:04:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y17sm1475646wrs.58.2019.11.06.02.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 02:04:55 -0800 (PST)
Message-Id: <pull.453.v2.git.1573034695.gitgitgadget@gmail.com>
In-Reply-To: <pull.453.git.1572991158.gitgitgadget@gmail.com>
References: <pull.453.git.1572991158.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 10:04:54 +0000
Subject: [PATCH v2 0/1] remote-curl: unbreak http.extraHeader with custom allocators
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is one of those bugs that can cost entire days of work.

The symptom of this bug is that git -c http.extraheader push ... will fail
frequently in Git for Windows v2.24.0, but not always. When it fails,
though, it will cause a segmentation fault in git remote-https while calling 
http_cleanup() and leave no visual indication of that problem, the only
indication of a problem will be the exit code of the caller (in this
instance, git push will fail with exit code 1).

In my tests during the pre-release period, I pushed many a time, it probably
failed a lot, in the way indicated above, and due to the absence of any
error message, I failed to realize that there was a problem in the first
place.

Fun side note: this bug haunted me for the best part of this past Monday,
when I tried to get Git for Windows v2.24.0 out the door. Large parts of Git
for Windows' release management are scripted, and that script failed,
claiming to have been unsuccessful in pushing the tag v2.24.0.windows.1,
just after printing a message to the extent that the tag is already up to
date (except in the first attempt, when it reported to have been successful
in pushing the tag). My attempts to fix the release script were doomed to
fail because the root cause was not a bug in the script, but the bug fixed
in this patch.

Changes since v1:

 * The patch was completely redone: instead of moving the call to 
   curl_global_init() (which would have broken support for http.sslbackend),
   this iteration instead replaces the usage of cURL's slist in the config
   handling by using Git's own string_list.

Johannes Schindelin (1):
  remote-curl: unbreak http.extraHeader with custom allocators

 http.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)


base-commit: 93b980e58f5624ee4e3b2dc0d0babaa97ef66d19
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-453%2Fdscho%2Ffix-curl-xmalloc-regression-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-453/dscho/fix-curl-xmalloc-regression-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/453

Range-diff vs v1:

 1:  d47a2aa594 ! 1:  3168ba2c9e remote-curl: unbreak http.extraHeader with custom allocators
     @@ -15,8 +15,18 @@
          presence of custom allocators, cURL would attempt to use the wrong
          allocator to release the memory.
      
     -    Let's fix this by moving the initialization _before_ the
     -    `http_options()` function is called.
     +    A naïve attempt at fixing this would move the call to
     +    `curl_global_init()` _before_ the config is parsed (i.e. before that
     +    call to `slist_append()`).
     +
     +    However, that does work, as we _also_ parse the config setting
     +    `http.sslbackend` and if found, call `curl_global_sslset()` which *must*
     +    be called before `curl_global_init()`, for details see:
     +    https://curl.haxx.se/libcurl/c/curl_global_sslset.html
     +
     +    So let's instead make the config parsing entirely independent from
     +    cURL's data structures. Incidentally, this deletes two more lines than
     +    it introduces, which is nice.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ -24,22 +34,50 @@
       --- a/http.c
       +++ b/http.c
      @@
     - 	char *normalized_url;
     - 	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
     - 
     -+	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
     -+		die("curl_global_init failed");
     -+
     - 	config.section = "http";
     - 	config.key = NULL;
     - 	config.collect_fn = http_options;
     + 
     + static struct curl_slist *pragma_header;
     + static struct curl_slist *no_pragma_header;
     +-static struct curl_slist *extra_http_headers;
     ++static struct string_list extra_http_headers = STRING_LIST_INIT_DUP;
     + 
     + static struct active_request_slot *active_queue_head;
     + 
      @@
     + 		if (!value) {
     + 			return config_error_nonbool(var);
     + 		} else if (!*value) {
     +-			curl_slist_free_all(extra_http_headers);
     +-			extra_http_headers = NULL;
     ++			string_list_clear(&extra_http_headers, 0);
     + 		} else {
     +-			extra_http_headers =
     +-				curl_slist_append(extra_http_headers, value);
     ++			string_list_append(&extra_http_headers, value);
     + 		}
     + 		return 0;
       	}
     +@@
       #endif
     + 	curl_global_cleanup();
     + 
     +-	curl_slist_free_all(extra_http_headers);
     +-	extra_http_headers = NULL;
     ++	string_list_clear(&extra_http_headers, 0);
     + 
     + 	curl_slist_free_all(pragma_header);
     + 	pragma_header = NULL;
     +@@
     + 
     + struct curl_slist *http_copy_default_headers(void)
     + {
     +-	struct curl_slist *headers = NULL, *h;
     ++	struct curl_slist *headers = NULL;
     ++	const struct string_list_item *item;
       
     --	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
     --		die("curl_global_init failed");
     --
     - 	http_proactive_auth = proactive_auth;
     +-	for (h = extra_http_headers; h; h = h->next)
     +-		headers = curl_slist_append(headers, h->data);
     ++	for_each_string_list_item(item, &extra_http_headers)
     ++		headers = curl_slist_append(headers, item->string);
       
     - 	if (remote && remote->http_proxy)
     + 	return headers;
     + }

-- 
gitgitgadget
