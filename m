Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B9FC433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 23:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D16364E6C
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 23:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBHXxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 18:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhBHXxi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 18:53:38 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A97C061786
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 15:52:57 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id v193so12117188oie.8
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 15:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SNkOJoYbbwDCpNdPhN2hC2iId8++w27740jCz7+u2bw=;
        b=hcuiZuntLA06p+dDbNRggM1jELCBwj0JpVjFpZ0kevxQnt8AbpPxxFbJPB/XgLSN2B
         JYtS+5S/ITN0ck/GDj4xKsJ1Pu43/FfJDOYSvD4EZ3PMFxOI2NXaSxe43LKVign69Ptv
         DD9XVTubOXtmIR1jsxWLNOc1R7A3p8G0brkaw4b6IlRTXBnePX9mWRlbsjJPWc7S6MUO
         p2TCoeB9SYRibs3IuShRpek9aX7mHUtwToXdzz5M85BeBY7Ehli64lunb7Ftv/mP0z+O
         nRRM2MgZZxgYy62IBfTyr4AcNHQ2KSdf89hh+OQrXs4Rb6nnL5X6+xpP2O1zEj6K79pF
         ZAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SNkOJoYbbwDCpNdPhN2hC2iId8++w27740jCz7+u2bw=;
        b=c9l8OTKW9VOwF6JRzJG+C8zrk0sSFQgER50Icpfbzfuh9pkph/6yuWAH6saD9FMUD/
         fwbP0EokHcUp+9blL+e40O2fYMh0/xzJOcS/hZ5IqNsG9VMSjjgVsiYt7nUftiLHpZmR
         kZ+Lr5lr5Q/Ov3uzhvBCSq+GRoxAGIijuJu9Bv/gAOk/kTaYmo2sOu3NzE5/R5MTHULA
         +H7ITCryp89yCA8OJ6/KeSuD52XC3xIBiastJTByr0glIi/NJhZhKa8bpqEuPLq/Wcvv
         emdMPBldme17HU15XstRNWqfIwD8X19b5at57hgwklja8LY87irc6WxUnwmpWd7yqvUc
         uLXw==
X-Gm-Message-State: AOAM533qciaBRu4+UiB0lUEwfSG+KCpSuo+rCFXgbfiKanUmvm9z9pqd
        Czq7MP8lkmOddVOJ97OAnCY7JAC9bEsD2IbeqBsXVGRS8Xo=
X-Google-Smtp-Source: ABdhPJw0xFkO23LJyaSyF4One12/tFk6vqzJfHzccI+VSzct0/WoytN58OkzDXctMzxhtnkwuVD25laFfME8nx/4VQI=
X-Received: by 2002:aca:550e:: with SMTP id j14mr798255oib.31.1612828376893;
 Mon, 08 Feb 2021 15:52:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
 <1d941c35076e8d515c8ff7ef01d6b9d8c092aaa9.1612651937.git.gitgitgadget@gmail.com>
 <9fbed0f9-032e-3f99-8467-f8a9cfa2d8f1@gmail.com> <xmqqsg677j2u.fsf@gitster.c.googlers.com>
 <CABPp-BGAgi+ooq==ZY2tWif0--W4Cruz02GDvxueHe6GjQEAXQ@mail.gmail.com>
 <xmqq4kim7964.fsf@gitster.c.googlers.com> <CABPp-BH_DWEE-3M96e=PPNwDqeYPaax9s1kBDhS8a6GtxsW=Mg@mail.gmail.com>
 <xmqqzh0e2kib.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqzh0e2kib.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 8 Feb 2021 15:52:45 -0800
Message-ID: <CABPp-BE9dPYgTsrAKjjmPTfy-xY56ajg-1ZYPf7X97YR0T_n3Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] diffcore-rename: guide inexact rename detection based
 on basenames
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 8, 2021 at 3:43 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > I'm sorry, but I'm not following you.  As best I can tell, you seem to
> > be suggesting that if we were to use a higher similarity bar for
> > checking same-basename files, that such a difference would end up not
> > accelerating the diffcore-rename algorithm at all?
>
> No.  If we assume we use the minimum similarity threashold in the
> new middle step that consider only the files that were moved across
> directories without changing their names, and the last "full matrix"
> step sees a src that did *not* pair with a dst of the same name in a
> different directory surviving, we know that the pair would not be
> similar enough (because we are using the same "minimum similarity"
> in the middle step and the full matrix step) without comparing them
> again.  But if we used higher similarity in the middle step, the
> fact that such a src/dst pair surviving the middle step without
> producing a match only means that the pair was not similar enough
> with a raised bar used in the middle, and the full-matrix step need
> to consider the possibility that they may still be similar enough
> when using "minimum similarity" used for all the other pairs.
>
> And because I was assuming that requiring higher similarity in the
> middle step would be a prudent thing to do to avoid false matches
> that discard better matches elsewhere, my conclusion was that it
> would not be a useful optimization to do in the final full-matrix
> step to see if a pair is something that was a candidate in the
> middle step but did not match well enough (because the fact that the
> pair did not compare well enough with higher bar does not mean it
> would not compare well to pass the lower "minimum" bar).

Ah, gotcha!  Thanks for clarifying.  Yes, yet another reason to not
even try to avoid "redoing" the O(N) spanhash comparisons.
