Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BCCC432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3922C6109E
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhHYXsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 19:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhHYXsT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 19:48:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88165C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:47:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y5so1650275edp.8
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1HAdJvfkqdODURpk/eM6rgwb1bR03bBBbKWvwnY1v64=;
        b=r9xQ0WhaVQL30E2hg+Tk89agw4KFLKVhZ+Vj35snPl8JyVHT3Au9LTsL+XqF+TynSg
         bndIfa5fmQNekor61+TPEpvXlG3WVEfmInv0wEEM6b0le9FFjRYfgLxIKE60EZXs75xW
         q5h73T0Folc68haUSnBtYunOpNQc3sdzTLFdgWnpUeeCIt6VLGxQVTBFtpd17XZccYlo
         N2m6bdrS5kEY8ggAr6PL8PNvVy+adtzlETIZ+lAoApfhnERW+pXzhotOo0jPH/2bDwSs
         sLFW828oEBUeUoIU1p5t6dABqrRZj9NlTA7gdW9RKc+rw+8lN7GhgfEeISLWxUkx1TZW
         Lc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1HAdJvfkqdODURpk/eM6rgwb1bR03bBBbKWvwnY1v64=;
        b=n6GZKMDrL7SOiBy+TjtcfhiNITkAbImG6iL5F8p3hvLMGV/lSGD0fHdjB7G8LQezKa
         kbt0rLniZu3/2IVDR4vZKy0j5zbUThb1Dn7i2PnWvc77Kbbnx4AxDzNM9IBLkZ3Jokfp
         xNZ2dYMlJvLEjrd/bisB4FNlDNcQRE+zuxQcqY7xM5Gl0EG0g1vLJPimf+wSaRQ5KWHZ
         2G8tzLfZXS7XwXbu+1KNZ19Oh/Y+0FTWds70bBTu1y0Tw2wFcWGq5XfdToEhrr2BMaTY
         lbA9EoXBAmF1Y5wyrQQziTd37XD3zwQ3sz9+oXbGorlfTZdpadThxYHITxLShAKlxSGa
         aCaw==
X-Gm-Message-State: AOAM533RMw+rjhbcFAKQ+rBv7oYlg/5gMU/5bh5vR/HkWNksK2Nam1KE
        t9LdrvmNWcx+B39h3QQmttJ8yFIXoWnMUnb0SWE=
X-Google-Smtp-Source: ABdhPJwZRdaN5JA1tJitxh+zy4024/FqCyb1j4tsxHhuyZnYr1izVfHYrjZjttC0o/ri9tTnzCFQF4eRziKaRfH3rEQ=
X-Received: by 2002:a05:6402:1775:: with SMTP id da21mr1099408edb.49.1629935250556;
 Wed, 25 Aug 2021 16:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <6a5c3e8e-0216-8b63-38fa-b7b19331d752@web.de>
In-Reply-To: <6a5c3e8e-0216-8b63-38fa-b7b19331d752@web.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 25 Aug 2021 16:46:54 -0700
Message-ID: <CAPUEspjkcV1_R5DNXCkL5wQpZCW+K4As2nGuEGu6fyeFrr15KQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] xopen: explicitly report creation failures
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 25, 2021 at 2:11 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> diff --git a/wrapper.c b/wrapper.c
> index 563ad590df..7c6586af32 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -193,7 +193,9 @@ int xopen(const char *path, int oflag, ...)
>                 if (errno =3D=3D EINTR)
>                         continue;
>
> -               if ((oflag & O_RDWR) =3D=3D O_RDWR)
> +               if ((oflag & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL=
))
> +                       die_errno(_("unable to create '%s'"), path);

probably over conservative, but && errno =3D=3D EEXIST?

> +               else if ((oflag & O_RDWR) =3D=3D O_RDWR)
>                         die_errno(_("could not open '%s' for reading and =
writing"), path);
>                 else if ((oflag & O_WRONLY) =3D=3D O_WRONLY)
>                         die_errno(_("could not open '%s' for writing"), p=
ath);

Since you are already changing this code, why not take the opportunity
to refactor it
and remove the " =3D=3D FLAG" part of these conditionals which is
otherwise redundant?

Either way "Reviewed-by", and indeed a nice cleanup.

Carlo
