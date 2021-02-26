Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E48C433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 19:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 821E564F27
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 19:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBZT3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 14:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhBZT3H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 14:29:07 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E688DC061574
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 11:28:26 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 40so1720140otu.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 11:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gumUcmq/38FA3+Ax8voNtCoR+RD3xyylUq06QxcqAkw=;
        b=Ay1cOrql8hkw02YnIhl4jfvEEHZzg4+KUS2bw4NOR9zjHOYJYo7BrktrGVacsTu4mU
         vGjPV9DPN5Im88m9edeNKlOykwhSJ+cXsuFfOg696XwcmMP0oDpU/5yYMRL8oH8jNmeI
         3bne83agF1bfytbVw6dL3fyds103e3uQEefTfFaak0Z8P7zT+38Kb/7ZHUxWJHPx5EfG
         ZnNmS7mOQGjptqE2H6Qp8gC2w1wvYDMSJmxEMzueJlwPQiQqMVwsKgflKtj0l62YbdWc
         AIv9TG20Y1/LYPv4p/8Z73je/hkEozsMCEVKZt02GUrHH5ZV6sEXrBjsikb+Z+XgTzJN
         f/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gumUcmq/38FA3+Ax8voNtCoR+RD3xyylUq06QxcqAkw=;
        b=XF2Ca+xz6ikTPE6xtTqTvbnH7wGEJTdqclZOrlaXiuUP5s2iq3ZvGHXbeuoGBtUIc3
         wP44Tcpo9vuKPHpEgQEBMFLf3/Nj/lnsui8hcBltvGtD1dDE9GOISI2Bdg4RHaL1o30F
         w4E2pSrq4GVLz3znV8LQzFGakEVVwLS9SYmN7rVTw5Z969GG/+fGXuNepoVOD3DUO44D
         r1aYDeJP/eqTgk7a9fr4rG7Vl74yVZSEYFsFGCVLYN4M0p2Cp4jOBFEL5l85VcpJ+nD7
         WnAdECcCiJdnAp8ESotc6Sdd3hSuTkqhYpLSzkljGBtotvVIRtPs7Pebz2sE16GCUVRL
         eSIg==
X-Gm-Message-State: AOAM5338ZmC8Ga3wx6iyzIWIkSzYcpxTqNmguDNZB/IPtlk+m+xBTxRb
        +w/7Z074cVKZx3S+hTo9KMSxS7VsGklYJ697chM=
X-Google-Smtp-Source: ABdhPJwVQe0zKOUvhE/Oh6RWRFBgJKVnuwb6XLdrObbdqxG5nKPDy23PaTFPeQFI3bVgF6TU9UCC6vqNvA5VQAI24j4=
X-Received: by 2002:a9d:7459:: with SMTP id p25mr3550685otk.316.1614367706382;
 Fri, 26 Feb 2021 11:28:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
 <pull.844.v3.git.1614304699.gitgitgadget@gmail.com> <8efa1f5e-b072-abe3-9ad0-c1535d7a8b14@gmail.com>
In-Reply-To: <8efa1f5e-b072-abe3-9ad0-c1535d7a8b14@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Feb 2021 11:28:15 -0800
Message-ID: <CABPp-BHEF3YKLEDzccph_J53vjqKja_Z-0tMPif3jZFQJdU5cw@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Optimization batch 8: use file basenames even more
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 26, 2021 at 8:34 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 2/25/2021 8:58 PM, Elijah Newren via GitGitGadget wrote:
> > This series depends on en/diffcore-rename (a concatenation of what I wa=
s
> > calling ort-perf-batch-6 and ort-perf-batch-7).
> >
> > Changes since v2:
> >
> >  * Rearrange the patches in the series to have a top-down ordering rath=
er
> >    than bottom-up -- as suggested by Stolee, =C3=86var, and Junio
> >  * Several comments and style improvements suggested by Stolee
> >  * Replace xstrfmt() with a few strbuf_add*() calls, as suggested by St=
olee

Oh, and I also forgot to mention that I applied =C3=86var's suggested
cleanup -- return-in-if-block-to-avoid-indented-else.

>  I like the new layout. The code looks good. The only nit I have is that
> some of the old commit messages read awkwardly with the new ordering.

Doh, I fixed some of those up, but apparently missed some.  I'll clean
those up too.

> These are not critical, so this version gets my:
>
> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks, I'll include that in my reroll with the cleaned up commit messages.
