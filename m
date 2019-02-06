Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 063051F453
	for <e@80x24.org>; Wed,  6 Feb 2019 19:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfBFT3L (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 14:29:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38606 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfBFT3K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 14:29:10 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so3551907plb.5
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 11:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uXLM3cseERAzYKx1nUSOVMzmZ57YSaBNM1EHGqoln4A=;
        b=f9Ns9DAMqwyXP52VXEDsitIaV7c7KVWS3qah3WO+QrhE7FaRC7Z1B99r9DUm0DPXUk
         w+00t8hBiaXsaKZm/+ujlZDfxs7bWnVVQ2aAQvHNxN/zRyfnE3zAYLNBFr/t0w+/fz0q
         cEnNiv8V8ml5zmdc3+fR+bZWfK4mtMXMv3NpLQFlmv5IFbdmw711hp9Cvh2By+4uoJAM
         kzb6NdnkwAtKOsho+5F9tedZoetSm+9gMUZMUpzrKj1F2v8HADhj/3ZRxAK4RQkugR+l
         69CnR2lX/fziBVej/KXtg3/06Ll3BBtKL+WkU5K0/Rf7YgK2upI1i8bbfRjfAkQqkl8B
         YpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=uXLM3cseERAzYKx1nUSOVMzmZ57YSaBNM1EHGqoln4A=;
        b=fZyb3Yl5Ben9GS1i0NsJ0LSgTk59n8YSSlx2eMvusUBq89TgZznHpVLJMsqhoe/S3+
         h4N0e1eDbwzXe9X6mQYNFTVppOvZeYZM2neej3NMtC5QHGnEw4aAWtxlbjVzYeGbTx0x
         DqvDOztjtwjgyB08DIQzhCtzizyMdvoUHybBz75VeGwaikkyDIrxtCJAchdmUX0d5bBR
         A7pL9qat0Zpgb9HhLzKUXgPujVdXWtAtWuYoJSy6YNLr6qte1WHCZYIqZAqHjhDsbxVT
         WtK2HAPkafOnwIIMIJ/X1VctaVmFtyN06eplYd5fin5tzvrF4lXrT7l9vAcvRTzDadKn
         p75g==
X-Gm-Message-State: AHQUAuaruKjJyjpXnRpcMmCIs+NBAdcKQxf97GAxd9rIbdgCKUj0wIKQ
        PY1/suo/6JFTjgR0Mfbh45wrgg==
X-Google-Smtp-Source: AHgI3IbXOB1JQucByIU+6dXVRkl4OnKPdysEvm0x7Yqs6/9+1hrJYSbmza7SR0qqPjUtB5ep8EhHyg==
X-Received: by 2002:a17:902:9a98:: with SMTP id w24mr12283306plp.213.1549481349515;
        Wed, 06 Feb 2019 11:29:09 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id d3sm8824151pgl.64.2019.02.06.11.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 11:29:08 -0800 (PST)
Date:   Wed, 6 Feb 2019 11:29:03 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] remote-curl: refactor smart-http discovery
Message-ID: <20190206192903.GE72177@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
References: <20190206191657.GE10231@sigill.intra.peff.net>
 <20190206191848.GA10893@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206191848.GA10893@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.02.06 14:18, Jeff King wrote:
> After making initial contact with an http server, we have to decide if
> the server supports smart-http, and if so, which version. Our rules are
> a bit inconsistent:
> 
>   1. For v0, we require that the content-type indicates a smart-http
>      response. We also require the response to look vaguely like a
>      pkt-line starting with "#". If one of those does not match, we fall
>      back to dumb-http.
> 
>      But according to our http protocol spec[1]:
> 
>        Dumb servers MUST NOT return a return type starting with
>        `application/x-git-`.
> 
>      If we see the expected content-type, we should consider it
>      smart-http. At that point we can parse the pkt-line for real, and
>      complain if it is not syntactically valid.
> 
>   2. For v2, we do not actually check the content-type. Our v2 protocol
>      spec says[2]:
> 
>        When using the http:// or https:// transport a client makes a
>        "smart" info/refs request as described in `http-protocol.txt`[...]
> 
>      and the http spec is clear that for a smart-http response[3]:
> 
>        The Content-Type MUST be `application/x-$servicename-advertisement`.
> 
>      So it is required according to the spec.
> 
> These inconsistencies were easy to miss because of the way the original
> code was written as an inline conditional. Let's pull it out into its
> own function for readability, and improve a few things:
> 
>  - we now predicate the smart/dumb decision entirely on the presence of
>    the correct content-type
> 
>  - we do a real pkt-line parse before deciding how to proceed (and die
>    if it isn't valid)
> 
>  - use skip_prefix() for comparing service strings, instead of
>    constructing expected output in a strbuf; this avoids dealing with
>    memory cleanup
> 
> Note that this _is_ tightening what the client will allow. It's all
> according to the spec, but it's possible that other implementations
> might violate these. However, violating these particular rules seems
> like an odd choice for a server to make.
> 
> [1] Documentation/technical/http-protocol.txt, l. 166-167
> [2] Documentation/technical/protocol-v2.txt, l. 63-64
> [3] Documentation/technical/http-protocol.txt, l. 247
> 
> Helped-by: Josh Steadmon <steadmon@google.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  remote-curl.c | 100 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 57 insertions(+), 43 deletions(-)
> 
> diff --git a/remote-curl.c b/remote-curl.c
> index 2e04d53ac8..c78ba83744 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -331,9 +331,63 @@ static int get_protocol_http_header(enum protocol_version version,
>  	return 0;
>  }
>  
> +static void check_smart_http(struct discovery *d, const char *service,
> +			     struct strbuf *type)
> +{
> +	const char *p;
> +	struct packet_reader reader;
> +
> +	/*
> +	 * If we don't see x-$service-advertisement, then it's not smart-http.
> +	 * But once we do, we commit to it and assume any other protocol
> +	 * violations are hard errors.
> +	 */
> +	if (!skip_prefix(type->buf, "application/x-", &p) ||
> +	    !skip_prefix(p, service, &p) ||
> +	    strcmp(p, "-advertisement"))
> +		return;
> +
> +	packet_reader_init(&reader, -1, d->buf, d->len,
> +			   PACKET_READ_CHOMP_NEWLINE |
> +			   PACKET_READ_DIE_ON_ERR_PACKET);
> +	if (packet_reader_read(&reader) != PACKET_READ_NORMAL)
> +		die("invalid server response; expected service, got flush packet");

This can also trigger on an EOF or a delim packet, should we clarify the
error message?


> +
> +	if (skip_prefix(reader.line, "# service=", &p) && !strcmp(p, service)) {
> +		/*
> +		 * The header can include additional metadata lines, up
> +		 * until a packet flush marker.  Ignore these now, but
> +		 * in the future we might start to scan them.
> +		 */
> +		for (;;) {
> +			packet_reader_read(&reader);
> +			if (reader.pktlen <= 0) {
> +				break;
> +			}
> +		}

Could we make this loop cleaner as:

while (packet_reader_read(&reader) != PACKET_READ_NORMAL)
  ;


> +
> +		/*
> +		 * v0 smart http; callers expect us to soak up the
> +		 * service and header packets
> +		 */
> +		d->buf = reader.src_buffer;
> +		d->len = reader.src_len;
> +		d->proto_git = 1;
> +
> +	} else if (starts_with(reader.line, "version 2")) {
> +		/*
> +		 * v2 smart http; do not consume version packet, which will
> +		 * be handled elsewhere.
> +		 */
> +		d->proto_git = 1;
> +
> +	} else {
> +		die("invalid server response; got '%s'", reader.line);
> +	}
> +}
> +
>  static struct discovery *discover_refs(const char *service, int for_push)
>  {
> -	struct strbuf exp = STRBUF_INIT;
>  	struct strbuf type = STRBUF_INIT;
>  	struct strbuf charset = STRBUF_INIT;
>  	struct strbuf buffer = STRBUF_INIT;
> @@ -405,47 +459,8 @@ static struct discovery *discover_refs(const char *service, int for_push)
>  	last->buf_alloc = strbuf_detach(&buffer, &last->len);
>  	last->buf = last->buf_alloc;
>  
> -	strbuf_addf(&exp, "application/x-%s-advertisement", service);
> -	if (maybe_smart &&
> -	    (5 <= last->len && last->buf[4] == '#') &&
> -	    !strbuf_cmp(&exp, &type)) {
> -		struct packet_reader reader;
> -		packet_reader_init(&reader, -1, last->buf, last->len,
> -				   PACKET_READ_CHOMP_NEWLINE |
> -				   PACKET_READ_DIE_ON_ERR_PACKET);
> -
> -		/*
> -		 * smart HTTP response; validate that the service
> -		 * pkt-line matches our request.
> -		 */
> -		if (packet_reader_read(&reader) != PACKET_READ_NORMAL)
> -			die("invalid server response; expected service, got flush packet");
> -
> -		strbuf_reset(&exp);
> -		strbuf_addf(&exp, "# service=%s", service);
> -		if (strcmp(reader.line, exp.buf))
> -			die("invalid server response; got '%s'", reader.line);
> -		strbuf_release(&exp);
> -
> -		/* The header can include additional metadata lines, up
> -		 * until a packet flush marker.  Ignore these now, but
> -		 * in the future we might start to scan them.
> -		 */
> -		for (;;) {
> -			packet_reader_read(&reader);
> -			if (reader.pktlen <= 0) {
> -				break;
> -			}
> -		}
> -
> -		last->buf = reader.src_buffer;
> -		last->len = reader.src_len;
> -
> -		last->proto_git = 1;
> -	} else if (maybe_smart &&
> -		   last->len > 5 && starts_with(last->buf + 4, "version 2")) {
> -		last->proto_git = 1;
> -	}
> +	if (maybe_smart)
> +		check_smart_http(last, service, &type);
>  
>  	if (last->proto_git)
>  		last->refs = parse_git_refs(last, for_push);
> @@ -453,7 +468,6 @@ static struct discovery *discover_refs(const char *service, int for_push)
>  		last->refs = parse_info_refs(last);
>  
>  	strbuf_release(&refs_url);
> -	strbuf_release(&exp);
>  	strbuf_release(&type);
>  	strbuf_release(&charset);
>  	strbuf_release(&effective_url);
> -- 
> 2.20.1.1122.g2972e48916
> 
