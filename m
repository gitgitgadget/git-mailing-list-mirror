Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2777CC433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 23:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFCE8224B2
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 23:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbhAUXwu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 18:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbhAUXwq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 18:52:46 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAD6C06174A
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 15:52:06 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 3so4544690ljc.4
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 15:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qaVWomVH2c+sLH1z0vaO8bScftDtBHbLe9ZFD6wTNn4=;
        b=lYwYX1oX4/9f1rLKTK087m5FCUaNQUT1pDiaUjrIK4m7w05mf7hImIYk4JeaA1cMUE
         cU+4iuryc1wbAnSomj60+jw+6HmtjP0VgHkoLM66cDPTBaMI4+pVyr1I8IzFDsKl61LH
         G1kTtBaGtrWds/ME4hc3zoaWNw+UzXLZ/S4IXyBroznrSv9AGb3N1nxsRWgeHkcH6gB8
         cVbgcCzrXsTovDgJQ3ToLi5T/0SKGbL+19eHoALrLz0dxE/JVdt4Qs9JAfCBiqcMFGpd
         h3qjeLG/osPIjAuARUqtxxc06/weCJOiHOqU5E+5bYRmP6CM+0vZTbw9rX94Z0bYHB0o
         hm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qaVWomVH2c+sLH1z0vaO8bScftDtBHbLe9ZFD6wTNn4=;
        b=TWoukHI252a210dZi8viOwRv1aBt8cpUV7XoYGEa/EWMXJohE+gxI0TRWlKPQujFR9
         Ioes/rnmQp9bpWQ7/pfAjyRTjDw9afqRgHF93xB1hQaT0AIekJ0wltA+awobs7R+CZ/H
         Svt9fGwAHRWk5KmC2rBAQb4BvwfaRrGdrRcAlUl2HlS1ZiL52hNrRDUunutwXLelWn0U
         2oth8ZxFaAIJ6uSbdRxpbbU9eWKWTM/q7E6K94ERJaFlQ2ePqS7os6mBVTTdEohZlbVn
         1vHMM1jkSkcBYudbrVShRqeeGK1es+eDzYwJ7WLIaSizp3EBOSlzcnjALqsRZaTPlJw5
         nkig==
X-Gm-Message-State: AOAM530uFUnrZq6WUnQLCgzsHaI7PmrfJU+Vm8alHz5jBn37Q+D2xGO4
        pnQMaVXJpqGvTQIuiuXkGJlrT6mmzN6s1JYB/KM=
X-Google-Smtp-Source: ABdhPJwntNrs8ml6FBP5XlH4I1xCrRPMVrYqlDFdgLDdQcFMlXPPtwOhVbh8kVK2O6rKY1yAX2AE8NCJhY9m9Cyb7mU=
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr389026ljk.74.1611273124404;
 Thu, 21 Jan 2021 15:52:04 -0800 (PST)
MIME-Version: 1.0
References: <20210120044435.53509-1-alexhenrie24@gmail.com>
 <xmqqturbdxi2.fsf@gitster.c.googlers.com> <CAMMLpeQM7JCP0=TMqf0DxDCVJvkCGDEPSKN6vYTU_xc7+QaA1Q@mail.gmail.com>
 <xmqqo8hiaptn.fsf@gitster.c.googlers.com> <CAMMLpeQ5ga_e5-YeVuArYBrui+ps7HWzNjWNQgeJK3sEjo2zhA@mail.gmail.com>
 <YAoSIkCecZU98QD2@generichostname>
In-Reply-To: <YAoSIkCecZU98QD2@generichostname>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 21 Jan 2021 16:51:52 -0700
Message-ID: <CAMMLpeTDNLUz9UVnL3aVK=J7X50Sq8L-OVGaoEsT5AY6EQON-g@mail.gmail.com>
Subject: Re: [PATCH] rebase: add a config option for --no-fork-point
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 21, 2021 at 4:45 PM Denton Liu <liu.denton@gmail.com> wrote:
>
> On Thu, Jan 21, 2021 at 04:25:25PM -0700, Alex Henrie wrote:
> > I didn't see any fork-point tests in the current codebase, but I can
> > work on adding some. Do you want them in a separate patch (that would
> > make the most sense to me), or squashed into the rebase.forkPoint
> > patch?
>
> The fork-point tests should be in t3431.

Derp! For some reason I thought that t3431 only tested --fork-point
with an ambiguous refname and that the other tests were unrelated.
Maybe we should make copies of some of those tests that set
rebase.forkPoint instead of passing --fork-point or --no-fork-point on
the command line.

-Alex
