Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C8621F404
	for <e@80x24.org>; Thu, 11 Jan 2018 01:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeAKBJZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 20:09:25 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:42276 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752312AbeAKBJX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 20:09:23 -0500
Received: by mail-pg0-f46.google.com with SMTP id q67so1387956pga.9
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 17:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n7H6v4T2XD4j+JMXAHiWiTcnPPFT1J7TC9OaPz5pqD8=;
        b=FlyvOiyv+ksRsAqL9lzzbv2bqwCKN4BnIZzqB9qGYc0k9+8GD9rDGUUvALUYPgIPGa
         kHp1xCSYbw4C8/OJ9n6uspy7C9ao7SOlVqK1L2gf0QXqWFlQ4S+cEwpjrE0acsy41aL/
         7qAZnHSQ1mJLclgN2G66FeLeyPE8sUxB5z2oA8GmDQL2xFylL3bugSdUuOeYCOuJfDYK
         vb7sUWeeuYWgRfo6yBPgXj6iSRVMU1t3oD3YkFhwF/F3s2iqwI1NTvlr9Jlv02hmV4Me
         4Q6X4dYmS/9n5GgROC+VZTpClfrYKkHqNv9dniY3RxTylf+WKBYlTVYJi86N3kiIB666
         ekyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n7H6v4T2XD4j+JMXAHiWiTcnPPFT1J7TC9OaPz5pqD8=;
        b=T3pEqEMlim2IlXqwdgvfqITW7iekFYm3NjI7oIg4FD5Fyo+BTzSgjD48rHxENO6Q30
         yTQqtnPZWkS/yPHA4Pvl/pZ8ZKNKDaaKutv9EzRDOMc/AshAoxlxHA1Caiq96cV/aMT9
         /XDlHfv3l9s1EmyRSVlRoFrdWBcSW0Oz2uNTTGyyFDM10oaHF5v3/Z7GUYA41J0zfgpT
         V4eXr4tUBwBLUIMgd17yYftvrCeU9SDdiTvcjcSWC1/QMrsrKTeyjbRFVjOpTtYbdhf5
         28Bc+nvuqAc/8WD00sSjkhkemrYpjEImEMQlzUe6oe6kmm7dlDHI3DT/TSIRK7qOGJsJ
         jGIA==
X-Gm-Message-State: AKwxytdTRTJaL9OeZ5uOJ3HjCsF8YJ8bWSSKmW4fPxwQtjHc26BOtTUF
        g82mB9YweIe04hg+nlVJGdfuBA==
X-Google-Smtp-Source: ACJfBoupcBjqAlk0LZnHdyRerxnZQ07i/pct9bEct2Ou27qjpD2sFjBXTXDb0qelMVRlQTv3A4PbHw==
X-Received: by 10.159.229.129 with SMTP id az1mr813868plb.232.1515632962994;
        Wed, 10 Jan 2018 17:09:22 -0800 (PST)
Received: from google.com ([2620:0:100e:422:d157:f909:10c:5e57])
        by smtp.gmail.com with ESMTPSA id l10sm28673pgp.86.2018.01.10.17.09.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 Jan 2018 17:09:22 -0800 (PST)
Date:   Wed, 10 Jan 2018 17:09:20 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 26/26] remote-curl: implement connect-half-duplex command
Message-ID: <20180111010920.GB91567@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180103001828.205012-27-bmwill@google.com>
 <20180110095730.1daaa70d7c583c58b85142a3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110095730.1daaa70d7c583c58b85142a3@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/10, Jonathan Tan wrote:
> On Tue,  2 Jan 2018 16:18:28 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > +static size_t proxy_in(void *ptr, size_t eltsize,
> > +		       size_t nmemb, void *buffer_)
> 
> OK, I managed to look at the Curl stuff in more detail.
> 
> I know that these parameter names are what remote_curl.c has been using
> for its callbacks, but I find them confusing (in particular, some Curl
> documentation rightly refer to the 1st parameter as a buffer, and the
> 4th parameter is actually userdata). Also, according to the Curl
> documentation, the type of the first parameter is "char *". Could we
> change the type of the first parameter to "char *", and the name of the
> fourth parameter either to "proxy_state_" or "userdata"?

Sounds good, I'll make the change.

> 
> > +{
> > +	size_t max = eltsize * nmemb;
> > +	struct proxy_state *p = buffer_;
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
> > +			die("error reading request from parent process");
> 
> This should say "BUG:", I think. I'm not sure what the best way of
> explaining it is, but basically connect_half_duplex is supposed to
> ensure (by peeking) that there is no EOF when proxy_in() is called.

This wouldn't necessarily be a bug if the parent dies early for some
reason though right?

> 
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
> > +	memcpy(ptr, p->request_buffer.buf + p->pos, avail);
> > +	p->pos += avail;
> > +	return avail;
> 
> Thanks, this looks correct. I wish that the Curl API had a way for us to
> say "here are 4 more bytes, and that is all" instead of us having to
> make a note (p->seen_flush) to remember to return 0 on the next call,
> but that's the way it is.
> 
> > +}
> > +static size_t proxy_out(char *ptr, size_t eltsize,
> > +			size_t nmemb, void *buffer_)
> 
> Add a blank line before proxy_out. Also, same comment as proxy_in()
> about the function signature.

I'll change this function too.

> 
> > +{
> > +	size_t size = eltsize * nmemb;
> > +	struct proxy_state *p = buffer_;
> > +
> > +	write_or_die(p->out, ptr, size);
> > +	return size;
> > +}
> > +
> > +static int proxy_post(struct proxy_state *p)
> > +{
> > +	struct active_request_slot *slot;
> > +	struct curl_slist *headers = http_copy_default_headers();
> > +	int err;
> > +
> > +	headers = curl_slist_append(headers, p->hdr_content_type);
> > +	headers = curl_slist_append(headers, p->hdr_accept);
> > +	headers = curl_slist_append(headers, "Transfer-Encoding: chunked");
> > +
> > +	slot = get_active_slot();
> > +
> > +	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
> > +	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
> > +	curl_easy_setopt(slot->curl, CURLOPT_URL, p->service_url);
> > +	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
> 
> I looked at the Curl documentation for CURLOPT_HTTPHEADER and
> curl_easy_setopt doesn't consume the argument here (in fact, it asks us
> to keep "headers" around), so it might be possible to just generate the
> headers once in proxy_state_init().

Yeah I'll go ahead and do that, it'll make the post function a bit
cleaner too.

> 
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
> 
> This seems to mean that we cannot have two requests in flight at the
> same time even while there is no response (from the fact that we have a
> HTTP status code after returning from run_slot()).
> 
> I thought that git fetch over HTTP uses the two-requests-in-flight
> optimization that it also does over other protocols like SSH, but I see
> that that code path (fetch_git() in remote-curl.c) also uses run_slot()
> indirectly, so maybe my assumption is wrong. Anyway, this is outside the
> scope of this patch.
> 
> > +
> > +	curl_slist_free_all(headers);
> > +	return err;
> > +}
> > +
> > +static int connect_half_duplex(const char *service_name)
> > +{
> > +	struct discovery *discover;
> > +	struct proxy_state p;
> > +
> > +	/*
> > +	 * Run the info/refs request and see if the server supports protocol
> > +	 * v2.  If and only if the server supports v2 can we successfully
> > +	 * establish a half-duplex connection, otherwise we need to tell the
> > +	 * client to fallback to using other transport helper functions to
> > +	 * complete their request.
> > +	 */
> > +	discover = discover_refs(service_name, 0);
> > +	if (discover->version != protocol_v2) {
> > +		printf("fallback\n");
> > +		fflush(stdout);
> > +		return -1;
> > +	} else {
> > +		/* Half-Duplex Connection established */
> > +		printf("\n");
> > +		fflush(stdout);
> > +	}
> > +
> > +	proxy_state_init(&p, service_name);
> > +
> > +	/*
> > +	 * Dump the capability listing that we got from the server earlier
> > +	 * during the info/refs request.
> > +	 */
> > +	write_or_die(p.out, discover->buf, discover->len);
> > +
> > +	/* Peek the next packet line.  Until we see EOF keep sending POSTs */
> > +	while (packet_reader_peek(&p.reader) != PACKET_READ_EOF) {
> > +		if (proxy_post(&p)) {
> > +			/* We would have an err here */
> 
> Probably better to comment "Error message already printed by
> proxy_post".

-- 
Brandon Williams
