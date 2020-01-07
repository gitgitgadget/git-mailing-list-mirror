Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488F1C32771
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 01:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F812072C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 01:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="E7vDNeiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgAGBIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:08:17 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60640 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727295AbgAGBIR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Jan 2020 20:08:17 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 18CC260482;
        Tue,  7 Jan 2020 01:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578359296;
        bh=OoPHPsYeHWjkABSaFlK7I7idLWxwHn9PAlbuX5rr6kA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=E7vDNeiz+c/TyFReask77zzv+tXLl0JM0LGO3LNLokwFj4Ap7d+0GAXZ+tycbgTZl
         N7fQfSb08wcmCinYSJ8MS7AnFcpUcKT2DUha474bOf8emNU4mnIY4siyrUej6cSPwe
         ZKa5nL/SEVLVlWLGBWGkY5La8m9Wj4TuDZD4oNNmo5ZuMv2vYdWTBxZs51+pWqhIJv
         HR1yyeUexA9CESMITFEGlh5hHQD+mSvA7+p3oeHj+8NjShTqy2KsUK4+6EJ+7IW6rm
         uT5R0H5OTcTSeEDPnMyMzB0u/yqAdAludQYNars779Cry9AQHj13HORvjySxf7ZsOI
         4zISnrI98UfkScArP6NtD/RFegSFOCWv+eSuD2plcwBYxi+zleef/Uv5CfjtILMdCP
         n70y9Nc+aUbVnvnGTDqQneru5/JFlFjaHG0k7Y3MPJgI9GNSwzO1F5ZVJem0xnLkyy
         xLK4fUpw1H7I9A5CjM8sQ6sSs8JaMrZURmM3NEbvrwPko1W9/i0
Date:   Tue, 7 Jan 2020 01:08:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     "Miriam R." <mirucam@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [Outreachy] Return value before or after free()?
Message-ID: <20200107010809.GH6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, "Miriam R." <mirucam@gmail.com>,
        git <git@vger.kernel.org>
References: <CAN7CjDDBA0ZoCG9aaQf5rg3gxqny=EjR6v6jE1mnxvUJQSF_0Q@mail.gmail.com>
 <20200106213051.GD980197@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G3juXO9GfR42w+sw"
Content-Disposition: inline
In-Reply-To: <20200106213051.GD980197@coredump.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--G3juXO9GfR42w+sw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-06 at 21:30:51, Jeff King wrote:
> On Mon, Jan 06, 2020 at 10:15:53PM +0100, Miriam R. wrote:
>=20
> > in run-command.c file `exists_in_PATH()` function does this:
> >=20
> > static int exists_in_PATH(const char *file)
> > {
> > char *r =3D locate_in_PATH(file);
> > free(r);
> > return r !=3D NULL;
> > }
> >=20
> > I wonder if it is correct to do return r !=3D NULL; after free(r);
>=20
> It is technically undefined behavior according to the C standard, but I
> think it would be hard to find an implementation where it was not
> perfectly fine in practice.
>=20
> Ref: http://c-faq.com/malloc/ptrafterfree.html
>=20
> I'd probably leave it alone unless it is causing a problem (e.g., a
> static analyzer complaining).

Unfortunately, compilers have gotten much more aggressive about assuming
that undefined behavior never occurs and rewriting code based on that.
clang is not as bad about doing that, but GCC is very aggressive about
it.  There are multiple instances where NULL pointer checks have been
optimized out because the compiler exploited undefined behavior to
assume a pointer was never NULL.

In this case, the only case in which we can safely assume that this
behavior is acceptable is that r is NULL, in which case C11 tells us
that "no action occurs" due to the free. So the compiler could just
optimize this out to a "return 0".  Just because it doesn't now doesn't
mean we can assume it won't in the future, so we do need to fix this.

I'll send a patch.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--G3juXO9GfR42w+sw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4T2fkACgkQv1NdgR9S
9oupUQ/6AigY5ORFJ2W5O99LbKxOfKynkyUPQ6s/qHSf2jscUc3rUMd6ES4izxIa
YSmHx8MrMuENNoBHT29diLoTL1Qfj8Et280QdUDm5gZPz0vsLw8y4jKPkFxwyZ0g
+pO3tTYKy83C4/MwtT9Tp47KPgmiLYDszAWAsCVjqxBytIGnTV7i5X7eZJEsaDGh
MwYZxNbBydWOZBmSVIeAaKYtGI1AbZ7NHqeved0qQyWoppu5Ij98X/PxYSI6HLSn
oSB+5b6l3loEml5qc/hwbW4vVmIcWjO+P8Hu8ok+OjwR75ovv0kHQytA1qotXkb+
2fU7lQQNfJQMlLO8/eH5edCa4pSyDjQvXBLRLI4eNVQY2f71NKRGo2njlCUJVhSW
iyVzvTw2aHOTcSW3eO0OO6d61Ow94I2vuUWk+alj1u4UTIZ0AjIvIVwYB3cMrUGv
iwjFhnABwVWM7heYoSoIeXdCRlYY57QVEblUWrVjX+ostPFQhBTC94scukCextCS
VTD15eTDkleL8aMQZdJHkKxjggZemsdGcdrVsMvN/tGcFpP98ltIrcYg5nWJssIc
eQr8Lec9/CKfbsZ0SfdiNFSEaDECF+wpeCdnzGKkCIRSc/aRr1p7DCYV/Q2H7XFs
Sz1u7irA2maJ6CvYRZEgU9+BphyCX4NkYRH2n7egzistSvV2UKc=
=Sz2k
-----END PGP SIGNATURE-----

--G3juXO9GfR42w+sw--
