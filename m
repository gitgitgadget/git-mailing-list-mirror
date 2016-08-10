Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 955701FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S941367AbcHJTV1 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:21:27 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36994 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936454AbcHJTCZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 15:02:25 -0400
Received: by mail-wm0-f44.google.com with SMTP id i5so124191814wmg.0
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 12:01:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jokIpIKeBLZqrvSTx9zVh+tDVl8ky++l7h7t03abb80=;
        b=UQZRVcziJ9ixphb/3KiB1b1wcGBbLieuUOlGB8V8ZQ2cxUFFej4M9CSOzI+LkB43Lh
         PRC0T7tGkIoscSdSkieYxizol83U8+3NnaYZ5gozuPVXwRpRdU7wOkx8PUqawHy4+UD8
         3I3mZKwScAbcbh14HCkhjbav7/V0bRrbC8YEOs+s6+8vGDa87tGtz9Dd5XQR4K5rd0aj
         S4CzpcJVpf/u+YofO6Y4bFUegFtDUam16fGnnP3BzI+OW0wx9ddeRvb4VxeMlDCRZpKR
         76fFbicj87wj+QMTnWc/b2uUkpPN9wjyW3ShhLRnz6EzbJ/vtW0oY1iF7Enua+oCVTOQ
         px/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jokIpIKeBLZqrvSTx9zVh+tDVl8ky++l7h7t03abb80=;
        b=fnMJejG+JlKXbGlC4dcIpFXIBpyryHSRxN2ktrrJs3N4b1Y/7HqE/qtP7abAVGUO2s
         freflFKJ562h35fYBumy32OSitTcHSiBahPkPfTD+pfQHI3cGGgm1hi12/GK2Jxna9tc
         wU/XgOfVDbRprsWqT0Wo/zIA4CCZVIemCDNz5WNzzpZxjJG17U6RE4CSp0r4oVD7kMIS
         JmvOl+NUUF85cCco/vjtMVNSGSF67MUMYb09optQCAhxQ2LX8OoMQAtT4XlIkX5Uqfxv
         B15vyMTmnpUNz4NO+ZRxMk0stqF8kRSs/H/aXu2izycKIs0UtZEvozEY0IiYOsbeMUeF
         k1sw==
X-Gm-Message-State: AEkoout0q47sToa94AG9gk98jwG7IjOkWe5l+Ut/Vnj1rNRRNK3udPkXZdyQr2ZLTOe+4A==
X-Received: by 10.28.36.10 with SMTP id k10mr3236094wmk.33.1470837096716;
        Wed, 10 Aug 2016 06:51:36 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id i1sm43129213wjl.9.2016.08.10.06.51.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 06:51:36 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 02/15] pkt-line: call packet_trace() only if a packet is actually send
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160810133017.ovdx3a3ldqj5gl7q@sigill.intra.peff.net>
Date:	Wed, 10 Aug 2016 15:51:35 +0200
Cc:	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	jnareb@gmail.com, mlbright@gmail.com, e@80x24.org,
	Johannes.Schindelin@gmx.de, ben@wijen.net
Content-Transfer-Encoding: 8BIT
Message-Id: <9BF0767F-6B10-42D5-9A72-2710A753E26A@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/> <20160810130411.12419-1-larsxschneider@gmail.com> <20160810130411.12419-3-larsxschneider@gmail.com> <20160810131317.a4npld5hf2qk6wiq@sigill.intra.peff.net> <4111F00D-74A9-449D-BDE9-EE170DA4A403@gmail.com> <20160810133017.ovdx3a3ldqj5gl7q@sigill.intra.peff.net>
To:	Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 10 Aug 2016, at 15:30, Jeff King <peff@peff.net> wrote:
> 
> On Wed, Aug 10, 2016 at 03:24:38PM +0200, Lars Schneider wrote:
> 
>>> On Wed, Aug 10, 2016 at 03:03:58PM +0200, larsxschneider@gmail.com wrote:
>>> 
>>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>> 
>>>> The packet_trace() call is not ideal in format_packet() as we would print
>>>> a trace when a packet is formatted and (potentially) when the packet is
>>>> actually send. This was no problem up until now because format_packet()
>>>> was only used by one function. Fix it by moving the trace call into the
>>>> function that actually sends the packet.
>>> 
>>> It looks like there are two functions: packet_write() and
>>> packet_buf_write().
>> 
>> I did not call trace in packet_buf_write() because this function does not
>> perform any writes.
> 
> Yes, but then who is responsible for the trace? The caller?

From my point of view the one that issues the write call.


> And why is it a bad thing to do it some time other than writing? It is
> if you format and then _don't_ write the packet, but the current callers
> are not doing that.

True, they don't do that. However, I don't think that is intuitive behavior
for future callers. If I call "format" and then trace tells me that a packet
was sent although it was not (yet).

> 
>>> Your patch only touches one of them, and it looks like we would fail to
>>> trace many packets (e.g., see receive-pack.c:report(), which uses
>>> packet_buf_write() and then write()s out the result).
>> 
>> I see. But isn't it confusing if packet_buf_write() issues a trace call?
>> If I just call this function then nothing happens at all. Shouldn't the
>> trace call be made in receive-pack.c:report() ? Or shouldn't receive-pack
>> let pkt-line.c perform the write calls?
> 
> How would report() do that without re-parsing each of the packets?

We could add a function to pkt-line that takes a list of strings and
generates a list of packets with a terminating flush packet out of it.
Then it sends the packets.

As a quick compromise we could also introduce a function "packet_buf_write_with_trace()"
that wraps the "packet_buf_write()" and calls trace. However, I can imagine that
would be perceived as ugly.

I guess my point is that I stumbled over the un-intutiive format_packet() behavior
and I wanted to improve the situation in a way that others don't run into this
trap. If you think that is no issue then it would be OK for me if we leave the
current behavior as is.

Thanks,
Lars




