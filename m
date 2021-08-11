Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493BEC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 00:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A20C60EBC
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 00:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbhHKA6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 20:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhHKA6O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 20:58:14 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D080C061765
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 17:57:52 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id e9so446360vst.6
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 17:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20Dw7r+vhwiNLxLr/ht2U5bmOVl0b4pM8fhORleZpbc=;
        b=Pl5gqvopx5Oyv3tf7Mrr2kx7szI2R18C0Hc99uKN1mnaoBDS3RxFqNC3YumZ9jT6+b
         uq3LhkoF1kHj1apAXLyl8PIUYerEI9T3KNG3iGZHZN2BtzYG6AMYIvhhfsQSddULxZZ5
         ftfx/2IT4O1vZQXpzn8xHHrLjuQglP65Ycq6woO3g/Tl+sCu9Lb87RkSjKm5/oUsbdos
         5IdjGhlylbvYmOVy8LgvFy6eOn8EKGW48XmGql2B7hqYnELS81B0qYcyt3UoWhWmbfhV
         dOVZH0fQw4QCAPOaoqg9q16Ro4ewxSWXVZzyKS84Kl+WAFTEpMqrkcklNqrJQ6meL31J
         ySww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20Dw7r+vhwiNLxLr/ht2U5bmOVl0b4pM8fhORleZpbc=;
        b=WEXqdgqGM5tqcyjMuVjXGjpod2SJeVn3y5q+S0SndpcOoWagfY6CEmq9VyLQvfdtZN
         2uG/B6maRW+yKCBeTWTZ0/XbfNx2c+AfefvHKxY9Akux5V/7wqHXqZqIATYmKdEjBmF+
         FvMR9x+Evipxuf3obuNpRUoB3U3Q2w7/acr1ByFvSCC9tZcLkIl9hugIWcxO/j3zPwg4
         GFB28MYkcMpvKq4917VuAaiJn9ACj06Wep/BKm5BCVNEC3d165fiX7Xxh4Lrx3ngsBhB
         lY2vNIBc5oupqHQbklaERpEdrDb4NFfY8fHdlKN6UzPXoFm6My19pZ90EwzHENEhtASg
         Nyag==
X-Gm-Message-State: AOAM531TZTD9L/RxsiXYM/q50DqwxHA+eoIEW7YaKw1B/oHKoXccLZvA
        CBAsnl7ZUvwP/vxBExijL44QwxgzTBPUfcZVL84=
X-Google-Smtp-Source: ABdhPJwrNBCYiDOsq9ZQAJo7l6QwGjbvEy4tt6bsRfXxSUpQfbrFkeDLM1pwCn/VEfZ6jqVWPvVeUg4afSsCr2Zt9jI=
X-Received: by 2002:a05:6102:2421:: with SMTP id l1mr21673129vsi.53.1628643471292;
 Tue, 10 Aug 2021 17:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
 <20210809013833.58110-1-carenas@gmail.com> <xmqqtujyftzx.fsf@gitster.g>
 <YRIZsOaguDW0HaeI@carlos-mbp.lan> <0b973579-748e-ce2f-20aa-a967765cce83@web.de>
 <CAPUEspiWdGRQoBnpn_uwjkqV7ffMm+MkzbNVU1rZ6yCwkpmNaA@mail.gmail.com>
In-Reply-To: <CAPUEspiWdGRQoBnpn_uwjkqV7ffMm+MkzbNVU1rZ6yCwkpmNaA@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 10 Aug 2021 17:57:40 -0700
Message-ID: <CAPUEsphbV_wGKPZP4T6tSO+qe89xmGpcpPozq+pZkHhsoup2gg@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/3] pedantic errors in next
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        e@80x24.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 10, 2021 at 4:49 PM Carlo Arenas <carenas@gmail.com> wrote:
> FWIW hadn't been able to reproduce that issue
> you reported in t3301 even with an Apple M1 with macOS 11.5.1 (I use
> NO_GETTEXT=1 though, not sure that might be why)

but it seems to be reproducible in the 32bit linux job from CI[1] :

  git: notes.c:206: note_tree_remove: Assertion `GET_PTR_TYPE(entry)
== 0' failed.

Carlo

[1] https://github.com/carenas/git/runs/3295672049?check_suite_focus=true
