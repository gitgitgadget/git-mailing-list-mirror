Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB8BC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 13:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334546141A
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 13:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhGANlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 09:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhGANlR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 09:41:17 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52248C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 06:38:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id o5so10454287ejy.7
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 06:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dfmNPYhkWoI6cffg9f4c9WsPLQgupE629TTWYnKecVg=;
        b=dg591mWXxnyAlbnMR4cvQFeDchCoO3fCi2vroaqCdZPqSATGpCVxX6HiYW5jL7AuWO
         uS2mPXl97DGb63YXRG8bK27OOXf+5c1CDM7euky/uiUEYscJmDcGFIuIXHXVLI3PnYu0
         ubkjVrNx7BmuaO+Z0lPXt+oQWpZrr5Ifj2lWOd8Pm7MXzVvAa981Ilt+3ae83SNhsoVv
         P/NCC8QUN+CADOX3ji8D+d4InR6XxmHwSFlsmY5mWaWKdENJY2XTz2czW72fUdPh1lve
         maP1KJmSaugsYrhlBNT7SOmW3HTIuwZgskVReORvv5pdCC9P7JXbWIoHtkSraXRlqLAe
         QZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dfmNPYhkWoI6cffg9f4c9WsPLQgupE629TTWYnKecVg=;
        b=uizbhIvja/VvYWtl5huM9cZ7sLS6ImqU6jMSLRcgwUJF2n1vFF7BmEVlJejpc69JLM
         esfws++t8W8iUmafEQPys+bLTw2E7JUUJLduh+pl1PXejWdaUNTAKjU+84e0Mj7qjJKq
         1lfqPBaVN70dMEL+0Nv8RHp3Zlk/nV91QRgribkFX14KtVxR7wLe92rLgyyb+D7yrKqd
         0n+moBf5PIFa3drMfJuXpXX41KiW+CWH4UapJs15GrXVbvYhQnnGGnzR2e4TFUZk3kw4
         oreaWJ9wwp8s1MmF2FPjbvInvFTcnPQmUI8qc2pCxAWyN6vaLu5AVigjfewjTY9MJtwS
         B70g==
X-Gm-Message-State: AOAM531tpz2ShY9rKFCU9Z+lW2AmP9HUJkCkr6sJIRMzRBwKDrquk3z5
        wxUEMFo8wAWNdhKxQkyvSjw=
X-Google-Smtp-Source: ABdhPJwuGhMzwsqI7wnMVe3DMMcBqin8prusQu8niGNS6B2RwQvj9fQkMYxl11ebhHgjWgk5wyIV7Q==
X-Received: by 2002:a17:907:7d91:: with SMTP id oz17mr4706007ejc.250.1625146725856;
        Thu, 01 Jul 2021 06:38:45 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id f14sm13925373edd.69.2021.07.01.06.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 06:38:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Date:   Thu, 01 Jul 2021 15:34:00 +0200
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
 <YNIBRboFiCRAq3aA@nand.local> <8735t93h0u.fsf@evledraar.gmail.com>
 <YNI3WVu5SK7pHI7T@coredump.intra.peff.net>
 <87r1gs1hfx.fsf@evledraar.gmail.com>
 <YNOz1GD/8+CaUvRz@coredump.intra.peff.net>
 <871r8r1hwe.fsf@evledraar.gmail.com>
 <YNSbe0At6SaQu1Z4@coredump.intra.peff.net>
 <87fsx6xn0b.fsf@evledraar.gmail.com>
 <YNqE8BIRF6NeYQcd@coredump.intra.peff.net> <xmqqfsx1yyza.fsf@gitster.g>
 <875yxxgkav.fsf@evledraar.gmail.com>
 <60dd3c92ef44b_174a220836@natae.notmuch>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <60dd3c92ef44b_174a220836@natae.notmuch>
Message-ID: <87tulecfx7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 30 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, Jun 28 2021, Junio C Hamano wrote:
>
>> > I do not see a point in complicating the build procedure to avoid
>> > using it.
>>=20
>> I'd really understand your and Jeff's concerns if I was proposing some
>> really complex workaround, but it's just extending & making consistent
>> the "mv" dance we already use for 1/2 our rules already.
>
> I'm not entirely sure what's going on here. We have agreed that
> .DELETE_ON_ERROR and the "mv" dance are orthogonal. So the patch to use
> .DELETE_ON_ERROR can move forward, while the "mv" dance can be discussed
> later.
>
> Like Junio and Jeff, I don't see much value in the "mv" dance, but that
> doesn't mean I want it gone. On the contrary, I would to try a scenario
> in which it's usefull.
>
> But that is *orthogonal*. Leave that for another discussion.

Yes, this whole sub-thread is just a side-discussion about a
change-not-in-this-series, which started out as a reference to a larger
series I carved this more narrow change from.

>> Even if you don't care about the end result or making git easier to hack
>> on for people who don't share your setup,
>
> I don't know about Junio, I do want to make git easier to hack for
> people that don't share my setup, but I would like to know what that
> setup is.

I think all of this is covered in detail upthread.

>> I'd think that making those rules consistent across the board makes
>> things less complex, not more.
>
> I don't agree with that. Consistency is just one of the many factors we
> have to consider. Even if 90% of instances in the documentation said
> "fast forward", that doesn't necessarily mean we should convert the
> remaining 10% away from "fast-foward".
>
> First we need to decide what is the end-goal we want to reach, and then
> we can go for consistency.
>
> But again, this is orthogonal to this patch, isn't it?

*nod*. I think for build rules it's easier to reason about them if all
of them e.g. do "$(RM) $@" at the start followed by "mv $@ $@+" at the
end, than wondering if the differences are accidental or intentional (in
most cases they're just a historical accident).q

>> Anyway, let's not discussed this forever. We're clearly getting
>> nowhere. Just for the record I'm quite miffed about the bar for "I don't
>> care about this area/platform/use-case, but this person actively sending
>> me patches in the area says it's helpful to send more patches" is so
>> low.
>
> I don't think it's quite like that. Skepticism doesn't mean disapproval.
>
> I for one are skeptic of the possitive value of the "mv" dance, but I
> wouldn't be surprised in the least if you showed the value in 4 lines of
> code. I just haven't seen them yet.
>
> Once again... That's orthogonal to this patch.

*Nod*, as noted covered upthread.

>> Maybe that's all worth it, and I'd be willing to take the Windows devs
>> at their word that dealing with the make dependency was really *that*
>> painful. But compare that to carrying a few lines of "mv $@+ $@" to, I
>> daresay, make the same or larger relative improvement on AIX.
>
> Oh I don't trust them at all. I did maintain some Windows installers for
> years, and with a couple of tricks I had no problem building them with
> plain Makefiles, with much more complex dependencies.
>
> I'm fairly certain I could make git build for Windows with plain
> Makefiles... But one controversy at a time.

Yeah, I think (from memory of reading the relevant threads) it's some
combinatin of "the dependency is large & painful" and "it's a bit
slower". I've found it hard in the past to get accurate estimates of
what's "slow" from our resident Windows maintainer:) Per:
https://lore.kernel.org/git/875z1lz6wl.fsf@evledraar.gmail.com/
