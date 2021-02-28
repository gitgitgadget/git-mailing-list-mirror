Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19571C433E0
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 20:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD22F64E83
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 20:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhB1UOk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 15:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhB1UOh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 15:14:37 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2F8C061756
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 12:13:56 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v13so1534489edw.9
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 12:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=UQsNO3YKHYA1hEVZSioUaF8e+uJigD4PBIkiE229di4=;
        b=a0kiZfhdzFFYWBFnHC09GcUxwyCZO0LIoW+Pw1CHeM3pp5aDmN3buuD+TmtsI9ZuYD
         OIxKZAQyYAfsC/00anf8faYBiA5YBF/BmWPvoS0x6y3thFrowL/7REOsoqKX+WhFqe4u
         lBKail76ezdas/V2dtl8MODllTg2PJqqF9L1pMRk6BQW4+T2C2Yfxd14N/UekuNSbyvV
         kpDji7lJk2+hGELUKIQI15qj9QsIIlTkNf5TFi2mRuEeLVjMc74SwvfYga037logwWs9
         BioBQJvPwT9AwRagZgSfaxvKS25M42/FU+FdBGflE3t1I6JoPao0lDPMvRjTQpAfipyy
         ZWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=UQsNO3YKHYA1hEVZSioUaF8e+uJigD4PBIkiE229di4=;
        b=NmOTQ50OkpNLsEzVG28nE7g3UWACrGLbLERBF83G9c1q32KL+slHlX4W8czV7XgyrT
         P+8OSuWVA3YMHCqFTxy3KqR3lgOvEU+D42fZ+h8VZhPJLse0trkK+skbdzjvvmLana61
         zZtmEAFI5RwH+uttBdusJFZfwb/mITjehADdH9mfXG/SPsV8jXzA6su4+kXk8wQiDyGx
         8b7kN/G/TDPJYfZwcn10dSU7qfjfpful5uaXxyoBELQ05K11Vnw1XRW5vj50ea+mIDrE
         rLpGB0bHtnsPyo/19OwucAIhihMcBZ2T3pFGQMFqTq+UKJVMvC5tRK2QYSn/wUb6eawH
         mP0A==
X-Gm-Message-State: AOAM531F4XpoPZ29Ph1SAGM8rHYtIN58rFd5eXvUcbSOxxZbrK8Emjha
        Y4HJ155XbH2NBHMYVMqifS8=
X-Google-Smtp-Source: ABdhPJwJnUtTCM9OquU0QpGCLd61Yee0Dq6R3rX5r54mW2/F97zHgzEn7YcCnSNZlS8fnS56nNBLPQ==
X-Received: by 2002:a05:6402:181a:: with SMTP id g26mr5651651edy.225.1614543235479;
        Sun, 28 Feb 2021 12:13:55 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id jx22sm9082159ejc.105.2021.02.28.12.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 12:13:55 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/6] Makefile: build "$(FUZZ_OBJS)" in CI, not under
 "all"
References: <20210201111715.10200-1-avarab@gmail.com>
 <20210223114132.24345-7-avarab@gmail.com>
 <YDVJZnmTiBYZ4iPM@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YDVJZnmTiBYZ4iPM@coredump.intra.peff.net>
Date:   Sun, 28 Feb 2021 21:13:54 +0100
Message-ID: <87wnusj6gt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 23 2021, Jeff King wrote:

> On Tue, Feb 23, 2021 at 12:41:32PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Adding $(FUZZ_OBJS) as a dependency on "all" was intentionally done in
>> 5e472150800 (fuzz: add basic fuzz testing target., 2018-10-12).
>>=20
>> Rather than needlessly build these objects which aren't required for
>> the build every time we make "all", let's instead move them to be
>> built by the CI jobs.
>>=20
>> The goal is to make sure that we don't inadvertently break these, we
>> can accomplish that goal by building them in CI, rather than slowing
>> down every build of git for everyone everywhere.
>
> The current state is that regular devs are responsible for avoiding
> compile breakages in the fuzz objects, even if they don't care
> themselves. Your earlier patches turned this into: regular devs are not
> on the hook for breaking fuzz objects; they are the responsibility of
> fuzz people. I'm OK with either of those, but this approach seems to me
> like the worst of both worlds. ;)
>
> If you do a refactor, you are still on the hook for breaking the fuzz
> objects because CI will fail (and you have to investigate it, and fix it
> for CI to remain a useful tool). But instead of finding out about the
> problem quickly as you're working, instead you push up what you think is
> a finished result, and then from minutes to hours later you get a
> notification telling you that oops, you missed a spot. I find that the
> shorter the error-fix-compile cycle is, the less time I waste waiting or
> context-switching.
>
> If we had a ton of fuzz object files that took forever to build, the
> savings on each build might be worth it. But AFAICT (from timing "make
> clean; make -j1" before and after), we are saving less than 1% of the
> build time (which is way less than the run-to-run noise).
>
> It doesn't seem like the right tradeoff to me. (Likewise, if other
> CI-only checks we have, like coccinelle, could be run at a similar cost,
> I'd recommend sticking them into the default developer build).

It's mainly psychological and doesn't contribute much to overall build
time as a percentage, but I find it grating that the last thing I see
before I switch away from that terminal when firing off a build on a
slower GCC farm box I can only use -j1 on, is these fuzz objects taking
2-3 seconds to build, knowing I'm wasting time on something I'll never
need.

I think when we build something we should narrowly be compiling only the
things we need, not running some sort of pseudo-CI on every developer's
computer. We can have CI or other targets for that.

Besides, if we were going for some sane cost-benefit here we'd have
targets to try compiling with NO_CURL=3D1 or some other conditional setups
that are actually common in the wild.

> One thing we _could_ do is stop building fuzz objects as part of "all",
> but include them for DEVELOPER=3D1 builds (which includes CI). That keeps
> them from hurting normal users (who don't actually need them), but
> prevents bitrot. It doesn't address your original motivation though (you
> as a developer would probably still be building them).

Please no. A very good thing about how DEVELOPER=3D1 works is that we're
not doing anything extra except advisory compilation flags. It's turned
on for "production" builds in a lot of settings because of that.

It would also be very annoying to e.g. have some failure on Solaris or
whatever, debug it with DEVELOPER=3D1, and then get some completely
unrelated failure in the developer-only code, e.g. because we'd decided
to compile all of fuzz/NO_OPENSSL/NO_CURL etc. and had some bug there.

Yes that bug would be worthwhile to fix, but not right there and
then. So having it under some "make all-combinations" flag or whatever
would be better.
