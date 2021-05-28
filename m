Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFEDC4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 21:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B2076100B
	for <git@archiver.kernel.org>; Fri, 28 May 2021 21:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhE1VTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 17:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhE1VTk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 17:19:40 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A32C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 14:18:05 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id b25so5624060oic.0
        for <git@vger.kernel.org>; Fri, 28 May 2021 14:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u8DWX0l/1daHmdFrBEZSSv9TkI2wH9AbwYQLPNPWphY=;
        b=ua7CBmyFKvWZ1DUgt6yzmBW9v68PmKaKKFiT2BTyExbJF4IGBzw2ImGqLAGpAUhYhm
         amQRzCMVpXUzzSq9ERjnJ3LUOSB+GfcpIsGb5/7leiQI/gyQPl+YrhHy25sC+ldTV3AV
         uYrFdg0m4JAfVlBUDIygdVbnqmFFy1MI1trydqzyH5skmEIrnsoZbAtFGm4i6oN5Ksr4
         belAnYLikCyg3/zZ3tiw4FX2FI/QWSePm0ENRizUeVqjHB3t2A0b4VpjNboDeMpp5mM4
         Ff458x0lIMgp1e8GkrmAFN3I8AViNkh1RZGY9s3lYw5WrtDFNpOuT3DaVod2LJUqKmZ1
         tsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8DWX0l/1daHmdFrBEZSSv9TkI2wH9AbwYQLPNPWphY=;
        b=lQSjRbiY/YYAq64Zoo54HXs7w9S2IJSevih0OgstIBTWSuTLL32JwLRa1yhy6Glj1K
         yKCKo2tTMMc99ddfaernTvwjOL1qZ2/qVObi+Od9IHHR6Hl7kJxR+w/WadSFWWf/IXVN
         9Ujsjc21avsDlDcyhIGvwpCQamqryKAU2mQUt9Mp+KkPYaPtM/vsgFOBF/Ao8ReJXuKU
         mnpy/HkosaAi4+iFXVcaEoEV3WJfGc+e2jkAvGkuonHwxX6F7ZKvRpe8DLnnmnI+WWTm
         HbZednVodVq2j+XWV46sOwJw2Cq0zF+yIDAcpUW7v5q1X0PWYyAAtb5YiTKeiHWLIoJ9
         EjvQ==
X-Gm-Message-State: AOAM531hUoDQ+r6Kd2Xy7fZ5BehLTlphyp0nbCISpM/C0+ceUDXH8hau
        r4kgaaeZ1d943+fG7zzog6Wg4J81YZBH+S4vYFg=
X-Google-Smtp-Source: ABdhPJxdBs8CRrkK+rv6iSLNLuhVNhK9nQR0QMpJy/s9H2TqGBrHWYi0fEEHw0gg462xPgmso8uysIOFcNQoYl5O3bE=
X-Received: by 2002:aca:4bd8:: with SMTP id y207mr10525732oia.39.1622236684936;
 Fri, 28 May 2021 14:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210528201014.2175179-1-felipe.contreras@gmail.com>
In-Reply-To: <20210528201014.2175179-1-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 May 2021 14:17:54 -0700
Message-ID: <CABPp-BGEtJqorUeQ4evWdmCvb=zsnkAdOn-ToG48=AYp3aUwNg@mail.gmail.com>
Subject: Re: [PATCH 00/11] Unconvolutize push.default=simple
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 28, 2021 at 1:10 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:

Is "Unconvolutize" a convoluted synonym of simplify, untwist, or
perhaps deconvolute?  ;-)

> Tired of jumping through hoops trying to understand what the "simple"
> mode does, I decided to reorganize it up for good so it's crystal
> clear.
>
> There are no functional changes.

A couple tweaks to some commit messages would make it easier to verify
that you have introduced no functional changes (at least for reviewers
like me who aren't that familiar with this code area).

> Basically the simple mode pushes the current branch with the same name
> on the remote.
>
> Except... when there's no upstream branch configured with the same name.
>
> Now the code and the documentation are clear.

I've read through the series and agree they do as you say.  The code
and documentation changes look good to me.

> This has the additional advantage of making `current` based on `simple`,
> rather than the other way around; `current` is basically `simple`
> but assuming we are never in a centralized workflow.
>
> Felipe Contreras (11):
>   push: hedge code of default=simple
>   push: move code to setup_push_simple()
>   push: reorganize setup_push_simple()
>   push: simplify setup_push_simple()
>   push: remove unused code in setup_push_upstream()
>   push: merge current and simple
>   push: remove redundant check
>   push: fix Yoda condition
>   push: remove trivial function
>   push: flip !triangular for centralized
>   doc: push: explain default=simple correctly
>
>  Documentation/config/push.txt | 13 +++++-----
>  builtin/push.c                | 47 +++++++++++++++++++----------------
>  2 files changed, 31 insertions(+), 29 deletions(-)
>
> --
> 2.32.0.rc0
