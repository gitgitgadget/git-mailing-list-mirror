Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF85C433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 17:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B545613C5
	for <git@archiver.kernel.org>; Sat,  8 May 2021 17:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhEHRgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 13:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhEHRgB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 13:36:01 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1333C061574
        for <git@vger.kernel.org>; Sat,  8 May 2021 10:34:59 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id k25so11850999oic.4
        for <git@vger.kernel.org>; Sat, 08 May 2021 10:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l8B27FrJbZuRKFpmhnyGTFmo/vamq4KDZ6j6RoavJkY=;
        b=j9F1lCwOHDmiPmBDkgvekL9DO9W66jGuXoRyb2IRIp16+9N1ESId1Ox3+CD9kL9065
         19c/hpYGiX7oNTIvKY63ZvaV9bJDsZoaSOa+pavjm6+j5GBGGFHagB49K5Ij/tMRGzib
         4aGQVLOabEAWyHDA8thVw7OE9wsbw4ZSD2EPj/N535fY5G+Uqk+O38X4WKFLtwOemRA+
         3sPGjrmQ6P99aGFX+LFaf1dRaLDzui8atx45op3f2qh4Qe+dWkc9kuMXRSC23ga65Xe+
         mEcjG7pfndmCOOMtj9tJY0d+IjnNVakBEj+0bg2j1D4ZDWs7f+U1AyB8t+0mEKIuzbyB
         gyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8B27FrJbZuRKFpmhnyGTFmo/vamq4KDZ6j6RoavJkY=;
        b=lg2ezJfpZJBk/2SNNzz1CrUtTvbyJZUbZ6+sLxHQUTQBtOrVXq3CVXbTHm0KwtlEP8
         vKv1jakip5bQKDgtHOzI1Y/eoEnmSRQIjgZF3gtq/a4NkPxqAUpc5Glp5HuqBUbOuwQo
         6zH44X7ovwc7bc/QjBVYS24JKnMm3vTkwfs5lgKFiilU+HfaEFwA2q3iNmv8FAvAqd+6
         rlp4EA8kJZ9pMe8EfrGgnwBSpO6Bs2c+mWhas9lkitrlxuM6nD01CZFAwucTj2WYa/nP
         lyQQwv9vVsVVwlSB3TNLJUOHS5NryhiToHMU31KhItZpkMMKbLE8k3I/jLFXouFNmwbl
         4KKg==
X-Gm-Message-State: AOAM530uu95xyuB1FYj4mwwY58rUHM9S2vjQwmecBC9/XTlcHQjUgMGh
        7pixhQKxv9XYJ9GiExFH7hJI28abDG/4ksiaA0I=
X-Google-Smtp-Source: ABdhPJyOqwnCGTtJLDxy/l+JTO24Nd7d+5DfTw/k7DNBAUpqdeUaCxDQ3MJzQ/1gFDRXVPMaPVziQc8hw06mSmEn65s=
X-Received: by 2002:aca:30cd:: with SMTP id w196mr72534oiw.167.1620495299308;
 Sat, 08 May 2021 10:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
 <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com> <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620432500.git.gitgitgadget@gmail.com>
 <xmqqczu1v8i0.fsf@gitster.g>
In-Reply-To: <xmqqczu1v8i0.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 8 May 2021 10:34:48 -0700
Message-ID: <CABPp-BE5hfMb_Jnwdb5hBjwkZg3EFEWxdqWht9wATRkbz6cjkA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] t7300: add testcase showing unnecessary traversal
 into ignored directory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 8, 2021 at 3:13 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > PNPM is apparently creating deeply nested (but ignored) directory
>
> Sorry, but what's PNPM?

a package manager; I'll use Philip Oakley's suggestion to make it more clear.

> > structures; traversing them is costly performance-wise, unnecessary, and
> > in some cases is even throwing warnings/errors because the paths are too
> > long to handle on various platforms.  Add a testcase that demonstrates
> > this problem.
> >
> > Initial-test-by: Jason Gore <Jason.Gore@microsoft.com>
> > Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  t/t7300-clean.sh | 40 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> > index a74816ca8b46..5f1dc397c11e 100755
> > --- a/t/t7300-clean.sh
> > +++ b/t/t7300-clean.sh
> > @@ -746,4 +746,44 @@ test_expect_success 'clean untracked paths by pathspec' '
> >       test_must_be_empty actual
> >  '
> >
> > +test_expect_failure 'avoid traversing into ignored directories' '
> > +     test_when_finished rm -f output error &&
> > +     test_create_repo avoid-traversing-deep-hierarchy &&
> > +     (
> > +             cd avoid-traversing-deep-hierarchy &&
> > +
> > +             >directory-random-file.txt &&
> > +             # Put this file under directory400/directory399/.../directory1/
> > +             depth=400 &&
> > +             for x in $(test_seq 1 $depth); do
>
> Style.  Lose semicolon, have "do" on the next line on its own,
> aligned with "for".  Tip: you shouldn't need any semicolon other
> than the doubled ones in case/esac in your shell script.

Thanks.

>
> > +                     mkdir "tmpdirectory$x" &&
> > +                     mv directory* "tmpdirectory$x" &&
> > +                     mv "tmpdirectory$x" "directory$x"
> > +             done &&
> > +
> > +             git clean -ffdxn -e directory$depth >../output 2>../error &&
> > +
> > +             test_must_be_empty ../output &&
> > +             # We especially do not want things like
> > +             #   "warning: could not open directory "
> > +             # appearing in the error output.  It is true that directories
> > +             # that are too long cannot be opened, but we should not be
> > +             # recursing into those directories anyway since the very first
> > +             # level is ignored.
> > +             test_must_be_empty ../error &&
> > +
> > +             # alpine-linux-musl fails to "rm -rf" a directory with such
> > +             # a deeply nested hierarchy.  Help it out by deleting the
> > +             # leading directories ourselves.  Super slow, but, what else
> > +             # can we do?  Without this, we will hit a
> > +             #     error: Tests passed but test cleanup failed; aborting
> > +             # so do this ugly manual cleanup...
> > +             while test ! -f directory-random-file.txt; do
>
> Ditto.

Yep, sorry.

> > +                     name=$(ls -d directory*) &&
> > +                     mv $name/* . &&
> > +                     rmdir $name
> > +             done
>
> Hmph, after seeing the discussion thread of v1, I was expecting to
> see a helper in Perl that cd's down and then comes back up while
> removing what is in its directory (and I expected something similar
> for creation side we saw above).

Hmm, I was a bit unsure of the alternative route I took in patches 7
and 8 (switching trace1 to trace2 in dir.c, then using it to get more
statistics which would allow a much more shallow directory structure
for this test).  I wasn't sure if the strategy seemed acceptable, and
I wanted people to be able to see the two schemes side-by-side, but if
that alternative is acceptable, I want to move patch 7 to the front of
the series, the code change parts of patch 8 as the second patch, and
then squash the rest of patch 8 into this patch vastly simplifying
this testcase and obsoleting everyone's comments on it.

Maybe I should have just refactored the series that way anyway.  I'll
send a reroll that does that, and put all the [RFC] patches first.
