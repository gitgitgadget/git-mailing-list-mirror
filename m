Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE61C433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5551F6115A
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhJSXWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:22:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36908 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229707AbhJSXWo (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Oct 2021 19:22:44 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8E64860734;
        Tue, 19 Oct 2021 23:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634685600;
        bh=L8H+7UYBWDHQNvwVBPjKyqnlCdEcQKRG/WY0c4iNXkI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=WU17PvTvM4TK9IIf01VZZ9Zz3ouP98We2OmpcH2Jo3mDcKopbAdeWqEHjnJRvwtXI
         PchINtB+ar53xuawjW7b8OcWDekh0WM44GyKv0birxy1j4zA1pVwG5ypUZI1QsTXPt
         SVlaLTT/II4ZMHEdK8d0YHfx6YwtVQDuhTMRCXBUls9RR/OdfS4v4+pglMb7+PR24q
         8J+iLBl0OzYd8lpUYWqSdKHZc387YrF4xONZ9fO3XzBJz5nQesVF5mjQm7oW0MGFP2
         S5QG7sHsU90RB8Unk0h3gUvFBThCd6/LA8eBwKKtVb7r/YhLqwAmPWGg3kGYZi6xrO
         9EGv4yOqN1b704eD0UUHLrEqogx4HD24Bemi8Wz+mIob8PucIxE+ILP+xWCANwI7TK
         mN8WI+XCpSSZwd9PWSyHHT6gNkFkQFLR82JLNGWMxghKvAuO2dNQvgP/FPSmiX4ITk
         T9iMF+n5bCh6GJKgMm0DfFRgpX0HhJY/gdeC88HvrchudG01X04
Date:   Tue, 19 Oct 2021 23:19:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     LL L <lll@xeltek-cn.com>, Git Users <git@vger.kernel.org>
Subject: Re: Git failed to pull after upgrading to 2.33.1, using choco
Message-ID: <YW9SmwZOp+HYHScP@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bryan Turner <bturner@atlassian.com>, LL L <lll@xeltek-cn.com>,
        Git Users <git@vger.kernel.org>
References: <001401d7c490$e7d57620$b7806260$@xeltek-cn.com>
 <CAGyf7-GV62dHzsiV7KD2h8Rgg2HBWn1TgimodzcPUWravowUGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="taEvZ/L/Iy4zGZ1x"
Content-Disposition: inline
In-Reply-To: <CAGyf7-GV62dHzsiV7KD2h8Rgg2HBWn1TgimodzcPUWravowUGQ@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--taEvZ/L/Iy4zGZ1x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-19 at 02:48:59, Bryan Turner wrote:
> On Mon, Oct 18, 2021 at 7:34 PM LL L <lll@xeltek-cn.com> wrote:
> >
> > What happened instead? (Actual behavior)
> >
> > git@e.coding.net: Permission denied (publickey).
> > fatal: Could not read from remote repository.
> >
> > Please make sure you have the correct access rights
> > and the repository exists.
>=20
> Most likely you're running afoul of an OpenSSH 8.8p1 upgrade in Git
> for Windows 2.33. OpenSSH 8.8 disables ssh-rsa key exchanges by
> default[1], which results in this sort of error. Git for Windows
> 2.32.2 was using OpenSSH 8.7 (or perhaps OpenSSH 8.5).
>=20
> [1] https://www.openssh.com/txt/release-8.8; see the
> "Potentially-incompatible changes" section.

Yes, this is almost certainly the problem.  Note that this change was
made because while RSA _keys_ are still secure, the SHA-1 signatures
being used are not, and so folks need to either use those RSA keys with
SHA-2 or switch keys.

> > debug1: Local version string SSH-2.0-OpenSSH_for_Windows_8.1
> > debug1: Remote protocol version 2.0, remote software version Go-CodingG=
it
> > debug1: no match: Go-CodingGit

Go's SSH library is known to have various problems with RSA keys and
SHA-2, so if this site is using that library, then it may be the cause
of your problems.  I know they're aware of this problem, so hopefully
they'll be able to work on it soon.

> > debug1: Authenticating to e.coding.net:22 as 'git'
> > debug1: SSH2_MSG_KEXINIT sent
> > debug1: SSH2_MSG_KEXINIT received
> > debug1: kex: algorithm: curve25519-sha256@libssh.org
> > debug1: kex: host key algorithm: rsa-sha2-512
>=20
> Looks like the server supports more secure RSA key exchanges, which is go=
od.

This is encouraging, but I don't think it's sufficient in this case.

You may want to generate a new Ed25519 SSH key with "ssh-keygen -t
ed25519" and use that instead, provided the site supports that.  Many
sites do, and those keys aren't subject to any of the problems you've
seen here.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--taEvZ/L/Iy4zGZ1x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYW9SmgAKCRB8DEliiIei
gT/NAQCATNiPQFlhNzyUvnEVVustUlthye14rWyZ9wAnPi62VQEAy64FtlEhX8oW
7TV4JN+wtiTNKxQCWgm6TPp3paYW3AE=
=+G+O
-----END PGP SIGNATURE-----

--taEvZ/L/Iy4zGZ1x--
