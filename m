Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1802C352A4
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 02:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25FF2082F
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 02:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg9A6j8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgBKCU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 21:20:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44509 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbgBKCU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 21:20:28 -0500
Received: by mail-ed1-f68.google.com with SMTP id g19so2818616eds.11
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 18:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7QU0Xalu1egPs7OxufX8RRg4g0mg1EtGmz4ULh3Zz+4=;
        b=eg9A6j8VrrICmSKJOAUpmKswfQeDwX35cRQ3sCg49jsfUqSEegsmo9RU1vFjXc5e55
         fW8gOj95AIfn5J+Qz2meA0Udg2kK4MVTjfVlf4D2yyH5x05csq+xqc1HppRyLNi+wx91
         1JEjXF/v/M6zAMp8w+aIWkI1DYX8w2q44amlk0uCoOJ7MisOIL3SL5/tXJaEnfHgBv+O
         99GDm2pjdLA5OyPI628YRuf/w5cboxS/Adw3Iydmt83T1oGPAwScYvcNPy9qbwegBiKS
         yi591lE72aVsC9A8hpKTcgqzeCN7HSQl4TzJFSp5kSyINogsQPCxLonX7nN+yZwAIMDO
         XlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7QU0Xalu1egPs7OxufX8RRg4g0mg1EtGmz4ULh3Zz+4=;
        b=lNW/9KDppYWZJGszbTEbT1MAz/50LFjB3ceGSk1jfEWkBHyVeln08dbJ/As7efXe7h
         eTiuVs2jpATosBC55six9mt5z3THVBXanisWKkiFGJTV3/6491wBI3cRAArLkgpPsWeH
         I7NMyV5XNc3ezZ037KfNsI7tiFosvTAX41o+mSs9aoHRpRo+nm3ZjehnQqW6scBJKJJk
         vCkbvoQkZZ4Y3zxRuTQYAV6WqocQH9NNgq7bNooFCyYiaT9ZGEnjZ7V0qwkwNDeFLpsJ
         c0bgkeV4LwAfoshHiCm1HszkuGwpjkK105K7enijyTnnLRo0Ag8U2T/Zkl6Uv1wAPKQU
         PMmw==
X-Gm-Message-State: APjAAAU2e3C7lOptvmzdABUD5UQImbSJntdJYh9T2PnjUZYoK3kwv3WV
        FiDq1V7XOMhkOMSi7nnGm50GXGAUkCeuZHNNHn8fyzly
X-Google-Smtp-Source: APXvYqya7d8yDXL2w3UJJJ99Lm87XCtrNIpYE3iHPU8X/wUyExK8//S1TrbFDkNN/+qwTWUpFbaLba3lxuAWZeVv2U4=
X-Received: by 2002:a17:907:375:: with SMTP id rs21mr3914827ejb.352.1581387626622;
 Mon, 10 Feb 2020 18:20:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com> <20200210203725.GA620581@coredump.intra.peff.net>
In-Reply-To: <20200210203725.GA620581@coredump.intra.peff.net>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Tue, 11 Feb 2020 15:20:15 +1300
Message-ID: <CACg5j276+BnuTe+1eMQTALPL-Ngfy=N5udyz=EQ++29=_2R9aQ@mail.gmail.com>
Subject: Re: [PATCH] advice: refactor advise API
To:     Jeff King <peff@peff.net>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 11, 2020 at 9:37 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Feb 10, 2020 at 05:04:09AM +0000, Heba Waly via GitGitGadget wrote:
>
> >     The advice API is currently a little bit confusing to call. quoting from
> >     [1]:
> >
> >     When introducing a new advice message, you would
> >
> >      * come up with advice.frotz configuration variable
> >
> >      * define and declare advice_frotz global variable that defaults to
> >        true
> >
> >      * sprinkle calls like this:
> >
> >       if (advice_frotz)
> >         advise(_("helpful message about frotz"));
> >
> >     A new approach was suggested in [1] which this patch is based upon.
>
> I agree that the current procedure is a bit painful, and I think this is
> a step in the right direction. But...
>
> >     After this patch the plan is to migrate the rest of the advise calls to
> >     advise_ng and then finally remove advise() and rename advise_ng() to
> >     advise()
>
> ...this step may not be possible, for a few reasons:
>
>   1. Some of the sites do more than just advise(). E.g., branch.c checks
>      the flag and calls both error() and advise().
>
>   2. Some callers may have to do work to generate the arguments. If I
>      have:
>
>        advise("advice.foo", "some data: %s", generate_data());
>
>      then we'll call generate_data() even if we'll throw away the result
>      in the end.
>
> Similarly, some users of advice_* variables do not call advise() at all
> (some call die(), some like builtin/rm.c stuff the result in a strbuf,
> and I don't even know what's going on with wt_status.hints. :)
>
> So I think you may need to phase it in a bit more, like:
>
>   a. introduce want_advice() which decides whether or not to show the
>      advice based on a config key. I'd also suggest making the "advice."
>      part of the key implicit, just to make life easier for the callers.
>

yes, I agree.

>   b. introduce advise_key() which uses want_advice() and advise() under
>      the hood to do what your advise_ng() is doing here.
>
>   c. convert simple patterns of:
>
>        if (advice_foo)
>           advise("bar");
>
>      into:
>
>        advise_key("foo", "bar");
>
>      and drop advice_foo where possible.
>
>   d. handle more complex cases one-by-one. For example, with something
>      like:
>
>        if (advice_foo)
>          die("bar");
>
>      we probably want:
>
>        if (want_advice("foo"))
>          die("bar");
>
>      instead. Using string literals is more accident-prone than
>      variables (because the compiler doesn't notice if we misspell them)
>      but I think is OK for cases where we just refer to the key once.
>      For others (e.g., advice_commit_before_merge has 13 mentions),
>      either keep the variable. Or alternatively make a wrapper like:
>
>        int want_advice_commit_before_merge(void)
>        {
>                return want_advice("commitbeforemerge");
>        }
>
>      if we want to drop the existing mechanism to load all of the
>      variables at the beginning.
>

All make sense to me, thanks for the feedback.

> -Peff

Heba
