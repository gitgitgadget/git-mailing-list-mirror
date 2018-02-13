Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12CA81F404
	for <e@80x24.org>; Tue, 13 Feb 2018 00:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933004AbeBMAtm (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 19:49:42 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38901 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932736AbeBMAtl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 19:49:41 -0500
Received: by mail-pg0-f67.google.com with SMTP id l24so2650126pgc.5
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 16:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hDggu7wRDSm2W3HrAcypkPTm51IkKeL13GBeSPqMT9Q=;
        b=gIw/pyG+0lsuba72CitmvYyZU8j27VmVG2KP6iU0yk90HM3mxUAQzlrp6gdYeZ23u1
         FYtPKcg1XeBqINyp8nqTcklW/9HCdZQgf4SavS2W2LhizA1/Q8BbCSA/YkJ/weQ4x2/Z
         axWPAKBjEhtBInGieNhw5l+Y9VC9+eLrVJXdK4NpoBwGJAGbUYwjpuMRh4tNEihmlH9T
         6GFIJZgsZcyhqQfUx192P61+XwWPeoFAPr9mbDOcbqrF/c696q8aWbZlHhoCmMO/aatk
         XE8N4v6KUeaOdF+kSO+2eT22W3S/vbjgOm1Nzzj22udOv6hf0Ftq/w+MFFDgnE1VCa71
         4V0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hDggu7wRDSm2W3HrAcypkPTm51IkKeL13GBeSPqMT9Q=;
        b=ouTP0A38TgX2P9U1zyPxDw22v8QAtyzlpMMRi6boer5Te1EQVGTqbIPRpa5EOWf3PE
         09352PZy677sqVxc1JbiX2s+Q6AgY/E7h1GMFUKcRVREYCDIV1XyHMnuOMYqCpCgZFB0
         fBlpAMgtlWYerg2LFNg/eczlfBe+1smtmnj2cIJmcn2PMH8ct8XWlMEoapHaRB1jSSlT
         0aLQ6wmbclei+4Q7XM7Oe7nAAkbG7KUg21M8QsBzoISOPiJv4hgsQ/tGRiG31+ISc+cv
         O0lsIod1O7aKnmwoIiaYO55uVuKnRQ9Fryt3xNGcTLHxVdvNCFMv5b6dBRz6J/GW8Ka2
         MENQ==
X-Gm-Message-State: APf1xPBwT9v9ySy/43B+PlRjq25OPMlKYvJDew/PhMYdEfHd+bVq56bJ
        uzAVK0OWnxrsmrEU50fSgtU=
X-Google-Smtp-Source: AH8x226xfzJYV5u+ADj6hhhyhf5FuNovrR3ToYPl/Rzb0tZlhm0xY3dOgnQDuTYfXPAP4n3NYsGzcg==
X-Received: by 10.98.209.8 with SMTP id z8mr13326352pfg.240.1518482980304;
        Mon, 12 Feb 2018 16:49:40 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h1sm23001504pfh.28.2018.02.12.16.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 16:49:39 -0800 (PST)
Date:   Mon, 12 Feb 2018 16:49:37 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 02/35] pkt-line: introduce struct packet_reader
Message-ID: <20180213004937.GB42272@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-3-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207011312.189834-3-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> Subject: pkt-line: introduce struct packet_reader

nit: this subject line doesn't describe what the purpose/intent behind
the patch is.  Maybe something like

	pkt-line: allow peeking at a packet line without consuming it

would make it clearer.

> Sometimes it is advantageous to be able to peek the next packet line
> without consuming it (e.g. to be able to determine the protocol version
> a server is speaking).  In order to do that introduce 'struct
> packet_reader' which is an abstraction around the normal packet reading
> logic.  This enables a caller to be able to peek a single line at a time
> using 'packet_reader_peek()' and having a caller consume a line by
> calling 'packet_reader_read()'.

Makes sense.  The packet_reader owns a buffer to support the peek
operation and make buffer reuse a little easier.

[...]
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -111,6 +111,64 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
>   */
>  ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out);
>  
> +struct packet_reader {
> +	/* source file descriptor */
> +	int fd;
> +
> +	/* source buffer and its size */
> +	char *src_buffer;
> +	size_t src_len;

Can or should this be a strbuf?

> +
> +	/* buffer that pkt-lines are read into and its size */
> +	char *buffer;
> +	unsigned buffer_size;

Likewise.

> +
> +	/* options to be used during reads */
> +	int options;

What option values are possible?

> +
> +	/* status of the last read */
> +	enum packet_read_status status;

This reminds me of FILE*'s status value, ferror, etc.  I'm mildly
nervous about it --- it encourages a style of error handling where you
ignore errors from an individual operation and hope the recorded
status later has the most relevant error.

I think it is being used to support peek --- you need to record the
error to reply it.  Is that right?  I wonder if it would make sense to
structure as

		struct packet_read_result last_line_read;
	};

	struct packet_read_result {
		enum packet_read_status status;

		const char *line;
		int len;
	};

What you have here also seems fine.  I think what would help most
for readability is if the comment mentioned the purpose --- e.g.

	/* status of the last read, to support peeking */

Or if the contract were tied to the purpose:

	/* status of the last read, only valid if line_peeked is true */

[...]
> +/*
> + * Initialize a 'struct packet_reader' object which is an
> + * abstraction around the 'packet_read_with_status()' function.
> + */
> +extern void packet_reader_init(struct packet_reader *reader, int fd,
> +			       char *src_buffer, size_t src_len,
> +			       int options);

This comment doesn't describe how I should use the function.  Is the
intent to point the reader to packet_read_with_status for more details
about the arguments?

Can src_buffer be a const char *?

[...]
> +/*
> + * Perform a packet read and return the status of the read.

nit: s/Perform a packet read/Read one pkt-line/

> + * The values of 'pktlen' and 'line' are updated based on the status of the
> + * read as follows:
> + *
> + * PACKET_READ_ERROR: 'pktlen' is set to '-1' and 'line' is set to NULL
> + * PACKET_READ_NORMAL: 'pktlen' is set to the number of bytes read
> + *		       'line' is set to point at the read line
> + * PACKET_READ_FLUSH: 'pktlen' is set to '0' and 'line' is set to NULL
> + */
> +extern enum packet_read_status packet_reader_read(struct packet_reader *reader);

This is reasonable.  As described above an alternative would be
possible to have a separate packet_read_result output parameter but
the interface described here looks pretty easy/pleasant to use.

> +
> +/*
> + * Peek the next packet line without consuming it and return the status.

nit: s/Peek/Peek at/, or s/Peek/Read/

> + * The next call to 'packet_reader_read()' will perform a read of the same line
> + * that was peeked, consuming the line.

nit: s/peeked/peeked at/

> + *
> + * Peeking multiple times without calling 'packet_reader_read()' will return
> + * the same result.
> + */
> +extern enum packet_read_status packet_reader_peek(struct packet_reader *reader);

Nice.

[...]
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -406,3 +406,62 @@ ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
>  	}
>  	return sb_out->len - orig_len;
>  }
> +
> +/* Packet Reader Functions */
> +void packet_reader_init(struct packet_reader *reader, int fd,
> +			char *src_buffer, size_t src_len,
> +			int options)

This comment looks like it's attached to packet_reader_init, but it's
meant to be attached to the whole collection.  It's possible that this
title-above-multiple-functions won't be maintained, but that's okay.

> +{
> +	memset(reader, 0, sizeof(*reader));
> +
> +	reader->fd = fd;
> +	reader->src_buffer = src_buffer;
> +	reader->src_len = src_len;
> +	reader->buffer = packet_buffer;
> +	reader->buffer_size = sizeof(packet_buffer);

Looks like this is very non-reentrant.  Can the doc comment warn about
that?  Or even better, can it be made reentrant by owning its own
strbuf?

> +	reader->options = options;
> +}
> +
> +enum packet_read_status packet_reader_read(struct packet_reader *reader)
> +{
> +	if (reader->line_peeked) {
> +		reader->line_peeked = 0;
> +		return reader->status;
> +	}

Nice.

> +
> +	reader->status = packet_read_with_status(reader->fd,
> +						 &reader->src_buffer,
> +						 &reader->src_len,
> +						 reader->buffer,
> +						 reader->buffer_size,
> +						 &reader->pktlen,
> +						 reader->options);
> +
> +	switch (reader->status) {
> +	case PACKET_READ_EOF:
> +		reader->pktlen = -1;
> +		reader->line = NULL;
> +		break;
> +	case PACKET_READ_NORMAL:
> +		reader->line = reader->buffer;
> +		break;
> +	case PACKET_READ_FLUSH:
> +		reader->pktlen = 0;
> +		reader->line = NULL;
> +		break;
> +	}
> +
> +	return reader->status;
> +}
> +
> +enum packet_read_status packet_reader_peek(struct packet_reader *reader)
> +{
> +	/* Only allow peeking a single line */

nit: s/peeking at/

> +	if (reader->line_peeked)
> +		return reader->status;
> +
> +	/* Peek a line by reading it and setting peeked flag */

nit: s/Peek/Peek at/

> +	packet_reader_read(reader);
> +	reader->line_peeked = 1;
> +	return reader->status;
> +}

Thanks for a pleasant read.

Jonathan
