Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7119C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 15:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91EC613AE
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 15:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhFJPoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 11:44:18 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:42597 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhFJPoS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 11:44:18 -0400
Received: by mail-ot1-f50.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so90997oth.9
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6VFNZ+QT+RYo3WmF5zOM3AIBvOLEWYR5TV82+CyDEt0=;
        b=mnrcvKvtsVgDVJLZdYkG7Q6F+FRVRk7S76pRsV6A7d6JO2RQjMuK62HtKxGI0IF9rH
         ZIMxF3SKXaknzZZe7TWyvbgoHv1QJLF0k+YfJ6JKJujy6FI7HVSbiW9V6okAc0iaQ0sc
         xAylhPHo6CzV+MWZ7V+P40aAyXPsDlCWofT4wXw2XM2VAQS1l1npGXWAES66E0agLCE2
         I2Z21DKUMY1Hqg8dmfgjx1+qz3xr3N9GhtKi8T45wFPPIPb2Hysd9/qVkNikspEezm0t
         3WggQqpaUUJ2W6m9zu1M0huQlT579LIseD3IGryH9lTZgOQVlF6Vl74iQ328vOgHVH0K
         EzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6VFNZ+QT+RYo3WmF5zOM3AIBvOLEWYR5TV82+CyDEt0=;
        b=nZYcDzYAMxW32Qsw0dRbS+/ZBuc1wnlE3SMQ8nVC3mRA7EwstQ96f0qMdYwr3ff9Mx
         sIij+QD4bHkFtwFJ9FBewWaNFowYndghqTEZg70Jpqv7cFwS9o0BzHuv/+oJZkrdzUat
         1kwAKPizSr/sNjwKLeoQIQI5opUFGfDifwoF9RRrqlwnT+gZD6N9qrdd3GMaFvzTGa6w
         1K1Q4TiMVwsNY06pSEqoXg0mxdHlPDZjh2veCt8mYp/hTSvBx1QRLOnoTAaU6AeZIPsN
         NxeYFsKlZiTAMwfvU0HGHmRW10m2TDLBIbioFnG0JEHxYNYTBzgSCC0TsmCIA/+8D2Qt
         Dtqw==
X-Gm-Message-State: AOAM532ky2zGthc87AGtuP39qwDxCmE/YWL4K4na87BwQO664LFUVjnA
        YYmksLwmMh/V1ypo/faROWh/KwrMVQ9U5fi2hVU=
X-Google-Smtp-Source: ABdhPJzpdKLrZX6dvI8PVa/YYpQ2cqUHU2aitC86YzLIf7EAYu1OsApa5htNcn2GhbjveNkdgNqy9ldqCM2RN+PDwrs=
X-Received: by 2002:a9d:426:: with SMTP id 35mr1908482otc.162.1623339664979;
 Thu, 10 Jun 2021 08:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.977.git.1623313765122.gitgitgadget@gmail.com>
 <877dj22fly.fsf@evledraar.gmail.com> <1554066605.61418500.1623333784687.JavaMail.zimbra@matthieu-moy.fr>
In-Reply-To: <1554066605.61418500.1623333784687.JavaMail.zimbra@matthieu-moy.fr>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 10 Jun 2021 08:40:53 -0700
Message-ID: <CABPp-BEQs=n2YhZGVNvLAUVedO1rnWaM=DXYMvVwqDnst3s-sQ@mail.gmail.com>
Subject: Re: [PATCH] multimail: stop shipping a copy
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 10, 2021 at 7:03 AM Matthieu Moy <git@matthieu-moy.fr> wrote:
>
> "=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason" <avarab@gmail.com>:
>
> > On Thu, Jun 10 2021, Johannes Schindelin via GitGitGadget wrote:
> >
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > > The multimail project is developed independently and has its own proj=
ect
> > > page. Traditionally, we shipped a copy in contrib/.
> >
> > > However, such a copy is prone to become stale, and users are much bet=
ter
> > > served to be directed to the actual project instead.
> >
> > Let's CC its maintainer / other people who've actively contributed to
> > it. I've taken the liberty to do that.
>
> Thanks.

I only authored ~2% of the commits in git-multimail, compared to
Matthieu's ~55% and Michael's ~32%.  So I'm not sure my opinion should
matter, even if I had a strong opinion.

And I don't have a strong opinion.  git-multimail was awesome and very
helpful for a few years, but it did everything I needed as of 2015 and
I didn't really contribute further because it was perfect for my needs
by that point.  (Well, okay, I did apparently contribute 563c41ed05ae
(Ficks a phew simpul speling erors., 2019-11-04) after 2015, but those
were just typo fixes in comments, not particularly important.)

Also, back when I did use it, I always used the version from upstream
rather than the copy from git.

> > Having written a system in the past that made use of git-multimail.py
> > (and sourced it from git.git's copy) I'd think a better direction would
> > be to keep this and modify githooks(5) to actively recommend it over th=
e
> > older and less featureful post-receive-email script.

Recommending git-multimail over the existing post-receive-email script
makes a lot of sense; git-multimail is much, much better.

> I'm all for recommending it in githooks, but this can be done by pointing
> to GitHub's URL instead of a local path. Actually the sample script could
> look like
>
> # Fetch git-multimail.py from https://github.com/git-multimail/git-multim=
ail/
> # adapt and uncomment the following line:
> #exec /path/to/git_multimail.py

This seems like a good idea.
