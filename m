Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19141C2D0C0
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 19:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86D7206B7
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 19:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OrUVy5de"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfLWTJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 14:09:56 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43626 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726805AbfLWTJ4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Dec 2019 14:09:56 -0500
Received: from camp.crustytoothpaste.net (50-249-64-195-static.hfc.comcastbusiness.net [50.249.64.195])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A053860787;
        Mon, 23 Dec 2019 19:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1577128194;
        bh=m0FVyBUlprTc5VC1stYVMUPLodLYG1ua7gFlxHHEco4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=OrUVy5deOtevRuDULKosmbRf9kf5NIuh6OkppVS7N56vMe90c5t9TIk38Wi7rXwCS
         V99B+4VhXpaIbuleBQkVTMMQWPMfbg3yWacrWzygk9MmHZnEC/PaYAwdNGv0MkO+z4
         TBWEGOi98RMsOj33eab4k6Nv9LjIu0G6NDeBqNmcw3NRF10+Iou3ZHoVQ5Tybk649b
         oyL2ZQ3ZX4ZPwKdSs+UI7Ccqp7ymfYeBXWajIf+89ZyxvIg9LqGcBhypktnWnXHhBq
         EXbd6U0KByG42BzKjS+IXqq+wOMJE03waoKdQ+CVw5vXkhGN5bTaWmb+QSmKgKM0rG
         80JF4lJfw+VqxlyUhn/CHhAMLcZJ1S68aV45ZHp0JkE75GUb3hSUHE0LlksSrZl2Sj
         bNHHndDPq8IwlxvQfoyCvTlarZqjg4zu6B41iSebYcFOp+VojIxXzufvx/Zew/QfOd
         6Tvc39l1uxMQ0r6WHqzUoJjosK91q64Nvj1oJFNPQ4y8BJ0iZaF
Date:   Mon, 23 Dec 2019 19:09:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Arnaud Bertrand <xda@abalgo.com>
Cc:     git@vger.kernel.org
Subject: Re: Possible improvement in DB structure
Message-ID: <20191223190950.GA6240@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Arnaud Bertrand <xda@abalgo.com>, git@vger.kernel.org
References: <CAEW0o+gwbNyDqmiouFzO16LsRUfcAnSwj9K77oGe5hi=EVMB=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <CAEW0o+gwbNyDqmiouFzO16LsRUfcAnSwj9K77oGe5hi=EVMB=w@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-12-23 at 13:00:46, Arnaud Bertrand wrote:
> Hello,
>=20
> According to my understanding, git has only 3 kinds of objects:
> (excluding the packed version)
> - the blobs
> - the trees
> - the commits

There are also tags.

> Today to parse all objects of the same type, it is necessary to parse
> all the objects and test them one by one.

This isn't a behavior we often want.  Can you say more about why you
want to do this?

> May be due to my limited knowledge of git, I don't see any advantage
> to put everything together.
> By splitting the objects directory, the gain in performance could be
> important, the scripts simplified, the representation more clear.

Oftentimes, we want to look up an item that we would refer to as a
tree-ish.  That means that any tag, commit, or tree can be used in this
case and it will automatically be resolved to the appropriate tree.

Currently, we can look for any loose object, and then look for any
packed object, which is a limited number of lookups (at most, the number
of packs plus one).  Your proposal would have us look up at most the
number of packs plus six.

In addition, we sometimes know that we need to look up an object, but
don't know its type.  We would incur additional costs in this case as
well.

I'm not sure that we would gain a lot other than conceptual tidiness,
but we would incur additional performance costs.  We can currently
distinguish between the type of all of these objects by simply reading
the object header, which on a 64-bit system cannot exceed 28 bytes,
which we do in some cases, such as `git cat-file --batch`.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4BEP0ACgkQv1NdgR9S
9ovlHg//WzdG1l4DOVHuUD4q0upfNm4K7bwNIVJmFDcrh6QIISDQLJsYK1/EsOfL
Ky0Cr3D+XsDvdikqWN8UEzmOhYOjhAw6AOq27jLyrWE3jyQS5mWZAZpA/tC0HtYC
IJnkwalWpn0afq7zslaVbPZV8WLVtwlCtAeh5f6Vy16wNmfT2QqyedhSXGfsBpZW
/c5uppBzt1ZN7CDLE7XAnJsb6Fq5wpenHdTJZugE5zusD6lqSqNfA3fDb6lgfQUP
+AGLjuj0F/nEKVHRfiouG5JRNDYUxEfTzZlFn2hs37fgyrGZPg14wZasA3s7DQTb
CmwHQCL8yS/rPHOmJP6OaekIxHh7CES+2VdVr7nyeSPpTh+yjZGNgexQiCrO8BQX
odn59GCvA/URS1KeElc0tTfdLIb7bjz7WjMp2+EoS2a5k+XhJIuteYBG295oz4R3
3F60F6g2xWuU3jLC4srOK9hCl8PAfIdW9Ew/PpJPYB5zM0dyxOfu7q/MjwSNiAzj
xQLVesSWdfqzZoCC9ypUls/11FUygoWDg2sGPYbXkb15WGWn1IEgU0234QNBdQDk
n6ikYeNoUrjzbdOkUKUh1AhxO255kiz2RAtoqO6aY1kPPIbas0iToestVLE8GDg5
bfPXkL3z40CSARCzQERC8BSlzLKMC8H8aIv7cwqEYDl/1qeEzvs=
=BlhP
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
