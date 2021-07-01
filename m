Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF02EC11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 03:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A52E861425
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 03:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbhGAD5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 23:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhGAD5c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 23:57:32 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41C1C061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 20:55:01 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t80so5765893oie.8
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 20:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=+K0tuJAbL9kU3ysCBsIaUotqf9IVs9urJ2hlMmGccYI=;
        b=H30S92206QuPas1d5x3G5tJ6JvSa47DHM8AhnYGWwb10xONvrmc0Zm/vtprKurLH7m
         dDmjLdWcyO+ktV7/X4F4AjOq5+3O8tEVqBjHkCYhfUSdsFF8bPTNLWmR7G+bwDkwSSLi
         QFGx4eY41hmaogYy+tFLJRfwF676HQUXgSo7VwLjprSfV7AdhhJYvBkqX0tnV5BWa9Il
         KvIKuratKDG/6C2eJdNMWRFfo3GlUrCBsO9R9samoLHKQP1Nf1qDBEG9QFYHkeVqTxNW
         lh4HAT59hA/UfPqZrRMvd+Z++IQdTKqY9fjzEYBizpQqdvunnEXRh42gCQnBSfGbjhJo
         YKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=+K0tuJAbL9kU3ysCBsIaUotqf9IVs9urJ2hlMmGccYI=;
        b=NHK1XuFqvAGI/3AuQiOtlnlhasB5Q81s9zcVeI5QimCkwk6YyN9w6thHNzdKnCJbPZ
         iSWoSUSW3iS5Oxq8GtiNTytA3tRHBFEqdOABY7sLKj8crSP0eLOKOY1DlTNgOAUWzTyi
         8UYxsW2a+I7u0KQUuZUDGFcfFC77Jx7a7q8fwJX/6vdzfRx4C5xF3m+VCCT25nheP0lW
         Q+p0sUxrRCXd0WZh+xLUxi/ta3RYJ6d3VvR7VOM78DK7jSp60AN8aSROsIkhxuDoH6h5
         0RkQpEShlQn0qdRndBnhchaZlbiURxf3DjW359eQODuoo1fJVhWP5t1lNaNVnL6XE3R2
         xP8A==
X-Gm-Message-State: AOAM530Ut/6+PbdUxq2p1XobJmtEMoCCUn3iXwlTRWgmgPCA8/HNzSpi
        V5tPqXYlD/soldq15N+o7M4=
X-Google-Smtp-Source: ABdhPJyTBRzvI3bSw3bQKEl617LAp1r7yKIGqxkfN2SjMfqLM0QGMVERC4ZahNYCQgnPADHGbdawmA==
X-Received: by 2002:aca:a9d3:: with SMTP id s202mr5854316oie.128.1625111701025;
        Wed, 30 Jun 2021 20:55:01 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id o24sm5307166otp.13.2021.06.30.20.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 20:55:00 -0700 (PDT)
Date:   Wed, 30 Jun 2021 22:54:58 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <60dd3c92ef44b_174a220836@natae.notmuch>
In-Reply-To: <875yxxgkav.fsf@evledraar.gmail.com>
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
 <YNIBRboFiCRAq3aA@nand.local>
 <8735t93h0u.fsf@evledraar.gmail.com>
 <YNI3WVu5SK7pHI7T@coredump.intra.peff.net>
 <87r1gs1hfx.fsf@evledraar.gmail.com>
 <YNOz1GD/8+CaUvRz@coredump.intra.peff.net>
 <871r8r1hwe.fsf@evledraar.gmail.com>
 <YNSbe0At6SaQu1Z4@coredump.intra.peff.net>
 <87fsx6xn0b.fsf@evledraar.gmail.com>
 <YNqE8BIRF6NeYQcd@coredump.intra.peff.net>
 <xmqqfsx1yyza.fsf@gitster.g>
 <875yxxgkav.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Jun 28 2021, Junio C Hamano wrote:

> > I do not see a point in complicating the build procedure to avoid
> > using it.
> =

> I'd really understand your and Jeff's concerns if I was proposing some
> really complex workaround, but it's just extending & making consistent
> the "mv" dance we already use for 1/2 our rules already.

I'm not entirely sure what's going on here. We have agreed that
.DELETE_ON_ERROR and the "mv" dance are orthogonal. So the patch to use
.DELETE_ON_ERROR can move forward, while the "mv" dance can be discussed
later.

Like Junio and Jeff, I don't see much value in the "mv" dance, but that
doesn't mean I want it gone. On the contrary, I would to try a scenario
in which it's usefull.

But that is *orthogonal*. Leave that for another discussion.

> Even if you don't care about the end result or making git easier to hac=
k
> on for people who don't share your setup,

I don't know about Junio, I do want to make git easier to hack for
people that don't share my setup, but I would like to know what that
setup is.

> I'd think that making those rules consistent across the board makes
> things less complex, not more.

I don't agree with that. Consistency is just one of the many factors we
have to consider. Even if 90% of instances in the documentation said
"fast forward", that doesn't necessarily mean we should convert the
remaining 10% away from "fast-foward".

First we need to decide what is the end-goal we want to reach, and then
we can go for consistency.

But again, this is orthogonal to this patch, isn't it?

> Anyway, let's not discussed this forever. We're clearly getting
> nowhere. Just for the record I'm quite miffed about the bar for "I don'=
t
> care about this area/platform/use-case, but this person actively sendin=
g
> me patches in the area says it's helpful to send more patches" is so
> low.

I don't think it's quite like that. Skepticism doesn't mean disapproval.

I for one are skeptic of the possitive value of the "mv" dance, but I
wouldn't be surprised in the least if you showed the value in 4 lines of
code. I just haven't seen them yet.

Once again... That's orthogonal to this patch.

> Maybe that's all worth it, and I'd be willing to take the Windows devs
> at their word that dealing with the make dependency was really *that*
> painful. But compare that to carrying a few lines of "mv $@+ $@" to, I
> daresay, make the same or larger relative improvement on AIX.

Oh I don't trust them at all. I did maintain some Windows installers for
years, and with a couple of tricks I had no problem building them with
plain Makefiles, with much more complex dependencies.

I'm fairly certain I could make git build for Windows with plain
Makefiles... But one controversy at a time.

Cheers.

-- =

Felipe Contreras=
