Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D40AC433E0
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 23:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28DD220796
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 23:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbhABXAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jan 2021 18:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbhABXAx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jan 2021 18:00:53 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E17DC061573
        for <git@vger.kernel.org>; Sat,  2 Jan 2021 15:00:13 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id q10so12545734vsr.13
        for <git@vger.kernel.org>; Sat, 02 Jan 2021 15:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yl/o00R6iEtgqIQVSDSg1LkrB/hUI1NbBzYJt2dCGbo=;
        b=Fhs+kk+cD/rKjvkleRVAk9QmfFDlvL7mKcz6chRpi04MVJ6TCMkraWQdrGooVAMZX1
         QWqz+IXilC8fr0ecPhn0wNrqZAatn/8YTvr9pHn2RB698uaMtJHUTHBLeROyFmBPK6LS
         hT3S36m5Xn77DnTzPpSci9XNCIckKVv5LPgnP0vEx86YgJKmzNmN35F1HRN34i48A4zW
         jGrdPJeAjoQQGs0Lkwmtv9VrpDS8sJLXOpmL/yNewoHHYWbNUH2SgvitH47dYdcHrq/x
         3paCwsY+k6pVQ3Tf+YLCVsFeb6rak0Z+cxkG4AwMHjyMiG1tEeWpB0syuBsiZ0y+FQrq
         NCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yl/o00R6iEtgqIQVSDSg1LkrB/hUI1NbBzYJt2dCGbo=;
        b=I3zM9AlcxeABraEQ/oqn8DoMuPOx3V45QSdi1+pH9+fGvnmcELjjAzHXouxtreeMa3
         5mqSxtsrK4jvA6JZVUyFZt9BubfEzb3g3HRLgPYF4NHl95S18xr6a/it5FIf9y9J0Akh
         l7qON1F/Phqo/BrgL7BMDC/WxN1nUD8zAho1ABAOXUUnqF4Or1e0d6M2yxPkJ5m30uAM
         jKtmvNsXVG6gjHQadVuWr0KuN3xJRM7ljf6MQXMNXWFX+qOHRvqlBBwudQUMBM70oAcJ
         UpglFr4zEruBGYRKtTLa271amARdpURwG56gcre11Hg1n4aLaLrukAewBOq/p79k9++t
         aVIA==
X-Gm-Message-State: AOAM530l1i0gvY6c1ZQobWDOoJudn7nLmjJcFmwL1ZkqzePvQCebbP36
        CUNXflWWOCD8eLFhXIl6F8DJ7cnFpByBnPz1jV4=
X-Google-Smtp-Source: ABdhPJwQQVZnnZrugUXYWhLZ3nsh+qrOzvveAUOPL//eQcxmpLZWErOLYXncSRlnWWLoMuMa52QCHa2jbmnQRXdrglg=
X-Received: by 2002:a67:8011:: with SMTP id b17mr42889042vsd.2.1609628412346;
 Sat, 02 Jan 2021 15:00:12 -0800 (PST)
MIME-Version: 1.0
References: <pull.831.git.1609609214040.gitgitgadget@gmail.com>
 <CAN0heSojPyr=g5PBVmT4VTfxxKxzYcFXJ1jynM1tGuZSyQMykg@mail.gmail.com> <5ff0f31315732_a76d20833@natae.notmuch>
In-Reply-To: <5ff0f31315732_a76d20833@natae.notmuch>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 2 Jan 2021 23:59:59 +0100
Message-ID: <CAN0heSq3q1X8jJqBkHtrTxaxJ4xfw5kQtH+b8GG9OWRXHExt+g@mail.gmail.com>
Subject: Re: [PATCH] doc: fix some typos
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Thomas Ackermann via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Ackermann <th.acker@arcor.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2 Jan 2021 at 23:26, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Martin =C3=85gren wrote:
> > On Sat, 2 Jan 2021 at 18:43, Thomas Ackermann via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >
> > [Snip several typo fixes in Documentation/, all of which I agree with.]
> >
> > > diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsyste=
ms/CMakeLists.txt
> > > index c151dd7257f..8f77baa678f 100644
> > > --- a/contrib/buildsystems/CMakeLists.txt
> > > +++ b/contrib/buildsystems/CMakeLists.txt
> >
> > Hmm... This does not match the "doc:" prefix of the patch.
> >
> > > @@ -442,7 +442,7 @@ endif()
> > >  check_c_source_compiles("
> > >  #include <regex.h>
> > >  #ifndef REG_STARTEND
> > > -#error oops we dont have it
> > > +#error oops we don't have it
> > >  #endif
> >
> > I don't think this is correct. This omission of the single quote someho=
w
> > looks like it's done on purpose. I don't build using this system, but I
> > tried making some silly code like this in another file, which I actuall=
y
> > do use:
> >
> > #if 0
> > #error might or mightn't work
> > #endif
>
> But this works:
>
> #error "might or mightn't work"

Yeah, I pondered writing something like that. But then I thought I would
also need to write something about how, at the least, it should still be
a separate patch, but also how even if it were a separate patch, I would
probably sort it under code churn (IMVHO).

The error is not really intended for anyone's eyes, at least assuming my
reading is correct. So I refrained from suggesting to Thomas that here's
how you could go about making such a change.

And now I ended up laying out my thoughts anyway. :-) Of course, others
may well disagree with me about this being code churn.

Martin
