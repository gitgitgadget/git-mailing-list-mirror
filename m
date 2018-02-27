Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A4D01F404
	for <e@80x24.org>; Tue, 27 Feb 2018 23:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbeB0XLu (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 18:11:50 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37343 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbeB0XLt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 18:11:49 -0500
Received: by mail-pg0-f68.google.com with SMTP id y26so207812pgv.4
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 15:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CQVwrTaT7+LTri8PFOxnygjQ/M0HLqt0Wty6ANWhAlo=;
        b=oiAXCRnTNIZhf/fpu7Xgh6+jEUieMozoDbtNGQe2NvTzClCKjORe8ADr5+AU3dn1iY
         EJOE+k4EZ7CfRaoYSQrGYj8MqO7OBSpM+U6sL8sM/J7JZ5WvHiWaLwU5l1ZSk+UfGiw0
         kQJFy7rmHo5SOgtMyih5v0LlFAm64/AAl6DNQae7qqD9Xe9jb1EifGrHn7bbwNOV7Ipp
         x6NlwODvJwkEmURfehDVJJodlchiY2+0/+ZWVZZxZfFj/I0zMTdwJjaL/sbDLEP8k/g+
         9JBJXXDHvndYvwPqUgxZmUJIwt0QtCpvf7hIQU/UmnUM8UvI7/7MrFFHsy2tMY+46Fzb
         MStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CQVwrTaT7+LTri8PFOxnygjQ/M0HLqt0Wty6ANWhAlo=;
        b=hdXCZjeh3wMEwaMMeITc8GOr/Zo/4KaagqaRU/VLBwreKAaoVroFIMuJOOsB+Go40w
         ZD/KZdjijwDq4Y6Whz/3/pmGaWYnhalVW7k8+77kQKblWp3NB99QoUMUsUAIhW7/Y5pu
         6l2Y9XldlQ6RYf8lue3qFXwa3V5ufoYBghrwOa11S4QMIP2qeDh2I0/3XQVjDGuTB4Ll
         98gM6BVxPYhef390ajJUWemmaQeHvti/2svESvgMNUNvgoOPgNJQXFbdV4dgsg3V9rna
         YMBk7LLxK4Etc1AN1F29/LqIZ7s86XbgLrXXAnS15eh8uQkciK0T22g+XtzHn4ZDhci/
         2+0Q==
X-Gm-Message-State: APf1xPDkUypnn5aMKK7qTe47T1//gGx9WltM1jm2gbhaPgtiKoL4OiKX
        sBLvExpd0Qzt+RgjpLxa6Ag=
X-Google-Smtp-Source: AH8x226DSFPhqJNCCcJxuExngpwCK6zAm0tzU1Gs26PLGzhhFcl46Xkjd4+R7wsSc16hHedP0d/qtw==
X-Received: by 10.101.101.138 with SMTP id u10mr12199735pgv.299.1519773108546;
        Tue, 27 Feb 2018 15:11:48 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id l19sm222932pgc.47.2018.02.27.15.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 15:11:47 -0800 (PST)
Date:   Tue, 27 Feb 2018 15:11:45 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 29/35] pkt-line: add packet_buf_write_len function
Message-ID: <20180227231145.GF174036@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-30-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207011312.189834-30-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> Add the 'packet_buf_write_len()' function which allows for writing an
> arbitrary length buffer into a 'struct strbuf' and formatting it in
> packet-line format.

Makes sense.

[...]
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -26,6 +26,7 @@ void packet_buf_flush(struct strbuf *buf);
>  void packet_buf_delim(struct strbuf *buf);
>  void packet_write(int fd_out, const char *buf, size_t size);
>  void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
> +void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len);

I wonder if we should rename packet_buf_write to something like
packet_buf_writef.  Right now there's a kind of confusing collection of
functions without much symmetry.

Alternatively, the _buf_ ones could become strbuf_* functions:

	strbuf_add_packet(&buf, data, len);
	strbuf_addf_packet(&buf, fmt, ...);

That would make it clearer that these append to buf.

I'm just thinking out loud.  For this series, the API you have here
looks fine, even if it is a bit inconsistent.  (In other words, even
if you agree with me, this would probably be best addressed as a patch
on top.)

[...]
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -215,6 +215,22 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
>  	va_end(args);
>  }
>  
> +void packet_buf_write_len(struct strbuf *buf, const char *data, size_t len)
> +{
> +	size_t orig_len, n;
> +
> +	orig_len = buf->len;
> +	strbuf_addstr(buf, "0000");
> +	strbuf_add(buf, data, len);
> +	n = buf->len - orig_len;
> +
> +	if (n > LARGE_PACKET_MAX)
> +		die("protocol error: impossibly long line");

Could the error message describe the long line (e.g.

		...impossibly long line %.*s...", 256, data);

)?

> +
> +	set_packet_header(&buf->buf[orig_len], n);
> +	packet_trace(buf->buf + orig_len + 4, n - 4, 1);

Could do, more simply:

	packet_trace(data, len, 1);

Thanks,
Jonathan
