Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F3B8201A7
	for <e@80x24.org>; Fri, 12 May 2017 23:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbdELXiB (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 19:38:01 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39486 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751407AbdELXiA (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 12 May 2017 19:38:00 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 56837280AD;
        Fri, 12 May 2017 23:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494632279;
        bh=F5EF43QueDFO5ii2d4ZJ3fnjUOcFEm7aDYxe+fA6oYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yt/XEBhRDnHP2rf/Yp0KtclU9Aq+ZtZMWCDb5iUKuLbkx0fj8UMjOdxHBurtMPmPx
         wD/qEFAQiaSy3Qu5tBLz1IyCRR048NVvK7QBYi7mX92DmF2Kif3g1xfZRz/oRDHkzh
         dWG6t9dyIS6WG/gt9hJlZcCOe5UW6YUK3xvzZ8/11b73ELyEyZ7drxqCznDG/NBmAg
         ycZfrFXUmONVboX8H0ztP+hVzdKtD9DhaFdAyMDbLcwIRuSIOP0YibQ5/X7SfNof1/
         hDCqnk6ApC3kjsydooYIFn/vyFmCTNFCZy6JptpNDEoltc4Pn3kqRgtkAtwQHi2P6I
         GcylPaksGRVqkCac8KzBxcNHBnDbNolFFujK/AfqrC+nGuWQCKXtfy674NpBf5JRQu
         9XZPVVP4ZXLlSQMYVnpuN36wS/8V/U+qiyiAaicbzuUEOZDtS0L3fwyKxY4h1PsprB
         vfG/v/LwZh9BAijJ/QaLaJUHoefE2wtEAftLDqSsj96s8HvaruV
Date:   Fri, 12 May 2017 23:37:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] builtin/log: honor log.decorate
Message-ID: <20170512233753.rz2g7quews4ny5iq@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20170512220704.txmdk45s66aqhexi@genre.crustytoothpaste.net>
 <20170512221221.406645-1-sandals@crustytoothpaste.net>
 <20170512233214.GE27400@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="35fusdyhk2fh7dfg"
Content-Disposition: inline
In-Reply-To: <20170512233214.GE27400@aiede.svl.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-3-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--35fusdyhk2fh7dfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2017 at 04:32:14PM -0700, Jonathan Nieder wrote:
> brian m. carlson wrote:
>=20
> > The recent change that introduced autodecorating of refs accidentally
> > broke the ability of users to set log.decorate =3D false to override it.
>=20
> Yikes.  It sounds to me like we need a test to ensure we don't regress
> it again later.

I can add one, but it's going to be a bit odd.  The issue is that as far
as I can tell, the option is honored only if it's the last one read, so
it necessarily has to be in the per-repository configuration.

I'm not sure it makes that much sense to add a test for this case.  Do
we generally want to write such tests for all config options?  I don't
suppose it's that common a mistake to make.

Does anyone else have views on whether this is good thing to test for?
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--35fusdyhk2fh7dfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.20 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlkWR1EACgkQv1NdgR9S
9ouTMA/+LdBaEDIl2OK5lTLv00FQPIsmccuKtmsbaQsZYkI16C3s5HHkuOjcXSST
OkE/Rfj+Zt87EaIa5cuYh3NV/2w95s4P3jKHzpKlcIpW+7rTWZEimjrA/x3BSAZa
6XX8cTwyqYrddA4GIJJzwkYBgIuiunocIyXN6UGiklaME5ITOfaj//w6TXQnm/gb
NeFSFd3Hw/GrtEfEih9iAu27FLSLuEtJ1XEvokqTuXvhsgobs5HdnD0ySSNB1NwA
Tv0viiehvN4HvybYOicVuRCuZvPKbN59Bo4HqUdxLBeQFsyTqmL+qiC7IIPd4/VE
EaFFYVqyOqW8HO2fF/p8Uwt9KLVmQFuXEuv4TnCxYluccl+KtQqJYpKCLSc7Uyll
HOmFUvCkZDsxToDj6wsS3qIqWnnMTtcspr1qw+355WEoiVrPOVuKOSrvS3a+IPCZ
JOpm7anPNXKdzceTPFn6To8juCgKDGluJIxZ1qI3TytFDiq34cA2VpNGiRGptZvt
orb4cEmIFVRFysgCGq9ozAbUlMuBYNQ6ZeGOGpQoBnX9xDmNx9XLI718xAofmSEK
tTFWMgtbAG48AHgJVQglCXWyVuYdQH1tNGLo3t8gtZDt+wC+7LFhqkCDgKktgGmf
IMG3/drYcccrkhZpHHB/Pd+rjusZcgT/viNdWR1Ub5gqscfNlmU=
=gbXh
-----END PGP SIGNATURE-----

--35fusdyhk2fh7dfg--
