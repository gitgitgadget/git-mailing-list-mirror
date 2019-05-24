Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E602B1F609
	for <e@80x24.org>; Fri, 24 May 2019 08:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389237AbfEXISa (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 04:18:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38782 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389046AbfEXISa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 04:18:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id t5so8247440wmh.3
        for <git@vger.kernel.org>; Fri, 24 May 2019 01:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=6gJ5xWYwlsc/aYxlZMrVcSC45jiFJMmAoQURBi3rG7c=;
        b=UiCZ0eaUdiw86Y+h/PdkJD1GWtTejNiFxA10WuGKCJrAIQS7M2vxsvDBZmY1bdIrJC
         wqe33FhZdAey3tSyo/9GJfyHyx6NhfT2hpT0lt7vyo9u9FE9Id93aQQeGVYcrPAtoVu9
         UOPa4jTOX2on3hyrDSeetbJxnIHJgHkiivmzZ020qDQHlwkkTas+pIRvnW2Fi05Ew91S
         rd1WwTMB35iy5vdWJXJVl/jvQsDSyMtML64mjOInrQl18hBglnMMaAzp9fsn1awyy7+4
         ICzfX//QM1bnfzZgkvGJ8qiV62mwOb5MIHPoChJnPBbCTbWehrT8+XJrdAwasjpDo+Ac
         y8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=6gJ5xWYwlsc/aYxlZMrVcSC45jiFJMmAoQURBi3rG7c=;
        b=te6obpGB+25/JMeu2Wb33AFsPK6FQmjfWdjQOUhR4p7cMHPuaM9co9se3zGwjFAspY
         RqN1Xbf22YVP09zFSr8JDzp53xy2eZtpdNg3+YHen2GZqFwFbHA7899sFZ2dIb9xJj4F
         R9GXWbNm9mREWHHPJMp+MzzJz5ou1yxzjhbqq2edk5Rc5iKiUu2q/1qiLBUCaTvUIGGm
         qpwgZOw8+VKMeT7pPRykrg8BHDAWVFheydD2blShUU7Uzizgu05oAlh4gw+FuI1D/mOV
         PFcwD2vbaNKglWN11SxRd8+42K0zC0jD90OKxLOVaXN6WQuSkBDpwrB2X5Ix+Pj2Nlu8
         i3rQ==
X-Gm-Message-State: APjAAAVeqxvOd4oiT1EmCJLLRXT2WvDaUlwZm7kMrXfXay0+Rt5bitgC
        AYPVyt9PiXO3DutCcxZFOIw=
X-Google-Smtp-Source: APXvYqy0Cu5jZHIz4U30IelmgVofz9Uw8hqO8I0zOKz/RETLIFi69YCdSOXZQRvL22Tof6H07dL7Ug==
X-Received: by 2002:a1c:9d56:: with SMTP id g83mr15640730wme.8.1558685907874;
        Fri, 24 May 2019 01:18:27 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id h15sm1379045wru.52.2019.05.24.01.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 01:18:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] server-info: do not list unlinked packs
References: <20190512040825.GA25370@sigill.intra.peff.net> <87tve0w3ao.fsf@evledraar.gmail.com> <20190514094729.GA12256@sigill.intra.peff.net> <20190514115047.oncvfq24fhnp64re@dcvr> <87ftphw7mv.fsf@evledraar.gmail.com> <20190515004551.emrxvboqemwnqh4g@dcvr> <20190515203839.zixx23bwzeyto6a3@dcvr> <20190515214806.GA31693@sigill.intra.peff.net> <20190523085959.4q76pokx2gy6wqq7@dcvr> <20190523102456.GA6583@sigill.intra.peff.net> <20190523172723.eny6smdt57zxau6z@dcvr>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190523172723.eny6smdt57zxau6z@dcvr>
Date:   Fri, 24 May 2019 09:34:21 +0200
Message-ID: <87sgt4fgqq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 23 2019, Eric Wong wrote:

> Jeff King <peff@peff.net> wrote:
>> On Thu, May 23, 2019 at 08:59:59AM +0000, Eric Wong wrote:
>>
>> > > We never delete entries from the in-memory packed_git list; a reprepare
>> > > only adds to the list. You'd need to teach update_server_info() to
>> > > ignore packs which are no longer present (or switch to exec-ing a
>> > > separate update-server-info binary).
>> >
>> > Ah, checking files_exists() and setting a bit seems sufficient.
>>
>> Yes, though we do we even need to store the bit?
>
> I wanted to avoid the over-allocation, and I hit a bounds error
> because I forgot to adjust num_pack as you mentioned
> below. [...]ALLOC_GROW makes the whole thing much nicer.

If you want to avoid over-allocation the last thing you want is
ALLOC_GROW() :)

I.e. see alloc_nr() in cache.h, we explicitly over-allocate with it.

But as our extensive use of it shows this sort of pattern is the right
trade-off, both in terms of performance on modern hardware, and code
readability in cases like this where we're never going to realistically
have to worry about memory pressure.
