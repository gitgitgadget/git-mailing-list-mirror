Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBEC31F462
	for <e@80x24.org>; Tue, 11 Jun 2019 23:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436948AbfFKXs1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 19:48:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60040 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436924AbfFKXs0 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Jun 2019 19:48:26 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:4429:e8a6:430:6b59])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 012FF60427;
        Tue, 11 Jun 2019 23:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1560296904;
        bh=trzF3DmZpr33GBHh+oiIkxvcbs1CjA0kCfwqlirdMGg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JmxmdNebCoPF9NEI+C2dUKZssOqdQoYBxMtle8wnN1yf8iv9Xg2XiDasO+Upoq8SA
         BDdZ3Pllvxbl/0EXr3VHS9Qlup7oy72/5sQ9iQ6RubmN9G3wspRO0HXGtSuj8NwXbw
         r23CwPdaOH15Jkie/EYMpQgiyYGMijiQLSOc2k+mf8wnm6LS4oedSqtkDnEvDfnnI/
         p6q/vfmCPdEWPD7QwkoJkcG/FHeZhr8YEGdnYn6XQokaiJpBMgg2/LnbDmethNv8uY
         9CBRiCyc1AE9eOxFZobYo/0y/pyj8WMMMAIu/8pROl8OeiXjPcCJW6nQo0lSpbvtce
         O8QAJotK4zXm+6+72a07gTk7zRgruMZYbNpZ6OLuoenNKkZvhM6l2+Jaw5X2Xz5pX+
         fcksVDH0HvqhiF9b4ie8Wn8hBmgVM8u0cvbLecleqexqv63Acx5J/jhedjllgmAZBg
         psK4hxVwwhSKA77j3hdVIkz9/lWg6GdBfFdju9GxxcY1vnxSkyf
Date:   Tue, 11 Jun 2019 23:48:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Elmar Pruesse <p@ucdenver.edu>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Reducing git size by building libgit.so
Message-ID: <20190611234815.GB8616@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Elmar Pruesse <p@ucdenver.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <21f1f334-755e-3283-d0da-ec0ab9231cfc@ucdenver.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="52aklQ8BZHJhx2Z3"
Content-Disposition: inline
In-Reply-To: <21f1f334-755e-3283-d0da-ec0ab9231cfc@ucdenver.edu>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--52aklQ8BZHJhx2Z3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-06-11 at 19:52:18, Elmar Pruesse wrote:
> Hi!
>=20
> The total compiled size of libexec/git-core is currently somewhere
> around 30 MB. This is largely due to a number of binaries linking
> statically against libgit.a. For some folks, every byte counts. I
> meddled with the Makefile briefly to make it build and use a libgit.so
> instead, which dropped package size down to 5MB.
>=20
> Are there, beyond the ~20 ms in extra startup time and the slightly
> bigger hassle with DSO locations, reasons for the choice to link statical=
ly?

I think the reason is that libgit is not API stable and we definitely
don't want people linking against it. Before libgit2 existed, projects
like cgit built their own libgit and it required pinning to a specific
version of Git.

Also, some people install Git into their home directories, and a shared
library means that they'll have to use LD_LIBRARY_PATH (or equivalent)
to run Git.

Finally, we have support for a runtime relocatable Git which can be run
out of any path and still automatically find its dependent binaries.
That won't work with a shared library.

So if we did allow for building a shared library, it would have to be an
option that defaulted to off, I think.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--52aklQ8BZHJhx2Z3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl0APb8ACgkQv1NdgR9S
9ovI9RAAsaASlrt6xZUcbL8g/mks/L1vaRzTROZVqxjkb913hvworMQe8kgxoytY
lvFt01DjqqfR4Wmr6717mlu9Vu3BZIAZFzMuVCx0YyzfNVWgrjoD11j34kfNfVH5
OOaDzfTWY0onA31cyC9yT1mAqnNuN8olJbEKmP2jNl8mPcbwqoHu3+GGAEVW0cpr
Pnfhaj5Y3qjApKC1n1HD5rKAu9uqYM0JgdGIq1P3d0oBjkPlOGoOZqam7ZZOtOiR
BVKqXrCLvmiMFyQ1RPvHXFZsluhpWassziE4ab1QMe4EvLS/IMsy2ykSnx4efqpb
9wH1Boozitmp8jWp1LwpFHWdLARB3lVWczLIJH1ebVWVVyPIPbTfdTQGkppvMVnB
wBAiiNP5MEvPLUpeiEF3c+HCtw6xRudUT18ZJUYjUU90u13K2ufYl2ZNydEgUcLH
GRUM0om4m0q9fvQS1X/0GuCXoyCIk9/Th6LSKnH8BzQBC+sh44EdDUOcFUtmYImG
H5pmUzuPoW3/mIn9/ID2eWxoPnDzrA1uLwL1fldzembmu4gjtiVdEGXHjbxnZ9lz
Hf21ecRuEInuiCQ+ZAq0JJQcek+XbZzo8HmGnpmIIQfDPwx+NVYqu3kguBhV/Fae
luhHeL4pWMw4eazch/IOuj5Ch/6WdADiRF3XevpmAASBDCyZPwo=
=a+bI
-----END PGP SIGNATURE-----

--52aklQ8BZHJhx2Z3--
