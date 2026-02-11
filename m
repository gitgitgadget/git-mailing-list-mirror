Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0D013B7AE
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 01:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770771936; cv=none; b=tzEf61iKsnnb5EhAYFIihTv21LlA0yy1S/CnHkzEcxFHSLWSbv+3uRRc5Hl6foLasHYjhGXPPoDZsisWdZeMPb+3XnjeMKqn+OeUg6rrgUTWay6OcMlTUTu/nG7T+6i69IbErx3DCm4wRUfYfu73j0dSrXjeow0/p7U8lQXe4J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770771936; c=relaxed/simple;
	bh=RNIUHZcoHOcL9qauCIPMV6N0r9KWUtBb5bmhZyUGBfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfz7ydss/cohvECl1PkHdj/W2eEZyn4z/AUcG4Q95PutZuY/TsF6xHK6DpqNsfWcIurQbB4qbv25dGuTMDmao2a4XI7n2QlVqGhnciaau9gDaSJOBHV7+PSHhc2KaGYqAAZyb9xwQPCEkOhz9Y68TEWYRusMHFvTuCEF1ht+P48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Lse1lVP+; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Lse1lVP+"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-79639c2d2b5so35411007b3.2
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 17:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1770771933; x=1771376733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWnhIh40Sgn4C3uhU5DhuBmUIx7Q3QbPCa9o9q7QHQU=;
        b=Lse1lVP+yWjufm+8ElOuNM8MoPpdxOzrcUcdQ0bbU95qisWYoq9M/bn0soJA0ymOLW
         c9Wv5QeG9g6HjZmv2RMXHve9/ud0Iiu7eoBizY7yww40JSzGW49+9VGMoGLu4pXGaDuk
         LwRgDnRH9kpmaEM0nf2GqrqnOaLqHZDGyIvo2vePbWDGiaWm4Z+8RewBOn1p3UnfDLBT
         sv7PmAlykDe3SqTn5fPWufleoiC2H6cGdWOf2aFAkw82W10olGx39X9+Qi3Q+PXLvPMC
         k0J3lGIdnMTlJaGS3mhhgD6DcPNYK+5PFgx+CAA2+rm5QtrmiR8HsF1c0xW8csfP/rb3
         lh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770771933; x=1771376733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWnhIh40Sgn4C3uhU5DhuBmUIx7Q3QbPCa9o9q7QHQU=;
        b=DYRfWnmSgILjD8uDIcXhnL2UHjzSmChk+S+iw44gQElINhR8TJvImFGuDNsqH2e1yT
         mONxs+IsuS6b5mhMQHEL/2c6xj/PP2Y5WW7KrvlRPQWUL0cpu667NHnclc8IjKfUS9W7
         TFVVnMatCKssJGlcMh0INwGTMsX/3e8XkMQBoHiAqL9tKUr+ChR9Jk4DfzQ1Leo1i2T5
         nXD40XkiP02PeQTRlibp4mJamlFHhVFx88Z8JSzZ5jVsdYyJCZLEcSEyYP/x4N5vjx5e
         TArb07nzcd0kAp0n1oo/o0TiolnCW1Kn26QMe29WKkQD9YzAUlL6ARa+/9hbZS0Rboay
         Ttiw==
X-Gm-Message-State: AOJu0YxRbQhR5E7D+L1L6g+Q1ABa4qfvMnyVt7PRHoPAy5h70Ig01nIA
	VWHelEAH5vVIFxo5WzxCrXd/dQ4UhqLkSWO/s9YcaUPfQV6omfSFpygPHJM2+0urH9k=
X-Gm-Gg: AZuq6aLlIM4SVHvA7Oe7bcVy8lTDg2ieIv4wqlOwF5B/z03y6GQ3NRKsCkkl+0VjLvN
	w/CbRLIizJfsolR4nf1NvrkCcazw86A0JhbVKeOCOZ2bbSEmZOTs9DxiOWAz4zeXAdOsS/hofgY
	YlgCPc7j5nf9GAKd0eOkkXmR7N0xmjSfH2hgY6ebEvH63etaOiQOCFf8zr6HwLiD5kbEfJHnl2m
	ltl+N0DgGb01+9mQLPwNOCmV8ilLR7FKDei9MhIVweiqqw+C1jzUkl6yCQjP11oxw8ta1uPMZje
	7uyFCdPnTOwrlq83+OuY8JE4onzaZqOHwmdV9n5LYcxf3Q06L5m/1+giwBmmKmGwv0doeR7JyNR
	mwASXpf4buBan9JgVp4QMVNqcsBsPT7TUsFa1WQ2u8XkKK9da5NHaqDjtdM930RsDvYuzXbdXxr
	nb64b622mAiGw2tGtvu9zlAP35XFF15wYzPVlP+JxdA+amQjRCy3rKd7WVbmQI3qXkZZ8yTSf7t
	U2Qr3CzI8sSCBa3Ipvm7vVRmD3jqg==
X-Received: by 2002:a05:690c:81:b0:794:cef6:64e9 with SMTP id 00721157ae682-7966c0f1cb4mr2581667b3.59.1770771933123;
        Tue, 10 Feb 2026 17:05:33 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c2533ccsm2531077b3.36.2026.02.10.17.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 17:05:32 -0800 (PST)
Date: Tue, 10 Feb 2026 20:05:29 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Vaidas Pilkauskas via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] http: add support for HTTP 429 rate limit retries
Message-ID: <aYvV2W5pcvqZig8S@nand.local>
References: <pull.2008.git.1764160227.gitgitgadget@gmail.com>
 <pull.2008.v2.git.1766069088.gitgitgadget@gmail.com>
 <d80ce077038bab96aca26b0b0ad706c91ea1d8a8.1766069088.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d80ce077038bab96aca26b0b0ad706c91ea1d8a8.1766069088.git.gitgitgadget@gmail.com>

On Thu, Dec 18, 2025 at 02:44:47PM +0000, Vaidas Pilkauskas via GitGitGadget wrote:
> From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
>
> Add retry logic for HTTP 429 (Too Many Requests) responses to handle
> server-side rate limiting gracefully. When Git's HTTP client receives
> a 429 response, it can now automatically retry the request after an
> appropriate delay, respecting the server's rate limits.
>
> The implementation supports the RFC-compliant Retry-After header in
> both delay-seconds (integer) and HTTP-date (RFC 2822) formats. If a
> past date is provided, Git retries immediately without waiting.
>
> Retry behavior is controlled by three new configuration options
> (http.maxRetries, http.retryAfter, and http.maxRetryTime) which are
> documented in git-config(1).
>
> The retry logic implements a fail-fast approach: if any delay
> (whether from server header or configuration) exceeds maxRetryTime,
> Git fails immediately with a clear error message rather than capping
> the delay. This provides better visibility into rate limiting issues.
>
> The implementation includes extensive test coverage for basic retry
> behavior, Retry-After header formats (integer and HTTP-date),
> configuration combinations, maxRetryTime limits, invalid header
> handling, environment variable overrides, and edge cases.




> +http.retryAfter::
> +	Default wait time in seconds before retrying when a server returns
> +	HTTP 429 (Too Many Requests) without a Retry-After header. If set
> +	to -1 (the default), Git will fail immediately when encountering

While reviewing, I originally wrote:

  Setting the default as "-1" makes sense to me. The current behavior is
  to give up when we receive a HTTP 429 response with or without a
  Retry-After header, so retaining that behavior makes sense and seems
  like a sensible path.

, but I'm not sure that I am sold on that line of thinking. This is
controlling how long we'll wait after a 429 response before retrying,
not how many times we'll retry (which is `http.maxRetries` below).

Should the default here be zero? We would "retry" immediately, but that
retry would fail since the maximum retries is set to "zero" by default.

> diff --git a/http-push.c b/http-push.c
> index 60a9b75620..ddb9948352 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -716,6 +716,10 @@ static int fetch_indices(void)
>  	case HTTP_MISSING_TARGET:
>  		ret = 0;
>  		break;
> +	case HTTP_RATE_LIMITED:
> +		error(_("rate limited by '%s', please try again later"), repo->url);
> +		ret = -1;
> +		break;
>  	default:
>  		ret = -1;
>  	}
> @@ -1548,6 +1552,10 @@ static int remote_exists(const char *path)
>  	case HTTP_MISSING_TARGET:
>  		ret = 0;
>  		break;
> +	case HTTP_RATE_LIMITED:
> +		error(_("rate limited by '%s', please try again later"), url);
> +		ret = -1;
> +		break;

I wonder if there is an opportunity to DRY this up a bit? I think the
case in fetch_indices() is very similar to remote_Exists(), and ditto
for fetch_indices() in the http-walker.c code.

The only exception I could see is http-walker.c's fetch_indices() needs
to also set repo->got_indices, but I think that could be done as a
separate pass.

If you end up going in that direction, I would suggest pulling out a
function as a preparatory commit before introducing the changes in this
patch so that you when you are ready to add the "rate limited by '%s'"
error(), you only have to do so once.

> -static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p UNUSED)
> +static size_t fwrite_headers(char *ptr, size_t eltsize, size_t nmemb, void *p)

Thanks for making this change. I think that handling both
www-authenticate and retry-after headers in the same function makes a
lot of sense, and the new name reflects that appropriately.


>  {
>  	size_t size = eltsize * nmemb;
>  	struct strvec *values = &http_auth.wwwauth_headers;
>  	struct strbuf buf = STRBUF_INIT;
>  	const char *val;
>  	size_t val_len;
> +	struct active_request_slot *slot = (struct active_request_slot *)p;
>
>  	/*
>  	 * Header lines may not come NULL-terminated from libcurl so we must
> @@ -257,6 +264,47 @@ static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p UN
>  		goto exit;
>  	}
>
> +	/* Parse Retry-After header for rate limiting */
> +	if (skip_iprefix_mem(ptr, size, "retry-after:", &val, &val_len)) {
> +		strbuf_add(&buf, val, val_len);
> +		strbuf_trim(&buf);
> +
> +		if (slot && slot->results) {
> +			/* Parse the retry-after value (delay-seconds or HTTP-date) */
> +			char *endptr;
> +			long retry_after;
> +
> +			errno = 0;
> +			retry_after = strtol(buf.buf, &endptr, 10);
> +
> +			/* Check if it's a valid integer (delay-seconds format) */
> +			if (endptr != buf.buf && *endptr == '\0' &&
> +			    errno != ERANGE && retry_after > 0) {

Should we handle "Retry-After: 0" here? I think that this means "retry
immediately", so I imagine that we should change this to read "&&
retry_after >= 0" instead.

> +				slot->results->retry_after = retry_after;
> +			} else {
> +				/* Try parsing as HTTP-date format */
> +				timestamp_t timestamp;
> +				int offset;
> +				if (!parse_date_basic(buf.buf, &timestamp, &offset)) {
> +					/* Successfully parsed as date, calculate delay from now */
> +					timestamp_t now = time(NULL);
> +					if (timestamp > now) {
> +						slot->results->retry_after = (long)(timestamp - now);
> +					} else {
> +						/* Past date means retry immediately */
> +						slot->results->retry_after = 0;
> +					}
> +				} else {
> +					/* Failed to parse as either delay-seconds or HTTP-date */
> +					warning(_("unable to parse Retry-After header value: '%s'"), buf.buf);
> +				}
> +			}
> +		}
> +
> +		http_auth.header_is_last_match = 1;

Could you help me understand why we're setting header_is_last_match
here? I think since we immediately "goto exit" this line isn't strictly
necessary.

As a separate but related note, I don't know if this function properly
handles header continuations for Retry-After headers, but in practice I
suspect it doesn't matter, as servers should not be continuing
Retry-After headers across multiple lines.

> @@ -1660,44 +1729,98 @@ void run_active_slot(struct active_request_slot *slot)
>  	fd_set excfds;
>  	int max_fd;
>  	struct timeval select_timeout;
> +	long curl_timeout;
> +	struct timeval start_time = {0}, current_time, elapsed_time = {0};
> +	long remaining_seconds;
>  	int finished = 0;
> +	int slot_not_started = (slot->finished == NULL);
> +	int waiting_for_delay = (slot->retry_delay_seconds > 0);
> +
> +	if (waiting_for_delay) {
> +		warning(_("rate limited, waiting %ld seconds before retry"), slot->retry_delay_seconds);
> +		start_time = slot->retry_delay_start;
> +	}
>
>  	slot->finished = &finished;
> -	while (!finished) {
> +	while (waiting_for_delay || !finished) {
> +		if (waiting_for_delay) {
> +			gettimeofday(&current_time, NULL);
> +			elapsed_time.tv_sec = current_time.tv_sec - start_time.tv_sec;
> +			elapsed_time.tv_usec = current_time.tv_usec - start_time.tv_usec;
> +			if (elapsed_time.tv_usec < 0) {
> +				elapsed_time.tv_sec--;
> +				elapsed_time.tv_usec += 1000000;
> +			}
> +
> +			if (elapsed_time.tv_sec >= slot->retry_delay_seconds) {
> +				slot->retry_delay_seconds = -1;
> +				waiting_for_delay = 0;
> +
> +				if (slot_not_started)
> +					return;

I wonder if run_active_slot() is the right place for these changes or if
it should be handled separately. I think it may be somewhat surprising
for run_active_slot() to return without actually running the slot, even
if the slot is marked as "active" but just waiting for a delay.

OTOH, like I mentioned earlier, I am far from an expert in this part of
the code, so perhaps this is totally OK. shortlog says that Peff (CC'd)
is among the most active contributors to this file in the past year, so
I'll be curious what he thinks as well.

> @@ -1871,6 +1994,8 @@ static int handle_curl_result(struct slot_results *results)
>  			}
>  			return HTTP_REAUTH;
>  		}
> +	} else if (results->http_code == 429) {
> +		return HTTP_RATE_LIMITED;
>  	} else {
>  		if (results->http_connectcode == 407)
>  			credential_reject(the_repository, &proxy_auth);
> @@ -1886,6 +2011,14 @@ int run_one_slot(struct active_request_slot *slot,
>  		 struct slot_results *results)
>  {
>  	slot->results = results;
> +	/* Initialize retry_after to -1 (not set) */
> +	results->retry_after = -1;
> +
> +	/* If there's a retry delay, wait for it before starting the slot */
> +	if (slot->retry_delay_seconds > 0) {
> +		run_active_slot(slot);
> +	}

This is a nitpick, but the curly braces here are unnecessary for a
single-line if statement. Documentation/CodingGuidelines has more
details here.

> +
>  	if (!start_active_slot(slot)) {
>  		xsnprintf(curl_errorstr, sizeof(curl_errorstr),
>  			  "failed to start HTTP request");
> @@ -2117,9 +2250,13 @@ static void http_opt_request_remainder(CURL *curl, off_t pos)
>  #define HTTP_REQUEST_STRBUF	0
>  #define HTTP_REQUEST_FILE	1
>
> +static void sleep_for_retry(struct active_request_slot *slot, long retry_after);
> +
>  static int http_request(const char *url,
>  			void *result, int target,
> -			const struct http_get_options *options)
> +			const struct http_get_options *options,
> +			long *retry_after_out,
> +			long retry_delay)
>  {
>  	struct active_request_slot *slot;
>  	struct slot_results results;
> @@ -2129,6 +2266,10 @@ static int http_request(const char *url,
>  	int ret;
>
>  	slot = get_active_slot();
> +	/* Mark slot for delay if retry delay is provided */
> +	if (retry_delay > 0) {
> +		sleep_for_retry(slot, retry_delay);
> +	}

Same note here as above.

> +/*
> + * Handle rate limiting retry logic for HTTP 429 responses.
> + * Uses slot-specific retry_after value to support concurrent slots.
> + * Returns a negative value if retries are exhausted or configuration is invalid,
> + * otherwise returns the delay value (>= 0) to indicate the retry should proceed.
> + */
> +static long handle_rate_limit_retry(int *rate_limit_retries, long slot_retry_after)
> +{
> +	int retry_attempt = http_max_retries - *rate_limit_retries + 1;
> +	if (*rate_limit_retries <= 0) {
> +		/* Retries are disabled or exhausted */
> +		if (http_max_retries > 0) {
> +			error(_("too many rate limit retries, giving up"));
> +		}

Here as well.

> +		return -1;
> +	}
> +
> +	/* Decrement retries counter */
> +	(*rate_limit_retries)--;
> +
> +	/* Use the slot-specific retry_after value or configured default */
> +	if (slot_retry_after >= 0) {
> +		/* Check if retry delay exceeds maximum allowed */
> +		if (slot_retry_after > http_max_retry_time) {
> +			error(_("rate limited (HTTP 429) requested %ld second delay, "
> +				"exceeds http.maxRetryTime of %ld seconds"),
> +			      slot_retry_after, http_max_retry_time);
> +			return -1;
> +		}
> +		return slot_retry_after;
> +	} else {
> +		/* No Retry-After header provided */
> +		if (http_retry_after < 0) {
> +			/* Not configured - exit with error */
> +			error(_("rate limited (HTTP 429) and no Retry-After header provided. "
> +				"Configure http.retryAfter or set GIT_HTTP_RETRY_AFTER."));
> +			return -1;
> +		}
> +		/* Check if configured default exceeds maximum allowed */
> +		if (http_retry_after > http_max_retry_time) {
> +			error(_("configured http.retryAfter (%ld seconds) exceeds "
> +				"http.maxRetryTime (%ld seconds)"),
> +			      http_retry_after, http_max_retry_time);
> +			return -1;
> +		}

As a general note on these error()s, I wonder if it would be worth
shortening them up a bit. For example, the first one reads:

  "rate limited (HTTP 429) requested %ld second delay, exceeds http.maxRetryTime of %ld seconds"

Perhaps we could shorten this to something like:

  "response requested a delay greater than http.maxRetryTime (%ld > %ld seconds)"

I feel like we could get it even shorter, but I think that this is a
good starting point.

As an additional note, I think we generally try and avoid putting
instructions like "Configure http.retryAfter or [...]" in error()
messages. Those would be good advise() messages, enabling the user to
turn them off if they are not relevant to their situation, whereas
error() messages are fixed.

> +static int http_request_recoverable(const char *url,
>  			       void *result, int target,
>  			       struct http_get_options *options)
>  {
>  	int i = 3;
>  	int ret;
> +	int rate_limit_retries = http_max_retries;
> +	long slot_retry_after = -1; /* Per-slot retry_after value */
>
>  	if (always_auth_proactively())
>  		credential_fill(the_repository, &http_auth, 1);
>
> -	ret = http_request(url, result, target, options);
> +	ret = http_request(url, result, target, options, &slot_retry_after, -1);
>
> -	if (ret != HTTP_OK && ret != HTTP_REAUTH)
> +	if (ret != HTTP_OK && ret != HTTP_REAUTH && ret != HTTP_RATE_LIMITED)
>  		return ret;
>
> +	/* If retries are disabled and we got a 429, fail immediately */
> +	if (ret == HTTP_RATE_LIMITED && http_max_retries == 0)

Another minor CodingGuidelines nit, but we generally do not write "x ==
0", and instead prefer "!x".

> +		return HTTP_ERROR;
> +
>  	if (options && options->effective_url && options->base_url) {
>  		if (update_url_from_redirect(options->base_url,
>  					     url, options->effective_url)) {
> @@ -2276,7 +2491,8 @@ static int http_request_reauth(const char *url,
>  		}
>  	}
>
> -	while (ret == HTTP_REAUTH && --i) {
> +	while ((ret == HTTP_REAUTH || ret == HTTP_RATE_LIMITED) && --i) {

I had to re-read this line, since I wasn't sure that decrementing i was
the right thing to do for both reauth and rate limited responses. But it
is, since we pass a pointer to rate_limit_retries down to
handle_rate_limit_retry() which will decrement it and eventually cause
it to return -1 when retries are exhausted, causing this loop to exit.

>  static int get_protocol_http_header(enum protocol_version version,
> @@ -518,21 +529,25 @@ static struct discovery *discover_refs(const char *service, int for_push)
>  	case HTTP_OK:
>  		break;
>  	case HTTP_MISSING_TARGET:
> -		show_http_message(&type, &charset, &buffer);
> -		die(_("repository '%s' not found"),
> -		    transport_anonymize_url(url.buf));
> +		show_http_message_fatal(&type, &charset, &buffer,
> +					_("repository '%s' not found"),
> +					transport_anonymize_url(url.buf));

Thanks for taking my suggestion here as well. I think that the end
result reads much cleaner, though I do think that introducing the new
show_http_message_fatal() function and rewriting the existing code
should happen in a preparatory commit before this one to more clearly
separate the changes.

> diff --git a/strbuf.c b/strbuf.c
> index 6c3851a7f8..1d3860869e 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -168,7 +168,7 @@ int strbuf_reencode(struct strbuf *sb, const char *from, const char *to)
>  	if (!out)
>  		return -1;
>
> -	strbuf_attach(sb, out, len, len);
> +	strbuf_attach(sb, out, len, len + 1);

Not sure that I'm following this change.

> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index 5091db949b..8a43261ffc 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh

I may solicit Peff's input here on the remainder of the test changes,
since he is much more familiar with the lib-httpd parts of the suite
than I am.

Thanks,
Taylor
