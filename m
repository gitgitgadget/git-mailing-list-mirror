Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4548014F61
	for <git@vger.kernel.org>; Fri, 17 May 2024 07:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715929767; cv=none; b=fCRc+tpjo6F9qO3NRaZ48cDryTy9mh5bgF5luwVTI3c7DYRtk0TRb5s8IT+7QW3L4KikfBqg3ErNpLEcEeeJ8HmR7JpEPccz5DifnFLHcAk0pGhPoXynrN2vLYKNdAzZnNb3/PmjrgcEWdUXatY1DqoJbOoSsiIs34G6/uRYdX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715929767; c=relaxed/simple;
	bh=8zdK5cKSRJl37TRgEbmiEb8KZ9R7skNOk0LYAsvHIiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6u0JGObAC9u7DSYSdTTzkdfRPu3pjG4ujO3gJHpZXs/IKdsmn8Lfe9CLJ3JqAX1aSrrx3L2bzIfJH7h4PwtR4J90z14cf4d4gxOcbpZYSwHj7UIYChGSf8zfN4QJU642k309oz8HjoByp6TLdwF//yGf6rXGTDi1sAhIfFV7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HqXnVKV3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kxm5Qd4H; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HqXnVKV3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kxm5Qd4H"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 84C48180018A;
	Fri, 17 May 2024 03:09:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 17 May 2024 03:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715929765; x=1716016165; bh=enxSXjbUMk
	cv7kWjHliQtlo2zjTr9OzBO48Ci6eNYUo=; b=HqXnVKV3z3WGhQEyn9pOVGhpzm
	a9WgKPND2V633oYPKt4WX86pec2TEHKf5KDGg03Ymi4KrGRmMvBYux3fDyUmNyrZ
	N2fKbU5O9s7qK70wK95Kb3XOQX1oR9vUUAT/ktgRBRsjGoeX5R1yE27tAl5s16fk
	ap8LzGZyzxw4lES7Lh7k4D5sn5KwfpH1T/tqGIZkqJfXjUEblNhT6EaT1aHscy5l
	HpsM4j8nPZzRNj22wmdpT+/CzQmuRT43xifhyO200fWHkHYZnQZR3oNpiMF/J2Pu
	KHHpelQo80wi6M3IPRtQdGq4MnVpHZ2YD4tb5NhfbcPf3Nq+El6+1I/NrKqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715929765; x=1716016165; bh=enxSXjbUMkcv7kWjHliQtlo2zjTr
	9OzBO48Ci6eNYUo=; b=Kxm5Qd4HBg4r9fkacnHpCBho9iXMUo2DcR0JPkXZ7MWf
	uRbP5n80lq6wnqHMypWfb0tQVrJuF5MuzuP2T6gn1VeNYsD2J51/rgzC1j4fP7rM
	0ZB8x0BtQXZ5F5mN0JyQ4t2kJSLBR//AMtWsOh+Ue8qID7/3fZQQcv9sPj5zbUoy
	zrFKurwOthcpUYQ4MQ9wCHfcyNwwS0Kf7WQbIUP+jSUsJ+hFWgOA9dK2UxDKA0Qx
	kSGGN+APeIHvYCfmJY+483zB2OFpWSFGB90sYmRuOwcsqiwvuhTLTxmuWYGDT/Or
	DtO7y1zLqEL+OGs3sfYPqGLHx9b+i7smc6jJX5d6oA==
X-ME-Sender: <xms:pAJHZo_hCuLepIP15rkcoDiv94nKjTUXJWUV58L8V8So3L15Xi_Btg>
    <xme:pAJHZgugEj9hThEaeSfUh72sAhlCRjJJAJBmDWNRCkhj0Ewkyn4Gwu4iehc-Tkux1
    7Atbq5GMaKaI8SaUw>
X-ME-Received: <xmr:pAJHZuBePKJYfn0W-tCSWUZpSDp3gbWFAum33v9RcHpkuUor1MCV26ujF0TaCFHsE83jUTOurGrFkEJhtWLzBs7iLvnFF5Ls_r_9NcaTAra3Kj2h7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:pQJHZocRVUyHIhGILkir6zMIOe964UrwtklZTspCTZ2kWIbvtV8YAg>
    <xmx:pQJHZtOEr2QWIaDmuHVdCcq8fJYbIvervQ_jH7GgoNasCejklmbYwg>
    <xmx:pQJHZim8e332Hz2ZAO3BHHeikZe3-PNhTK42ns62MIGFMs7aluOWlg>
    <xmx:pQJHZvuEJQ91kbU973bFisibCb8HoIOqVcKEXzrRvfIkjWtTG70A6Q>
    <xmx:pQJHZuodZpU9GxJLVH1nqOp8Co84BcEE27diOstZPcNhZvLEptpi6buW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 03:09:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e2b74165 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 07:08:57 +0000 (UTC)
Date: Fri, 17 May 2024 09:09:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 03/16] refs: implement releasing ref storages
Message-ID: <ZkcCoY8_S2nSXSyU@tanuki>
References: <cover.1715836916.git.ps@pks.im>
 <282fbe35a7c9db715a8a805f93f9b465d42885a5.1715836916.git.ps@pks.im>
 <CAOLa=ZT3VqhrHXt9x-4DN7norTb3RuscBx+VHipn=QxJvwwThQ@mail.gmail.com>
 <xmqqjzjtr602.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kyy+Uez+FuFaOVYC"
Content-Disposition: inline
In-Reply-To: <xmqqjzjtr602.fsf@gitster.g>


--kyy+Uez+FuFaOVYC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 11:01:01AM -0700, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>=20
> >> +static void debug_release(struct ref_store *refs)
> >> +{
> >> +	struct debug_ref_store *drefs =3D (struct debug_ref_store *)refs;
> >
> > We should probably add a trace here, using `trace_printf_key()`
>=20
> A totally ignorant question.  Should we be adding more traces with
> trace_* API instead of trace2_* API?  If the latter aims to cover
> superset of use cases the former did, I was hoping that we can
> eventually deprecate the former, hence this question.  Of course We
> could add a compatiblity layer that emulates trace_* API with a thin
> wrapper around trace2_* API, but if we do not add new callers, it
> may still be feasible to directly migrate the callers to use trace2_
> API without having to invent such compatibility wrappers.

I cannot really answer this question as I ain't got much of a clue
around the tracing APIs. But in this case I think we should indeed add
this via `trace_printf_key()` so that we remain consistent with all the
other wrappers in the debug store. I'd argue that either all functions
here should use trace or trace2, but not a mixture.

Patrick

--kyy+Uez+FuFaOVYC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHAqAACgkQVbJhu7ck
PpRMTQ//aId98TwVKEY8PzLWrdDFXglp2fcY1wJmPYbWwYLz5+UhcCqksBHWgXXP
bK2SEGYliBybgMNKqaIctdMgyCmO6r7EJQom/hrc6CWDSDBZU2/UOagdeeK+Q8Zp
EF8K8j5xvYJV/MUwSEUvNfW+uIujBzq58yuB7N2CwcNH2rdEa6o5ea34oLaHxO9q
7IVKsvIsoryRPQYks32BrB61e/Kif3dt4M8yzyeFljmW+r5ZNIEPwyWiyAfltfv1
mB8i9YhSFROYIp1kpvaV+gAzY3UgwsaYJ8maNAcJmiV7xTFcoACfd9otW5TzZd0d
ODmT4fkXE9Iruo1a4pZTkbQsI3OQ/R0NWUSIwS0jrQil3Q0Rfn5stPdKyuyztR2o
6p+z4lQ3LFkNmq+gpjTRe3w1+/I6PSIwVuo9hdUm2+jSPkguHFpk1rMhwfYV0SL3
eg1r2ILYu9hsSAfW134h+3cfDQDi++ZNBDGLy3g5hrtqjnRY8r5dynufTXovLQon
F6JMAIRXqkd4ywp6oIsWxeG6ccBOKjSgMuQ53+6w8IB2jiWywlASMKktkT3hLDvz
A71H7a70UM2M1LE6/PlX3gO13FLifsITPm4TYTXpj+RT/kcCa1HU6eGP0ykdSCkX
VaKXMgHm+rakyGCn8zykM6IQzFtpvMv0Oz7Cli39tCDzBKVPaZY=
=1LGs
-----END PGP SIGNATURE-----

--kyy+Uez+FuFaOVYC--
