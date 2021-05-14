Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454F0C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 08:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A82613E9
	for <git@archiver.kernel.org>; Fri, 14 May 2021 08:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhENIyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 04:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhENIx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 04:53:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FB9C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 01:52:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t21so15889206plo.2
        for <git@vger.kernel.org>; Fri, 14 May 2021 01:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IwJ74iBnhMDvnEkKv8mbEyw3Ew2yB7VgJIlCT4motz8=;
        b=S5q+F1/Mg3ds2uZg2lLmpQjnLuW75D5FTG7bL4b2USbJd/9NriwUkSoHHwElU+RzY9
         gs28O7tfXb3OQ6JBb5Phl02exr0gXZnrJquDJTiytAjWnvK2TAa4Rqrq2IzPVenXC2RF
         t9nqVEwJM+JnWazOaBQh5ferQ6fCHx9oz5uohyctPA/cU9fqMn2fsAGZQFgPGmoriRRq
         dGbH3sqLr2ueebassyd21MkDNTE96hwSF0u223D/+KHRzKkniWmfqNVRVEOtXvqtCFzD
         SqG73HF6X4E5PaSZmEYCH8miwNg3e4MeqskyRHaGtYH7qX498LJjoGnGR06vqqGsxkfQ
         WUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IwJ74iBnhMDvnEkKv8mbEyw3Ew2yB7VgJIlCT4motz8=;
        b=WxEwYw9CMnoHuH8HyC348OBkB2JQpYQUBEiJXgdbJEpOVtBRDaIem7yfxhwwmRWzQO
         rDdqA/VMV7FoJ3chLC2K/qS278DRvVwzW74opGBrYy3jjugMuJFR4XBkUpUQGcwJzpDJ
         B4RQ6BI08hsNg4GzKznQ6kSARTi1rvwWfYTfkEWP+H3EdM49J2Y2zqgNwBniMHHfIZG0
         cI7s7dcDoNl68ImTVfHLMzuaWzi74ex8LG4wzu/cCpAUXNs9k964AvcMK8+ndhMmwBcH
         8eMlB2EhWrsHgompmgkbOlXrzhifnPm4MXemN48VmmeRQNVwhCQNY+jRgqkUPaKHz90w
         KlXA==
X-Gm-Message-State: AOAM532xaN7JWtUbOmfb9vTpqAAlpiz4EXz5uhf5EY78nYOGtBky1Ply
        V/gtJ2ghW14/TICimN0YEe93ZNepFJ8pUvFZVbg=
X-Google-Smtp-Source: ABdhPJytT7vgl7U02LH2eXEy7XFG/YIGw8R5HQ05YoyuMn2pZD9u843NhuhMsG0vndzzOyfh7iAeLQ3n5+wXo3jvBhs=
X-Received: by 2002:a17:902:7c8a:b029:e6:f010:a4f4 with SMTP id
 y10-20020a1709027c8ab02900e6f010a4f4mr44313154pll.17.1620982368283; Fri, 14
 May 2021 01:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <YJzGcZpZ+E9R0gYd@coredump.intra.peff.net> <CAN0heSp3mXQeqeC_Zd==bBoJCCWe-NzJsomuUf6MTxy7+WZ1wA@mail.gmail.com>
 <YJ4PHbVoQ8+ubfBK@coredump.intra.peff.net>
In-Reply-To: <YJ4PHbVoQ8+ubfBK@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 14 May 2021 10:52:35 +0200
Message-ID: <CAN0heSrjPJG_OGyV2dt9bOfkd07He=kBUKQ-+w5JXNae+YH7qg@mail.gmail.com>
Subject: Re: [PATCH] t: avoid sed-based chain-linting in some expensive cases
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 14 May 2021 at 07:48, Jeff King <peff@peff.net> wrote:
>
> On Thu, May 13, 2021 at 01:05:28PM +0200, Martin =C3=85gren wrote:
>
> > Devil's advocate: Who do we expect to turn GIT_TEST_CHAIN_LINT_HARDER
> > on, and when?  If no one ever does it then we might as well drop the
> > "default" thing and just go "we won't bother linting these particular
> > tests, ever". But as long as "someone" does it "sometimes", it's not
> > like it's a very complex mechanism to carry around.
>
> The answer is probably: people who suspect something is broken. We could
> perhaps also turn it on for CI to be more complete there (and where 30
> seconds of CPU time is relatively much smaller). It was also handy to
> have while timing the impact, of course.
>
> I'm not opposed to having it be less flexible, and in fact I wrote it

And to be clear, I'm not opposed to having it more flexible. :)

> that way originally. But it doesn't actually make the code much simpler.
> The assignments to _DEFAULT in the scripts become GIT_TEST_CHAIN_LINT_HAR=
DER
> and the read side has one less level of defaulting:
>
> -test "${GIT_TEST_CHAIN_LINT_HARDER:-${GIT_TEST_CHAIN_LINT_HARDER_DEFAULT=
:-1}}" !=3D 0 &&
> +test "${GIT_TEST_CHAIN_LINT_HARDER:-1}" !=3D 0 &&
>
> I guess it's conceptually a little simpler, though. I dunno. I sort of
> assumed it would just work and nobody would need to ever look at or
> configure it either way. :)

:)

> > I seem to have 140 tests that haven't changed on disk since I did this
> > particular clone in 2017. 235 haven't changed this calendar year. Maybe
> > we could skip linting those tests that haven't been modified for severa=
l
> > weeks on the basis that they can't reasonably have newly-introduced
> > syntax mistakes. I guess it gets tricky where the t????-*.sh file
> > doesn't change in a long time, but it sources tests from other places,
> > such as a lib-foo.sh helper. We'd have to be a bit more clever there.
> > That's all just thinking out loud, and definitely not something that
> > should hold up your patch.
>
> Yeah, I suspect that would work in general. But it seems like even more
> complexity (now you have a cache of "I linted this script at time X and
> it was good" that has to be written). It does increase the possible
> savings though (up to perhaps 100 or so seconds of parallel CPU in my
> case).

Yeah, I thought about the cache. I guess it would be a list of
known-good test script hashes / blob IDs. But what I actually meant was
to check whether the mtime was way back in the past. It's not fool-proof
though. You could have a network-mounted disk where the date is way off,
or you could hack up the test script, wait for several weeks and *then*
run it. ;)

> I think a bigger and better version of that is to actually see which
> code paths are run by which scripts, and not even bother running scripts
> that don't touch code which has changed. But that's a _lot_ more
> complicated, and writing such a tool is probably at least worth a thesis
> project. ;)

Ah yes, it should be safe to punt on that for now.

Martin
