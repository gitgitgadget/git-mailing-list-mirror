Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9343FC433EF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 07:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B4260F91
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 07:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhIDHly (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 03:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbhIDHly (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 03:41:54 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54272C061575
        for <git@vger.kernel.org>; Sat,  4 Sep 2021 00:40:53 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id a15so1470250iot.2
        for <git@vger.kernel.org>; Sat, 04 Sep 2021 00:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=42KEJk5Z7iI8vaE68sDcFRFSpenjubzONvZzQUClE0w=;
        b=TDEOdm02aRLW5NIiE/lhsT7a/mgZyLPbaQu8nimkXHCfdTWA7mUO4VzISifoamaABh
         yspVLCykC0lR7/JsHfIPFCRysj84VCjY3+UGgJVHXf/77VFznV1LO7Xop9eex7KDMMIQ
         APVt82FSh5uTzsT/dpMebTfKmU4EaGFy88ddi7MVkA25y4sHVHuF6cJBjRH4gf4dHzQM
         EZ7KMJonoAnzF6AO6JjXsI8P093rGoK0EoHt0WccLW3RlmGZnaWuG2ON0V04pXrDXcgj
         msnfdX1vYU0beNiWDPfc+50b30Mvi5kDcpBRvUwMzcqugzKEfTNpBRxTZmAZNRcJ4igS
         8CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=42KEJk5Z7iI8vaE68sDcFRFSpenjubzONvZzQUClE0w=;
        b=SFHQVmrGRnxZDcJVRoxHH8C9emPoI+dgf4sHwOyz3Qu7vUA1DhgSPzOM0B1PEXnuOO
         Gtywf9bF2sVfVbLtFRV9uzPdGuYKawCTl2/fJiI/H6ySDzpubYvE3BjYlrKE1PU0nf3u
         Og9JJx4O3x/qb5YFmdcJhlrPXbY6x+I19b1EMZVAbjdVnW80HX+9vhbiY3/kCI5ULQnG
         k7WKl/RdeTOjbzionTJolin0oSu4NQyde4OjJRkfcuj8V3bsCYmTijvFZI4dgM1aQ1ck
         5+61j67CdmK9So9/X9sNLz48oBmqu6UoXV3l0sjPAoVK56TlwbDkrrGTTbPNLEGeGHPL
         540g==
X-Gm-Message-State: AOAM531dRZ7QqLXbWU8vLKUUx9Ro6kG8NU1Ehk52mz/gqHSGWQIFUSu7
        tZ2hrnMFukd9RgN3fkJ1Gz1rVLfDbyWcB4MXA0U=
X-Google-Smtp-Source: ABdhPJwGvcPEdCG/X9npa6mQOZf22kEGZccCEb58aPv/JJDISc7HxhDckrV2da69B+5LAPGAQUfn5M/vb/2NNWwWGFA=
X-Received: by 2002:a05:6638:d85:: with SMTP id l5mr2351958jaj.2.1630741252792;
 Sat, 04 Sep 2021 00:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <YTGLLQCvlnT17jo8@nand.local> <CAP8UFD2SNyCj6Weo4EeHt0Z-CW9CEJbQbzmU7jhwfJdNW9CrYQ@mail.gmail.com>
In-Reply-To: <CAP8UFD2SNyCj6Weo4EeHt0Z-CW9CEJbQbzmU7jhwfJdNW9CrYQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 4 Sep 2021 15:40:41 +0800
Message-ID: <CAOLTT8QufEU5Q64JfQyEOs4FYCsrNX2jgj8PdmYziVtKnRyu4w@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Taylor Blau <ttaylorr@github.com>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>, Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=
=884=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=8812:30=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Fri, Sep 3, 2021 at 4:40 AM Taylor Blau <ttaylorr@github.com> wrote:
> >
> > Are we interested in participating in the December 2021 round of
> > Outreachy? September 3rd (tomorrow at 4pm UTC) is the initial community
> > application deadline.
> >
> > Christian, Peff, and I discussed off-list that we would each try to pul=
l
> > together funding for one intern from GitHub and GitLab respectively.
>
> Yeah, and we submitted an initial community application.
>
> > If we're interested, the project submission deadline is September 23rd
> > [1]. By then, we'd need:
> >
> >   - Volunteers to act as mentors
>
> I am ok with co-mentoring 2 interns.
>
> >   - Updates to our applicant materials on git.github.io (project ideas,
> >     as well as potential microprojects).
>
> About microprojects, I have been wondering if there are run_command*()
> calls that could be replaced by direct calls to C functions like what
> Junio did in ffcb4e94d3 (bisect: do not run show-branch just to show
> the current commit, 2021-07-27), and if that could make a good
> microproject.
>
> About project ideas, maybe continuing Hariom Verma's GSoC 2020 "Unify
> ref-filter formats with other \-\-pretty formats" project could be and
> idea, though maybe it could interact too much with ZheNing Hu
> continuing his GSoC 2021 "Use ref-filter formats in `git cat-file`"
> project.

If the project idea is related to Hariom or my GSoC project, I think I can
provide a lot of help. :)  I can help them as a mentor.

This may be a place to promote my patches: See [1][2][3].
It can provide some extra atoms for git cat-file --batch | --batch-check,
like %(tree), %(author), %(tagger) etc. Although some performance
optimizations have been made, It still has small performance gap.

If the community still expects git cat-file --batch to reuse the logic
of ref-filter,
I expect it to get the attention of reviewers.

The solutions I can think of to further optimize performance are:
1. Delay the evaluation of some ref-filter intermediate data.
2. Let ref-filter code reentrant and can be called in multi-threaded  to ta=
ke
advantage of multi-core.
These ideas may be very difficult to implement now.

[1]: https://lore.kernel.org/git/CAOLTT8SxHuH2EbiSwQX6pyJJs5KyVuKx6ZOPxpzWL=
H+Tbz5F+A@mail.gmail.com/
[2]: https://lore.kernel.org/git/pull.1025.git.1629882532.gitgitgadget@gmai=
l.com/
[3]: https://github.com/adlternative/git/commits/cat-file-reuse-ref-filter-=
logic

Thanks.
--
ZheNing Hu
