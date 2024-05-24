Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035C038FA3
	for <git@vger.kernel.org>; Fri, 24 May 2024 07:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536043; cv=none; b=gqaQgs/0cobrMICYZVGGx6tSLx79b/gjzLUwX3iXaHvYNhLLXUV33MGsd/SDtcBZUwVNQcbYoDISrlnAKFJp3hSY6wmBn7sdlYd8DDaf0jjkueZQ/2uKvLlKAMC1ypJnq0gBlbIM2GdOHBKJzkURkpVFQGgQasgR4G46FuXZzUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536043; c=relaxed/simple;
	bh=dN10N+7GIHmUeywCb6LSRNrwS+X2Ko2NiOuroPGtQsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDQXpvVGUWVFVix886sgbPIZL3lYSk5TD+xW3BtQgOOaPADDqxeDcTjY14t407ZOUCwNKhoC6gNCQnbLyhbbS2GrpiIkP4FhHM5AK2kfrtgLOlvxABjnak7S3b2SYv6Pih5qmDo8yPilNT2cMcyNT8GtSVSCS7HlEaVgg/8U3yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZWnUm8Se; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yosy+jHM; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZWnUm8Se";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yosy+jHM"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 00FDE13800CA;
	Fri, 24 May 2024 03:34:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 May 2024 03:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716536040; x=1716622440; bh=YClxbGPRCr
	+NnL+hswU8xdssUrfSroLcBUOjqnRHxDs=; b=ZWnUm8SemxOFkIyX0l56tXdiXx
	oJqdRmJPb6Pd0M8yzc/yvYSXg/VKR8VF9tdI1YPaPnyLtzeKW271wA+NZmBKxqAS
	UQ1dycxPcBd63mqjzincBn3HZBcEp6qc3n2R4/iaS6i+SFFggL+UcgdUBc6cZQSH
	IvxcBDenV0x2E9uttbqpnkhz22bDuRPjtdorzf0oSUY4GVNUI++Njdu5RjLrdcym
	FkGOjqGRmzJ8oOJbS8rTpIGQawcHCPHOQ29/JAbGlOzkL8TOBoS81RWj3juoRp8v
	27unJLIG9Y71j1DUBORiUQ37aQY+w66RW7zaaw6X4XWRABNAwPdQ+3oAh0Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716536040; x=1716622440; bh=YClxbGPRCr+NnL+hswU8xdssUrfS
	roLcBUOjqnRHxDs=; b=Yosy+jHMxHuVcwqejbRspQTWjhQbZ2qBQV52azmgfzCg
	ru4nbwD9bIErEwhx9XtNK2ZO02W7DZ8b5gTeWzR97CKs9ybSDiCCvlmXaW1Hs+Xm
	VSpGhjwc5+VoTRg5Qkgvu4U5qFV7LBh6RW+zs1PwXB8t2U++rRrDebzvOSF+eOYg
	zzGuj9hVPcdHXBs+x00yoez+ZtvxuUm0jfezRQeD6uCu4ZR6MyMSn8plB2HVSR30
	fLKfwPU14MYw1o4GaDgIQYNs/oID0B2Y2+4Ex2pd0SNVGjxEqTCq8MlstiOJ5bgr
	v8nC1oINwF0yD1jVG4z5sKx5S0R+uE1UtYuJ9IdEwA==
X-ME-Sender: <xms:6EJQZgb2eDYv_Qusrt5Oc2kYEUoDYaav4TWBejXGDnEzu-yrfXSRGA>
    <xme:6EJQZrZACCgnu774TP7v6W2GW9zvVjTsScjB9LQ_d2i3P91hteWE5Lrf3HmO7Kzii
    pVfX_n4kZoe-4SxcQ>
X-ME-Received: <xmr:6EJQZq9pz-i5QFjz_Vtp3mRo1XMdqS3psDFffHK7YpRW4TtWGyecTbMtJywSdQfL_wtySqDZwEfnSERcCIwXgP35bGcK2gN4z2XcUOGWU7NlLnE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeijedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:6EJQZqqleu1nKZqX462hWzEtKR9aWrSSkHOjy732rzRDY4zYX2UJpw>
    <xmx:6EJQZroJC68LpmsrC0AO9Cw5umdHOJ8Wu0MhqqPg6kuSLiQyFsMpag>
    <xmx:6EJQZoTczjbNyC9jv-_0c_oildg0uOFpfxPWxh3aiL-SBgaqhHbU3g>
    <xmx:6EJQZroNgGTV22qdlmYLLQ9K9wGPicrCOov3363sGpMc0YNgcGvwng>
    <xmx:6EJQZi3UIxZMu4C-K-LutvPDG3DP0dZU2W_rAem5vUMAhtk79HBth_13>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 03:34:00 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 321584dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 07:33:55 +0000 (UTC)
Date: Fri, 24 May 2024 09:33:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/9] refs: ref storage format migrations
Message-ID: <ZlBC5O4CHqrx1di7@tanuki>
References: <cover.1716451672.git.ps@pks.im>
 <xmqqwmnkv7ay.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ooGHqNe95IAkrSUa"
Content-Disposition: inline
In-Reply-To: <xmqqwmnkv7ay.fsf@gitster.g>


--ooGHqNe95IAkrSUa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 09:09:41AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >   - It is not safe with concurrent writers. This is the limitation that
> > ...
> >     none at all, as it may cause users to be less mindful. That's why I
> >     decided to just have no solution at all and document the limitation
> >     accordingly.
>=20
> Documenting the limitation is a good place to start.  For normal
> users, would it be sufficient to
>=20
>  (1) tell your colleagues that this repository is currently closed
>      and do not push into it;
>=20
>  (2) configure "git gc --auto" to never kick in;
>=20
>  (3) delist the repository from "git maintenance" schedule.
>=20
> before they try this feature out?

I think (2) wouldn't even be needed. Auto-GC only kicks in when there is
a write in the repository, and if both (1) and (3) are true then there
are none. But other than that yes, (1) and (3) should be sufficient.

Patrick

--ooGHqNe95IAkrSUa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQQuMACgkQVbJhu7ck
PpQUERAAksHBL6fjhBOlmYYhUAxhPAlPv1TVbEq0AIoahg/QZ+Xvj424WV6BZ0y3
7cs2FFBcoj/4K/MbvRODzHDg7LwYG0seCmGYGJc5rEx8T7PmYMZTSAMTPq9eOgRw
idGqpxLnIbKWRmeCVoOvTlKs+Rf/04FEZoZGi/by0rcOp8sibMUOgGoFw3OA9J3C
6WPTTtWGfRQbcR0M24y1lvjx0Q3RbGLRY1n2WKsprebNm8cplKn2mRITkBEHWSJu
sMeDL0RwjAo1dOk2LV06TdcL4kNmWmfsshf4JlxsteT44bmeponKumNCxZeavQG+
dNVMCW/sZZ+Z3rPqYLgI+VrdeFiBcdRJ85Qhkr74T1HphOxk3mqHw2iHtTd1n3m2
90JzflF+maqYo7+MEuv1bDpOnKpN/syfYNqjL76bBer/zoIVaGN2OSxwB5d4Edec
WJF2fa6T0J9nowXir0coA1gMIV4LAlRiUFHb28OXtnM+Yp0iPQaL8N4Mg43TmVmH
qEjQvZgl2n3XYQy7Vlikd5l+7oH0ZyRt4Rsl8FOv+QKhk19FcCE1VSi6TenuZ36e
gJ0EfcAIlUXQqca6ch4PWL3pqx0SaIe30XbmqD7DtY44qM10Q8YCiT4N9kQoZ2Dh
DI1YUDswdt/j2EtsLrfN9HGVkX3IoT5ivD4pDNwCKlvIJA4zb3U=
=qrYu
-----END PGP SIGNATURE-----

--ooGHqNe95IAkrSUa--
