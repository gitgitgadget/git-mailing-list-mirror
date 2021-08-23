Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBDCC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 14:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F8761247
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 14:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhHWOuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 10:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhHWOuu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 10:50:50 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC23C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 07:50:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bt14so37621078ejb.3
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 07:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=JagnwFio1IzGes00PjHTAHrYNs7MYlZnhFbmMZHyrEI=;
        b=Gpusx96PqdWwWucldjxUVWEmX+oytvgA77rFVxGnKysOftjxRitO+fRMYL3vffFcfa
         o6IboxiwDiGJjO7FWwDjFTKW1tRTByRkM2YZ1XNWymmU6XKzGNWVXgOpRQvDTn2uNoAD
         wTXIsomRIdt35+N/filDMBbjApYGUzPUfAKcljALrwFaWtSquMIIweCZ4VA/vuLRaXDV
         b4rORCuUJE1MmCwFU3aeT618mbjsryzp+uG13LXAlxnL2wKnw0N/R/cXBO/OUpM7nqSK
         sBOM5aei/k8+nivYamDR7bPgJHHs86Lxow+qFtAyozNOVTlqomGOa4b1Mu+pbsYPaIJQ
         OmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=JagnwFio1IzGes00PjHTAHrYNs7MYlZnhFbmMZHyrEI=;
        b=OJDJI0JhFr4yumhgGMDAYO1p3jmp76sCev2jmMnTz3n4iGabhfPmcvPG3NoaquJDnB
         I8K0FFmh9vfmS5hqMKBL2TPEw+5zT2l6J07iYsu+aK5bLJXrcyCrmD2ENhihyymXkpz+
         zB6RJUJRRS80AzYDxzUjMW0WEE/a12/AiRre+avTYjjkiHLflAMIWowWnwtBAHbxT+k/
         S3/Olta1Q1CfqSdD2zX+fsoLpbDgt9aB//ARsgqGGXxscgJk/MDYEz4MCqQMibBhOAR+
         xbDXewpFFQgBV1kuB468eoovLS9XDQCsqzaetV9xk+iD+SzpSCEKB3ich/B3m4HexzAt
         RV6w==
X-Gm-Message-State: AOAM532LG563v6YVJDJBkC2u8B+/0Ubqn3i2pSfQRl7SGLPDursovTjS
        9wRmfGkEB7AOHXB7DV2ONpE=
X-Google-Smtp-Source: ABdhPJxtZyUKaLStTpzgvJd+JEHqQQAlLeAMubDPcc9MHAb8xQVm/SQzQpPrpO+dh/z7cqEzsSDKVQ==
X-Received: by 2002:a17:906:3a98:: with SMTP id y24mr35553593ejd.198.1629730205983;
        Mon, 23 Aug 2021 07:50:05 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u9sm9577500edt.60.2021.08.23.07.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 07:50:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Ben Goldberg <ben@benaaron.dev>, git@vger.kernel.org
Subject: Re: send-email issue
Date:   Mon, 23 Aug 2021 16:49:08 +0200
References: <24a88faf-5339-8449-80c4-f6085bd1e098@benaaron.dev>
 <b4b1dda4-6bf7-f4b1-88c5-9d579a7c56d3@benaaron.dev>
 <20210813180056.ctzivmakj4bj5apa@nitro.local> <xmqq35rbtx84.fsf@gitster.g>
 <20210816131143.6ifcbpxp6ilo2nv5@nitro.local>
 <YRqQJTyBW6j6b2pW@coredump.intra.peff.net> <xmqq4kbps58l.fsf@gitster.g>
 <YRqY4Tw4YxbepuFg@coredump.intra.peff.net> <xmqqzgthql1h.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqzgthql1h.fsf@gitster.g>
Message-ID: <87eeakfc6b.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 16 2021, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> This is certainly unfortunate, but IMHO is not a hard requirement for
>> adding new values. This is no different than a case where we add a new
>> config option, but old versions of Git quietly ignore it.
>>
>> In other words, I would suggest to tighten this as the values are added,
>> but not worry about having a "spreading" period.
>
> I would have agreed with you even in April if this knob were not
> about security.  Thinking that the user is asking for an encrypted
> connection and silently getting an unencrypted connection is not
> such a good thing, and advertising "we now improved the distinction
> between smtps and starttls easier to express" to users would not
> work well in that context.

I think per
https://lore.kernel.org/git/87o8ejej8m.fsf@evledraar.gmail.com/ that
this may not be much of an issue in practice, i.e. assuming that most
modern servers only accept auth over the encrypted channel the user will
get an error anyway.

But how true that is in the wild beyond just the GMail example, I don't
know...
