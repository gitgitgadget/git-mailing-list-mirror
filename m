Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDBAD1F404
	for <e@80x24.org>; Sun, 28 Jan 2018 15:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbeA1PPp (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 10:15:45 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58338 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751699AbeA1PPo (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jan 2018 10:15:44 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 62D30609CB;
        Sun, 28 Jan 2018 15:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517152543;
        bh=DwbSukBimATcRM7Jwhh5jguHC1U8CNd0Nwtcbg6Qruw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hcIkFjqg3L9z8a5C1yax94pFpqfEUbIwZO5/6nPMDuh1QP7J6Tr9NpetHCxC++T5Y
         lvu9xi6oGOjFhQhR7/O6kjvW8b7xYvElGg+3VCtcF16YOlt5zoITHIKWHD1d0514TA
         Oa+IhMVDkF2TEZRk6tbH6bzoCxINhoyFzmqZIJwm+5P0tHbqIF0OUBYjjn8FXr8/FZ
         CwTP7KZyotdkRAEW0Yb3m6LkULfdWgMZ8cew3+xCnO+mViFy2Kc/oUvzSJHpKybRY+
         Ok0rdfpvRuC7A1q1CGtyeHS08fqfFkNa5OhdndRZVnIIEHqUnxLJshlhqBeJo8ST6B
         +C4zrP8Av919h43venmdhsfelV+/RohyNq+jizP1EDEn8F+ftAFIH8VxwaTa9JDH/v
         26vlB2sqBVaCKD+Hw9Rq64JpvfA41eHLizsY09y9Wa6wvEjr9dseLsatw/GUzJgfg3
         T4hsHKnprIQ/JMRNWEQU+QPgGgpVolQb0z0A7rD8UdZGN27uN5M
Date:   Sun, 28 Jan 2018 15:15:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: git send-email sets date
Message-ID: <20180128151536.GE431130@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        git@vger.kernel.org
References: <20180126183230.0ae0c76b@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline
In-Reply-To: <20180126183230.0ae0c76b@kitsune.suse.cz>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-rc8-amd64)
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2018 at 06:32:30PM +0100, Michal Such=C3=A1nek wrote:
> git send-email sets the message date to author date.
>=20
> This is wrong because the message will most likely not get delivered
> when the author date differs from current time. It might give slightly
> better results with commit date instead of author date but can't is
> just skip that header and leave it to the mailer?
>=20
> It does not even seem to have an option to suppress adding the date
> header.

I'm pretty sure it's intended to work this way.

Without the Date header, we have no way of providing the author date
when sending a patch.  git am will read this date and use it as the
author date when applying patches, so if it's omitted, the author date
will be wrong.

If you want to send patches with a different date, you can always insert
the patch inline in your mailer using the scissors notation, which will
allow your mailer to insert its own date while keeping the patch date
separate.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlpt6RgACgkQv1NdgR9S
9otNsw//fToM5SjZuYaOJYr8oOuQFMV6g0aBcAZWFio5pJBMr3FVe+MLunxrGnaD
fmjMqA3JZy0vCNw+irun0he+s8ZgmIuQ2HYQH8/3j7E+RMFlqKEyzFl17ttXlW7y
twpCCIos32tgl6x/pyhwYGfEeZ0+uE2lzhHTplHdIVxoGOhmVVdimFQeMdot7U1z
8s/r38TIhUnft6eCUW1Hk+fMDTPd0yPhSCUW8yEUVbUFqENFxZOkhZz1wWLnBlPQ
iIwclmfhDQE8td462jsNxSPifYi94DDFFAtzDYF+FVwEXT6E6UG9SqCylbLHCx1d
y3hx6X9/dcwDwMMilXeRv7yUlhIDSTNOMSCqbsD5ZoSQEPNaE1hVPLvnRMKSWjTk
n4VkM8eMyauv07DS31YXt/aI58+KH0BRPBPh8DKIW+hjMfHlp/JrkbeFfaaTM1yF
iz/aStlmeDQMyYKatAGUCBK1aFSkrAesP+a0FPdxYcpudmrL8bS0Ncklx8E+eAwo
be/NSw/lkH4qIiaQC4XZjY8YNxWDdKDH5gMWOSEOj3rD1no4PLNnBjJZV+ejnCjB
81rx+/KnOZHK8xm3ZjJ2Civmv/2cj+VKzwn4BWrgaIxsTWMC5QZWX1DiMjjneDFJ
Xyj34Bh53bxl71BxFMhxzW/OXsiN4ycfMzMtz3vsqSig5pNAkLo=
=twpI
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--
