Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13F481F404
	for <e@80x24.org>; Tue, 13 Feb 2018 00:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932875AbeBMAcV (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 19:32:21 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35652 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932769AbeBMAcU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 19:32:20 -0500
Received: by mail-pl0-f65.google.com with SMTP id o11so2174651pls.2
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 16:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RhUALTCwL67N2loX8N1aEs/rS0tr+0iiWvKA2Ii7G7M=;
        b=bLLBgAV6W1QmX8oRc2FiW8JhYuPjkwo4x/thYlfffC+l/0iJAKazzYFyLEb26sC25n
         rjsu7AUzYKvYsmRfxXKZsmuLv35uLg/I6KzP71SC2vOhuMRjoPn3HbsrATmC/IIdceDh
         GP7CeOxL0l26LFjaEw76rOAo32L5vjk94egIlJyeTEj9l3jqchWxJQ9lrGSS2gJ6o5Rl
         WxkYurNHyxFuAMGceVC2JHUWZ1FyhA9Imw7WsqfrR9OHX1iHOtmw+a87A3ZkLnBG/BLP
         IueoE60TJjRv6zB9lGiR/RRkWPAEabH9tRu9+wVCUjI8mIF8XWVfMafpcBWOEwhYRpt2
         PJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RhUALTCwL67N2loX8N1aEs/rS0tr+0iiWvKA2Ii7G7M=;
        b=jXGtu1J8ji/IYcrkvSY9YXHKWRyQ1ywAfGLZlBVPQXpKwgWipI8+3JbFU0Yo8KxDFL
         Q/liGHrCuODUusv9g8G3COpWyLQRRaGWxqQBsvdMcwp4EQbgfskMo5S2dQWUuWqhH61s
         ZQQFC3ZBdiX0W7inmn8flOZPInTZDjE4GFRE/Ys+UR/07G1wzImacqsx27B+JcuNUPld
         OSQE5oKI4iTCpA/JlZMRWS3u1RmGNiFxSZUys7wJ3o70tx8dXa8pYgTgxHdA007B8WWB
         RqLC3VX4mVzwpOO7M/+sTGeu0lHpzaJl10I5XR3BpZelZftQN8j3TkJtjuHPXRSqCJ9W
         gP4Q==
X-Gm-Message-State: APf1xPBj5gwtHwd00NDGxZinuOEnAciv455D2VHrK3ag94Bp9Mut6gQ8
        /2UCrJgZ9Jcc7Od3rydnSGR1mcUW
X-Google-Smtp-Source: AH8x224Eo0yXUeV2WOJ9ad6nqWfvXQcQEElnVwWWbfPZ7tx4sEWosuSTZA0kAexA1ETVJdrXwysqxw==
X-Received: by 2002:a17:902:bc02:: with SMTP id n2-v6mr12181360pls.52.1518481939777;
        Mon, 12 Feb 2018 16:32:19 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b9sm1265243pgv.69.2018.02.12.16.32.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 16:32:19 -0800 (PST)
Date:   Mon, 12 Feb 2018 16:25:54 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 01/35] pkt-line: introduce packet_read_with_status
Message-ID: <20180213002554.GA42272@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-2-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207011312.189834-2-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> The current pkt-line API encodes the status of a pkt-line read in the
> length of the read content.  An error is indicated with '-1', a flush
> with '0' (which can be confusing since a return value of '0' can also
> indicate an empty pkt-line), and a positive integer for the length of
> the read content otherwise.  This doesn't leave much room for allowing
> the addition of additional special packets in the future.
>
> To solve this introduce 'packet_read_with_status()' which reads a packet
> and returns the status of the read encoded as an 'enum packet_status'
> type.  This allows for easily identifying between special and normal
> packets as well as errors.  It also enables easily adding a new special
> packet in the future.

Makes sense, thanks.  Using an enum return value is less opaque, too.

[...]
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -280,28 +280,33 @@ static int packet_length(const char *linelen)
>  	return (val < 0) ? val : (val << 8) | hex2chr(linelen + 2);
>  }
>  
> -int packet_read(int fd, char **src_buf, size_t *src_len,
> -		char *buffer, unsigned size, int options)
> +enum packet_read_status packet_read_with_status(int fd, char **src_buffer, size_t *src_len,
> +						char *buffer, unsigned size, int *pktlen,
> +						int options)

This function definition straddles two worlds: it is line-wrapped as
though there are a limited number of columns, but it goes far past 80
columns.

Can "make style" or a similar tool take care of rewrapping it?


>  {
> -	int len, ret;
> +	int len;
>  	char linelen[4];
>  
> -	ret = get_packet_data(fd, src_buf, src_len, linelen, 4, options);
> -	if (ret < 0)
> -		return ret;
> +	if (get_packet_data(fd, src_buffer, src_len, linelen, 4, options) < 0)
> +		return PACKET_READ_EOF;
> +

EOF is indeed the only error that get_packet_data can return.

Could be worth a doc comment on get_packet_data to make that clearer.
It's not too important since it's static, though.

>  	len = packet_length(linelen);
> -	if (len < 0)
> +
> +	if (len < 0) {
>  		die("protocol error: bad line length character: %.4s", linelen);
> -	if (!len) {
> +	} else if (!len) {
>  		packet_trace("0000", 4, 0);
> -		return 0;
> +		return PACKET_READ_FLUSH;

The advertised change. Makes sense.

[...]
> -	if (len >= size)
> +	if ((unsigned)len >= size)
>  		die("protocol error: bad line length %d", len);

The comparison is safe since we just checked that len >= 0.

Is there some static analysis that can make this kind of operation
easier?

[...]
> @@ -309,7 +314,31 @@ int packet_read(int fd, char **src_buf, size_t *src_len,
>  
>  	buffer[len] = 0;
>  	packet_trace(buffer, len, 0);
> -	return len;
> +	*pktlen = len;
> +	return PACKET_READ_NORMAL;
> +}
> +
> +int packet_read(int fd, char **src_buffer, size_t *src_len,
> +		char *buffer, unsigned size, int options)
> +{
> +	enum packet_read_status status;
> +	int pktlen;
> +
> +	status = packet_read_with_status(fd, src_buffer, src_len,
> +					 buffer, size, &pktlen,
> +					 options);
> +	switch (status) {
> +	case PACKET_READ_EOF:
> +		pktlen = -1;
> +		break;
> +	case PACKET_READ_NORMAL:
> +		break;
> +	case PACKET_READ_FLUSH:
> +		pktlen = 0;
> +		break;
> +	}
> +
> +	return pktlen;

nit: can simplify by avoiding the status temporary:

	int pktlen;

	switch (packet_read_with_status(...)) {
	case PACKET_READ_EOF:
		return -1;
	case PACKET_READ_FLUSH:
		return 0;
	case PACKET_READ_NORMAL:
		return pktlen;
	}

As a bonus, that lets static analyzers check that the cases are
exhaustive.  (On the other hand, C doesn't guarantee that an enum can
only have the values listed as enumerators.  Did we end up figuring
out a way to handle that, beyond always including a 'default: BUG()'?)

> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -65,6 +65,21 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
>  int packet_read(int fd, char **src_buffer, size_t *src_len, char
>  		*buffer, unsigned size, int options);
>  
> +/*
> + * Read a packetized line into a buffer like the 'packet_read()' function but
> + * returns an 'enum packet_read_status' which indicates the status of the read.
> + * The number of bytes read will be assigined to *pktlen if the status of the
> + * read was 'PACKET_READ_NORMAL'.
> + */
> +enum packet_read_status {
> +	PACKET_READ_EOF = -1,
> +	PACKET_READ_NORMAL,
> +	PACKET_READ_FLUSH,
> +};

nit: do any callers treat the return value as a number?  It would be
less magical if the numbering were left to the compiler (0, 1, 2).

Thanks,
Jonathan
