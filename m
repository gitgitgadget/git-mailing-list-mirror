Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EBFC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 06:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E84A6127C
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 06:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhDTGbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 02:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhDTGbp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 02:31:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEEAC06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 23:31:13 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id n138so59889107lfa.3
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 23:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0VQzb4fN97HBJkPGlu5SRM41fyoJOr5lmnaZWIV6q1E=;
        b=Zdnw5aE2xufREyCO4Gusu/wIuk5q7xceZxdcLoY7cPEch0NE4DRsjlGvbR/XreKL6D
         sDsZTyuZw/okqNpsMrxs04jr6oqkQXeHD58dUiQXvXivAyqA2z29P1yJkLxvYZTpuRXd
         sfh6njpvTQVDav0byC0aurln7gDISOqAt7SokAd5zjmrMD42dKCX+iq5/Mk9NRJwXF9Y
         0/cyTwgTsKpZoTfFm2TqmtPZuz8rbQe+1sIwlJI5ksbtL2Zg8aikIocNV3didZpl0e5Y
         V6cgW5T6WvZ9VfQDyUlhqMOnsqqcyR4dvnGU8ewQq8DBUt10hlvONbjTBUsLM+lHPo/a
         7lbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0VQzb4fN97HBJkPGlu5SRM41fyoJOr5lmnaZWIV6q1E=;
        b=Po96Nb2VBuMMYuWPsCYa1SkvYamOCmEkZr9FrqJ3oPvobeok5CNXzC/wUhV4d9ArdP
         ebjIE8rcLwHBciNGA9vSOwVJ9/hI52sPHUWL5dgPfK5cv2I9KHV14lk9d6iO2c4/MfOI
         X+za7fcM+S0cYxq4B5cn0N8i2VJLZ9qcLFtj4eeK2xFeH6zsgqnQ415zfsCTfO35sB2N
         tHpzS0HMU6JDtRn6uQ6lb6sca5ve5kJvOxDGa0EjmcwBFjmuA7jqMhoWNO7k3woC5OCZ
         wpD+wVFUm9fr+MqeCpoyOAbpnrac3efksEkjkWlbBrSZD5ob7iT0saSnYrfU1jRUkrpa
         8x/A==
X-Gm-Message-State: AOAM533BzlhlZOM7A1E89NO65jZp+avE8RUvMub3AMVw+z3ieiXjbiFA
        e3kgunlhfqm38T3oNxdYme6j0JjnoDvnQkk8KC0=
X-Google-Smtp-Source: ABdhPJzu4LBclfc9l/OFPNKTgSHjGeevtI42NW5B9fIJkxjJJT5AvKyaxf9lgQkipqNMK5xRqO7ZA23GUeVD3P8vE2g=
X-Received: by 2002:a19:4cc2:: with SMTP id z185mr14137818lfa.461.1618900271435;
 Mon, 19 Apr 2021 23:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <YHaIBvl6Mf7ztJB3@google.com> <22a0a383-0ae1-c7d1-75f7-7dfdfe5fb504@gmail.com>
 <87fszn48lh.fsf@evledraar.gmail.com> <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
 <87czuq4r4l.fsf@evledraar.gmail.com> <CAHGBnuMedez4SE-4-JwCcR8k=_FRtjgBdBSEJqshQnVceCvGug@mail.gmail.com>
 <YH4FaQRB/vWOI9aI@mit.edu>
In-Reply-To: <YH4FaQRB/vWOI9aI@mit.edu>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Tue, 20 Apr 2021 08:30:57 +0200
Message-ID: <CAHGBnuNrXrHUz9f8nWEdB0PoO0FeLsNpNOGgdiYmsmAD5LjTmg@mail.gmail.com>
Subject: Re: Pain points in Git's patch flow
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        patchwork@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 20, 2021 at 12:34 AM Theodore Ts'o <tytso@mit.edu> wrote:

> The primary reason why the kernel uses mailing lists is because code
> reviews are fundamentally *discussions*, and people are used to using
> inboxes.  Sure, you can have a gerrit server send e-mail notifications

[...]

> maintainers simply find e-mail reviews to simply be more *convenient*
> than using gerrit.  And over time, we've used other tools to track

That still sounds to me as if people are stuck to what they know.
Maintainers are "used to using inboxes'', and that's *why* they find
e-mail reviews to be convenient.

Of course, there's basically nothing wrong with sticking to a flow
that works. But I understood the start of this discussion as a sign
that you guys acknowledge that something does *not* work. At least not
when it comes to attracting new contributors.

> I'll note that the kernel folks have done this, starting with a 2019
> Kernel Summit talk at the Linux Plumbers Conference in Lisbon.  A
> description of the follow-up discussions from that talk can be found
> here:

I'm reading a lot about "maintainers" and "kernel developers" here.
But what I believe is important to accept is that Git is not only
about kernel development anymore. While I'm well aware of Git's
history, there are by far more people using Git than there are kernel
developers, and also by lines of code (or whatever "stupid" metric you
want to choose) the kernel is not the biggest project maintained in
Git. Maybe not even the most important one, but that's highly
subjective anyway. So asked in a heretic way, why should the opinion
of a kernel developer count more than the opinion of, say, an Eclipse
Foundation developer when it comes to Git workflow questions?

To me, that means if you want to make contributions to Git more
attractive to the Git community beyond the kernel, you need to stop
making incremental improvements to existing tools and start thinking
out of the box by looking at the tools that are most popular in that
"other side" of the community.

And, please don't take anything I've written as a try to talk you into
anything. But as the lead of a team who's day job it is to contribute
to various Open Source projects, I believe to have a good feeling
about what the pain points of developers are to start contributing.
I'm just trying to foster some appreciation for the thinking of the
"other side".

-- 
Sebastian Schuberth
