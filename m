Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C022B1F858
	for <e@80x24.org>; Sat, 30 Jul 2016 10:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbcG3KtX (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 06:49:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35054 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbcG3KtW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 06:49:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so19042560wmg.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 03:49:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=cb5jOOiJiaPcJDzC1k8cPcgwvlClg3WtwhwxWQMw2M0=;
        b=Ad3x4Sw/yzUQfBzKUlxDPKVPYexDKXeYIHNBC45G8Ml2ianK94K2zBu/ZEREzYMZXo
         HDblcweZ7KiCHgd2rcGdL8iWdGS2NNFJuddOFNwAzbyFLWN44qgThPc2/uJhENYJK/uZ
         4PgufDU0Mu9mETMmkHfZEx2zMjGS2YLXXcBNS8sNLZL/Hza6QaFf543c15DHBCrIQuQ0
         S/N9UN3vzLGIeb8hWuPheKdbiOZnNeg1cNG9cScuww811uGOWhY5bxB+N1ghVLLvNsiq
         QvLSYA4VJPiQljTrTFyDrR1SfOdnX1TWxpV97wFv4h55brktiAkF3mIjRtczLp9QZAtC
         tg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=cb5jOOiJiaPcJDzC1k8cPcgwvlClg3WtwhwxWQMw2M0=;
        b=QZzjxiXKIaQab6G1Y5smkRJHrroJkDCWtvB61hJZWYSzAsLGsJF5qIuVmVjhMxAIaO
         0Q+a+tmS+AX/ANCVeUQEnbw7NkuiHc4/d0RCA7fq30+G0hHBsORZm9xQ24IeMarDfejT
         /JzofLGE4a9DGtjbq85M1ToKYdhPjsFDMWPubyZ481ktZ5QvRVbWwZrm+wor6bYeLzM4
         nYQpDGjYXelcxpSx0tS0sNWLsaROLIyt5y56Kc3ykwcANm4qF93vOsVn7XbMQv9VEHEz
         47PwZW3v5LBz+2nV03ePriqBzPIBxt0ioZxy9ZskALL4jDVVncb2qRMUlSD0CJydKCyv
         Q0mg==
X-Gm-Message-State: AEkoouu+zHmZmrh008Uuh+qa6/W2uP/i/v0a+ecdl/McpGFz8qZeHgVST9ZwRU9KfPAGpQ==
X-Received: by 10.28.26.5 with SMTP id a5mr51017773wma.27.1469875760884;
        Sat, 30 Jul 2016 03:49:20 -0700 (PDT)
Received: from [192.168.1.26] (ddi132.neoplus.adsl.tpnet.pl. [83.23.86.132])
        by smtp.googlemail.com with ESMTPSA id yz6sm20697944wjb.35.2016.07.30.03.49.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jul 2016 03:49:20 -0700 (PDT)
Subject: Re: [PATCH v3 02/10] pkt-line: add direct_packet_write() and
 direct_packet_write_data()
To:	Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160729233801.82844-3-larsxschneider@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>, tboegi@web.de,
	mlbright@gmail.com, Eric Wong <e@80x24.org>,
	Jeff King <peff@peff.net>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <58e4737b-6e0e-565c-2468-05c705dea426@gmail.com>
Date:	Sat, 30 Jul 2016 12:49:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160729233801.82844-3-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 30.07.2016 o 01:37, larsxschneider@gmail.com pisze:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Sometimes pkt-line data is already available in a buffer and it would
> be a waste of resources to write the packet using packet_write() which
> would copy the existing buffer into a strbuf before writing it.
> 
> If the caller has control over the buffer creation then the
> PKTLINE_DATA_START macro can be used to skip the header and write
> directly into the data section of a pkt-line (PKTLINE_DATA_LEN bytes
> would be the maximum). direct_packet_write() would take this buffer,
> adjust the pkt-line header and write it.
> 
> If the caller has no control over the buffer creation then
> direct_packet_write_data() can be used. This function creates a pkt-line
> header. Afterwards the header and the data buffer are written using two
> consecutive write calls.

I don't quite understand what do you mean by "caller has control
over the buffer creation".  Do you mean that caller either can write
over the buffer, or cannot overwrite the buffer?  Or do you mean that
caller either can allocate buffer to hold header, or is getting
only the data?

> 
> Both functions have a gentle parameter that indicates if Git should die
> in case of a write error (gentle set to 0) or return with a error (gentle
> set to 1).

So they are *_maybe_gently(), isn't it ;-)?  Are there any existing
functions in Git codebase that take 'gently' / 'strict' / 'die_on_error'
parameter?

> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  pkt-line.c | 30 ++++++++++++++++++++++++++++++
>  pkt-line.h |  5 +++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/pkt-line.c b/pkt-line.c
> index 445b8e1..6fae508 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -135,6 +135,36 @@ void packet_write(int fd, const char *fmt, ...)
>  	write_or_die(fd, buf.buf, buf.len);
>  }
>  
> +int direct_packet_write(int fd, char *buf, size_t size, int gentle)
> +{
> +	int ret = 0;
> +	packet_trace(buf + 4, size - 4, 1);
> +	set_packet_header(buf, size);
> +	if (gentle)
> +		ret = !write_or_whine_pipe(fd, buf, size, "pkt-line");
> +	else
> +		write_or_die(fd, buf, size);

Hmmm... in gently case we get the information in the warning that
it is about "pkt-line", which is missing from !gently case.  But
it is probably not important.

> +	return ret;
> +}

Nice clean function, thanks to extracting set_packet_header().

> +
> +int direct_packet_write_data(int fd, const char *buf, size_t size, int gentle)

I would name the parameter 'data', rather than 'buf'; IMVHO it
better describes it.

> +{
> +	int ret = 0;
> +	char hdr[4];
> +	set_packet_header(hdr, sizeof(hdr) + size);
> +	packet_trace(buf, size, 1);
> +	if (gentle) {
> +		ret = (
> +			!write_or_whine_pipe(fd, hdr, sizeof(hdr), "pkt-line header") ||

You can write '4' here, no need for sizeof(hdr)... though compiler would
optimize it away.

> +			!write_or_whine_pipe(fd, buf, size, "pkt-line data")
> +		);

Do we want to try to write "pkt-line data" if "pkt-line header" failed?
If not, perhaps De Morgan-ize it

  +		ret = !(
  +			write_or_whine_pipe(fd, hdr, sizeof(hdr), "pkt-line header") &&
  +			write_or_whine_pipe(fd, buf, size, "pkt-line data")
  +		);


> +	} else {
> +		write_or_die(fd, hdr, sizeof(hdr));
> +		write_or_die(fd, buf, size);

I guess these two writes (here and in 'gently' case) are unavoidable...

> +	}
> +	return ret;
> +}
> +
>  void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
>  {
>  	va_list args;
> diff --git a/pkt-line.h b/pkt-line.h
> index 3cb9d91..02dcced 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -23,6 +23,8 @@ void packet_flush(int fd);
>  void packet_write(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
>  void packet_buf_flush(struct strbuf *buf);
>  void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
> +int direct_packet_write(int fd, char *buf, size_t size, int gentle);
> +int direct_packet_write_data(int fd, const char *buf, size_t size, int gentle);
>  
>  /*
>   * Read a packetized line into the buffer, which must be at least size bytes
> @@ -77,6 +79,9 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
>  
>  #define DEFAULT_PACKET_MAX 1000
>  #define LARGE_PACKET_MAX 65520
> +#define PKTLINE_HEADER_LEN 4
> +#define PKTLINE_DATA_START(pkt) ((pkt) + PKTLINE_HEADER_LEN)
> +#define PKTLINE_DATA_LEN (LARGE_PACKET_MAX - PKTLINE_HEADER_LEN)

Those are not used in direct_packet_write() and direct_packet_write_data();
but they would make them more verbose and less readable.

>  extern char packet_buffer[LARGE_PACKET_MAX];
>  
>  #endif
> 

