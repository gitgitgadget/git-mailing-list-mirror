Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A973A8C3
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920322; cv=none; b=lrbBnJcaUMTNbSVrzX0GMZDh3tQ0UovO5KK5PssNAmf0DzQGbvJ0DftZoPwaJWC2edcO/9hxY/XmYu+WvrXIs0QX+pa+FllIg5Nkpj5bkeYXSJZctUUe0jk+gG2Z+C0N/4A3kKaKxAuasWbF2B7dVWA6Aoyu6QlvCOhFI7a2YEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920322; c=relaxed/simple;
	bh=d9oG9YNEQFK9OF9mEEfELSm6fV6mJlJ8h0+S94dvt1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTmfY7RHDs7WA+G3MJNny7lu+IvmZjY2V2olsrtIRUQfxIkurVZE11vI7YSyctkZEes6kc/n9NPQ23mzsm4xjC9xiYobh+/ilTFq2L2Ey4aaVZtQzdFfnivw04tKr9fuaRpUDrQTs4PjkRytnwUDjsZD2tXMZU9/Tb54YGiCiNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AusI2Q1F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vjrBdvny; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AusI2Q1F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vjrBdvny"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 66B463200A78;
	Mon, 22 Jan 2024 05:45:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 22 Jan 2024 05:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705920318; x=1706006718; bh=RKWzFu3msH
	pYJppeozrqIdpW4IUVJfxYSEBe1C47qb8=; b=AusI2Q1Fd/yBVpRRCvdQD5XlE9
	Vf37C+eqFKGY2iEhAROhwZh2dZLS5NVS/5J1UDRKPcLpoQnOo5/CajNWPkZc/iAk
	/IrUCLxir9RlWFBcmDab0b5/Xx76GVxsZ0Zd6MRgFt7RFfb0oiTGCuDoCZ1qcYPz
	4S0UHSUAImH77gGZxWc+n+ms8savZZzZVOYfWIBvy/izfBUt1NtG32RNXFS+8S4G
	ihTd/zAfyU7NH1e/iXiGP5AX8ttHxWMlTOzllBAzCoSsxNaC97zXTdgStReuxeGy
	7N4gtnm5u89k2u/4o7TgitaA0UvG4fJiUgcNWAU7D1t6pXHsP9wuqLVl/18g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705920318; x=1706006718; bh=RKWzFu3msHpYJppeozrqIdpW4IUV
	JfxYSEBe1C47qb8=; b=vjrBdvnyROnHfCDdJK9vOipBHy1ZcicAA3qZiKZ9OTmY
	D2uyEZgQ26ltfU4KJ3NljFJ2dcAkVNKpFVlhbB8C6G+Ok8NrsWnpLWKoTaZmk+7G
	wFep6DFG+1HX2eNuOmCYh9SZpmDnCeaxXuARrgGwt3FzEz2vv0aIh0otKHsERx4z
	zqRikKqr0AGhWI7Zmv1+gZ+YyR/VQWwNonkuHaoOSZtCLeZ6rEY59yDMpocKfOMC
	wtWCvCAHU+cRMLNBW9JfkcLnOdJEUNNcbCaFKQ1VMSZTq5PW2Mxmw/cqgYFsfIlS
	QbJ3sYZOlmvWtsDpMI8wu/bVDu+mWbkStYbhyFyiYQ==
X-ME-Sender: <xms:PkeuZWSCj3F7ZdvMOaoSv1yXaTllsJoJ1M6vWMVNMzRRUg6dZmBJuw>
    <xme:PkeuZbx4Zn1TNDnXFqbKmmtGNK1r4iWG7IMHrXn6zOVQNto6WMv8YuoGiaPGpUusT
    yMv-r0AShLeWAdvOg>
X-ME-Received: <xmr:PkeuZT2oysHFRHpiZNJCd0dE50xpCMnuvcu89GHlMzegxfHaROejusxaFJA1PxI_NWMuZeAG-fFdBsIsYu2UhKJ3PZN8_H1bb6YICgr_Jyd06TA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:PkeuZSDcj9mEcR1h0LBfIg26CxZUg-6h-eXOYxQxqNWyGf18Ri9Vfg>
    <xmx:PkeuZfg9ycv8fdIvXYhsEs0KAOMK0nUHb1q6SGoIMHW0I2DsPJnFQg>
    <xmx:PkeuZerO4kO4JsGM1fQXXbfTGooQ4eyTL7HXYgNESG1rwyz18wu-aA>
    <xmx:PkeuZXZLOjExfI4roU6UOGu5zxz37qVbNU0gr_Cl6TltTOjZvXlTfw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 05:45:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8b2fe394 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jan 2024 10:42:13 +0000 (UTC)
Date: Mon, 22 Jan 2024 11:45:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/7] refs: convert AUTO_MERGE to become a normal
 pseudo-ref
Message-ID: <Za5HOkWM3IQIiKDJ@tanuki>
References: <cover.1705659748.git.ps@pks.im>
 <ae2df6316f79e372c51d59666d685e59981d2f98.1705659748.git.ps@pks.im>
 <xmqqjzo5jf79.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+n3pX7n2ubhIq8rt"
Content-Disposition: inline
In-Reply-To: <xmqqjzo5jf79.fsf@gitster.g>


--+n3pX7n2ubhIq8rt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 11:28:10AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > In 70c70de616 (refs: complete list of special refs, 2023-12-14) we have
> > inrtoduced a new `is_special_ref()` function that classifies some refs
>=20
> "introduced"
>=20
> > @@ -4687,10 +4685,17 @@ void merge_switch_to_result(struct merge_option=
s *opt,
> >  		trace2_region_leave("merge", "record_conflicted", opt->repo);
> > =20
> >  		trace2_region_enter("merge", "write_auto_merge", opt->repo);
> > -		filename =3D git_path_auto_merge(opt->repo);
> > -		fp =3D xfopen(filename, "w");
> > -		fprintf(fp, "%s\n", oid_to_hex(&result->tree->object.oid));
> > -		fclose(fp);
> > +		if (refs_update_ref(get_main_ref_store(opt->repo), "", "AUTO_MERGE",
> > +				    &result->tree->object.oid, NULL, REF_NO_DEREF,
> > +				    UPDATE_REFS_MSG_ON_ERR)) {
> > +			/* failure to function */
> > +			opt->priv =3D NULL;
> > +			result->clean =3D -1;
> > +			merge_finalize(opt, result);
> > +			trace2_region_leave("merge", "write_auto_merge",
> > +					    opt->repo);
> > +			return;
> > +		}
> >  		trace2_region_leave("merge", "write_auto_merge", opt->repo);
> >  	}
> >  	if (display_update_msgs)
>=20
> We used to ignore errors while updating AUTO_MERGE, implying that it
> is an optional nicety that does not have to block the merge.  Now we
> explicitly mark the resulting index unclean.  While my gut feeling
> says that it should not matter all that much (as such a failure
> would be rare enough that the user may want to inspect and double
> check the situation before going forward), I am not 100% sure if the
> change is behaviour is acceptable by everybody (cc'ed Elijah for
> second opinion).

We only ignored _some_ errors when updating AUTO_MERGE. Most notably we
die when we fail to create the file, but we succeed in case its contents
aren't written. This does not make much sense to me -- my expectation
would be that we should verify either the complete operation or nothing
of it and ignore all failures. Gracefully leaving an empty file behind
is a weird in-between state, so I'd claim it's more or less an oversight
that we did not perform proper error checking here.

Patrick

--+n3pX7n2ubhIq8rt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWuRzkACgkQVbJhu7ck
PpSItg//ZkMfkrzpPzmB/1peNje+YrwaimyeofjmuMprxQrlpIOZUWraOPgs1D5H
rOWa4hn+npbKGw12rF+UAbmmn9hq333TRXpdzwYdc2yMGqmgsEQuxjGLUD2WHe1P
Cge2LWPWbYr4a00jsF5wMOJqC88Y+Wb5wveR1wnC2rmlj7HvDfL45pppzk5Ga/aA
yC9g0cN6wTaLl7HQWEX7vrsHltOivhXNHpxzBbV+3QozOkkn/PlgUKNOYibyZ5g8
Y3twWi75EFHoWF+TEn0aXSTGN5E2xAfeNPCc0cf41qNSx18vTusSqa+EqSMULopJ
m4omecgYvJXHBbIw2x0U3wxc5ulnJx5COdqIol61q2wb9EbiHvr7Ze3fZFxPU7tw
6sRqJbZWLZJUHXa4sQn/MNr7ucfxakEk0S3/rf5ua+6JPbmZNmYdOqBcfC+X3YGW
M7EDx6X08gnrjw2LaENDpITWYbA6+NT3jycRG1XppOLjbqA1d9MaKxLwGlgp5h4p
Sn2YhFuSuVHbhffkkqAA5sjw0tced5cwWoH3UWCVx7op0E0E1nwmpOjeUzqNWadS
kfPVWk1zIjRS134ECQTqQPm5jZ5d27K+PAfM3mZ+nL2+XwySMbOeVAzR8ZK7DNde
XwQvNKnPWXZ7LdvOYwjcJhg9VsjI/XyJJsSHCnrrjXMw7FZdsuA=
=4qm/
-----END PGP SIGNATURE-----

--+n3pX7n2ubhIq8rt--
