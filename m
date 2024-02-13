Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BFF13AC3
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707807452; cv=none; b=jVBV4az8ym+8rOvaMBaLNQknf2cF50mNYQFGMIXAoKe2SdoBeUTOLLDkijx9WFt5UqF4pBHUvETbRfu6LBOYGqZK/8h+OpP6z6HMpgJi+p4utHLRTNr7QxyUqpAcrCrFhob5wMWOasu+zqz/JtgWW/I9kjuQjxA5bDv5kUdOVHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707807452; c=relaxed/simple;
	bh=PfA670BULdCNC/n2BosblXGqXwuxD2prqr8TwqMkHHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSfEGFw/3Z8LDFbRowtpLHcyMGvil38QFivgaBxKDjRQrRW4KiapllAl7kLfQYsO8O5cY6jdersJuGRUnRXqYibT5/jfzXA0P6oeXLVXxha34nxU/f7YLtFbFSjYmc69uAmkNFIZ8bsfBEN2WQ8Yv20IRUVS2F2WLNSndvvGYPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gXNnZwU6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KWpnUSER; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gXNnZwU6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KWpnUSER"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id B840C1C00094;
	Tue, 13 Feb 2024 01:57:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 13 Feb 2024 01:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707807446; x=1707893846; bh=PfA670BULd
	CNC/n2BosblXGqXwuxD2prqr8TwqMkHHg=; b=gXNnZwU6WuzNsXfE+/IoLdjs4M
	wwpaNFOhkWNW1gqcjvvRXbYND+ppAOt7ilCZ8vW6CtP+wcmbMZg9WuzB+cR/t+DW
	0yZ5aqo35EW50p7K5oFHlle3AC3bcLtSlABtqcJQpggLkafBYwNtCTqrcItzyYtW
	It/YSgozi8Y3hl5Ygahd8qbM/bH+EJfDvQEcoaCJy5ZDOMHdqMRefqxy5/1ttjjl
	YaQ1yF/PSv7M2yld6HeMTZrFuufobAMKx44a/cY6JCm90h2yGO2KBlzoNOLbJGQg
	wZWaJhLw8h9BmCUlh2zMlGXANPvLjuzNvAT+28yotUPsJjd3jXZf9UkdCDXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707807446; x=1707893846; bh=PfA670BULdCNC/n2BosblXGqXwux
	D2prqr8TwqMkHHg=; b=KWpnUSER0bbZGtAL/uA8fvZV964EdAlKu+K3EXMZYpF4
	0+J3mIo5msu9QygFr4GO56Hrt2kSr63OLR/atJT0A4bnsJV1A4Mte9maHhGcH5zZ
	0oS0zjPJn9HPgCWoxHuquQhrLjd8awm/9jNFJ/lgELysAcuPyzDwKsnZxWFuksBk
	PgbFEPZa/uF9E+BXySCXInzxdnpKkoAnOVUAJCfw+5KslmvZoEs8lel1ImW4lBBN
	aGoqC5AvnX2mJbjbtuS1wIw4Q9/gKSjE2JMTxnkqVb19aaG1XUMbGdQwJnPoGSfx
	tpGpv4egVZcCmm90oQxK7mKGpSLCM3rXLoARNo1giw==
X-ME-Sender: <xms:1hLLZeYH4ebj65o45R3uke9y_j-C94zWVWvcxLNec6VMQsZYwEpJNg>
    <xme:1hLLZRYd5349z-0Y5gu17P4olxFlA9T9rmoA4EFo8xYFCerV5Ky1BSthpj5UD3fxA
    nbh4u9W2yeOq5u8gQ>
X-ME-Received: <xmr:1hLLZY9-MYjWGI6e8_CReZWptUK9nzb4m-kLOG5p7AIgWlULYpq2LNNrgb6bba6OX43x32EMfck8hzPDzSvjzz67yVvLz1Bcub3eYLxr72s8vA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeggddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:1hLLZQrJfmeUVo6pjeIgoRD3g7LcsoE7mQ8XAFvNHc6jdWt5wB9zJQ>
    <xmx:1hLLZZpZFjcxYKlOwC6X3BkLfzHQ3Ngo9xvKnuhFn_aV0CXQw4W28A>
    <xmx:1hLLZeQe4y_Ae6SMfI42BL5XDBCcB1glj9QyNWqrCp8Kq3nmo2SpxQ>
    <xmx:1hLLZanYlxdO9D9FvZa-VuL1mS48YO0lX9_jtMgcLOYtLwzcezgxZ2k5b10>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 01:57:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9bdcc28e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Feb 2024 06:53:34 +0000 (UTC)
Date: Tue, 13 Feb 2024 07:57:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 7/7] reftable/reader: add comments to
 `table_iter_next()`
Message-ID: <ZcsSz3rJIsK_HFzj@tanuki>
References: <cover.1706782841.git.ps@pks.im>
 <cover.1707726654.git.ps@pks.im>
 <167f67fad841ad06535a5532088fa6c9125fb1cd.1707726654.git.ps@pks.im>
 <xmqq4jed7g87.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IuOORWpNS4y/a0a7"
Content-Disposition: inline
In-Reply-To: <xmqq4jed7g87.fsf@gitster.g>


--IuOORWpNS4y/a0a7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 09:19:20AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > While working on the optimizations in the preceding patches I stumbled
> > upon `table_iter_next()` multiple times. It is quite easy to miss the
> > fact that we don't call `table_iter_next_in_block()` twice, but that the
> > second call is in fact `table_iter_next_block()`.
> >
> > Add comments to explain what exactly is going on here to make things
> > more obvious. While at it, touch up the code to conform to our code
> > style better.
> >
> > Note that one of the refactorings merges two conditional blocks into
> > one. Before, we had the following code:
> >
> > ```
> > err =3D table_iter_next_block(&next, ti
>=20
> ");"???

Oh, right, seems to be a copy-paste error. I see you already fixed it in
ps/reftable-iteration-perf and merged the branch to next. Thanks!

Patrick

--IuOORWpNS4y/a0a7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXLEs4ACgkQVbJhu7ck
PpTnqA//b+ii/fMkuN+219e2n8Xy8zh4DCdBqhLFwhwTjLdl28lpueiRWMiVeyoE
23zTYmwxy8BbB2HI1+qDfkRXjQu3zCNYxhbOehIYczuFJ1zQiQEawkfJfwjWTzSc
bJSs5KtwEw18PbNGGnvQXZLQAeKgeR/eFHp2kYgTD9rJYUdKLMD6hb0Ce/zoPeel
PPr54j/yc+ZFiAw5vTFKtCob40dsJKUkoTDvaGusKBZzClT0bu5TZAAUzYmFrvz7
rl7dLi5GmfYzHRw+by1t1lzUJETc6o1u7el+g5RIgSIZl/fzP4pkKW7DFL7VWvjG
VDEGgecFYo71WMt2dQW4eguIOwCrHRPZXegTDO0iywYWB5OCNNU3OoGURBbMSBIG
ryHVv8n7Hqht7AlvYeGU/yj11rh6sweKtGFgJ4nskbZca4UmLW9SYPdqyPo9rENI
d4BKZOdMl/lKzeLCjjW416WKwv4JqG8LOvYNkhaJ4hSPr69c7PxDOe0w4Q5LvaWl
oOD4hS5+6L55gP7+oBW+bfwXsMQ+x50d/cc8aHg5cAbjuYqldF1Za4bxl8hlQ6hf
BWTZC4m/MUMsbqAewneuZloHgcpFmmh+T2UC2DKV1gM71ufawxCiUZVd2jQal68+
+81o8UL24bB4H13tu7QhjASfD00bxy2QWTEBBFn1hx8NbXsX89w=
=iikL
-----END PGP SIGNATURE-----

--IuOORWpNS4y/a0a7--
