Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77F6C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 21:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiGRVlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 17:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbiGRVi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 17:38:59 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EF132ECC
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 14:38:41 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 376AB5A14E;
        Mon, 18 Jul 2022 21:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1658180312;
        bh=Tzw99+QBLmIUJhKHaSnujYMVsgVKk7kVsWYfOri6M+4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=C8RgBG6jNy76WORZRdLWW0Ub12H+lbquAhkBljuW+sb5dnTX84pBeP3hOO2oHCZFz
         zRVop8vgKlMUdysUi4hP7AOQKkdvg9jdSzLho2uOLcS9l6MHktuApp/NHFlCQfSxbw
         QMKReszwB40Jkk86KOhq+PI1mfR5VsDbHiuHEtGJRCzUXjrnKqYyKtEgWC/LEJKpHG
         BRrvVUw32fJFYpHXhxYrJ5dtpU8feNj9ns8jxcwF88uzEsAq3yiW0yIvt+RdyPkmcq
         iowUyoj7jqevWdkLgo0f3WXjgUrJ1zWro6/N35D0culfJFXGhzwrAQIVwodJT8vzgi
         my69oap9I2h9Boo2uAJBYgq1kujBqBspAuf2YT0tRGMhk1BmD+CP8VjKLN64tKVsyo
         ikNS9Z9DU3Gr4u08xjnWCNXtf70/P+lSRj+2Lh3F+H7DSj+Q4pc3sI+uB0RqaNJFnr
         qnRa8duAxsrle0pqbI4IHG4Z447OksDMjvDwGNIX4xyNBvq4vhO
Date:   Mon, 18 Jul 2022 21:38:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     paul@kinzelman.com, git@vger.kernel.org
Subject: Re: Possible git bug when working with Microsoft Mapped drives
Message-ID: <YtXS1s66fw/UCvLU@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff Hostetler <git@jeffhostetler.com>, paul@kinzelman.com,
        git@vger.kernel.org
References: <f946c577-d3d6-212c-cec5-a6c63856b77d@kinzelman.com>
 <b5931787-3589-102f-cfeb-caeb8a07e149@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="amHSrNNX+QliVU96"
Content-Disposition: inline
In-Reply-To: <b5931787-3589-102f-cfeb-caeb8a07e149@jeffhostetler.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--amHSrNNX+QliVU96
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-07-18 at 20:46:44, Jeff Hostetler wrote:
> On 7/18/22 4:28 PM, Paul Kinzelman wrote:
> > I'm using git version 2.37.1.windows.1 and Windows 10
> >=20
> > I've got two systems which are miles apart and so are not on the same
> > LAN, and I have connected them together using the ui.com VPN and M$
> > RDP/TSclient. I mapped each system's C: drive to be accessed by the
> > other system as Drive X: and I can transfer files back and forth
> > initiated on each system.
> >=20
> > I can also see all the repository files on the source system, including
> > the tree of files under the .git directory. Note I had to unhide the
> > .git folder so that I could see that folder from the other system.
> >=20
> > However, when I run 'git clone' on one system to get the repository from
> > the other system, git seems to think the repository on the other
> > system is empty when it's not. As I said, I can even do a directory
> > and see all the other files.
>=20
> I can't duplicate your setup, so I'll just speculate out loud
> here.  I have to wonder if the "X:" drive letters are tricking
> Git to thinking that the remote instance is actually local and
> Git is trying to use some shortcuts. (For example, it might
> hardlink them rather than copy them on Linux.)
>=20
> So I'm wondering if "--no-local" or "--no-hardlinks" or using
> a file URL rather than a pathname might make it behave differently.

It may also be the case that the remote file system lacks some
functionality that Git needs.  For example, Windows can support mapping
HTTP DAV resources as drives, but the DAV protocol is incapable of
providing certain operations that Git expects of a file system (Git
roughly needs something that's POSIX compliant, but can paper over case
insensitivity) and thus such a disk simply can't work with Git.

This may end up looking like the file system is empty because, for
example, the function to query directory contents may return an error.
The contents may not actually be empty, but because they cannot be
enumerated in the way Git needs them to be, it appears that way.

Again, I don't know if this is the case here, but you're the second
person recently to have seen problems with using RDP for this purpose.
You may wish to try SFTP, which should work (at least it does for Unix
systems), or possibly SMB/CIFS (which may or may not work, but I believe
it typically does).
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--amHSrNNX+QliVU96
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYtXS1gAKCRB8DEliiIei
gZ44AP9OfycxQhwmz54R7TbsB+pTs30AUD7Yqp7ycGZdX12oogD/YiaNPBZu1pOn
4msCit+zaXmCQQZdA9Dpfo+pVunZego=
=PMhg
-----END PGP SIGNATURE-----

--amHSrNNX+QliVU96--
