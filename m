Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE3DC1F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 12:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbcG3M3i (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 08:29:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34190 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbcG3M3h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 08:29:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so19295897wma.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 05:29:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=N0vXtFdp403nHIxDuwuG96D2vTdGPIE0kH1brQmNJS8=;
        b=G8/wHoTbk97NpSn9NZAdbUfC5vZzdtEooWJPyZhDBeRrK7FitjxRMZg4keYS0H2sRe
         Xjdw5jk3TRDt7nbqbaHvhizPkhT4uMmtYWZSYcDJTogxKgetuaJyiimHtJ2kvyEipKpd
         viknXBdiIJLgt4F5HLKCmGxhdDSdLO5GmgUGQFGxlYnZRNWJj+kSZdZc5ENYEiWxszkD
         9rZAismn7t7jBICtttVjKeJghxKgf27HPeSxfYMkEQT1c0BtgnwxcatGSuHC6cmUITW2
         Xrek7zW7GpkOMvQ9mdqpgrvfzFWPY+xheL0hyAAZcsZSVUEO7v8+/1NuqMHZUKLd9Uph
         6WwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=N0vXtFdp403nHIxDuwuG96D2vTdGPIE0kH1brQmNJS8=;
        b=LtG9K/S44QCVOGhJfKnge57MITR4ZUn7//eMu/fkZZdueXt7fCW3NLou9SrV9ENalQ
         rKs+YyMkNL3rF27vV5kqVnCvnrgL04MrrNLSNfQDw2fRUeiZD/qdD1aF9hsyraJAs58j
         spmhbHY5enbou4HrwrxHoHShWAsjbvOvn41/wGVjRLRGg2+ET2fo0+f4FBkqpxvj9DTs
         ZgPI7wpDfpDq0S+FW6MK8MpPFHrbhf0JmHBaGuRbEjSSbi5r9mLRRPeYVau6+bzHsfL4
         +aSGEmkm2ahLZBfPTiKM08oq8PAJ44spd9pTep3VOgaoM3p5WjZVftHy6JhXPJwrCQdZ
         tdXA==
X-Gm-Message-State: AEkoouvNBEzDretu8vxYdNAClh2i61M1fK8j3/j/jEnZ8sgF9peLFc2mX5Nd5tUtjdTrpQ==
X-Received: by 10.194.171.131 with SMTP id au3mr43597858wjc.125.1469881775343;
        Sat, 30 Jul 2016 05:29:35 -0700 (PDT)
Received: from [192.168.1.26] (dax57.neoplus.adsl.tpnet.pl. [83.23.23.57])
        by smtp.googlemail.com with ESMTPSA id e10sm21092169wjc.21.2016.07.30.05.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jul 2016 05:29:34 -0700 (PDT)
Subject: Re: [PATCH v3 04/10] pkt-line: call packet_trace() only if a packet
 is actually send
To:	larsxschneider@gmail.com, git@vger.kernel.org
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160729233801.82844-5-larsxschneider@gmail.com>
Cc:	gitster@pobox.com, tboegi@web.de, mlbright@gmail.com, e@80x24.org,
	peff@peff.net
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <786f0b8e-29f0-3dd3-7bb4-5f6558f8ec84@gmail.com>
Date:	Sat, 30 Jul 2016 14:29:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160729233801.82844-5-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 30.07.2016 o 01:37, larsxschneider@gmail.com pisze:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> The packet_trace() call is not ideal in format_packet() as we would print

Style; I think the following is more readable:

  The packet_trace() call in format_packet() is not ideal, as we would...

> a trace when a packet is formatted and (potentially) when the packet is
> actually send. This was no problem up until now because format_packet()
> was only used by one function. Fix it by moving the trace call into the
> function that actally sends the packet.

s/actally/actually/

I don't buy this explanation.  If you want to trace packets, you might
do it on input (when formatting packet), or on output (when writing
packet).  It's when there are more than one formatting function, but
one writing function, then placing trace call in write function means
less code duplication; and of course the reverse.

Another issue is that something may happen between formatting packet
and sending it, and we probably want to packet_trace() when packet
is actually send.

Neither of those is visible in commit message.

> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  pkt-line.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pkt-line.c b/pkt-line.c
> index 1728690..32c0a34 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -126,7 +126,6 @@ static void format_packet(struct strbuf *out, const char *fmt, va_list args)
>  		die("protocol error: impossibly long line");
>  
>  	set_packet_header(&out->buf[orig_len], n);
> -	packet_trace(out->buf + orig_len + 4, n - 4, 1);
>  }
>  
>  void packet_write(int fd, const char *fmt, ...)
> @@ -138,6 +137,7 @@ void packet_write(int fd, const char *fmt, ...)
>  	va_start(args, fmt);
>  	format_packet(&buf, fmt, args);
>  	va_end(args);
> +	packet_trace(buf.buf + 4, buf.len - 4, 1);
>  	write_or_die(fd, buf.buf, buf.len);
>  }
>  
> 

