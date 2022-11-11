Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C98EC4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 17:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiKKRzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 12:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbiKKRzh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 12:55:37 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA927DE90
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 09:55:36 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id o15-20020a17090aac0f00b00212e93524c0so5797998pjq.2
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 09:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3IGJR2/G2VkthzlytHLZxtKIM2jyBhtkkGfXZFMQXi4=;
        b=nreNd1A3pt4gbV0PliZxf4EIzCw32B2mDnKtwq25/bEnbCuWRvCgkQ2xBe9Ba8H5MS
         udb4UWB+lz05qvt08bpm3nJK3etg0S06Xv8P0nRxZmP4u2fdOiXBEHtZp+ewUCepn4Dp
         eIQq0jrYx1aEfE9WUsAo880X5b7UKEynhNstBuBBX0maGoW+Rlsv4OigEqzLUQ/metTP
         AUV1JO/Qz/tFwJEP89xaJmXpbWLRR0qixYkHaEJ5XDqbxo9C60H82le9wisSXBlYzRE8
         H6+jbOEUmPThyHBuPGpAncEL+kCVMV7Ru1ZcxYJ8PD5IpSFbwdc5zKtYRZslCi03oXrd
         7GSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IGJR2/G2VkthzlytHLZxtKIM2jyBhtkkGfXZFMQXi4=;
        b=FS/oD0PSbqj5bbHkU5VvxE2sTZVISbAQe8KSdN4cKHfvGaw+h5r53a5AQaVR+P5kqA
         JZHJo04DhfJYiCuo5dVUrtnuAfCzYpJ207pP635ErCz1kaGS0r5dNvzSsWRzKTDxE3rx
         SKurqmF0tcFBwJNjLyZZ7AUt+A8cLCCAin2G1nm8WacohWM8/FK6uCQL19GsOW02637x
         BFOlsoKK9QN6KSJRf23xO7t8Mdxoj2RoxqUtyMoNyoeOQ2VGMgOzZRB2FJo65bQpgZEJ
         ERz3YT7G31uI1kByJB/1s2I89T/OkRo3+JiKUvZ1/KzPZwDjrY9BH7F/6PmrJm/bkrF0
         ANbg==
X-Gm-Message-State: ANoB5pkNhgb4xoPsfFeJdo8JtRhRIc3BIyXPwFW8dbRR2sETC3hYg9Yu
        FUUEFdrHDbUzBQFzwiGGwkhTPBhDhhB18A==
X-Google-Smtp-Source: AA0mqf4u+tu2Oi3RkPFiHIYF59bSJPp27GMa0DKMYAGdJit0uqBCYZp14uLDcvwcd1JUPZaZYzCTVeUWuEFHvg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1c86:b0:56b:d027:214 with SMTP
 id y6-20020a056a001c8600b0056bd0270214mr3674760pfw.79.1668189336166; Fri, 11
 Nov 2022 09:55:36 -0800 (PST)
Date:   Fri, 11 Nov 2022 09:55:34 -0800
In-Reply-To: <Y221kGaQUfZJznO9@coredump.intra.peff.net>
Mime-Version: 1.0
References: <pull.1377.git.git.1667955151994.gitgitgadget@gmail.com>
 <pull.1377.v2.git.git.1668121055059.gitgitgadget@gmail.com> <Y221kGaQUfZJznO9@coredump.intra.peff.net>
Message-ID: <kl6ly1sh1ill.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2] http: redact curl h2h3 headers in info
From:   Glen Choo <chooglen@google.com>
To:     Jeff King <peff@peff.net>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Nov 10, 2022 at 10:57:34PM +0000, Glen Choo via GitGitGadget wrote:
>
>> +/* Redact headers in info */
>> +static void redact_sensitive_info_header(struct strbuf *header)
>> +{
>> +	const char *sensitive_header;
>> +
>> +	/*
>> +	 * curl's h2h3 prints headers in info, e.g.:
>> +	 *   h2h3 [<header-name>: <header-val>]
>> +	 */
>> +	if (trace_curl_redact &&
>> +	    skip_iprefix(header->buf, "h2h3 [", &sensitive_header)) {
>> +		struct strbuf inner = STRBUF_INIT;
>> +
>> +		/* Drop the trailing "]" */
>> +		strbuf_add(&inner, sensitive_header, strlen(sensitive_header) - 1);
>
> This will misbehave if fed the string "h2h3 [", because that strlen()
> becomes 0, and the subtraction underflows.
>
> Unlikely, since we are being fed by curl, but possibly worth asserting
> (though see below for an alternative which drops this line).
>
>> +		if (redact_sensitive_header(&inner)) {
>> +			strbuf_setlen(header, strlen("h2h3 ["));
>
> This strlen may be better spelled as:
>
>   sensitive_header - header->buf
>
> which IMHO makes it more clear that our intent is to truncate based on
> the pointer we computed by skipping (and has no chance of getting out of
> sync with the earlier copy of the string).
>
> It's also a little more robust, in that it doesn't depend on "h2h3"
> being at the beginning of the string (though in practice it must be,
> because that's where skip_iprefix() is checking). See below on that.
>
>> +			strbuf_addbuf(header, &inner);
>> +			strbuf_addch(header, ']');
>> +		}
>> +
>> +		strbuf_release(&inner);
>
> This will do a new allocation/free for each info line, even if it's not
> redacted. It's probably premature optimization to worry about it, but
> you could do it all in the original strbuf, if we inform
> redact_sensitive_header() of the offset at which it should look for the
> header (and because it uses "sensitive_header - header->buf" for the
> truncation, it handles the extra "h2h3" at the beginning just fine).
> Something like:
>
> diff --git a/http.c b/http.c
> index 8135fac283..8a5ba3f477 100644
> --- a/http.c
> +++ b/http.c
> @@ -561,14 +561,14 @@ static void set_curl_keepalive(CURL *c)
>  #endif
>  
>  /* Return 1 if redactions have been made, 0 otherwise. */
> -static int redact_sensitive_header(struct strbuf *header)
> +static int redact_sensitive_header(struct strbuf *header, size_t offset)
>  {
>  	int ret = 0;
>  	const char *sensitive_header;
>  
>  	if (trace_curl_redact &&
> -	    (skip_iprefix(header->buf, "Authorization:", &sensitive_header) ||
> -	     skip_iprefix(header->buf, "Proxy-Authorization:", &sensitive_header))) {
> +	    (skip_iprefix(header->buf + offset, "Authorization:", &sensitive_header) ||
> +	     skip_iprefix(header->buf + offset, "Proxy-Authorization:", &sensitive_header))) {
>  		/* The first token is the type, which is OK to log */
>  		while (isspace(*sensitive_header))
>  			sensitive_header++;
> @@ -579,7 +579,7 @@ static int redact_sensitive_header(struct strbuf *header)
>  		strbuf_addstr(header, " <redacted>");
>  		ret = 1;
>  	} else if (trace_curl_redact &&
> -		   skip_iprefix(header->buf, "Cookie:", &sensitive_header)) {
> +		   skip_iprefix(header->buf + offset, "Cookie:", &sensitive_header)) {
>  		struct strbuf redacted_header = STRBUF_INIT;
>  		const char *cookie;
>  
> @@ -631,17 +631,10 @@ static void redact_sensitive_info_header(struct strbuf *header)
>  	 */
>  	if (trace_curl_redact &&
>  	    skip_iprefix(header->buf, "h2h3 [", &sensitive_header)) {
> -		struct strbuf inner = STRBUF_INIT;
> -
> -		/* Drop the trailing "]" */
> -		strbuf_add(&inner, sensitive_header, strlen(sensitive_header) - 1);
> -		if (redact_sensitive_header(&inner)) {
> -			strbuf_setlen(header, strlen("h2h3 ["));
> -			strbuf_addbuf(header, &inner);
> +		if (redact_sensitive_header(header, sensitive_header - header->buf)) {
> +			/* redaction ate our closing bracket */
>  			strbuf_addch(header, ']');
>  		}
> -
> -		strbuf_release(&inner);
>  	}
>  }
>  
> @@ -659,7 +652,7 @@ static void curl_dump_header(const char *text, unsigned char *ptr, size_t size,
>  
>  	for (header = headers; *header; header++) {
>  		if (hide_sensitive_header)
> -			redact_sensitive_header(*header);
> +			redact_sensitive_header(*header, 0);
>  		strbuf_insertstr((*header), 0, text);
>  		strbuf_insertstr((*header), strlen(text), ": ");
>  		strbuf_rtrim((*header));

As someone who's still trying to wrap my head around pointer
manipulations, these suggestions are very welcome, thanks!

I'll take these suggestions along with the HTTP2 one.
