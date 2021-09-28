Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3D2C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 11:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104866108F
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 11:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240246AbhI1LFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 07:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239306AbhI1LFA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 07:05:00 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24033C061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 04:03:21 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id f73so8272801vkf.6
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 04:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rb76GdCF/MzaZirSK03yLYQaEq4Qm0xviYNhWfbMlYY=;
        b=kwhRNjZwfyeA7MLscYBXMDrHICKVsDXTJlZyeBqedLBZdL6BGybclU0xJgRETJwJf8
         00ZWSrPH5wy5MIbaPAK2xHz1HPqyQ1DPjTShlI1YQhol0XUG1YcSOosKzL7BeWQal/AL
         QJyduYdydf+iH+Q75FQ6FNJ2hPy4NGyaJg1Y6zN0PRZA4gipO+IjPjCg5oMYJY5o+AT1
         IGD9xGblKN8HjIn7a9b4h/9bqZfuUFkf5eDuvgpzy2wpWNamNilTVu8grdyYK0DZsh2A
         flKEmrs+1lASD8a7V5hR2dfBEs3I8GcnY+hxHzAPk9RbxI+uAaZ4NENn5MFv4Z3lVXCp
         224g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rb76GdCF/MzaZirSK03yLYQaEq4Qm0xviYNhWfbMlYY=;
        b=go353bs7lDVpmmH/L5xbi0LlOh4fNDz1p/8cXFUfNoK30Q7YIFvJ+DO9ofWKDVjJJU
         sU0b6n+plEwoMPaeXG20U7oca5ypElmJXO1ceZMYwi+7FD038/vRBXWstQqIgtywdise
         CmcNboE+Vlqe6CvZgZ/fMzvYZaqp2ddJ0R/c33wn+DlGIKd2cFIwJuRDR6SnjkMN4yAR
         ZVWGHV0Fnb+4HP82mGw1thwDO6/nniA8sQn0F5eadnqjy9CG1trhvFMFc/oY82xHj3sD
         xYdKfAF0iagtoEn1hqM8jG5ztripbardD/Mo2TP3rjx2GlGnd4/lZrgJazB4oOvmN3A4
         P/6Q==
X-Gm-Message-State: AOAM533P/dyVMlu2iQsHogbHUZIlmbM3gmD3cFPzCaBNIGIQbN8owdTx
        C/Hj/TGPZcfE2hQyQaWxT/1a0a8uKu7EPDTUItY=
X-Google-Smtp-Source: ABdhPJzCCcwD18w2QQ/ZvcAfnNmFA5IFIVgA5aaY4ql7ImjP2etzKJ04Cd4sXrtZ/IqbJeB7PT39nunSdxhprPFz1vY=
X-Received: by 2002:a1f:1c8d:: with SMTP id c135mr3909784vkc.7.1632827000113;
 Tue, 28 Sep 2021 04:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210928091054.78895-1-carenas@gmail.com> <20210928091054.78895-3-carenas@gmail.com>
 <87wnn1vxh8.fsf@evledraar.gmail.com>
In-Reply-To: <87wnn1vxh8.fsf@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 28 Sep 2021 04:03:09 -0700
Message-ID: <CAPUEspj_hOXRc2d+c+DTvShgWX8NH+fXKD4Pk+_G=nj9Z97VnQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] Makefile: avoid multiple -Wall in CFLAGS
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, t.gummerer@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 2:52 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> This really breaks things for anyone who's relying on specifing CFLAGS
> now to clobber the default -Wall configuration, e.g. on both xlc and aCC
> after this:

got it; then it should have been DEVELOPER_CFLAGS+=3D-Wall the one to
keep, and that way there is no need to hack CFLAGS just to disable
-Wall in non GNU compilers IMHO
of course, that still leaves the question if -Wall is still something
we want to have by default for people NOT using DEVELOPER=3D1 to
compile.

> I'd end up with -Wall twice, gcc doesn't complain, but maybe some other
> toolchains do.

clang wouldn't complain either, and indeed you already have 2 -Wall,
which is what I was trying to clean up.

> But I think this needs to at least have
> s/DEVELOPER_CFLAGS/WARNING_CFLAGS/g or something.

makes sense, even though I assumed there would be less churn if
reusing the variable you came up with.
in any case, I think it is clear that this change that I thought will
be tiny might be better tackled in a different thread, not to
complicate the main reason for this thread, which was to make sure
that users that might build the next release (even with DEVELOPER=3D1)
are less likely to find issues than the developers that got their
first taste of "pedantic" in master.

will wait for more feedback before doing a reroll, but would be nice
to get feedback also in the other 2 patches, which hopefully are less
problematic.

Carlo
