Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B941188713
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 23:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765322117; cv=none; b=hu6jpH/0V/Giz5nI8zgJVTxRuPyh8fqYM/b1AQtvM/oNVNypZPnOM/t+kxLSncAevYplgeBmtSLhkrliUSvgXMUjGUsjz8avaobFr8c0sT+vWlwjSDXdGS66n3JETinYG2p8waTwcOgwMBAdSFnBKFRmYAHXJLPf90AZPEgX4yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765322117; c=relaxed/simple;
	bh=5SUeqlRPZ0FLR33WhusAy3VYQ9aaBx1V3g8z7BTA/UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHtRJ6821mMBxqOTuO0Ryn3rQOneJYfMEz/fSuDcs0iyhOiIVVLniyjwdFxDHDsow/sWNMls5RAk5gNIGHJfz2+I7fbnBwkYWVhiNzt7J3ZjwHdlga7noitmzTuV3oiHzCHtQ3IbyP/LSGfsog5/ARXyviy99aONs8rh7I/AxO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=aVZqBKu7; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="aVZqBKu7"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8ba3ffd54dbso26237285a.1
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 15:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765322113; x=1765926913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=76Tekca9JA/FwmsrUSqRxrwziknQlNPYqwcYElBIFDg=;
        b=aVZqBKu7K8EaVcwsI19yaXhRT7203uOSL4pH23QzvYpG36TdXsyDbbnnoE3xKiGNOo
         Ys5f6RqeEUFKlj9mn2dnhiDvjQKQ51obb3GERg55dbG8ULMoCFT/4397bFBiHm2rtPHX
         azG7yedMSvl/RmP65ZlKl8Q6ITLY9dsLNKL9D5x8YUDrzzsjiyZlolB/zVl4fknXxoHo
         uJ+KA5eC98zb/KEk6W6qy0jAt+KXJHM3dJMyyvHd2E6Oc4NfondpcdOcSsTfivwLxGKB
         YEnHGxhpJzKDpwRqhbBU1epSKZwcgVVl9ubd4+8bbPw4BmRx4xu7dp8WKRXx1LGChZMg
         DrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765322113; x=1765926913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76Tekca9JA/FwmsrUSqRxrwziknQlNPYqwcYElBIFDg=;
        b=qu0nB32duRi3zIAxrT8NC7dqWlF+SeMEKJ7ffmzKn9tir+JUlWCfUG3sb9iu6WpsGm
         CLORWXh+IUaNsmsZE4TUvrrURBeIxfWSo4AJjZvxFPxQPggoShaosqgf5ElGYX5OBGHT
         Kj4ZXdVBF5LTlsH9GXzgMq2ixonUawJyVet3XshQ33J+eatrDxdyKOVxfOLGhj4fc4qK
         HrjllGYnbwpoKFNi9v+3hS0rBsVfy8ANgThOcYB2dEq2rJL83MsueMu8FAEVOYXFFGT/
         S/UZyfAzF8F5lJ6hrNjqJUtUG+ggeREtD2yoTQ0wjrmXZ5QUzL0F7vrUx2UGtVtEKYMb
         bU9A==
X-Gm-Message-State: AOJu0Yw1GI49Tc5nX+Al1fzESrekFud0Wk22BTOvLby4r7yWhoN8mun0
	YvMdA3t6p1AwI1rTlEgRIQYpJVKW0j7JS66dJ+w1PH9yoAE0nBOzyu16/zCEuu9SXWOyidrRxzM
	h75L5fD8=
X-Gm-Gg: ASbGncsh+aXxJQV5l9vXrCpW6tRHWy5bDGTyIxdE8fHGqtBON+uTCODQA2Nl5CEn7V9
	Jg77DeQ3FSw15742FUxBR66vuE6/4IbXJkxsZajn4SBziCdMxvIGQQJ8MW8MqG+YocUk0bmbylX
	zVB6ZZvt7eClVACHDHP+syfd+sQ+iRkmw3CgK7qnbKIWqDVWgBE5xWZorjFix0yOduTu5u9DPk2
	4e6tQp81MOLFV4S8/s23DLCjYlvK4T0IxRdQLwjC+boCpOgU8JrzdyPctPE5x1aqRbkX3IgIu0a
	fxIvOKml2lCsalsfEZmpm0YL30wUfIvxO3JIVfa4wlcU74FOFTgS3zBDgQB2wEbwIgG9AELIsAj
	yVNEFzKrW14WVQu7c5f7mctiqGtnfi73XdMXKFjPQnVPUqrfrjj9vGPhs47Fg3CQit5UQLtKzOC
	XvlxG35TZJdH/pbFnGhGJBUVkY7oNiBtl2v5aumjo58gg9DTzs4dREvMG1TCGOCAK/mFr2WvdUf
	At3jRZgIhN/ZL9d3g==
X-Google-Smtp-Source: AGHT+IFguBkBr/Eg0GTrS9Poo1D/h9hdG4vZxpTPnvKd3XWAydKb527+eLynDNanHxEwVJPdJyPlZw==
X-Received: by 2002:a05:620a:31a8:b0:8b2:ef2d:f74b with SMTP id af79cd13be357-8ba38c77e4fmr119289485a.29.1765322112773;
        Tue, 09 Dec 2025 15:15:12 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-8b6252b6539sm1368570485a.20.2025.12.09.15.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 15:15:12 -0800 (PST)
Date: Tue, 9 Dec 2025 18:15:11 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Vaidas Pilkauskas via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
Subject: Re: [PATCH 1/3] http: add support for HTTP 429 rate limit retries
Message-ID: <aTitfzeb7J8TUTYQ@nand.local>
References: <pull.2008.git.1764160227.gitgitgadget@gmail.com>
 <ae0087cd1c7fbb6b748d6767b476c1bd1a19996f.1764160227.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae0087cd1c7fbb6b748d6767b476c1bd1a19996f.1764160227.git.gitgitgadget@gmail.com>

On Wed, Nov 26, 2025 at 12:30:25PM +0000, Vaidas Pilkauskas via GitGitGadget wrote:
> Retry behavior is controlled by three new configuration options:
>
>   * http.maxRetries: Maximum number of retry attempts (default: 0,
>     meaning retries are disabled by default). Users must explicitly
>     opt-in to retry behavior.
>
>   * http.retryAfter: Default delay in seconds when the server doesn't
>     provide a Retry-After header (default: -1, meaning fail if no
>     header is provided). This serves as a fallback mechanism.
>
>   * http.maxRetryTime: Maximum delay in seconds for a single retry
>     (default: 300). If the server requests a delay exceeding this
>     limit, Git fails immediately rather than waiting. This prevents
>     indefinite blocking on unreasonable server requests.
>
> All three options can be overridden via environment variables:
> GIT_HTTP_MAX_RETRIES, GIT_HTTP_RETRY_AFTER, and
> GIT_HTTP_MAX_RETRY_TIME.

This is great information, and I am glad that it is written down in
http.adoc so that it shows up in git-config(1). I think that it's fine
to omit this level of detail from the commit message, since it
duplicates information from the authoritative source on configuration
knobs.

It might be reasonable to say something like:

    Retry behavior is controlled by three new configuration options
    (http.maxRetries, http.retryAfter, and http.maxRetryTime) which are
    documented in git-config(1).

or something.

> diff --git a/http-push.c b/http-push.c
> index d86ce77119..a602a302ec 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -716,6 +716,10 @@ static int fetch_indices(void)
>  	case HTTP_MISSING_TARGET:
>  		ret = 0;
>  		break;
> +	case HTTP_RATE_LIMITED:
> +		error("rate limited by '%s', please try again later", repo->url);
> +		ret = -1;

Other strings in this file aren't marked for translation, but I think
we can/should mark this one like so:

    error(_("rate limited by %s ..."), repo->url);

> diff --git a/http.c b/http.c
> index 41f850db16..212805cad5 100644
> --- a/http.c
> +++ b/http.c
> @@ -22,6 +22,7 @@
>  #include "object-file.h"
>  #include "odb.h"
>  #include "tempfile.h"
> +#include "date.h"
>
>  static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
>  static int trace_curl_data = 1;
> @@ -149,6 +150,14 @@ static char *cached_accept_language;
>  static char *http_ssl_backend;
>
>  static int http_schannel_check_revoke = 1;
> +
> +/* Retry configuration */
> +static long http_retry_after = -1; /* Default retry-after in seconds when header is missing (-1 means not set, exit with 128) */
> +static long http_max_retries = 0; /* Maximum number of retry attempts (0 means retries are disabled) */
> +static long http_max_retry_time = 300; /* Maximum time to wait for a single retry (default 5 minutes) */

These comments should be OK to drop, the variables indicate what Git
configuration they correspond to (e.g., http_retry_after ->
http.retryAfter), so git-config(1) is the authoritative source for
documentation here.

> @@ -257,6 +267,47 @@ static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p UN
>  		goto exit;
>  	}
>
> +	/* Parse Retry-After header for rate limiting */
> +	if (skip_iprefix_mem(ptr, size, "retry-after:", &val, &val_len)) {

Makes sense, though I wonder if we should rename this function, since
fwrite_wwwauth is now doing more than just handling WWW-Authenticate
headers.

Perhaps we should have a single top-level function that is registered as
our CURLOPT_HEADERFUNCTION that dispatches calls to header-specific
functions? Otherwise the actual parsing of the Retry-After header looks
good to me.

> @@ -1422,6 +1488,10 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  	set_long_from_env(&curl_tcp_keepintvl, "GIT_TCP_KEEPINTVL");
>  	set_long_from_env(&curl_tcp_keepcnt, "GIT_TCP_KEEPCNT");
>
> +	set_long_from_env(&http_retry_after, "GIT_HTTP_RETRY_AFTER");
> +	set_long_from_env(&http_max_retries, "GIT_HTTP_MAX_RETRIES");
> +	set_long_from_env(&http_max_retry_time, "GIT_HTTP_MAX_RETRY_TIME");
> +

The configuration handling and overrides look good to me.

> @@ -2253,19 +2330,36 @@ static int update_url_from_redirect(struct strbuf *base,
>  	return 1;
>  }
>
> +/*
> + * Sleep for the specified number of seconds before retrying.
> + */
> +static void sleep_for_retry(long retry_after)
> +{
> +	if (retry_after > 0) {
> +		unsigned int remaining;
> +		warning(_("rate limited, waiting %ld seconds before retry"), retry_after);
> +		remaining = sleep(retry_after);

What should we do if there are other active request slots? It has been a
couple of years since I have looked at Git's HTTP code, but I imagine
that we should be able to continue processing other requests while
waiting for the retry-after period to elapse here.

> @@ -2302,7 +2396,54 @@ static int http_request_reauth(const char *url,
>  			BUG("Unknown http_request target");
>  		}
>
> -		credential_fill(the_repository, &http_auth, 1);
> +		if (ret == HTTP_RATE_LIMITED) {

Should handling the retry behavior be moved into a separate function? I
think that http_request_reauth() might be clearer if it read:

    if (ret == HTTP_RATE_LIMITED)
      apply_rate_limit(...); /* presumably with a better name */
    else
      credential_fill(...);

, and likewise, should we rename this function as it is no longer just
re-authenticating HTTP requests?

> diff --git a/t/t5584-http-429-retry.sh b/t/t5584-http-429-retry.sh
> new file mode 100755
> index 0000000000..8bcc382763
> --- /dev/null
> +++ b/t/t5584-http-429-retry.sh
> @@ -0,0 +1,429 @@
> +#!/bin/sh
> +
> +test_description='test HTTP 429 Too Many Requests retry logic'
> +
> +. ./test-lib.sh
> +
> +. "$TEST_DIRECTORY"/lib-httpd.sh
> +
> +start_httpd
> +
> +test_expect_success 'setup test repository' '
> +	test_commit initial &&
> +	git clone --bare . "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" config http.receivepack true
> +'
> +
> +test_expect_success 'HTTP 429 with retries disabled (maxRetries=0) fails immediately' '
> +	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
> +	printf "Status: 429 Too Many Requests\r\n"
> +	printf "Retry-After: 1\r\n"
> +	printf "Content-Type: text/plain\r\n"
> +	printf "\r\n"
> +	printf "Rate limited\n"
> +	cat "$1" >/dev/null
> +	EOF

To avoid having to write this script multiple write, you can write it as
a separate script in t/lib-httpd and then make sure to list it in
prepare_httpd() (from t/lib-httpd.sh).

You can then list it in the apache.conf in the same directory and invoke
it however you like. If you need to take in arguments to the script
(e.g., to change the Retry-After value), you can use a ScriptAliasMatch
instead of a normal ScriptAlias to pass in extra parameters from the URL.

The one-time-script mechanism here will cause the test harness to delete
the script after its first (and only) use, which can be useful for some
cases but I suspect is not necessary for all of these tests.
> +
> +	# Set maxRetries to 0 (disabled)
> +	test_config http.maxRetries 0 &&
> +	test_config http.retryAfter 1 &&
> +
> +	# Should fail immediately without any retry attempt
> +	test_must_fail git ls-remote "$HTTPD_URL/one_time_script/repo.git" 2>err &&
> +
> +	# Verify no retry happened (no "waiting" message in stderr)
> +	! grep -i "waiting.*retry" err &&

test_grep can be helpful when reading the output of test failures, since
it dumps the contents of the file it was searching. Just make sure to
write "test_grep !" instead of "! test_grep" (there are a few such
instances of the latter that I just wrote patches to clean up).

"! test_grep" isn't *wrong* per-se, but it will pollute the test output
with "couldn't find xyz in abc".

I skimmed through the the remainder of the tests since I imagine that
they will change substantially after writing the script out explicitly
instead of using one-time-script, so I'll hold off on reviewing that
portion in more detail until then.

Thanks,
Taylor
