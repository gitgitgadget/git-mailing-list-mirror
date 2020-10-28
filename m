Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3ACC388F7
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3FF920878
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bakanov-su.20150623.gappssmtp.com header.i=@bakanov-su.20150623.gappssmtp.com header.b="IQo/dy9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgJ1WlO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388991AbgJ1Wjg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 18:39:36 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961D7C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:39:36 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id z6so564256qkz.4
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bakanov-su.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MYL5/prl4Sr3KuA+1b7ojUED0qSCFKuqHuTt3vM96HA=;
        b=IQo/dy9k8vqeAfH1z2XwwA5G3lhqnJVaJmyiv7q3Kc9GfhazdeK6YEgKnSJzv4tFbM
         AIIJOu0umqCndeUaMXV2h8lQ+iQohy3NPMww1TLV/TMognC/AmeOqFNnXTcm1p6/efLU
         XAXpK2e+3BOXquL6Z8nHcxC5a23bCfxIondI2u8Cv8yKksXe8tD5dP0m9kSa+wX/OFr8
         c4uyuF/ZT6+zmJN2hTQsplytshjRyXhYol2z8ptwjQUzq3GN7aBTZlGhXb+1SCm5lv1B
         8sa7BI1KRuNO8yjk/llejBMaFz1/Bp/i5zqqCZqvJN4BSvJQuvJ4AwRwqIuw9lxW4Wv/
         lVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYL5/prl4Sr3KuA+1b7ojUED0qSCFKuqHuTt3vM96HA=;
        b=KG2jlc5AAzcsSJFTJad8qOUwtCblVJ/FPUrR4F2exKkR0lDHxErqkSqHFxjhfMRADh
         iRuL2zGWN2ksTmOBlombIFevQOd9NeHmGDbmPEaSbYUlGlqDULJdKr5XlhG5/jk1PTaU
         wgxsAkWYu44Mzu8fzb5L93mf8AZtLbKEVYrfMa+6GCpYpi9i06TogugsCC6N0+OV7vQ9
         dpcLWSueTeVYzz3gMveURHUHvgL8wZCUkWJ6JGiebSRQvScESjo/Zcglew1O7t4dpNSI
         6+L/T1TnEE54dBAKXs2fywEp+8jUMKUb8YTSMWdP3w8D0D/s1kN2RZRG/U87agvCG+Fy
         PwTw==
X-Gm-Message-State: AOAM532IlIHEV/0U9x+46o/JcyqjdCu/7uxm4g5N5tx+M0ZWus5uxQ9f
        fbir/K2eE0qG+nzHTgL8YPITJR6S6Am0n3CS6QyIbx21zuAu5D9M
X-Google-Smtp-Source: ABdhPJw1U3cahIk8HcQGY8H99kM8zgRgCdu1xH4yngUDeCYLhtZAIWHNT5VnjC4yC1353kBiftelWzsSKBOZ+GOP3AQ=
X-Received: by 2002:a05:6638:1381:: with SMTP id w1mr6545296jad.79.1603887673544;
 Wed, 28 Oct 2020 05:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAAdniQ5pRHKUU77XVmZkZ_gUgfYYFpo9=Xt2T6EgzJ3hoT0YMg@mail.gmail.com>
 <3956141603887148@mail.yandex.ru>
In-Reply-To: <3956141603887148@mail.yandex.ru>
From:   Filipp Bakanov <filipp@bakanov.su>
Date:   Wed, 28 Oct 2020 15:21:02 +0300
Message-ID: <CAAdniQ5Mj0svFKeDPtDV9mNeFfHY+7vznn1EVN2DO6tb5Qe4Jw@mail.gmail.com>
Subject: Re: Proposal: "unadd" command / alias.
To:     Konstantin Tokarev <annulen@yandex.ru>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you, that solves the issue.

On Wed, 28 Oct 2020 at 15:13, Konstantin Tokarev <annulen@yandex.ru> wrote:
>
>
>
> 27.10.2020, 23:10, "Filipp Bakanov" <filipp@bakanov.su>:
> > Hi! I suggest to add "unadd" command, that will undo a git add command.
> >
> > git unadd path/to/file
> >
> > It will be an alias to:
> >
> > git reset HEAD -- path/to/file
>
> It can be done in shorter way: git reset path/to/file
>
> >
> > The motivation is that I always forget syntax and have to google each
> > time I want to undo accidentally added files. Unadd is just much
> > easier to remember and quite obvious.
>
>
> --
> Regards,
> Konstantin
