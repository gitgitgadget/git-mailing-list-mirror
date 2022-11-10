Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBABEC4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 21:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiKJV5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 16:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiKJV5m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 16:57:42 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780991E3FF
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 13:57:41 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id g24so2690602plq.3
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 13:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IGviH22zfLcOWGop780aXRvabWjS/UbLsyCQyLyChts=;
        b=MBQOMd7FtMbJ0tN/dKTBf28I2DyBQShxt/IEDDYORurnasQeXqOcd8boT4t6ap2uqJ
         +7cJqL0OgAgv6ICyNjNgwPqmyJlcsSRM73giDTfilgVHUrHkSBnAzKHgX0plTeML/6nd
         9EdWupbTVqZtN5/PFuAHxo9FwpjOemul6KEPZhfo8+X7g30OT/XG9cHH6bqH6TwKEShn
         DjSNcMlhadsbCFhwKN3G4b22dDVjgLUnIOX6EtCrz7QobZ/6HoYCcmmOuTRmbbg6I8th
         c2+yS9wbGrp27BRWjBiGyo8+63vvkvhZiXeWC1PDpV0zut6vV8PVVonblkm+WE4BLcC5
         Ev+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGviH22zfLcOWGop780aXRvabWjS/UbLsyCQyLyChts=;
        b=bPrmsozOTMsDtKfqrOcBhqEj7N+r0C4mLVBl0o1IlViGh6CcW2vjTsLobVr/RZQ3Ni
         DFco8cyWFJQ7IoKDlT6J5gFmBaRtCr1oDcaQ3XPeCm9ZrnZwrXNahmZf6IzdfP9//oFz
         Ly1QCAIUIsRKDq8WLO/TPi5jndekdtXypwbnIZoE3bsJ+dZygX1rEQw1fYXwkTIWwRWI
         isGbpbiFw96WfjreWRJrNLI1viYgrftQ/ovLz5KJcJd2f14McDF3rnAn8RbVFOXKxW5k
         6r/BQJobKZ6V7H6JpoVU1O2n0TTnMprRJJz+ccRjTFYTJy9iWw600cpTB2bikRqggpLe
         O/Ow==
X-Gm-Message-State: ACrzQf3wkACHgnH9ukYCqlnMwwwmfh1vPe0mfXqgM4r8f1fNeDgefQMh
        ngR7bBhIrF1z3du5gJDdidHGYg==
X-Google-Smtp-Source: AMsMyM5Z+F8J+bVPxjVtfxY15MJyoWfxzACIsLPNWm0MCNxcSLln2mGlDEM9I+2bpZK/Sjb5Zsu3gw==
X-Received: by 2002:a17:902:d544:b0:176:b0ce:3472 with SMTP id z4-20020a170902d54400b00176b0ce3472mr2173296plf.169.1668117460613;
        Thu, 10 Nov 2022 13:57:40 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:d072:d86:e0b4:a3a3])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902654e00b001743ba85d39sm167985pln.110.2022.11.10.13.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 13:57:39 -0800 (PST)
Date:   Thu, 10 Nov 2022 13:57:35 -0800
From:   Emily Shaffer <nasamuffin@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] http: redact curl h2h3 headers in info
Message-ID: <Y21zz1HYXzyyfwqy@google.com>
References: <pull.1377.git.git.1667955151994.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1377.git.git.1667955151994.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2022 at 12:52:31AM +0000, Glen Choo via GitGitGadget wrote:
> 
> With GIT_TRACE_CURL=1 or GIT_CURL_VERBOSE=1, sensitive headers like
> "Authorization" and "Cookie" get redacted. However, since [1], curl's
> h2h3 module also prints headers in its "info", which don't get redacted.
> For example,
> 
>   echo 'github.com	TRUE	/	FALSE	1698960413304	o	foo=bar' >cookiefile &&
>   GIT_TRACE_CURL=1 GIT_TRACE_CURL_NO_DATA=1 git \
>     -c 'http.cookiefile=cookiefile' \
>     -c 'http.version=' \
>     ls-remote https://github.com/git/git refs/heads/main 2>output &&
>   grep 'cookie' output
> 
> produces output like:
> 
>   23:04:16.920495 http.c:678              == Info: h2h3 [cookie: o=foo=bar]
>   23:04:16.920562 http.c:637              => Send header: cookie: o=<redacted>
> 
> Teach http.c to check for h2h3 headers in info and redact them using the
> existing header redaction logic.
> 
> [1] https://github.com/curl/curl/commit/f8c3724aa90472c0e617ddbbc420aa199971eb77
> 
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>     http: redact curl h2h3 headers in info
>     
>     I initially sent this to the security list, but the general impression
>     is that this isn't sensitive enough for an embargoed fix, so this is
>     better discussed in the open instead.
>     
>     Since this comes from curl's HTTP2.0/3.0 module, this can be mitigated
>     by setting http.version to 1.X, e.g. "git -c http.version=HTTP/1.1".
>     
>     According to [1], the susceptible curl versions appear to be 7.86.0,
>     7.85.0, 7.84.0, 7.83.1, 7.83.0, 7.82.0, but I'm not sure which platforms
>     are vulnerable.
>     
>     This patch fixes the issue on my machine running curl 7.85.0, so I think
>     it is okay to merge as-is. That said, I would strongly prefer to add
>     tests, but I haven't figured out how. In particular:
>     
>      * Do we have a way of using HTTP/2.0 in our tests? A cursory glance at
>        our httpd config suggests that we only use HTTP/1.1.
>      * How could we set up end-to-end tests to ensure that we're testing
>        this against affected versions of curl? To avoid regressions, I'd
>        also prefer to test against future versions of curl too.
>     
>     [1]
>     https://github.com/curl/curl/commit/f8c3724aa90472c0e617ddbbc420aa199971eb77
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1377%2Fchooglen%2Fhttp%2Fredact-h2h3-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1377/chooglen/http/redact-h2h3-v1
> Pull-Request: https://github.com/git/git/pull/1377
> 
>  http.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/http.c b/http.c
> index 5d0502f51fd..cbcc7c3f5b6 100644
> --- a/http.c
> +++ b/http.c
> @@ -560,8 +560,10 @@ static void set_curl_keepalive(CURL *c)
>  }
>  #endif
>  
> -static void redact_sensitive_header(struct strbuf *header)
> +/* Return 0 if redactions been made, 1 otherwise. */

Does it make sense to reverse the retval here?

`if (!redact_sensitive_header())` sounds like "if not redacted, ..." -
but here it means the opposite, right?

> +static int redact_sensitive_header(struct strbuf *header)
>  {
> +	int ret = 1;
>  	const char *sensitive_header;
>  
>  	if (trace_curl_redact &&
> @@ -575,6 +577,7 @@ static void redact_sensitive_header(struct strbuf *header)
>  		/* Everything else is opaque and possibly sensitive */
>  		strbuf_setlen(header,  sensitive_header - header->buf);
>  		strbuf_addstr(header, " <redacted>");
> +		ret = 0;
>  	} else if (trace_curl_redact &&
>  		   skip_iprefix(header->buf, "Cookie:", &sensitive_header)) {
>  		struct strbuf redacted_header = STRBUF_INIT;
> @@ -612,6 +615,27 @@ static void redact_sensitive_header(struct strbuf *header)
>  
>  		strbuf_setlen(header, sensitive_header - header->buf);
>  		strbuf_addbuf(header, &redacted_header);
> +		ret = 0;
> +	}
> +	return ret;
> +}
> +
> +/* Redact headers in info */
> +static void redact_sensitive_info_header(struct strbuf *header)
> +{
> +	const char *sensitive_header;
> +
> +	if (trace_curl_redact &&
> +	    skip_iprefix(header->buf, "h2h3 [", &sensitive_header)) {
> +		struct strbuf inner = STRBUF_INIT;
> +
> +		/* Drop the trailing "]" */
> +		strbuf_add(&inner, sensitive_header, strlen(sensitive_header) - 1);
> +		if (!redact_sensitive_header(&inner)) {
> +			strbuf_setlen(header, strlen("h2h3 ["));
> +			strbuf_addbuf(header, &inner);
> +			strbuf_addch(header, ']');

I'd really like some more comments in this function - even just one
describing the string we're trying to redact, or showing a sample line.
Navigating string parsing is always a bit difficult.

> +		}
>  	}
>  }
>  
> @@ -668,6 +692,18 @@ static void curl_dump_data(const char *text, unsigned char *ptr, size_t size)
>  	strbuf_release(&out);
>  }
>  
> +static void curl_print_info(char *data, size_t size)

Nit: Every other helper in this file calls it _dump_, so should this
also say _dump_ instead of _print_?

> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	strbuf_add(&buf, data, size);
> +
> +	redact_sensitive_info_header(&buf);
> +	trace_printf_key(&trace_curl, "== Info: %s", buf.buf);
> +
> +	strbuf_release(&buf);
> +}
> +
>  static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size, void *userp)
>  {
>  	const char *text;
> @@ -675,7 +711,7 @@ static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size,
>  
>  	switch (type) {
>  	case CURLINFO_TEXT:
> -		trace_printf_key(&trace_curl, "== Info: %s", data);
> +		curl_print_info(data, size);
>  		break;
>  	case CURLINFO_HEADER_OUT:
>  		text = "=> Send header";
> 
> base-commit: c03801e19cb8ab36e9c0d17ff3d5e0c3b0f24193

Otherwise functionally it seems fine to me. case CURLINFO_TEXT is the
one case that's not already using a curl_dump_* helper, so we're adding
one, and to that helper we're adding a call out to
redact_sensitive_header().

Thanks.
 - Emily

> -- 
> gitgitgadget
