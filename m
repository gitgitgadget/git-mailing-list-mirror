Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF9621F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932808AbcHCUWf (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:22:35 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38122 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394AbcHCUWd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:22:33 -0400
Received: by mail-wm0-f54.google.com with SMTP id o80so352520690wme.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 13:22:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=vYeaW0fINN7/uXYquLTynAK22p2p5qTE3GGEnnu1e1U=;
        b=h/Zj0VNcarrvqRKjMpQ0Yjgqi2IFmrwOCV2FX+dmIh/DcV8OJkql2ge+yFOIfKI1m9
         e3+2e6pZ/fcsNQPieSghALxtrQE2S1oSCWUjyclVxaxX8YVfSHID34oyKn3T9QZTYuan
         NZb0WOhG4e9ISCvoKi6zwZXuQ4Ja+YmHvjt0sWTohbjnvCTqhSYGGDvgpJ7OD6WoaWtQ
         1iyzAdGO+QOI4JrYxJCW0zETXfxcqbtiVsrEZY9fpZmC0HzgHug6EiK7xERM47pBsUsW
         Y6lClBvPiinn6puIunoiOLSWZ4MsJ4zLG2l4I7pflO+qZ8vYCMtz1FPDCjCJlsd8HGuZ
         gTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=vYeaW0fINN7/uXYquLTynAK22p2p5qTE3GGEnnu1e1U=;
        b=KicYzppVNz0P0CrnjpsQAqO1Xc7rUHqujvYoTNcvnH1Y0irs+Yk+0X/xj82iH0njvd
         TH34LgtE9h3upkuFxtflfI0VVqGFFRVTRr5U0rx2LXfMy0F7wd6vvyjY7q13OtF7RzIZ
         qd/t5EaaYWUBksWuHowFOZsCgVZcHYz60HuBGi+Ec+IP1Zyx3fBkrWMiPG+SL0/rwqzj
         9P8NSV3VO+ee2k4eFXPtK5MsIAc8Mrzh+GpIVmzC0Hx8wiwlTbCPQUKVyi/fccFAYcfI
         U5iV8saI8qFVbzvo3HmKO7IqE0eW8dDjmYoQidlALl+55ujFRXvxzxb/crJj5EFTFyKq
         Fh6w==
X-Gm-Message-State: AEkoousWK7mZ8nvOwzbg3dQAFfaYIQkCYrhoQk6wz3R6xvqDjehWh0z+afg1YCWyyBthHA==
X-Received: by 10.194.63.39 with SMTP id d7mr62358121wjs.13.1470255336036;
        Wed, 03 Aug 2016 13:15:36 -0700 (PDT)
Received: from [192.168.1.26] (adbx179.neoplus.adsl.tpnet.pl. [79.184.23.179])
        by smtp.googlemail.com with ESMTPSA id n6sm9331644wjj.5.2016.08.03.13.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2016 13:15:35 -0700 (PDT)
Subject: Re: [PATCH v3 04/10] pkt-line: call packet_trace() only if a packet
 is actually send
To:	Lars Schneider <larsxschneider@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160729233801.82844-5-larsxschneider@gmail.com>
 <786f0b8e-29f0-3dd3-7bb4-5f6558f8ec84@gmail.com>
 <52A5703D-AF9E-405D-A4F8-E30A7B923400@gmail.com>
Cc:	git@vger.kernel.org, gitster@pobox.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <fb5f8496-fb85-93b7-d83d-f5d24f0bc5c2@gmail.com>
Date:	Wed, 3 Aug 2016 22:15:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <52A5703D-AF9E-405D-A4F8-E30A7B923400@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

[This response might have been invalidated by v4]

W dniu 01.08.2016 o 14:18, Lars Schneider pisze:
>> On 30 Jul 2016, at 14:29, Jakub Narębski <jnareb@gmail.com> wrote:
>> W dniu 30.07.2016 o 01:37, larsxschneider@gmail.com pisze:

>> I don't buy this explanation.  If you want to trace packets, you might
>> do it on input (when formatting packet), or on output (when writing
>> packet).  It's when there are more than one formatting function, but
>> one writing function, then placing trace call in write function means
>> less code duplication; and of course the reverse.
>>
>> Another issue is that something may happen between formatting packet
>> and sending it, and we probably want to packet_trace() when packet
>> is actually send.
>>
>> Neither of those is visible in commit message.
> 
> The packet_trace() call in format_packet() is not ideal, as we would print
> a trace when a packet is formatted and (potentially) when the same packet is
> actually written. This was no problem up until now because packet_write(),
> the function that uses format_packet() and writes the formatted packet,
> did not trace the packet.
> 
> This developer believes that trace calls should only happen when a packet
> is actually written as the packet could be modified between formatting
> and writing. Therefore the trace call was moved from format_packet() to 
> packet_write().
> 
> --
> 
> Better?

Yes, that's much better.

P.S. Yes, this is one of those changes where commit message is much longer
     than the change itself...

-- 
Jakub Narębski

