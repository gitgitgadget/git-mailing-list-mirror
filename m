Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE21C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 13:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70FBD61DCB
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 13:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhF2NzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 09:55:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59510 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233052AbhF2NzU (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jun 2021 09:55:20 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 52A3D6073C;
        Tue, 29 Jun 2021 13:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1624974742;
        bh=lQoVTyDopfdy4ARhdzNtk7Fy6y+kJdq4BHnWUGhxkq8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rlyJTno8Mzz9z60vpce1xsuX4J95dst+T1VaYlB4ZnBvjYQkDBlUFHovLYAWuDBkz
         V/yOju7MOjUl3kpzeUbNFU1pTEdP0lswofEpBaGksItlslibNIL+bR+K6koTi5STZW
         iZfxymgeAIbC2cHZkEoRL8P/wghMKlvlLMDPr3fZyP/sitJTQnUSluKL9qhSJJy5XN
         5BG0yuWAtgjHcZWowhptvueXOsFdu/+ZH+oqDh7Xl0RwobeUNJbkkX3x2FV7GTRgAU
         vMBbJgM0nHr1D/KaJTxyw52T03jADAFlNpdcOrXXkuPRyv5r1w+HseyY4en12YYRb7
         TM1KKEL0SxnfVBVAowKKW0O50w+y4SLZf75YSh0V3UHhBf2DQhpdWNefg9E/UsBbIj
         r4FOQ1KplmbhooeBpaJCjhSuIYSyJxrsO0YLHggCEFbJt/+g/F1rJtcNOE8R6aQCbj
         pap8JPLe58xO5lkXQLHvKD9vvBkmscz3ALr68JmIY/C2l4Doodx
Date:   Tue, 29 Jun 2021 13:52:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ondrej Pohorelsky <opohorel@redhat.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: GIT_TERMINAL_PROMPT environment variable isn't honored properly
Message-ID: <YNslktip/qknZoFf@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ondrej Pohorelsky <opohorel@redhat.com>, git@vger.kernel.org,
        peff@peff.net
References: <CA+B51BHBoDn+xFXOXWe0SvRzzuPo+YYj63f0dyafJELbBTgGbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QsnInOJVcLH5gi22"
Content-Disposition: inline
In-Reply-To: <CA+B51BHBoDn+xFXOXWe0SvRzzuPo+YYj63f0dyafJELbBTgGbw@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--QsnInOJVcLH5gi22
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-29 at 13:46:44, Ondrej Pohorelsky wrote:
> Hi, we've run into an issue when running git as part of an automated syst=
em.
>=20
> When you set the GIT_TERMINAL_PROMPT environment variable as 0 you
> expect git to die instead of trying to issue a prompt on the terminal.
>=20
>=20
> $ GIT_TERMINAL_PROMPT=3D0

When you write this in the shell, the shell doesn't by default export
this variable to processes it invokes, like git.  If you want to do
that, you need to write:

$ export GIT_TERMINAL_PROMPT=3D0

or

$ GIT_TERMINAL_PROMPT=3D0
$ export GIT_TERMINAL_PROMPT

> $ echo $GIT_TERMINAL_PROMPT
> 0
> $ git clone https://github.com/some/non-existent-repo
> Cloning into 'non-existent-repo'...
> Username for 'https://github.com':
>=20
>=20
> You get expected behaviour only when you set the GIT_TERMINAL_PROMPT
> variable just before you run git clone.
>=20
>=20
> $ GIT_TERMINAL_PROMPT=3D0 git clone https://github.com/some/non-existent-=
repo
> Cloning into 'non-existent-repo'...
> fatal: could not read Username for 'https://github.com': terminal
> prompts disabled

When you write this, the variable is always exported to the command, since
it's not possible to use export here and otherwise this syntax wouldn't
be very useful.

Hopefully this explains why you're seeing some different behavior
between the two situations.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--QsnInOJVcLH5gi22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYNslkQAKCRB8DEliiIei
gVBRAP9rQsHitWObbuD7Ml8dLrfyfmWY60PQXtyxgn7f7/sn/AEA1eMhGGaeGEz5
i07H9VnYUCTksfmW4Mf3VPd+rAtn3w4=
=FG3X
-----END PGP SIGNATURE-----

--QsnInOJVcLH5gi22--
