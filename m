Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C414C433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 05:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhLKFTE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 00:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhLKFTE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 00:19:04 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AF1C061714
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 21:15:27 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v1so36385720edx.2
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 21:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Elyjw7aKh2WG0TVFYRdR6zZ0OZB09XyrQxObjUBQfEQ=;
        b=KQ/ckq4HR2d9ujRzpZzb3TCrZfOivC6ZEH2l3+2dEcnm1L2YpDMEZTzhJmee6w0uS0
         6nvuHZ8GCTh9ANYOo/155E+EHJc8v+QUDYMZSB1lK1uHON6dYC2D6vi/NJK1Nj6chuFx
         zJE1oz87ZBnFEeWA9GR/NxynM64kt9iFaUdbBRBDO/EJt8kWquGqsqCNMEIxeZpEBGCM
         HKpE+ee3CPe45LQV28weJVMDH3dzIMoEWHNQeIuN8/Zie5oHIaagDXF3tV79w7XF9BkU
         1qkPlQTMRvHzdiVupMal0udJpPKHvwTtsd32Rkkn6U1xCz7/jmXACdg78S5aIaRmGsMJ
         fBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Elyjw7aKh2WG0TVFYRdR6zZ0OZB09XyrQxObjUBQfEQ=;
        b=3zRtPDeD33pf6F+Zdui1eCKsM0OPgBo8GI/aT6Dcef+B/8b/bgVQjaNcewGcvzbWRC
         JmX5uToMyuByMIMW3ng0rJlrskQLWcReaR4hNyuDqhd4tHHNpGCG5C6cx0oswiIiyjb8
         TKfdTlAEyMke5T4Kd3Nq83GPXxrZe7xS7o8E+kEPxC164nYtjDqehN9Moh3vmbhGbcSb
         /GIdPlRLv0OVx+BQzQ7xUZ7UY97Sh5MMV5nyh/xzKC6FsWbhaVzcWjOy1uzZj6ZH9D2A
         1kdYa3tuDGgFCK0eTgmnTu6KTD276/kSKSBU0ccmxryMd737zQ0hEtU8PPXkx2lAOMOU
         UKcw==
X-Gm-Message-State: AOAM530QiOg/fYvjWjrlt6aYY51XMCsNaA9doJY8urWFlyaUmKrcI8sj
        X97waNolR/kgCyzGIJ7NLKyiKiK8m7SsxBohUZI=
X-Google-Smtp-Source: ABdhPJw6OTlwyaoYdZRjOVmtGdOR09Eg8UZqGu32ukGV4iDWpdardPfjmI5h8bhnQpXnT2H0paCvJlu5z4XTZhUm1So=
X-Received: by 2002:a05:6402:491:: with SMTP id k17mr44995874edv.333.1639199726259;
 Fri, 10 Dec 2021 21:15:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
 <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com> <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
 <xmqq4k7nmksi.fsf@gitster.g> <nycvar.QRO.7.76.6.2112081207320.90@tvgsbejvaqbjf.bet>
 <xmqq8rwuv3i2.fsf@gitster.g> <nycvar.QRO.7.76.6.2112110044010.90@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2112110044010.90@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Dec 2021 21:15:15 -0800
Message-ID: <CABPp-BGt=AcCg-74SSpS7iPFOCKnWE7Q7+CruvALLxKnqXGRuw@mail.gmail.com>
Subject: Re: [PATCH v10 00/15] Upstreaming the Scalar command
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Fri, Dec 10, 2021 at 4:29 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Junio,
>
> On Wed, 8 Dec 2021, Junio C Hamano wrote:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > > The Scalar Functional Tests were designed with Azure Repos in mind, i.e.
> > > they specifically verify that the `gvfs-helper` (emulating Partial Clone
> > > using the predecessor of Partial Clone, the GVFS protocol) manages to
> > > access the repositories in the intended way.
> > > ...
> > > I do realize, though, that clarity of intention has been missing from this
> > > mail thread all around, so let me ask point blank: Junio, do you want me
> > > to include upstreaming `gvfs-helper` in the overall Scalar plan?
> >
> > Sorry, I do not follow.
>
> In
> https://lore.kernel.org/git/CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com/
> (i.e. in the great great grand parent of this mail), you specifically
> replied to my mentioning Scalar's Functional Test suite:
>
>         > > One other thing is very interesting about that vfs-with-scalar
>         > > branch thicket: it contains a GitHub workflow which will run
>         > > Scalar's quite extensive Functional Tests suite. This test
>         > > suite is quite comprehensive and caught us a lot of bugs in
>         > > the past, not only in the Scalar code, but also core Git.
>         >
>         > From your wording it sounds like the plan might not include
>         > moving these tests over.  Perhaps it doesn't make sense to move
>         > them all over, but since they've caught problems in both Scalar
>         > and core Git, it would be nice to see many of those tests come
>         > to Git as well as part of a future follow on series.

This is me and my email you are quoting; these aren't Junio's words.
I'm afraid my confusion may have snowballed for others here.  Sorry
about that.

I simply misunderstood at the time -- I thought there were scalar-only
tests (rather than scalar+gvfs tests) that were not being considered
for upstreaming.  As I mentioned before[1], I'm sorry for the
confusion and seemingly opening an unrelated can of worms.  I agree
that we don't need gvfs tests, or tests that combine gvfs with other
things like scalar, or c# tests.

[1] https://lore.kernel.org/git/CABPp-BFmNiqY=NfN7Ys3XE8wYBn1EQ_War+0QLq96Tk7FO6zfg@mail.gmail.com/
