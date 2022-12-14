Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E844AC4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 23:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiLNXPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 18:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiLNXPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 18:15:09 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE7E193E5
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:15:08 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso872625pjh.1
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WGX6nRNT8G0RFBqg1BRLIC8sFBTW3kB7yFhjwhJFnlY=;
        b=c8ihR4z5zqDafoRO0ygudgvvFVUytKIcuXENq1pxcfxC5oQOkeW57FAo9ulS9sXaFn
         9vAJn+Ai/BxwCLdRf74Ehb1JbkOEoVSmk+8TxyUxgQHUrI9YNPwUQ1xUpAr97JUZpHTZ
         X7+opYpXcbuFTq3C+Edmei9tf3D5Z7SM4/FYjOeSbvlWs5kLHg8xYHB5cc4nGHqE2joG
         y8DAT9WgMWM1Ms4Kmn1ngPlJCNFKsya/bwDoaMRkwTMZYVJE3kT6ViMshTb40ACuEqKg
         aQYICy2MHLh2C86AoxGYpMKhilCZsz9sFu0DlYAsC2jihC2Pumdu0q/A1K/X1bK/w8aW
         Z2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WGX6nRNT8G0RFBqg1BRLIC8sFBTW3kB7yFhjwhJFnlY=;
        b=A7oWI9Ki5lMD0z6CoR0f4Wc+V/BzGFqx8DazYYXhhTuzPdkdzygVxu6AZd3m/CQinL
         noC5Rd4POSBaklye+4WH/70To8DlEiPXZULFJdD3y7hh3XUsRrwc6bF+JS+GciyKvXdJ
         B6emDDHd/xUIQi7VCfG9y+Wflesl+OFwlVs0PbyUtOwoWFXaH1HBJhpE5ABBrowBCU5w
         VBRDkbSGwhWH+bN32teeoLi44pSMFmXJuin4nqRfwlN96hgmkfEqyt1sEKpU8HsTC27p
         qAdVO2+/oB5MIb1owtOL36UqDepq4v1pNojx9VE3RjloU0QIadVmfQIITFR9POz/T55c
         IhAA==
X-Gm-Message-State: ANoB5pmKwzJcauJ9zMQk7tD6MvKm35PXBmv6xio4o942djlqIpHrXmJb
        cY+jOI10zeyI3uwf1UhN7OdN
X-Google-Smtp-Source: AA0mqf4ItgzCwVzZHlo1dxtgj4d9HouX+dzmkG7UvaHaBop2hQsx6ckNY+rL/y5hKUmpBosxUk/okQ==
X-Received: by 2002:a17:903:428d:b0:189:5385:41c6 with SMTP id ju13-20020a170903428d00b00189538541c6mr24126877plb.6.1671059708321;
        Wed, 14 Dec 2022 15:15:08 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902d2cf00b00176b84eb29asm2315599plc.301.2022.12.14.15.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 15:15:07 -0800 (PST)
Message-ID: <c255896d-637d-f7b0-8698-10a2112852c1@github.com>
Date:   Wed, 14 Dec 2022 15:15:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v4 1/8] http: read HTTP WWW-Authenticate response headers
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
 <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <b5b56ccd9419353a4bf5bc9d751a711af07d2197.1670880984.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <b5b56ccd9419353a4bf5bc9d751a711af07d2197.1670880984.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew John Cheetham via GitGitGadget wrote:
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
> +	strbuf_trim_trailing_newline(&buf);
> +
> +	/* Start of a new WWW-Authenticate header */
> +	if (skip_iprefix(buf.buf, "www-authenticate:", &val)) {
> +		while (isspace(*val))
> +			val++;

Per the RFC [1]: 

> The field value MAY be preceded by any amount of LWS, though a single SP
> is preferred.

And LWS (linear whitespace) is defined as:

> CRLF           = CR LF 
> LWS            = [CRLF] 1*( SP | HT )

and 'isspace()' includes CR, LF, SP, and HT [2]. 

Looks good!

[1] https://datatracker.ietf.org/doc/html/rfc2616#section-4-2
[2] https://linux.die.net/man/3/isspace

> +
> +		strvec_push(values, val);

I had the same question about "what happens with an empty 'val' here?" as
Stolee did earlier [3], but I *think* the "zero length" (i.e., single null
terminator) will be copied successfully. It's probably worth testing that
explicitly, though (I see you set up tests in later patches - ideally a 
"www-authenticate:<mix of whitespace>" line could be tested there).

[3] https://lore.kernel.org/git/9fded44b-c503-f8e5-c6a6-93e882d50e27@github.com/

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
> +		char *append = xstrfmt("%s%.*s", *v, (int)(size - 1), ptr + 1);

In this case (where the line is a continuation of a 'www-authenticate'
header), it looks like the code here expects *exactly* one LWS at the start
of the line ('isspace(*buf.buf)' requiring at least one space to append the
header, 'ptr + 1' skipping no more than one). But, according to the RFC, it
could be more than one:

> Header fields can be extended over multiple lines by preceding each extra
> line with at least one SP or HT.

So I think 'buf.buf' might need to have all preceding spaces removed, like
you did in the "Start of a new WWW-Authenticate header" block.

Also, if you're copying 'ptr' into 'buf' to avoid issues from a missing null
terminator, wouldn't you want to use 'buf.buf' (instead of 'ptr') in
'xstrfmt()'?

> +
> +		free((void*)*v);
> +		*v = append;

I was about to suggest (optionally) rewriting this to use 'strvec_pop()' and
'strvec_push_nodup()':

	strvec_pop(values); 
	strvec_push_nodup(values, append);

to maybe make this a bit easier to follow, but unfortunately
'strvec_push_nodup()' isn't available outside of 'strvec.c'. If you did want
to use 'strvec' functions, you could remove the 'static' from
'strvec_push_nodup()' and add it to 'strvec.h' it in a later reroll, but I
don't consider that change "blocking" or even important enough to warrant
its own reroll. 

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

The comments describing the intended behavior (as well as the commit
message) are clear and explain the somewhat esoteric (at least to my
untrained eye ;) ) code. Thanks!

> +
> +exit:
> +	strbuf_release(&buf);
> +	return size;
> +}
> +
>  size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf)
>  {
>  	return nmemb;
> @@ -1864,6 +1940,8 @@ static int http_request(const char *url,
>  					 fwrite_buffer);
>  	}
>  
> +	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_wwwauth);
> +
>  	accept_language = http_get_accept_language_header();
>  
>  	if (accept_language)

