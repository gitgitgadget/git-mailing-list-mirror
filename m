Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90844C433E0
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 19:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB056148E
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 19:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbhCMTmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 14:42:38 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39854 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234385AbhCMTmR (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 13 Mar 2021 14:42:17 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0671A6049C;
        Sat, 13 Mar 2021 19:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1615664536;
        bh=HfHVxITHouypiMdqnIzi324qmJ6PXmVSDYktewaVBZM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=jNLvcKTFtzH9JB2xc60QvwmcwffVSoTVq4Xz6p4Lc4m5KaeFez6LkjA91pejdUmTv
         up19AUpsLSODWgDxU2SR7TEeCSRhTfeq6t9rQOhWjbIz6xb6Y99/ngz3pDPsdoq+gZ
         bzx5kxHp2kTD3cYvT18jLmzmmqNzz25ghGCBRgBB9poL4rkcc5rmvRkUpsn/+vse8G
         94RII7a1gBx2HuW9SJN0N9XgIzxIoNFbBvDFpMx1SA+3XU9TDu4MCk05hclmIK+hNs
         gTDu9I7i4CrfEpDZaTeQ9RSxn6eV8g4B01ftaBGP4pk03H/cUbToqrXFUSL4ud5SGz
         hFDWhtSwSi45uf2fZX4Jh/wJ1F8fcdMX6zaFZJ6Nqfbo5KQyS+00kZWhxVP1JnE9L1
         Ii1Ezmpe019IQT5pfAmHqUL6uQtJuk4MkQY7zKyQSai90565z1WrPy4xlnZgaEIO54
         I2dQZ5hLSlW2swowQz57O+ui9iYppA8EvaEw9ZiDFxQgTRIDuE4
Date:   Sat, 13 Mar 2021 19:42:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Submodules and SHA-256/SHA-1 interoperability
Message-ID: <YE0Vki0HNOYhYIYh@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <YCmbKrTsJhgPHYLc@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2103011621000.57@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vzAcya8K64+zjGfX"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2103011621000.57@tvgsbejvaqbjf.bet>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vzAcya8K64+zjGfX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-01 at 19:28:13, Johannes Schindelin wrote:
> While my strong urge is to add "Remove support for submodules" (which BTW
> would also plug so many attack vectors that have lead to many a
> vulnerability in the past), I understand that this would be impractical:
> the figurative barn door has been open for way too long to do that.
>=20
> But I'd like to put another idea into the fray: store the mapping in
> `.gitmodules`. That is, each time `git submodule add <...>` is called, it
> would update `.gitmodules` to list SHA-1 *and* SHA-256 for the given path.
>=20
> That would relieve us of the problem where we rely on a server's ability
> to give us that mapping.

This is true, but it ends up causing problems because we don't know
where the .gitmodules file is for a given revision.  If we're indexing a
pack file, we lack the ability to know which .gitmodules file is
associated with the blobs in a given revision, and we can't finish
indexing that file until we have both hashes for every object.

While we could change the way we do indexing, we'd end up having to
crawl the history and that would be very slow.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--vzAcya8K64+zjGfX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYE0VkQAKCRB8DEliiIei
gSyHAQDiBAijY2QfSqgaAKPflHxWCWmpXdC8AcGFjJvx5nYaeAEAs2y0XNplnPEb
8wBImiEaaHvBAXHjrzBDXO3um0mgqgQ=
=E8J8
-----END PGP SIGNATURE-----

--vzAcya8K64+zjGfX--
