Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0EB1474BF
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715589380; cv=none; b=pa5I33a6UpxRhUkY0TY8vWFF6Qh1fE/hnLnM0FbNpBS34D/g9IjX6MtpEt2EXG0sH5EkMTFCw4LUPSalMHXXF1aXBr9y8ZZtCoqTEI2IwNwxyhxY3swOjAp6vD40XdEfcWBQha8XAVlBRo3g4iDSUfF/jKqTJrxCl4BUMrSmf9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715589380; c=relaxed/simple;
	bh=EdF+D6Lq5LIWqBwyTW67of9UG+804s4aDMeo+Jyxtw0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvpYMRLvj7rgrk153fcNp4JCtG1PF9YmI6PCOJo9iGdQNKLRFCKg/iiKVLBpIivi3E4HHyK4JmpnCpFMFTpDA0ArbKmiyqaykYYe1YZ7lxvIASKpuxsqZjbVxCnqIzQTqV44jAFu4VM2DFdN3qBPKnS1qybTKPZcaa4lkrIsrtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bG4JnMoJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FyUiA69g; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bG4JnMoJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FyUiA69g"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 87E551C000F7
	for <git@vger.kernel.org>; Mon, 13 May 2024 04:36:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 13 May 2024 04:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715589378; x=1715675778; bh=/X4AsFjaig
	d6HPuHCiLZEFEgU3QN0hqh7e7ekKMWyVU=; b=bG4JnMoJ1n90JPDFz+YRCI7hu0
	NlGlUXS0H8jYgRjTV6bULUoP9K+JBZz5png/0QY4jfkN/xsQeecUXpZOjrvISyzW
	f7ElwG6fG7OMSg9iCTld3IBqpeTs3nAvhfK8UzmmPm9RJW+N8Ufz1DzsWTQw5pGf
	WmYWF9aJ+9dSz5blmxxF4Wy+ceSTOOqh0sHSZjFOwymeq/VEbrKUpL26fzyH9KBn
	3dNvxwo4YyMqc4FLj0RWGOcc2nhQ6lX4Qd/xQhFhODs0N7tkrCeAZzKORA2CGxEB
	0Us5clOW3MS/Pp/0b9PKbBX/9e9BSXaVr9yLjcXjnb9lg0xex5EaFlU6NoWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715589378; x=1715675778; bh=/X4AsFjaigd6HPuHCiLZEFEgU3QN
	0hqh7e7ekKMWyVU=; b=FyUiA69gFddznYVpVByyTacEkpxxqrbnY1gKZzmyKaqn
	Gx75M9k1AUnIkfKOOM2VYkhwgpBA+zZU+4ulDisRtNkh90UuGzN0pcw52jc53oUd
	20G7crwa0xa3/DXLMyi+Rsa0gkWk5X9NzVw0DhrcSh1iymf1GuCeKy1MnGnjoqbp
	MO8x9w/Mw0TbAD/hF0MqT7TvwlnUmPNpvpDQIvaIiKoAcS9MsYWsgwt7BbPe8ySN
	N/rdeOsA+zrvomJt3lC9Gi6QqYS7F7EtbaJSBsKb97OQ65p6y7+oJX5YviDzIYAP
	VYy0PxV0f/FDFqAciKm8I7rbIwVUSzZtXRCcHX3pgA==
X-ME-Sender: <xms:AdFBZif1TZFnk5Hv4W9CIHTwNZroNOzFMnMKU7C3JpyGCRMV3JqAPw>
    <xme:AdFBZsOHXALraCPLAT_CFLQJnh9HUsdRFUQJVbi4NUDA2HgEfruZMVnw9ciA7IIsy
    3fmPQ6m2jA-b28cpQ>
X-ME-Received: <xmr:AdFBZjhYg1xSzP-h9tHtrbY3nI6J2jllM77Ic9mq8cJkoAupcWP0HVJoI4nr0M0zCDa3y2pjYUsoVC8dwlfVavNo3MInIEJDtcxwpGIQYdLkWcU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:AtFBZv9Lso2pNw0vUGQlycCfZTkQXVo2IICiKkm0SKDn_3xMa2qQJw>
    <xmx:AtFBZus5ifIvVCbnzthvgCkS_ufc9EkHjFKwRskizNSTsZ2W_r_Qsg>
    <xmx:AtFBZmFnAT7y6auKrZFo6iV-jPLj_c9v9ajE1HMmu8JIJsTlgqga_A>
    <xmx:AtFBZtO7g4de8gi_juzHS4vTRLpwL8QCeNCcRZ0edst6xqYK_2bL_A>
    <xmx:AtFBZjU4YXkGRkfMHGHQXnDDJjYNgf1GdVubsZQ_QKEi65BLLk9tqCyo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 13 May 2024 04:36:17 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cd58d0ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 13 May 2024 08:35:55 +0000 (UTC)
Date: Mon, 13 May 2024 10:36:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH 07/13] reftable/merged: split up initialization and
 seeking of records
Message-ID: <ZkHQ-yAtzm1GNqFY@tanuki>
References: <cover.1715166175.git.ps@pks.im>
 <21b3e3ab5f04e66fdd352187b1da699d1ab67cee.1715166175.git.ps@pks.im>
 <dqnhhjdingkhhwwp5nwut2hsnkkze7m2ls4kscddqxm3txjzbf@5knvdk4vc6eg>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c2QSM1du739nQu4w"
Content-Disposition: inline
In-Reply-To: <dqnhhjdingkhhwwp5nwut2hsnkkze7m2ls4kscddqxm3txjzbf@5knvdk4vc6eg>


--c2QSM1du739nQu4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 02:18:16PM -0500, Justin Tobler wrote:
> On 24/05/08 01:04PM, Patrick Steinhardt wrote:
> > To initialize a `struct merged_iter`, we need to seek all subiterators
> > to the wanted record and then add their results to the priority queue
> > used to sort the records. This logic is split up across two functions,
> > `merged_table_seek_record()` and `merged_table_iter()`. The scope of
>=20
> Did we mean `merged_iter_init` instead of `merged_table_iter()` here?

Indeed, good catch.

> > @@ -246,32 +230,33 @@ static int merged_table_seek_record(struct reftab=
le_merged_table *mt,
> >  				    struct reftable_iterator *it,
> >  				    struct reftable_record *rec)
> >  {
> > -	struct merged_iter merged =3D {
> > -		.typ =3D reftable_record_type(rec),
> > -		.hash_id =3D mt->hash_id,
> > -		.suppress_deletions =3D mt->suppress_deletions,
> > -		.advance_index =3D -1,
> > -	};
> > -	struct merged_iter *p;
> > +	struct merged_iter merged, *p;
> >  	int err;
> > =20
> > -	REFTABLE_CALLOC_ARRAY(merged.subiters, mt->stack_len);
> > +	merged_iter_init(&merged, mt);
> > +
> >  	for (size_t i =3D 0; i < mt->stack_len; i++) {
> > +		reftable_record_init(&merged.subiters[merged.stack_len].rec,
> > +				     reftable_record_type(rec));
>=20
> I find it somewhat confusing how we increment the subiterator index
> here. I assume this is because when a record is not found we don't want
> to add it to the index. Might be nice to add a comment here explaining
> this.
>=20
> Edit: Looks like you address this in the next commit so I guess we are
> good :)

Seconded. And yes, as you noticed, this is one of the reasons why I
change this in the next patch.

Patrick

--c2QSM1du739nQu4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB0PoACgkQVbJhu7ck
PpQzsg/9Gkux8r38xI5KEFgutLm1mObfYX+Jj/9czffqn/KSxgn+Ebp0jyV+06Jj
xstJm3geBPWeXkKhdzxeXC7wHzbSjQY36Of5mdIJjlW5cTaD86u6BtlIfP+AN8ju
Jzemm2yuSMDW0Z46rt9TyGkuG2vxKS8zyfV1XJwmn4tMGaR0IdWgfT1tLkSKW2HE
VQ05/kmfwRYEkKQh1KopmU167dCFqVSksjmYoNpBiFmueGK6YsKFxlIMfBXO2wAV
kdopV/HQMRP1qo5zCzrQSFasT5QS9Bw3xMqgmfi8Z0U3pOwcVnvdSdXCQxNCXnvs
wL6AkpzIs22a3z8YKZVKx/trolwp7LCmgY0L5quCNKON1kmcwAqjEBdQdLkzuGH6
WAvjrUhlVb42un7OWSYO7EveBO74z3p6R/w22/ps6ApgxEmBinfK1hc228SGZ0hg
9ttfj4yTSA/2B5TzTE2qpdPqKW9iYZTfOmPqyd3491hM2gt0q6EyO4JtLxumJijk
3hm3lwx30MTjlyywGVdHTAdo0xl4QXRRrKGjQFlfv6KsejvOR3tZN+vpeRWhyHcv
/57FXh3yDji9bEkG/Z0BkcKOl7rcqhEiRL3XwB2gLjZ/Hl0nCVXwC2ep3aiYou57
vhmd7Jj8My1hukvLMS9fnydCx902CsjAHsizfE0nnnFCeAVQRv8=
=MHeJ
-----END PGP SIGNATURE-----

--c2QSM1du739nQu4w--
