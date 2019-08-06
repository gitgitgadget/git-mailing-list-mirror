Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59FBA1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 22:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfHFW7A (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 18:59:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57312 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725974AbfHFW67 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Aug 2019 18:58:59 -0400
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CC49C6047B;
        Tue,  6 Aug 2019 22:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1565132338;
        bh=L2JIYHIrZlOSTy1K6Dyf3xrNG819WDgJD8f+tcmAAFA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Hqn+6yaI/mjC4s1H2Wy4iPUAF441qdTIPS/ztPe4xmApZ85koD8ApbuLD6JsD1fxG
         IiqoyKkTj4vNR1KacbRiB/pTiOm0T3+N77eCoWkh2hKzBCT6GrwL4jIKWlIxpICHmH
         lXU614y2+F47Viy4IMjv1kD4PnEXA+PZjnAcC6lEPRLvBxSmkwTAv2QdEZO0Ku1vMs
         h6yR18aorNYcR5HhrVrBvCskJ3Ud/V4ey+XsBMWxHX2sAQ4GRaNsRWaPZmD/TBt7YD
         Rl++xuqjO/+65K1hFhPdEo0Sze7g8s4P5aR675vubUrzIxWsujUOCgoc0ukrjQvvuA
         N9QwqDDtxjvJUJ5uNzaQrI6lfGwB1EoXfaHEHYGUrEUDyFN5DeG8tcZ/M0RLaS/CWQ
         dW0TWBuZ3RRBxpBaWoVEargkfA6BhmOMbZ1SeexQOwhdMMHE0tM0LzFfyXq9HeGWig
         y4aC21ScID73MbcbdJmI97+17UqpF40LrvmVCEJxWlZBFVs68/F
Date:   Tue, 6 Aug 2019 22:58:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] --end-of-options marker
Message-ID: <20190806225853.GH118825@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20190806143829.GA515@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TnYVF1hk1c8rpHiF"
Content-Disposition: inline
In-Reply-To: <20190806143829.GA515@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TnYVF1hk1c8rpHiF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-06 at 14:38:30, Jeff King wrote:
> It's hard for scripted uses of rev-list, etc, to avoid option injection
> from untrusted arguments, because revision arguments must come before
> any "--" separator. I.e.:
>=20
>   git rev-list "$revision" -- "$path"
>=20
> might mistake "$revision" for an option (with rev-list, that would make
> it an error, but something like git-log would default to HEAD).
>=20
> This series provides an alternative to "--" to stop option parsing
> without indicating that further arguments are pathspecs.

Sorry, I hadn't had a chance to look at this series in depth, but I was
wondering: could we not just accept two separate "--" arguments, and if
there are two of them, interpret the first with the traditional meaning
and the second with the Git-specific meaning? That would be much more
intuitive for folks, although I suspect it would take a little more work
in the options parser.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--TnYVF1hk1c8rpHiF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1KBi0ACgkQv1NdgR9S
9ouTjA/8CBDSftUyUs2RcOBZXHdaPDtAeF3X39lxwFGrl0IheFVFr8nAHbBPFYMA
YeLspEWQI2dkpCyCSF8/qC5IkcZg2I0RwougaNRLzNHDgxfe30gza3IWBkrhz30S
DWcvRSkTIiC805IeB4PzaniRS6XGg7anX9Jsj6QuVZgTO6g5PjKZfspyXQ9hxMgm
kEld2eeMR5bRZD0LESpmHiZiK5lZbNHc3IJAaYRpQOHRnkiOHv3bKFHo8z5rWIbC
r12fgDslvEpLR4YYjR0a04D8xj7A1eSYI4toPpnVf4jC7A0Mi5O6W9aiRwVI1MDj
3sjhZfeonGU5fAijpCdgm5luH4XEvX/KiFT0zdi6KGFtZfs/Kz1G4AycxCf3TdCc
UZ7pDvQtzcUKWv+KFPL8bJ8aHdIzADuvW5w4WT1qaAaFk7zOmCjsKvwnV1nbaZgw
Ny4rZ7YaF6wlmi1CIGFPII8gtqI5hnCJkA6h3Wk637fdIYX1ZUHVSmx7AYBsXzuS
sPdFFHDDTdDG/i5A+KXKHBXaP2EdJg+qwW6TBN3E1W2GA27WKotJ8QOiKgTVHF3T
9Qz18dsi4nqCuFKpiG+kIuSQ9EZWFAMFe5/mHqjkE3r3RLY5LSS4yQynqfNC/KW4
huUQVIuaUSrM4XuU5oh26/c3dR/5m/Dp1KDnxzUwZsgErLJ+saM=
=OdnV
-----END PGP SIGNATURE-----

--TnYVF1hk1c8rpHiF--
