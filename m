Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2652B211B5
	for <e@80x24.org>; Thu, 20 Dec 2018 00:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbeLTAVn (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 19:21:43 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57800 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728849AbeLTAVn (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 Dec 2018 19:21:43 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b469:672:eccb:defe])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3DBEF6042F;
        Thu, 20 Dec 2018 00:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1545265302;
        bh=ntqeHjhxvMH4wXyIR/zoEO5+b9MXpMLhO/6062YNUBE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=E16A9NZQb7dldcDtYpAGzAK/D3Sw+4apflgVbz+lTi/ELZqhM4y75YFDHZTbm2A5C
         bAUKV7W/e2+WqVbrRApgIemX/k7e1XIp7cp0+3789cmbOl6SvF5Htkd1y8r1t54dzr
         V3P6bF076TyFCgm43imAnllc6vKiXhKYJWxirCXHBykmXmRFzk890Pz4JW6qTx6zw/
         aAEZyXkhn6Rv3LFtdGccdCJhSw5I6RDubZqHIt9ez4YFlGpKAuawlK5MOlWYv4TXFc
         IhUOBZQ/aGf8h5q/5A5/yXfY8pPZPQyekTkCNLR3ltU60wDxqW0RKqKJQvCrMy9GPs
         LDFdolruvHqDEveXZG0t37OlPcV5Y9KRstjXsnzRvujitaBNfAUWb7rwKzG/r+OpVu
         ty6NyuZw/ceNmV5bbGPoB6EWwf2/32TdQGRX1436QMx7EEgvgSYGgbraF2XoqETsGa
         tm1xFvv7He2X6w6oXf4mxXa0QjKj9SZaI/GzIReElUErEYVlg3l
Date:   Thu, 20 Dec 2018 00:21:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/3] setup: do not use invalid `repository_format`
Message-ID: <20181220002137.GB35965@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org
References: <20181218072528.3870492-1-martin.agren@gmail.com>
 <20181218072528.3870492-3-martin.agren@gmail.com>
 <20181219153841.GB14802@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <20181219153841.GB14802@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 19, 2018 at 10:38:41AM -0500, Jeff King wrote:
> Hmm. It looks like we never set repo_fmt.hash_algo to anything besides
> GIT_HASH_SHA1 anyway. I guess the existing field is really just there in
> preparation for us eventually respecting extensions.hashAlgorithm (or
> whatever it's called).

Yeah, it is.

I haven't tested, but since we just read the value of
extensions.objectFormat, this patch shouldn't have any effect on the
SHA-256 code. The default remains SHA-1 if a value isn't specified
somehow.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwa4JEACgkQv1NdgR9S
9oslXxAAkBkh2S5CsF17kGXEs2M2iKZou6TMa2lyUNG/kcwZV9AQMLRwtKjz2M6z
8qg5kooQujQBb1aUzodrzqCWHG0C5nYc1PXsivX6QQYsYsvgWWj8UDur1boW0Qdr
7INE24l/uSrUB6wcJSeBPMYKteffT6UE8NWeiWUu4g7dpSQI0Sv6oLwjGXYlFySc
8bL0UZt0XQmyEI+XezWI/pIPvP4S2qY/Jd4PfzepQ5ABFjfjpWLnFubvGaCVq3Fd
W6FRyHds42R3UDcGVc7AJ50FSn2XAOBhvOsJYR6PJzCnqusSIDmNr/OPVGVVLsdN
ZX9lYgZM5GfGD0FMJUjwYF/XupKU8qJ/N45zqDqoy4a3POoI0pB0qYHlOLNnpDRZ
PInjAF+ahez19onUyOyzY8mjXNQNM52cCWVI59cTigGgB60ZhTYtsvEeEi1y7bcC
YlLwYrTZdgHWkECf1t9zJoBB9eBbuRo1WSViWYxeeGUGHJ29G6tL0kyj3/tTDjvQ
Iq5QCxvetNPOAxBh1TyxkEqm8mih4s2oJmvV/Wo86q23tu1UAlcNp157/ALn6Rro
+BBZmHZHSRcCK2aUBVsP5e5i8oM2e39IObz2AwjtkP7B6Xju3QMnjAUUjgOqEb+j
Sq0SH76aAPVW5fgzVIBf8KUYECC+uLrgbj0qvwjGXrb8hwPGcdQ=
=7zdq
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
