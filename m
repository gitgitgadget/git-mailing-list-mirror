Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32FC57C94
	for <git@vger.kernel.org>; Wed, 15 May 2024 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715763924; cv=none; b=qcW2EOrFbX8cSlrlIdfHaiEABbvfmJpkkdKGdPDt3K9n2cG2m/wVGzt6cppfKGCR3+2bqX9lJWWoD3XTkkCsw2eyS7oOHgPu3Sn/0QXiQORsGdBXN4JnppyvSbllxr1Dyx9IIX68LgyvnpPWVMjkVrLcMRzezwMXCYrERpGGrs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715763924; c=relaxed/simple;
	bh=TQuwspVB7tf2Q5F63VC2KXz0qC8zvbq4Af5pEyiSFcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5aN+OXpSplxEW/jFaRBj0FM+HiJxlzc7q5FlVEYmdMuoWQsdj3wP9fMH6JWpmSjuHXxXG5wPwLhZAJb4/jBx1cae/0OOj/kLmg+kxr5CLP8qEzIXSETRhVDGj5TkkHHBZCn+nJtY3wPEaiYOEN/XvYF9d5NvOJcwII48BRp/+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VajAJCo6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IMl/SngA; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VajAJCo6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IMl/SngA"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D0894114009E;
	Wed, 15 May 2024 05:05:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 15 May 2024 05:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715763921; x=1715850321; bh=hlSA5G7hEB
	3KSMnWmAtHfeSmYHFIlajJcu4gvGc2YCg=; b=VajAJCo6LbHX7yZprECdhkXoPd
	NHeZmY+sI5eHiOCllnn3TWkIX/29xWLpWLczF+IInYF7ZVHndracF5edwAFtLNdA
	sVpg7yp/JJUhGGfNfBawImZ1y+iZIbs7fjvfBdYEdXRe3qWeHScYjlaJUoxEdpll
	ZjONbVArIOlYgexbqgHkSmfwtOVA/B7B3SIUNa+qPcj9SotGB/BWUuIXRSqOTP0O
	yJ8q///QqeIcHkfYT3PboCgeC1JVFPSUHD4aZVJ9+gphol7fimK4VcZztL4nMRsL
	9BAB+J3C6+pWQ4ywD5EoXFx3IZHzOXZrcm2yLg5OrfjixBG3coF4Z4sCSFjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715763921; x=1715850321; bh=hlSA5G7hEB3KSMnWmAtHfeSmYHFI
	lajJcu4gvGc2YCg=; b=IMl/SngA4uPvNgDZ8RdOIhGtzpxo7zS6zKJgOxjVds+k
	rnZlI2RB73N6NkOyyjrBecLZDVQgh68SqqWEoV44770YXxfe9HrI8o+QNUqlXoRT
	vP51O0ocyw7tMDi3eeSWlB8TdY6GZBklUljwhmwih6AcIyfPMqNehvU/GZMhMf8Q
	/ajlajoEGEda9N3eR/KMzspWgM3AncjewQMwSvE5p/SZ4pOi3oMdJSNcnhfOopec
	bU6dqCh3TQJufkG+FXGyAvP6DEtuslow9NQGkLtVcy8hWr5ba3BwuD1hE0XDfJe5
	av4/um4r/Hmgiy9xWBCnKusRHD3rtvwPbDDZ6p7EBg==
X-ME-Sender: <xms:0XpEZuQP4hhq-8Gg2DixjqINHS4QxQMpm099nZ1Jzkawky0dGYkn2w>
    <xme:0XpEZjy4rVjhnVBqZYRtjVIdinhEiSvwrsRTn9kbMof0R2ZURHUBRRVJ1V7iJyefe
    cSOXTuIrGFNupyzYA>
X-ME-Received: <xmr:0XpEZr2xLay9IjM4A0ZLWTrtUpCtkJNQXdYHnL4pov0zIlgrJZyY145Vi-fFaNXCtLPBmGQEQr28Ydrf-w_rnJakSoNY-02v4hqwbts_iJsBL7k0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegkedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:0XpEZqDnQ2LoxGFd0-G_JPkNGVcC8_gdAa_6HiuBx87KHlrcfFOcbA>
    <xmx:0XpEZngjx1yCVxnFE507XtfGwOvRV1WqzegB6v7RSaQfaIIIq2dK5w>
    <xmx:0XpEZmqGLq5xe5RvtnfP4m-G28k0cVENZj22mvJi5bf3deUwimA7mw>
    <xmx:0XpEZqgI6D5IbT0EDx3WGtdfTep31FtS0Ze9bBJ79GlUDojWV6vNPA>
    <xmx:0XpEZncEgyYxDlC6ca_XeDKk4lqKG-XCF52O3ijk6kFClizH2nLL5Ozz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 05:05:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f8833d23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 09:04:57 +0000 (UTC)
Date: Wed, 15 May 2024 11:05:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] pack-bitmap: introduce `bitmap_writer_free()`
Message-ID: <ZkR6zkUfW6Fosqyn@tanuki>
References: <cover.1715716605.git.me@ttaylorr.com>
 <bf65967764f34adc2ca00d4c8195840ad3e4e127.1715716605.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SFtjA2hFlgTuPRbx"
Content-Disposition: inline
In-Reply-To: <bf65967764f34adc2ca00d4c8195840ad3e4e127.1715716605.git.me@ttaylorr.com>


--SFtjA2hFlgTuPRbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 03:57:06PM -0400, Taylor Blau wrote:
> Now that there is clearer memory ownership around the bitmap_writer
> structure, introduce a bitmap_writer_free() function that callers may
> use to free any memory associated with their instance of the
> bitmap_writer structure.

Great. I wanted to ask about this in preceding commits already, good to
see that you already thought of if.

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/pack-objects.c |  3 ++-
>  midx-write.c           |  1 +
>  pack-bitmap-write.c    | 23 +++++++++++++++++++++++
>  pack-bitmap.h          |  1 +
>  4 files changed, 27 insertions(+), 1 deletion(-)
>=20
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 10e69fdc8e..26a6d0d791 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1245,7 +1245,6 @@ static void write_pack_file(void)
>  	uint32_t nr_remaining =3D nr_result;
>  	time_t last_mtime =3D 0;
>  	struct object_entry **write_order;
> -	struct bitmap_writer bitmap_writer;
> =20
>  	if (progress > pack_to_stdout)
>  		progress_state =3D start_progress(_("Writing objects"), nr_result);
> @@ -1315,6 +1314,7 @@ static void write_pack_file(void)
>  		if (!pack_to_stdout) {
>  			struct stat st;
>  			struct strbuf tmpname =3D STRBUF_INIT;
> +			struct bitmap_writer bitmap_writer;
>  			char *idx_tmp_name =3D NULL;
> =20
>  			/*

Nit: we could have avoided moving the struct if it was introduced in
this spot in the preceding patch.

[snip]
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index 420f17c2e0..6cae670412 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -32,6 +32,29 @@ void bitmap_writer_init(struct bitmap_writer *writer)
>  	memset(writer, 0, sizeof(struct bitmap_writer));
>  }
> =20
> +void bitmap_writer_free(struct bitmap_writer *writer)
> +{
> +	uint32_t i;
> +
> +	if (!writer)
> +		return;
> +
> +	ewah_free(writer->commits);
> +	ewah_free(writer->trees);
> +	ewah_free(writer->blobs);
> +	ewah_free(writer->tags);
> +
> +	kh_destroy_oid_map(writer->bitmaps);
> +
> +	for (i =3D 0; i < writer->selected_nr; i++) {
> +		struct bitmapped_commit *bc =3D &writer->selected[i];
> +		if (bc->write_as !=3D bc->bitmap)
> +			ewah_free(bc->write_as);
> +		ewah_free(bc->bitmap);
> +	}
> +	free(writer->selected);

I was wondering whether we also want to set all those fields to `NULL`
at the end, or just `memset()` the whole structure. But there probably
isn't much of a reason to do it currently, so I don't mind if your
answer is "no".

Patrick

--SFtjA2hFlgTuPRbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEes0ACgkQVbJhu7ck
PpSyHQ/9EAWt1J2RAEHgksgVmpFKUB7LWEHVhrbBQ4vnoVHw/QLMAAMC7N6o7Can
7Hh5ePKZeImD1lAt7jXZAlUQ8qQ4zRaPSmCBoMI1LAAV81hxPxdMGBpErJH9D7tW
Tv3RExyhAbJWML10JAfTrcjkbP10y9MFpoWH+HMDMwnNmzYPeYJoWVhFoLJ242+p
L7OMAWfZerX+zqCS8mU790E7B0GfSRPiyH6QG8lsm+aEe2R0ZyB8QgKDUt2o1D3c
bxTEYIasLDqGvARVURSLmbzo7e8Qx3e3ch6FiHff/uRvs1Ie84dsR8Mj4H01/sCM
hfdTDl36/njoArWxK2Bb/lZyCaGZ/+D9d4tgN8Dco61FCx/e8xZmhyylLecSbVt5
4oIJ8Rn8z6aDDNTqCngvYMUSBh9jrYVchE2FdOqcacJgsiRXoLebiDxITEK58ymI
iZqV3eG3Y6gwSowCYbDrCtcregY2rwy6JdBEqMpYTZNSXtrgF7mApqk66d21oVe1
11oOKVcUb4Iorvmzys6MJkQR0ujVwQlM7DqnT7uRb+pMVHOAiStG1vCiFlM35DeJ
j85FFes1GyG9DwWN4uvTIS4NKgE6TyW9PfHLn3UHNwWSMQ9k+3BTIi1k/85OYjCn
PBVZECmYelcs8c20/Uw1JBcXkv9VBxF5OzolV8txzHsmIeYQjRw=
=jBcr
-----END PGP SIGNATURE-----

--SFtjA2hFlgTuPRbx--
