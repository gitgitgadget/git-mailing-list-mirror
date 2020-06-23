Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0C5C433E1
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77029207FF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="iYrUj6ES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387718AbgFWVvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:51:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40152 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387690AbgFWVvP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Jun 2020 17:51:15 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7DE7B6048A;
        Tue, 23 Jun 2020 21:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592949043;
        bh=1P7ZNqverJg3O8alO/tvL/iheCle5Z9rKtYCxcjZ6Fw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=iYrUj6ESVx6gG8yf63gPFmtQrP0J4G/+xNLHMmZh6WsajcYtEKk2zPKDX0NhusgdG
         JMQdHP3lETY2bHaO3iwosZBNyDoresYpkXUOT60g4c10xC9UJOuHWWXk+aa3AS3bfY
         SzwOwCkCTQlPscn7j/mjuceDft8tqbAQ1V3mTCzDhMHCVGdkUiCsDIbPyp/jnqpvxV
         sW6SDGXm0Ux019xUo6YkHgkfymOaLTS2orFjTjaYbsfUtEG67H0Y5cGVEAeOhvtD3e
         whD8CJYIESOVzpiX16wMJyVY4S/8bCy7pOKm3DdnDJQ0ks02+fZ9T34qTMPq/i62DY
         u5kISQBfJHcihVtKINQjkbj7Y0HaADBnJVqzE1SWLIvOAc5mENeNSUVMAqsQ4Qyi5d
         YtKPxIM1D26xHCiXO+sDVfbGJUw6IKwMhevT64jEVvpxnepX6tJq+O/WQO1zLBOhdV
         hHmzkXkL6edSd0OVqO+qGn/tkUxT2YTGxtptogFq919yZ6i54/3
Date:   Tue, 23 Jun 2020 21:50:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Ward <mward@smartsoftwareinc.com>
Subject: Re: [PATCH] http-push: ensure unforced pushes fail when data would
 be lost
Message-ID: <20200623215038.GU6531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Ward <mward@smartsoftwareinc.com>
References: <20200623010519.GR6531@camp.crustytoothpaste.net>
 <20200623202129.2616672-1-sandals@crustytoothpaste.net>
 <CAPig+cSPwR_0xR5X50dbBAJ9EJKqP7Vyu_e3jsq_WOg=B0tKXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tYlHSoJ8Aop8eNG2"
Content-Disposition: inline
In-Reply-To: <CAPig+cSPwR_0xR5X50dbBAJ9EJKqP7Vyu_e3jsq_WOg=B0tKXQ@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tYlHSoJ8Aop8eNG2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-23 at 21:28:43, Eric Sunshine wrote:
> On Tue, Jun 23, 2020 at 5:23 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > When we push using the DAV-based protocol, the client is the one that
> > performs the ref updates and therefore makes the checks to see whether
> > an unforced push should be allowed.  We make this check by determining
> > if either (a) we lack the object file for the old value of the ref or
> > (b) the new value of the ref is not newer than the old value, and in
> > either case, reject the push.
> > [...]
> > Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>=20
> Do you want a "Reported-by: Michael Ward <mward@smartsoftwareinc.com>"
> in this vicinity?

Yes, we do.  Thanks for reminding me.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--tYlHSoJ8Aop8eNG2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXvJ5LgAKCRB8DEliiIei
gSD0AP9aYB7du/WA1wqODAA0RNW/ycqPqiHTHKEadFvhocY+BgD/Qf00meYOADud
SwGhn+s/Lz6KyxCykwAnUyevqpqPagA=
=+LGv
-----END PGP SIGNATURE-----

--tYlHSoJ8Aop8eNG2--
