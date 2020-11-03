Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B03C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7660C206FB
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfFNoBsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgKCQq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 11:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbgKCQq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 11:46:28 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B933C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 08:46:28 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id 9so18995305oir.5
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 08:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZdvCRjvxp7rOjItxWmUTIAeNhU2S6HbBgJpLFmOpExQ=;
        b=OfFNoBsm7ZFHv7EV5p8cj+MSipZUW59cQfJyxrWRakBBVkoULL6OfqYlGgSMh5ceqU
         B8EyuQA0RZYhbZCpSgyuNlIo5a/KPB0kpHcqAa4T1B9VwFE9hHShPxjKHBc+bnOgox0u
         tKMZt/xUUuN73esUXrHTJYcGys6qkSF6UiuXEqjpYA7F8vcBDiR787gOWYhPxx+fVMJG
         E0W2t97pN1hb49xtLiRS+1JXGd+mv3kLs2uj0ZKmwA7hkQooftrKRzZN8fV8ArlwPVri
         /T7S8HsEkOs/IdIWeWsFSO1U6+uOmkrwvMe9b3L5hBVMsAYVIC0Q6x15dSBEbE8wpJ90
         OLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZdvCRjvxp7rOjItxWmUTIAeNhU2S6HbBgJpLFmOpExQ=;
        b=lpfMgXYEY+K0Ug+v8V/8X76IEWcWQh8kKpJdFVcIlRo8yeoiD/DD68J4+yGEP/FpLZ
         UgM6EJLzfCibvDuU9NYtgyTf5GKHWwQEgu8sT4I3asu8g8IzY4+AKiFsvOZiZy7ie8V5
         pMuBkERGHmUd+NX3MnFEkhkpUSuw/d7Vyt3evvmQBeLzFS5AxpGshkG8MZBdgCjV6mVv
         JTQNyr48tTxj65MW/XXRrpa8iYEmw1O182ueOLwc1mjXkGp5MxapxNowOwjNsY9UyWzT
         lZugKubig6eF1jb6LF2Jqkawe5XNSWLLttVtHotLlw9AA2RLnprfhRckxnH0MLF0FHtd
         rgRQ==
X-Gm-Message-State: AOAM533/RR6Q+NmvnTqY7izVSAGR5KnbEUBiEMK/vo3EQ+cmUUVp0j8K
        9/l9lVWzGdwe+lbb/uWB+dDP5nI0czNlPxJnpUK8jd0tj+c=
X-Google-Smtp-Source: ABdhPJyg+xrNi1mQsOV+QduRgr2M+XmVHtFxP4UGsG1yKGAstOFTh4n+k2o8nSK4ygkfaA1q5kt8GWpHzoBhQMy/29I=
X-Received: by 2002:a05:6808:17:: with SMTP id u23mr12802oic.31.1604421987615;
 Tue, 03 Nov 2020 08:46:27 -0800 (PST)
MIME-Version: 1.0
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com> <cc8d702f98f94fd9202d227d19be43a912467e84.1602549650.git.gitgitgadget@gmail.com>
 <20201030143906.GH3277724@coredump.intra.peff.net> <CABPp-BFyqTthyBmp5yt+iUniwTi+=y2QcBcmNnnCy=zvyi3Rbw@mail.gmail.com>
 <20201103162013.GE444466@coredump.intra.peff.net>
In-Reply-To: <20201103162013.GE444466@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Nov 2020 08:46:16 -0800
Message-ID: <CABPp-BGnjxk--2oAiKPmCdEiwYL4zE338dfpE+tz9SEk5j42Bw@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] strmap: add functions facilitating use as a
 string->int map
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 3, 2020 at 8:20 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Oct 30, 2020 at 10:28:51AM -0700, Elijah Newren wrote:
>
> > > You might want to mention that this _could_ be done as just accessors to
> > > strmap, but using a separate struct provides type safety against
> > > misusing pointers as integers or vice versa.
> >
> > If I just did it as accessors, it makes it harder for myself and
> > others to remember what my huge piles of strmaps in merge-ort do; I
> > found that it became easier to follow the code and remember what
> > things were doing when some were marked as strmap, some as strintmap,
> > and some as strset.
>
> Oh, I'm definitely on board with that argument. I was just suggesting
> you might want to put it in the commit message for posterity.
>
> > > > +/*
> > > > + * strintmap:
> > > > + *    A map of string -> int, typecasting the void* of strmap to an int.
> > >
> > > Are the size and signedness of an int flexible enough for all uses?
> >
> > If some users want signed values and others want unsigned, I'm not
> > sure how we can satisfy both.  Maybe make a struintmap?
>
> Right, that was sort of my question: do your users actually want it
> signed or not. Sounds like they do want it signed, and don't mind the
> loss of range.
>
> > Perhaps that could be added later if uses come up for it?  Some of my
> > uses need int, the rest of them wouldn't care about int vs unsigned.
>
> Yeah, if you don't have any callers which care, I'd definitely punt on
> it for now.
>
> > If someone does care about the full range of bits up to 64 on relevant
> > platforms, I guess I should make it strintptr_t_map.
>
> Yeah, that's what I was wondering. I suspect the use case for that is
> pretty narrow, though. If you really care about having a 64-bit value
> for some data, then you probably want it _everywhere_, not just on
> 64-bit platforms. I guess the exception would be if you're mapping into
> size_t's or something.
>
> I think my question was as much "did you think about range issues for
> your intended users" as "should we provide more range in this map type".
> And it sounds like you have thought about that, so I'm happy proceeding.
>
> > But besides the
> > egregiously ugly name, one advantage of int over intptr_t (or unsigned
> > over uintptr_t) is that you can use it in a printf easily:
> >    printf("Size: %d\n", strintmap_get(&foo, 0));
> > whereas if it strintmap_get() returns an intptr_t, then it's a royal
> > mess to attempt to portably use it without adding additional manual
> > casts.  Maybe I was just missing something obvious, but I couldn't
> > figure out the %d, %ld, %lld, PRIdMAX, etc. choices and get the
> > statement to compile on all platforms, so I'd always just cast to int
> > or unsigned at the time of calling printf.
>
> The right way is:
>
>   printf("Size: %"PRIdMAX", (intmax_t) your_intptr_t);

Ah, intmax_t; that's what I was missing.

> which will always do the right thing no matter the size (at the minor
> cost of passing a larger-than-necessary parameter, but if you're
> micro-optimizing then calling printf at all is probably already a
> problem).
>
> But yeah, in general using a real "int" is much more convenient and if
> there's no reason to avoid it for range problems, I think it's
> preferable.

Yep, I like the simplicity of "int", the signedness of "int" and it
has far more than enough range on all platforms (most my strintmaps
actually map to enum values, but my largest int usage is for counting
up to at most how many files are involved in rename detection.  Even
microsoft repos only have a number of files present in the repository
that registers in the low millions, and I'm only dealing with the
subset of those files involved in rename detection, which should be
much smaller).
