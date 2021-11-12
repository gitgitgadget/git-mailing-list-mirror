Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EBDC433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 08:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B292F60231
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 08:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhKLJAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 04:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbhKLJAL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 04:00:11 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D78C061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 00:57:20 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id e136so21926421ybc.4
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 00:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ONwqy/vHpivASK+uFaIUFEfoS3ioTg8kEqW+h4qxklE=;
        b=ud6rXj+JZXogglZK5CogQlFwogh0Vgl3lSbl9Bd9/bG/HNy00SQ93JOjuyyVnEEUED
         dC7yVJBkU1oLy5Gfsx8G42NxSkyUAaJjky6gqsKp+xpLdHzFG+xYMNw4MOomG4ztr6el
         WoJZAT+BCA3C73kniSMUZwqfQqVWZwvHPtPZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONwqy/vHpivASK+uFaIUFEfoS3ioTg8kEqW+h4qxklE=;
        b=RgLdiplninKLry1ndgHKaWdptmKi327EAKlSz/t7Sbhwm9A+oQEC4dFC8ltGnhPwix
         BxvidSTGc9YLbmlpfLU4YQGPFQifcgzuZgPZ71kCrNfxpy+bbWR2+6KDfEcmv2Hxi1uc
         k5dyUhLYxpNX9HUSmxTo4Ma9PkbbzUNFdVkKU9Q+tb+71w+d5Fb/hy7HJpWy2j1o5m05
         PQWLQ02IskK5sRpVAukb9RbfcGdJX+8/LWcGmbW5v9oUeP9UPUi4C4dBOh/WERwMs6if
         hSf8AZVggMG6q1CJm+Wbq+EXFZMaujD6BFG+dubYOodiT9qPdCQyrW1r12hCMWEkoWhB
         +n0g==
X-Gm-Message-State: AOAM533b2CcpSWTUXItjaVJRwaQLsTNG5siBeOWp2H/q+bisy5bc9q3f
        nOX8dH+badNMZF545i1gLU9GGhrrv3D69VJQ10RVlw==
X-Google-Smtp-Source: ABdhPJza3r/P7qPGopKAweeJ3VxJJyzfGA7Cd9tielq6TaszTlD/hh570ch7/JYkqBi7/8yBjl7sFVMfQaKsnglVrjg=
X-Received: by 2002:a25:1344:: with SMTP id 65mr15194548ybt.468.1636707439773;
 Fri, 12 Nov 2021 00:57:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com> <6b7a058284b93fab52458b12a6aede5e8aed6652.1632152179.git.gitgitgadget@gmail.com>
 <20211104194619.GA12886@dinwoodie.org> <nycvar.QRO.7.76.6.2111090051530.54@tvgsbejvaqbjf.bet>
 <dca03da9-5684-10c7-2315-2d10affd4f0a@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.2111092358240.54@tvgsbejvaqbjf.bet> <xmqqee7ozyx4.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2111101324020.21127@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2111101324020.21127@tvgsbejvaqbjf.bet>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Fri, 12 Nov 2021 08:56:42 +0000
Message-ID: <CA+kUOanh1m=dkE-gDikg53zOPXx_7v65ggqxPspuZWDbdOrR=g@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] t/helper/simple-ipc: convert test-simple-ipc to
 use start_bg_command
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 10 Nov 2021 at 12:28, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Junio,
>
> On Tue, 9 Nov 2021, Junio C Hamano wrote:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > > I fear that it is a bit late in the -rc cycle to try to get this into the
> > > official v2.34.0. Adam, since you are the maintainer of the Cygwin git
> > > package, would you mind incorporating this patch into Cygwin's version of
> > > Git?
> >
> > I do not mind taking a Cygwin-only #ifdef block in compat/ like we
> > see below from folks who have stake in Cygwin, and who are clearly
> > leading Cygwin users on the list, like Ramsay and Adam are, even
> > after I tag -rc2.
>
> Thank you for your encouragement, I contributed it here:
> https://lore.kernel.org/git/pull.1074.git.1636542550889.gitgitgadget@gmail.com
>
> > I cannot give the change any better test than they can, and it is
> > their platform to improve, or break by accident while trying to do
> > so.
>
> Right. I tested this as well as I could, via the `--stress` option, and am
> fairly confident that it is correct. Since the patch touches only
> `simply-ipc` code, the only test that could possibly affected is t0052,
> and it passes with `--stress` over here (when it failed without the
> patch).
>
> Ciao,
> Dscho
>
> P.S.: in case you wondered, no, I did not run the entire test suite. With
> the performance characteristics of the POSIX emulation provided by the
> Cygwin runtime, this would simply take too long. It's not the first time I
> wish our test suite was more efficient, across _all_ supported platforms.

I have just run the complete test suite on rc2, both with and without
this patch, and I can confirm it resolves this problem and doesn't
cause any other new test failures.

But yes, the (lack of) speed of running the Git test suite on Cygwin
is one of the reasons I run the tests on high-spec Azure VMs rather
than my own systems. Unfortunately the Cygwin compatibility layer plus
the overheads of NTFS mean things are unlikely to get significantly
quicker any time soon, and between WSL and Git for Windows, I expect
interest in improving Cygwin's performance is going to continue to
wane.
