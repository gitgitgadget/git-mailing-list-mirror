Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9611C433DF
	for <git@archiver.kernel.org>; Thu, 14 May 2020 22:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 780B02065C
	for <git@archiver.kernel.org>; Thu, 14 May 2020 22:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fqPUfnUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgENWzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 18:55:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38356 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728229AbgENWzU (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 May 2020 18:55:20 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A879360443;
        Thu, 14 May 2020 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589496919;
        bh=PxQmwKWYIiFk2JdrSuaRnmObhhKbW2yMB6vYKJNuqE0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fqPUfnUvV3ULIHlIhe2eepj4C/qF8MYWJmgdSrGkacRzJoxkRRSRhI4UCRowOHCUX
         6g/vNcQK/yiGL38P6I1h3qnFoFHIqfa3p7xMjB6LmWiY5cE3tfVI3+bbyJDOHAYdo3
         rWSdUOZquMD1/3Y5rMYUiKP8wfi7oCQQgGWrwk+vn98PkgdoAlFG4sCbhubkXtkCpy
         /L4x7SRtqrZCHZIBVZgORP7TPjmBLwKkF0Jfe41/4xOD32e+gz3ssELXpjloUjP9WK
         54VMbKKqwefLYoedxY6F4w2m3fqvdA1tHwetVNR0BwTOCtywSXvIPjLC2fZMGO5fxG
         UqDD6FiDkY3g5DUrAt4wgJ23T+XVe9kbY+cKZ+GGwFYL7c+KDik0pbm906jWd0v2uN
         k2NjnGVQzxFOEu0bS4UbWT9Ka2jOLB4AiN3zmpf5st5uk7puL6/Y9wgjGUTklcKW7g
         wp4kzHsCycfHJzQsssyxiYBofXUyu4rKir3k9ryFiwpedjkVRe5
Date:   Thu, 14 May 2020 22:55:14 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] t0300: workaround bug in FreeBSD < 10 sh
Message-ID: <20200514225514.GA6362@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, peff@peff.net
References: <20200514210518.56101-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20200514210518.56101-1-carenas@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-14 at 21:05:18, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> 4c5971e18a (credential: treat "?" and "#" in URLs as end of host,
> 2020-04-14) introduces check_host_and_path to t0300 and some tests that
> use it, but fail in at least FreeBSD 9.3.

=46rom FreeBSD's website, it looks like the production releases are 11.3
and 12.1.  9.3 is EOL and has been since 2019.  Since FreeBSD is not
supporting this release with security updates, nobody should be using
it.  In light of that, do we need this patch?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXr3MUQAKCRB8DEliiIei
gWCyAP99ytDLGyEiq6Lasehv+llM53Et+x8eSLZTaywByFDWIQEA/jZ81ZBWONTu
GRCYcGcB/IQ9LcIWZ75GfgrIWnKzNA0=
=IR6j
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
