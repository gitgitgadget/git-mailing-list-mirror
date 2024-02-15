Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3218D128382
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996134; cv=none; b=cx/R9OgJIL06N39FRu94X/QID2h1m+3Wo0E9Qqpl0FcDzyHo3IsCFyb/MCuVlT0ndNp7WaZQKl59yA2bY7liaCnZleH0Gawb2WHzRZEEXkxyGPwc+UDdiMxgFoa6JvY3UhA1DRWVqx/fXiw5VKyAhzDAjXlnr9GrnbEM70qK52U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996134; c=relaxed/simple;
	bh=Jhp2Niex9B5ckadgQ5n9ebRnUwshLjji62vV8Cud7VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3WEUhdjw4DCa8JwhN5GVtFcxo51lV8YsYB6ryudV8AZvWQxwBTJDDoHlypxp5rUSvOHi6P9MEm4p+NKhcZy6MrZ4dQxTVrTMZTNRaBGSt2SqNNw3qiqiYadYnx9gy/9D5aL/JlkS2MNKQ2EPSzj2GxnGx+P8XfGxkOQlMIu9+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=azh/qkcM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oIFSEjgL; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="azh/qkcM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oIFSEjgL"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 22C7B5C00CB;
	Thu, 15 Feb 2024 06:22:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 15 Feb 2024 06:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707996132; x=1708082532; bh=LtLMKUcP4S
	eJOhoyy+tFbwzM4FXdZu28Wwr3b7uNWlw=; b=azh/qkcMpxNZQ5ax6a2z7i7nvM
	zdpoFzW2c+u5IO3OvKeIV3uYjl4IlGRNKNvzUhahD3hUQPqp4olS3EwBs9PBaGsT
	TTrU4oFqba9/2jDxQ2ka5/DSesS8SEueiwINrg9owFnnyaBqXjTdCJcZQjAtO00A
	oPG2ngTgnqsgut742hhV4pOWYrxO9S1ZppfliBree2oCvYgnNB84SUrOxyIvt5xy
	Xv1JRVCMiTUhU4TT44ASdQE8gdDDhSdT/SAzKhNLwTbELhv36C9Zo7YJidfxcOyA
	ubJuWAhEy7IH6XIyayMU07f13oBiZQgKByhyErnMklEWTZUjJwNyVZuQFGDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707996132; x=1708082532; bh=LtLMKUcP4SeJOhoyy+tFbwzM4FXd
	Zu28Wwr3b7uNWlw=; b=oIFSEjgLe5ufIPmHsb47Mrm18RADvWF7LCT0sA88Afjv
	tF7XJaDCZe/j0h6oZgZuT22Ru9RlLsNcfr0gNVDJ0g+wGBi+WpT7yFbgZJk/g7nm
	X1dM1qWdoTUpqzJC199B4XEwvIBwdrAboMp2j1fsI+xduZO47k4gwoezBu80E6sF
	u5X+a/8rzYdCn2bEzcHX15OTtsddOlMxA0gncl90+hnbblt7BRVcTiNI+0n7YZRO
	qT9ZedAXod2zW/9iPZe0dOaHT1wwtF7fJLE/0hL/GHW5xUlCV+0iEGrYfwTuiYSr
	8KdTrg23e9QI4vaSw3M3g9avjxWz91e+8hKJ4Jy/mg==
X-ME-Sender: <xms:4_PNZSW32BzfsxL7dqaVaJfvDhOYpqlPqtG9C1FXt0YxWFbdmKJuQQ>
    <xme:4_PNZelU4zDSI8QkRZ2CjwIzHf8Oxn3_p9mjpKyotsziHyw4Wrs8ATI9lXBPMW5Wv
    OAER_GTDZ_y-R51gg>
X-ME-Received: <xmr:4_PNZWbVQFsj05FG0LXNTtmCTWdGSNa-RiAvQ14zVSgFFdFK9TNGwgE6rNLNuH9Ffd_Vw9JhNNv-9mY1OVBieYdkth35IbWJiDV3BggvIip_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:5PPNZZXsP42dYueCzhqtMN8ZUs9cmYBvheIc61hLAfHJ5PB39owspg>
    <xmx:5PPNZcldZR6hHt34bcnwKPGpsJsq-Xl1Gl1kONfxmnZ7_jzMCTFrAg>
    <xmx:5PPNZecgnkfL_P0WoPX83O4Ms6p4VV95HmtX3h3dtbzuVmJVaf-tcg>
    <xmx:5PPNZbvJpEsuXGcqVgebZGgMTRWAHB2S9rfh6skVAnr2-x2_YUy9sQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 06:22:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bcfe77d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 11:18:19 +0000 (UTC)
Date: Thu, 15 Feb 2024 12:22:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "Eric W. Biederman" <ebiederm@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2 06/30] loose: compatibilty short name support
Message-ID: <Zc3z4YWYybC0Xi2u@tanuki>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
 <20231002024034.2611-6-ebiederm@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fEtNCfyMLeq4nfOU"
Content-Disposition: inline
In-Reply-To: <20231002024034.2611-6-ebiederm@gmail.com>


--fEtNCfyMLeq4nfOU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 01, 2023 at 09:40:10PM -0500, Eric W. Biederman wrote:
> From: "Eric W. Biederman" <ebiederm@xmission.com>
>=20
> Update loose_objects_cache when udpating the loose objects map.  This
> oidtree is used to discover which oids are possibilities when
> resolving short names, and it can support a mixture of sha1
> and sha256 oids.
>=20
> With this any oid recorded objects/loose-objects-idx is usable
> for resolving an oid to an object.
>=20
> To make this maintainable a helper insert_loose_map is factored
> out of load_one_loose_object_map and repo_add_loose_object_map,
> and then modified to also update the loose_objects_cache.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  loose.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
>=20
> diff --git a/loose.c b/loose.c
> index 6ba73cc84dca..f6faa6216a08 100644
> --- a/loose.c
> +++ b/loose.c
> @@ -7,6 +7,7 @@
>  #include "gettext.h"
>  #include "loose.h"
>  #include "lockfile.h"
> +#include "oidtree.h"
> =20
>  static const char *loose_object_header =3D "# loose-object-idx\n";
> =20
> @@ -42,6 +43,21 @@ static int insert_oid_pair(kh_oid_map_t *map, const st=
ruct object_id *key, const
>  	return 1;
>  }
> =20
> +static int insert_loose_map(struct object_directory *odb,
> +			    const struct object_id *oid,
> +			    const struct object_id *compat_oid)

I think it would've been nice to fold this into the preceding patch
already. At least I wanted to propose adding such a function to avoid
the duplication down below.

Patrick

> +{
> +	struct loose_object_map *map =3D odb->loose_map;
> +	int inserted =3D 0;
> +
> +	inserted |=3D insert_oid_pair(map->to_compat, oid, compat_oid);
> +	inserted |=3D insert_oid_pair(map->to_storage, compat_oid, oid);
> +	if (inserted)
> +		oidtree_insert(odb->loose_objects_cache, compat_oid);
> +
> +	return inserted;
> +}
> +
>  static int load_one_loose_object_map(struct repository *repo, struct obj=
ect_directory *dir)
>  {
>  	struct strbuf buf =3D STRBUF_INIT, path =3D STRBUF_INIT;
> @@ -49,15 +65,14 @@ static int load_one_loose_object_map(struct repositor=
y *repo, struct object_dire
> =20
>  	if (!dir->loose_map)
>  		loose_object_map_init(&dir->loose_map);
> +	if (!dir->loose_objects_cache) {
> +		ALLOC_ARRAY(dir->loose_objects_cache, 1);
> +		oidtree_init(dir->loose_objects_cache);
> +	}
> =20
> -	insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->empty_tree,=
 repo->compat_hash_algo->empty_tree);
> -	insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_algo->emp=
ty_tree, repo->hash_algo->empty_tree);
> -
> -	insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->empty_blob,=
 repo->compat_hash_algo->empty_blob);
> -	insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_algo->emp=
ty_blob, repo->hash_algo->empty_blob);
> -
> -	insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->null_oid, r=
epo->compat_hash_algo->null_oid);
> -	insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_algo->nul=
l_oid, repo->hash_algo->null_oid);
> +	insert_loose_map(dir, repo->hash_algo->empty_tree, repo->compat_hash_al=
go->empty_tree);
> +	insert_loose_map(dir, repo->hash_algo->empty_blob, repo->compat_hash_al=
go->empty_blob);
> +	insert_loose_map(dir, repo->hash_algo->null_oid, repo->compat_hash_algo=
->null_oid);
> =20
>  	strbuf_git_common_path(&path, repo, "objects/loose-object-idx");
>  	fp =3D fopen(path.buf, "rb");
> @@ -77,8 +92,7 @@ static int load_one_loose_object_map(struct repository =
*repo, struct object_dire
>  		    parse_oid_hex_algop(p, &compat_oid, &p, repo->compat_hash_algo) ||
>  		    p !=3D buf.buf + buf.len)
>  			goto err;
> -		insert_oid_pair(dir->loose_map->to_compat, &oid, &compat_oid);
> -		insert_oid_pair(dir->loose_map->to_storage, &compat_oid, &oid);
> +		insert_loose_map(dir, &oid, &compat_oid);
>  	}
> =20
>  	strbuf_release(&buf);
> @@ -197,8 +211,7 @@ int repo_add_loose_object_map(struct repository *repo=
, const struct object_id *o
>  	if (!should_use_loose_object_map(repo))
>  		return 0;
> =20
> -	inserted |=3D insert_oid_pair(repo->objects->odb->loose_map->to_compat,=
 oid, compat_oid);
> -	inserted |=3D insert_oid_pair(repo->objects->odb->loose_map->to_storage=
, compat_oid, oid);
> +	inserted =3D insert_loose_map(repo->objects->odb, oid, compat_oid);
>  	if (inserted)
>  		return write_one_object(repo, oid, compat_oid);
>  	return 0;
> --=20
> 2.41.0
>=20

--fEtNCfyMLeq4nfOU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXN8+AACgkQVbJhu7ck
PpS8OA//eyd2Fk4O5Ds8PDtrhCD0l2Alz27+QC9SCoRpagYDIBsIcfAGRs7w3LhF
ZNE5nFwNSM1TXkFpkRlGOvaypKlSd4G5XljprFf1NWd1YgUDEBRztFpBTP/phj3B
vyUbOFWvtaiCEVQs8wbcLJfrdXGfZLVkdSATEwRkpdwTGLH6oiAW2TGCcD7BTXDY
b9knsQ3lSvLmJbpbTwDF15AjYgq2OMgSx3A8Fc5zoTCF99Q0NZi8yG9RybFJJRRm
/R97q4DZ5NcKkRPsK42lbuL8Z91kBGSYFU5HW2y2MMZMbityA6FyZtABM79Qy9hL
m4LQf+4++Al1ph66n/o+w7aeHhLHHF9hgmVIRWcDZS7VezlIg5fotFHoLgL2Fp4O
MiRsyNOPrAvatcAGs+/822Y+dhjiYrS3KkjOtdCP2MzQ3OTSdwZjx4Tp8yhcG+6F
0cdgGYyueT4JJxRKF/zDqGYSgxtXR1nl+SoYjKARPp3S5UmGpVBR6pVY+Xgcyq/F
kb1OfFETlTeJJsp6lbA1w0iowujtJnH5wDPzx24Gs6fa7O2hgK1SarCs9n05yWWV
c7clYP65howd1DvoJFNhnv6dwdd2R94uEeBKhSMEkXXw/pMGd6XR6QkHVQw2OTr7
j+g8VAFiuu6rY+jIc7443I486MxU7Eyo6RjnIcPoPx6n5ESdJlY=
=677W
-----END PGP SIGNATURE-----

--fEtNCfyMLeq4nfOU--
