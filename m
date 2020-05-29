Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE18C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 19:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B413720723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 19:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmBYGyYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgE2TId (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 15:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgE2TIc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 15:08:32 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02406C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 12:08:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n15so304813pfd.0
        for <git@vger.kernel.org>; Fri, 29 May 2020 12:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LjWIwFftdMEQV7jaRXkpYt8To79A82jKHUZhTaEdcuY=;
        b=QmBYGyYP1qpLjDZSXHoVJ6Rg9wG8jBytsSANdd1Huxu+eTwpgChEwNwrvkuY89iY2U
         WO/BFinwhQFhpB6w/hAXyQZGcQNCBAVC06CTYSGgZEtqrhUvd1HrBYGlgMsDiXdQH6bt
         ua9aVW8JvDJKInj9fQ83/moPhPBerSyeguJzH2K10ZX/2D196A/iJKrZwRRRsnAFTbjW
         WjA33llmqPhRtqqbD72DuEdZZwOT0BMrYN/EoeJ4mXTOKL9Gl+I6o21EGZ6kQXdwmebu
         dpvyBhSiVzrV1qvxXtWujBq/c/6rhxrdEjCq+ZPY5s0EfWaQW6qpo99rmELRR6hoNOlT
         9Jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LjWIwFftdMEQV7jaRXkpYt8To79A82jKHUZhTaEdcuY=;
        b=ORF4hFmtJrpVIqxlwxLbHeBA1Krz5lFm6mVc2Guk1Yo4v16X6+DN9Caepg9Z1b40uF
         r/anbfJ19QugTHMUeWz5SktLpX9AXnmAYhXE414gcHax+F7+s2ZBlGP4uRv+6EW0nf0v
         vp/+NuWCrPgp5zkRJj2uixb0AIxawczyC36+SLLG5bMMVRFhcLigpdpuyzlEX/MYtyn3
         lBqRfmRey6ySF7yWJt36qF4nS+hB3MGDpFXC9lvLcnPKTzNtlciXDx2ZNKB2yxGyWina
         4CmEnzIv6T5cKCNGnlfAHSbPNW97XMYHWsFyY0SzuY8spBDogcpOI7J/8op9lW1oCTZZ
         NM+w==
X-Gm-Message-State: AOAM5337evWw+GLLIZeYxdiv3MBVKxh19cjO7HOtvFZmbdCSjoI26thm
        3Q7B0bhFXvpA9Qq/GIVT1qrhcpB2d6rsdERimVB1ghiqjL2+mA==
X-Google-Smtp-Source: ABdhPJw0UI0xQ/k4RbZsBJsZxNSBwSUzJq9bgkY353ssfatZgvRF0TeJn18gBh5quQW1cBuv5tq5n3z2w9GRjAFx+6o=
X-Received: by 2002:a63:545a:: with SMTP id e26mr9414009pgm.4.1590779312528;
 Fri, 29 May 2020 12:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Ves8x9_1=fVo_+dB92GpAGLcbGVqeo2gjRbBnzTzM0uzg@mail.gmail.com>
 <20200529172955.GA123244@google.com>
In-Reply-To: <20200529172955.GA123244@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 May 2020 22:08:20 +0300
Message-ID: <CAHp75VdTX=pJw6r=H=qfaDcv07n69uGQQ0TwrR0bACAx-OQAXQ@mail.gmail.com>
Subject: Re: Git fetches whole repository and not just latest
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 29, 2020 at 8:29 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> Andy Shevchenko wrote:
>
> > So, I have a local repository which has many remotes added (~20 or
> > so). Most of them are from the same Git server, but few are from
> > different servers.
> [...]
> > origin, for example, almost everyday now gets in full (1.21 GiB!),
> > while others have no pattern.
> >
> > I would like to know if it's problem of proxy, or that specific Git
> > server or is it (new) bug in Git?
>
> What Git version are you using?

git version 2.26.2

>  Can you test 2.27.0-rc2?

Is there any deb package?

> I believe this is fixed by
>
>         commit 2f0a093dd640e0dad0b261dae2427f2541b5426c
>         Author: Jonathan Tan <jonathantanmy@google.com>
>         Date:   Mon Apr 27 17:01:10 2020 -0700
>
>             fetch-pack: in protocol v2, reset in_vain upon ACK
>
> which is part of 2.27.0-rc0.
>
> Thanks and hope that helps,

I'll try to allocate slot to test later, if there is deb available, I
can do it sooner.

Thanks!

-- 
With Best Regards,
Andy Shevchenko
