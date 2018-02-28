Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BA4F1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 20:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934230AbeB1UVr (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 15:21:47 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34807 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934119AbeB1UVq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 15:21:46 -0500
Received: by mail-pg0-f41.google.com with SMTP id m19so1384213pgn.1
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 12:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ySex2P9DAUW7qbAiOe6IxHfCmj1CvsjbAp2KCXt20EI=;
        b=gBv06sfb0XqvOlqQfezrngocnGYTyQazSAC8m2H9sJp6lnIELtuoJagRdwHSmxybD8
         Y6Mdu2NvKntV7yxc92hW5Y11MfqMOk3VvFhhxhZUJAE2Lwqd+0pub+p5irlADFEyHQhb
         2S1cRKtL2egFNqxsnSP2puCDOcZGKaJWzffi0mi7NmGysPxhkYxkxk79yQD43CqUoABQ
         m0DmM7XNA82yMF7rL0F/4rORyXplj9jhKjqA0TfI1XbX7FsDJ9Z4umvnPSo0knxRPvxd
         y6pIJcSfLJVLEho8JYDROvEIukNUQJ7/GcxLsEkzlzQlxECEp4dZ7BgAFB3CPik1LWIj
         PH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ySex2P9DAUW7qbAiOe6IxHfCmj1CvsjbAp2KCXt20EI=;
        b=ACR5iQ0Nd4kc8XQiixHWmE+3E5Ec301oDVP6ngRf/Q+qKaJdncHZNxKO/ifs62cEdf
         S+UTxEkXaJaoEbadrkE8WhDNawEkrnHYGIlqMktgKQkjdohcbH0bO6dwrq8Zir0gylpV
         d2m+JkS4gGDz9CkqmCFtu9Z03oWCdpWHER3OiUJthtzGLvUFv4BPAOwjSX29D0JfKKha
         pbg++qEb1Q6KlwYfAL+jVTEvaWpcXXL+LXaDy7edmoU9PMx960Squj1pKDkrFQJd1YWo
         lTIK0Uba5kW7TMbBpjfsyFHxER0BwyrbFjNlV5JzoS/bKgc9iQ5Yw0EgBW1mzUS7StJ2
         z9eg==
X-Gm-Message-State: APf1xPDofLHBwTbA9xOlV/s3Qv3g/y89s6dMffk9gKBOhx8q0zRWugGx
        VHkDFuOJPOcxjpgOedGskVec0g==
X-Google-Smtp-Source: AG47ELumRH1iGWodpU7hAG0SjF3wQeVXr/ucunKyc1aPVwwNBvjvm3st314veWnJhUOKNHxCQbx7AQ==
X-Received: by 10.99.146.91 with SMTP id s27mr915819pgn.367.1519849305152;
        Wed, 28 Feb 2018 12:21:45 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id y124sm4117398pgb.29.2018.02.28.12.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 12:21:44 -0800 (PST)
Date:   Wed, 28 Feb 2018 12:21:42 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 34/35] remote-curl: implement stateless-connect command
Message-ID: <20180228202142.GC87122@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-35-bmwill@google.com>
 <20180228000520.GI174036@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228000520.GI174036@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/27, Jonathan Nieder wrote:
> Hi,
> 
> Brandon Williams wrote:
> 
> > Teach remote-curl the 'stateless-connect' command which is used to
> > establish a stateless connection with servers which support protocol
> > version 2.  This allows remote-curl to act as a proxy, allowing the git
> > client to communicate natively with a remote end, simply using
> > remote-curl as a pass through to convert requests to http.
> 
> Cool!  I better look at the spec for that first.
> 
> *looks at the previous patch*
> 
> Oh, there is no documented spec. :/  I'll muddle through this instead,
> then.

I'll make sure to add one :)

> 
> [...]
> > --- a/remote-curl.c
> > +++ b/remote-curl.c
> > @@ -188,7 +188,10 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
> >  	heads->version = discover_version(&reader);
> >  	switch (heads->version) {
> >  	case protocol_v2:
> > -		die("support for protocol v2 not implemented yet");
> > +		/*
> > +		 * Do nothing.  Client should run 'stateless-connect' and
> > +		 * request the refs themselves.
> > +		 */
> >  		break;
> 
> This is the 'list' command, right?  Since we expect the client to run
> 'stateless-connect' instead, can we make it error out?

Yes and no.  Remote-curl will run this when trying to establish a
stateless-connection.  If the response is v2 then this is a capability
list and not refs.  So the capabilities will be dumped to the client and
they will be able to request the refs themselves at a later point.  The
comment here is just misleading, so i'll make sure to fix it.

> 
> [...]
> > @@ -1082,6 +1085,184 @@ static void parse_push(struct strbuf *buf)
> >  	free(specs);
> >  }
> >  
> > +struct proxy_state {
> > +	char *service_name;
> > +	char *service_url;
> > +	struct curl_slist *headers;
> > +	struct strbuf request_buffer;
> > +	int in;
> > +	int out;
> > +	struct packet_reader reader;
> > +	size_t pos;
> > +	int seen_flush;
> > +};
> 
> Can this have a comment describing what it is/does?  It's not obvious
> to me at first glance.
> 
> It doesn't have to go in a lot of detail since this is an internal
> implementation detail, but something saying e.g. that this represents
> a connection to an HTTP server (that's an example; I'm not saying
> that's what it represents :)) would help.

Always making new code have higher standards than the existing code ;)
Haha, I'll add a simple comment explaining it.

> 
> > +
> > +static void proxy_state_init(struct proxy_state *p, const char *service_name,
> > +			     enum protocol_version version)
> [...]
> > +static void proxy_state_clear(struct proxy_state *p)
> 
> Looks sensible.
> 
> [...]
> > +static size_t proxy_in(char *buffer, size_t eltsize,
> > +		       size_t nmemb, void *userdata)
> 
> Can this have a comment describing the interface?  (E.g. does it read
> a single pkt_line?  How is the caller expected to use it?  Does it
> satisfy the interface of some callback?)

I'll add a comment that its used as a READFUNCTION callback for curl and
that it tries to copy over a packet-line at a time.

> 
> libcurl's example https://curl.haxx.se/libcurl/c/ftpupload.html just
> calls this read_callback.  Such a name plus a pointer to
> CURLOPT_READFUNCTION should do the trick; bonus points if the comment 
> says what our implementation of the callback does.
> 
> Is this about having peek ability?

No its just that Curl only requests a set about of data at a time so you
need to be able to buffer the data that can't be read yet.

> 
> > +	struct proxy_state *p = userdata;
> > +	size_t avail = p->request_buffer.len - p->pos;
> > +
> > +	if (!avail) {
> > +		if (p->seen_flush) {
> > +			p->seen_flush = 0;
> > +			return 0;
> > +		}
> > +
> > +		strbuf_reset(&p->request_buffer);
> > +		switch (packet_reader_read(&p->reader)) {
> > +		case PACKET_READ_EOF:
> > +			die("unexpected EOF when reading from parent process");
> > +		case PACKET_READ_NORMAL:
> > +			packet_buf_write_len(&p->request_buffer, p->reader.line,
> > +					     p->reader.pktlen);
> > +			break;
> > +		case PACKET_READ_DELIM:
> > +			packet_buf_delim(&p->request_buffer);
> > +			break;
> > +		case PACKET_READ_FLUSH:
> > +			packet_buf_flush(&p->request_buffer);
> > +			p->seen_flush = 1;
> > +			break;
> > +		}
> > +		p->pos = 0;
> > +		avail = p->request_buffer.len;
> > +	}
> > +
> > +	if (max < avail)
> > +		avail = max;
> > +	memcpy(buffer, p->request_buffer.buf + p->pos, avail);
> > +	p->pos += avail;
> > +	return avail;
> 
> This is a number of bytes, but CURLOPT_READFUNCTION expects a number
> of items, fread-style.  That is:
> 
> 	if (avail < eltsize)
> 		... handle somehow, maybe by reading in more? ...
> 
> 	avail_memb = avail / eltsize;
> 	memcpy(buffer,
> 	       p->request_buffer.buf + p->pos,
> 	       st_mult(avail_memb, eltsize));
> 	p->pos += st_mult(avail_memb, eltsize);
> 	return avail_memb;
> 
> But https://curl.haxx.se/libcurl/c/CURLOPT_READFUNCTION.html says
> 
> 	Your function must then return the actual number of bytes that
> 	it stored in that memory area.
> 
> Does this mean eltsize is always 1?  This is super confusing...
> 
> ... ok, a quick grep for fread_func in libcurl reveals that eltsize is
> indeed always 1.  Can we add an assertion so we notice if that
> changes?
> 
> 	if (eltsize != 1)
> 		BUG("curl read callback called with size = %zu != 1", eltsize);
> 	max = nmemb;

Yeah i can go ahead and do this.  Just note that the v1 path uses logic
identical to this so it would be a problem there.

> 
> [...]
> > +static size_t proxy_out(char *buffer, size_t eltsize,
> > +			size_t nmemb, void *userdata)
> > +{
> > +	size_t size = eltsize * nmemb;
> > +	struct proxy_state *p = userdata;
> > +
> > +	write_or_die(p->out, buffer, size);
> > +	return size;
> > +}
> 
> Nice.  Same questions about st_mult or just asserting on eltsize apply
> here, too.
> 
> [...]
> > +static int proxy_post(struct proxy_state *p)
> 
> What does this function do?  Can it get a brief comment?

Will do.

> 
> > +{
> > +	struct active_request_slot *slot;
> > +	int err;
> > +
> > +	slot = get_active_slot();
> > +
> > +	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
> > +	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
> > +	curl_easy_setopt(slot->curl, CURLOPT_URL, p->service_url);
> > +	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, p->headers);
> > +
> > +	/* Setup function to read request from client */
> > +	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, proxy_in);
> > +	curl_easy_setopt(slot->curl, CURLOPT_READDATA, p);
> > +
> > +	/* Setup function to write server response to client */
> > +	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, proxy_out);
> > +	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, p);
> > +
> > +	err = run_slot(slot, NULL);
> > +
> > +	if (err != HTTP_OK)
> > +		err = -1;
> > +
> > +	return err;
> 
> HTTP_OK is 0 but kind of obscures that.  How about something like the
> following?
> 
> 	if (run_slot(slot, NULL))
> 		return -1;
> 	return 0;
> 
> or
> 
> 	if (run_slot(slot, NULL) != HTTP_OK)
> 		return -1;
> 	return 0;
> 
> That way it's clearer that this always returns 0 or -1.

Sounds good.

> 
> [...]
> > +static int stateless_connect(const char *service_name)
> > +{
> > +	struct discovery *discover;
> > +	struct proxy_state p;
> > +
> > +	/*
> > +	 * Run the info/refs request and see if the server supports protocol
> > +	 * v2.  If and only if the server supports v2 can we successfully
> > +	 * establish a stateless connection, otherwise we need to tell the
> > +	 * client to fallback to using other transport helper functions to
> > +	 * complete their request.
> > +	 */
> > +	discover = discover_refs(service_name, 0);
> > +	if (discover->version != protocol_v2) {
> > +		printf("fallback\n");
> > +		fflush(stdout);
> > +		return -1;
> 
> Interesting.  I wonder if we can make remote-curl less smart and drive
> this more from the caller.
> 
> E.g. if the caller could do a single stateless request, they could do:
> 
> 	option git-protocol version=2
> 	stateless-request GET info/refs?service=git-upload-pack
> 	[pkt-lines, ending with a flush-pkt]
> 
> The git-protocol option in this hypothetical example is the value to
> be passed in the Git-Protocol header.
> 
> Then based on the response, the caller could decide to keep using
> stateless-request for further requests or fall back to "fetch".
> 
> That way, if we implement some protocol v3, the remote helper would
> not have to be changed at all to handle it: the caller would instead
> make the new v3-format request and remote-curl would be able to oblige
> without knowing why they're doing it.
> 
> What do you think?

I do see the draw for wanting this.  I think a change like this requires
a lot more refactoring, simply because with the current setup the
fetch/ls-refs logic doesn't care that its talking through a
remote-helper where if we went down that route it would need to be aware
of that.

-- 
Brandon Williams
