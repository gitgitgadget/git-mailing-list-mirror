Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6710758AB2
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 23:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199511; cv=none; b=LT6nV+bc7aby+2XRvPXQFc3OK5gWsejgt3/W4PYMkVkMr3D27qEH283yThoPD39h5UrcthRvggb8zAXY2z//fFbYUfzHzxDgfeWoGk77iBGUQ27yPfR6IB99aWmuZ+7APb6JDcHFfcVaddzx1PiOdcIo8BNnckUT4syrD6c2p+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199511; c=relaxed/simple;
	bh=LG+QeJqk74YBn0xWnCnNgXnYjpcRbJGjskp77hanB5c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIUNTbXo65o0GDTzC2BICRoWHoubItOL/W+lk+kr9foLx/eHHdnJUoXDZKi9rxKG+aJ8szpR+KXnJUOY34d5TpV8K82c8tK6DjoMIky+Mz5lqu0+toXYlYoTDkgpCKy6T6XVlcoZJiXwtQdy/NvcwSRY692pulA+f+2n67h1l7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=elDhrEkJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TlttrmRt; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="elDhrEkJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TlttrmRt"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 77244138012C;
	Mon, 11 Mar 2024 19:25:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 11 Mar 2024 19:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710199509; x=1710285909; bh=CdeVspvX8x
	XJbDcfT4kHEx3RK0K7QY+aivk7Fbaj7gc=; b=elDhrEkJLq1vr61R1AzJQ1paua
	pj0CJFTWY9YpseLlEl/VbakRLgK6P6dgJzvOGcAhfaY3sVCUEBwEi9MtlmPmVDsZ
	8jGyOjO4L6jSynACib37xtAjFC+HaD4Fysl1FQbXyhaDuAijaB6WAAx1Na/Cp5Dc
	qsgrzMu5WuZW2cgzevF8dJX5HzzoPWa5je3tUPLfFO0CxktzKswUNW2OAXQoMVqy
	lOTpAmiX2h93i+ir18l/gYNaTRxVAxqVSf4MXMItEn4tBS9dzPViV4cbc/izL7tF
	D3CaAv72s5XYM29V0oMso/f4uwKKmgGZpBjwepZLpEGHrP+ikn4Q0hvkbMvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710199509; x=1710285909; bh=CdeVspvX8xXJbDcfT4kHEx3RK0K7
	QY+aivk7Fbaj7gc=; b=TlttrmRtz4XpRG4b73S49RLrMrMBi0DSJaZvCDhF8aMr
	CxhDu52eYD31miY2Ici1I1Mhj9hGovhlORqEtS5ECMx8CZ2YORIhL4FqOivPqLg/
	EGYripS1k0RbBdhR6CnyWOR6q2yhLKjBPMf7fuqzEZj390UUEAlZjbcGYJrZZ45M
	RyuI1fD1juUfk9jqFIuYBl6T37HxaV6aPohxIG6ngQk52+JG4iR1rU/XKfuCeXmV
	xUVm680EvAuFZmLhxXpPF6gFRxlvUPTCbUts5riuf/6+CrMRfyRd6i0W1YYRTtyA
	udnrdBQDGChqLVAq+9AGwZXizSGK8Jrmy53mTQEl0g==
X-ME-Sender: <xms:1ZLvZXMY4-ZI6iQpialOIS9FtXarzKQQXMRiOIOo92BCXfz_o6zsIQ>
    <xme:1ZLvZR_XouKVN7WEMkwM2hJ-Aezfbtl9nwfT_uYsE2jXrZ_aL3ySaVEtgRo_lu7Wd
    a-q0XP0EruY4AAjbg>
X-ME-Received: <xmr:1ZLvZWTKj_YF2JxKMoYHWhW2AlPiwCoimAT3rcYQs19k0Qna9TCJIhcFYtltArR7kbPBfNLOq7SW8x-3uYDsE1qreA4p2q1zfAftmqytefiBEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:1ZLvZbtwIrwgl1StrwjLtGPjWgBprhcpdOiHpqDpGWnXtq2SsITTWg>
    <xmx:1ZLvZffFmV7FbXtZCZOGfnra8joA5L8ZmEkzYgl0roLiQWdmpghXkw>
    <xmx:1ZLvZX3Q76G7aDmeSPTFCtqvtt8SHi1TtgprS1G-olLy5F8MMznLvQ>
    <xmx:1ZLvZQr7RHbSSscmU8xifA6db9jU5Njl2qyCrKvxhOt3eXz_DrApwg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 19:25:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 347ae4b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Mar 2024 23:20:27 +0000 (UTC)
Date: Tue, 12 Mar 2024 00:25:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 6/7] reftable/record: use scratch buffer when decoding
 records
Message-ID: <Ze-SzWD7p4hwz8nG@tanuki>
References: <cover.1709640322.git.ps@pks.im>
 <e0a9057593f761917a3e6fb9a77045400e2b9d1c.1709640322.git.ps@pks.im>
 <Ze9cLWCZoBqcfr2B@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yYcS7KNR3qXk8O92"
Content-Disposition: inline
In-Reply-To: <Ze9cLWCZoBqcfr2B@google.com>


--yYcS7KNR3qXk8O92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 12:31:57PM -0700, Josh Steadmon wrote:
> On 2024.03.05 13:11, Patrick Steinhardt wrote:
[snip]
> > diff --git a/reftable/record.c b/reftable/record.c
> > index 7c86877586..060244337f 100644
> > --- a/reftable/record.c
> > +++ b/reftable/record.c
> > @@ -374,7 +374,7 @@ static int reftable_ref_record_encode(const void *r=
ec, struct string_view s,
> > =20
> >  static int reftable_ref_record_decode(void *rec, struct strbuf key,
> >  				      uint8_t val_type, struct string_view in,
> > -				      int hash_size)
> > +				      int hash_size, struct strbuf *scratch)
> >  {
> >  	struct reftable_ref_record *r =3D rec;
> >  	struct string_view start =3D in;
> > @@ -425,13 +425,12 @@ static int reftable_ref_record_decode(void *rec, =
struct strbuf key,
> >  		break;
> > =20
> >  	case REFTABLE_REF_SYMREF: {
> > -		struct strbuf dest =3D STRBUF_INIT;
> > -		int n =3D decode_string(&dest, in);
> > +		int n =3D decode_string(scratch, in);
> >  		if (n < 0) {
> >  			return -1;
> >  		}
> >  		string_view_consume(&in, n);
> > -		r->value.symref =3D dest.buf;
> > +		r->value.symref =3D strbuf_detach(scratch, NULL);
> >  	} break;
>=20
> I had to dig into this to convince myself that we aren't leaking memory
> here, but IIUC this gets cleaned up eventually by
> reftable_ref_record_release(), right?

Yes, exactly.

Patrick

--yYcS7KNR3qXk8O92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXvkswACgkQVbJhu7ck
PpQBUg//UC1w3MY+MEqhgnWlX7VAze0pvt+K42eAMVcgnpLvfQim3C+sbWzXD04M
41qTBr3j4KJ7poAyk+iDQ49ghZicKz0LrZrxe6aSXZs+hQpx1lGI4qRcdEVDh/0o
ID2IZSqJDM4uFFHB8XrlamLiAGraEQ0r/DfgNbdxF3JyOZsKY1yORe56QO+BF+AJ
WGK1dBJ/xADF1Utsc5IMCGQDdDUEnb1iVcgDdjCE01tEN4n3roLvoQcMAU75Qjul
CO7lj35e4HCqIs5BvC4d84d/DDQ+XpOhcyWx/rbP46MiL5unKUbXO6g7q/Ar+fwt
ZdIJY5ZHsLsWZNbQew8oK2lyftGo4P4wX54Wp5FhBjvUauYbjVIYUjMZ721JDIdM
fdEaGdYN22eNvBSLh8X+lADbP/Za17FG2EvHOsmwuATKzg9+MxJKd6KOMBwaWyZ9
FfAYDqw4yzoH4jX7TI2rRpEYOWrKZDPAwDJtw1ilBr8aX9m/VTtiiaYTt0c2EPcH
WDg2iNuj8AAPadUIMXzMrv0bxpadBFsC+lD8voi0zReGF9WiF0jZVx+gxgQiw9WP
KZnHlecviXhhmI556fLmlA2DCeqcbsV95/Po/2fj0sYOtSoLizLY0Lf8h0fOGL4K
tOc6sajFswDDX04gnEvR5b4JTljfz8zr3SHcFQ3gSanQub7Eq40=
=CXHC
-----END PGP SIGNATURE-----

--yYcS7KNR3qXk8O92--
