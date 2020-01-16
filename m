Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BD5C32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 00:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EC92467A
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 00:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MWYT77GY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgAPAW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 19:22:59 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39714 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726552AbgAPAW7 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Jan 2020 19:22:59 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2D89360426;
        Thu, 16 Jan 2020 00:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579134177;
        bh=JDjd/TZo6qHPNS1ozVJ0YGS1JyRvKQ3Nhg3KK6XenI0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=MWYT77GYMzhNe1KdLsFV911ZqxpoOCeTl9pUJp9HseqWZXmb5nWsvbCAnVDMudNcy
         NvZng8lcEBpyWd+E0JKerxEiZc1w3bN8c2GNvfqBGWlKsGTfi85RsXcOxvbOIdDiXX
         N5Pvr3NRAqsRC5R4bxeRRMuAjTsF6O4ytTmOWxzVLAP+2kZZRqWhXnJKQkW6htVS8M
         OJ+9sIXzhgBm1mrShjqRss+LIxFxvlgNKI4aT3pvNNtXh2d9MXenCZjxbynOz0athd
         5kLFGivf8y9426bed/j//+ISLZcmMrRd/kDePnAB+O6QY/NKPpGkZmLLnrhsJU4Tbu
         9tIypj39j1Bs9Jsiiz2bBKr4NOPK5bc8gH+xnAsmKQe+B9j0W3sJwTL5e5l55x6Tu6
         dc4JDXRICFTDnu8vWIzJEeGqXrNiEe7cSDVv7SdewcgnDRnVi2RTaVmfQ5J+rahIX3
         rshFCZKZuWOpYqrjrWNSBgnaEuJsPvcFlLjJunKwpsSfUJLPKmX
Date:   Thu, 16 Jan 2020 00:22:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 02/22] hex: add functions to parse hex object IDs in
 any algorithm
Message-ID: <20200116002252.GX6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
 <20200113124729.3684846-3-sandals@crustytoothpaste.net>
 <xmqqv9pciejd.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5FDiZl1vRbLRjwwc"
Content-Disposition: inline
In-Reply-To: <xmqqv9pciejd.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5FDiZl1vRbLRjwwc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-15 at 21:40:54, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > +/*
> > + * NOTE: This function relies on hash algorithms being in order from s=
hortest
> > + * length to longest length.
> > + */
> > +int get_oid_hex_any(const char *hex, struct object_id *oid)
> > +{
> > +	int i;
> > +	for (i =3D GIT_HASH_NALGOS - 1; i > 0; i--) {
> > +		if (!get_hash_hex_algop(hex, oid->hash, &hash_algos[i]))
> > +			return i;
> > +	}
> > +	return GIT_HASH_UNKNOWN;
> > +}
>=20
> Two rather obvious questions are
>=20
>  - what if we have more than one algos that produce hashes of the
>    same length?

Than we have a problem that we'll have to deal with then.  There are a
handful of functions that essentially document all these locations and
we'll have to decide how we fix them.

Notably, the dumb HTTP protocol doesn't provide any capability
advertisement, so it's not possible to ask the remote server which
algorithm it's using or negotiate a different one.  Bundles and
get-tar-commit-id are the other problem cases.

Granted, I did very much try to limit these cases as much as possible,
and most of our more modern code doesn't have this problem, but in some
cases it's just unavoidable.  I feel like with only three uses, doing
this won't be mortgaging our future too much.

>  - it feels that GIT_HASH_UNKNOWN being 0 wastes the first/zeroth
>    element in the hash_algos[] array.

I actually think it's really useful to have it this way, because then
it's easy to check for a valid hash algorithm by a comparison against 0.

> In the future, I would imagine that we would want to be able to say
> "here I have a dozen hexdigits that is an abbreviated SHA2 hash",
> and we would use some syntax (e.g. "sha2:123456123456") for that.
> Would this function be at the layer that would be extended later to
> support such a syntax, or would we have a layer higher than this to
> do so?

That's going to be at a different layer.  We'll have the ^{sha1} and
^{sha256} disambiguators that can be used with the normal revision
parsing syntax, and we'll handle the ambiguity there if one isn't
provided.  As for output, we'll only produce output in one algorithm at
a time so ambiguity isn't a problem there.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--5FDiZl1vRbLRjwwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4frNsACgkQv1NdgR9S
9ou+OA/9GpfU0IsX1oYF3iS1ds64pjMuRwNmv/JIZl1K+8+G+FGwNCZI2cqXXWOh
3cLukf3/ZGmFcL/cq0T40qtQnColAOGxEoJMBc9kMFbZEG7mp5zFYKqZflCehHfV
DukxDzPE+8vTDP3Z7IMfZUrNV1aLmRTSiS0d8/lXVLi8rNdIppZ/1IFBeA7EPcvF
8b9nttogFH2mKqN5Vd9VBGT7TcE9snRHQbt/vJpIKHh/avxdQ2bC1eiW0qXa6F+I
BpwkGH3jgPKp8DwGtP6mrAs9qka4MjPD3D/X/62/oysQpVDekZkeqhaaYfULywsA
uH0Hh0+IadOUplLXfxkBYPamD+ROrpUVlD1kz/f3+p45F252qgEUdjh9K3p4bNs/
x6KvOVgMRcpkwR8QgI6XxYIX0ePaf4Vuv8JXPf8jg/b6VrdLMi5zJzvhK7XIQlvy
+TG0o8uhdlD4ODI8Us6cpGOJvKPMhZAJsSdpKvYBgryhkpvjWjKiLEqJZ+YWwiwq
Wk3R+8MAYv0sSZr/bJTE5vRgTqIGJDb0Pp0fhzkJ1txcMKGgJqOCnJyIyofwkmVk
5F/TNVu+f3b8O/2NJvghzHg60IuwRQ2acI1D1EHXnDBUFTvbdalIJJWQ+kwvXiq/
v+Bbc/CODk3V9uUY/j+eoV6SB6gn6W4iSC6sPeaq5LlrQ0GuCDc=
=LY7V
-----END PGP SIGNATURE-----

--5FDiZl1vRbLRjwwc--
