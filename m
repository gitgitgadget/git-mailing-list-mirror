Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 810EB1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 00:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbeB1AFZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 19:05:25 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46059 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbeB1AFY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 19:05:24 -0500
Received: by mail-pl0-f65.google.com with SMTP id v9-v6so395513plp.12
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 16:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yw2/WqbIWq/gdw/wIF9vbrSXc3PjPIMkucq8B8u7nZo=;
        b=rJueuP15HVtFnoiqYDuaOfjnRbX1ZZ8X56bdgMv2p86MucxRlej5SL6xg3C6C475g3
         yZjqec1+nzNxSX4W/zwSopeZag5tK7BOtSLhcQ253fT4qFOE1tRtNFFKOal653KVBaY7
         U7KpdwTMHziDU21DsFQTEe4rYF1+AIZwtOvYfUOxpI3UrSRl8nAd3Put14sKh7CuOL8X
         bf6FSjQyRq0GDilzGueqFtTl4hna9rFE75MjvRqs2OWK0Bd9HV1ZyxnD8EXZR3POG1R/
         YvIn9sURsSfDkbgTYbyctHapJEoOxY0a2+HlLHLL+PJz4T8SD+tTnGcpXkZoBcBjZDxo
         unAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yw2/WqbIWq/gdw/wIF9vbrSXc3PjPIMkucq8B8u7nZo=;
        b=XKotHmwROQoG4jAkJ8Gk4pI3CTS2IaQgzzFsoVPOClLv7pY5xmNIJ1MaQqxfAE/7jv
         bbqfEGVZ0iFIKkq5zbiM1+fuWUavas5gwziNinoLp8cDGWblRLo2TlFnX4Zz5N66fIgk
         jfZAOeuuQAC9ajfbfNSozZXUWfijHL8p1sMJ+W7wGCO9eOH0OoWed8DBcmF2D4iOYjNj
         8DffxBUnv2O9dtaAXy1xtxKi/eyuKZ8aWQonAzpKIdWsUy++sF7UasiMO7LibmSzrC74
         ee2YwmqsoQ0iseXDBzh0LAhYTDBRc3Qca66c3f9IN8cWgHeC+qqOZhHXArqa+6EDdYwO
         uU9g==
X-Gm-Message-State: APf1xPDLAISjEMXro0Kv2oksMjSjwfBuf0PsAp56MJeh75OvD+szJY7+
        pbwg+S9x6mF0Ba+6lNjp2Bg=
X-Google-Smtp-Source: AH8x226dBuIae6x2C1SyUhv0rm4m3PDY/VEFKjScwJhfzL7TT/YV7KHE79dITghusiw5ubz1uA3BLA==
X-Received: by 2002:a17:902:4201:: with SMTP id g1-v6mr15911080pld.62.1519776323467;
        Tue, 27 Feb 2018 16:05:23 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id w129sm347583pfd.155.2018.02.27.16.05.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 16:05:22 -0800 (PST)
Date:   Tue, 27 Feb 2018 16:05:20 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 34/35] remote-curl: implement stateless-connect command
Message-ID: <20180228000520.GI174036@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-35-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207011312.189834-35-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> Teach remote-curl the 'stateless-connect' command which is used to
> establish a stateless connection with servers which support protocol
> version 2.  This allows remote-curl to act as a proxy, allowing the git
> client to communicate natively with a remote end, simply using
> remote-curl as a pass through to convert requests to http.

Cool!  I better look at the spec for that first.

*looks at the previous patch*

Oh, there is no documented spec. :/  I'll muddle through this instead,
then.

[...]
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -188,7 +188,10 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
>  	heads->version = discover_version(&reader);
>  	switch (heads->version) {
>  	case protocol_v2:
> -		die("support for protocol v2 not implemented yet");
> +		/*
> +		 * Do nothing.  Client should run 'stateless-connect' and
> +		 * request the refs themselves.
> +		 */
>  		break;

This is the 'list' command, right?  Since we expect the client to run
'stateless-connect' instead, can we make it error out?

[...]
> @@ -1082,6 +1085,184 @@ static void parse_push(struct strbuf *buf)
>  	free(specs);
>  }
>  
> +struct proxy_state {
> +	char *service_name;
> +	char *service_url;
> +	struct curl_slist *headers;
> +	struct strbuf request_buffer;
> +	int in;
> +	int out;
> +	struct packet_reader reader;
> +	size_t pos;
> +	int seen_flush;
> +};

Can this have a comment describing what it is/does?  It's not obvious
to me at first glance.

It doesn't have to go in a lot of detail since this is an internal
implementation detail, but something saying e.g. that this represents
a connection to an HTTP server (that's an example; I'm not saying
that's what it represents :)) would help.

> +
> +static void proxy_state_init(struct proxy_state *p, const char *service_name,
> +			     enum protocol_version version)
[...]
> +static void proxy_state_clear(struct proxy_state *p)

Looks sensible.

[...]
> +static size_t proxy_in(char *buffer, size_t eltsize,
> +		       size_t nmemb, void *userdata)

Can this have a comment describing the interface?  (E.g. does it read
a single pkt_line?  How is the caller expected to use it?  Does it
satisfy the interface of some callback?)

libcurl's example https://curl.haxx.se/libcurl/c/ftpupload.html just
calls this read_callback.  Such a name plus a pointer to
CURLOPT_READFUNCTION should do the trick; bonus points if the comment 
says what our implementation of the callback does.

Is this about having peek ability?

> +{
> +	size_t max = eltsize * nmemb;

Can this overflow?  st_mult can avoid having to worry about that.

> +	struct proxy_state *p = userdata;
> +	size_t avail = p->request_buffer.len - p->pos;
> +
> +	if (!avail) {
> +		if (p->seen_flush) {
> +			p->seen_flush = 0;
> +			return 0;
> +		}
> +
> +		strbuf_reset(&p->request_buffer);
> +		switch (packet_reader_read(&p->reader)) {
> +		case PACKET_READ_EOF:
> +			die("unexpected EOF when reading from parent process");
> +		case PACKET_READ_NORMAL:
> +			packet_buf_write_len(&p->request_buffer, p->reader.line,
> +					     p->reader.pktlen);
> +			break;
> +		case PACKET_READ_DELIM:
> +			packet_buf_delim(&p->request_buffer);
> +			break;
> +		case PACKET_READ_FLUSH:
> +			packet_buf_flush(&p->request_buffer);
> +			p->seen_flush = 1;
> +			break;
> +		}
> +		p->pos = 0;
> +		avail = p->request_buffer.len;
> +	}
> +
> +	if (max < avail)
> +		avail = max;
> +	memcpy(buffer, p->request_buffer.buf + p->pos, avail);
> +	p->pos += avail;
> +	return avail;

This is a number of bytes, but CURLOPT_READFUNCTION expects a number
of items, fread-style.  That is:

	if (avail < eltsize)
		... handle somehow, maybe by reading in more? ...

	avail_memb = avail / eltsize;
	memcpy(buffer,
	       p->request_buffer.buf + p->pos,
	       st_mult(avail_memb, eltsize));
	p->pos += st_mult(avail_memb, eltsize);
	return avail_memb;

But https://curl.haxx.se/libcurl/c/CURLOPT_READFUNCTION.html says

	Your function must then return the actual number of bytes that
	it stored in that memory area.

Does this mean eltsize is always 1?  This is super confusing...

... ok, a quick grep for fread_func in libcurl reveals that eltsize is
indeed always 1.  Can we add an assertion so we notice if that
changes?

	if (eltsize != 1)
		BUG("curl read callback called with size = %zu != 1", eltsize);
	max = nmemb;

[...]
> +static size_t proxy_out(char *buffer, size_t eltsize,
> +			size_t nmemb, void *userdata)
> +{
> +	size_t size = eltsize * nmemb;
> +	struct proxy_state *p = userdata;
> +
> +	write_or_die(p->out, buffer, size);
> +	return size;
> +}

Nice.  Same questions about st_mult or just asserting on eltsize apply
here, too.

[...]
> +static int proxy_post(struct proxy_state *p)

What does this function do?  Can it get a brief comment?

> +{
> +	struct active_request_slot *slot;
> +	int err;
> +
> +	slot = get_active_slot();
> +
> +	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
> +	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
> +	curl_easy_setopt(slot->curl, CURLOPT_URL, p->service_url);
> +	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, p->headers);
> +
> +	/* Setup function to read request from client */
> +	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, proxy_in);
> +	curl_easy_setopt(slot->curl, CURLOPT_READDATA, p);
> +
> +	/* Setup function to write server response to client */
> +	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, proxy_out);
> +	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, p);
> +
> +	err = run_slot(slot, NULL);
> +
> +	if (err != HTTP_OK)
> +		err = -1;
> +
> +	return err;

HTTP_OK is 0 but kind of obscures that.  How about something like the
following?

	if (run_slot(slot, NULL))
		return -1;
	return 0;

or

	if (run_slot(slot, NULL) != HTTP_OK)
		return -1;
	return 0;

That way it's clearer that this always returns 0 or -1.

[...]
> +static int stateless_connect(const char *service_name)
> +{
> +	struct discovery *discover;
> +	struct proxy_state p;
> +
> +	/*
> +	 * Run the info/refs request and see if the server supports protocol
> +	 * v2.  If and only if the server supports v2 can we successfully
> +	 * establish a stateless connection, otherwise we need to tell the
> +	 * client to fallback to using other transport helper functions to
> +	 * complete their request.
> +	 */
> +	discover = discover_refs(service_name, 0);
> +	if (discover->version != protocol_v2) {
> +		printf("fallback\n");
> +		fflush(stdout);
> +		return -1;

Interesting.  I wonder if we can make remote-curl less smart and drive
this more from the caller.

E.g. if the caller could do a single stateless request, they could do:

	option git-protocol version=2
	stateless-request GET info/refs?service=git-upload-pack
	[pkt-lines, ending with a flush-pkt]

The git-protocol option in this hypothetical example is the value to
be passed in the Git-Protocol header.

Then based on the response, the caller could decide to keep using
stateless-request for further requests or fall back to "fetch".

That way, if we implement some protocol v3, the remote helper would
not have to be changed at all to handle it: the caller would instead
make the new v3-format request and remote-curl would be able to oblige
without knowing why they're doing it.

What do you think?

Thanks,
Jonathan
