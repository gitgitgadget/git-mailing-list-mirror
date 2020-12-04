Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFA6C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E9522C9C
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgLDUCF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgLDUCF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:02:05 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211F4C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 12:01:25 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id h3so7489430oie.8
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t+Ka28n0bZhF0Q/gCzb5CELFJKKIs9G7JaSuOsQnIDk=;
        b=ffc9SVwNzYnEYSg0bamXpG6ty6f6bpAeJS7MrBKEJgTj3DK3twzxIPOnBnOyJFHiNO
         2kUGOP89HtLNfXQTqULU4nHWB5qLpV6bsrrmzR6grs4sHpc7CSRHpFyhltr8oaHVvw9c
         mAO+cAIDO9am9/41KOHil3p7BbnW2IqoqtmfaNNDqeXfLXqeScKID1RpVGdl7lLPPOuo
         yBuUuhUH4H6ZcK90EvHTbtIa87KT0Yt1Iz1Ti1fQ2FGSoqgLtFfiN6pBpoOT15AGhkel
         +rtEZEscy5ZG/GpHxhf0R74p7xvOTRtAQMyNeYDQogeikTv7rkTn3nwiduCzuk0diKDf
         vN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+Ka28n0bZhF0Q/gCzb5CELFJKKIs9G7JaSuOsQnIDk=;
        b=X7UszHL30kWFZFP7oxYtBp17VsD49wHRfl0eQ6SwMcpjeWw+gka9uwptUC35mLjukP
         BtWlAt/BTkYMLS5xYAAJwzy0/yW7fv2af3SyTD1DKlS8nyqMVSnWslGaKOOiuY0JaaX7
         +xejk+pb0TYG5MP02mWpNHSdEKUG2JNdhHg6BaVGxCv1uIQRKU5volJuCTQTQP4PWaH3
         tf0CYl3n79ujmhcLzZEoTNBrjf+9JmFIhIL3y2X+r3WWvwNgMwBZ8LTyAI8yH8TEhNqg
         9MqT5Mz1qGHwPucs7MBcEa8XzFNlfchJ8DmFacd0Eop9F3zX+fuaCHZqpvSLV/kHbHiL
         jK/A==
X-Gm-Message-State: AOAM532OiXQ9+pnObTbOiwxp9pKSPmP0Yhoxkg94SAQk7JY2oX01f1Ih
        KRbY6oYHPM1wP2TTztxsluyL8XWXuykiUdphA9c=
X-Google-Smtp-Source: ABdhPJyLBknKUZwJdpf/ctok1cZp86BvXbraWtn5shkvj0gZQwB73bOvP5AIpPGwlAHKYsnpM2qyuyi6nE4ishMn9Y8=
X-Received: by 2002:a54:4704:: with SMTP id k4mr4354729oik.39.1607112084307;
 Fri, 04 Dec 2020 12:01:24 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201108213838.4880-1-sorganov@gmail.com>
 <20201108213838.4880-25-sorganov@gmail.com> <CABPp-BGZO+7bRdCAGFdetOkmwyFnHxDPQ=SD4f6TSa9ZYGFn=A@mail.gmail.com>
 <877dpyhefj.fsf@osv.gnss.ru> <CABPp-BEyiLDZ5Ums1D5gL679EMmKXpqxWDF_xGT4scXLMkwseg@mail.gmail.com>
 <877dpxpjae.fsf@osv.gnss.ru> <CABPp-BH1ORV8XYzM1ESH8NibAb2B-OszqZ6r2xnU2pxvR5AZwQ@mail.gmail.com>
 <87o8j9ny22.fsf@osv.gnss.ru>
In-Reply-To: <87o8j9ny22.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Dec 2020 12:01:12 -0800
Message-ID: <CABPp-BGT9S5av=X0UyLUXziSYbEj75bG8VLsf9A4-GCSHOQ5ug@mail.gmail.com>
Subject: Re: [PATCH v1 24/27] doc/git-log: describe new --diff-merges options
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 11:58 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Fri, Dec 4, 2020 at 9:34 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> [...]
>
> >> >> To my excuse, I took this from git:5fbb4bc191 that has:
> >> >>
> >> >> +Note that unless one of `-c`, `--cc`, or `-m` is given, merge commits
> >> >> +will never show a diff, even if a diff format like `--patch` is
> >> >> +selected, nor will they match search options like `-S`. The exception is
> >> >> +when `--first-parent` is in use, in which merges are treated like normal
> >> >> +single-parent commits (this can be overridden by providing a
> >> >> +combined-diff option or with `--no-diff-merges`).
> >> >
> >> > Yeah, I can see where you're coming from, though the context change
> >> > feels like just enough different that the four words you added bother
> >> > me a bit more.  However, this existing wording does bother me now that
> >> > you highlight it.  Even though it's not something introduced by your
> >> > patch, I'd really like to drop "normal" here; I think it is prone to
> >> > cause confusion to users and as far as I can tell provides no useful
> >> > meaning for the sentence.  (There are multiple types of single-parent
> >> > commits?  What is an "unnormal" one?  How do I tell which kind I want?
> >> >  etc...).
> >>
> >> I see your point, but I won't change it in these series. I think that
> >> it'd be better if you change this yourself, independently.
> >
> > Sounds good; I'll submit it after your series merges to avoid any conflicts.
>
> Ooops! I actually did change this in the series, and now it reads:
>
>        Note that unless one of --diff-merges variants (including short
>        -m, -c, and --cc options) is explicitly given, merge commits will
>        not show a diff, even if a diff format like --patch is selected,
>        nor will they match search options like -S. The exception is when
>        --first-parent is in use, in which case
>        --diff-merges=first-parent is implied.
>
> that hopefully is OK with you.

Ah, together with the dropping of those four extra words on the
description of --diff-merges=first-parent, this seems great.  Thanks!
:-)
