Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F680C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 10:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 065C061028
	for <git@archiver.kernel.org>; Mon, 17 May 2021 10:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbhEQKnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 06:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbhEQKnv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 06:43:51 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015DEC061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 03:42:34 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id f184so6068555oig.3
        for <git@vger.kernel.org>; Mon, 17 May 2021 03:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=6+Eo2nPmyCg+TB1ktCDByuLEfBkcfo7xkP49o88re9I=;
        b=T5u9Nf37TP01HyfbJQrfgXx0w8HuBZwKl8IGxQcgE7pwGhxNnB1yhThiTyEVE59dX7
         j5Gq3FzTXH7re3S+BvrZZSeNbCMd768zj2yFpjo6EniQcTpI3DzR/OSGlZSXUTFdWzmb
         OB24IPHEdwWh9bGRXCw7qvydINNBDhHzRRqOxWZ5BgxWWVgRJmbYdlj74S06HOweK1fp
         5c+Iubjqwe17DPAY6k9UsMv/8fQ8cufod8A5R26vkRM2pqivJGYWso8HJdUNTr1baK+8
         ojAeeFPzDC6r38wNxpTvs2fG+3zK/5Z7pNVzDXMJfI7/D7i39aV79yJcmZl99KkldbZY
         im7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=6+Eo2nPmyCg+TB1ktCDByuLEfBkcfo7xkP49o88re9I=;
        b=ilegBGghrLOTqmTQ4XvT6u9riRJyAVKy3HQSZBA421KmHzCIZTfgc1fN213yngi+Q7
         PXjdn3AqaURYgd5ojrKbVnwml88xJCyMrAR0khcgQHbEE3UcJICEW7Ixx3wMZTdDvCH7
         JMe1rS0gwFwm0hh2kyKwDD+X+Q60WBL2WJgxTJcPeIgclCokLXHzME3OrP34VKW2GAiT
         +Pea40RqM2MMSGuvxGOj4Cw4E2TFQvXvZS4JyEokl9/bfhL26JmUn4eod8XzZylwoGUP
         t+2RcrG4okiEHDiAmzP47PX7y6NcMb4yIqE3UFntt+YKWNIwEQ0psWATQwu+//+/Zo7E
         BVEA==
X-Gm-Message-State: AOAM5311t8jgypOm9bP4RPyH2QId5Zcidt20LwEM5Uo1g74CzdsK5U0C
        Bt9MQzRa6ic3sm5PDpfKKsc=
X-Google-Smtp-Source: ABdhPJyKcDj3bw0CuGsHLLh9MBN8nBO1+z0V0nLbz5N+9fXGR0B2ujORVpbN6/VCaHyicfKPobUYmA==
X-Received: by 2002:a05:6808:117:: with SMTP id b23mr42233921oie.7.1621248153436;
        Mon, 17 May 2021 03:42:33 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 186sm2927540oof.14.2021.05.17.03.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 03:42:32 -0700 (PDT)
Date:   Mon, 17 May 2021 05:42:31 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60a24897afda0_126a0520834@natae.notmuch>
In-Reply-To: <YKIu/DUfmU8JbDY2@coredump.intra.peff.net>
References: <20210514115631.503276-1-felipe.contreras@gmail.com>
 <20210514115631.503276-4-felipe.contreras@gmail.com>
 <YJ+TQiYVgocUBQRV@coredump.intra.peff.net>
 <609fb8b5bf799_e173a20897@natae.notmuch>
 <YKIu/DUfmU8JbDY2@coredump.intra.peff.net>
Subject: Re: [PATCH v2 3/5] doc: remove unnecessary rm instances
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Sat, May 15, 2021 at 07:04:05AM -0500, Felipe Contreras wrote:
> > Jeff King wrote:

> > > That does differ in that it removes $@+, too, but the premise is the
> > > same (we know that $@+ could not be a problem, as we're about to
> > > clobber it anyway).
> > > 
> > > I'm OK with getting rid of all of them, but it seems like it ought to be
> > > happening all in this patch.
> > 
> > Yeah, but the rationale is different.
> > 
> >   1. $(RM) $@: these remove the target file because of permissions
> >      (i.e. root owned)
> >   2. $(RM) $@+ $@ && $(CODE) && mv $@+ $@: these are for interrupted builds
> > 
> > To get rid of #2 we need an alternative solution, like .DELETE_ON_ERROR,
> > to get rid of #1 we don't, we can just do it.
> 
> To get rid of the "mv", you need something like .DELETE_ON_ERROR. But
> the "rm" in the second case has nothing to do with interrupted builds.
> It is is doing the same nothing that the ones you are getting rid of
> here are.
> 
> I.e., I was suggesting to get rid of the "rm" call in the hunk I showed
> above, but leave the "mv" for the follow-on patch.

Ahh, I see. It's quite a bit more work, but sure, I can do that.

-- 
Felipe Contreras
