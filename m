Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7AAC433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 05:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbiBIFNk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 00:13:40 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377828AbiBIElh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 23:41:37 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0103AC061577
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 20:41:36 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id m11so2587763edi.13
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 20:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4opcKdcsP3O1kpm0JyZa2FNq7IwyoyAW9H1g0SCuK2g=;
        b=ZePdoPLImvQUJgxLv1nEq4us93RGTWmFiQHJ0EEC1FLzXU4JN+/nouRnE4q9Jg4ZZj
         ebdb/5wlXtb70+ofPi2SCMuMWU6KMNWFGqOuRo/GpNS7N2H6rOG+K87VzJqDakgdRM1F
         x7n9qZ2CuDlAZHim8taj/I5qfadql53QgvYFclDx2n7OqkQhq1MdK8LD/zvwfWTKr2Hj
         bpi3vezElDxHp1KmAgnlcKgvu+ADsHmQ5rg9uQKZBX2+63cJB3vRMODFroYC39RV6TGJ
         edo/LwcigoV3GxKWis+GTAtQZ29TKkZBZml+6EOp590VHiDGFFslicHyc/QfgXDgY/Me
         cdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4opcKdcsP3O1kpm0JyZa2FNq7IwyoyAW9H1g0SCuK2g=;
        b=GFEKxcqBmwMKCTAz9kiI9l4jUbDIw4jAPo1JduUCuLQqk6ESA5pb2CRKKUyfRRzFx6
         5uRTWIMhjLVEhAMjZbiFW/ZvwkgMgu+XdELlfO0S/1OeaBJAlTaTQ8D4Az3iIm0CIbXo
         bN/YC35UM2h+EModLRy3hh37kwq0SWqM8asqYW0Kqwv7M1YeLLih5H985B3AOuycF+1U
         qeOhQ6U85A81gEQ8CqUoX6Yzkv0v3e5C9v4RrEhtdJ9beV7k6Ux8wyzPRQB6zLelN6c6
         MHuxoamSp8pCQFF2eKYhSi93LKLZ9oT063iA+FuKkqfOMhb2IOrSkLQYDK/exfkrXpwG
         z+cA==
X-Gm-Message-State: AOAM53375UZOd8CczQ0Ll7HtH+CwMztNS0EKN72I6Ufgejoi9yyxsqmH
        fBuCE8REgxMt3HCuRTQ0EYBnIFxIE/bS9R+WfXM=
X-Google-Smtp-Source: ABdhPJypCa5eD/PNWvSOe79zfbeF4EWmIlzekQEvvh+XeI0Vmk5uBbhJiE++VnDeP8cExE0yVIlMB/+J9su1vI0s15E=
X-Received: by 2002:aa7:da84:: with SMTP id q4mr602194eds.380.1644381694280;
 Tue, 08 Feb 2022 20:41:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com> <CABPp-BHtki3WupjbeyoQu9Li0S0kQV5rXWC0RN8_Pt524iUZOw@mail.gmail.com>
In-Reply-To: <CABPp-BHtki3WupjbeyoQu9Li0S0kQV5rXWC0RN8_Pt524iUZOw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Feb 2022 20:41:23 -0800
Message-ID: <CABPp-BEyFmsqQiO8+1JRw3R=XFVOFNXxmEMphPhu-OXVwUxAXw@mail.gmail.com>
Subject: Re: [PATCH 00/11] Finish converting git bisect into a built-in
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 29, 2022 at 10:39 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Jan 28, 2022 at 3:08 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > After three GSoC/Outreachy students spent an incredible effort on this, it
> > is finally time to put a neat little bow on it.
> >
> > Johannes Schindelin (11):
> >   bisect run: fix the error message
> >   bisect--helper: retire the --no-log option
> >   bisect--helper: really retire --bisect-next-check
> >   bisect--helper: really retire `--bisect-autostart`
> >   bisect--helper: align the sub-command order with git-bisect.sh
> >   bisect--helper: make `--bisect-state` optional
> >   bisect: move even the option parsing to `bisect--helper`
> >   bisect--helper: using `--bisect-state` without an argument is a bug
> >   Turn `git bisect` into a full built-in.
> >   bisect: remove Cogito-related code
> >   bisect: no longer try to clean up left-over `.git/head-name` files
> >
> >  Makefile                               |   3 +-
> >  bisect.c                               |   3 -
> >  builtin.h                              |   2 +-
> >  builtin/{bisect--helper.c => bisect.c} | 201 ++++++++++---------------
> >  git-bisect.sh                          |  84 -----------
> >  git.c                                  |   2 +-
> >  t/t6030-bisect-porcelain.sh            |   1 -
> >  7 files changed, 84 insertions(+), 212 deletions(-)
> >  rename builtin/{bisect--helper.c => bisect.c} (87%)
> >  delete mode 100755 git-bisect.sh
>
> I read through the series and couldn't spot any problems.

I re-read the series, taking a closer look.  Spotted a few minor
things (and left some comments) but the series looks pretty good to
me.  I think Dscho's on vacation, so we'll resume the discussion when
he gets back.
