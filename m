Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF08220281
	for <e@80x24.org>; Sat, 23 Sep 2017 19:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbdIWTC6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 15:02:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53980 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750916AbdIWTC4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 23 Sep 2017 15:02:56 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Sep 2017 15:02:56 EDT
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EF2C660D76;
        Sat, 23 Sep 2017 18:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506192949;
        bh=t5uIpYaB8PexBtnN0+lB4IPtHdWQoNTHYx03RTbiJzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eevKqTfzwBWnNbH5SKPZK5zhZqug9qPPgGVa9CGiyPjkLqCtXBpriDorGV+lNZvci
         bOx1VTNEuWk+TkHqiHDuD7/nUaFMgQjK1ZGPCHkUKvXEhiQy9A768T36IuGBhcIov/
         mjd3dPVUuJHTh8/2kMgZFuSQEK0KvRXE5/aebZM1Xkm8/NB4L6KyZBZ3TFOltgz/oS
         EzisYeoRe30xIk3GbHYuMDrsOc9dUSEiGjxWwqhB7S+BYqXQrCDeTYMCBfn15DgWpa
         tATGn8fQJh0EfpTd1YTVr2KILD1QQYq6iuqvpZdZCeIKGGMnDYU/5Vnqm38cSTyzS5
         xKgULLDWm9xaQR3ngKLl1U2275dxfGRjYH3OfH46p4EzQ+mdh1nYdt2rhsTClxYc5T
         rRNXnA23cKP9387wXAU79qpp31+rGNtSGW8tNqwc9JKBStMeFUu6nNsKA2ejEV6IbF
         uWhB9QNJccgZ/ZnR8fqr11ontpCIrtR+HaflC0sKvgBimxgtCON
Date:   Sat, 23 Sep 2017 18:55:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: is there a "symlink" option for cloning a repo in a separate
 filesystem?
Message-ID: <20170923185543.ithsgi3nvksp5uos@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
References: <alpine.LFD.2.21.1709230418340.22644@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rct3mbk6ppba7mps"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1709230418340.22644@localhost.localdomain>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.12.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rct3mbk6ppba7mps
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 23, 2017 at 04:22:32AM -0400, Robert P. J. Day wrote:
>=20
>   reading "man git-clone", and i understand the mechanics of the local
> protocol, so that if i run:
>=20
>   $ git clone /path/to/repo
>=20
> then "files under .git/objects/ directory are hardlinked to save space
> when possible."
>=20
>   but if the repo is in a separate filesystem, or on an NFS mount,
> hardlinks clearly won't work, so what happens then? does it default
> all the way back to regular copies? is there no intermediate symlink
> feature that would still work? (i suspect i am far from the first
> person to wonder this.)

I believe the current behavior is to make a copy.  However, if the
source repo is reasonably well packed, you won't be copying that many
files anyway.  You can always run git gc in the source repo to speed up
that process if you're going to be making many clones.

As Torsten pointed out, --reference is available.  If your source
repository is ephemeral (or otherwise won't last as long the destination
repository), then you won't want to use that option, as you'll lose
data.  The --shared option documents all the sharp edges.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--rct3mbk6ppba7mps
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlnGri8ACgkQv1NdgR9S
9otK2Q//Xknut5DFfK/3A8aHpFO9v49uVeVrHxwtcy1NvDNDDItQiObpQigiwc+c
xF2I6V28GUfcBZEh5ekuKK61FfiTwpGtEa2hxH6G+qiJu6jl3uhmuWWkDPWXGIzC
ttp2sxJr+xV/0C5wb+aS1ZUngunKJ2ZFt9Nz99XQl6CC6gqvOcrTkZmiQjL9CoLY
Ya3WihTiPVLBE7GqzcnYz6jKoYODfPF5fbajyPQ6L6EXp44qkesWzvJ38ZQI4dFR
GE4N/DIQUkaFPoPMhT6w14hTOv1488cLNiBvCDThxRV8sAoitHlksRg3mB1mHpkE
rnugqXItQYZCO1NbFU6A+LauaFmx4WSEDuk+erJX4g89Awq8xYsIoSOuCD+uhCLI
i7c6/1Ls6WQn+B3WpB2+5oXoB8EpGc+iYMP7noPA2mzKAzUnIi+EkBdK9OlKgLLu
ekNLDPdyJPjQDL2XQRetu7lz5lGHj8uPq0yhlxvpwsGB8eQB76YbK+w/uy6Ajc6q
jngHJQtKTCRkDXxUvrBcuiVBeRwVLUahpCvVwb9t8FwZI/wgDLGOGdYyS+ZLrMPV
dRFGqiThPqYRHIW3dJ+BS0JllDAjjslLDe2ecTvFD0GzjmtwWb42mHqdGeB7NqPD
C50kDzCyHSAO5Zu1WjROBm+YjYe/xC1yGR0+4NiQ79tbRsrl+zk=
=GaUy
-----END PGP SIGNATURE-----

--rct3mbk6ppba7mps--
