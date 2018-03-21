Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B45941F404
	for <e@80x24.org>; Wed, 21 Mar 2018 22:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753707AbeCUWme (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 18:42:34 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40082 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753309AbeCUWmd (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Mar 2018 18:42:33 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C2963600FB;
        Wed, 21 Mar 2018 22:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1521672152;
        bh=8khar4KkYLVMdsnbI+D+8hwd43ocKcvMYNit5UKWFPE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=SFuTLzygzC853udGPzsRM6FJ+Rv5t5fi2Arm7cWn1a6BBU4f9AwU30FODzqldx9zz
         SVBIJciQwxWrHT5QepAvnXlPfHxVUwx5IrnX0N+nX3sR7WJ7K8eh3eUlKyjV3U1v4J
         6B4rLcQOtNwxMLQVJ/5cbpagpJ5YpIkHO1IIPN3LVvmsaHjS1jNuSzxI/MdiyLNoIz
         nsrJeQP5K5TI4F/u7M5T1O8YCmfKlPkGRyQXAhHdbh4dgZqGReWRsYZxMRWBT6wEzu
         xVnHTYrD8iNlJadEV+2lMIdWHsUh3KIS4ePHg3HBm3JzrbUgICoNL/wSjughz+faSC
         6dKcvoBrTCFxk8oGtm+IFgzR/OMUR0wTzQGl9qT8o8oXB8UoI1CdEppeeP3nGaSYNC
         pGd9jVbZt9aQCd8X4SFWc8NXs3UwQ4fL/dlX7Z+lnhChX2Amy1lCRwMB5DhM6cYM4l
         eB0RqFZltsCmqfXlaYZVyI+fOUkmnV6kSprShgY+GSPcUnIsEXW
Date:   Wed, 21 Mar 2018 22:42:26 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH] sha1_name: use bsearch_hash() for abbreviations
Message-ID: <20180321224226.GA74743@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
References: <20180320200325.168147-1-dstolee@microsoft.com>
 <20180320152505.bd66f0deaecf6d92fa6d62de@google.com>
 <3527bd3a-a899-a909-5fda-1d7abeb0e158@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <3527bd3a-a899-a909-5fda-1d7abeb0e158@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-rc5-amd64)
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2018 at 09:24:06AM -0400, Derrick Stolee wrote:
> On 3/20/2018 6:25 PM, Jonathan Tan wrote:
> > On Tue, 20 Mar 2018 16:03:25 -0400
> > Derrick Stolee <dstolee@microsoft.com> wrote:
> > > One caveat about the patch: there is a place where I cast a sha1 hash
> > > into a struct object_id pointer. This is because the abbreviation code
> > > still uses 'const unsigned char *' instead of structs. I wanted to av=
oid
> > > a hashcpy() in these calls, but perhaps that is not too heavy a cost.
> > I recall a discussion that there were alignment issues with doing this,
> > but I might have be remembering wrongly - in my limited knowledge of C
> > alignment, both "unsigned char *" and "struct object_id *" have the same
> > constraints, but I'm not sure.
>=20
> Adding Brian M. Carlson in the CC line for advice on how to do this
> translation between old sha1's and new object_ids. If it isn't safe, then=
 we
> could do a hashcpy() until the translation makes it unnecessary.
>=20
> I should have compared the two methods before sending the patch, but runn=
ing
> the "git log --oneline --parents" test with a hashcpy() versus a cast has=
 no
> measurable difference in performance for Linux. Probably best to do the
> safest thing here if there is no cost to perf.

There is no alignment difference.  The alignment of struct object_id is
going to be the same as the underlying hash.  My concern in the past has
been strict aliasing violations, which compilers can sometimes exploit
to generate incorrect code.

However, the bigger concern tends to be that when we switch to a new
hash function, we may extend struct object_id with a hash type byte.
The current hash function transition plan certainly makes this a likely
scenario.  In such a case, a cast would end reading past the end of the
underlying array should we read the type byte.

If this isn't a performance critical path, I'd recommend simply making a
copy.  I can clean up the definition of struct min_abbrev_data in a
future series, or I can do something like the following on top of the
last series I sent, which is in next (only compile tested).  If you're
willing to wait until it hits master, you can just drop the patch in.

-- >8 --
=46rom 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
=46rom: "brian m. carlson" <sandals@crustytoothpaste.net>
Date: Wed, 21 Mar 2018 22:38:09 +0000
Subject: [PATCH] sha1_name: convert struct min_abbrev_data to object_id

This structure is only written to in one place, where we already have a
struct object_id.  Convert the struct to use a struct object_id instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1_name.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 39e911c8ba..16e0003396 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -480,7 +480,7 @@ struct min_abbrev_data {
 	unsigned int init_len;
 	unsigned int cur_len;
 	char *hex;
-	const unsigned char *hash;
+	const struct object_id *oid;
 };
=20
 static inline char get_hex_char_from_oid(const struct object_id *oid,
@@ -526,7 +526,7 @@ static void find_abbrev_len_for_pack(struct packed_git =
*p,
 		int cmp;
=20
 		current =3D nth_packed_object_sha1(p, mid);
-		cmp =3D hashcmp(mad->hash, current);
+		cmp =3D hashcmp(mad->oid->hash, current);
 		if (!cmp) {
 			match =3D 1;
 			first =3D mid;
@@ -603,7 +603,7 @@ int find_unique_abbrev_r(char *hex, const struct object=
_id *oid, int len)
 	mad.init_len =3D len;
 	mad.cur_len =3D len;
 	mad.hex =3D hex;
-	mad.hash =3D oid->hash;
+	mad.oid =3D oid;
=20
 	find_abbrev_len_packed(&mad);
=20
-- >8 --
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlqy39IACgkQv1NdgR9S
9ossJA/+K2JfOp4cwR7B/wy0TNwjbuQtv2bdK/SdpjDwVJpmiF8lPfWXM3EeKDQn
oMyeavipKdwmJWK6YN/hQKQGB/UKl1RzXJwvP2IQKy4BvgoPfq7WnGiLCpFK3vUB
XnDv/HfDu591zV0JA6+9VLcoRJGRH6/ZuBRtaq5LXdS0YWa9kw3SgzPZrufRp+EH
RJmlzdinpeNA4xSe2+Mt8ZkELA7CGQcV/60eA+x+DUuggfZC5iZHRmOfnUbSvLCS
X9auZELEwhMCpnRgm8McuVkOxRyFYZzjZu+Q5hgfHqerFTlW6XUwx7wrPznCvFN3
UDtB/RsC7b/DddcLgb/SSjjH/paNUWbjJFLa7NlwaZ3uXPaOCdl5/GeuuDYdfbIJ
5uFfwEd1DoyvtzlQNVhWBiOzxNKu7+HUUERZWvBmOTTIuuC3R84BubB5e3B+2rKy
NEmkBsOAZkJfzchtTXJxXX9YsuAyiluj08FYjGsNmb1yWdrU/eAgZaJDID+lJ0BW
InqxvwHBVwUzfPT7SmjVFQFH6N8iX0EFVYl8ROtBCM42YRDEGN+mL+mIFRsIg7MF
8GE3/EMlHVT5Ir9GSaM6AP6vbQYrV1gWROwleT1VfLTXZ28q1etq9gWGwkStxJek
7+fL9yEp17Hiqi2rsj73fgIxqqDlFXd+W0gU3kzNuzOgtuKSHiI=
=fdgu
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
