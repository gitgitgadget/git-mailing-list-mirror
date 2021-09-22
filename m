Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE7EC433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 10:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38F2C6109F
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 10:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbhIVK5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 06:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbhIVK5I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 06:57:08 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8759FC061756
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 03:55:38 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id u4so2432924vsu.11
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 03:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iHFefDeLUIyfjVjXAkfjuck7wIGGJrBxtzM+hdZbUIM=;
        b=qkhJO89m62vBY4f0bCzODS1/BuTCVADPIna1zCIxgfqINf1kK+Nl7A3ot6PSXjRuFS
         x6UpHS6QtJ8YmML4H5Xy3BR8z9fTEqL4uvfOkNhMK5ThZ+RpIU5re0GJbsFYq9FT3bI1
         /mjXEYJTGQTHIs144TNsVbZGElL7dMBgFUrwHjEqCvSGvRksPQ7CBe9+y+zEUZCvxAhA
         bTEUeR91lwuvGQgifLiY3mWS84wzhQHKKmTqhexXKLSvo7SXTkpo9H7qS4+DZNnsywZ8
         cP3aPqobJ1+AInCQrvtP2GuqH0aana4sFeFAJ650GZ1EdwfPVMEVAkxAN22/9hNNSetK
         x0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iHFefDeLUIyfjVjXAkfjuck7wIGGJrBxtzM+hdZbUIM=;
        b=OtOwhRFeYmjZ58jlfSR1ypQKLwyt/QWILT1c0OOwxdaxseMiOsM/Ms1FCrdK7hkneU
         D/DqcP/R9lP1upVZfsYAQyZrVGx/Bi6OLDlFb+kVGVYG3CBXWCYB5r40X6PmRVIMmi0f
         I78N+3GoY1dZlDCGek1KFLqLkoN4GwWi+CRdyy2Tb5joa6RPVBDlX7Ed16PVtGYZoZpq
         B8MnnM18g2iAgYXPGSNY59FT0rWtbi3Cf1Gd7WLMsg64tZnvhxEn53E7AAyREj+ll4VG
         2d6bVzysGg6YoGIc5T9R8eyd29DTxcp53EDLK4OSzj3qw6o1z2FvD42YoPioPjI8fg/V
         165A==
X-Gm-Message-State: AOAM530TMsmIh9BmsNJjVGCBZCRj1RkKJZLkxAqVuv4oyadNs44H9gUv
        XZkPOZ98iXkT2o8kK1uzkND9pB22PFYo9M9OjL20BttR
X-Google-Smtp-Source: ABdhPJzx628DhBWW7ZNl2n9Rrm0DRlDb4wAK/1Nm2MZ+qoBUJxJq6YhdVW0z1Ex1mt0NwKQdDFD7IRaUjjkfG2K6tSo=
X-Received: by 2002:a05:6102:518:: with SMTP id l24mr24925870vsa.57.1632308137667;
 Wed, 22 Sep 2021 03:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 22 Sep 2021 03:55:26 -0700
Message-ID: <CAPUEsph8TYokqLmiZjvu3VgmzLh4AFhp+0vh0nv+2+m351=n_A@mail.gmail.com>
Subject: Re: [PATCH] Makefile: make COMPUTE_HEADER_DEPENDENCIES=auto work with DEVOPTS=pedantic
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 3:38 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> The "COMPUTE_HEADER_DEPENDENCIES" feature added in [1] was extended to
> use auto-detection in [2]. Then when -Wpedantic support was added to
> DEVOPTS in [3] we started passing -Wpedantic in combination with
> -Werror to the compiler here.

It is my impression though that header dependencies computation is
something that might only work in gcc and clang (because of its gcc
compatibility), so shouldn't this be restricted to those compilers
instead of forcing all others to error?

Also, why is this process run with DEVELOPER=3D1 to begin with, if we
obviously don't need/want any compilations warnings?

Carlo
