Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5554C125AC
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722391; cv=none; b=kHHaNXsbZ4YwflGBkDqCMlUg2gTmHEnoWpKx7P7gIo2RYbH8BkFlUHAdq32VDSB1TKZpa5rrAoFTBBSacB4XXAp0TKO4G6tPXo8Kce1ff9QdzkbBytHVfvXr8i2taPiUfe9oWrkKSk1yZi7Kay/MCMBm4MJWnPAWwluhbD2i3ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722391; c=relaxed/simple;
	bh=TOOTk/ranHuQDX2XAu6kmMEFkBqtwVPw94RRbhNnNqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJZxUtu39md3XPEzq3mQ/RpGNnOtOOjAa9wLbQknT8xCJVWdGS2h1A+1ScfBFcAchzOB9JERLuxnhId10s1hEM8yEp3DqyL9cLbsyJX4d8cUJsNPKLNpI+4CFAUdjA7Lvnn7ZeR6nosTShbplndcHKUI/3tbtq5yKu5069WXJCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eEeJ7A2f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hpblhX2m; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eEeJ7A2f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hpblhX2m"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 2F1875C0061;
	Mon, 12 Feb 2024 02:19:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 12 Feb 2024 02:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707722388; x=1707808788; bh=wxbF6wMMI8
	NiKFdbZJEUkKlaGhB05AFuG7Bq4piXv7Y=; b=eEeJ7A2fHjXGATHRnlxYC9bDdd
	j0oYImxvsMqvoT/ZiSTr7EVD4C04os3Wj3+lW+6zBDDcrgp/IsxdE83WeuDB4QsP
	69HtDtaCX/03t9O+/5S4Hg3CR9oibH6GDkDfNBi37GEYNTvQqzAg4UHuYMm7YXJp
	fUhDCD1sF6qcR+JcxJxg9taOe5iHLWS20vlatTHRDAGhbDP0Hf8Z2dHsFv5g7zvA
	zNGvqnaQ++kLFe6KN9ysRUOw4fv8ljb+ObJOsbcxer1NS78U9HIzEw0M1lEtrOBY
	Dm9pLh6KQCJjynTEivnD9L4qEdbSV/PK4JI51/Vqn2gO3RMZ7dd8B6YEdrvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707722388; x=1707808788; bh=wxbF6wMMI8NiKFdbZJEUkKlaGhB0
	5AFuG7Bq4piXv7Y=; b=hpblhX2me5c3ArQcYoAXBR9AFChFfVx3imCllMwKwvLl
	Bf0bqahqnB9uYSlHVEMsnu0d7Hzgg2zv0s+vuxY7uFkixLKrXFR0RBY9d+yolhgp
	BvXpYgrp1LfBBkIJNkja0p9UKuF3G9VZA6w2IH9h+QaPHTlWuZ13f/uRann0m3ok
	zuC2qrIQoZ3KvpPthyy4S3HZnxzWAHGiPS+zxIFBhoTpnL3V3xmFlR+oA70Ue7Zd
	MNCiJTYTuydzGWLhf+BV+hvpM86HL+1mUjOQJk7mfJo4l7nQSW0WPNC7L5miba/G
	H4gkiJ3KYIQUqGxWU7cO36GlR8fS8JCpMWp39GA1FQ==
X-ME-Sender: <xms:k8bJZXVF7F9tfvZxvtmdUyka4jKKJtp89cqKwjDzY5RSlfL6ONPUbA>
    <xme:k8bJZfnM0uOzRkyL_KjRUPhJtYeMqT37mLM675kQ4_I6BvBn6PKV75X6Uh8YI5ql5
    fXe0VpvmnkRiqgm8A>
X-ME-Received: <xmr:k8bJZTZU1T8_6kAp2B6OqDwPZMtaL4JbJUbwB07C68-UoAxMtZdutWob_jbCyVznzB561Hha6SortnGCR6QJUd8Hk5w4Ds1hU7xziWzEokSB-jc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:k8bJZSXLKJJl_wZoyg-FTt4FxT-GmwpiB2QDGc-4XQSI5BoMysAwew>
    <xmx:k8bJZRmBQXqvWM-AaI4aaPMhn3UbFDGcFu6UMnaddIefz262SrOv_Q>
    <xmx:k8bJZfcJ0xnAv39f-pvPQuUFB8_O_Yo-mn77DFj6dorYnpKVs9Da8g>
    <xmx:lMbJZWw4CF43PoCXOTsC-kj69MD6v57HGmdDsQuzxEB1IeUT0Drb2Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 02:19:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id af9ad606 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Feb 2024 07:16:00 +0000 (UTC)
Date: Mon, 12 Feb 2024 08:19:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: Race condition in git-bundle(1) create when ref is updated while
 running
Message-ID: <ZcnGkFI5IiylfGiH@tanuki>
References: <87eddlpx5k.fsf@iotcl.com>
 <xmqq5xyxh6zp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z+HoaQDxJkGrp80U"
Content-Disposition: inline
In-Reply-To: <xmqq5xyxh6zp.fsf@gitster.g>


--Z+HoaQDxJkGrp80U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 09:39:38AM -0800, Junio C Hamano wrote:
> Toon Claes <toon@iotcl.com> writes:
>=20
> > I discovered a bug in git-bundle(1) create. There is a race condition
> > happening when a ref gets updated while the bundle creation process is
> > running.
>=20
> "--all" that tells "traverse from the tip of all the refs" to any
> rev-list family of commands (like log and bundle) eventually boils
> down to opendir("refs/...") followed by readdir(), and if somebody
> creates or deletes files while you are reading in such a loop,
> readdir() may appear to skip an entry, which is understandable.
> Even "git for-each-ref" would race with a ref update (which involves
> removing a file and then creating another file at the same path), I
> would think.  IOW, I do not think this is limited to "git bundle".

Yeah, it's unfortunately a general issue with the "files" backend and
nothing that can easily be solved there. The only answer I can provide
in this context is that the "reftable" backend will fix it because it
enables consistent reads -- sorry for this shameless plug.

Patrick

--Z+HoaQDxJkGrp80U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXJxo8ACgkQVbJhu7ck
PpRupw/+JRgYDF8s4Sy6CxRLaG17Z3X2WvMuNf685LERIBLZHtG80RiyyikVCgDo
PWyq5QxKpkS+BrjfFOgnO1oinEaB7AxnfXSFuFAefrLn001vAxUa1NdvGaZUfWtp
WP2qE8QAjrd11aagbk4IQdWMfGJO73k2DH/DcQ8dxKCjvQZbuNJxs2Ct4OjAH5+E
s+IRtEQHmGxQLXHtDOkNzIuLnAau4+iNKgvOIQSlmSvTJfEEpxcyN4o2EFo18pp4
k0N9DFN6ogFkCiKSRrHCtPBkJv8A8WOI+lS5WtiLt3a9U/uSW+plP+3VEFXzbOEj
Yi29NKz9ObWVQ9UafjBRvXnaknAeSAT5fyAPZcjoNPpP+0kImbEDKLxayNZTXtto
69vid0Fq3ehwldy9JuOkIHJ58T02j8F1okoihFwV+cSLe25g8j5j5QYil+Rt3Vnq
SSKXhalsyLHSxJgtYsiiQ8/Itjc81JkPsx7PzQsVavFRD2H71EIe09zxQV4lQhSA
c5e9xFmVzDYX6nOxO3SM/De9frdVU+5IeliX1b0WydVfUit1re83Xu+U0M0heKRQ
LDc7iepMi2GC01h1g4A0Fubu5fNJRsZDI1mrb91FZlXP5hQ4TiPh28CRAjQmLziM
lvtMk/6BZ7VZIhPp/5EN1ZWoWqFEXpDiTaaFVyV1F6Gm5tEkvW0=
=DPgj
-----END PGP SIGNATURE-----

--Z+HoaQDxJkGrp80U--
