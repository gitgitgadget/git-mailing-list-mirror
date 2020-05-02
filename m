Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA53C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 15:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E32206F0
	for <git@archiver.kernel.org>; Sat,  2 May 2020 15:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKI3pedv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgEBPQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 11:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgEBPQY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 11:16:24 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96782C061A0C
        for <git@vger.kernel.org>; Sat,  2 May 2020 08:16:24 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l78so12158751qke.7
        for <git@vger.kernel.org>; Sat, 02 May 2020 08:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ld3zhCT7YPahz5tYwyslGc65Wmp+boc7KFJ9Da2ObA=;
        b=SKI3pedvvJR1z578hrGpRW/6x+cHBEli9IK0P83P/v5GtJs/pldC9e3Xw2nN1RAbKS
         BdFaqXO1hu7qcGqbn5crFkIr/w6ia+6/z5+hJvWQCYb8mLdDCZkhLL63qchw2jDR8AeY
         reeN/g25qFIWabmvBtqLBunSoK5WBYg4Ohtuj1yuWdTanfW4sUyrkUDXBSTEjMQihk4I
         IQo5M2oC4Q1A/jbc06w7U5uMiKjW84CpUn9BuoSfXoT8yUTs5imXxvCSh3WwmolRgEpl
         3ef7kszxNF1tXX75ufMxykC4Hn9skBuMbwSJY8zGEZwKdO+VxhEkqoeYleU+JHm3aLan
         njoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ld3zhCT7YPahz5tYwyslGc65Wmp+boc7KFJ9Da2ObA=;
        b=GsV9Oi+nkwscwzoh5+YEE1hj+xesUAi9MW/xM++9KdByAnvlOBbOyK1nxf8A665T9n
         ROb0tmGoB4GoiehVqJ+jFL+b5kQfyI7lMJlLyFBssChgrhyRTV1okOtXTC6yERvRXOC9
         EIv5m1zVO3T/vgvgKoMNbizX/6q0f1pVAFO0lqv1xBmryoGp/J9IbVJDyOiIbYGqg7DX
         syrzFklX57QVyGP/vy3kNGlHIGU+Ns9Qcw2LAcBiEsPM+bMorTssvmjNEeFCwR/VTe/L
         M1kGUi8w84ZKWKmChKWNYpyA2dx/8OnsfrPL72bwR3nd3Z/bUvhsgZ0NQgVd+AQlcSk5
         vy0w==
X-Gm-Message-State: AGi0PuYM9Qq4+MBLVqrjVdqZDYbDfHhlQjmAGNXfu5CUowD1Ps8xYT0+
        MSh94rpfIvNzuR/rmVTLRIof7q3PS8yKiJ+NXSkGrNFQ
X-Google-Smtp-Source: APiQypLHvTLX/xToRAfGyXK4rtiOmvh3sFpShT/LzGjgaygmDlg92aU0lc42bOxnyCahZYXS0AAMmZ985qSsmfQ1o6k=
X-Received: by 2002:a05:620a:688:: with SMTP id f8mr8279482qkh.431.1588432583875;
 Sat, 02 May 2020 08:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
 <20200427200852.GC1728884@coredump.intra.peff.net> <20200427201228.GD1728884@coredump.intra.peff.net>
 <20200428135222.GB31366@danh.dev> <20200428210750.GE4000@coredump.intra.peff.net>
 <CAKiG+9U2Eg5yvT4XjgpMUXu4OV-8JF9Hp_ou_P6twxfqJ1tEYA@mail.gmail.com>
 <20200502132144.GB3143@danh.dev> <CAKiG+9WNkM-9hfp83xz_xv0s3LQaiyG0voMFKoxvMwFKt4YoZQ@mail.gmail.com>
 <20200502150200.GA26423@danh.dev>
In-Reply-To: <20200502150200.GA26423@danh.dev>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sat, 2 May 2020 20:46:12 +0530
Message-ID: <CAKiG+9Xk5vgNxYZ7kNsUhgv0oopY-057VexUK=iE6dX6GKPrqA@mail.gmail.com>
Subject: Re: [PATCH 0/8] CMake build system for git
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 2, 2020 at 8:32 PM Danh Doan <congdanhqx@gmail.com> wrote:
>
> On 2020-05-02 20:20:50+0530, Sibi Siddharthan <sibisiddharthan.github@gmail.com> wrote:
> > On Sat, May 2, 2020 at 6:51 PM Danh Doan <congdanhqx@gmail.com> wrote:
> > The thing with options in cmake is the values it takes are boolean only.
> > To do what you want I think you have to do something along the lines of this.
> > if(NOT DEFINED SHELL_PATH)
> > set(SHELL_PATH  <default value> CACHE STRING "path to POSIX compliance shell")
> > endif()
> >
> > Then if you want to change this value, edit this value in CMakeCache.txt.
>
> Ah, this is what I mean, I think it's better to use this (without
> if_not_define)
>
>         set(SHELL_PATH  "/bin/sh" CACHE PATH "path to POSIX compliance shell")
>
> Then, we can use this:
>
>         cmake -DSHELL_PATH=/path/to/good/sh ...
>

If you CACHE the variable, you have to do this
 cmake -USHELL_PATH -DSHELL_PATH=/path/to/good/sh

I know it is bad.
Otherwise you can modify the cache entry directly in CMakeCache.txt.

Thank You,
Sibi Siddharthan

> --
> Danh
