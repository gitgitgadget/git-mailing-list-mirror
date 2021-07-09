Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2292EC07E96
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 01:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE0A361461
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 01:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhGIBTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 21:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhGIBTl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 21:19:41 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C954C061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 18:16:58 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so7771764otp.8
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 18:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/a1s4xWNPA7bTdY4rgzOM5f/luhR+jiVsaC6E0U56M=;
        b=GV6HIqEBwSdLwhI8og4FijE6wcH9CAspckj/H0L82D2UElv7OdnHepPy/v3dRzUdLx
         C7DSB7TPXTk4lMfpdJwpiUSQ02uKP1RVVUmeT/dox0A8TTZTnM2Zt3jDifm837BeMFUO
         Cd5M+7FOlG36qXsYNjXLS+FjPwtgDlEdGlnaMXxQZaS4FYzUVQ8gbYV+3+oDsTttFgG0
         2a/Np8dvMFA1dexJR/LvPaoigHyv0UkiRJeSPIBzx7HWud7CLPciu/rQWXtyS6OuvitL
         NtWJLVyDDmg/CYnF6kV5jv6fpVPasuGkP1dpFfgWD0xzSN2nce/sfXh2BaoSdBY3i9QS
         GXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/a1s4xWNPA7bTdY4rgzOM5f/luhR+jiVsaC6E0U56M=;
        b=orsDiNvAllJgMoyjMvqm40yuMS1LDg2gMJ/9jJb+qg8oQb55fl8xbVYFcGy3m+/9/v
         aguiAduA47JUgpoHpbfbXhz0kEPfIapHv6CRXiUb4XggDtn864S2cyqwu3rANqiqBoTB
         TfRrDOONh9nHyyYN5tdHRMBIDx+YPDdBmFd+t/Bim7J4WQP0+Wau9sI5GozgXudb9U7a
         cAjSeLJglDwvqQQvC0iU7gIyTt8vrZsA5AsMB+iiq3k17TWY3zmL4OOLAAJB1HsTaIk7
         FCmdQIjg37sIRFqg+sA5tRzln9KiiEO/WVNUT29fB8o6vQhaxfkEzGsjww2S04krjdIm
         0m9w==
X-Gm-Message-State: AOAM532ZC+fh2N6kJOQvEqchD1srWu/4EdbNeVZuYWgAl5zOPN8MENhx
        io/1GcHjAxOETB2Txf5WsiqKo5gEXWzjaFfBEoE=
X-Google-Smtp-Source: ABdhPJyivG2RIMqyP8JyWuHIaDy7mWaeNyxirCBQuEzmbPuf3csDzBtdJOcRAu/n9c5ylmcKMH0fXla4BzWCpxgrPJM=
X-Received: by 2002:a9d:6d03:: with SMTP id o3mr23248708otp.316.1625793417772;
 Thu, 08 Jul 2021 18:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
 <pull.932.v7.git.1624932293.gitgitgadget@gmail.com> <CABPp-BHqoJjF9f6NKZ8jjQdj1bgUNgrwek5jcnGTRk2m-m8dBg@mail.gmail.com>
In-Reply-To: <CABPp-BHqoJjF9f6NKZ8jjQdj1bgUNgrwek5jcnGTRk2m-m8dBg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 8 Jul 2021 18:16:46 -0700
Message-ID: <CABPp-BF2BLQm6864m+esquJ7og3fWHvTZeX_R-y4pnx9ApZ6XA@mail.gmail.com>
Subject: Re: [PATCH v7 00/16] Sparse-index: integrate with status
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 30, 2021 at 7:32 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Jun 28, 2021 at 7:04 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > This is the first "payoff" series in the sparse-index work. It makes 'git
> > status' very fast when a sparse-index is enabled on a repository with
> > cone-mode sparse-checkout (and a small populated set).
> >
...
> > Because the range-diff is a big difficult to read this time, I'll break the
> > changes down on a patch-by-patch basis.

Thanks for doing this; it was helpful.

> This is SUPER exciting.  I've only read the cover letter, but it
> strongly suggests you've not only handled all my feedback in previous
> rounds, but got things pretty solidly nailed away.  I'll try to make
> some time to go over it all soon.

You have indeed addressed nearly all my feedback in previous rounds,
and I found few problems with all the new code in this round.
Overall, this round is looking really good, though there are a couple
things I called out in comments on individual patches that I'll
summarize here:

Patch 9: a few minor suggestions for improving comments

Patch 10: the new code is never triggered and probably should either
be dropped or made part of a later series if the later series needs
it.  Also, although it doesn't necessarily need to hold up this
series, I found a bug affecting sparse-checkouts with or without
sparse-index while trying to understand this patch.

Patch 12: the code was slightly confusing to me, but I found that
there seems to be an invariant it is based upon.  Adding an assert
with a comment or just a comment about this invariant might help make
the code more readable.

Patch 15: since the new tests in t1092 are written to compare
sparse-checkout and sparse-index, it seems we should investigate a bug
where the testsuite commands we invoke are giving incorrect behavior
in both sparse-checkout and sparse-index.
