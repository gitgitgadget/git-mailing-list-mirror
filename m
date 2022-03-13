Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA87C433EF
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 19:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiCMTDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 15:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiCMTDu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 15:03:50 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9CA4D61A
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 12:02:41 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id v75so6401812oie.1
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 12:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tTDLSsJLZWB02IEnCcNx0q31wMgsaPTUyKKfUmez03I=;
        b=LK1j+rQacr7klKZlmZDJmGOqe3mtE90W12kP/SvFpdCQKKwSAeAQsdWb4nj2YjzRQu
         tlo7X8MfFNiENb2imM6/uS3e+UB00796EJapKdJOpjbkupYYOiG71m1FpULjELKX8hBL
         R6/Jt7JIpfOZmjs2+SnIJaqlPxP12Y+UV3GEluzWg735tCrpXeWVts/JhoFNYfieFGTQ
         F4EufZdlcRkX5Rgp5rBZhzvCtyOmdlMB0yXeXL+ns/qibiYGhsFO0XBnQR3M6sRRQrMG
         1eqBAKhGUly4IAA4HSTW5XMdDZxqogPhpa7CZQS5RENxAGyI6Z2x7AfjZJfLhvhavPfr
         JTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tTDLSsJLZWB02IEnCcNx0q31wMgsaPTUyKKfUmez03I=;
        b=VuebiYTHCa04IzsH8WwS/yUwBzC+iFTO9mBvL1J+NjgupfsLyxioaTHQl5a8SIJD+Q
         SQgEl8cmNxl2rEialCvpPS8x1rIAxjgCb+Ou8iriPCogD0uJC56omwdm5pj913ehb3NG
         T3RQfG/mQC+WvVNJ/YVmFl3TY9Xunn6IBXCLhzMkoWaQ7HrrY5nhr59vS80S5o+EXhD+
         pCgjrwJ34l7l4lqeIeP3B9EVmpdL16Ty8t6fy8kpU6gcv38qd2gISbDzMt1hyyivGmFT
         fK1foXooWPCMIwErMnTJ7w1BhQlrFxatKmT1H++5ADr9nj+obAxZ9RtMrsRxYx49b6vq
         U5Eg==
X-Gm-Message-State: AOAM530p5emnp8YfQdV1UiLlPErkRZUmdvZkbXPy/+8mA4aS3wTbJHtB
        BeMTQf1ngpn9m0NKyGLvDf//K4E+pv6H1txLITA=
X-Google-Smtp-Source: ABdhPJx6ar0eGXPA7BbTudOXokIb02AeL2CYpE/YxAXudcgk2jhnES0TRcnucy0xPjbrVMmcuuMHeUe1Htn+wHUeOCI=
X-Received: by 2002:a05:6808:655:b0:2ec:ce86:303c with SMTP id
 z21-20020a056808065500b002ecce86303cmr2655151oih.217.1647198161010; Sun, 13
 Mar 2022 12:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220304133702.26706-1-gitter.spiros@gmail.com> <20220308113305.39395-1-carenas@gmail.com>
In-Reply-To: <20220308113305.39395-1-carenas@gmail.com>
From:   Elia Pinto <gitter.spiros@gmail.com>
Date:   Sun, 13 Mar 2022 20:02:33 +0100
Message-ID: <CA+EOSBm1wfO-RPJHiHZiUxokdt8MW3ufoCk_aJ4o7O=x1_nwDQ@mail.gmail.com>
Subject: Re: [PATCH] test-lib.sh: use awk instead of expr for a POSIX non
 integer check
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Il giorno mar 8 mar 2022 alle ore 12:34 Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> ha scritto:
>
> Restrict the glibc version to a single version number and compare it
> arithmetically against the base glibc version to avoid accidentally
> matching against "2.3" and better supporting versions like "2.34.9000"
>

I didn't understand the problem. How glibc names the versions is known:

https://sourceware.org/glibc/wiki/Glibc%20Timeline

What is wrong with the expr statement ?

+ expr 2.34 '<=3D' 2.35
1
+ expr 2.34 '<=3D' 2.34
1
+ expr 2.34 '<=3D' 2.33
0
+ expr 2.34 '<=3D' 2.32
0
+ expr 2.34 '<=3D' 2.31
0
+ expr 2.34 '<=3D' 2.30
0
+ expr 2.34 '<=3D' 2.29
0
+ expr 2.34 '<=3D' 2.28
0
+ expr 2.34 '<=3D' 2.27
0
+ expr 2.34 '<=3D' 2.26
0
+ expr 2.34 '<=3D' 2.25
0
+ expr 2.34 '<=3D' 2.24
0
+ expr 2.34 '<=3D' 2.23
0
+ expr 2.34 '<=3D' 2.22
0
+ expr 2.34 '<=3D' 2.21
0
+ expr 2.34 '<=3D' 2.20
0
+ expr 2.34 '<=3D' 2.19
0
+ expr 2.34 '<=3D' 2.18
0
+ expr 2.34 '<=3D' 2.17
0
+ expr 2.34 '<=3D' 2.16
0
+ expr 2.34 '<=3D' 2.15
0
+ expr 2.34 '<=3D' 2.13


> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  t/test-lib.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 8e59c58e7e7..f624f87eb81 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -518,9 +518,9 @@ else
>         setup_malloc_check () {
>                 MALLOC_CHECK_=3D3 MALLOC_PERTURB_=3D165
>                 export MALLOC_CHECK_ MALLOC_PERTURB_
> -               if _GLIBC_VERSION=3D$(getconf GNU_LIBC_VERSION 2>/dev/nul=
l) &&
> -                  _GLIBC_VERSION=3D${_GLIBC_VERSION#"glibc "} &&
> -                  expr 2.34 \<=3D "$_GLIBC_VERSION" >/dev/null
> +               local _GLIBC_VERSION=3D$(getconf GNU_LIBC_VERSION 2>/dev/=
null)
> +               if echo "$_GLIBC_VERSION" | cut -d. -f1-2 |
> +                       awk '{ if ($2 - 2.34 < 0) exit 1 }'
>                 then
>                         g=3D
>                         LD_PRELOAD=3D"libc_malloc_debug.so.0"
> --
> 2.35.1.505.g27486cd1b2d
>
