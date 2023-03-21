Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DD4C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 14:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCUOZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 10:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCUOZo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 10:25:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D98869D
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 07:25:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l12so13880220wrm.10
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 07:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679408702;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xr1L697rISZfskqo9oULlB2vrlTqAnS8tUmkktffeBM=;
        b=nqAhrSk2gJFN+wc5x36Mz04Q4yfq7RO8c3Rctzog8dqg+tXScpXOfOtsiVkSJ1V/mB
         bwn9CgDh3FquSefuY/Gh4293Mv1I/4OPrIm2Bsve+BWDHg5lGhnhQF7N4aaGAKr0PcCY
         57b5FNaEVAEnLS3RGhN4ZFeG5DIaWIqYcNteqf4b8iMLHZT3rcyD2fpnItZtAG3Vw/C3
         tRLTP/04wGddIj6gng5GaY5Rq6oZkXlaCV38hMuJ70dQSYF/QPVRLvspqYTD7JH6N0o5
         qaE4CSzyvgu361/1joG/JWLjG5IxoeNt2lI0hxQygCsxUu7D2EyXnllOPvtqnW2xPbue
         5czQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679408702;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xr1L697rISZfskqo9oULlB2vrlTqAnS8tUmkktffeBM=;
        b=VtsHOlN/k4BXk0Nn7TZmZpk7E+YpcoNb8tA3QqAXlflvQCJ5y7YUsEHuDR72J4akXg
         1KFrvvx2APgoDw2nsphrTy9wlOPvifHKDoFAWH8FxMQ+PDMXdaHX1pSxfs66fphjNWjC
         wRXNr7i6LZgBSmXNqAOqHuZPeOns4yjM1amc/EGts5yD3wG1nVDdvQ5Jg6FZDwHXhFjM
         OwWruAkSTczIrmZ1a1apSjF1u2QXGj3GMQe0VlMJ0OWoOkTLiu3KerkbPxDU06mj8xeA
         nonGuQ/aEiFIRG0V2SkzyQ0lO+6Le+nIXS2xI2js2rQHgCyqbrAXBdRjcMOglyxlsgGL
         Q/cg==
X-Gm-Message-State: AO0yUKV9xDezOI7OVdyZDClAVti8l0cB8B2MCflU67GJmgz292HSLtea
        LpVdhNIFcimweOTp/vbc4I8TQKJYEmM=
X-Google-Smtp-Source: AK7set+hK/N7ZRwK5ctfmlpoTtD3/Iortt6lnT9YWVOvlsZ/gu0hNFGg8ilwBH4GtltcBV4ZKzEMVA==
X-Received: by 2002:a5d:6b0a:0:b0:2d0:8e61:959c with SMTP id v10-20020a5d6b0a000000b002d08e61959cmr2511312wrw.20.1679408702278;
        Tue, 21 Mar 2023 07:25:02 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.51.134])
        by smtp.gmail.com with ESMTPSA id a7-20020adff7c7000000b002c70ce264bfsm11544846wrq.76.2023.03.21.07.25.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 07:25:01 -0700 (PDT)
Message-ID: <92e2b9d2-e259-6bba-7080-28a01c0d323c@gmail.com>
Date:   Tue, 21 Mar 2023 15:24:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Alejandro Colomar <alx.manpages@gmail.com>
Subject: .gitconfig: -c core.pager='less -+F -+X' status
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------kjm45tDL8kQ5k3LcQ7XACfcf"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------kjm45tDL8kQ5k3LcQ7XACfcf
Content-Type: multipart/mixed; boundary="------------UG3qGSe6A00OTu9ktY2YZLHf";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Message-ID: <92e2b9d2-e259-6bba-7080-28a01c0d323c@gmail.com>
Subject: .gitconfig: -c core.pager='less -+F -+X' status

--------------UG3qGSe6A00OTu9ktY2YZLHf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I wrote recently some aliases to not clutter my screen when I want to
check something quick:

$ head -n4 ~/.gitconfig=20
[alias]
	df =3D -c core.pager=3D'less -+F -+X' diff
	sw =3D -c core.pager=3D'less -+F -+X' show
	st =3D -c core.pager=3D'less -+F -+X' status

Now, `git df` and `git sw` work as expected: they open a less window,
and it's later closed with `q`, with no traces in my screen except for
the command itself. =20

However, `git st` doesn't seem to work.  It prints everything to screen,
and then exits.

You can reproduce it on the command line too:

git -c core.pager=3D'less -+F -+X' diff    # OK
git -c core.pager=3D'less -+F -+X' show    # OK
git -c core.pager=3D'less -+F -+X' status  # Not OK

Cheers,
Alex

P.S.:  While sometimes I want to check quick something without
cluttering my screen, I don't recommend anyone reading this to run these
aliases as a norm.  I prefer using the ones that leave traces on the
screen, since that way it's simple to recover from rebase accidents,
which at least to me, happen rather often.  This is only for cases where
I have something important on the screen which I don't want to hide
(previously, I would open a new terminal to check something quick on
git).

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------UG3qGSe6A00OTu9ktY2YZLHf--

--------------kjm45tDL8kQ5k3LcQ7XACfcf
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmQZvjUACgkQnowa+77/
2zKtXQ//U7voiArrgTa4yZUp/NTKIGmaY3N1D7BXY59ClTCYuGPbTbwiiUoL13Y0
5Q6hbbqbIb0mDroz7sSOZOpMiLd+xKB5PNEvno7Gx/IPKmLNZrRTB8H9BT743Whs
kw+pAVws3AaJY4Bl7Aa9Mw9neRS1Rh0T5DlatBWNhTmVRDFaOmKRU8Y6uwF3XrPv
C0FVvpfC+8Vf5nBSOih4be1+3cYl/CzToSp+CVFzAoUN5q+46J4iyL9XKooWEFnX
9LZi84PVlOaHdB/w3HlsaAS1JlUiMhP8mwhu4R/fjIyUL2G9vXDUqtbhF5OE7AyZ
h6Vt+vVHYnNgUAxGkXIPGQKfxxIhOZVdJv40ot9WOFPO3OJyXjUcfIKMGB8lPXsC
l9Vn3tGPwHhK8KWYIyRl7S0lOWMf4cHZQChhWi4WbVsL2kl021dLNzggHVcB0vwt
dTfIah5U1s8cXO26TtiSPB7Yl6ZUJJ3G+NOU+TfQnzXpfXnJYuLGno+uAkbjXDk1
ZlRY2gdxPWYLbnQ/VWplaX+iHTC1V4LPbRG/QOUojIxLpbfvBiyxjP312v7eh4wS
gUBG54sYlFq3Y37tQpXbRigxzk69nQEWTKIEBMSDzoec6GjI4RvNY6jK0QTGr+vQ
5i2+Itx/maL/da2aC8aNIMbqX4Tq+1n/6t/80pxnbgJ3C92bXjc=
=6fGH
-----END PGP SIGNATURE-----

--------------kjm45tDL8kQ5k3LcQ7XACfcf--
