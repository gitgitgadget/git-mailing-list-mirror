Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7C9C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C094F60F22
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbhJ0IHz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbhJ0IHy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:07:54 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79292C061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:05:29 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id f4so3334295uad.4
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Aotb203OJFrKgoa8e6Ijkrht3AXUAHCyf57+fpglwvo=;
        b=fw5ZZ8QCRoD51iwVZs172pFeRQrHDd2LXDRbzYiu47RpZE7/HHOekIPxXPIj/UTW4O
         yx+fLHJi7KXScND1lfO3nJhYuGFY6uVfgHe5t9fWNXWF1cnkUcridtUip+4klE8uL/ot
         zWU3/DQ5OIuMOF0RPBXaMkpjkVodo/qMA6tLTcfPq9N3avte1WzwS5NcvygYnP3Ln7mW
         YZwC5gZiEinUIS5wTm8z+A4Gw58BVeDWxDFdVoZ2F5lc1tr06wh7zMRh9hVDIUOKedxj
         RETF/GK2WpJsvFvfUmc2G3cMPc8OACmz7Fe2Z3YCbA0s+6JTYiQZynHdrskrCSsEaiDy
         p0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Aotb203OJFrKgoa8e6Ijkrht3AXUAHCyf57+fpglwvo=;
        b=Rm1O0Z3jcL8EmPqNAY1GHFSgfM8X2IzTvdubge/G88zJX0yxg4bVd9DEyK95gM1SAN
         aQGIilxqLN+6B6UzbYXCsZWs1vGnWJjTKoKQt6MB/eUJlsvNcwI5C9OQC2EqDvSzq9y2
         UPwzW6YoJD1sD3zSDspi6WQUc2EJgQxRceRo6jDKaOG5zi3aOVOVPNJDUJH4ADnr2onQ
         SUxM9dB+9dQXD36wTZuRRCzED0WIgBmyUlWE60HCdUtuzrkMpbtbx48m5cdp6nOWlG6V
         zDe3nW9U9n3Z2OgT+fp2e7Fvg9d72Rm8iy9wyrcRRUpRwQH94DHn8mbGiDlE3tKFSTqZ
         YHLg==
X-Gm-Message-State: AOAM532laUBgvmdTbqDE6scqIvUEwFAPYMhM6Mh0LYNW4k0tTYyGe1Vr
        +WJaKMdkmjG6YdXRZATrtdfE6x+LNzH0C1q1Sg9oLSLw
X-Google-Smtp-Source: ABdhPJxmvBCEXRdbMeFsDrmy6DOm/g2OCgJuGRkF69+fd3ynPOYTwlcFfaIDGSrsY5MXOQO7BNp65SJuamOlES2dFrA=
X-Received: by 2002:ab0:14a7:: with SMTP id d36mr28497151uae.96.1635321928522;
 Wed, 27 Oct 2021 01:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211026013452.1372122-1-eschwartz@archlinux.org> <20211026013452.1372122-4-eschwartz@archlinux.org>
 <YXfvY3n9wEwctjUR@danh.dev> <43fe6d5c-bdb2-585c-c601-1da7a1b3ff8b@archlinux.org>
In-Reply-To: <43fe6d5c-bdb2-585c-c601-1da7a1b3ff8b@archlinux.org>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 27 Oct 2021 01:05:17 -0700
Message-ID: <CAPUEsph_03V-1-Euj_9P1PAA9EBZHN+utEV9TvfQxwb2QTPdag@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] pretty: add abbrev option to %(describe)
To:     Eli Schwartz <eschwartz@archlinux.org>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 27, 2021 at 12:23 AM Eli Schwartz <eschwartz@archlinux.org> wro=
te:
>
> On 10/26/21 8:06 AM, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> > Other than the question pointed out by Eric,
> >
> > with DEVELOPER=3D1, -Werror=3Ddeclaration-after-statement
> > We'll need this change squashed in:
>
> Thanks for the advice. In v1 of this patchset I attempted to do a
> developer build but failed due to preexisting errors:

you can always avoid breaking your build by using:

  DEVOPTS=3Dno-error

Carlo
