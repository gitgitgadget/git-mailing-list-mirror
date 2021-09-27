Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C79C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 18:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1495D60F4F
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 18:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhI0SKl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 14:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbhI0SKk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 14:10:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F039C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 11:09:02 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y35so21594089ede.3
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rNjJIgTHPj2dSVzSiEIr4SDaYzXQHYgUaspUhYAuzP4=;
        b=JzTBW2vkkydhsmYRZAF6f83AJ3Q1J1XP2aGlZYA8Sy3It8XYRnjS/m6keOU++d872p
         KgphJauIo6jAqQm3AHvCkGiJtVE6tvOXfC5BlZ+7ITv2IKXKEAe4ozCYX3LjulppHeGJ
         EFqRhgd6x6LfYll9QkphvMQD2X6UN6/MEh5deSCLpOIBYRPuEvXAKmndQdE+CQFNq6yQ
         IL6z+5j7AX96HpEINgyalec/yRGMBibsxR6u0VaKBYxRKLW1s5sDw5Q4hdiLf4SSNREA
         2gSGs11dQbnewYSaJyuLKde0t4l78Cdqkoa787KTliAubxHSZSGm0DrtoMzDWpTc5rD/
         fbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rNjJIgTHPj2dSVzSiEIr4SDaYzXQHYgUaspUhYAuzP4=;
        b=kcoKzjaIF0touSNNtIKS/4CKJwRUoCcPLve5OVEb3+dhJ4HX4abZs6CpePw5dK46gr
         sRisfZy0hz0VDRuSD5xnu623KarG4VZwIzsh1jGE9RzuESXcSev3DCE1I9yMMKosKGha
         DMwuC0yH2sZg7EQR/RQhNJp29NQdRR68/Cl65y0uT3FpcM0G8GvZAjJPhoz7rTmatQGr
         WvZoZcarqCWckLxzrfnf3/HXwbeproebZMDWtilB92Eu5R9AeakZCy2UtkTKKE+480V1
         ULPxvgTZUlX5VWCN6sl0sBvbR/FAMT46POFslMug7Teg+6uI1R8gN0Ysvh4sxOJkPZXj
         nvWw==
X-Gm-Message-State: AOAM5304hCgUkB7Y28UjCiTYKl0TLeDbDh5veFdyXc5tRHjdxQzHkJAY
        Wu2sVW9dMYSiOtryN705mVpYbFRnFXoglPbDqM4=
X-Google-Smtp-Source: ABdhPJwMAcMNHsA4eSiM2RVbxhgDQhQtL54syqawlWt9PYSipoXKWUONwumorpunL6eNOA4vMg8lGDzNfvbEp5/aTJo=
X-Received: by 2002:a50:cd87:: with SMTP id p7mr1683891edi.294.1632766140713;
 Mon, 27 Sep 2021 11:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <CABkJDHFOMkf-Pouaw3rtjtM+KFhPxnYtCiMbqKYCraXFb_9qQw@mail.gmail.com>
 <7b4b59a4-7e58-3db2-d934-d570cdebbf31@gmail.com> <CABkJDHHDjwviVmCR=tu3JBx+7BMmbmesOrkymq0fH4PXE5=i1g@mail.gmail.com>
 <135f854b-7975-a6a0-69ea-8697583a87b2@gmail.com>
In-Reply-To: <135f854b-7975-a6a0-69ea-8697583a87b2@gmail.com>
From:   David Aguilar <davvid@gmail.com>
Date:   Mon, 27 Sep 2021 11:08:24 -0700
Message-ID: <CAJDDKr7itDvy1WPoC=kBPpT4_qm6MKWWfxwt96wQJKnGBGW5ng@mail.gmail.com>
Subject: Re: [INFO] Does Git GUI support Dark Mode on Windows 10 ?
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Sashank Bandi <bandi.rao999@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 27, 2021 at 3:41 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 27/09/21 17.19, Sashank Bandi wrote:
> > I'm currently planning to convert this into a C++ program as there is no
> > way from the Tcl itself to change the color and background color of the title
> > bar or menu of the Git GUI window.
> >
> > I also CCed Pratyush Yadav as he is the official maintainer of the project.
> >
>
> Regarding GUI toolkit, you should pick the replacement carefully -
> tooling used in Git for Windows will need to be adapted in order to
> compile your chosen toolkit (whether it is Qt, GTK, or wxWidgets) for
> Windows.

Have you tried git cola? [1]

It uses Qt. It's cross-platform and written in Python.

Git GUI is useful because it's built in, but from a usability
perspective cola has many advantages.

It has a dark mode that works more or less how you described:
- system default
- user-specified theme (dark/light with a few color variations)

.. and beyond these rather small differences, git cola even has image
diffs[2]. That alone is a killer feature.

[1] https://github.com/git-cola/git-cola/

[2] http://git-cola.github.io/screenshots.html
-- 
David
