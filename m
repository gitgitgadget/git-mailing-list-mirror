Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE953C7E19
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752442; cv=none; b=rayfrB2GY5FA67Tp+HLCseBYVsNHc1LZa/5fEE6bo4LlgMHWc0J93Z8dcW728g9t59PSwTaMFEUwBxLu66GvaIp5gc3ueEs9a5XwTwj/MeazFZrDiBosb7jgVrCeYxGul4zabaa1+z9kAcEOfk8tteVugYxUpiV4jQVWlBmvR9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752442; c=relaxed/simple;
	bh=3ZNdoQ/dbLjzyDDjAcydRuUomIZ2xI53LBxYbRFkYqM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NU59tQKcWrmNL2lxn7Z8kSMD9+n8GG+wRmLWQiSAaJZxS+pbmwYg51f/yN5qmxB7W/QhSPstF6tuh59lSKwgGDHtxU1m2ikk5Qa+/FIHobBObmrlNKhwyo/DAitQMJz3fMqJAnacMfF3nZjx6gntjlx4mtHAizB1PSuukMuvbpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQeKUXuu; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQeKUXuu"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cb5c9ba82bso822248585a.2
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 06:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773752438; x=1774357238; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7u/EyKOMQMnlKMuuF49K9e3XdenhmIw1GBvGPtrzvSk=;
        b=mQeKUXuuvkd3GqRnrGPKBk9wIfs+iIUlqDL5XkvJLDrMV3N7SuqT90x3QyuIVLvlxu
         p5mBpOYxbKpZI61n+kNJzuOYNFT6EkjRLdbKIZr27eUsl2C1U1mhVwXDMVI+3mZ3TL/p
         1++zrb/WvWK8mTEookVmOPVdvs8Xmui0+hO287+/aAhtXXHBrmz1+H77kNDySeBefuTy
         Mq3dOkn/0M/EkH19uNBrf8SFEWRMLOEF+702UPuI9LJdM5dSB0ZOzNPnCRioLskB0BiE
         UveEQiB1sQR1H3goq06IN2QCJsvDz1gtMvRQh3xYOXq2UcasMBuh4btsUJ8uignwCG69
         cjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773752438; x=1774357238;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7u/EyKOMQMnlKMuuF49K9e3XdenhmIw1GBvGPtrzvSk=;
        b=JO/Xuxtq7+8fyjoKf7ylQ56m1/BM9/tX44lTmcgSPypoM1/JXQ1mjlt6mbUZ76ycIa
         yYUqef6cyuUESePLmkjyzNYSi/UmBk/5ATt057QBYux10f9M5Vd3qw6eUrWjkdg9Cca7
         Q+oBJUoC0QGNXINq7upUSiBcTB6DMx5P8buNJ16kvD77QmBYJJdDdXeqPUzCfmZQ7Nl8
         IHugQ9dpCx2ChfAnmuRnSVxDXdJw4EUJbkT1ILVc1zgDgcsduDSl11YsZneKoDx6S3Fe
         bXadKRO0IO0FoGAsuXN8Zu5jJmXZ6uMfRWoecIKcktQnVk1y6vO/RxOP2X43EQ8vfTFT
         Dq6A==
X-Gm-Message-State: AOJu0YwM3Z5pRJOouECDrfhbZQtULaKYkjXeOG+1o+nWTORgbUJGCG8q
	TRtJL7qGFlD03FLckRx+mNFkavfFtZcSedddTPHKIdChVHjXo6suhshd69e8AA==
X-Gm-Gg: ATEYQzzNrHGyu/6LY9xamWJ/CjKchn8XJnmfz+BJTEh9D9UDKU9pFPCx4ZjV8PLc7BU
	rMTUSB37n1KsJkJphO6U0CCXZIwY25Qjmp2qSWcQR+9Hej5zn20JTh93m5C5xkLrEsgdfqj89hS
	dA8U/7a0Xqlh4Saj8fjWOnx+nkBzWGEFKjjyKB0tGZ/ehitjqmSY9dqWJGslWIUPb/mR9U6g5d/
	ZOZfYvIJbQWhQec+FWhg3JJAra4BLq4I6a6jWTniutuzfDpQUk0oZMo8M8PpJAt4JLZ0Op6HWZ7
	JT9sXLkBA8/CDslLggJQL/8eVP4fpWAhL3xhBWmc15MAXW6rxz87y97VwP4sT1LUQXcRWCbf9sp
	VGTFB6pZYnDSwJgTW2JJdyDv52mMEXI9F7szYX/QeivfftLhYlb6HmexG/mfZWuAmH0/omBl0Ku
	wCUU+k+TuXMpByucROcnld/7w=
X-Received: by 2002:a05:6214:194f:b0:89a:8be:9d44 with SMTP id 6a1803df08f44-89a81f60cb9mr241198566d6.43.1773752437566;
        Tue, 17 Mar 2026 06:00:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.23.161])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c5246e77asm42963746d6.27.2026.03.17.06.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:00:36 -0700 (PDT)
Message-Id: <pull.2008.v6.git.1773752435.gitgitgadget@gmail.com>
In-Reply-To: <pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
References: <pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
From: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 13:00:32 +0000
Subject: [PATCH v6 0/3] http: add support for HTTP 429 rate limit retries
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,
    Jeff King <peff@peff.net>,
    Junio C Hamano <gitster@pobox.com>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>

Changes since v5:

 * drop show_http_message_fatal() preparation patch
 * drop fwrite_headers, restore fwrite_wwwauth
 * move CURLINFO_RETRY_AFTER from finish_active_slot to http_request
 * move retry_after=-1 init from run_one_slot to http_request
 * replace retry_after_out param with http_get_options field
 * fix loop counter: separate REAUTH and RATE_LIMITED counters
 * fix racy -lt 2 timing bounds in tests

Changes since v4:

 * fix only strbuf_attach() calls which don't need reallocation
 * remove patch, which enforces strbuf_attach() contract via BUG()

Changes since v3:

 * Clean up of all strbuf_attach() call sites

 * Add strbuf_attach() contract enforcement via BUG()

Changes since v2:

 * New preparatory patch: Introduced show_http_message_fatal() helper
   function to reduce code duplication in remote-curl.c (suggested by Taylor
   Blau)

 * Removed specific HTTP_RATE_LIMITED error handling from http-push.c and
   http-walker.c for the obsolete "dumb" protocol, allowing generic error
   handling to take over (suggested by Jeff King)

 * Added support for CURLINFO_RETRY_AFTER on curl >= 7.66.0, falling back to
   manual header parsing on older versions

 * Simplified retry/delay architecture: replaced complex non-blocking
   "delayed slot" mechanism with simple blocking sleep() call in the retry
   loop, removing ~66 lines of timing logic (suggested by Jeff King)

 * Fixed Retry-After: 0 handling to allow immediate retry as specified by
   RFC 9110

 * Changed http.retryAfter default from -1 to 0, so Git will retry
   immediately when encountering HTTP 429 without a Retry-After header,
   rather than failing with a configuration error

 * Improved error messages: shortened to be more concise

 * Fixed coding style issues: removed unnecessary curly braces, changed x ==
   0 to !x (per CodingGuidelines)

 * Improved test portability: replaced non-portable date(1) commands with
   test-tool date, added nanosecond-precision timing with getnanos, replaced
   cut(1) with POSIX shell parameter expansion

 * Split out strbuf.c bugfix into separate preparatory patch (the
   strbuf_reencode alloc size fix is unrelated to HTTP 429 support)

 * Squashed separate trace2 logging patch into main HTTP 429 retry support
   commit

 * Kept header_is_last_match assignment for Retry-After to prevent incorrect
   handling of HTTP header continuation lines

The implementation includes:

 1. A bug fix in strbuf_reencode() that corrects the allocation size passed
    to strbuf_attach(), passing len+1 instead of len so that the existing
    buffer is reused rather than immediately reallocated.

 2. A cleanup of strbuf_attach() call sites that were passing alloc == len,
    leaving no room for the NUL terminator. Sites with a
    known-NUL-terminated buffer now pass len+1; sites where the source
    buffer has no trailing NUL (ll_merge output) are converted to use
    strbuf_add() instead.

 3. The main feature: HTTP 429 retry logic with support for the Retry-After
    header (both delay-seconds and HTTP-date formats), configurable via
    http.maxRetries, http.retryAfter, and http.maxRetryTime options. If any
    computed delay exceeds maxRetryTime the request fails immediately with a
    clear diagnostic rather than capping and retrying silently.

Vaidas Pilkauskas (3):
  strbuf: pass correct alloc to strbuf_attach() in strbuf_reencode()
  strbuf_attach: fix call sites to pass correct alloc
  http: add support for HTTP 429 rate limit retries

 Documentation/config/http.adoc |  26 ++++
 builtin/am.c                   |   2 +-
 builtin/fast-import.c          |   2 +-
 git-curl-compat.h              |   8 +
 http.c                         | 144 +++++++++++++++---
 http.h                         |   9 ++
 mailinfo.c                     |   2 +-
 refs/files-backend.c           |   2 +-
 remote-curl.c                  |  11 ++
 strbuf.c                       |   2 +-
 t/lib-httpd.sh                 |   1 +
 t/lib-httpd/apache.conf        |   8 +
 t/lib-httpd/http-429.sh        |  98 ++++++++++++
 t/meson.build                  |   1 +
 t/t5584-http-429-retry.sh      | 266 +++++++++++++++++++++++++++++++++
 trailer.c                      |   2 +-
 16 files changed, 557 insertions(+), 27 deletions(-)
 create mode 100644 t/lib-httpd/http-429.sh
 create mode 100755 t/t5584-http-429-retry.sh


base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2008%2Fvaidas-shopify%2Fretry-after-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2008/vaidas-shopify/retry-after-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/2008

Range-diff vs v5:

 1:  7ec2d66447 = 1:  6e76be1d85 strbuf: pass correct alloc to strbuf_attach() in strbuf_reencode()
 2:  3e0b78cfb6 = 2:  0dc214d3c2 strbuf_attach: fix call sites to pass correct alloc
 3:  973703e9dd < -:  ---------- remote-curl: introduce show_http_message_fatal() helper
 4:  bfee1f10c0 ! 3:  3418f4553d http: add support for HTTP 429 rate limit retries
     @@ Documentation/config/http.adoc: http.keepAliveCount::
      +	Default wait time in seconds before retrying when a server returns
      +	HTTP 429 (Too Many Requests) without a Retry-After header.
      +	Defaults to 0 (retry immediately). When a Retry-After header is
     -+	present, its value takes precedence over this setting. Can be
     -+	overridden by the `GIT_HTTP_RETRY_AFTER` environment variable.
     ++	present, its value takes precedence over this setting; however,
     ++	automatic use of the server-provided `Retry-After` header requires
     ++	libcurl 7.66.0 or later. On older versions, configure this setting
     ++	manually to control the retry delay. Can be overridden by the
     ++	`GIT_HTTP_RETRY_AFTER` environment variable.
      +	See also `http.maxRetries` and `http.maxRetryTime`.
      +
      +http.maxRetries::
     @@ http.c: static inline int is_hdr_continuation(const char *ptr, const size_t size
       }
       
      -static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p UNUSED)
     -+static size_t fwrite_headers(char *ptr, size_t eltsize, size_t nmemb, void *p MAYBE_UNUSED)
     ++static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p MAYBE_UNUSED)
       {
       	size_t size = eltsize * nmemb;
       	struct strvec *values = &http_auth.wwwauth_headers;
     -@@ http.c: static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p UN
     - 		goto exit;
     - 	}
     - 
     -+#ifndef GIT_CURL_HAVE_CURLINFO_RETRY_AFTER
     -+	/* Parse Retry-After header for rate limiting (for curl < 7.66.0) */
     -+	if (skip_iprefix_mem(ptr, size, "retry-after:", &val, &val_len)) {
     -+		struct active_request_slot *slot = (struct active_request_slot *)p;
     -+
     -+		strbuf_add(&buf, val, val_len);
     -+		strbuf_trim(&buf);
     -+
     -+		if (slot && slot->results) {
     -+			/* Parse the retry-after value (delay-seconds or HTTP-date) */
     -+			char *endptr;
     -+			long retry_after;
     -+
     -+			errno = 0;
     -+			retry_after = strtol(buf.buf, &endptr, 10);
     -+
     -+		/* Check if it's a valid integer (delay-seconds format) */
     -+		if (endptr != buf.buf && *endptr == '\0' &&
     -+		    errno != ERANGE && retry_after >= 0) {
     -+			slot->results->retry_after = retry_after;
     -+		} else {
     -+				/* Try parsing as HTTP-date format */
     -+				timestamp_t timestamp;
     -+				int offset;
     -+				if (!parse_date_basic(buf.buf, &timestamp, &offset)) {
     -+					/* Successfully parsed as date, calculate delay from now */
     -+					timestamp_t now = time(NULL);
     -+					if (timestamp > now) {
     -+						slot->results->retry_after = (long)(timestamp - now);
     -+					} else {
     -+						/* Past date means retry immediately */
     -+						slot->results->retry_after = 0;
     -+					}
     -+				} else {
     -+					/* Failed to parse as either delay-seconds or HTTP-date */
     -+					warning(_("unable to parse Retry-After header value: '%s'"), buf.buf);
     -+				}
     -+			}
     -+		}
     -+
     -+		goto exit;
     -+	}
     -+#endif
     -+
     - 	/*
     - 	 * This line could be a continuation of the previously matched header
     - 	 * field. If this is the case then we should append this value to the
     -@@ http.c: static void finish_active_slot(struct active_request_slot *slot)
     - 
     - 		curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CONNECTCODE,
     - 			&slot->results->http_connectcode);
     -+
     -+#ifdef GIT_CURL_HAVE_CURLINFO_RETRY_AFTER
     -+		if (slot->results->http_code == 429) {
     -+			curl_off_t retry_after;
     -+			CURLcode res = curl_easy_getinfo(slot->curl,
     -+							  CURLINFO_RETRY_AFTER,
     -+							  &retry_after);
     -+			if (res == CURLE_OK && retry_after > 0)
     -+				slot->results->retry_after = (long)retry_after;
     -+		}
     -+#endif
     - 	}
     - 
     - 	/* Run callback if appropriate */
      @@ http.c: static int http_options(const char *var, const char *value,
       		return 0;
       	}
     @@ http.c: int run_one_slot(struct active_request_slot *slot,
       		 struct slot_results *results)
       {
       	slot->results = results;
     -+	/* Initialize retry_after to -1 (not set) */
     -+	results->retry_after = -1;
      +
       	if (!start_active_slot(slot)) {
       		xsnprintf(curl_errorstr, sizeof(curl_errorstr),
     @@ http.c: static void http_opt_request_remainder(CURL *curl, off_t pos)
       static int http_request(const char *url,
       			void *result, int target,
      -			const struct http_get_options *options)
     -+			const struct http_get_options *options,
     -+			long *retry_after_out)
     ++			struct http_get_options *options)
       {
       	struct active_request_slot *slot;
     - 	struct slot_results results;
     +-	struct slot_results results;
     ++	struct slot_results results = { .retry_after = -1 };
     + 	struct curl_slist *headers = http_copy_default_headers();
     + 	struct strbuf buf = STRBUF_INIT;
     + 	const char *accept_language;
      @@ http.c: static int http_request(const char *url,
     - 					 fwrite_buffer);
     - 	}
     + 		headers = curl_slist_append(headers, accept_language);
       
     --	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_wwwauth);
     -+	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_headers);
     -+	curl_easy_setopt(slot->curl, CURLOPT_HEADERDATA, slot);
     + 	strbuf_addstr(&buf, "Pragma:");
     +-	if (options && options->no_cache)
     ++	if (options->no_cache)
     + 		strbuf_addstr(&buf, " no-cache");
     +-	if (options && options->initial_request &&
     ++	if (options->initial_request &&
     + 	    http_follow_config == HTTP_FOLLOW_INITIAL)
     + 		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1L);
       
     - 	accept_language = http_get_accept_language_header();
     + 	headers = curl_slist_append(headers, buf.buf);
       
     + 	/* Add additional headers here */
     +-	if (options && options->extra_headers) {
     ++	if (options->extra_headers) {
     + 		const struct string_list_item *item;
     +-		if (options && options->extra_headers) {
     +-			for_each_string_list_item(item, options->extra_headers) {
     +-				headers = curl_slist_append(headers, item->string);
     +-			}
     +-		}
     ++		for_each_string_list_item(item, options->extra_headers)
     ++			headers = curl_slist_append(headers, item->string);
     + 	}
     + 
     + 	headers = http_append_auth_header(&http_auth, headers);
      @@ http.c: static int http_request(const char *url,
       
       	ret = run_one_slot(slot, &results);
       
     -+	/* Store retry_after from slot results if output parameter provided */
     -+	if (retry_after_out)
     -+		*retry_after_out = results.retry_after;
     +-	if (options && options->content_type) {
     ++#ifdef GIT_CURL_HAVE_CURLINFO_RETRY_AFTER
     ++	if (ret == HTTP_RATE_LIMITED) {
     ++		curl_off_t retry_after;
     ++		if (curl_easy_getinfo(slot->curl, CURLINFO_RETRY_AFTER,
     ++				      &retry_after) == CURLE_OK && retry_after > 0)
     ++			results.retry_after = (long)retry_after;
     ++	}
     ++#endif
     ++
     ++	options->retry_after = results.retry_after;
      +
     - 	if (options && options->content_type) {
     ++	if (options->content_type) {
       		struct strbuf raw = STRBUF_INIT;
       		curlinfo_strbuf(slot->curl, CURLINFO_CONTENT_TYPE, &raw);
     + 		extract_content_type(&raw, options->content_type,
     +@@ http.c: static int http_request(const char *url,
     + 		strbuf_release(&raw);
     + 	}
     + 
     +-	if (options && options->effective_url)
     ++	if (options->effective_url)
     + 		curlinfo_strbuf(slot->curl, CURLINFO_EFFECTIVE_URL,
     + 				options->effective_url);
     + 
      @@ http.c: static int update_url_from_redirect(struct strbuf *base,
       	return 1;
       }
       
      -static int http_request_reauth(const char *url,
      +/*
     -+ * Handle rate limiting retry logic for HTTP 429 responses.
     -+ * Returns a negative value if retries are exhausted or configuration is invalid,
     -+ * otherwise returns the delay value (>= 0) to indicate the retry should proceed.
     ++ * Compute the retry delay for an HTTP 429 response.
     ++ * Returns a negative value if configuration is invalid (delay exceeds
     ++ * http.maxRetryTime), otherwise returns the delay in seconds (>= 0).
      + */
     -+static long handle_rate_limit_retry(int *rate_limit_retries, long slot_retry_after)
     ++static long handle_rate_limit_retry(long slot_retry_after)
      +{
     -+	int retry_attempt = http_max_retries - *rate_limit_retries + 1;
     -+
     -+	trace2_data_intmax("http", the_repository, "http/429-retry-attempt",
     -+		retry_attempt);
     -+
     -+	if (*rate_limit_retries <= 0) {
     -+		/* Retries are disabled or exhausted */
     -+		if (http_max_retries > 0) {
     -+			error(_("too many rate limit retries, giving up"));
     -+			trace2_data_string("http", the_repository,
     -+					   "http/429-error", "retries-exhausted");
     -+		}
     -+		return -1;
     -+	}
     -+
     -+	(*rate_limit_retries)--;
     -+
      +	/* Use the slot-specific retry_after value or configured default */
      +	if (slot_retry_after >= 0) {
      +		/* Check if retry delay exceeds maximum allowed */
     @@ http.c: static int update_url_from_redirect(struct strbuf *base,
       			       void *result, int target,
       			       struct http_get_options *options)
       {
     ++	static struct http_get_options empty_opts;
       	int i = 3;
       	int ret;
      +	int rate_limit_retries = http_max_retries;
     -+	long slot_retry_after = -1; /* Per-slot retry_after value */
     ++
     ++	if (!options)
     ++		options = &empty_opts;
       
       	if (always_auth_proactively())
       		credential_fill(the_repository, &http_auth, 1);
       
     --	ret = http_request(url, result, target, options);
     -+	ret = http_request(url, result, target, options, &slot_retry_after);
     + 	ret = http_request(url, result, target, options);
       
      -	if (ret != HTTP_OK && ret != HTTP_REAUTH)
      +	if (ret != HTTP_OK && ret != HTTP_REAUTH && ret != HTTP_RATE_LIMITED)
       		return ret;
       
     +-	if (options && options->effective_url && options->base_url) {
      +	/* If retries are disabled and we got a 429, fail immediately */
      +	if (ret == HTTP_RATE_LIMITED && !http_max_retries)
      +		return HTTP_ERROR;
      +
     - 	if (options && options->effective_url && options->base_url) {
     ++	if (options->effective_url && options->base_url) {
       		if (update_url_from_redirect(options->base_url,
       					     url, options->effective_url)) {
     + 			credential_from_url(&http_auth, options->base_url->buf);
      @@ http.c: static int http_request_reauth(const char *url,
       		}
       	}
       
      -	while (ret == HTTP_REAUTH && --i) {
     -+	while ((ret == HTTP_REAUTH || ret == HTTP_RATE_LIMITED) && --i) {
     ++	while ((ret == HTTP_REAUTH && --i) ||
     ++	       (ret == HTTP_RATE_LIMITED && --rate_limit_retries)) {
      +		long retry_delay = -1;
       		/*
       		 * The previous request may have put cruft into our output stream; we
     @@ http.c: static int http_request_reauth(const char *url,
       		default:
       			BUG("Unknown http_request target");
       		}
     +-
     +-		credential_fill(the_repository, &http_auth, 1);
      +		if (ret == HTTP_RATE_LIMITED) {
     -+			retry_delay = handle_rate_limit_retry(&rate_limit_retries, slot_retry_after);
     ++			retry_delay = handle_rate_limit_retry(options->retry_after);
      +			if (retry_delay < 0)
      +				return HTTP_ERROR;
      +
     @@ http.c: static int http_request_reauth(const char *url,
      +						   "http/retry-sleep-seconds", retry_delay);
      +				sleep(retry_delay);
      +			}
     -+			slot_retry_after = -1; /* Reset after use */
      +		} else if (ret == HTTP_REAUTH) {
      +			credential_fill(the_repository, &http_auth, 1);
      +		}
       
     --		credential_fill(the_repository, &http_auth, 1);
     --
     --		ret = http_request(url, result, target, options);
     -+		ret = http_request(url, result, target, options, &slot_retry_after);
     + 		ret = http_request(url, result, target, options);
       	}
     ++	if (ret == HTTP_RATE_LIMITED) {
     ++		trace2_data_string("http", the_repository,
     ++				   "http/429-error", "retries-exhausted");
     ++		return HTTP_RATE_LIMITED;
     ++	}
       	return ret;
       }
     + 
      @@ http.c: int http_get_strbuf(const char *url,
       		    struct strbuf *result,
       		    struct http_get_options *options)
     @@ http.h: struct slot_results {
       };
       
       struct active_request_slot {
     +@@ http.h: struct http_get_options {
     + 	 * request has completed.
     + 	 */
     + 	struct string_list *extra_headers;
     ++
     ++	/*
     ++	 * After a request completes, contains the Retry-After delay in seconds
     ++	 * if the server returned HTTP 429 with a Retry-After header (requires
     ++	 * libcurl 7.66.0 or later), or -1 if no such header was present.
     ++	 */
     ++	long retry_after;
     + };
     + 
     + /* Return values for http_get_*() */
      @@ http.h: struct http_get_options {
       #define HTTP_REAUTH	4
       #define HTTP_NOAUTH	5
     @@ http.h: struct http_get_options {
      
       ## remote-curl.c ##
      @@ remote-curl.c: static struct discovery *discover_refs(const char *service, int for_push)
     - 		show_http_message_fatal(&type, &charset, &buffer,
     - 					_("unable to access '%s' with http.pinnedPubkey configuration: %s"),
     - 					transport_anonymize_url(url.buf), curl_errorstr);
     + 		show_http_message(&type, &charset, &buffer);
     + 		die(_("unable to access '%s' with http.pinnedPubkey configuration: %s"),
     + 		    transport_anonymize_url(url.buf), curl_errorstr);
      +	case HTTP_RATE_LIMITED:
     -+		show_http_message_fatal(&type, &charset, &buffer,
     -+					_("rate limited by '%s', please try again later"),
     -+					transport_anonymize_url(url.buf));
     ++		if (http_options.retry_after > 0) {
     ++			show_http_message(&type, &charset, &buffer);
     ++			die(_("rate limited by '%s', please try again in %ld seconds"),
     ++				transport_anonymize_url(url.buf),
     ++				http_options.retry_after);
     ++		} else {
     ++			show_http_message(&type, &charset, &buffer);
     ++			die(_("rate limited by '%s', please try again later"),
     ++				transport_anonymize_url(url.buf));
     ++		}
       	default:
     - 		show_http_message_fatal(&type, &charset, &buffer,
     - 					_("unable to access '%s': %s"),
     + 		show_http_message(&type, &charset, &buffer);
     + 		die(_("unable to access '%s': %s"),
      
       ## t/lib-httpd.sh ##
      @@ t/lib-httpd.sh: prepare_httpd() {
     @@ t/t5584-http-429-retry.sh (new)
      +	test_must_fail git ls-remote "$HTTPD_URL/http_429/retry-after-exceeds-max-time/100/repo.git" 2>err &&
      +	duration=$(test-tool date getnanos $start) &&
      +
     -+	# Should fail quickly (less than 2 seconds, no 100 second wait)
     ++	# Should fail quickly (no 100 second wait)
      +	duration_int=${duration%.*} &&
     -+	test "$duration_int" -lt 2 &&
     ++	test "$duration_int" -lt 99 &&
      +	test_grep "greater than http.maxRetryTime" err
      +'
      +
     @@ t/t5584-http-429-retry.sh (new)
      +	test_must_fail git ls-remote "$HTTPD_URL/http_429/config-retry-after-exceeds-max-time/none/repo.git" 2>err &&
      +	duration=$(test-tool date getnanos $start) &&
      +
     -+	# Should fail quickly
     ++	# Should fail quickly (no 100 second wait)
      +	duration_int=${duration%.*} &&
     -+	test "$duration_int" -lt 2 &&
     ++	test "$duration_int" -lt 99 &&
      +	test_grep "configured http.retryAfter.*exceeds.*http.maxRetryTime" err
      +'
      +
     @@ t/t5584-http-429-retry.sh (new)
      +
      +	# Should fail quickly (not wait 200 seconds)
      +	duration_int=${duration%.*} &&
     -+	test "$duration_int" -lt 2 &&
     ++	test "$duration_int" -lt 199 &&
      +	test_grep "http.maxRetryTime" err
      +'
      +
     @@ t/t5584-http-429-retry.sh (new)
      +	git ls-remote "$HTTPD_URL/http_429/past-http-date/$past_date_encoded/repo.git" >output 2>err &&
      +	duration=$(test-tool date getnanos $start) &&
      +
     -+	# Should complete quickly (less than 2 seconds)
     ++	# Should complete quickly (no wait for a past-date Retry-After)
      +	duration_int=${duration%.*} &&
     -+	test "$duration_int" -lt 2 &&
     ++	test "$duration_int" -lt 5 &&
      +	test_grep "refs/heads/" output
      +'
      +
     @@ t/t5584-http-429-retry.sh (new)
      +
      +	# Should fail quickly (not wait 50 seconds) because env var limits to 10
      +	duration_int=${duration%.*} &&
     -+	test "$duration_int" -lt 5 &&
     ++	test "$duration_int" -lt 49 &&
      +	test_grep "greater than http.maxRetryTime" err
      +'
      +

-- 
gitgitgadget
