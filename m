Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 625171F404
	for <e@80x24.org>; Mon, 12 Mar 2018 21:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932418AbeCLV4j (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 17:56:39 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36011 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932265AbeCLV4i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 17:56:38 -0400
Received: by mail-pf0-f169.google.com with SMTP id 68so4959206pfx.3
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 14:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZQPWz0c9ztAYy7MdxMeQsSsYOL/ezRZHE1FCKH6nWuM=;
        b=Whi7RaZ0p9urFuTwjUruzQoGiP9o1qTz0v+/sRkQpjdQOIbOLXRNppi4Kt9E/9e9LA
         76DFiXFvngJ62AsbtjIpfVTWh5xEGB3XAAuf6h+oSorOCO5ocAOmWc71pbc9WpKWv3Qr
         hulpFtkaQbpYEMrSKCZLXZcFn/63QrOoUwWhAoI6PUFDcD8LGuotNiJRiAqvvrWDM07T
         Tyu8Qhcz5nl+Sqpcap/O/pP3Si1+tGfEkXQHqpkahifgg7MmY11Z+iyc49YDZFvE9fBP
         aPpMiNftjAHJcJb3zBZkS8TgMhyAu0om9UIcau2tDnJkuTSOEgpCptyjU5LH8mcJilTQ
         GjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZQPWz0c9ztAYy7MdxMeQsSsYOL/ezRZHE1FCKH6nWuM=;
        b=EtC087tsdyGcGr0I8KN9w60ipCAO1SOsX8uoU58SLAhGwxgEsCo09HUOFEDaJ9yH8L
         QwotJ1uufIu6eqNimG4ndny/6AExoIfCAmvfZ6zhzMlARBE91iefg76rLlHz1OuPzI36
         ZwsO7ELF8hRT3nNi5LuQRjMRah6r1MonM/0eIvswsvLNx4KWds2hFtRHaHxHGJ31xdZC
         ZfKha2xIItgJ5sQfkq2bKn4vfiwWfhXEgsBf0Y2hE3uuQLVH6G9EUFg08Bk4b9XzSB2q
         oWyi28Gef2AoK/291bL8ovQBRrK+wSNdpJJ9yVZy6vv7JPcTFbwlk95NSx8+zy2xrDZX
         7PkA==
X-Gm-Message-State: AElRT7Ge3P69Je1cLWIwA1VDVRdcq+VV/xuDWwTW5gru7UK9kCsPddle
        pukjC45mbFyPYNM7FeIxAuJXw4PP+o4=
X-Google-Smtp-Source: AG47ELu2g5tpiqqhi1sAlKz9OjFo6c0k7Z/0Qb4Lv30LQmo3bm0jhSQ2bpY7UzHxrMbuWF2LRD9JKw==
X-Received: by 10.99.140.8 with SMTP id m8mr4904962pgd.320.1520891798049;
        Mon, 12 Mar 2018 14:56:38 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id n76sm18743605pfi.93.2018.03.12.14.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Mar 2018 14:56:37 -0700 (PDT)
Date:   Mon, 12 Mar 2018 14:56:35 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 02/35] pkt-line: allow peeking a packet line without
 consuming it
Message-ID: <20180312215635.GA61720@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <20180228232252.102167-3-bmwill@google.com>
 <xmqqk1uvfro3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk1uvfro3.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/01, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > +enum packet_read_status packet_reader_read(struct packet_reader *reader)
> > +{
> > +	if (reader->line_peeked) {
> > +		reader->line_peeked = 0;
> > +		return reader->status;
> > +	}
> > +
> > +	reader->status = packet_read_with_status(reader->fd,
> > +						 &reader->src_buffer,
> > +						 &reader->src_len,
> > +						 reader->buffer,
> > +						 reader->buffer_size,
> > +						 &reader->pktlen,
> > +						 reader->options);
> > +
> > +	switch (reader->status) {
> > +	case PACKET_READ_EOF:
> > +		reader->pktlen = -1;
> > +		reader->line = NULL;
> > +		break;
> > +	case PACKET_READ_NORMAL:
> > +		reader->line = reader->buffer;
> > +		break;
> > +	case PACKET_READ_FLUSH:
> > +		reader->pktlen = 0;
> > +		reader->line = NULL;
> > +		break;
> > +	}
> > +
> > +	return reader->status;
> > +}
> 
> With the way _peek() interface interacts with the reader instance
> (which by the way I find is well designed), it is understandable
> that we want almost everything available in reader's fields, but
> having to manually clear pktlen field upon non NORMAL status feels
> a bit strange.  
> 
> Perhaps that is because the underlying packet_read_with_status()
> does not set *pktlen in these cases?  Shouldn't it be doing that so
> the caller does not have to?

That's true, I'll fix that.


-- 
Brandon Williams
