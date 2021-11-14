Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E62EC433EF
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 20:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C01A6112E
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 20:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbhKNUNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 15:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbhKNUNv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 15:13:51 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A4BC061746
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 12:10:55 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id d10so40580539ybe.3
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 12:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPekiq5IM24w6tTW+YvqHkPVT2BaWHn0kjM+t4lfaEc=;
        b=mJkhqa6XCTVuYfx+1slRJUErfk9zE2G13WQjj3aQT3N/SnOS2UESV7wYRFJav0TALF
         qQU7sB6+HI6bS0yoxkd84saK4j8TFHoXFjwvrqCshGbKXT87Oe3QhhFI9LwTQzyanRLT
         UVNzIQn+I7bvMHPoGYhDj87OAzDGF/pbU8brg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPekiq5IM24w6tTW+YvqHkPVT2BaWHn0kjM+t4lfaEc=;
        b=O9MHEA42GEz3SoxiGpoGNTb+Ke7imwwBYSF99fL8JC4o1NLYhyvUstovAJZNOG2cz9
         TzFlClJzy29LKO+cta30ODeNNPBWnt8R+B4CWXdfUR+eMx+LHK9B4gm+Yx9NOWMM3mF5
         fbIWk/iXOsDkIYA/Xfav8mra4zIZYDD+dTIkLaPVVh77MwXudRInEhoG9r7hRLmzTIoL
         +2QybaRC/Q9Uo96zT09oF5xrZ9FSwf/MN31sgzUif+ONe572sadmQP6EKx/dMGSPAuQ7
         hjoCkUPu8vIsONuTRKDHUjnmZLxBwmySUs34KkCv5zKDrHkRRI8Ugh5fCpU9QDTATelx
         2RYw==
X-Gm-Message-State: AOAM530q6HhyFi9LPXQP8yUd30CCsH7iLKQuz3Xn/7qkOm8+3Ugt2+d/
        fvTobRhvTbnPax1Qes5eGvkiq9GiKDt4+Go0C2JSMQ==
X-Google-Smtp-Source: ABdhPJzsRd8Punhto58LdN3TDV6Chts0txuIvPpy0QBH46nfQMv2F5lPmHClzXMh/bQvtZXv3/zUAPPxwMDy4bwbaAc=
X-Received: by 2002:a25:1c02:: with SMTP id c2mr35020021ybc.218.1636920654902;
 Sun, 14 Nov 2021 12:10:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com> <6b7a058284b93fab52458b12a6aede5e8aed6652.1632152179.git.gitgitgadget@gmail.com>
 <20211104194619.GA12886@dinwoodie.org> <nycvar.QRO.7.76.6.2111090051530.54@tvgsbejvaqbjf.bet>
 <dca03da9-5684-10c7-2315-2d10affd4f0a@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.2111092358240.54@tvgsbejvaqbjf.bet> <xmqqee7ozyx4.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2111101324020.21127@tvgsbejvaqbjf.bet> <02b6cfa8-bd0a-275d-fce0-a3a9f316ded3@ramsayjones.plus.com>
In-Reply-To: <02b6cfa8-bd0a-275d-fce0-a3a9f316ded3@ramsayjones.plus.com>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Sun, 14 Nov 2021 20:10:21 +0000
Message-ID: <CA+kUOanwFBdv=kd+txAmfkb6jdC=gdSyaBEi89T0neE1w5iO0w@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] t/helper/simple-ipc: convert test-simple-ipc to
 use start_bg_command
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
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

On Sat, 13 Nov 2021 at 19:11, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> On 10/11/2021 12:27, Johannes Schindelin wrote:
> [snip]
> >> I cannot give the change any better test than they can, and it is
> >> their platform to improve, or break by accident while trying to do
> >> so.
> >
> > Right. I tested this as well as I could, via the `--stress` option, and am
> > fairly confident that it is correct. Since the patch touches only
> > `simply-ipc` code, the only test that could possibly affected is t0052,
> > and it passes with `--stress` over here (when it failed without the
> > patch).
> >
> > Ciao,
> > Dscho
> >
> > P.S.: in case you wondered, no, I did not run the entire test suite. With
> > the performance characteristics of the POSIX emulation provided by the
> > Cygwin runtime, this would simply take too long. It's not the first time I
> > wish our test suite was more efficient, across _all_ supported platforms.
>
>
> [I seem to have lost Adam's reply about this now being Hunky-Dory, but ...]
>
> I ran the test-suite on -rc2 on thursday night (note _not_ rc2 + this patch)
> and it deadlocked on me; I didn't notice for 4 hours, so (in the early hours)
> I simply Ctl+C-ed it and went to bed. I haven't had the test-suite deadlock
> for many many years - I've been spoilt! ;-)
>
> I tried -rc2 again last night; this time it finished, but I gained another
> test failure: t0301-credential-cache.sh. I have _never_ had this test fail
> before, so that was unexpected. :(
>
> [Yes, t0052-simple-ipc.sh failed as expected, since this patch was not
> applied].
>
> Also, I was half expecting a small speed-up due to the new pipe code in
> v3.3.2 of the cygwin dll, but it actually took an hour longer than normal. :(
>
> The only change to my setup, between -rc1 and -rc2, was the cygwin update
> to v3.3.2, so this may point to some more fallout from the new pipe code
> (maybe?).
>
> Anyway, I haven't even looked at the new failure (see below), which we will
> probably not have time to fix before release, so I am just now building
> current master (v2.34.0-rc2-16-g5a73c6bdc7) to give that a try. (So, I won't
> have anything to report until tomorrow).

I'm seeing the same failure. It isn't caused by a change in Git --
I've rebuilt and re-run the test on old versions where that test was
passing, and it's now failing -- so this is clearly something in the
Cygwin environment. I've not investigated further, but it's clearly
caused by a Cygwin change rather than a Git change, so I don't think
there's any reason to hold up the Git release.

(I should probably report it on the Cygwin mailing list, but I haven't
got around to that yet...)
