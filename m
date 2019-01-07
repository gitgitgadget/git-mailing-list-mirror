Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 918061F803
	for <e@80x24.org>; Mon,  7 Jan 2019 03:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfAGDhK (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Jan 2019 22:37:10 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58204 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726246AbfAGDhK (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 6 Jan 2019 22:37:10 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c537:b034:2963:7e8f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1983F6042D;
        Mon,  7 Jan 2019 03:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1546832228;
        bh=4/3kKXcTt/MTzd2b3iv+zpUPM818iAE6Zyg2FBMKf2c=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=z3rsOsMPiVrvG/gLLWMeWeLcYkUkeRUBid8X9ZqBtOBcUT6nY3xH93NZbN10XGwu/
         EJL/DFIvNsCYtS7MyLH2Au7bA5L5L3WIut4RJT6zYZZrh2YqWf0q9LQBcNE8UWzdKT
         TpCP67tVSqnM533YDrjvsb8EOQKfVEGbDutOCZSGWLRa+Ygp/bivFM77C4r6MLgzIa
         kQ1i1oE0eEgSqEYTxGNmZUr0RIuXZn3iZjaAeH+tWC/UTXwAUm8YTAK74jmA1/h/jY
         IMgCYmPygNTx9hY9Dcn1Zdh3GkPNtbZ2L4Q7TiFCv1bWs6QkhzNybCElNijA8Kfnii
         WGdH0oXhCOTQrLFyC92GFsg4cPYj6DwK2PFABIeYzUUYU7ACHAU2+s9whwKuBfhQwD
         B4SHe+06deeWaJj3SU8CtBvNTUb7c8c8eoN7ZiZQycw3D+OKn5uniUck5WFF0rkNtH
         iR72hGvSwbMlW/to7fqeLLcrrFbgvEFOH2IxxiLdq+LxDw5lfXK
Date:   Mon, 7 Jan 2019 03:37:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Guilhem Bonnefille <guilhem.bonnefille@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Suspicious fetch-pack behaviour
Message-ID: <20190107033702.GI423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Guilhem Bonnefille <guilhem.bonnefille@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CA+BUw6jXTt6QGXvdFjRDNqJcij+1hNP5xybUUuGqo3bY0=ueuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kH8JNVvasRCCW1Oz"
Content-Disposition: inline
In-Reply-To: <CA+BUw6jXTt6QGXvdFjRDNqJcij+1hNP5xybUUuGqo3bY0=ueuA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kH8JNVvasRCCW1Oz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 03, 2019 at 10:52:48AM +0100, Guilhem Bonnefille wrote:
> Hi,
>=20
> One of my users reported a strange problem: a simple HTTPS clone did
> not work with Git 1.8.3.1 on RedHat 7.
> I did many tests and I was not able to understand why his clone don't
> work while I'm able to do it on other similar host.
>=20
> Nevertheless, we did more investigations. One of them: a raw strace.
> I discovered two strange behaviours:
> - fetch-pack closes its standard input and standard output and then
> tries to print the references on standard input and finaly dies.
> - git-remote-https does not react to fetch-pack death and continue
> polling an empty set of FD.
>=20
> Reading fetch-pack code, the behaviour is explicit:
> When "--stateless-rpc" is provided, fd is filled with standard input
> and standard ouput which are then closed.
> https://git.kernel.org/pub/scm/git/git.git/tree/builtin/fetch-pack.c?h=3D=
v1.8.3.1#n156
>=20
> Reading this, I did not understand why it could work.
> Any help appreciated.

When --stateless-rpc is passed, git fetch-pack usually has its standard
input and output wired up to the ends of a socket. Those file
descriptors are then passed to do_fetch_pack, which calls get_common to
negotiate refs with the remote side and get_pack to get the resulting
pack data. The negotiation should function regardless of the final ref
printing.

It's true that attempting to write to the standard output fails in that
case, but that's okay, since we wouldn't have wanted to write that data
to the socket anyway.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--kH8JNVvasRCCW1Oz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwyyV4ACgkQv1NdgR9S
9ovnaQ/+KlZuPsnzHzeA68gyR1QiBla+pqRgd2IOOEfhp4XJ531Gboq0BeZDkSqa
/xH98N89nrRhtvqR+N1GE1KIGVT3ByCrAAPLv5B5V72sVjI5VmI8ym/LMdMed10b
nH4NOXfPZhKh2iEMukj+oT7lid9H56s0RdlIn4YWMt3eI+bOu5ggs9NRNcYUJcXF
juXVOfoMjArwHld+mVB6SwyNaHO+b9Tjpol0n/sLaZcrwkXESnq3X11OuV5Q/PQQ
Y6QbSSleCUEzV431ZDmNs4TX/4XEX+bSyXvNBksOQGo4FUcuJo+wRXdeFZun7gjA
gYeRXUZGmDhoCflWndBc+d3rJtUEmWT0E46Xy31ShXFFJPYt0n6H/EJSKWS1TuMc
JmvxKHIwDC2WW7p1xgkrfVtlB5QoQ9SX82Y5Zkm1X81O1DSQR6+B8LOwfFe0QJV9
HNfJr6CxwDFpiHDMyLclvmjubU4KiQvBX8OLuxKGrN2nRVEeTGp14uxYLDymSQXe
6hk/Gt7sHmQfYk/r+jX1n24t3fp2xf2dPhqbhAOJ2vCsuWMlhPGgZip2pbwp34Y7
MWtNomKZg/vbSHL5E78808mDCA1/24w0/9c3d624WPpQrHb9wm0P7Zos+LAvjNd8
SjWCedqUYt9ZVGYIVNJMkT4zlTvQ6Jan4R7xYTLD/sR1zvkUeR4=
=hm/f
-----END PGP SIGNATURE-----

--kH8JNVvasRCCW1Oz--
