Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CC4C4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 09:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiLUJVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 04:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbiLUJVD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 04:21:03 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14BC1C12E
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 01:21:01 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id gh17so35365528ejb.6
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 01:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJnCQdupGTIkMmYMIUbf2dQLsKbgjfjxmQt6LF40s6Q=;
        b=ZX5aYr+RabL4mrj7kw7o4RG4nhYcS/ROExMMTaTmhSYO6FmE/EPPXalL0PjWN7rDOj
         3CvZXJ4e4SLLpLXLJnEwmNysKmtwkxzhkyus/uyHZIP2Lv0WmgLghfMQWdYhEWlwJXsw
         L783PKopiv4PXxUMZFGRrlU/UJpEIGLwQGjatKXLGEfwqsr32R6uPoDEsvfp6fnRDHGs
         opOQOi5N0B9Px7k7P9Uxj7vhal2D/ja8uja8JDWuQpv8E7pTl7h7WgsqbHVxGUPUtaO8
         jjyqDmFUWnifNzEo/VijO48aHHbkN5+94vAiMu7iQaYM2ibvfJy2CBZyaQrHRtY4eRlj
         XMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJnCQdupGTIkMmYMIUbf2dQLsKbgjfjxmQt6LF40s6Q=;
        b=Ty30Y/VPiXHZeyJDhBRlQZAY6sa6m5wb2ONvO7s0vd6rwt5yCH4exuBtHW0ygQ5X1D
         sJ1hoOP1270gGWnK6K/sY2F/6LPlaf693SXUwZDd9oUXuQsnaem5wPYzAh4orvxoDTem
         MFxT/pktxWrbSsvDzfoNY7FcAo9jRUScEiA3bfaqthcxx9EeI8XsJA8Ge4YwCUQ/HPRG
         Y9Pid11/Hm0c80PLwUu3pBhY466EK50LmhByn3PhxhFRrbmf5y9Utrt3pmx1CTDUvqtY
         7Tnj3PXTjfVWs1Tl7SOqQl65/JASkJK78qo0X/p/LY5QzPaWnLru8PaiccONyAMfAYao
         BN2g==
X-Gm-Message-State: AFqh2kq5YKoAfSecoO3Sq8Bs/tu8iIVCbnoM57pJnKA+XhE4WXOcOrwT
        c8TT/4hPOVLZR6CADi9uTN38Gex1ov0=
X-Google-Smtp-Source: AMrXdXult3zOMyl+2ebw4476EKrCue5MsOPP87mhZ1ty5KxOUOMNgZSNWHkBFYLdJXl4dVAa3pi3Zg==
X-Received: by 2002:a17:906:7f91:b0:7c1:5a5:f6bb with SMTP id f17-20020a1709067f9100b007c105a5f6bbmr681997ejr.50.1671614459725;
        Wed, 21 Dec 2022 01:20:59 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id la7-20020a170907780700b007815ca7ae57sm6890858ejc.212.2022.12.21.01.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 01:20:59 -0800 (PST)
Date:   Wed, 21 Dec 2022 10:20:57 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4] am: Allow passing --no-verify flag
Message-ID: <Y6LP+fCMmP33T6Cx@orome>
References: <20221130172833.2662751-1-thierry.reding@gmail.com>
 <xmqqr0xkt07x.fsf@gitster.g>
 <xmqqlenst021.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gy9i5An7ghRnoKqM"
Content-Disposition: inline
In-Reply-To: <xmqqlenst021.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gy9i5An7ghRnoKqM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 01, 2022 at 09:55:18AM +0900, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > ...
> > The same comment as the previous one applies to "test_cmp_rev second"
> > check.  I think removing them would make the tests better.
>=20
> I will queue this on top for now.  Thanks.

Just to clarify: do you want me to send out another version with your
changes on top or should I consider this done?

Thierry

>=20
>  t/t4150-am.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git i/t/t4150-am.sh w/t/t4150-am.sh
> index d77c4dcefe..50b257e43f 100755
> --- i/t/t4150-am.sh
> +++ w/t/t4150-am.sh
> @@ -356,7 +356,6 @@ test_expect_success 'am with failing applypatch-msg h=
ook (no verify)' '
>  	git am --no-verify patch1 &&
>  	test_path_is_missing .git/rebase-apply &&
>  	git diff --exit-code second &&
> -	test_cmp_rev second HEAD &&
>  	git log -1 --format=3Dformat:%B >actual &&
>  	test_cmp msg actual
>  '
> @@ -401,9 +400,10 @@ test_expect_success 'am with failing pre-applypatch =
hook (no verify)' '
>  	EOF
>  	git am --no-verify patch1 &&
>  	test_path_is_missing .git/rebase-apply &&
> +	test_path_is_file empty-file &&
>  	git diff --exit-code second &&
> -	test_cmp_rev second HEAD &&
> -	test_path_is_file empty-file
> +	git log -1 --format=3Dformat:%B >actual &&
> +	test_cmp msg actual
>  '
> =20
>  test_expect_success 'am with post-applypatch hook' '

--gy9i5An7ghRnoKqM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmOiz/kACgkQ3SOs138+
s6HPIA//ZqH7hQgxSFAHiHMsbZRu5ASEH3AGcc8EfeaC8yCTlitXhPRK2rjUi0tQ
dtoRtcc4Xrxn34aU7vfiM06LGSssV8GilCKv+qP99BK/hqGvJXxIY9IR3BK7zQg0
2Q+NkR71hRDUOhFCOq5snaYkcgdz8wEpX11Z4QX911lna8jHoWB5kYdLVvuUZ5aU
YUwniz8HD40rH6Fc2bk1yBDK0ByiXPRFYNtcCto28ETNINabI6lJ15q2CMH2uxGK
OugpglxnESdddL+4/c5iwJsb/dPAMOg8g/UDl6Wb2ZyvFqIH5d7U+I6u2NFPR67d
i9ryPsHh6PMVS/giN/tdMJ10UajkEbsoF6XnPI24c1Zi1TtYuyqyhODIphNkEJL4
vVh0ChqVtn0FTSXsc0m/7q34OfN43+214IrYRMlXSw9Mg01b/NP1VgzfjCN5jPJd
ljPCu7bf5VIWt9ML+hiOfvMzzTwweg7E/SDHkjQYWzt5Qc/WGG6OOQIL/G0Qw8tM
WVizDrYIOJug4Ol2RDZxMPnZaGsM1NGyqFFf9RGDa5RRWLpUnz3/ERpmJHTkJyZi
DLnUoXnvKL3GSMi8Nn0++iOWT8ak62tfZ7xNbbLZtZYdOUZP49Avh9GQDIukOC9Y
FHSpL8bH4Yc18m5cwqcf30jEnpVi3Ol2UpGzC84rFC6TsaLUpkI=
=SOCB
-----END PGP SIGNATURE-----

--gy9i5An7ghRnoKqM--
