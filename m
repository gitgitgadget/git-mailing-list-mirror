Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,
	NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A35C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFB020708
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 17:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lufia-org.20150623.gappssmtp.com header.i=@lufia-org.20150623.gappssmtp.com header.b="JZwI4EVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgHNR3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgHNR3H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 13:29:07 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEA2C061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 10:29:07 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m71so4883396pfd.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 10:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lufia-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pVFrv5+NU/VOWJgvj22KToIYc9vJGwQZQtOjCvULofs=;
        b=JZwI4EVax8iYO1+yCm+NJjky/mn0ecfFNNTUg5oIpFGlmrl7TETSfv4vLdrb0ahXU2
         8lf+9BQQlOXXCP5XVQW7tkLO1/syVvztPWOJfgK8zKKe/LHGGVv/TXwePhvhLN4UyTNi
         nMzUMOGQ/GK7QznGQMOsnZfu1guy+b+1K0KOr3XlmpSxWO9KX4ya4emC3S1QTHxzQEXr
         AtcUAjUmyiX8EQkwm60365kysPX0ULMq+6QfFOHNQLv9ukDiqCzUWIQyCemPrBHdoDdW
         kvJyG7PXFKk04re5r/vOwmK6SBnvo3bGd8iBNnZopG4QfBkiXfq9o3di8aPqG30Cffqz
         MMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pVFrv5+NU/VOWJgvj22KToIYc9vJGwQZQtOjCvULofs=;
        b=gfCmX9qXKqMN9jjMqn9XwF54YGs2AWlmyeEbu33gSWtZXUo8dgP7c4lOyxqfpOw7z+
         vSW4ucmkPPefMY+64KWJzhd4qHOPsO6K7yREIr+kjBi7yhILC/5e9FfVHK3H6H8tteBG
         hkRS3L44CsGPm170FbmhWKA3zgRuncctrJ4jLOm9gV0oI6X5XaKAD7C1WTQTgaRcReeg
         S8SsSJ+XuDHl/m4kdlis0WtZ839w8sSzLETdXbHt+V6GQszrDIe6cCHLyKt5p5f6kWep
         APuhVhDxUcLLHtX6AlA2a01rs30/1qk5Ht1tuApwSoUoNXStPLvZvvMNiMBuuAwyecbh
         c65w==
X-Gm-Message-State: AOAM531k0iAtK2fLFa10QRbbF61iKJVz7l36ox/316rG8WvlMwdQ/q9l
        d6FLWjP1jFqrKBNEHfQbx/8oXMKJ2QQeNKfrGt20J9814nBjrhTY
X-Google-Smtp-Source: ABdhPJyU2/5W/ThK+TGGdFKWfP4V+RKzPsW/rRZ90hsF1NyCirVsNlLrjjELtLT0MO6PuBRTT/Ptw9PCNR7CmcRoYiA=
X-Received: by 2002:a63:24c2:: with SMTP id k185mr2343376pgk.415.1597426146437;
 Fri, 14 Aug 2020 10:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAFMepc=iqyHG7V4LPcyZ-fmmWp176YpW_88joLtYxQrpsM5UFA@mail.gmail.com>
 <86d2176b-afa7-6c39-7d1c-489895ca1fab@gmail.com>
In-Reply-To: <86d2176b-afa7-6c39-7d1c-489895ca1fab@gmail.com>
From:   Kyohei Kadota <lufia@lufia.org>
Date:   Sat, 15 Aug 2020 02:28:55 +0900
Message-ID: <CAFMepc=R8JeMx3UR5ihbzzJVw6T=+ixOjT1iGGP1JLZkkkZqkw@mail.gmail.com>
Subject: Re: Does git-apply --recount search a extra line?
To:     phillip.wood@dunelm.org.uk
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 11/08/2020 07:16, Kyohei Kadota wrote:
> > I just found a strange error in git-apply --recount.
> >
> > ======= output ========
> > % git --git-dir= apply --check --recount -p1 -v <patch.diff
> > Checking patch main...
> > error: while searching for:
> >      mountfs\
> >      configdist\
> >      confignet\
> >      mountdist\
> >      fmtventi\
> >      download\
> >      copydist\
> >      bootsetup finish stop\
> >      stopether stopppp\
> > -- /n/sources/plan9/sys/lib/dist/pc/plan9.ini.cd    Wed Apr 13 21:19:21 2011
>
> There's no "diff ..." header which git inserts before every file between
> the two files in the patch so when it is recounting it treats the "---
> /n/sources..." as a continuation of the current hunk

Oh I'm sorry, I've missed its specification.
Thanks.

>
> Best Wishes
>
> Phillip
>
> > error: patch failed: main:8
> > error: main: patch does not apply
> >
> > ======== patch.diff ========
> > diff -Nru /n/sources/plan9/sys/lib/dist/pc/inst/main /sys/lib/dist/pc/inst/main
> > --- /n/sources/plan9/sys/lib/dist/pc/inst/main    Fri Apr  1 15:10:39 2005
> > +++ /main    Sun Sep 18 00:00:00 2011
> > @@ -8,9 +8,9 @@
> >       mountfs\
> >       configdist\
> >       confignet\
> > +    download\
> >       mountdist\
> >       fmtventi\
> > -    download\
> >       copydist\
> >       bootsetup finish stop\
> >       stopether stopppp\
> > --- /n/sources/plan9/sys/lib/dist/pc/plan9.ini.cd    Wed Apr 13 21:19:21 2011
> > +++ /plan9.ini.cd    Tue Nov  1 00:00:00 2011
> > @@ -5,6 +5,7 @@
> >   dmamode=ask
> >   adisk=/dev/sdD0/cdboot
> >   cdboot=yes
> > +installurl=http://148.251.6.120/plan9/download
> >   # console=0
> >   # baud=9600
> >
> > ======== main ========
> > #!/bin/rc
> >
> > # must be topologically sorted (by prereq)
> > tasks=(\
> >      configfs\
> >      partdisk prepdisk\
> >      fmtfossil\
> >      mountfs\
> >      configdist\
> >      confignet\
> >      mountdist\
> >      fmtventi\
> >      download\
> >      copydist\
> >      bootsetup finish stop\
> >      stopether stopppp\
> > )
> > #    startether startppp stopether stopppp download\
> >
> > ======== plan9.ini.cd ========
> > partition=new
> > mouseport=ask
> > monitor=ask
> > vgasize=ask
> > dmamode=ask
> > adisk=/dev/sdD0/cdboot
> > cdboot=yes
> > # console=0
> > # baud=9600
> >
> > [install]
> > nobootprompt=local!/boot/bzroot
> > bootfile=sdD0!cdboot!9pcflop.gz
> >
