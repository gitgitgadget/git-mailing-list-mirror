Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAED14D452
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721810165; cv=none; b=gjfJuN9rL9rJNp8U/8mdk/SiXY/XtDQ30ruCp0FeXp5U2JX6cV5VuBGgISExaqo64jnNQo7m6M1tL4PBP1TKzeofGFcvMXoNAyRrpAgbET+g2PNBPMnDy5mIlpoeWMKeCwUhPWS0SZ3TWz89USOUtX/iPsmXLJceSDNOoYKkAh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721810165; c=relaxed/simple;
	bh=y8uiCPQt3E3B4++hJvIstYPv38Gnx+UcSs7ow3N9dZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtE3NUMSnIZt7ooYEHSMzIe6JjnCkOugRNNWsext5nkLwQQTq8bfMADmd+l3t8z1YEOUah6QHamLKcqo895b+t2W+VdDEtyjaDD+2BSd4VMhN7Rez4/Yfd6bdHq6w1HWEtox0H7+jmzC8s9Pdujv+teEcPXFU+W+d39IkfNikAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kl7zHsfP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K8weN91d; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kl7zHsfP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K8weN91d"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 80D22114028A;
	Wed, 24 Jul 2024 04:36:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Wed, 24 Jul 2024 04:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721810162; x=1721896562; bh=1kp7PPXTfF
	PDu+7w55Sj1tW8xTryM1ZLoRyycI52koQ=; b=Kl7zHsfPHYd+juZ7SToCiOnHBf
	pd3tRkHfudnSJ6MzkmJUxQoeRn69p0BfRAAJpt9pdmWlx3wDtnK/q2l6GNIrKqI+
	fABoJtYs/p4nZjnYd55Xs9i13ayDgIl35psBOgq/CEkphLvN6NSt0+8vPVCTbfz3
	qlaVNQ45cI/tAjq6QHgdE1t7RPdfYGagmKpdORQkUZ5HsNwVD+8mAoq7wqQWb6Mf
	6DDlkMiafGR/HxhDZfYKbraENZ7Z+aXJmwetuZywIlPrGBJzy1+Ony0UDkKMWfzA
	BtUbyuOlaeyol7O9D/+ta4wVsdxCddkavyB594yfcLwd5wyLbZ7kCDI6jEnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721810162; x=1721896562; bh=1kp7PPXTfFPDu+7w55Sj1tW8xTry
	M1ZLoRyycI52koQ=; b=K8weN91dR99Hw1WB24WoYyXvD4MNMuyr+ZWMcx4xUkRe
	0DCx1IkSf2MXOkZy7PcPIEne88BsUNx1099DRL6MZWRWpdDAupJ2UNqqoZdNurlB
	sTNLBfbRhQ2W7WWQG7TOqm9INjtMsYhYW6bYMT2OK06Z+MDPBl+hPSqVF7jplprd
	L90shav9o0Qf4ckpr9EoyJR5qe9Aogovgfz765jXeFu4fTmVkdtxRaEPO3zhKDc8
	zImaQXsiiNp3pHxTGJJ4ImrGC+eIayUYexAelSs1cLaWlOrXoDid4qnpVcWDmeKn
	5m1l9gMFU0g0hdKq+IPtOEsdF2j2y2XlfH/11oeBXg==
X-ME-Sender: <xms:8rygZqeKwgMA2D_LXlPX8iJB-dDPV-vQE4j5ysKdVr0KE6igetrL6g>
    <xme:8rygZkMvUU7DOkzVt8IOu_rS2dUfWPqIpEGFRoeFE9bNgW2lWiwizCkpaA_VrS8p5
    Yxp5jnkmHhABsBV4w>
X-ME-Received: <xmr:8rygZripK-zDR0ZmSVU-8bONW300KryNBP1sE8YkB7GODozi9V5rtcVtr-yZSLx11c6M9Jm2d3TzkklYTHqaFMhpPI636D_y2K-yp4HO4cqc-Hl3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:8rygZn__lROi5U4cDJm9mEoyuBIM0QOW5Lo35xySoEaTXHbLToyDtg>
    <xmx:8rygZmunwQG8VrADlV638gu8NWqxjiFwOJQ2Ocs3ypUEY0CNg6zELA>
    <xmx:8rygZuEGaV3ygvRKyVkPfhCocmos3NfJDI9YGNrN6Zag0znfZQ8qMg>
    <xmx:8rygZlOl7wlp3dbohL-9AGRssECQPPPn7m1XlfNUkXUFCB-0cWVbpA>
    <xmx:8rygZqIH_ej_hLc31il1GBKQCPgW3Bk12bGmwMZj1vOcAxlkjvPXYQyM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 04:36:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4ec65dc5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jul 2024 08:34:46 +0000 (UTC)
Date: Wed, 24 Jul 2024 10:35:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 05/10] cat-file: use delta_base_cache entries directly
Message-ID: <ZqC872ExETzRH60Z@tanuki>
References: <20240715003519.2671385-1-e@80x24.org>
 <20240715003519.2671385-6-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hle73LNbYV8A23PG"
Content-Disposition: inline
In-Reply-To: <20240715003519.2671385-6-e@80x24.org>


--Hle73LNbYV8A23PG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 12:35:14AM +0000, Eric Wong wrote:
> For objects already in the delta_base_cache, we can safely use
> them directly to avoid the malloc+memcpy+free overhead.

Same here, I feel like you need to explain a bit more in depth what the
actual idea behind your patch is to help reviewers.

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index bc4bb89610..769c8b48d2 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -24,6 +24,7 @@
>  #include "promisor-remote.h"
>  #include "mailmap.h"
>  #include "write-or-die.h"
> +#define USE_DIRECT_CACHE 1

I'm confused by this. Why do we introduce a macro that is always defined
to a trueish value? Why don't we just remove the code guarded by this?

>  enum batch_mode {
>  	BATCH_MODE_CONTENTS,
> @@ -386,7 +387,18 @@ static void print_object_or_die(struct batch_options=
 *opt, struct expand_data *d
> =20
>  	if (data->content) {
>  		batch_write(opt, data->content, data->size);
> -		FREE_AND_NULL(data->content);
> +		switch (data->info.whence) {
> +		case OI_CACHED: BUG("FIXME OI_CACHED support not done");

Is this something that will get addressed in a subsequent patch? If so,
the commit message and the message here should likely mention this. If
not, we should have a comment here saying why this is fine to be kept.

> +		case OI_LOOSE:
> +		case OI_PACKED:
> +			FREE_AND_NULL(data->content);
> +			break;
> +		case OI_DBCACHED:
> +			if (USE_DIRECT_CACHE)
> +				unlock_delta_base_cache();
> +			else
> +				FREE_AND_NULL(data->content);
> +		}
>  	} else if (data->type =3D=3D OBJ_BLOB) {
>  		if (opt->buffer_output)
>  			fflush(stdout);
> @@ -815,6 +827,7 @@ static int batch_objects(struct batch_options *opt)
>  			data.info.sizep =3D &data.size;
>  			data.info.contentp =3D &data.content;
>  			data.info.content_limit =3D big_file_threshold;
> +			data.info.direct_cache =3D USE_DIRECT_CACHE;
>  		}
>  	}
> =20
> diff --git a/object-file.c b/object-file.c
> index 1cc29c3c58..19100e823d 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1586,6 +1586,11 @@ static int do_oid_object_info_extended(struct repo=
sitory *r,
>  			oidclr(oi->delta_base_oid, the_repository->hash_algo);
>  		if (oi->type_name)
>  			strbuf_addstr(oi->type_name, type_name(co->type));
> +		/*
> +		 * Currently `blame' is the only command which creates
> +		 * OI_CACHED, and direct_cache is only used by `cat-file'.
> +		 */
> +		assert(!oi->direct_cache);

We shouldn't use asserts, but rather use `BUG()` statements in our
codebase. `assert()`s don't help users that run production builds.

>  		if (oi->contentp)
>  			*oi->contentp =3D xmemdupz(co->buf, co->size);
>  		oi->whence =3D OI_CACHED;
> diff --git a/object-store-ll.h b/object-store-ll.h
> index b71a15f590..50c5219308 100644
> --- a/object-store-ll.h
> +++ b/object-store-ll.h
> @@ -298,6 +298,13 @@ struct object_info {
>  		OI_PACKED,
>  		OI_DBCACHED
>  	} whence;
> +
> +	/*
> +	 * set if caller is able to use OI_DBCACHED entries without copying
> +	 * TODO OI_CACHED if its use goes beyond blame
> +	 */
> +	unsigned direct_cache:1;
> +

This comment looks unfinished to me.

>  	union {
>  		/*
>  		 * struct {
> diff --git a/packfile.c b/packfile.c
> index 1a409ec142..b2660e14f9 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1362,6 +1362,9 @@ static enum object_type packed_to_object_type(struc=
t repository *r,
>  static struct hashmap delta_base_cache;
>  static size_t delta_base_cached;
> =20
> +/* ensures oi->direct_cache is used properly */
> +static int delta_base_cache_lock;
> +

How exactly does it ensure it? What is the intent of this variable and
how would it be used correctly?

>  static LIST_HEAD(delta_base_cache_lru);
> =20
>  struct delta_base_cache_key {
> @@ -1444,6 +1447,18 @@ static void detach_delta_base_cache_entry(struct d=
elta_base_cache_entry *ent)
>  	free(ent);
>  }
> =20
> +static void lock_delta_base_cache(void)
> +{
> +	delta_base_cache_lock++;
> +	assert(delta_base_cache_lock =3D=3D 1);
> +}
> +
> +void unlock_delta_base_cache(void)
> +{
> +	delta_base_cache_lock--;
> +	assert(delta_base_cache_lock =3D=3D 0);
> +}

Hum. So this looks like a pseudo-mutex to me? Are there any code paths
where this may be used in a threaded context? I assume not in the
current state of affairs as we only use it in git-cat-file(1).

>  static inline void release_delta_base_cache(struct delta_base_cache_entr=
y *ent)
>  {
>  	free(ent->data);
> @@ -1453,6 +1468,7 @@ static inline void release_delta_base_cache(struct =
delta_base_cache_entry *ent)
>  void clear_delta_base_cache(void)
>  {
>  	struct list_head *lru, *tmp;
> +	assert(!delta_base_cache_lock);
>  	list_for_each_safe(lru, tmp, &delta_base_cache_lru) {
>  		struct delta_base_cache_entry *entry =3D
>  			list_entry(lru, struct delta_base_cache_entry, lru);
> @@ -1466,6 +1482,7 @@ static void add_delta_base_cache(struct packed_git =
*p, off_t base_offset,
>  	struct delta_base_cache_entry *ent;
>  	struct list_head *lru, *tmp;
> =20
> +	assert(!delta_base_cache_lock);
>  	/*
>  	 * Check required to avoid redundant entries when more than one thread
>  	 * is unpacking the same object, in unpack_entry() (since its phases I
> @@ -1521,11 +1538,16 @@ int packed_object_info(struct repository *r, stru=
ct packed_git *p,
>  		if (oi->sizep)
>  			*oi->sizep =3D ent->size;
>  		if (oi->contentp) {
> -			if (!oi->content_limit ||
> -					ent->size <=3D oi->content_limit)
> +			/* ignore content_limit if avoiding copy from cache */
> +			if (oi->direct_cache) {
> +				lock_delta_base_cache();
> +				*oi->contentp =3D ent->data;
> +			} else if (!oi->content_limit ||
> +					ent->size <=3D oi->content_limit) {
>  				*oi->contentp =3D xmemdupz(ent->data, ent->size);
> -			else
> +			} else {
>  				*oi->contentp =3D NULL; /* caller must stream */
> +			}
>  		}
>  	} else if (oi->contentp && !oi->content_limit) {
>  		*oi->contentp =3D unpack_entry(r, p, obj_offset, &type,

Okay, this hunk is the gist of this patch. Instead of copying over the
delta base, we simply take its data pointer as the content pointer. All
the other infra that you're adding is mostly only added as a safeguard
to make sure that we don't discard the delta base while the object is
getting accessed.

Patrick

--Hle73LNbYV8A23PG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmagvO4ACgkQVbJhu7ck
PpTWAw//XIns0jpyFtIZw/ykFyjiXJ4pXFCl6QG1pNtFpvZvDOjQUsQaMy8GQMsX
eqQhZ58WY9smjJGSAz4vj1r/3szbrmCYPGFUTLRDvzcUyqgsd2XwUHNQKjoQefxq
MMejkpdmnGDgcypTM/jnvqeIqZ1eVcka0eCST1FXxUImtCqesD9k2ypbtP2gBfnt
r+2Y9882RpXjtPr8zmFxO9oGmEXYDsrYeSChH/aoIVL7qv9tSY7trKQkl0CdxFZk
HOCx7UWMOOg04idooH6gE+76JuVLRMRT8POqtHDltiNy/N8ibJcbMZly1N69qXy0
7WnoAKLQ/uIOziIoaVzvMhTyflEAwQgy0FciMoN4FMTkcgc+l5AQb3Qe/+rTGrJV
MO9m/IUWZ8gMcUp4ZPxu5B0bcAkA6oG4WUF0M9k0jyguLIcyc8EJ0yFncIa1onaB
NL7gQVG9xYUGDU9D5n88g+LL+z9k9neakTDf2HldCR8eHtx0aGIYL4pA8raZd6CE
l2x0iLAg41GeV4YtWPRjkKCOXe+mgT4dxqRYDwy8CRZw0LuTGUglIP3NppKHdUeu
/woexpjAOrf8g4OgUHWrkG61elrWJEbSQnQb/P6TlSDJGzqnee8YLfrabOYvZk3e
GgxpyXEFmFaUd0CdAurjbD1ZCtQT5wfM0Ohndl2WBZALVDY6iOw=
=UkCY
-----END PGP SIGNATURE-----

--Hle73LNbYV8A23PG--
