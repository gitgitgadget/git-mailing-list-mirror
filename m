Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A17C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 10:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B0961184
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 10:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbhFIKLP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 06:11:15 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:46769 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbhFIKLO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 06:11:14 -0400
Received: by mail-ej1-f42.google.com with SMTP id he7so18136341ejc.13
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 03:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RBHB6EvpKz3bdKin2c9Q387jPX/4H2Y41QxpvxaWmOE=;
        b=V8CoMrCpHVXKn21BjacXOHbDqpRLlKZvKSgyaN6Bd12NvoP8u0p8DKMyuWmjrbTGpR
         GeMN9AABHA4/OdgRg73gz5b118DI7m/DnLvms+U+G241apMQs+mctuoaiHz8Op82dkJG
         LMEmoQ8MFR7id+WKKAcCSBccGLczkAvc8gIWCkTpm7Mpx+145US6sC/pSrmKIM4DSpF6
         Dezejsr2WYaoyWiLVVXKYDkVLxRErkn15dZYlu5+ZfcUihNX5lostefpBkKEZ/JBIOke
         pvh743G96RXgrXfUs6xAem73uOoBTjeQrMQoJEMhOkWQzJop1bMaQ9CA6GptL4txlfl5
         vHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RBHB6EvpKz3bdKin2c9Q387jPX/4H2Y41QxpvxaWmOE=;
        b=bocbaN2jEwOeazC1B1UDWS16puRPhDKQp6Q/EvHahNA2S8VYd6ti5EaXh/hGawdCAY
         8cfiAQBJxLKFPPOGd9pjXTnGokoXky0o5EwHiI8pFZ2Fhmr1c1aCaSbeudAnm4nlA0RY
         6LvBAlAJVCvCZynwRJHeNfbe1aZOKzvmXVhbOVCbt/jZuK9kftBfdyOGLDiaAGqYZCBn
         gUPiwqjygQUIRw689greYNa5y9HIaeV9ajOaq4fPFfczO8ZkHCnPng4522LyI8ofQzek
         VLTaxDgZkgUaRUXwKDpqOCkYVen231kdXpepnYc4BuuUKfAYLC5noL4F5VWXuHjl4ntv
         uu0w==
X-Gm-Message-State: AOAM533fmmJQJmPTumF6D6MZFamjYFRHCPBdKXc4XQoveOD7OtUkybA2
        k6Jc27PHgJyKZlJHJRg3qHihtf8ZdQFeYg==
X-Google-Smtp-Source: ABdhPJx1DkFpPhb7u3psKxopLqetjIeJjg0h2SYIskXED6EnYe1m5mo7LK1su4OQ7+RPXVwscW3Xuw==
X-Received: by 2002:a17:906:9512:: with SMTP id u18mr27858998ejx.61.1623233283845;
        Wed, 09 Jun 2021 03:08:03 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id y15sm923069edd.55.2021.06.09.03.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:08:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2021, #02; Sun, 6)
Date:   Wed, 09 Jun 2021 12:06:08 +0200
References: <xmqq4kebxj2d.fsf@gitster.g>
 <87sg1t4usb.fsf@evledraar.gmail.com>
 <YMCMixVw+2G59yQH@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YMCMixVw+2G59yQH@coredump.intra.peff.net>
Message-ID: <87fsxr2vwd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 09 2021, Jeff King wrote:

> On Mon, Jun 07, 2021 at 04:10:17PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > * ab/trace2-squelch-gcc-warning (2021-05-21) 1 commit
>> >   (merged to 'next' on 2021-05-28 at 6c7a015f99)
>> >  + trace2: refactor to avoid gcc warning under -O3
>> >
>> >  Workaround compiler warnings.
>> >
>> >  Will cook in 'next'.
>>=20
>> Thanks.
>
> BTW, =C3=86var, are you planning to fix other -O3 problems? I happened to
> notice some today. One is new in pu (and I sent a message in that
> thread), but two are older. See this message from last year:
>
>   https://lore.kernel.org/git/20200404142131.GA679473@coredump.intra.peff=
.net/
>
> (amusingly, it also mentions your trace2 one!). I'm happy to send
> patches, but I hadn't written them yet, and it occurred to me you might
> already have done so.

There hasn't been much of anything new in pu for a while :)

But no, please beat me to it. That trace2 one was a one-off I was
tackling because I ran into it when compiling revisions under -O3 with
t/perf/.
