Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB79C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 19:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A6B02084D
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 19:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zPcfKpLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbgFWTOV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:14:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40132 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387449AbgFWTOS (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Jun 2020 15:14:18 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DFE5660436;
        Tue, 23 Jun 2020 19:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592939627;
        bh=o5myxP9sEV7B8YYAs3NYC5YXBSy+4/pbFGUcUDC2ILY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zPcfKpLhY9RC1O+ZSaL+dHLt8IiRhoFoaTskRRcYRr30BhCiCzw/x4Jd7CXeaWRKI
         3sKfZkVwIHE5FUKh3lzfcexIDha2kg9iqnReBSi0Yc4rxhdC1FoxBB5zcOmz9e7PyK
         afv6BYnViPUqsIFbOGaEohG2D0qzR6ti54XKHqUlg+Gi/f4cKljdxjOqkb+pvafTe8
         Y63o1cEMNoh/3QQkFXuDn4u7erxkbjunB9W9Fq9MOmEB4qPMG3uxZ7WKAkFU2tJFv0
         3EHkVs9EzChOGsXjD5kdJJpsWEuzG1EboZeBuUq4z+D6CJmRzChnyVBold1/+gDNRK
         DWeZeRKZrVF/u1j1gBMpzxEXGUQWdzun2U0H8HxK/tR5CstesP2LlMZAGacX67+SQg
         +T+DyeWIQxSW47YjAoFx2uIsDjN9dfu7gKo/pqO9tAHIU8ilPsYu1se62ZdfKdg7uF
         wtahqdCmeAd3EF5Tg85HH81Q0bvRglOR1IbloWSJiPvvUisL/Dc
Date:   Tue, 23 Jun 2020 19:13:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Michael Ward <mward@smartsoftwareinc.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: Re: Git 2 force commits but Git 1 doesn't
Message-ID: <20200623191339.GT6531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Michael Ward <mward@smartsoftwareinc.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>, Jeff King <peff@peff.net>
References: <20200622202122.GO6531@camp.crustytoothpaste.net>
 <a42d038f-bf14-8f1a-927e-7488796e7710@smartsoftwareinc.com>
 <20200622204346.GP6531@camp.crustytoothpaste.net>
 <8ad16219-2426-6127-b41d-bb3007a9b993@smartsoftwareinc.com>
 <20200622210953.GQ6531@camp.crustytoothpaste.net>
 <2e43580c-9952-9ccf-6b35-27a4333fb83e@smartsoftwareinc.com>
 <20200623010519.GR6531@camp.crustytoothpaste.net>
 <09a7fa54-d7ae-772c-fb36-29dbd27bc626@web.de>
 <20200623151951.GS6531@camp.crustytoothpaste.net>
 <83e99359-2c24-d8cd-bd4a-6ba90ed54b7f@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="B0+HW0pjZ+2jqF7e"
Content-Disposition: inline
In-Reply-To: <83e99359-2c24-d8cd-bd4a-6ba90ed54b7f@web.de>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--B0+HW0pjZ+2jqF7e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-23 at 16:42:48, Ren=C3=A9 Scharfe wrote:
> We could save 4 bytes on x64 by reducing FLAG_BITS from 29 to 28, by the
> way.  Increasing it to 32 would be free.  That's because parsed (1),
> type (3) and flags (29) currently occupy 33 bits, which are padded to 8
> bytes.  And bits 22-24 are only used by builtin/show-branch.c, so it
> should be easy to tighten the flags range just a bit.  Weird.

Actually, as you've just shown, we're already using 8 bytes, so
increasing FLAG_BITS to 60 wouldn't actually allocate any additional
memory.  Unfortunately, C11 says that a "bit-field shall have a type
that is a qualified or unqualified version of _Bool, signed int,
unsigned int, or some other implementation-defined type," so using
uint64_t here wouldn't be portable.  So in that case we may want to
shrink it to be just 4 bytes.

> > Assuming we don't want to do that right now, may I have your sign-off
> > for the following code, Ren=C3=A9, so I can add it to a patch along wit=
h my
> > test?
> >
> >> diff --git a/http-push.c b/http-push.c
> >> index 822f326599..99adbebdcf 100644
> >> --- a/http-push.c
> >> +++ b/http-push.c
> >> @@ -70,10 +70,10 @@ enum XML_Status {
> >>  #define LOCK_REFRESH 30
> >>
> >>  /* Remember to update object flag allocation in object.h */
> >> -#define LOCAL    (1u<<16)
> >> -#define REMOTE   (1u<<17)
> >> -#define FETCHING (1u<<18)
> >> -#define PUSHING  (1u<<19)
> >> +#define LOCAL    (1u<<11)
> >> +#define REMOTE   (1u<<12)
> >> +#define FETCHING (1u<<13)
> >> +#define PUSHING  (1u<<14)
> >>
> >>  /* We allow "recursive" symbolic refs. Only within reason, though */
> >>  #define MAXDEPTH 5
> >> diff --git a/object.h b/object.h
> >> index b22328b838..a496d2e4e1 100644
> >> --- a/object.h
> >> +++ b/object.h
> >> @@ -67,7 +67,7 @@ struct object_array {
> >>   * builtin/blame.c:                        12-13
> >>   * bisect.c:                                        16
> >>   * bundle.c:                                        16
> >> - * http-push.c:                                     16-----19
> >> + * http-push.c:                          11-----14
> >>   * commit-graph.c:                                15
> >>   * commit-reach.c:                                  16-----19
> >>   * sha1-name.c:                                              20
> >>
>=20
> You're welcome to use it.  Not sure if a sign-off is necessary, but
> here you have it:
>=20
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>

Thanks.  You did the work here and I'd much prefer to add your sign-off
to give you credit for that.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--B0+HW0pjZ+2jqF7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXvJUYgAKCRB8DEliiIei
gdhDAQDfW1X0y10ao63tooV5NqnDX/ZrIPdPNBvoW9Yrb+sKMwEAhr6AEJ66Z+r9
eG7d6QTb3+PLOR0bI2hW2zb8qticIQU=
=ZWHI
-----END PGP SIGNATURE-----

--B0+HW0pjZ+2jqF7e--
