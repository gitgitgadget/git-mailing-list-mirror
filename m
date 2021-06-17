Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72483C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 20:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59295613AA
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 20:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhFQVAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 17:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhFQU77 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 16:59:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1011EC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 13:57:51 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b11so5625740edy.4
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 13:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=myVVqudMeC3fi06gInvxqYbBGGOQx1dTWgMxf+c9z/8=;
        b=lQL65251T/+w8/fEAFteAy3cw+YTeXBg3ueXvYheZZQ7sBKK32BTmdcB+gOehaL3D2
         yEx15KMMAH+BZ31OIlLF+1pLnzwpe43hfqdCaluoHxrB2zy6uGsERToP5E2omSnxjHML
         asP/lZ1T8A5Lf8/O8RJCz8UE2DDdPQ+aCEiAiTFaYJ5b35Qpj3H6wvX3vkM51QR1mQh5
         7P8HzWfsF2hF2CcRZf3GK08boTwlFIM5yTPFR4Zj2bOq280e+/OgKyyAG8XhutEGkIP5
         35ovvvJc3SXn+Oh7NMqkat3oYnUdQnt/EYwLqVHUJa4qdwt0ifQELzZOoe0SsqOGdOS4
         r/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=myVVqudMeC3fi06gInvxqYbBGGOQx1dTWgMxf+c9z/8=;
        b=blHFYz7LGLD9+9W6U5k6ogDWhcozE8M9IZUNt23lQcrUUyqZhYSMhtu1puirmvIMee
         NnloevbyV+NfdxsOgCJxLEqbLEckMGMkhdkRJyl9iAXaPbjuCaD+qBqoCd7i+Et/6gQf
         nlii0N18EIcLGwA8cqjPzhVdXTuxcRuWS6tSK49ui6xT4X5eC7EoUGAffpureQ1Z7ghJ
         nS2ztVVHMCIFRiEOvWU6n/xA1T+2azeWmlY3oJ7vNgs6PBaw8/G7MfGPpxMxystu7FyV
         WxqZPzkIpPLfSI5UnBVDAe5IGenMU3bCcYTXdsfdcJLi1tdbmV6phs32eGfQMkzizBof
         VXVw==
X-Gm-Message-State: AOAM532ok0Zar7ND+3SiO0q1egj2aY+Qs/goFH93WPxgP4XaFeRBI2Th
        97bmBvNuL1RX3e8bhdE4WtA=
X-Google-Smtp-Source: ABdhPJx2hOr6OqdzFbvbKZ7b0hOfGsLPYDOxnoPITdrNLH7H3PDffW+2xv0ry9ySD/by1ggrOR0JSg==
X-Received: by 2002:a05:6402:3513:: with SMTP id b19mr310609edd.148.1623963469648;
        Thu, 17 Jun 2021 13:57:49 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w8sm4998141edc.39.2021.06.17.13.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 13:57:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Susi <phill@thesusis.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 0/6] doc: replace "alice" and "bob" examples
Date:   Thu, 17 Jun 2021 22:51:19 +0200
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
 <60c8db3558fb8_1296f208ac@natae.notmuch>
 <871r93ym8q.fsf@evledraar.gmail.com>
 <60ca6586607f5_602720852@natae.notmuch> <87pmwkh4he.fsf@vps.thesusis.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <87pmwkh4he.fsf@vps.thesusis.net>
Message-ID: <8735tg5hv7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 17 2021, Phillip Susi wrote:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> I have not read cryptography documentation, so for me Alice and Bob are
>> simply two illustrative colleagues.
>
> I have read cryptography documentation and seen Alice and Bob used
> commonly.  Am I supposed to be confused if I see those names used in
> documentation for non cryptographic software?  If Alice and Bob work
> there, why should they not be used here?  Am I missing something?
>
>>> And as argued in 1/6 for those users who /are/ aware of "Alice and Bob"
>>> it's needless distraction. Maybe it's just me, but whenever I read
>>> references to them I keep waiting for the cryptography angle to be
>>> introduced. None of the uses in our documentation reflect that canonical
>>> usage.
>>
>> It's probably not just you, but the vast majority of readers are
>> likely not aware of any cryptographic reference.
>
> I find it surprising that anyone would be upset that the names Alice and
> Bob were being used in a non cryptographic context.

Who's upset? Not the author of this patch series, as noted in 1/6 I just
think it makes for less confusing reading, since Alice & Bob in
particular have implicit meanings you might guess at[1], and aside from
that I think it simplifies the example the guide is getting at [2].

>>> There's also just weird things in our documentation fixed by this
>>> series, such as referring to a random file tracked by git as "bob"
>>> instead of the more obvious "file.txt".
>>
>> OK, _that_ I agree it's unequivocally an improvement.
>
> Yea, a file probably shouldn't be called bob... I would probably have
> gone with "foo.txt" ( but file.txt is just fine too ).

Git's documentation is read by all sorts of audiences, "foo" and "bar"
are programmer jargon not obvious to everyone. I wouldn't say don't use
it at all, but when a self-descriptive alternative such as file.txt or
whatever works perfectly fine as in the case changed in this series,
it's better to go with that.

1. http://lore.kernel.org/git/patch-1.6-abbb5b9ba13-20210615T161330Z-avarab@gmail.com
2. https://lore.kernel.org/git/875yyc5i6x.fsf@evledraar.gmail.com/
