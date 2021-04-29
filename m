Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5B7C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 17:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66AAF6144E
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 17:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240985AbhD2RZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 13:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240986AbhD2RZW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 13:25:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524CDC06138D
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 10:24:35 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x2so92869lff.10
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vpgm3R99zMtROh/LetPlbxtEZehY8qqsOeN6eMeO3f4=;
        b=JuD3gyTr7vahTFs5JT8UNmucpvtVpK55qkihrONPAyqitqh0dvDWmV6nEaHraEM6hl
         SA5qKRSFM7IIpQc6rRb4qEVByXS/vjrVZc9+HaaNVikr9pfLZbltNpbMkrq8585xFZiK
         hzW40hZ6kVBQGWEPHomy4ahY/x4X1sKV1dGZLX0sXtJvBJSoeJr/Mu8h/YgwGp00VhmT
         Ew4TNFnUdcaQQDD0Kq14JNtTzwuJVlIfLGSqjVo619FPn7HXN5QglP6UyfIDuvebj3oC
         7GU4nbqWS4pMPGTeKoH+EFOwr1GhKzExqpVB5CL0UaMLyr42BdTJsDMNPOlffWRsRrwQ
         Pv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vpgm3R99zMtROh/LetPlbxtEZehY8qqsOeN6eMeO3f4=;
        b=nnb9TBAFfEb1ZvdfSvnKxXg/2jvfT1JdvBxoXcNL03FhTl54oI4Q9DCFbkj2Bku4+o
         YJ3G2Q/SZAEVeQse++eU8coJ6WOu0Vzbw1r4KeQDBV9QLH1pElpKsGf2AIly8HsZ4zgl
         ZeAduE4UK4UQ2eAr8O0zucS2XDGHg4IkcBPnzvEEdJUF+siMehML3YrnsTvZKUoS1hDX
         a398b9VuDMdYrVXyznjIIwK3lzxy7JRz4p7x07aDJMiqevojdVa+R4LPuhVw6ILm4cLW
         AdZDFw0x8UWlW7sdYKWSK40Os5hP1Rs7CZH8hKSDJlXeTKysNQByT+uSY5kehsKuVaTt
         7WAg==
X-Gm-Message-State: AOAM530BhvvBx8tbWQhvZrDWXlLCQ/9uRzZZJD/vhZ80sBCnHc2HA1/3
        +bk8iUdqbx9W/5vjTTrc3r9IXlvMij8po2Jk/cE=
X-Google-Smtp-Source: ABdhPJzxrhiPxMu4O5Ck9M8r4hi23Zrj+blYi9hTi3OJwBwfcHnq+ipVsMh3MJ0fId1mQ8Q2T55n+pHebdqqGqC2Hs4=
X-Received: by 2002:a05:6512:228f:: with SMTP id f15mr446918lfu.42.1619717073851;
 Thu, 29 Apr 2021 10:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <xmqqwnsl93m3.fsf@gitster.g> <87im45clkp.fsf@osv.gnss.ru> <CAMMLpeS4pkP_xRw_qT3mCTP4hS3iLP9TwdDf8LV+3+an9aJ3Hw@mail.gmail.com>
 <87eeet9hhl.fsf@osv.gnss.ru>
In-Reply-To: <87eeet9hhl.fsf@osv.gnss.ru>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 29 Apr 2021 11:24:22 -0600
Message-ID: <CAMMLpeQE5zY2KAu7rA=kGBGh5xeNUK8CRMf4FxKd-BoMjZzLJA@mail.gmail.com>
Subject: Re: Why doesn't `git log -m` imply `-p`?
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 29, 2021 at 10:35 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > On Thu, Apr 29, 2021 at 6:38 AM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> As the final purpose of all this is to have -m as user-friendly short
> >> option, I'd incline to finally let it imply -p, as --diff-merges=m now
> >> covers another side of the coin.
> >>
> >> What do you think?
> >
> > I am 100% in favor of that proposal, and I can work on the code this
> > weekend.
>
> No need to bother. If we agree, I'll send a patch atop of my recent
> changes that make -m format configurable.

Great, thank you!

> Alternatively, we can add a configuration option, or let -m imply -p
> only when -m format is explicitly configured by the user.

Since the goal here is simple, easily understandable, and
user-friendly behavior, I think -m should imply -p all the time, or at
least imply -p by default. The less I have to explain to new Git
users, the better.

-Alex
