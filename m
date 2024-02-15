Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020E317581
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996121; cv=none; b=mUNKVqYznl8GhZraO0++ygxtu2pAg8aqwvoCQgIXaMMnDGf/qCi4hGtxNGg8Tf1wUDQVE8ILxUg+ttRcla8GMDKNiQs/r13Kt3FwVnKxeOCR+t8WieiPxhT22BkPFam20rlzcyZcssJ+6spOt28jpFFe3Ocj6ifkt1uaf8IQ5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996121; c=relaxed/simple;
	bh=zk3DFgVNS6cQGyd7LtkkLfVwizA8jjpgmeDj4p8shGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fudimerLhLdFwdmhe+9aKCq2I4dDCl389bwccFp2ZlDVq9S26ffsQzESo6wVZevD2qMth5blWyl4uBeL5Bvjy62j/F3U5AWf8IOChdqQr8nTDliCaLGTs1fSSu4msgNB4E2ikpEXW7pSQxiowGvhssQN3yieES890kjpc8ENJz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PQ5M6eF5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U5NAPHML; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PQ5M6eF5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U5NAPHML"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EE8BB11400B9;
	Thu, 15 Feb 2024 06:21:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 15 Feb 2024 06:21:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707996118; x=1708082518; bh=VOgvkYvxpn
	W8XvQxmtMkLhrLq2ZY90ZMHyc7BcEl+6g=; b=PQ5M6eF5XYp4vEiyrMGg5BU0GI
	Ouw8yTkA5p3awpsTfYdYnhT70G5ILazA1Pnw7D2q8m0xOhe9AeBOIjNbh0lVJI3h
	ef1z1z1EcdczDy93c+blGHgLDsR6glM+Z84bk0KMZQESu1YKdy917NdxSoZA/1Ia
	QVzDZp/As3oNKdE+SaMy97LkUodp6aBg0bsoeseYQYS6WGNP8Ba67I07l7QdZicR
	evUfBkTM9hhVGYJ1F4568OZ3FZJvM8woFJanPxIDQAH6kwzezNjpM5ufQhbqfIlb
	t/jnBbbhU4TUZn8uT8W7YqoTeyE+/pJx7/zc3ZvUR3eUsZTymvgYhb1m5MDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707996118; x=1708082518; bh=VOgvkYvxpnW8XvQxmtMkLhrLq2ZY
	90ZMHyc7BcEl+6g=; b=U5NAPHMLwM7wXjpQ+grUhpGn/MfzyzIlODtqFokNBjxC
	/eZRKa6kkUkVAQ/QJnkcQ8h7jGg0X1n0wqSOzOM5sRebiyhCbvl+FdOr2u42Fx9Y
	AK0CFKyurn+gT1Wt/m5g8iv0w2CPeK6y8/FMP2+Gi76bX6GErFsomtaA+y4gifL+
	NcmewzuiJGu9MKnaODQkfj1hyDZkkg7COKqozSzRn/G91rRg9sBFYvBczh0IH1oh
	ZBdXGipGGbvUUFGvLiJPst/7pVIhBukmbFREcAUtruyE8Z9F7nLhn+pzzZpOfrs2
	CKkE8xkR5z6mkK9hL0Ni56qiZ2vTgHB5oZAYQQpL8w==
X-ME-Sender: <xms:1vPNZbIZa2TOZLFe3G3FX2SzbIuOGVRi7n-sljLsGLmhgwMKMupMTg>
    <xme:1vPNZfL4vU6Wgk3vEfFFeMU3SZb_gWySof1S7djYx1QHG_YTvQVsaTketkpBzpWam
    U5aY1n34Vi3FViutw>
X-ME-Received: <xmr:1vPNZTvDBIeQ-WDoD7v4ja566pnCTrTc3yImJfL49RStiTqDzVqk9z6NkbDrF2paBoFsORWWZLG0fKLFKGzENwYe6zSm_SC-EgQwkbsQbFaL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:1vPNZUaOtS1bC-BFyrx3B08gS-V9S0kCQiYqnSmVTM8YDgG63GdDfg>
    <xmx:1vPNZSY87KwubziVOS4J0Xt6DyUe2eddnobc-JMGwOhxtm7Egmo9Dw>
    <xmx:1vPNZYBcjsb9lP7U3ERi03iYh2wQQbS-RVMJNHbehq6_XarEfPrfgg>
    <xmx:1vPNZXNPemVHHf6CuOJqcxPDf1bjlH_ymTm0oUFkxpcxj_9CxvmF8A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 06:21:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 66bf1fb9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 11:18:05 +0000 (UTC)
Date: Thu, 15 Feb 2024 12:21:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "Eric W. Biederman" <ebiederm@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2 03/30] object-names: support input of oids in any
 supported hash
Message-ID: <Zc3z09woCStanYlP@tanuki>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
 <20231002024034.2611-3-ebiederm@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QthQH+SCsvXoGPBL"
Content-Disposition: inline
In-Reply-To: <20231002024034.2611-3-ebiederm@gmail.com>


--QthQH+SCsvXoGPBL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 01, 2023 at 09:40:07PM -0500, Eric W. Biederman wrote:
> From: "Eric W. Biederman" <ebiederm@xmission.com>
>=20
> Support short oids encoded in any algorithm, while ensuring enough of
> the oid is specified to disambiguate between all of the oids in the
> repository encoded in any algorithm.
>=20
> By default have the code continue to only accept oids specified in the
> storage hash algorithm of the repository, but when something is
> ambiguous display all of the possible oids from any accepted oid
> encoding.
>=20
> A new flag is added GET_OID_HASH_ANY that when supplied causes the
> code to accept oids specified in any hash algorithm, and to return the
> oids that were resolved.
>=20
> This implements the functionality that allows both SHA-1 and SHA-256
> object names, from the "Object names on the command line" section of
> the hash function transition document.
>=20
> Care is taken in get_short_oid so that when the result is ambiguous
> the output remains the same if GIT_OID_HASH_ANY was not supplied.  If
> GET_OID_HASH_ANY was supplied objects of any hash algorithm that match
> the prefix are displayed.
>=20
> This required updating repo_for_each_abbrev to give it a parameter so
> that it knows to look at all hash algorithms.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  builtin/rev-parse.c |  2 +-
>  hash-ll.h           |  1 +
>  object-name.c       | 46 ++++++++++++++++++++++++++++++++++-----------
>  object-name.h       |  3 ++-
>  4 files changed, 39 insertions(+), 13 deletions(-)
>=20
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index fde8861ca4e0..43e96765400c 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -882,7 +882,7 @@ int cmd_rev_parse(int argc, const char **argv, const =
char *prefix)
>  				continue;
>  			}
>  			if (skip_prefix(arg, "--disambiguate=3D", &arg)) {
> -				repo_for_each_abbrev(the_repository, arg,
> +				repo_for_each_abbrev(the_repository, arg, the_hash_algo,
>  						     show_abbrev, NULL);
>  				continue;
>  			}
> diff --git a/hash-ll.h b/hash-ll.h
> index 10d84cc20888..2cfde63ae1cf 100644
> --- a/hash-ll.h
> +++ b/hash-ll.h
> @@ -145,6 +145,7 @@ struct object_id {
>  #define GET_OID_RECORD_PATH     0200
>  #define GET_OID_ONLY_TO_DIE    04000
>  #define GET_OID_REQUIRE_PATH  010000
> +#define GET_OID_HASH_ANY      020000
> =20
>  #define GET_OID_DISAMBIGUATORS \
>  	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
> diff --git a/object-name.c b/object-name.c
> index 0bfa29dbbfe9..7dd6e5e47566 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -25,6 +25,7 @@
>  #include "midx.h"
>  #include "commit-reach.h"
>  #include "date.h"
> +#include "object-file-convert.h"
> =20
>  static int get_oid_oneline(struct repository *r, const char *, struct ob=
ject_id *, struct commit_list *);
> =20
> @@ -49,6 +50,7 @@ struct disambiguate_state {
> =20
>  static void update_candidates(struct disambiguate_state *ds, const struc=
t object_id *current)
>  {
> +	/* The hash algorithm of current has already been filtered */
>  	if (ds->always_call_fn) {
>  		ds->ambiguous =3D ds->fn(ds->repo, current, ds->cb_data) ? 1 : 0;
>  		return;
> @@ -134,6 +136,8 @@ static void unique_in_midx(struct multi_pack_index *m,
>  {
>  	uint32_t num, i, first =3D 0;
>  	const struct object_id *current =3D NULL;
> +	int len =3D ds->len > ds->repo->hash_algo->hexsz ?
> +		ds->repo->hash_algo->hexsz : ds->len;

`hexsz` is not an `int`, but a `size_t`. `match_hash()` of course uses
a third type `unsigned` instead, adding to the confusion.

>  	num =3D m->num_objects;
> =20
>  	if (!num)
> @@ -149,7 +153,7 @@ static void unique_in_midx(struct multi_pack_index *m,
>  	for (i =3D first; i < num && !ds->ambiguous; i++) {
>  		struct object_id oid;
>  		current =3D nth_midxed_object_oid(&oid, m, i);
> -		if (!match_hash(ds->len, ds->bin_pfx.hash, current->hash))
> +		if (!match_hash(len, ds->bin_pfx.hash, current->hash))
>  			break;
>  		update_candidates(ds, current);
>  	}
> @@ -159,6 +163,8 @@ static void unique_in_pack(struct packed_git *p,
>  			   struct disambiguate_state *ds)
>  {
>  	uint32_t num, i, first =3D 0;
> +	int len =3D ds->len > ds->repo->hash_algo->hexsz ?
> +		ds->repo->hash_algo->hexsz : ds->len;
> =20
>  	if (p->multi_pack_index)
>  		return;
> @@ -177,7 +183,7 @@ static void unique_in_pack(struct packed_git *p,
>  	for (i =3D first; i < num && !ds->ambiguous; i++) {
>  		struct object_id oid;
>  		nth_packed_object_id(&oid, p, i);
> -		if (!match_hash(ds->len, ds->bin_pfx.hash, oid.hash))
> +		if (!match_hash(len, ds->bin_pfx.hash, oid.hash))
>  			break;
>  		update_candidates(ds, &oid);
>  	}
> @@ -188,6 +194,10 @@ static void find_short_packed_object(struct disambig=
uate_state *ds)
>  	struct multi_pack_index *m;
>  	struct packed_git *p;
> =20
> +	/* Skip, unless oids from the storage hash algorithm are wanted */
> +	if (ds->bin_pfx.algo && (&hash_algos[ds->bin_pfx.algo] !=3D ds->repo->h=
ash_algo))
> +		return;
> +
>  	for (m =3D get_multi_pack_index(ds->repo); m && !ds->ambiguous;
>  	     m =3D m->next)
>  		unique_in_midx(m, ds);
> @@ -326,11 +336,12 @@ int set_disambiguate_hint_config(const char *var, c=
onst char *value)
> =20
>  static int init_object_disambiguation(struct repository *r,
>  				      const char *name, int len,
> +				      const struct git_hash_algo *algo,
>  				      struct disambiguate_state *ds)
>  {
>  	int i;
> =20
> -	if (len < MINIMUM_ABBREV || len > the_hash_algo->hexsz)
> +	if (len < MINIMUM_ABBREV || len > GIT_MAX_HEXSZ)
>  		return -1;

Isn't this loosening things up a bit too much? I'd have expected that we
would compare with `algo->hexsz`, unless `GET_OID_HASH_ANY` is set and
thus `algo =3D=3D NULL`.

Patrick

>  	memset(ds, 0, sizeof(*ds));
> @@ -357,6 +368,7 @@ static int init_object_disambiguation(struct reposito=
ry *r,
>  	ds->len =3D len;
>  	ds->hex_pfx[len] =3D '\0';
>  	ds->repo =3D r;
> +	ds->bin_pfx.algo =3D algo ? hash_algo_by_ptr(algo) : GIT_HASH_UNKNOWN;
>  	prepare_alt_odb(r);
>  	return 0;
>  }
> @@ -491,9 +503,10 @@ static int repo_collect_ambiguous(struct repository =
*r UNUSED,
>  	return collect_ambiguous(oid, data);
>  }
> =20
> -static int sort_ambiguous(const void *a, const void *b, void *ctx)
> +static int sort_ambiguous(const void *va, const void *vb, void *ctx)
>  {
>  	struct repository *sort_ambiguous_repo =3D ctx;
> +	const struct object_id *a =3D va, *b =3D vb;
>  	int a_type =3D oid_object_info(sort_ambiguous_repo, a, NULL);
>  	int b_type =3D oid_object_info(sort_ambiguous_repo, b, NULL);
>  	int a_type_sort;
> @@ -503,8 +516,12 @@ static int sort_ambiguous(const void *a, const void =
*b, void *ctx)
>  	 * Sorts by hash within the same object type, just as
>  	 * oid_array_for_each_unique() would do.
>  	 */
> -	if (a_type =3D=3D b_type)
> -		return oidcmp(a, b);
> +	if (a_type =3D=3D b_type) {
> +		if (a->algo =3D=3D b->algo)
> +			return oidcmp(a, b);
> +		else
> +			return a->algo > b->algo ? 1 : -1;
> +	}
> =20
>  	/*
>  	 * Between object types show tags, then commits, and finally
> @@ -533,8 +550,12 @@ static enum get_oid_result get_short_oid(struct repo=
sitory *r,
>  	int status;
>  	struct disambiguate_state ds;
>  	int quietly =3D !!(flags & GET_OID_QUIETLY);
> +	const struct git_hash_algo *algo =3D r->hash_algo;
> +
> +	if (flags & GET_OID_HASH_ANY)
> +		algo =3D NULL;
> =20
> -	if (init_object_disambiguation(r, name, len, &ds) < 0)
> +	if (init_object_disambiguation(r, name, len, algo, &ds) < 0)
>  		return -1;
> =20
>  	if (HAS_MULTI_BITS(flags & GET_OID_DISAMBIGUATORS))
> @@ -588,7 +609,7 @@ static enum get_oid_result get_short_oid(struct repos=
itory *r,
>  		if (!ds.ambiguous)
>  			ds.fn =3D NULL;
> =20
> -		repo_for_each_abbrev(r, ds.hex_pfx, collect_ambiguous, &collect);
> +		repo_for_each_abbrev(r, ds.hex_pfx, algo, collect_ambiguous, &collect);
>  		sort_ambiguous_oid_array(r, &collect);
> =20
>  		if (oid_array_for_each(&collect, show_ambiguous_object, &out))
> @@ -610,13 +631,14 @@ static enum get_oid_result get_short_oid(struct rep=
ository *r,
>  }
> =20
>  int repo_for_each_abbrev(struct repository *r, const char *prefix,
> +			 const struct git_hash_algo *algo,
>  			 each_abbrev_fn fn, void *cb_data)
>  {
>  	struct oid_array collect =3D OID_ARRAY_INIT;
>  	struct disambiguate_state ds;
>  	int ret;
> =20
> -	if (init_object_disambiguation(r, prefix, strlen(prefix), &ds) < 0)
> +	if (init_object_disambiguation(r, prefix, strlen(prefix), algo, &ds) < =
0)
>  		return -1;
> =20
>  	ds.always_call_fn =3D 1;
> @@ -787,10 +809,12 @@ void strbuf_add_unique_abbrev(struct strbuf *sb, co=
nst struct object_id *oid,
>  int repo_find_unique_abbrev_r(struct repository *r, char *hex,
>  			      const struct object_id *oid, int len)
>  {
> +	const struct git_hash_algo *algo =3D
> +		oid->algo ? &hash_algos[oid->algo] : r->hash_algo;
>  	struct disambiguate_state ds;
>  	struct min_abbrev_data mad;
>  	struct object_id oid_ret;
> -	const unsigned hexsz =3D r->hash_algo->hexsz;
> +	const unsigned hexsz =3D algo->hexsz;
> =20
>  	if (len < 0) {
>  		unsigned long count =3D repo_approximate_object_count(r);
> @@ -826,7 +850,7 @@ int repo_find_unique_abbrev_r(struct repository *r, c=
har *hex,
> =20
>  	find_abbrev_len_packed(&mad);
> =20
> -	if (init_object_disambiguation(r, hex, mad.cur_len, &ds) < 0)
> +	if (init_object_disambiguation(r, hex, mad.cur_len, algo, &ds) < 0)
>  		return -1;
> =20
>  	ds.fn =3D repo_extend_abbrev_len;
> diff --git a/object-name.h b/object-name.h
> index 9ae522307148..064ddc97d1fe 100644
> --- a/object-name.h
> +++ b/object-name.h
> @@ -67,7 +67,8 @@ enum get_oid_result get_oid_with_context(struct reposit=
ory *repo, const char *st
> =20
> =20
>  typedef int each_abbrev_fn(const struct object_id *oid, void *);
> -int repo_for_each_abbrev(struct repository *r, const char *prefix, each_=
abbrev_fn, void *);
> +int repo_for_each_abbrev(struct repository *r, const char *prefix,
> +			 const struct git_hash_algo *algo, each_abbrev_fn, void *);
> =20
>  int set_disambiguate_hint_config(const char *var, const char *value);
> =20
> --=20
> 2.41.0
>=20

--QthQH+SCsvXoGPBL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXN89IACgkQVbJhu7ck
PpRU2BAArjP9DI5a1ferbgIlNSIDvndd+T1VFQOeNLJiWg176c4tPS70Ni3Dl7FW
AH2AruFwggm2mBBThDDOHoJAdMx2lFi32OJfi7slGle3p+88pzTEedHK3O46j+uC
2ld6w6eSEYYb8yBOqsOZmH0c40C+CthKiwhs6V+rafYHbXC4VSg8ZFV3KxzDFQa3
ePQuczh7zcRiV+YdDaDHCvZ3C1TbE6ZO7Yek+lUvsDNTKs85cCXB0WrAtD4XGpil
qlLF8WzEuqmLTAgnatAhf3vY0md9gwa/+h6DERa3M98Ylv3bKrBFRMSjSgk+tu3G
fo15RQqUsVJjP7niGtF5P77fWeS3JCYbAufVY156/0V5z5KLpXMjVMAxZfNMfNae
IYDAp6O0NtjqPEjejstcZl+xFKD3b78hhcr6HHCBvxgzU9tJIBK/S+ZGVg+aTHLw
UL8UQD8p608NRKuUK72gKrFJA+X5jUch1ZK/XX+elqa3qPNJAIkcusBG9TihnMQ6
i634d6iwCjdcpJC58RTtJsk/FDgxGkRBAxZKRURnSjJSKs/QOE+tfVvs6TxoYtpq
ovJj369IwSKxIi6JO1yzdUT19jBweiMjqMQx5/5XVZsucrM1sgTfI2EgeJ2nivFO
2vt40jQEq125pLjVi1yKovv/k4kGohOEQttgznrWhhZ299ctGgg=
=3yTP
-----END PGP SIGNATURE-----

--QthQH+SCsvXoGPBL--
