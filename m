Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE058ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 16:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiISQVW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 12:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiISQVT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 12:21:19 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43A13123B
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:21:17 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id v15so44223qvi.11
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=9M/Dm2E1ClGlGPcanWAWpAstr0H9mtRaN3N1se6/Crw=;
        b=g6QQhLH9TJfo9dwIYNDzVTuGPmaE/E7F/p5VdZKDcLpi6M/kXHd8xbkVJOLGKecoH6
         78XOJymMadKV6sP53dY/98bWCBdyD92vzKN3XZPMZZhiLc32PIen4dQNz6Y5a9hr1B9J
         QCXhzo/kGTikbz2uYNcDYUEy0tkz1SzyKSYqQlCIrgQqq4T6CLo9brrWINPJAHqkSHbi
         2AVG4ONBykuYBmnfbRlUa9DdStX8Ng/ilrgQcp6azbNMcr8YPvMrgsZYk4GRjdyUyIV4
         VGsL5w0ti3SRRLDwtXy4edbVEvaphb1TOcPP55ZCcfL9KecRaf+gkbv5aPECs1Oed2z5
         f+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9M/Dm2E1ClGlGPcanWAWpAstr0H9mtRaN3N1se6/Crw=;
        b=WxF+T+pocmCgp7+b6KZvu1Jan4DyDGpFo1pVQ94EMKDfmZ25eBYR1+ZHWyaSE9qGeA
         ciYGkQvGqgfZCkJS9MLF4gyDWI7/dnGT+oVlDQA8CkCkRTR+Km6x5VMJtOyZiqpZnMcL
         GR1YKhy2eBVaYxOSeDMJmZDnEN+ui4nuuopVH+zxz6UlB9bL8gKDHBi0JJlMNuEWXl9k
         jLJTu8yRSN0Z0kiMgcZvsklIvX+Iy6nIpC6dfP7Asq93dqPnM3fu4dixbVKdOpPETfY9
         8oL0PI5AiZJCIvUDSp3efNAL/VBDr62uthQ4Rg5ch2ASrEcNimIbuw0ho8JkM+v5G8L7
         Pdag==
X-Gm-Message-State: ACrzQf0sFbuGz78naHPbsQYOWwdeJm0YZy+z3sXb1G3O73M4J85Kj795
        sjT64u1vg8OBn5ZLrJYVnWxy
X-Google-Smtp-Source: AMsMyM7CmNH9GOovgsQA8bNI1f0OoioVirK+5hjHz26y0wjI8J1uiDgDNBkcBntBiNmn8LwGvl2pVA==
X-Received: by 2002:ad4:5d6a:0:b0:4ad:3936:df69 with SMTP id fn10-20020ad45d6a000000b004ad3936df69mr5581512qvb.108.1663604476771;
        Mon, 19 Sep 2022 09:21:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:fd97:43ff:6c00:2cf8? ([2600:1700:e72:80a0:fd97:43ff:6c00:2cf8])
        by smtp.gmail.com with ESMTPSA id z81-20020a376554000000b006cddf59a600sm12654754qkb.34.2022.09.19.09.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 09:21:16 -0700 (PDT)
Message-ID: <9fded44b-c503-f8e5-c6a6-93e882d50e27@github.com>
Date:   Mon, 19 Sep 2022 12:21:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 4/8] http: read HTTP WWW-Authenticate response headers
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
 <78e66d56605cfb1c7000edf329ac16c05a5d69b0.1663097156.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <78e66d56605cfb1c7000edf329ac16c05a5d69b0.1663097156.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/13/2022 3:25 PM, Matthew John Cheetham via GitGitGadget wrote:

> +	/**
> +	 * A `strvec` of WWW-Authenticate header values. Each string
> +	 * is the value of a WWW-Authenticate header in an HTTP response,
> +	 * in the order they were received in the response.
> +	 */
> +	struct strvec wwwauth_headers;

I like this careful documentation.

> +	unsigned header_is_last_match:1;

But then this member is unclear how it is attached. It could use its
own "for internal use" comment if we don't want to describe it in full
detail here.

> +static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
> +{
> +	size_t size = eltsize * nmemb;
> +	struct strvec *values = &http_auth.wwwauth_headers;
> +	struct strbuf buf = STRBUF_INIT;
> +	const char *val;
> +	const char *z = NULL;
> +
> +	/*
> +	 * Header lines may not come NULL-terminated from libcurl so we must
> +	 * limit all scans to the maximum length of the header line, or leverage
> +	 * strbufs for all operations.
> +	 *
> +	 * In addition, it is possible that header values can be split over
> +	 * multiple lines as per RFC 2616 (even though this has since been
> +	 * deprecated in RFC 7230). A continuation header field value is
> +	 * identified as starting with a space or horizontal tab.
> +	 *
> +	 * The formal definition of a header field as given in RFC 2616 is:
> +	 *
> +	 *   message-header = field-name ":" [ field-value ]
> +	 *   field-name     = token
> +	 *   field-value    = *( field-content | LWS )
> +	 *   field-content  = <the OCTETs making up the field-value
> +	 *                    and consisting of either *TEXT or combinations
> +	 *                    of token, separators, and quoted-string>
> +	 */
> +
> +	strbuf_add(&buf, ptr, size);
> +
> +	/* Strip the CRLF that should be present at the end of each field */

Is it really a CRLF? Or just an LF?

> +	strbuf_trim_trailing_newline(&buf);

Thankfully, this will trim an LF _or_ CR/LF pair, so either way would be fine.

> +	/* Start of a new WWW-Authenticate header */
> +	if (skip_iprefix(buf.buf, "www-authenticate:", &val)) {
> +		while (isspace(*val)) val++;

Break the "val++;" to its own line:

		while (isspace(*val))
			val++;

While we are here, do we need to be careful about the end of the string at
this point? Is it possible that the server will send all spaces up until the
maximum header size (as mentioned in the message)?

> +
> +		strvec_push(values, val);
> +		http_auth.header_is_last_match = 1;
> +		goto exit;
> +	}
> +
> +	/*
> +	 * This line could be a continuation of the previously matched header
> +	 * field. If this is the case then we should append this value to the
> +	 * end of the previously consumed value.
> +	 */
> +	if (http_auth.header_is_last_match && isspace(*buf.buf)) {
> +		const char **v = values->v + values->nr - 1;

I suppose we expect leading spaces as critical to this header, right?

> +		char *append = xstrfmt("%s%.*s", *v, (int)(size - 1), ptr + 1);

We might have better luck using a strbuf, initializing it with the expected
size and using strbuf_add() to append the strings. Maybe I'm just prematurely
optimizing, though.

> +
> +		free((void*)*v);
> +		*v = append;
> +
> +		goto exit;
> +	}
> +
> +	/* This is the start of a new header we don't care about */
> +	http_auth.header_is_last_match = 0;
> +
> +	/*
> +	 * If this is a HTTP status line and not a header field, this signals
> +	 * a different HTTP response. libcurl writes all the output of all
> +	 * response headers of all responses, including redirects.
> +	 * We only care about the last HTTP request response's headers so clear
> +	 * the existing array.
> +	 */
> +	if (skip_iprefix(buf.buf, "http/", &z))
> +		strvec_clear(values);
> +
> +exit:
> +	strbuf_release(&buf);
> +	return size;
> +}
> +
>  size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf)
>  {
>  	return nmemb;
> @@ -1829,6 +1904,8 @@ static int http_request(const char *url,
>  					 fwrite_buffer);
>  	}
>  
> +	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_wwwauth);

Nice integration point!

Thanks,
-Stolee
