Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1035B1F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 19:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfACTJG (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 14:09:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52137 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfACTJG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 14:09:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so30149289wmj.1
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 11:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4ETZiu7C23DnxA4Wlack73yhZThkdh3gWPtDhBRArLw=;
        b=pRy2jQ002yimtiQWbNz9QpOJRL+u67tIE93Vc77AUeHxTIlZ3rgQL5ZLwQN32yE4Bl
         ZkVO4PCwGHK/gpGjNDMF2426Csx5k8vF2sl0IpNiZ0XCXeZvfwoz0ZYo2Ax6UMApNtZH
         l2eXm6qahnjrcl3tIRps9G7MNiFo1nVJIkpRqKJ5gQ2C2XdWiFQFmCYld/xIDGDmxwiG
         mQhd+7+ll0kkAgC2cgY50N7O7Q3ndqCw+ey+7tPxQemBUb/fvYBoACzHp4PD+tPuBkpd
         7JmxDQb6ClIuATc0eoBgiYTicS91nf4a6WaL6rxrAQjZIe0DnKRyb0tF+2NRMUQ7vpcD
         CzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4ETZiu7C23DnxA4Wlack73yhZThkdh3gWPtDhBRArLw=;
        b=ciz5pFSj1ShAjRkYfOsyOTezRM8fPjL4KmJeNKRDt3cterR3zHy+FmicGPuEeP0v3H
         oPVT+NthbmQ2X3yRsVdt7ICnPdqfFWz233WtC/Zsvq0lm1RMmmOkUpGGlbsumql9cQ+4
         /M+rjDfuSaSDn3XMyZSVCHniU3cSyvZBtxgFUcEPnKjMjDaHlUVsyrxXT8u+zpK/gt+F
         BW+h2AGAP0xr1YE85Q9cXEPGQTqEJCi/CVGGuI7+uS/bcv8qRZofqEEHT8WDrBFTJRKh
         36JSbXRT6e6JeHru+7/K+lCQ+AIBt7qSpik+tliXZVWSmA4lWCJ+Lw+p+Fx4zBYKw8Y1
         O2fA==
X-Gm-Message-State: AA+aEWZOEAIV25JcyKayFGOlakGk0f/4hSdfJpukGtG48Vxc1YL5Jstr
        SkPQuzGNuCkVT57jg3noxik=
X-Google-Smtp-Source: ALg8bN6HQDWduG7nsE1oT+I/hYQHmI6cJcG6e4tLMQizbWA7J2mnWZORkccqS4rjP6+EOUnqgJCoaA==
X-Received: by 2002:a1c:7011:: with SMTP id l17mr37549198wmc.34.1546542543379;
        Thu, 03 Jan 2019 11:09:03 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g67sm45621207wmd.38.2019.01.03.11.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 11:09:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        sunshine@sunshineco.com
Subject: Re: [PATCH v2 1/2] Change how HTTP response body is returned
References: <20181228014720.206443-1-masayasuzuki@google.com>
        <20181229194447.157763-1-masayasuzuki@google.com>
        <20181229194447.157763-2-masayasuzuki@google.com>
Date:   Thu, 03 Jan 2019 11:09:02 -0800
In-Reply-To: <20181229194447.157763-2-masayasuzuki@google.com> (Masaya
        Suzuki's message of "Sat, 29 Dec 2018 11:44:46 -0800")
Message-ID: <xmqqtviph835.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Masaya Suzuki <masayasuzuki@google.com> writes:

> Subject: Re: [PATCH v2 1/2] Change how HTTP response body is returned

Perhaps:

    Subject: http: change the way response body is returned

but if we can state why we want to do so concisely, that would be
even better.

> This changes the way HTTP response body is returned in
> http_request_reauth and post_rpc.
>
> 1. http_request_reauth makes up to two requests; one without a
>    credential and one with a credential. The first request can fail if
>    it needs a credential. When the keep_error option is specified, the
>    response to the first request can be written to the HTTP response
>    body destination. If the response body destination is a string
>    buffer, it erases the buffer before making the second request. By
>    introducing http_response_dest, it can handle the case that the
>    destination is a file handle.
> 2. post_rpc makes an HTTP request and the response body is directly
>    written to a file descriptor. This makes it check the HTTP status
>    code before writing it, and do not write the response body if it's an
>    error response. It's ok without this check now because post_rpc makes
>    a request with CURLOPT_FAILONERROR, and libcurl won't call the
>    callback if the response has an error status code.

The above may be an accurate description of what the code will do
with this patch, but I cannot quite read the reason why we would
want the code to behave so in the first place.

>
> Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
> ---
>  http.c        | 99 +++++++++++++++++++++++++++++----------------------
>  remote-curl.c | 29 ++++++++++++---
>  2 files changed, 81 insertions(+), 47 deletions(-)
>
> diff --git a/http.c b/http.c
> index eacc2a75e..d23417670 100644
> --- a/http.c
> +++ b/http.c
> @@ -165,6 +165,19 @@ static int http_schannel_check_revoke = 1;
>   */
>  static int http_schannel_use_ssl_cainfo;
>  
> +/*
> + * Where to store the result of http_request.
> + *
> + * At most one of buffer or file can be non-NULL. The buffer and file are not
> + * allocated by http_request, and the caller is responsible for releasing them.
> + */
> +struct http_response_dest {
> +	struct strbuf *buffer;
> +
> +	FILE *file;
> +	const char *filename;
> +};
> +
>  size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
>  {
>  	size_t size = eltsize * nmemb;
> @@ -1794,12 +1807,8 @@ static void http_opt_request_remainder(CURL *curl, off_t pos)
>  	curl_easy_setopt(curl, CURLOPT_RANGE, buf);
>  }
>  
> -/* http_request() targets */
> -#define HTTP_REQUEST_STRBUF	0
> -#define HTTP_REQUEST_FILE	1
> -
>  static int http_request(const char *url,
> -			void *result, int target,
> +			struct http_response_dest *dest,
>  			const struct http_get_options *options)
>  {
>  	struct active_request_slot *slot;
> @@ -1812,21 +1821,23 @@ static int http_request(const char *url,
>  	slot = get_active_slot();
>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
>  
> -	if (result == NULL) {
> -		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
> -	} else {
> +	if (dest->file) {
> +		off_t posn = ftello(dest->file);
>  		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
> -		curl_easy_setopt(slot->curl, CURLOPT_FILE, result);

OK, so it used to be that we can either discard the result
(i.e. NOBODY) or send the result to CURLOPT_FILE, and the latter has
two options (sent to a file, or sent to in-core buffer).  The way
these three choices are given were with the result pointer and the
target enum.

That is replaced by a struct that allows the same three choices.

Makes sense so far.

> @@ -1930,10 +1941,10 @@ static int update_url_from_redirect(struct strbuf *base,
>  }
>  
>  static int http_request_reauth(const char *url,
> -			       void *result, int target,
> +			       struct http_response_dest *dest,
>  			       struct http_get_options *options)
>  {
> -	int ret = http_request(url, result, target, options);
> +	int ret = http_request(url, dest, options);

Just adjusting the calling convention to the change we saw above.

> @@ -1949,32 +1960,34 @@ static int http_request_reauth(const char *url,
>  	if (ret != HTTP_REAUTH)
>  		return ret;
>  
> -	/*
> -	 * If we are using KEEP_ERROR, the previous request may have
> -	 * put cruft into our output stream; we should clear it out before
> -	 * making our next request. We only know how to do this for
> -	 * the strbuf case, but that is enough to satisfy current callers.
> -	 */
> -	if (options && options->keep_error) {
> -		switch (target) {
> -		case HTTP_REQUEST_STRBUF:
> -			strbuf_reset(result);
> -			break;
> -		default:
> -			BUG("HTTP_KEEP_ERROR is only supported with strbufs");

Now it gets interesting.  We used to allow keep-error only when
receiving to in-core buffer.

> +	if (dest->file) {
> +		/*
> +		 * At this point, the file contains the response body of the
> +		 * previous request. We need to truncate the file.
> +		 */
> +		FILE *new_file = freopen(dest->filename, "w", dest->file);

Now freopen() lets us restart the file anew with a new "FILE *".

> +		if (new_file == NULL) {
> +			error("Unable to open local file %s", dest->filename);

error_errno(), perhaps?

At this point, I presume that dest->file is closed by the failed
freopen(), but dest->file is still non-NULL and causes further calls
to http_request() with this dest would be a disaster?  As long as
the caller of this function reacts to HTTP_ERROR and kill the dest,
it would be fine.

> +			return HTTP_ERROR;
>  		}
> +		dest->file = new_file;
> +	} else if (dest->buffer) {
> +		strbuf_reset(dest->buffer);
>  	}

OK.

>  	credential_fill(&http_auth);
>  
> -	return http_request(url, result, target, options);
> +	return http_request(url, dest, options);
>  }

So far, I spotted one reason why this patch wants to exist: it used
to be that keep_error was impossible when sending to a file.  It
somehow wants to allow us to do so (even though it still is unclear
who that new caller that wants to use keep_error is, and for what
purpose it wants to use that facility).

Perhaps this step can be split into at least two steps?  The first
one is to turn <result, target> to <dest> without changing any other
behaviour, and then the second one implements keep_error handling
for the "dest->file != NULL" case.

There may be other things this patch does, in which case it may
deserve to become three or more steps, but we haven't seen enough to
decide if that is the case.  Let's read on.

>  int http_get_strbuf(const char *url,
> -		    struct strbuf *result,
> +		    struct strbuf *dest_buffer,
>  		    struct http_get_options *options)
>  {
> -	return http_request_reauth(url, result, HTTP_REQUEST_STRBUF, options);
> +	struct http_response_dest dest;
> +	dest.file = NULL;
> +	dest.buffer = dest_buffer;
> +	return http_request_reauth(url, &dest, options);

This is merely adjusting for the updated calling convention, which
makes sense.

>  }
>  
>  /*
> @@ -1988,18 +2001,20 @@ static int http_get_file(const char *url, const char *filename,
>  {
>  	int ret;
>  	struct strbuf tmpfile = STRBUF_INIT;
> -	FILE *result;
> +	struct http_response_dest dest;
>  
>  	strbuf_addf(&tmpfile, "%s.temp", filename);
> -	result = fopen(tmpfile.buf, "a");
> -	if (!result) {
> +	dest.buffer = NULL;
> +	dest.file = fopen(tmpfile.buf, "a");
> +	if (!dest.file) {
>  		error("Unable to open local file %s", tmpfile.buf);
>  		ret = HTTP_ERROR;
>  		goto cleanup;
>  	}
> +	dest.filename = tmpfile.buf;

Hmph.  I somehow expected that the presence of dest.filename field
would allow callers to just set it and let the fopen() call handled
in http_request(), e.g. at the beginning of the function, it would
do something like

	if (!dest->file && dest->filename)
		dest->file = fopen(...);

But obviously that is not within the scope of this change.  Leaving
the caller responsible for opening and reporting errors as before
like the above is preferrable.

> diff --git a/remote-curl.c b/remote-curl.c
> index 1220dffcd..48656bf18 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -546,14 +546,31 @@ static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
>  }
>  #endif
>  
> +struct rpc_in_data {
> +	struct rpc_state *rpc;
> +	struct active_request_slot *slot;
> +};
> +
> +/*
> + * A callback for CURLOPT_WRITEFUNCTION. The return value is the bytes consumed
> + * from ptr.
> + */
>  static size_t rpc_in(char *ptr, size_t eltsize,
>  		size_t nmemb, void *buffer_)
>  {
>  	size_t size = eltsize * nmemb;
> -	struct rpc_state *rpc = buffer_;
> +	struct rpc_in_data *data = buffer_;
> +	long response_code;
> +
> +	if (curl_easy_getinfo(data->slot->curl, CURLINFO_RESPONSE_CODE,
> +			      &response_code) != CURLE_OK)
> +		return size;
> +	if (response_code != 200)
> +		return size;
> +
>  	if (size)
> -		rpc->any_written = 1;
> -	write_or_die(rpc->in, ptr, size);
> +		data->rpc->any_written = 1;
> +	write_or_die(data->rpc->in, ptr, size);
>  	return size;
>  }

This is not necessarily related to the change we saw in http.c but
making it more careful in general?  That is, we avoid writing the
payload to the destination (by the way, rpc->IN being the target of
write(2) is somewhat a brain-twister).  It may deserve to become its
own step in a patch series, with separate justification (i.e. "when
rpc channel receives an error from the cURL library, we used to
write the data to the file anyway, and that caused such and such
problems, as demonstrated by the new test added by this patch.  we
fix it by checking for the error before writing to the file").

> @@ -633,6 +650,7 @@ static int post_rpc(struct rpc_state *rpc)
>  	size_t gzip_size = 0;
>  	int err, large_request = 0;
>  	int needs_100_continue = 0;
> +	struct rpc_in_data rpc_in_data;
>  
>  	/* Try to load the entire request, if we can fit it into the
>  	 * allocated buffer space we can use HTTP/1.0 and avoid the
> @@ -765,8 +783,9 @@ static int post_rpc(struct rpc_state *rpc)
>  
>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
>  	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
> -	curl_easy_setopt(slot->curl, CURLOPT_FILE, rpc);
> -
> +	rpc_in_data.rpc = rpc;
> +	rpc_in_data.slot = slot;
> +	curl_easy_setopt(slot->curl, CURLOPT_FILE, &rpc_in_data);
>  
>  	rpc->any_written = 0;
>  	err = run_slot(slot, NULL);

These two hunks look like mere adjustments for the new callback
type, which makes sense.

Thanks.
