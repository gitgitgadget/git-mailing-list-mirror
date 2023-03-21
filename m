Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966F7C6FD20
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 19:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCUTW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 15:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCUTW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 15:22:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9E81BEC
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 12:22:24 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j24so5937558wrd.0
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 12:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679426543;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2q9vBGaPLKeG356VCsL2YwVbFYcsFaNQe8T8xTItVM=;
        b=qCte3lrRnqMgBKAQU1iwqQwJs/Kbswylrjs+5+9QA4JQGi0ehnu4sqwSoeTmDEW90J
         6s3xoOuMAR2Gv4V4B7qNIthxbVovtgrNn5Ir4EZoepqBng8gYxM5Xzvm9VPXXE7eHtBi
         ulaBHYaXuhVan/9DR4GXG8dM6ChubpmvbPdBk2Ho/vcK+cjmc85u/HNEBk/5mmH9vQqo
         sUhIjHpsxUzQSTAavz6oUNJ9kdx3sNYtxVBZkjxyTVU1P4TnG36fhYVaYeNc8IT7jHJo
         YrtsjYA3V0k5pkC7U8EEbMHGF0HmFq6m/G94gUa5+tcc+SXE0BiZgO58AevRUTbt9vDH
         uRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679426543;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m2q9vBGaPLKeG356VCsL2YwVbFYcsFaNQe8T8xTItVM=;
        b=TaXKJnyrji/55OE031iYlE4kBwlTKGKPv56FfJr3OLvYrRg4o0mrlA/DdfoeiQAoRx
         kkt63wQWxyLEkkTG/7J79LKY9tVPjndhpWgf60HtDmo6CzBuw1zutTBljUs9/Fwe260i
         RJD68ljjViRwyYiP4PC7S/xwuPUkf+w0geDHhMFrM/dkygJmNJEOCgbvMquKefHPgr+p
         MsRfWZOdSPxJ0OC4ztZLbgTYEEIY2eQsOihbx53XoEWsUeRDGrKdl9ukfBFf2cr1z4Vn
         NFwxV5FynpyUuA8h+mTwFBXSZ+R/Ws9Eu4Npu3Svwil1fG784uJgsHBDQ6vNsK2yWaU7
         HomA==
X-Gm-Message-State: AO0yUKVLc9kgxpyewINixNNXEZpenUYfjfNNoRtikbMLW2+NxM8RxcYZ
        IbQgArnOhuAAzm/LTV5qCIg=
X-Google-Smtp-Source: AK7set9LQn8HfZU3JyTrsfnz9ZA3HUhaZpk0tZI8QlyIJw6E+/qXMBnnQflmmh8QFHTDyG2d/Gr/FQ==
X-Received: by 2002:adf:efd1:0:b0:2c3:dd81:49ad with SMTP id i17-20020adfefd1000000b002c3dd8149admr3393023wrp.33.1679426542787;
        Tue, 21 Mar 2023 12:22:22 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.51.134])
        by smtp.gmail.com with ESMTPSA id v3-20020adfe4c3000000b002cf8220cc75sm4086189wrm.24.2023.03.21.12.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 12:22:22 -0700 (PDT)
Message-ID: <6a1bea28-ed50-f32b-35ef-ef12f16e2878@gmail.com>
Date:   Tue, 21 Mar 2023 20:22:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: .gitconfig: -c core.pager='less -+F -+X' status
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <92e2b9d2-e259-6bba-7080-28a01c0d323c@gmail.com>
 <20230321184210.GM3119834@coredump.intra.peff.net>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20230321184210.GM3119834@coredump.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3QUO7wOGQzTyTFEgABkffw0J"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------3QUO7wOGQzTyTFEgABkffw0J
Content-Type: multipart/mixed; boundary="------------mRSno6bb3pEvS258jRhVMn2T";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Git Mailing List <git@vger.kernel.org>
Message-ID: <6a1bea28-ed50-f32b-35ef-ef12f16e2878@gmail.com>
Subject: Re: .gitconfig: -c core.pager='less -+F -+X' status
References: <92e2b9d2-e259-6bba-7080-28a01c0d323c@gmail.com>
 <20230321184210.GM3119834@coredump.intra.peff.net>
In-Reply-To: <20230321184210.GM3119834@coredump.intra.peff.net>

--------------mRSno6bb3pEvS258jRhVMn2T
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On 3/21/23 19:42, Jeff King wrote:
> On Tue, Mar 21, 2023 at 03:24:53PM +0100, Alejandro Colomar wrote:
>=20
>> Hi,
>>
>> I wrote recently some aliases to not clutter my screen when I want to
>> check something quick:
>>
>> $ head -n4 ~/.gitconfig=20
>> [alias]
>> 	df =3D -c core.pager=3D'less -+F -+X' diff
>> 	sw =3D -c core.pager=3D'less -+F -+X' show
>> 	st =3D -c core.pager=3D'less -+F -+X' status
>>
>> Now, `git df` and `git sw` work as expected: they open a less window,
>> and it's later closed with `q`, with no traces in my screen except for=

>> the command itself. =20
>>
>> However, `git st` doesn't seem to work.  It prints everything to scree=
n,
>> and then exits.
>=20
> git-status doesn't invoke the pager by default:

Ahh, sorry, how could I forget something like that =3D)
Probably some brainfart here between chair and keyboard.

>=20
>   $ git -c core.pager=3D'echo foo' log
>   foo
>=20
>   $ git -c core.pager=3D'echo foo' status
>   On branch [...etc]
>=20
> You can configure it to do so:
>=20
>   git config --global pager.status true

Hmm, I like this.  When status grows hundreds of lines, it's nice if
it only shows the first screen by default.

Thanks!

Alex

>=20
> Or if you just want it to happen in your alias, try:
>=20
>   [alias]
>       st =3D -p -c core.pager=3D'less -+F -+X' status

>=20
> -Peff

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------mRSno6bb3pEvS258jRhVMn2T--

--------------3QUO7wOGQzTyTFEgABkffw0J
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmQaA+YACgkQnowa+77/
2zL2Ig//Si9L6JE117/UqdVSPO3J38Js0ELwzZ1cKH5Da0vNjg4DpI41qmOWAFYA
6v/8oFrHAdwFUfvWfqgOYf0v9txzZTcAZVQwZ/Gwo/KKzOotJcTFJpSXGxjh6PBK
1ojxFMKlrfAJFg2c/CqYrSsKVErkWPrWPqwWEMp5J09M/H7XPQB13ujBknkGWIWF
9PCcgZdYFMVtfWhYTCNS3xv+qW7caguTgG3pRwPvxIpLHrMxjqzlo6JaYV83ANQB
PMiIx7ya1gfax0792GdF+tLG8X3rVPVq9nJ4yX+wWSR4xbG1roUnPaPUFIOwcb2F
ziUtyl5nAzuP3dpjIR8V2dNbvEypf807N/Y69Gc2enDa7c0NoIKQWgL8ZaPOUsyy
xdyFz5G4w31TC9kGZvukRY/qhl4de4oeMbEFAcwzgQI9DRIgea+jBFN0UHdKY1Bi
pVM7ZIcYvjKcbUPpuP7zifW15Q6UzJItTfboazcMn38d7nvBsunujrAubLPZuCvA
uN0SDZ6Dk79Yt6rSCBKMVMKpCaoa/oSuyoMTblx0PtVs6zjGIYFqzzVT9QXttA11
WG6Ake6Qe8pVQi3Mq5UDi+eXvBFhGKx0yY+NVO5B7NOUuotD+r0aUBMv6EfcP3vR
ppG2QWcALnrXuJEz8/xvn1RPZwx04yieJaKG1IJKgLuPihZPGZY=
=gAJG
-----END PGP SIGNATURE-----

--------------3QUO7wOGQzTyTFEgABkffw0J--
