Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB9DC4332F
	for <git@archiver.kernel.org>; Sat, 24 Dec 2022 22:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiLXWNo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Dec 2022 17:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiLXWNn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Dec 2022 17:13:43 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C596764A
        for <git@vger.kernel.org>; Sat, 24 Dec 2022 14:13:41 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id g4so8611981ybg.7
        for <git@vger.kernel.org>; Sat, 24 Dec 2022 14:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfzBv+21EnNngjyYHk2KTnWdpuGE95c0S/wZU1dkm0U=;
        b=Bslsvdjm0HACaRhqVfj8XUf+ugruo55mtXda2vsx/ZA0F81DY2o///2Gt3XVQgtNus
         sjTv6taG5NKQk4UTnp1HmZ4gvkuNwVx8zJIaKNe151rn9/XZMSjJ+8h3tpgqQLQJilQO
         YcsO7q3z15FNlz4K8JrRFPe03a1pdjXM8sTw1ALwxlf+sydpe479y4GIOJEnmtHpHOOr
         sSBO3uZBZDM3M9KZZKKcJmiWhPfpmjYFjIfxN11Gg9wGG0Hgd4wOnEvk5heEQZvRnV++
         q+kQiUHA3YY3ZKUHnS1Qk3+lXE/C1zoOvW+TCAx9sLOTpZ2eGm7d+cys8jhlJ0Dgk/am
         NvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfzBv+21EnNngjyYHk2KTnWdpuGE95c0S/wZU1dkm0U=;
        b=ERRsIu4QyfrTucHCaMbN4yLZBF4bCFi1AzgdjVN8WUn4OtYH0yHQxkNz3OhZ32WJU4
         0ZibiKuM22XybDJ8+dda207KzjjmRxHY0w5GJ7hXmYJLpnsVTuT7237Tz5AjoHBNCsOn
         GNK/zoKfRdx9qrayaZRd8azQZzHIgbMT1Fzw1z7GvC0jE4w7qJWYwCzKfQk13wN6hrm3
         xbijDGIuDE6YQXF2JbBFOzIH7gB/vWR4RrCKquPnnOLFpBOWBSWilU5IZ6K2exMpZsTN
         PWKeN5Zt5OM78tUqhPO6wVtiA3CT8YpFlO4KkzRxjnOBLtwZWXEqYjtvTHzxZXs8kXGo
         u/7w==
X-Gm-Message-State: AFqh2kqPzLMafllbEPx1QiPj5utOmt2iEvN6kVOZlGc/v98UJl+fAsYc
        tftDkjZGZ5wbMLWKSy1+8nKkTwNpW+aNsgZF4Uu4Aodr8s2t7g==
X-Google-Smtp-Source: AMrXdXucYvh26aFpIbtIn+iaFQYF+KWIDMcF0J+fUx4T8w1emp4ck3Ijp952WrP9Er4Uv9I/j9g8KQZEEU6VC84rrss=
X-Received: by 2002:a25:c50f:0:b0:6fc:b841:cf42 with SMTP id
 v15-20020a25c50f000000b006fcb841cf42mr1422030ybe.372.1671920020557; Sat, 24
 Dec 2022 14:13:40 -0800 (PST)
MIME-Version: 1.0
References: <CA+PPyiHtPsRwqMmr6annuuqzeUEf+7pFUSbnXdThjNNVtxFCGw@mail.gmail.com>
 <20221222192646.GF3411@szeder.dev> <CA+PPyiHtSrLwandGcjWxzZzfuwaxX_Cpa0h40HCLBekH1vSK7g@mail.gmail.com>
In-Reply-To: <CA+PPyiHtSrLwandGcjWxzZzfuwaxX_Cpa0h40HCLBekH1vSK7g@mail.gmail.com>
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Sun, 25 Dec 2022 01:13:29 +0300
Message-ID: <CA+PPyiH55E128M83v7qvCM3QT5vL97cuKbQSrKu7nO8w8P8JUA@mail.gmail.com>
Subject: Re: GitHub actions are failing
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > This should be fixed in 0178420b9c (github-actions: run gcc-8 on
> > ubuntu-20.04 image, 2022-11-25), which is in v2.39.0-rc1, but your
> > branch is based on v2.39.0-rc0.  I would suggest to rebase your branch
> > on top of v2.39.0, because it contains a few other CI fixes that are
> > not yet present in any of its prereleases.
>
> Thanks for the advice, how can I do this?

Oh, I have finally learned how to do it. just search around the internet.
And it solves the problems, Github Actions are no longer failing.

Best Regards
Wilberforce


On Sun, Dec 25, 2022 at 12:11 AM NSENGIYUMVA WILBERFORCE
<nsengiyumvawilberforce@gmail.com> wrote:
>
> > This should be fixed in 0178420b9c (github-actions: run gcc-8 on
> > ubuntu-20.04 image, 2022-11-25), which is in v2.39.0-rc1, but your
> > branch is based on v2.39.0-rc0.  I would suggest to rebase your branch
> > on top of v2.39.0, because it contains a few other CI fixes that are
> > not yet present in any of its prereleases.
>
> Thanks for the advice, how can I do this?
>
>
> On Thu, Dec 22, 2022 at 2:26 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
> >
> > On Thu, Dec 22, 2022 at 08:55:43PM +0300, NSENGIYUMVA WILBERFORCE wrote=
:
> > > Hi
> > > So I have been working in the signature atom patches. I have been
> > > testing my commits on my fork. However, the actions are failing.
> > > One of the errors is
> > >
> > > -------------
> > > E: Package 'gcc-8' has no installation candidate
> > > + end_group
> > > + test -n ''
> > > + return 0
> > > Error: Process completed with exit code 100.
> > > -------------
> > >
> > > I would like to have any help, my branch is
> > > https://github.com/nsengiyumva-wilberforce/git/commits/signature5
> >
> > This should be fixed in 0178420b9c (github-actions: run gcc-8 on
> > ubuntu-20.04 image, 2022-11-25), which is in v2.39.0-rc1, but your
> > branch is based on v2.39.0-rc0.  I would suggest to rebase your branch
> > on top of v2.39.0, because it contains a few other CI fixes that are
> > not yet present in any of its prereleases.
> >
