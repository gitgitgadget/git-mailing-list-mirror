Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAE7C43467
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 19:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0855B2078A
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 19:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+VyZglM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgJNTCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 15:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730421AbgJNTCT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 15:02:19 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875D5C061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 12:02:19 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t77so317696oie.4
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 12:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+s9o4hmNTYDneRl7rdx/FI3sNm7sY5M/5Ward12PHM=;
        b=N+VyZglMZUMUEkTKrzjHaYODhSTn1QrSDY/2W/3Ut1wi+yWI+uj4MASbFrgOEiJIKO
         POVhsrod2048cYCbaCUX0F9dDYRdO5lMEfs/LvfKL05BXqsYJ7mcCfKvyia8DuKvWsMV
         GvS5eK80gT0UQZgJQW3YfiYwbbIehBYOZSH/0lT8xsJvNnyiFBVeP3JtfWRf23wQVEpV
         VuNaJ3rIfB6eRfgcKXDV4QgnECuI6UAvjDQRQsI0zQTiT1Lahv0ZDEtedkmabd3bYia9
         SHeUbGs5VsL7oWzbpS5s5LbUqpU8J7kYW+u8raDpLtw9LUkA2raJaUXMXCVlMlPWttAo
         UrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+s9o4hmNTYDneRl7rdx/FI3sNm7sY5M/5Ward12PHM=;
        b=Pb2G1whU3JogZwKWUyBZEf1ApG3NhCDmADsK8cxM4XeB/uR9JmfwEVrelMfmN1W/WE
         MONiABo8vUFYZ/z82qJlK+Atd8GLiM53bHu1I4/69BEAYkrGHHTOx41iIWnQMPWarYtU
         xwzuAKYs5tFbrB2QZlMY0z2fZGThWd0GC3yO5yLYvUce9pY0yDc9UyyVgIv04Ln54PfJ
         ddejOHsd8WgaTh6FynF5vUxgTiKzvdXO1OSnSULOFqCNTItfT7z9EqR9jtYXSwUD+ef5
         4QR7wPK0kAxBSsUTVpPpbLBlAIAPdAWwnRwmimjL1pBywJcaDc7V8/RNiHQWN+VykEkT
         vCQw==
X-Gm-Message-State: AOAM533ueP8FS/bQeHe0RXeYud8Hd3dFpiFBTKAkQOeqg1z+L+NrYAqC
        3/r6wAn8YTA/CFduEei1omaHTH1sge8kC8vJLHU=
X-Google-Smtp-Source: ABdhPJxON47QO8MsUPZ/Ba9CUSWT4rkumCgZlTl9dyWg168JfLdKSD9ST/CD1S6vANC8HFc/7eI9wvH8AAxRjDXD0e4=
X-Received: by 2002:aca:ec92:: with SMTP id k140mr517800oih.39.1602702138754;
 Wed, 14 Oct 2020 12:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com> <41e2528e83ba7087c9d21f0b15efed416f1512f8.1602616786.git.gitgitgadget@gmail.com>
 <20201014170413.GB21687@coredump.intra.peff.net> <CABPp-BEOrYhUBZ112Z7qFgwUYojmus6_Ra0G0Ts4y+n=-D5vMw@mail.gmail.com>
 <20201014180959.GC24279@coredump.intra.peff.net>
In-Reply-To: <20201014180959.GC24279@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Oct 2020 12:02:07 -0700
Message-ID: <CABPp-BHV4WGygzyw6RUsJqCGkvmc-f4dseFjbAG9hUvJgkYx+Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] test-lib: allow selecting tests by substring/regex
 with --run
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 11:09 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Oct 14, 2020 at 10:50:03AM -0700, Elijah Newren wrote:
>
> > > > @@ -819,9 +821,8 @@ match_test_selector_list () {
> > > >                       *)
> > > >                               if expr "z$selector" : "z[0-9]*[^0-9]" >/dev/null
> > > >                               then
> > > > -                                     echo "error: $title: invalid non-numeric in test" \
> > > > -                                             "selector: '$orig_selector'" >&2
> > > > -                                     exit 1
> > > > +                                     echo "$title" | grep -q "$selector" && return
> > > > +                                     continue
> > > >                               fi
> > >
> > > I like that you allow regexes. It's unfortunate that the skip-check
> > > costs us a process in every test. It may not be that big a deal since we
> > > only pay it if you use a non-numeric selector. But I wonder if there's
> > > any reason not to use "expr" here, as well.
> >
> > I originally used [[ $title =~ "$selector" ]] in order to avoid the
> > sub-shell...but that was bash-specific.  I briefly looked to see if
> > there was a shell portable way to handle regexes, wasn't having much
> > luck, and decided that this is only likely to arise when people are
> > passing --run and thus only running a single script and they avoid all
> > the subprocesses that would have been invoked inside the test, so it's
> > still a big net win overall.  Does expr handle regexes, portably?  Or
> > are you suggesting dropping the regex handling and limit it to
> > substring matching?  In either case, does using expr save us anything
> > (isn't expr a shell command)?
>
> There's an expr command doing a regex match in the diff context quoted
> above. :)

Oh, indeed.  How'd I miss that?

> I was wrong that it would save us a process, though. I thought it was a
> builtin in modern shells, but it doesn't appear to be in either dash or
> bash. So there's little reason to prefer it over grep here (switching to
> globs could be done with case and would save a process).

I guess it's at least slightly more consistent with the surrounding code.

Oh, and I found a bug in that my code was not handling negated
substrings correctly, e.g.
   ./test-script.sh --run="!rename"
would run all the tests instead of excluding the ones that had
"rename" as a substring.  So I'll send a reroll fixing that.
