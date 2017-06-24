Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8EFE2082E
	for <e@80x24.org>; Sat, 24 Jun 2017 11:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751305AbdFXLLi (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 07:11:38 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:32850 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbdFXLLh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 07:11:37 -0400
Received: by mail-wr0-f181.google.com with SMTP id r103so95621593wrb.0
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 04:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=TC7YmWFWTBS/5CnmVaond7B87GfD9AFB7FoyQeHoyfE=;
        b=G1JJFyLBywaWcPkOlEQCIOTOponJKxPMnrl2iQOV9txeL2VZra39g8GeXeg/JwkGqp
         pdPyHzzZcxDWyrFHc8ebMURz3H0hpWorLLvMwGHgmG8W52tlkdal+3yGaTxCPVhtEi09
         WJ87zCxA/3rl9S1j9tkZApwxPq86Jbyrp36EbFDK+UDddMDPTccVtVlPnS8z+mVpHYE6
         VNKQt0WTxjjbywtTh5TioM0xkifMZ5cP5j1K/hjVegok0eXZNCTLFpw+oNHo7bfboIuy
         GefW10jVJd2ZUru6nDI9M1DgDC4Hgs1CUN81CX10Mneyf1WgonePX80aDOCBGHD4w5s7
         M2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=TC7YmWFWTBS/5CnmVaond7B87GfD9AFB7FoyQeHoyfE=;
        b=Ux50fvZMvSae3QfyjjiAbQEQJEm4vuzV9sEws9aq6StmImKorod/IXf6PIesAWrM62
         xcjgFqpPl6s9G0CcP18eF9uxNofXN47KvFTBbLV6mmrEG0ioALMItBTVkFhpP8QYlqdd
         fNp4oCe6LNQ1sdu1izstrRSSLIC290/fY8IVN+Lt67qkc/8geTqZH0RsHLeklPEdRCXo
         c3OcopBDKdEUbqdQN+pn418pSxoE7bjLuJzsi+4Spf/JWaw3/M1O/3UjSbfs06+DMqeE
         2Wljls4vRF2PJGhSKkyEg8biWmm2Z/LY/d6RxkILY4o/A5weAcBNiHXcEacBbvdmX6uQ
         qy9w==
X-Gm-Message-State: AKS2vOwkBBrVRYPgICeunYAam2jHevFnm6Jg9KeFvZuPyeggxeyEaXlx
        tETvkGlZorweuw==
X-Received: by 10.80.145.118 with SMTP id f51mr9493491eda.170.1498302695986;
        Sat, 24 Jun 2017 04:11:35 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id w26sm2193452edw.24.2017.06.24.04.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Jun 2017 04:11:34 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dOiyT-0002Gn-T4; Sat, 24 Jun 2017 13:11:33 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf: change an always NULL/"" strbuf_addftime() param to bool
References: <20170623144603.11774-1-avarab@gmail.com> <20170623145102.h7rt6zaqajfzuhsk@sigill.intra.peff.net> <8760fmka8t.fsf@gmail.com> <20170623152344.gdk4haizpziwryrd@sigill.intra.peff.net> <2e0773c3-b742-a211-d9cb-64da58cf9e0d@web.de>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <2e0773c3-b742-a211-d9cb-64da58cf9e0d@web.de>
Date:   Sat, 24 Jun 2017 13:11:33 +0200
Message-ID: <87y3sh1vyy.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 23 2017, René Scharfe jotted:

> Am 23.06.2017 um 17:23 schrieb Jeff King:
>> On Fri, Jun 23, 2017 at 05:13:38PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>
>>>> The idea was that eventually the caller might be able to come up with a
>>>> TZ that is not blank, but is also not what strftime("%Z") would produce.
>>>> Conceivably that could be done if Git commits carried the "%Z"
>>>> information (not likely), or if we used a reverse-lookup table (also not
>>>> likely).
>>>>
>>>> This closes the door on that.  Since we don't have immediate plans to go
>>>> that route, I'm OK with this patch. It would be easy enough to re-open
>>>> the door if we change our minds later.
>>>
>>> Closes the door on doing that via passing the char * of the prepared
>>> custom tz_name to strbuf_addftime().
>>>
>>> I have a WIP patch (which may not make it on-list, depending) playing
>>> with the idea I proposed in
>>> CACBZZX5OQc45fUyDVayE89rkT=+8m5S4efSXCAbCy7Upme5zLA@mail.gmail.com which
>>> just inserts the custom TZ name based on the offset inside that `if
>>> (omit_strftime_tz_name)` branch.
>>
>> OK. I'd assumed that would all happen outside of strbuf_addftime(). But
>> if it happens inside, then I agree a flag is better.
>
> Oh, so the interface that was meant to allow better time zone names
> without having to make strbuf_addftime() even bigger than it already is
> turns out to be too ugly for its purpose?  I'm sorry. :(

I don't think it's ugly. My motivation for sending this patch is that I
started playing with this code and was confused because I thought that
strbuf_addstr(...) actually did something to the string, but it never
did.

Since it's a purely internal API used in just one place I thought it
made sense to adjust the prototype / code to its current usage for ease
of readability, if we want to do something else with it in the future
it'll be trivial to adjust it then.

But I don't feel strongly about this patch at all, it's just a minor
fixup I submitted while reading / playing with the code.
