Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A75A168AFF
	for <git@vger.kernel.org>; Fri, 10 May 2024 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336040; cv=none; b=Cn6LvNSdbkA+tJEKuJC0W3GUrT1EWCZ0oH66CQg2jqihJWUp3OLxtEy0CA7rfEBE7VI0eFY1Rh9ZeGZxMe0Y9xBdEq52OOFONSWYei+ys82fRBGjHYZ/y+Hw1kqNuzLDiOumxIczsK5WGeoP36H3Q/5p1T5PZUO9F6aAuwGkdLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336040; c=relaxed/simple;
	bh=9cT9++BBnViU1W0ART4/fheWuk2nitB+3hRclU/KnHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gabupkwHfchK7h335NF5rB39Yh2/Wu+i8M2aQx/I2K3Wxwjm4o8XuBbUCHq3fOi3nCTo74XU/SCzssW4x009nzfTrznmMC7uIIAN9klG1Rn0dfH2UsHCqz3fDr7pTpo6kzGZ77qv6tjuWY/DiyPXMSnaIG514axE6PsLlJXGhQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZLH/yfhl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QbnSkEit; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZLH/yfhl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QbnSkEit"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6D5331800114;
	Fri, 10 May 2024 06:13:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 10 May 2024 06:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715336038; x=1715422438; bh=h0PCifIv37
	nawZv6u2v8mhJcmjXS9IKB8Prr2jI55hU=; b=ZLH/yfhlCDSvzo7S4WEWcZx6tc
	+GLp1JxF65EmVPr+oNJ4g2FzIE0nyMIZNpqTym3Htr2bKd1HuVhVNHBfo1R9hXIx
	CQTC8o+KPqFbES/SW2l7uo7aMmQ0MnLyobK9Z4RVGWLyM3A18Ik1J4XSD7RgZAfV
	PO/aZyxyMY7ft84IxtFm654H1+J1oMLlTLAzXoQT+ySwqbdbg4+F9la9KOHjWA1d
	FzqUDtvHqa0PoqH6wS8DF3ZmYm5HqgPXPGnKXsDAwuymiwqaZpN/Inu7Bb5bkOvG
	64b2ozaE0ljpvVXDt7aOL9simyKuDuwAVMxTEaWFV/1QwiOJtZt9v6dwEwgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715336038; x=1715422438; bh=h0PCifIv37nawZv6u2v8mhJcmjXS
	9IKB8Prr2jI55hU=; b=QbnSkEitjmPN1NTlzdqeYBbXjw75OLWdpeaor3NXHNKv
	Yri9jHL8PRFzCx5cHqhdhOZL4txdDRNPExOAWeZnozz8acJYoOc7WGGrb6DjYJM4
	x3oLXaMXKw8wH0rRtUvV3jaqCOuTf166OZYDPreaQ269tQT92fCppOx3QL6vd+gn
	ttL06B/IsObXiYGiQ2FblXcLBfWVxjNHEdYKXS7g6io3NJzBK/Vl87a7sBSwKkhe
	vKVu0jBXY8/Dx7Z2imRLhxqo0sAuvJ7rQfqQYHQUW7i404kEiB8gAljo0Vvg/yqB
	iLB9yW2/OFT4Vq7x47cIZ6UQMPnJG58+ISo5c8aidA==
X-ME-Sender: <xms:ZfM9ZhBgjEJw6dH5rO6pYm4a9O-0CziDlMgydCggTjQiMF5JKgPGLQ>
    <xme:ZfM9ZvhiySr6xSuMOghPyuTx8Rz6Muw7Z5yEuCJ9Yktg5x9ONWn-piMI-BaEM-mEn
    8SL4PWkc4bCUbl56A>
X-ME-Received: <xmr:ZfM9ZslLqmrQy4Ex772YmKxpHVxEVrOqe5RUatZdLKGWOcrTOUv6PEoHryp7t99TUk9-wSszMKIgl92_kwKMRfruKvZ--MeSZDyRhx0I6s344YW5NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ZfM9ZrxGyNpA-HFyEiPHrVlBmcl-jB2vFMrl-iRMNpymAmHoTnFHFw>
    <xmx:ZfM9ZmTKZpCxfBbIVa0DVu3CheMLFUarraP5p9zZ0FkfE0ZPtZepuQ>
    <xmx:ZfM9ZuagsKILWu4doQKb-e0-d3kNcZiP15b0tYPv5yobmdgYuBK43Q>
    <xmx:ZfM9ZnS3aDCm82vyAs9N1dug6bIrrZKIHGIL7_n1QsRBiYACUEklQQ>
    <xmx:ZvM9ZhdAM44tG4jRfV0mXRmF6CV0oQCFoSfZsQJRRiJXS8cU09UNftYT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 06:13:57 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0108a9b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 10:13:44 +0000 (UTC)
Date: Fri, 10 May 2024 12:13:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 11/11] refs/reftable: allow configuring geometric factor
Message-ID: <Zj3zYvr-o3hpnMGU@tanuki>
References: <cover.1714630191.git.ps@pks.im>
 <861f2e72d987d17b00d68cdaf400d743e2f8c118.1714630191.git.ps@pks.im>
 <CAOLa=ZSLx7fAo0kT5OR6wyjyTczDLOpcS82xGd195uWVs7JRFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DYbG7Xc0ij/gLHoc"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSLx7fAo0kT5OR6wyjyTczDLOpcS82xGd195uWVs7JRFQ@mail.gmail.com>


--DYbG7Xc0ij/gLHoc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 02:58:58AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Allow configuring the geometric factor used by the auto-compaction
> > algorithm whenever a new table is appended to the stack of tables.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  Documentation/config/reftable.txt | 10 ++++++++++
> >  refs/reftable-backend.c           |  5 +++++
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/Documentation/config/reftable.txt b/Documentation/config/r=
eftable.txt
> > index 6e4466f3c5..1c381dda04 100644
> > --- a/Documentation/config/reftable.txt
> > +++ b/Documentation/config/reftable.txt
> > @@ -37,3 +37,13 @@ reftable.indexObjects::
> >  	are a reverse mapping of object ID to the references pointing to them.
> >  +
> >  The default value is `true`.
> > +
> > +reftable.geometricFactor::
> > +	Whenever the reftable backend appends a new table to the table it
>=20
> This doesn't read right, did you mean 's/to the table/,' perhaps?

This should rather be "to the stack,". Good catch.

Patrick

--DYbG7Xc0ij/gLHoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY982IACgkQVbJhu7ck
PpSE/A//f83q7AizYaW+T3oLJa992s3LRVKuHwEesjypIvbfM7sKR5xF3jvOBKPv
b/nMC4DRGoKurfzB2IbMjeQh2hQ6mLaO5RwWS3/GF6+phQl/kMj4PAN8gijTEGlX
PKnZ5xZiOpHFn/oD2VisjyRX0ihobBWES5BiZUKqQcFMd/0bKgmSGp9L4ctsUdN4
Y+diYI5JNtccVPSLVp68oC2dpoZJejMbqAg5GzrK+qTTVkpQcnqvHpsawJTWjYKt
gIwMThah66DyyZm6rkdValHcBHXxabubz5ZxsNMFjm1Yj1YdtYN2nB32ApNZRbeW
I/wWCeOcHl2HUMIYM7kr3FL2hKJhGKVilUnhxMu5vW1hvOZ+D67dg3qHVR08944B
sYaHstN6tyN+7Q+qyefmDMpm8caQaxZWSVwZ3a/P5CJibO0CFs85dunnH8LLY88h
EXcTxXDjkdjVGJtZaFeqax/RbwA/60Sh3I4/8lLbK8cftI2VW293GG2uD1NQDhOX
UzAGpisX1gqaUbx9illEwqskLatFBQQvI9yguo98fUw7VuM3jwjq8DoFp7wmT8iU
P5iJSlthn7GnAmROJ/aaw2xv4HST5aKaYKn6PG0pMQ+qpJNw9FZ3MnZKoc2EWZDc
F51dLmVaXvWGVSswl76YpQGxnJaxiBVJLGuHy9Pj2DXuCd4bSLc=
=pIrw
-----END PGP SIGNATURE-----

--DYbG7Xc0ij/gLHoc--
