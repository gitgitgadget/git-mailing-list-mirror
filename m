Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31261C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 23:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiLNXSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 18:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiLNXSN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 18:18:13 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961284A5B2
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:18:11 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 36so3015363pgp.10
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=10O35PWCCOiMWCj+Y24Yt7c4vytMbXXPhUuQZmz1NHk=;
        b=L0bYvr7+x5ZBZh2UoKhgjlpIKbtOx6WyzLgVxVktBQo04xG3NWRhmbhSMX7a+LmRz0
         wk5/GMI1yIWyz8Yuc6hH/3abH3AUb5MjQEX7zmRyhtdhSXwGRpDd4RYaPZUopyhhfP1N
         YiDIZJ1SDgVAepxicXtQDn8+HtDtye9MXkKNwJHu70za92NSWT/wGZoaB6f3BAogHbLl
         LVFzjtYLaeMx324UDjNW/QhMRZo2TfEarsaLzlV/t0lwoMGTKhS6LXSTn2VqMNjHmPCz
         TdhHF+IQEQnTyVwT5IAMy1tkhLYXGrN2p36rTuXBHeKqSPRkMm2bjGgGr16XKBvNKldY
         BNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10O35PWCCOiMWCj+Y24Yt7c4vytMbXXPhUuQZmz1NHk=;
        b=bNz7A6NvRG3ZhzMKRHSz26DHr2S64bkLAU732/nceaKIEqbdiLega/BviXlZU8oa/7
         IeNVewmHXpfi1+mXZnPEYhPCe/Q3eg8APO1Q8dI5GcckJ5wp/wxwlgZV4f8OfYUHsYsl
         fhPNml0wpUuRC56Pi9o+i4ZboCl0J2hfozkKydY5gFa5tHTyf9kK8Hu5GTKedGWcpEYe
         KwWXvZGh+klcugNLwioL07a+ncYpBJuTRaeY35a3dyExBFGLCl8dxjaZwnRbxpiJOR/D
         b7aRoH+x0CMoDW+/XWvjQZdxuCvXYCeMNJeutWJH5u/0X/DAs0tfkDeMpKJu/9HixTHA
         FeJg==
X-Gm-Message-State: ANoB5pmtSrp5eMc50GC+MixUuk9xyqxmcNsXqkKfmRYBHohKnBJCK0a7
        qSm6MiRhGVJcdCfxh+D7mpQt
X-Google-Smtp-Source: AA0mqf5XEjgw5mliQBOCJRXYCACy+L56nonSSrXXRT4xj2OwH/etkM2qgP/mdh97kAplGmFoKeLxxA==
X-Received: by 2002:a05:6a00:1696:b0:56e:dca8:ba71 with SMTP id k22-20020a056a00169600b0056edca8ba71mr33711932pfc.32.1671059890948;
        Wed, 14 Dec 2022 15:18:10 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id a11-20020aa78e8b000000b005772d55df03sm391261pfr.35.2022.12.14.15.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 15:18:10 -0800 (PST)
Message-ID: <e957d4f4-fa94-7a68-f378-38e6ed131244@github.com>
Date:   Wed, 14 Dec 2022 15:18:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v4 5/8] test-http-server: add HTTP request parsing
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
 <5c4e36e23eecbb7841078939a982b7150e2f4ab8.1670880984.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <5c4e36e23eecbb7841078939a982b7150e2f4ab8.1670880984.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew John Cheetham via GitGitGadget wrote:
> +/*
> + * Read the HTTP request up to the start of the optional message-body.
> + * We do this byte-by-byte because we have keep-alive turned on and
> + * cannot rely on an EOF.
> + *
> + * https://tools.ietf.org/html/rfc7230
> + *
> + * We cannot call die() here because our caller needs to properly
> + * respond to the client and/or close the socket before this
> + * child exits so that the client doesn't get a connection reset
> + * by peer error.
> + */
> +static enum worker_result req__read(struct req *req, int fd)
> +{
> +	struct strbuf h = STRBUF_INIT;
> +	struct string_list start_line_fields = STRING_LIST_INIT_DUP;
> +	int nr_start_line_fields;
> +	const char *uri_target;
> +	const char *query;
> +	char *hp;
> +	const char *hv;
> +
> +	enum worker_result result = WR_OK;
> +
> +	/*
> +	 * Read line 0 of the request and split it into component parts:
> +	 *
> +	 *    <method> SP <uri-target> SP <HTTP-version> CRLF
> +	 *
> +	 */
> +	if (strbuf_getwholeline_fd(&req->start_line, fd, '\n') == EOF) {
> +		result = WR_OK | WR_HANGUP;
> +		goto done;
> +	}
> +
> +	strbuf_trim_trailing_newline(&req->start_line);
> +
> +	nr_start_line_fields = string_list_split(&start_line_fields,
> +						 req->start_line.buf,
> +						 ' ', -1);
> +	if (nr_start_line_fields != 3) {
> +		logerror("could not parse request start-line '%s'",
> +			 req->start_line.buf);
> +		result = WR_IO_ERROR;
> +		goto done;
> +	}
> +
> +	req->method = xstrdup(start_line_fields.items[0].string);
> +	req->http_version = xstrdup(start_line_fields.items[2].string);
> +
> +	uri_target = start_line_fields.items[1].string;
> +
> +	if (strcmp(req->http_version, "HTTP/1.1")) {
> +		logerror("unsupported version '%s' (expecting HTTP/1.1)",
> +			 req->http_version);
> +		result = WR_IO_ERROR;
> +		goto done;
> +	}
> +
> +	query = strchr(uri_target, '?');
> +
> +	if (query) {
> +		strbuf_add(&req->uri_path, uri_target, (query - uri_target));
> +		strbuf_trim_trailing_dir_sep(&req->uri_path);
> +		strbuf_addstr(&req->query_args, query + 1);
> +	} else {
> +		strbuf_addstr(&req->uri_path, uri_target);
> +		strbuf_trim_trailing_dir_sep(&req->uri_path);
> +	}

This "line 0" parsing looks good, and aligns with the RFC you linked
(specifically section 3.1.1 [1]).

[1] https://www.rfc-editor.org/rfc/rfc7230#section-3.1.1

> +
> +	/*
> +	 * Read the set of HTTP headers into a string-list.
> +	 */
> +	while (1) {
> +		if (strbuf_getwholeline_fd(&h, fd, '\n') == EOF)
> +			goto done;
> +		strbuf_trim_trailing_newline(&h);
> +
> +		if (!h.len)
> +			goto done; /* a blank line ends the header */
> +
> +		hp = strbuf_detach(&h, NULL);
> +		string_list_append(&req->header_list, hp);
> +
> +		/* store common request headers separately */
> +		if (skip_prefix(hp, "Content-Type: ", &hv)) {
> +			req->content_type = hv;
> +		} else if (skip_prefix(hp, "Content-Length: ", &hv)) {
> +			req->content_length = strtol(hv, &hp, 10);
> +		}

The "separately" is somewhat confusing - you unconditionally add 'hp' to
'req->header_list', so the "Content-Type" and "Content-Length" headers are
included there as well. If that's the desired behavior, a comment like "Also
store common headers as 'req' fields" might be clearer.

> +	}
> +
> +	/*
> +	 * We do not attempt to read the <message-body>, if it exists.
> +	 * We let our caller read/chunk it in as appropriate.
> +	 */
> +
> +done:
> +	string_list_clear(&start_line_fields, 0);
> +
> +	/*
> +	 * This is useful for debugging the request, but very noisy.
> +	 */
> +	if (trace2_is_enabled()) {

'trace2_printf()' is gated internally by 'trace2_enabled' anyway, so I don't
think this 'if()' is necessary. You could add a 'DEBUG_HTTP_SERVER'
preprocessor directive (like 'DEBUG_CACHE_TREE' in 'cache-tree.c') if you
wanted to prevent these printouts unless a developer sets it to '1'.

> +		struct string_list_item *item;
> +		trace2_printf("%s: %s", TR2_CAT, req->start_line.buf);
> +		trace2_printf("%s: hver: %s", TR2_CAT, req->http_version);
> +		trace2_printf("%s: hmth: %s", TR2_CAT, req->method);
> +		trace2_printf("%s: path: %s", TR2_CAT, req->uri_path.buf);
> +		trace2_printf("%s: qury: %s", TR2_CAT, req->query_args.buf);
> +		if (req->content_length >= 0)
> +			trace2_printf("%s: clen: %d", TR2_CAT, req->content_length);
> +		if (req->content_type)
> +			trace2_printf("%s: ctyp: %s", TR2_CAT, req->content_type);
> +		for_each_string_list_item(item, &req->header_list)
> +			trace2_printf("%s: hdrs: %s", TR2_CAT, item->string);
> +	}
> +
> +	return result;
> +}
> +
> +static enum worker_result dispatch(struct req *req)
> +{
> +	return send_http_error(1, 501, "Not Implemented", -1, NULL,
> +			       WR_OK | WR_HANGUP);

Although the request is now being read & parsed, the response creation code
is still a hardcoded "Not Implemented". This means that the now-parsed 'req'
is be temporarily unused, but I think that's reasonable (since it allows for
breaking up the implementation of 'test-http-server' into multiple, less
overwhelming patches).

> +}
> +
>  static enum worker_result worker(void)
>  {
> +	struct req req = REQ__INIT;
>  	char *client_addr = getenv("REMOTE_ADDR");
>  	char *client_port = getenv("REMOTE_PORT");
>  	enum worker_result wr = WR_OK;
> @@ -160,8 +324,16 @@ static enum worker_result worker(void)
>  	set_keep_alive(0);
>  
>  	while (1) {
> -		wr = send_http_error(1, 501, "Not Implemented", -1, NULL,
> -			WR_OK | WR_HANGUP);
> +		req__release(&req);
> +
> +		alarm(init_timeout ? init_timeout : timeout);
> +		wr = req__read(&req, 0);
> +		alarm(0);

I know 'init_timeout' and 'timeout' were pulled from 'daemon.c', but what's
the difference between them/why do they both exist? It looks like
'init_timeout' just acts as a permanent override to the value of 'timeout'.

> +
> +		if (wr & WR_STOP_THE_MUSIC)
> +			break;
> +
> +		wr = dispatch(&req);
>  		if (wr & WR_STOP_THE_MUSIC)
>  			break;
>  	}

