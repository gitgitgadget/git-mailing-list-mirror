Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75B7E1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 00:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbeLTASb (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 19:18:31 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57794 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728849AbeLTASa (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 Dec 2018 19:18:30 -0500
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AC8496042F;
        Thu, 20 Dec 2018 00:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1545265108;
        bh=s7aGJU+96KCp+MSzKaJqfqjmrv1gmPzUR47h1hPwkHQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=jh28X2PN5N+hHVTDZjgQFkTbZUMLPp0fjokb75m89BeAAVFwejqIHpUvkJ6j3mGs+
         oSpztpsRhN+EaEocYdkKAyA0o/rmneOu92ubBciwlKGvYxDPHXGZfPub3LgA2PNgo5
         xlPWK3J4hXcD3HCHETOkQ3u509fUazOpgBatysrPVWxW7sP/CrVmkF+//Sd/igp8Sl
         19yrsdgiSAyM15cJPnatUxIaaRrOep0/tdaAEpK4QB/hbURPYvJYLT3gR6J9jpLdMC
         YD8cVyGdP+FwRdF4JwE8R/TNodT+WIxLl36HUvVzXsitYhWhdnJKTkxY0Drn4cDUY0
         WBZOvAQ8Ad+ac9EbtABG2TVEaRvm9tZia2Jr9jtiVqNCm2razmnMUKagIwjV0+wXy2
         UsHCQ49uRPjJfCQoEXPJ6BKlP3wvacLEqkvw2yVBezr9XFgyWFAtIj4WDVJbcejX2W
         9RDGiysMQMRP9ey884Q57LY44h6eyOVay6ZxlNsjC1a1UsB6X9w
Date:   Thu, 20 Dec 2018 00:17:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] setup: drop return value from
 `read_repository_format()`
Message-ID: <20181220001752.GA35965@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org
References: <20181218072528.3870492-1-martin.agren@gmail.com>
 <20181218072528.3870492-2-martin.agren@gmail.com>
 <20181219152735.GA14802@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20181219152735.GA14802@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 19, 2018 at 10:27:35AM -0500, Jeff King wrote:
> I dunno. This is one of those dark corners of the code where we appear
> to do the wrong thing, but nobody seems to have noticed or cared much,
> and changing it runs the risk of breaking some obscure cases. I'm not
> sure if we should bite the bullet and try to address that, or just back
> away slowly and pretend we never looked at it. ;)

I will point out that with the SHA-256 work, reading the config file
becomes essential for SHA-256 repositories, because we need to know the
object format. Removing the config file leads to things blowing up in a
bad way (what specific bad way I don't remember).

That may influence the direction we want to take in this work, or not.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwa37AACgkQv1NdgR9S
9ou+lRAAmOH4O3vanenWH9dqMPn2kQpOFLQVOPb7sbU9CVysKu5bpUKPZITokf4s
9YCPGlpfjAUSLFGQfCPSKUjTJfU86FGbKO5JjmFbF4IoWJzBVjBnE5CXiruuBNTA
CkjPa32HSS0N+CNcO9le9wYcopgdokiGQDPQvEEaWfm312yh1bEQ2sOiAjr9Wb/X
zL6vdyaZw7qY5kY8IPAdwc6F1M1vT3xnIpLCGjgH+Of1uPA1P+FPWSAOD2ZFB8gu
VKvn2TBIp6NpfWJ1EezUD8aTlEQgU94M2cySsTdoSg69keSUE5SxK3JnIQJq12wy
HN0aCC23fu9+buMiOjpIdv3sZ4o4KHhVtRdXkVimMDN/tgQvfjfsmNjn/b4rFQbw
d/RwQV9y7yD08EyeW4Gcw0jWDpBGlC8CjK5xh6fJp0HYK8B29FS15Q7iCbFu6S+7
htJ+8yQzj8mcr0cpTxRXSOE1F6ykXfkt2Rv2xR6spltdZj5O8xo8MrrbXzpr7KzB
WcdV5AoPFEID0QI9aWjquiDNk25xt7ljyq4hG7APw1ycd3RyImrQVu11WN1kL9VY
EJl9HPpeUAiHk0Mt0py2ZVVia3EpwI/xnQ4R0u7it1F/HR3746IdwTCbLUdFEdlx
sihTM95ED17AzvfsEKaSDBWa9dwztui9YGgL6lok2TvsvGBoQf8=
=k5pb
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
