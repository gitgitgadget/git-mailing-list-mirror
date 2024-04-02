Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A9664AB
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058467; cv=none; b=oqR9ad8o1E62nPeN4Ju2BHO3jM9vgDOlUdK469N/uU9txw4/ddZMT56ij/R8fj2LO0MH2JKzrk3O5FrvF90ZnXoUJjLbByr5MqARKWBsTj60HyTwhSBsWPpKXDrPAnu1CGgKa8Gns0lduUJEtIM8Tizpd1wnMWuMr+Ut3jeDZuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058467; c=relaxed/simple;
	bh=B4dXhaUsmH6xyGkzHTrWj6FtEsMBUD0MAL/I/t6lZNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K21VatTA+7eVRv1vsw1hkMWVvrlJ3q2E92EO8TY39pGgVUstvZqnEy3myUytxSnhvc5tui4buiq4xvuw0ltFNag0xEdiY+RZBRJl3xS7LItEU2NTvofMXF0Wj/XtttoohSUk9d9WgSndwmjycscDoXxl6HIVwWDry+jbN103UTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aOZ6BNyF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pGL3xkhW; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aOZ6BNyF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pGL3xkhW"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id C2AE01C000DA;
	Tue,  2 Apr 2024 07:47:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 02 Apr 2024 07:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712058463; x=1712144863; bh=NbgYc73hbw
	gfcCf5XSRuj553IaERFNzqmZoFF1FPZEg=; b=aOZ6BNyFNZOlKTQ8jybpenrib2
	cNaz9HTiH8Q4Z+/rW9aIDmGiKCoCUsKnKT/K5URD3x/BgvCaUVIZW6Ut1SagQZvC
	RWiAD1sYCG1u2a8BBPhLBz2alhhDq7L4CeWKdFEFLAckoWoYH0V02LTmcecc5Qgu
	6PUrusqa3j3DAF1QHmQ4N64dPD1XXYj4LK+kKn0jT2u9Kj0Et3ubW/+QOLlPKQfg
	5V16/PoMSA+dOcjidGjZZoE88EJqkn1KA4QcbhwSg3T5OuOhrk2cz9/AkOMFnotS
	bTwhJ5l3X2xRBP2M0PZ6LQ33sg1vTEEFr4MxJbGHYYsuQVIVcgS5//LKmxNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712058463; x=1712144863; bh=NbgYc73hbwgfcCf5XSRuj553IaER
	FNzqmZoFF1FPZEg=; b=pGL3xkhWuJfHh7i1oBp9rYu76DiVnKMAq7Lmi1SHzkxD
	tbbn3sTRAS4gvU9ZvDvwhJHjwgGIubt5YxodnDoS1iQz8HJ0OtNottmK+nmgf4Yv
	QN2EFvuiSIsxpAlBRAZduBK0QSdyknKElKbAnuOFRN3WxgcAFy+BF0FSTtbspn2k
	XMpW8UK5zTJvSlst1nkOdvG9y8L9E3Mw1ZCBwZ4ozwLIQzi8akInJHLt7H3dCsHy
	vLFvmLMx+7LWQUHLkwn+1h5joIwgA39arPDmU+Dc6ereIRbnyF3HPkUDWE3OZnaq
	AQCG2DIqjO5c18zt4/u+s4t/YDDNvIp4X5la7Ji+jA==
X-ME-Sender: <xms:XvALZu6p6P7uvoiAWsR-fnHtE70aw1LdfcfOxaIfmQEBUiZsxxYlIA>
    <xme:XvALZn5KGuU5chquf6ajl_tSs8NHp754-fmetVI1WSidApuGVWzB0FIGU96w0ksj8
    jMY_hwafDLglNVu_g>
X-ME-Received: <xmr:XvALZtdDpxLk2YQqMo9PYvuzJWvDdU6gRMLxdQOhl9qOGdu6x3PPTqG2rMdVvItzM_Iv6apFp_mymXu-uLj7gut4ZNJO283heNpO8hk78d2_1Ec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:XvALZrJ4QnnO-0tKZxY1XmU3sAQ1MNHgdAnR9t05t8vWjZNJyHfr3A>
    <xmx:X_ALZiIUGTb_2E7vXgteY7MMOmMoLYSa67QYwWdpwEfAqUJyMkDRJg>
    <xmx:X_ALZsy6Ah0vsakd2HEzDvUthAG6JBDFCNQAZUZln9F8LBLkxNKrhQ>
    <xmx:X_ALZmJiqlwvjv3kTNChSlwdOjinAHc7gSfFQNMmXo6zOemaql8miA>
    <xmx:X_ALZq9mrHUh1ZyVR3ON4753uzRYt3vi7UU9fEGXLIudLHwwdNkOgQPW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 07:47:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 18ea6c43 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 11:47:32 +0000 (UTC)
Date: Tue, 2 Apr 2024 13:47:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 2/4] midx-write.c: factor out common
 want_included_pack() routine
Message-ID: <ZgvwWlvrw8MpC_AZ@tanuki>
References: <cover.1711387439.git.me@ttaylorr.com>
 <cover.1712006190.git.me@ttaylorr.com>
 <0064e363c0cc3288346585a6b4340444ce7b863c.1712006190.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dkbHGd1ioBcujqVJ"
Content-Disposition: inline
In-Reply-To: <0064e363c0cc3288346585a6b4340444ce7b863c.1712006190.git.me@ttaylorr.com>


--dkbHGd1ioBcujqVJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2024 at 05:16:38PM -0400, Taylor Blau wrote:
> When performing a 'git multi-pack-index repack', the MIDX machinery
> tries to aggregate MIDX'd packs together either to (a) fill the given
> `--batch-size` argument, or (b) combine all packs together.
>=20
> In either case (using the `midx-write.c::fill_included_packs_batch()` or
> `midx-write.c::fill_included_packs_all()` function, respectively), we
> evaluate whether or not we want to repack each MIDX'd pack, according to
> whether or it is loadable, kept, cruft, or non-empty.
>=20
> Between the two `fill_included_packs_` callers, they both care about the
> same conditions, except for `fill_included_packs_batch()` which also
> cares that the pack is non-empty.
>=20
> We could extract two functions (say, `want_included_pack()` and a
> `_nonempty()` variant), but this is not necessary. For the case in
> `fill_included_packs_all()` which does not check the pack size, we add
> all of the pack's objects assuming that the pack meets all other
> criteria. But if the pack is empty in the first place, we add all of its
> zero objects, so whether or not we "accept" or "reject" it in the first
> place is irrelevant.
>=20
> This change improves the readability in both `fill_included_packs_`
> functions.
>=20
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  midx-write.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
>=20
> diff --git a/midx-write.c b/midx-write.c
> index 5242d2a724..906efa2169 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1349,6 +1349,24 @@ static int compare_by_mtime(const void *a_, const =
void *b_)
>  	return 0;
>  }
> =20
> +static int want_included_pack(struct repository *r,
> +			      struct multi_pack_index *m,
> +			      int pack_kept_objects,
> +			      uint32_t pack_int_id)
> +{
> +	struct packed_git *p;
> +	if (prepare_midx_pack(r, m, pack_int_id))
> +		return 0;
> +	p =3D m->packs[pack_int_id];
> +	if (!pack_kept_objects && p->pack_keep)
> +		return 0;
> +	if (p->is_cruft)
> +		return 0;
> +	if (open_pack_index(p) || !p->num_objects)
> +		return 0;
> +	return 1;
> +}
> +
>  static int fill_included_packs_all(struct repository *r,
>  				   struct multi_pack_index *m,
>  				   unsigned char *include_pack)
> @@ -1359,11 +1377,7 @@ static int fill_included_packs_all(struct reposito=
ry *r,
>  	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
> =20
>  	for (i =3D 0; i < m->num_packs; i++) {
> -		if (prepare_midx_pack(r, m, i))
> -			continue;
> -		if (!pack_kept_objects && m->packs[i]->pack_keep)
> -			continue;
> -		if (m->packs[i]->is_cruft)
> +		if (!want_included_pack(r, m, pack_kept_objects, i))
>  			continue;
> =20
>  		include_pack[i] =3D 1;
> @@ -1410,13 +1424,7 @@ static int fill_included_packs_batch(struct reposi=
tory *r,
>  		struct packed_git *p =3D m->packs[pack_int_id];
>  		size_t expected_size;

I was briefly wondering whether `m->packs[pack_int_id]` could change
after the above assignment. But there's a loop a bit further up here
that already calls `prepare_midx_pack()`, so this shouldn't happen.

> -		if (!p)
> -			continue;
> -		if (!pack_kept_objects && p->pack_keep)
> -			continue;
> -		if (p->is_cruft)
> -			continue;
> -		if (open_pack_index(p) || !p->num_objects)
> +		if (!want_included_pack(r, m, pack_kept_objects, pack_int_id))
>  			continue;

Another thing I wondered was whether it hurts performance that we now
call `prepare_midx_pack()` twice. But this shouldn't matter either as we
exit early from that function in case `m->packs[pack_int_id]` is already
populated.

So this patch looks good to me.

Patrick

>  		expected_size =3D st_mult(p->pack_size,
> --=20
> 2.44.0.330.g158d2a670b4
>=20
>=20

--dkbHGd1ioBcujqVJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYL8FkACgkQVbJhu7ck
PpQJBA/9EgBrWH6bCREo+wbhPf4iHthAxFlqHruqU18th85NL13HeGf2WgXc2qho
3n9YTfrRRlzrQOhRmkj1/gvNp4qBksG7ElXizusp7k+dKJqX0p3z/crSgSzg05br
Jtjp2mgLJ59/PXt4v1StcZCVg1sTq4R4iXvO1q2Shs6wsgA+lj1Orc5MTY+FpsPR
tzU+16KTj8qAY+Dtcx0uwAREMZ7Il1rC6Uh4IToQkltC5kZNRDF//ogfnzybFnkp
sMkF3JYg/w/9vhsSZQwW23Ynzo9DcGk6gm5RMiJrUAUusbzbW6XHHqItdiiAJgUS
fMP8Lyk+nZtHmFrFo/TYu1BGo26620XwVP9LE82dLghxd7amjJIJuQO0V54k64iG
D+nFUtX/RQI2I98XqclmIosJ7NTYgGWuzCIizGIcw+rLa4Do6lF6105f9zS1Hsfd
rfHDd3gURSRIkQ7Pks5FUCjvtTAtFxMEVDNVIkPmajdwH9MxLg/nbK7hNI6U1c5D
QkdDPkFNmZtpcWS7mJUpKcrOc1uyZNHLfA7FNWoAX/dldhl+PeoJYg6Tm3VClAc1
1DI9WKHzb/i2GgDaxtMTq/4xW1wI+o1/2B14iuWcdQ2MfcIz/pHkwN9jiA7U04pS
xHzEyNBz/rIqy0XiO6AViROHl+6N+R1ZMRLwdkyygJUtnPC67ik=
=XzIM
-----END PGP SIGNATURE-----

--dkbHGd1ioBcujqVJ--
