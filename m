Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21471202D7
	for <e@80x24.org>; Sun,  5 Mar 2017 23:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbdCEXxo (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Mar 2017 18:53:44 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:42960 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752442AbdCEXxo (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Mar 2017 18:53:44 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 70C73280AD;
        Sun,  5 Mar 2017 23:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1488757946;
        bh=NtuzLKwuRBlPlyOOrJoO8pOvKiinQ6SAhCOzyAQSKsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OxEAKZNZg8ZyA/t8s+u3iscQL9WeuJVQ9Wjf2H9lgK7jSkupZUjcsHJLQFuFn5rEv
         ckYANQ7L73xx6nKoN6T2qUrxmJVdPDZc8N71OBdY50ZVsrNofH3MGdhj93nqnRMMXj
         fi80+qHQU0tVmLPks7N6CpmEd+9OHqFofnSqD8Oj+FlfsD21b00YmPWByzJFxsNPPm
         v0O+DtlZHtQsXFeofEhVIxDASFKSGFsinpTyUvAfxjbnC6XYyzURFgNHrBK9R+tqjO
         VFtsPEpjTx7H0fhSAnv8MfUi66vDNo96Ex2ASGk5DPGx0fNqnpfbnGsfcL0WMCcZhE
         rVfXST5ipCvsgTuZ0sSOSiRn7ZqUR9QZyUiZu+O5zPtDOOF0LtydhIc4Sf98CjgR0i
         lRfvDpZZk2BvXi1bro3Cw7usB+l9aNo6J8vHW+6zmICVHbV/dNjtN85BRG+GRZGt7/
         s/eMyeVxt+Ar/7h36XysMRJnHawUxKo3W1y0hARf6KgXsM3sui/
Date:   Sun, 5 Mar 2017 23:52:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?QW5kcsOp?= Laszlo <andre@laszlo.nu>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] pull: do not segfault when HEAD refers to missing object
 file
Message-ID: <20170305235222.vxia7jw2n5uj2h2e@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?QW5kcsOp?= Laszlo <andre@laszlo.nu>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
References: <20170305234222.4590-1-andre@laszlo.nu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jhhmvj3pooucbz6d"
Content-Disposition: inline
In-Reply-To: <20170305234222.4590-1-andre@laszlo.nu>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jhhmvj3pooucbz6d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2017 at 12:42:22AM +0100, Andr=C3=A9 Laszlo wrote:
> +test_expect_success 'git pull --rebase with corrupt HEAD does not segfau=
lt' '
> +	mkdir corrupted &&
> +	(cd corrupted &&
> +	git init &&
> +	echo one >file && git add file &&
> +	git commit -m one &&
> +	REV=3D$(git rev-parse HEAD) &&
> +	rm -f .git/objects/${REV:0:2}/${REV:2} &&

I think this is a bashism.  On dash, I get the following:

  genre ok % dash -c 'foo=3Dabcdefg; echo ${foo:0:2}; echo ${foo:2}'
  dash: 1: Bad substitution

> +	test_expect_code 128 git pull --rebase > /dev/null
> +	)
> +'
> +
>  test_done
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--jhhmvj3pooucbz6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAli8pLYACgkQv1NdgR9S
9ot/YhAA0WADDD5bnFZurEXcQNFm3GA8Z50l7E+XCpW8LK5LRU9+sWKX47OddiP2
k8x0FPaQ4ouvMBwl2ubvWTO1QU2/cNjjEMi3erY99AbLEaJpLP6lghxpDcW2qZ96
V/Czepmt4pmLGC6+vexeAeHAlG5djxjM5JMVXPhu+deJngBtZkX//Pp9X1ywKy6o
RldbarXv1jLAr4NcCOL8Q62pyUjLR4IOcIVb6QmcV+dhWMyiMUVgOFohNqUxQuRs
VW0BmriCpLg+0NgWJuN9/7Mcck0JPyz87qQXZ1gRwT+S3YpHLEpHHmXkXyvQJU3U
45Uez5g9ywu8vYmT1Juh+R3SBgQzPNGqK6YKzxWyf9NB6yf3mmgJF0CsW0fV3XBg
Wi65pBYgehXahqhH3TmuamSRJfqsQTrUri8ACjHSq+IffWnEM/GW5FrlMLfspbqG
GWnceeALQdsYfA+N1YL1JL+35oPFOmzs+WZtA4e6M7H8VOBmW8D0ZAIluhW4+Uoz
lbGXepFkmYjqhXTz0yKRW0X5WEpyWbmGIl9QUzch6dWT+bjix9BwlO1ooT6dyMpe
pElnQqc+VXlu74EUmsl8fI81e4nHoRVSr+MEoqNhn9xH5d+1Se4cZ/FOn8uQQ9oC
9+t0aIswLEkunXNPe+JFWRJ2B5LEdJAgsiezM9BtzyHXOOmJQhU=
=Q/JH
-----END PGP SIGNATURE-----

--jhhmvj3pooucbz6d--
