Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48C121F404
	for <e@80x24.org>; Mon, 13 Aug 2018 18:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbeHMVlB (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:41:01 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40774 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbeHMVlB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:41:01 -0400
Received: by mail-yw1-f68.google.com with SMTP id z143-v6so14348581ywa.7
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ROSaABYeZZTkhibAfCApFU4PsxrY6MWdW8fnNg3yavs=;
        b=e9TJXZY5R4vw1k5Sf4rvXqvIlsuzgS+cRy+iOv2KyGRdMigniIBJuEHJqv5CJls2mY
         t/AwsLNewN8zXDt0Uu1qvs8t/UTlepvOXnQVCT+F03zZXZrNxq9POI0cuEiR2qDGhw3G
         oQWHOuA2yp/agPcQ5oZVKnj9if1j6W49nUwDO+eoaGyG9Ks1jDm4Pz4I4jcWzm/+hPPE
         qW6nPohG4vV+X40fpMbEhVBz4wZKmd0cfPm8jmueg91yBUpyEY2GhEmGqkl0iPV+5ClE
         WR6BkfIMlA0XJnGEcyf/Ls5ZVHNrvfh0IAXD6n60LHutjnj48AH+E+Nj3b6bnVXgg8Oo
         /xkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ROSaABYeZZTkhibAfCApFU4PsxrY6MWdW8fnNg3yavs=;
        b=D6qXThXAA5hDz9aF2I9fXU3MSp12w7CfEGISAGFeTi02q/N7Y/25pKRE0/52yttmx4
         XEW+tSNw7ygdaO7oyYvbia5JADMvlphEp6X2/lTnnAnkDJOyp+fE7712gbQWnoEqAKVj
         ifYFaMVV+e35tf9l7GCBptAORmnkglw+AudKIC76ILH/VnDTTmU61zKYd7JnmCaq6WW8
         CGdOy19DTzMG2khXeN8D0i4jmSc4ZEqWlE4ybqSAcPMS3nntb1B32QZKCQWTJzaECjYD
         ME2jpppuwE4X5ouUAV+0fx06t0b7HZdMY+DVJASncyiJEUSvYz9GeUINGrVzM+cG6oj/
         l68A==
X-Gm-Message-State: AOUpUlGCfhN2VfMF2IXtC+2fjMHpTdaUCtnt5+IuU4aVkkKG61/mthxk
        EVc+/wSv8WIu4SY0fTvITwUmfPibbKevO1UFhTxhsg==
X-Google-Smtp-Source: AA+uWPzjX+pmRtYbmAcq7BXTBoDwi9fbpKZ0k39D7aSYcSatcmKwEXN7DsknTHzaKgsLl9TTwk59KWnvSHJNzMxqfMU=
X-Received: by 2002:a0d:c944:: with SMTP id l65-v6mr9990589ywd.414.1534186652168;
 Mon, 13 Aug 2018 11:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180810223441.30428-1-sbeller@google.com> <20180810223441.30428-9-sbeller@google.com>
 <nycvar.QRO.7.76.6.1808131429550.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1808131429550.71@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Aug 2018 11:57:20 -0700
Message-ID: <CAGZ79kZ=bs84WGeA5TbVUTbQL2ECUSwEJanMKmeWw+xKp-rH5Q@mail.gmail.com>
Subject: Re: [PATCH 8/8] diff.c: rewrite emit_line_0 more understandably
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 5:42 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Stefan,
>
> On Fri, 10 Aug 2018, Stefan Beller wrote:
>
> > emit_line_0 has no nested conditions, but puts out all its arguments
> > (if set) in order.
>
> Well, currently `emit_line_0()` *has* nested conditions: `first == '\n'`
> inside `len == 0`.
>
> And these nested conditions make things hard to read, so resolving that
> to a simpler workflow makes a ton of sense. You can sell that better by
> starting the commit message with something along the lines that you are
> making the overly complex logic easier to follow.
>
> > There is still a slight confusion with set and set_sign, but let's defer
> > that to a later patch.
>
> There is no later patch in this here patch series.

yup, I got overly excited when writing this commit message, as for
what we could try next.

> I would therefore
> appreciate it if you could spend the paragraph or two on explaining
> yourself here.

noted.

>
> > at "diff: add an internal option to dual-color diffs of diffs",
> > 2018-07-21), as there we broadened the meaning of 'first' to also
> > signal an early return.
>
> Did we? I thought we introduced the possibility of passing *just* a first
> character or *just* a "rest of the line". I might misremember, though.
>
> > The change in 'emit_line' makes sure that 'first' is never content, but
>
> <tongue-in-cheek>Awwww, you want to make 'first' sad all the time? That's
> not nice of you...</tongue-in-cheek>
>
> Seriously again, the adjective "content" has a different meaning than the
> noun and this ambiguity made this sentence very hard for me to parse.

So what is a good noun for the stuff that Git stores? ("stuff" is not a
good one)

> > always under our control, a sign or special character in the beginning
> > of the line (or 0, in which case we ignore it).
>
> It would be good to reword this paragraph to say that from now on, we will
> only pass a diff marker as `first`, or 0.

Makes sense.



> > +     if (!len && !first)
> > +             goto end_of_line;
> > +
> > +     if (reverse && want_color(o->use_color)) {
>
> Since you implied `reverse` to mean that a non-`NULL` `set` *as well as*
> `set_sign` were passed in, and since a non-`NULL` `set` *implies* that we
> want color, you could drop that `want_color(o->use_color)` here.
>
> But as I stated above, I am not a fan of having such unintuitive
> implications in the code.

okay. So we'd want to be explicit about reverse again?

> > +     fwrite(line, len, 1, file);
> > +     needs_reset |= len > 0;
>
> First of all, this should be a `||=`, not a `|=`.
>
> And then, this code is skipped by the `if (!len) goto end_of_line;` part
> above, so `len > 0` is *always* 1 at this point.
>
> But then, I wonder why we bother all that much. After all, we want to
> reset whenever we used color. So why not simply initialize
>
>         int need_reset = reverse || set_sign || set;
>
> and be done with it?

I just removed that line and all tests still pass. :/
I could have sworn of a failing test when writing the code
that ensures that content (noun), that contains color codes,
would still look okay by having a reset at the end of the line,
so really we'd need to have

  need_reset = reverse || set_sign || set || (len > 0);

I'll dig into this again.

Thanks,
Stefan
