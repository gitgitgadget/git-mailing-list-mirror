Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53ACC2D0A3
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 02:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C13205ED
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 02:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgKJCg1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 21:36:27 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37948 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728066AbgKJCg1 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Nov 2020 21:36:27 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CA8CB6045A;
        Tue, 10 Nov 2020 02:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1604975786;
        bh=TouxPynUOS/0czo/geZeXFzm8OH7/AXrZk1sH6chbxc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=kY87qV+z/Aef5wnXNRIZ30mb7Ri+io6VhYB8OCLSfTU3FXhhKqCqXuBlcZu4Uhl3f
         Cn3R3kf45P6nj3z1713J1GaUKPD2usaBO2UVcqnVsT95KPAIqlt3WzIO0pDirH94i9
         CFrN20S1wJZHoxvmYUuko2XcjGGCUHGTHiZr6df917VAKuBDyZ4v4LciDqNuyR76re
         8GZziNosoJ3S9bXlowCYtsVGjXKmZXh36MtH3qPX5hMeYPvyrUXhmX3fe1eRUk40gu
         ujoRrosQfWywSAzB6waVelSLlH6yUSuFGPc8KzMKbd+dsRqqGEVaDJoFm5TQLmMJYW
         5Sy7xdsEfmA+2kBswmMp5d0xh61bnL+TgsW8l6dU6AGMa5KFICBcLbemBnmbPTrh7e
         kKAfAOdYMg2bhcIyuf7wkCXkM1pdlkDH8SUxoaANiM2mtOfp73R4V4w2Jdz8pF781c
         HppqSSLEFNlaTPB5Txfofo+PMigh03GxdgHcTu6kX1cjx20T2HZ
Date:   Tue, 10 Nov 2020 02:36:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Daniel Gurney <dgurney99@gmail.com>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] compat/bswap.h: simplify MSVC endianness detection
Message-ID: <20201110023620.GH6252@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Daniel Gurney <dgurney99@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de
References: <20201107234751.10661-1-dgurney99@gmail.com>
 <20201108095739.23144-1-dgurney99@gmail.com>
 <20201110003127.GA1268480@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6lXr1rPCNTf1w0X8"
Content-Disposition: inline
In-Reply-To: <20201110003127.GA1268480@coredump.intra.peff.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6lXr1rPCNTf1w0X8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-10 at 00:31:27, Jeff King wrote:
> On Sun, Nov 08, 2020 at 11:57:41AM +0200, Daniel Gurney wrote:
>=20
> > Modern MSVC or Windows versions don't support big-endian, so it's
> > unnecessary to consider architectures when using it.
>=20
> This made me wonder if we support any non-modern versions (which would
> be negatively impacted).

I'm pretty sure we don't.  As I said, we're using several C99 features
and that version precedes the C99 standard (and 1999).

> From the earlier thread at [1], it sounds like probably not, but I
> wonder if we can offer a stronger argument there (or just define
> "modern" a little more clearly).

According to Wikipedia[0]:

  Visual C++ 2013 [12.0] finally added support for various C99 features
  in its C mode (including designated initializers, compound literals,
  and the _Bool type), though it was still not complete. Visual C++ 2015
  further improved the C99 support, with full support of the C99
  Standard Library, except for features that require C99 language
  features not yet supported by the compiler.

The version mentioned that supported MIPS, Alpha, and m68k was Visual
C++ 2.0 RISC Edition.  While Wikipedia doesn't mention its release date,
its successor, Visual C++ 4.0, was released in 1995.  The m68k version
ran on Macs using those processors, and Apple abandoned m68k for PowerPC
in 1994[1].

I'm entirely comfortable with requiring that people use a compiler and
operating system newer than 25 years old to compile Git correctly.  As
I've said or implied in previous threads, I'm also fine requiring C99
(vendors having had over two decades to implement it) and only
supporting OSes with vendor security support, although obviously these
latter two items are much more controversial.

I'm fine leaving the commit message as it stands, given the brevity of
the patch and that in the technology field, the affected versions are
not in any way "modern," but of course I wouldn't object to a reroll.
It's fine, should that happen, to include any of this email in the
commit message.

[0] https://en.wikipedia.org/wiki/Microsoft_Visual_C%2B%2B
[1] https://en.wikipedia.org/wiki/Macintosh
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--6lXr1rPCNTf1w0X8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX6n8pAAKCRB8DEliiIei
gXF9AQDt6Na60PQtAIf2W8e7eZn5oqsoIGJJVDmWxx3v7XyuAgD+N2gI7AKWyP55
RzL6R189l2yEv1Is03ovOCoWt+4g/AQ=
=YSYC
-----END PGP SIGNATURE-----

--6lXr1rPCNTf1w0X8--
