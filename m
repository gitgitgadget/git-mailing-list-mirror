Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F50B1F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 13:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034079AbcIYNqw (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 09:46:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36366 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966303AbcIYNqu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 09:46:50 -0400
Received: by mail-wm0-f67.google.com with SMTP id b184so10087347wma.3
        for <git@vger.kernel.org>; Sun, 25 Sep 2016 06:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=vmuV4S6kuYpieCUEtpsGczVbBnVy6+cAFj+ERs0UaOQ=;
        b=TxdW+LBtE7Sg2Joda2bZRrFCGPWG0ajXjIi+uYkojjI7UxCliPzslTbn8Q1DnJFm2G
         3mBCLTLbq94MY7JvCfTO4roOpMEdwOVLgbF25JeUsrmL0ddtsN0gw8Tk8u7hSl4AlTTi
         A7dBG3teSdc14rBZ+L3XP+XdcZDEjgEylMVwvkpN64v51kss4+ovNSs1xqMDqggVfMTX
         jVwZZkGF0sX/C1+jXjQDRFgrBDJ8aVFbtgarvpAMYvOFJDu/y4iJmjdkwVESksiFhFqe
         O690llRBit3I1MOBz1TQk2AZIN4ina66W2tIZKKGw5bcT2h+/oZ9Yui+IwsRbsqYYy6y
         2TTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=vmuV4S6kuYpieCUEtpsGczVbBnVy6+cAFj+ERs0UaOQ=;
        b=eTHk48cmiGBCr4IkLpEaICKhAVmsAMDL1qTt4nqRc82hzD48DZaJDL8UFNQM5+NRxz
         RSQeNED+lZd00cw+0BLHuH4pbBbztc5odau1HahVwjEF6xclwtX+JXUnDvjQzA+L/GE/
         EDhqjf/joSNxSZoPPk4TbLXrh19/pr82pfVxiof3b/igrzUdqDS/wJB/lyOGDMSTNqam
         f/p6M62bk5hU+X11FxaR1xHrCB6q5un3m8KY2uKmP+atiEhBiQruLZ3kWL3jZbUnD2Ay
         aLXp57irZwuvrKjieuqUcrrOK+qFPy7JIqm3ZL7XCS3RAJqU0soHEfHDa9cJNykUxPCA
         JigA==
X-Gm-Message-State: AA6/9Rniu0mkYUdO6mbPkQuw+eO027qhkW9ib5nUUZmtmNpQhKUOqVdYn9Z4xit/7maOYQ==
X-Received: by 10.28.209.76 with SMTP id i73mr9947111wmg.104.1474811209028;
        Sun, 25 Sep 2016 06:46:49 -0700 (PDT)
Received: from [192.168.1.26] (dce219.neoplus.adsl.tpnet.pl. [83.23.56.219])
        by smtp.googlemail.com with ESMTPSA id n131sm6083080wmd.3.2016.09.25.06.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Sep 2016 06:46:47 -0700 (PDT)
Subject: Re: [PATCH v8 07/11] pkt-line: add functions to read/write flush
 terminated packet streams
To:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-8-larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <507a29a1-99ff-c13e-cf1f-76631345a822@gmail.com>
Date:   Sun, 25 Sep 2016 15:46:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160920190247.82189-8-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> write_packetized_from_fd() and write_packetized_from_buf() write a
> stream of packets. All content packets use the maximal packet size
> except for the last one. After the last content packet a `flush` control
> packet is written.
> 
> read_packetized_to_buf() reads arbitrary sized packets until it detects
> a `flush` packet.

I guess that read_packetized_to_fd(), for completeness, is not needed
for the filter protocol (though it might be useful for the receive
side of send-pack / receive-pack).

Also, should it be read_packetized_to_strbuf()?  I guess using strbuf
to read is here because we might need more size to read in full, isn't
it.

> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  pkt-line.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  pkt-line.h |  7 +++++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/pkt-line.c b/pkt-line.c
> index fc0ac12..a0a8543 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -196,6 +196,47 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
>  	va_end(args);
>  }
>  
> +int write_packetized_from_fd(int fd_in, int fd_out)

I wonder if it would be worth it to name parameters in such way that
it is known from the name which one is to be packetized, for example
fd_out_pkt here...

But it might be not worth it; you can get it from the function name.

> +{
> +	static char buf[PKTLINE_DATA_MAXLEN];

Static buffer means not thread-safe and not reentrant. It would be
nice to have this information in a comment for this function, but
it is not necessary.

Also, is using static variable better than using global variable
`packet_buffer`?  Well, scope for weird interactions is smaller...

Sidenote: we have LARGE_PACKET_MAX (used in previous patch), but
PKTLINE_DATA_MAXLEN not LARGE_PACKET_DATA_MAX.

> +	int err = 0;
> +	ssize_t bytes_to_write;
> +
> +	while (!err) {
> +		bytes_to_write = xread(fd_in, buf, sizeof(buf));
> +		if (bytes_to_write < 0)
> +			return COPY_READ_ERROR;
> +		if (bytes_to_write == 0)
> +			break;
> +		err = packet_write_gently(fd_out, buf, bytes_to_write);
> +	}
> +	if (!err)
> +		err = packet_flush_gently(fd_out);
> +	return err;
> +}

Looks good: clean and readable.

Sidenote (probably outside of scope of this patch): what are the
errors that we can get from this function, beside COPY_READ_ERROR
of course?

> +
> +int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
> +{
> +	static char buf[PKTLINE_DATA_MAXLEN];
> +	int err = 0;
> +	size_t bytes_written = 0;
> +	size_t bytes_to_write;

Those two variables, instead of modifying the values of len and/or src_in,
make code very easy to read.

> +
> +	while (!err) {
> +		if ((len - bytes_written) > sizeof(buf))
> +			bytes_to_write = sizeof(buf);
> +		else
> +			bytes_to_write = len - bytes_written;
> +		if (bytes_to_write == 0)
> +			break;
> +		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write);
> +		bytes_written += bytes_to_write;
> +	}
> +	if (!err)
> +		err = packet_flush_gently(fd_out);
> +	return err;
> +}

Looks good: clean and readable.

> +
>  static int get_packet_data(int fd, char **src_buf, size_t *src_size,
>  			   void *dst, unsigned size, int options)
>  {
> @@ -305,3 +346,30 @@ char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
>  {
>  	return packet_read_line_generic(-1, src, src_len, dst_len);
>  }
> +
> +ssize_t read_packetized_to_buf(int fd_in, struct strbuf *sb_out)

It's a bit strange that the signature of write_packetized_from_buf() is
that different from read_packetized_to_buf().  This includes the return
value: int vs ssize_t.  As I have checked, write() and read() both
use ssize_t, while fread() and fwrite() both use size_t.

Perhaps this function should be named read_packetized_to_strbuf()
(err, I asked this already)?

> +{
> +	int paket_len;

Possible typo: shouldn't it be called packet_len?
Shouldn't it be initialized to 0?

  +	int packet_len = 0;

> +	int options = PACKET_READ_GENTLE_ON_EOF;

Why is this even a local variable?  It is never changed, and it is
used only in one place; we can inline it.

If it would be needed in subsequent patches, then such information
should be included in the commit message.

> +
> +	size_t oldlen = sb_out->len;
> +	size_t oldalloc = sb_out->alloc;

Just a nitpick (feel free to ignore): doesn't this looks better:

  +	size_t old_len   = sb_out->len;
  +	size_t old_alloc = sb_out->alloc;

Also perhaps s/old_/orig_/g.

> +
> +	for (;;) {

I see that you used the more popular way of coding forever loop:

  $ git grep 'for (;;)' -- '*.c'  | wc -l
  120
  $ git grep 'while (1)' -- '*.c' | wc -l
  86


> +		strbuf_grow(sb_out, PKTLINE_DATA_MAXLEN+1);
> +		paket_len = packet_read(fd_in, NULL, NULL,
> +			sb_out->buf + sb_out->len, PKTLINE_DATA_MAXLEN+1, options);

A question (which perhaps was answered during the development of this
patch series): why is this +1 in PKTLINE_DATA_MAXLEN+1 here?

> +		if (paket_len <= 0)
> +			break;
> +		sb_out->len += paket_len;
> +	}
> +
> +	if (paket_len < 0) {
> +		if (oldalloc == 0)
> +			strbuf_release(sb_out);
> +		else
> +			strbuf_setlen(sb_out, oldlen);

A question (maybe I don't understand strbufs): why there is a special
case for oldalloc == 0?

> +		return paket_len;
> +	}
> +	return sb_out->len - oldlen;
> +}
> diff --git a/pkt-line.h b/pkt-line.h
> index 3fa0899..6df8449 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -25,6 +25,8 @@ void packet_buf_flush(struct strbuf *buf);
>  void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
>  int packet_flush_gently(int fd);
>  int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
> +int write_packetized_from_fd(int fd_in, int fd_out);
> +int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
>  
>  /*
>   * Read a packetized line into the buffer, which must be at least size bytes
> @@ -77,6 +79,11 @@ char *packet_read_line(int fd, int *size);
>   */
>  char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
>  
> +/*
> + * Reads a stream of variable sized packets until a flush packet is detected.
> + */
> +ssize_t read_packetized_to_buf(int fd_in, struct strbuf *sb_out);
> +
>  #define DEFAULT_PACKET_MAX 1000
>  #define LARGE_PACKET_MAX 65520
>  extern char packet_buffer[LARGE_PACKET_MAX];
> 

