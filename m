Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F798C2D0EC
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 01:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C8D206A1
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 01:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Fwok6tzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgDHBSh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:18:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51690 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726406AbgDHBSh (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Apr 2020 21:18:37 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A5A486042C;
        Wed,  8 Apr 2020 01:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1586308716;
        bh=bx/vZyArH/Uq7xzUjlXEH9IOjV6e/G40mtoXFpx64xM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Fwok6tzlQfqLNAflsMAt5ZDz7WFeDSQQI/8V5FONJxOzB/ckxnJDx5Mdt41vdfdN5
         /7/ogQCMJHZVPKewAxtuEivUO9SjJu/doDbY6J2x4txzZITFU8k2gpymdHY1wa94BL
         ddBTgsJdjykj31d8ftFIz6QSDGAU4bnbac2+ndNLELDoz8gefraX+5YX0I+nq+4gHY
         I3VSDLZ2OcSqplkmdBlwuT6tWKUg5qHLufqQW6WstVaNhg/bsaQ1KdmGGHNi8me94v
         Vg6YHhdmWv+5Eu32k9POZTqC/fXkUP8d50DnW9lQAFDMBdmzwmxP3vRsrYS2Ukpqc1
         13kICa9mtxf+MN3KYFLPhTj4lu9XRY7e2HBRRv3LBWZ25t97uQT7xNJ8qlR3pGYTgZ
         7HHWymEWprTXwXKMEIyLAV80OsX19X/coXpo8hJmdgw+NKrmphbLgT6WhqRyX0SEch
         Wa1PqrnnwTcck9nbJ0fJfGA0ltk1tL3sjwDJD70knYHFo5Wmczk
Date:   Wed, 8 Apr 2020 01:18:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     git@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: subtle bug in git-am
Message-ID: <20200408011830.GA6549@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        git@vger.kernel.org, andy.shevchenko@gmail.com
References: <20200407184823.GA3932679@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20200407184823.GA3932679@smile.fi.intel.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-07 at 18:48:23, Andy Shevchenko wrote:
> Hi!
>=20
> What I would like to do is to apply patch from one repository to another =
with
> same files but *different directory structure*.
>=20
> When I try to change directory in the target repo to the folder of files,=
 I run
> git-am -p5 my_cool_patch.patch.
>=20
> Instead of the expected result (files and their contents is the same!) I =
got
> fileXXX is not in index.
>=20
> So, I think this is a bug, because -p<n> use in git-am makes little to no=
 sense
> without above feature.

So if I understand correctly, you're expecting git am to apply relative
to the current directory in the repository.  I have also expected that
behavior in the past, and found it surprising when it did not.

What git am does is apply relative to the root of the repository.  If
you'd instead like to apply to a specific subdirectory of the
repository, you can use the --directory option to specify to which
directory your patch should apply.

This is the behavior of git apply, which underpins git am.  However,
outside of a repository, it _does_ apply relative to the current
directory, since there's no repository root to consider.  I, at least,
found this confusing, but that's how it works.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXo0mZQAKCRB8DEliiIei
gSJtAP4z/jfZp/VHGPbbhMvVW17xavk3x4iDpjhdtHkkNoKZNAEAlBPz1fjFUVb3
8GAB8t7/2dFrGQzuK/dvR1nCcY32xAc=
=LktH
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
