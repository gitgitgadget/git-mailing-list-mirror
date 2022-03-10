Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F40C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 01:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbiCJBW6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 20:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239164AbiCJBWz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 20:22:55 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D41CB907
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 17:21:55 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id o6so5657035ljp.3
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 17:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UzYSnKZXEPLjrr4b5sXVbY43CvBdKASNf/p8Z4jWbQc=;
        b=nmrppQ+zhLx3UqkKUDkOpEsyGw+X/OdWT9SsqiAxu+9cXLPOWlY5B0rWUqOnhxZUlR
         dIg8GXYS4fL5GV9dJPFvyhBkr1IktsEGyS3s+kIhiukJocjVRGkXVBn6UCfHTVTUBGMc
         XqPgzh8mukfOXjHxo/B/ZKGYoHu//mbudvu6k+bSvu/lTnhLVyDlYktdvfKL+PnJhwyh
         wZ/gRmG2872bWg5AK0vPJjUV0+MrDC5bd5FMovdmErhRyLU+SVS2mlMp/7h+ERXW1XiB
         NvzK4/g8+FDc7bXgB69AZzWGHbEpitomMaWzlgm9AdqGCKg62fXW1DNkM/lJDV18O9b4
         EbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UzYSnKZXEPLjrr4b5sXVbY43CvBdKASNf/p8Z4jWbQc=;
        b=oNGw0D6XDQ+xWIBNR5MtOsye2jOXq8bNRXZrEWdGgGAGUgTIjHNdJREveuSZU7R+Tc
         qINp3xBcOINps8yc16QRFIHR601mWTmNtGIiEqad3pExkoswAHa8TAWF63DqCFblGBVG
         Tf+YmXGa1KWVZbXwdN94jWuCPYxacUNG4IYGKaEGU1yaD2btqbNeJcr87trJUYa9AJFE
         Qh+rnC7q9+Nw1wGZsA/C4tOQHmfxd24+DzTSzuWtfvNJ5hPmt4dMn84Af+0B+C4GKmZ5
         XyhD/vF4uury8atSusvI/arjDcu9vzykC6EmMd/16dgRILR4hSONhl8y9R3DmUxfChIR
         ZtOw==
X-Gm-Message-State: AOAM531TcHn05GWrI6EvBjqbQ0IIXN6kvnjVfnOKvXTsAKMI4WlbPoNC
        CaShXSjS9kJ4p/ENPwFGLQyXhR6VVxq+r4p3FgY=
X-Google-Smtp-Source: ABdhPJwYUFDaiOMIEmPOfmRiDMqELVD22/+Y9ri1GeTUeC40lWAvgZJ8EHk/P3XVnO2xOkWa5Ao2GRhv2qOeAsSSTyg=
X-Received: by 2002:a05:651c:516:b0:247:a27c:60fd with SMTP id
 o22-20020a05651c051600b00247a27c60fdmr1426224ljp.73.1646875313939; Wed, 09
 Mar 2022 17:21:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
 <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com> <685b1db888079c83573cfd984ae64f46284544af.1646866998.git.gitgitgadget@gmail.com>
 <xmqq8rtiln6a.fsf@gitster.g>
In-Reply-To: <xmqq8rtiln6a.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 9 Mar 2022 17:21:43 -0800
Message-ID: <CANQDOde4e6434mDE3rra9VQMfhfksmJT48jvgNk6M4XDqtthrg@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] wrapper: move inclusion of CSPRNG headers the
 wrapper.c file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 9, 2022 at 3:29 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Including NTSecAPI.h in git-compat-util.h causes build errors in any
> > other file that includes winternl.h. That file was included in order to
> > get access to the RtlGenRandom cryptographically secure PRNG. This
> > change scopes the inclusion of all PRNG headers to just the wrapper.c
> > file, which is the only place it is really needed.
>
> It is true that wrapper.c is the only thing that needs these headers
> included as part of its implementation detail of csprng_bytes(), and
> I think I very much like this change for that reason.
>
> Having said that, if it true that including these two header files
> in the same file will lead to compilation failure?  That sounds like
> either (1) they represent two mutually incompatible APIs that will
> cause breakage when code that use them, perhaps in two separate
> files to avoid compilation failures, are linked together, or (2)
> these system header files are simply broken.  Or something else?
>
> > -/*
> > - * Including the appropriate header file for RtlGenRandom causes MSVC to see a
> > - * redefinition of types in an incompatible way when including headers below.
> > - */
> > -#undef HAVE_RTLGENRANDOM
>
> This comment hints it is more like (1) above?  A type used in one
> part of the system is defined differently in other parts of the
> system?  I cannot imagine anything but bad things happen when a
> piece of code uses one definition of the type to declare a function,
> and another piece of code uses the other definition of the same type
> to declare a variable and passes it as a parameter to that function.
>
> I do not know this patch makes the situation worse, and I am not a
> Windows person with boxes to dig deeper to begin with.  Hence I do
> not mind the change itself, but justifying the change primarily as a
> workaround for some obscure header type clashes on a single system
> leaves a bad taste.  If the first sentence weren't there, I wouldn't
> have spent this many minutes wondering if this is a good change ;-)

This is (2), these system header files are simply broken.  I've been
looking deeper into why, but haven't bottomed out yet.

Thanks,
Neeraj
