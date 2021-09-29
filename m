Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74AEC433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 22:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A4E61502
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 22:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347223AbhI2XAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 19:00:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50938 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345988AbhI2XAg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Sep 2021 19:00:36 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6FA8E6073C;
        Wed, 29 Sep 2021 22:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1632956334;
        bh=Ve6VVKnZLqjvx1IpnoRxrNpBZ+nP4KcbIW5mCerUS4Q=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=meAqv/PYM0osmhQvO1J3zdNZrfQ+pZOWOVXZQnkeEpblM5u/5jQvXFbW/VeYUaSKG
         /Tdu2lIcqZPfz4aIZfXC3x00FCmWa3BCcoU9F5hmBWs+IVM75omndl6pYNNRgMzp6h
         9VQV8Dzm7RMqiu+P2+urvAYO5Bj/3DLTBSnrs08hA0FTGVbEjSFa5UFeYlDTG6bhMZ
         DDbWntr8I8CUgubqELkhrvFIj1hmZJyU5kYkJwe/d1lpJrJu0TI5HdB56XGYDQj57y
         zAHDH7/e7cIYnhbpaEENo8Ck8jxqqhrTLvGtDjGU8zfE75zBSq7AvjDV/j8IcBrM7x
         rBOgKcwfNY0d7mFYia+dvAxcRFGvewb8TVlefyhwZEeA1n2WsphS94K9g9WkZ0g+Dc
         +12d5gShX8z26vPAA6jZR7MOipNJANz3GcoCA5GmHqBAUXbFQixn6I8ztcrCwIqQv3
         nlLpArARBee4hz1zIkkqJbRW2/OtcNi8klI+rlOnhE9zccIEClO
Date:   Wed, 29 Sep 2021 22:58:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Kevin Kendzia <kevin.kendzia@googlemail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Issues with newest version of openssh 8.8p1-1
Message-ID: <YVTvqpjkHuB2c15l@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bryan Turner <bturner@atlassian.com>,
        Kevin Kendzia <kevin.kendzia@googlemail.com>,
        Git Users <git@vger.kernel.org>
References: <CAKcQ8=cyq46=eF8NZtUifmfHgWUphmHPYh4s3oQrHjiX2nqEmQ@mail.gmail.com>
 <CAGyf7-FBgmRTmjKFjMi2p5MArGEQh9a4Z6RA6FO-2U4D5jGnmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dY6GBEog7C8x3Ksd"
Content-Disposition: inline
In-Reply-To: <CAGyf7-FBgmRTmjKFjMi2p5MArGEQh9a4Z6RA6FO-2U4D5jGnmA@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dY6GBEog7C8x3Ksd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-09-28 at 07:32:05, Bryan Turner wrote:
> Ultimately this isn't a Git issue; it's an SSH issue. My guess would
> be that upgrading to OpenSSH 8.8 picks up the change to stop using RSA
> signatures using SHA-1 hashes by default.[1]
>=20
> You can update your ~/.ssh/config to add these lines to revert that
> and allow using those keys again:
> Host old-host
>      HostkeyAlgorithms +ssh-rsa
>      PubkeyAcceptedAlgorithms +ssh-rsa

I should point out that these algorithms are disabled by default because
they are a security risk.  This has been announced for a long time now
in OpenSSH and everyone should have either switched key types or enabled
RSA with SHA-2 or both.

> With that said, though, if possible a better solution is to generate
> new SSH keys using ECDSA, Ed25519 or another stronger signature and
> switch to those.

You also need to contact the party operating the server to which you're
trying to push in this case, since it's ultimately the fact that they
don't support RSA with SHA-2 that's the problem.

There are a couple different providers (in my testing just this second,
I found Bitbucket and Azure DevOps) who are still offering only the
ssh-rsa host keys (possibly with ssh-dss as well) and not offering the
rsa-sha2-256 and rsa-sha2-512 algorithms, and only the server operator
can fix those.  If the server operator adds support for RSA with SHA-2,
then OpenSSH 8.8 will work just fine.  But otherwise, this will continue
to be broken out of the box.

But as for client keys, I do strongly recommend Ed25519 in all cases.
If you have the misfortune of having to use a FIPS-compliant environment
(which I don't recommend in any case), then use RSA with SHA-2.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--dY6GBEog7C8x3Ksd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYVTvqQAKCRB8DEliiIei
gaiwAP9azBZhU9ggOxEof+fCPLPFBhwz4ez3GBE8z8auKMPMoQEA+e9s42wTiFYs
SdhLkVCu3UxlBek25UOi9Heah2PsRgs=
=YFa9
-----END PGP SIGNATURE-----

--dY6GBEog7C8x3Ksd--
