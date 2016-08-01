Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DA541F855
	for <e@80x24.org>; Mon,  1 Aug 2016 12:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbcHAMSo (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 08:18:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36618 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342AbcHAMSn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2016 08:18:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so25883788wma.3
        for <git@vger.kernel.org>; Mon, 01 Aug 2016 05:18:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0VGxAma+Jci4BIzGddBY0MtkzCvBk35uINCffzzFDu4=;
        b=sk2B1fOiQkv1mx2UzReGZziNrmdWJM7cNWiNhSNLdxt4CdXZR7I9feqJlbJiHSNplQ
         VE8mDYfNVcUYKkWT7OT4QgdrfIBlZkvSU/pPUq31bOLP2TUYAVDqip4/cW5TjFTiQb7U
         RLtQzh26QUj7KxtpYiHWp2IWmwcusOV7iRxkB9DEOflnIwDhWtBiih1d1JCPaMrhIoSY
         Kcizig/oiVntSXML7JIHTYQYBQ0S45hqCM93/l/LO5uXpqZP2oO/6Ia6wMB2GZbHW+lu
         K/Dnlk6U0Zi1v5YcldrMm5dNBP0+gNbHlLYBz5VqU4+OWqDFJsjmbv9OF1ymOfwF+OR8
         EeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0VGxAma+Jci4BIzGddBY0MtkzCvBk35uINCffzzFDu4=;
        b=K+cvHU2lzmiMf0ipukE/yQmCNt35z8JYwSSLrHIfQqK4tDvdpd2/8VoiZvwMb0Dujz
         T6kxc6SpZ2TECyz2yOBb1FAzxHFzc5vqF3Tr2gXtAEGtfziS41U6kDYWyPCq8q0Wp0hx
         oZ7CHBhATAYA7cjUoz1z+2R54DcHpUe/Zw/lQiZo4CNfFfcTrXjQa9QXe+XCO69FtPzb
         BOGllNBgkpFkinh/dSVxfdPp+HcxU1JgBdLeiJvIsft5cTPih9bZBwf09Eu1qhXqzD38
         4R3ogrr6YVHMg7k1sFl1U56lKKObFNtIYA9QN4t3VoTsffJzlVPsMKijg/XOhIZU6NEI
         Oyrw==
X-Gm-Message-State: AEkoouupwW4veZpCN8XaJs0gzrekRi3AyZTk8W3nv1ZkLXzfOCMoCh81B6PlMRaY6A0waw==
X-Received: by 10.28.0.70 with SMTP id 67mr58860627wma.88.1470053921760;
        Mon, 01 Aug 2016 05:18:41 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id i7sm30287722wjg.42.2016.08.01.05.18.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Aug 2016 05:18:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 04/10] pkt-line: call packet_trace() only if a packet is actually send
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <786f0b8e-29f0-3dd3-7bb4-5f6558f8ec84@gmail.com>
Date:	Mon, 1 Aug 2016 14:18:36 +0200
Cc:	git@vger.kernel.org, gitster@pobox.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net
Content-Transfer-Encoding: 8BIT
Message-Id: <52A5703D-AF9E-405D-A4F8-E30A7B923400@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/> <20160729233801.82844-1-larsxschneider@gmail.com> <20160729233801.82844-5-larsxschneider@gmail.com> <786f0b8e-29f0-3dd3-7bb4-5f6558f8ec84@gmail.com>
To:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 30 Jul 2016, at 14:29, Jakub Narębski <jnareb@gmail.com> wrote:
> 
> W dniu 30.07.2016 o 01:37, larsxschneider@gmail.com pisze:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> The packet_trace() call is not ideal in format_packet() as we would print
> 
> Style; I think the following is more readable:
> 
>  The packet_trace() call in format_packet() is not ideal, as we would...

Agreed!


>> a trace when a packet is formatted and (potentially) when the packet is
>> actually send. This was no problem up until now because format_packet()
>> was only used by one function. Fix it by moving the trace call into the
>> function that actally sends the packet.
> 
> s/actally/actually/

Thanks!


> I don't buy this explanation.  If you want to trace packets, you might
> do it on input (when formatting packet), or on output (when writing
> packet).  It's when there are more than one formatting function, but
> one writing function, then placing trace call in write function means
> less code duplication; and of course the reverse.
> 
> Another issue is that something may happen between formatting packet
> and sending it, and we probably want to packet_trace() when packet
> is actually send.
> 
> Neither of those is visible in commit message.

The packet_trace() call in format_packet() is not ideal, as we would print
a trace when a packet is formatted and (potentially) when the same packet is
actually written. This was no problem up until now because packet_write(),
the function that uses format_packet() and writes the formatted packet,
did not trace the packet.

This developer believes that trace calls should only happen when a packet
is actually written as the packet could be modified between formatting
and writing. Therefore the trace call was moved from format_packet() to 
packet_write().

--

Better?

> 
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> pkt-line.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/pkt-line.c b/pkt-line.c
>> index 1728690..32c0a34 100644
>> --- a/pkt-line.c
>> +++ b/pkt-line.c
>> @@ -126,7 +126,6 @@ static void format_packet(struct strbuf *out, const char *fmt, va_list args)
>> 		die("protocol error: impossibly long line");
>> 
>> 	set_packet_header(&out->buf[orig_len], n);
>> -	packet_trace(out->buf + orig_len + 4, n - 4, 1);
>> }
>> 
>> void packet_write(int fd, const char *fmt, ...)
>> @@ -138,6 +137,7 @@ void packet_write(int fd, const char *fmt, ...)
>> 	va_start(args, fmt);
>> 	format_packet(&buf, fmt, args);
>> 	va_end(args);
>> +	packet_trace(buf.buf + 4, buf.len - 4, 1);
>> 	write_or_die(fd, buf.buf, buf.len);
>> }
>> 
>> 
> 

