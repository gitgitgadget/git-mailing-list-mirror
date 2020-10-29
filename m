Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80585C2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 23:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A43420838
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 23:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIi96Yy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgJ2XbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 19:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgJ2XbA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 19:31:00 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531E2C0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 16:21:24 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id y17so4885683ilg.4
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 16:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=poQ4+d6Gw4yhFEl7+ZwnpXWXm1JcjzO6NTWBIwY2Xxc=;
        b=OIi96Yy8PyoD6m3kYbAzU0wZDHut+INE3Xe4L/poV7T8dZlWo0WlGdZOoVxuFlUAOr
         X9zpwfcolbAs9hM1NJjcp3LnhJ17RxV5mvqi9mKuiN+BY+SY3WO5Crf0wTJXEQYKTE76
         MfjBUOAVNnXn31o1zQSrMakoFmUxy0hQy2Urjc6VU5gSBJ8TvmZoX/mXrO0xb6F3Lpz2
         hbmjVSn9Vqy4A1PyesqYrulWyoC3ZhIHOm/uUjYOlGb1sfxKonzwOgYeJ28gBnJr0j4h
         JtyHrSAMBfOBIR/JopHdbWnENJ+sAYVh5QKFR5gNDjsZpfMdWWe82GpivGYnqEb3ty4X
         sKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=poQ4+d6Gw4yhFEl7+ZwnpXWXm1JcjzO6NTWBIwY2Xxc=;
        b=XHgTfQ9Y58szpJiWdz0GdCXC2zIwuy/gunD/VBerTouwfQJNA7YdeylWIXWkioshgy
         fGmyz8cjS/ieiKRUBewGqJbyGM48sMZfMC8ZqEhm8DBawrhEqCiPqiE5c7s7mO8EW7Ph
         3l3C9OjQGjLf1Gx5b3PWUBgMRM6skd9aDJkpO28Et/SIxacoJbioztd5/LGgAiq/rLif
         zWvkxt3jf5IKgmRlaY924ZYhxy5X1J25ng8U7nmNnsBst1dKJpuYnHY1rLQ/ldd+0JGh
         As55lWygRXXLuwIn+yfZVdCXUSswdilO/eh3BmKG4f7s+upG3ET6WdTkGISBRg5d3aft
         rndA==
X-Gm-Message-State: AOAM533waTgxtEtYUqqekd4ZRl9V//FPXioqifI3xeB9DdXqUGSDD7zh
        441JsbavBuFEv/ykB9zJwc76S11x95p/OaebZ9emd7P/VqJkqg==
X-Google-Smtp-Source: ABdhPJwluJGnaTt1Ba1BlU0lHGIONqIaRAMQ9BCtRhwBoAyZuHOR4ZAC0s+Ol25QPC1zLBAvBxCKM9SChwqeUNiyG44=
X-Received: by 2002:a92:9907:: with SMTP id p7mr5358985ili.200.1604013683655;
 Thu, 29 Oct 2020 16:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <619dac64-106c-d6df-b121-ce6589b4af3a@xiplink.com>
 <20201029204149.20232-1-serg.partizan@gmail.com> <b85e0713-81d6-fcf2-6292-1b5acf86650a@xiplink.com>
In-Reply-To: <b85e0713-81d6-fcf2-6292-1b5acf86650a@xiplink.com>
From:   partizan <serg.partizan@gmail.com>
Date:   Fri, 30 Oct 2020 01:21:12 +0200
Message-ID: <CAJihB3K_Gnz-y-=2wriak-7cjPAv_Zi-j96T=iaCgnQBxBNvuw@mail.gmail.com>
Subject: Re: git-gui: Why are the main panels no longer white?
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 29, 2020 at 11:58 PM Marc Branchaud <marcnarc@xiplink.com> wrote:
> > I will check it on kubuntu later.
> >
> > Can you show your `xrdb -query`?
>
> *Box.background:        #d6d2d0
> *Box.foreground:        #221f1e
> ...

This massive list of options could be the problem.

>  Thanks.  Seems to be /usr/share/tcltk/tk8.6/ttk on my box.
> Nothing in that directory sets that greyish color (#d6d2d0).

But many options in `xrdb -query` is setting that color, and this is the reason.
And that's exactly some KDE-theming-TK-apps thing.

I tried to install Kubuntu 10.04, and in gnome-boxes it could not
configure the network.
Luckily 18.04 has the same big list of options in `xrdb -query` and I
was able to reproduce the issue.

I traced source of the problem:

> *background:    #d6d2d0

But if you change this, many backgrounds change color.

Now we need to find right *something*background to set that panel
colors. I'll continue search tomorrow.
