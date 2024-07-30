Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7268A190477
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 07:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324294; cv=none; b=XhX11iCcOtD/eljfwlTv+PMb59wDCApmcZNdMcUgdgl18DYpU0lihrcyOGWZsNa6RlzU9V7iQAqIKd+MhCaYvGzOSOqdtCLaKmd5Ywn0SwyTgpvhQfQSyP2no/J34yEjZAYwCZSYTBM16kntWmlApwO2p5pUgdiDVpF757WgRjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324294; c=relaxed/simple;
	bh=0wOwKY6pmmovLtDwmesUlW12sJ3IuWTbD4IEYQOZL0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqiuEBmCMyImsw2tKMuKbB7/lfK8mh29yFJ44es6UTfzqJR60Bg+SzvLF1lAqFBGKJlvmXRL9+MftHXs/CFzvt8tcIOGf19ksGgAyJu5nljoE0Afb0+AjPS45P8qt3vCSCL8tHfhdyNTiLGZiWBsyNVgMVq4IKUAHKSChlEThc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c16n7EkU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ITzyMi5X; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c16n7EkU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ITzyMi5X"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 72F6C1140383;
	Tue, 30 Jul 2024 03:24:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 Jul 2024 03:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722324291; x=1722410691; bh=NI0+O5P8BW
	8w7bPWZJOGpuerfzpW/wQ1/fFJ2mtdWF8=; b=c16n7EkUEU2nTUOJu92QCdX2/z
	FTtrcsQYyCuAB+OG1nwze3eWgUPuvBxd0+HzYxsUDH9AUC0q6VQLCXWq5MxVvZ8J
	/swxeRYwbESztCwAjycAXAdSYFXxa2b6IS3a1lFbtKIw7QodRy5HGIFfSAqmJ96z
	Nz4yVXyQzoigq55hR4Ydkuw7gpnJHk08QPRJXZwD9gWZaJFy5+CHGA4hTNHP74BD
	uo3FfNwgD6rBKaAihSmw+iBRjxJMN2uXCuq6bN4eTCmm6ZQrz6KMd6Vaxk04tKJ5
	KfSvxm4E5+EKx5zcxA2P+zYlCLZmpqJiB05JDJXU204AFmvpKBDH4seKl3YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722324291; x=1722410691; bh=NI0+O5P8BW8w7bPWZJOGpuerfzpW
	/wQ1/fFJ2mtdWF8=; b=ITzyMi5XNwqeHfYKaJmARS+5tuJbCl07c2DUUGe3jCWx
	fN8WjLeW/2x8rPI4BTpKq23qZOVb+9LaaSkUzhhARPC+jEPnelHYmCPljXuYcy1q
	66b7ZdYGeV89fvFxY1QfWBNFn9XSgc/ywVRoyOIC3UFtCSr2YZLVBKT0QXpRa7+4
	mD3GJJsTxZiK1BslPSW62FqFpAaZKlkuBaOTDQHbGLUjoGkqy6dllVm4KbZW6skv
	s7GOonHyza/KfNCY8RsMyzB7rL0rVz06+Q3rnbBKKiZo6UNvJVpbOgoxctqD7w5n
	07t4un87Twor4J3wuOGBoxtaD2oS9oo40VCXv5hQhg==
X-ME-Sender: <xms:Q5WoZg9gtsPuzuyKh8fntvi2N_87-7lhvQUvPzfOek0zYF3b2TNHpg>
    <xme:Q5WoZot8vgat0TNr9GPdx3P76R--xhzL3tX993xgEfXhOICYrLX5PHvpJNeeiBth-
    DRfgKzY9Ae1352Ygg>
X-ME-Received: <xmr:Q5WoZmBBhFQPQJ3p6qCIdltLzTPEawLmnCMRY-uFPlKeW4DqgFz2dI1rN8HX1Tfh7c0gjyJvFc8OoDBHNwtUMqUWFP0852fQmC58opFOJZnOToQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:Q5WoZgeCb5g5xuQ6qTyYl_esiMKQpnynglxkbjL3xJZG-8YWcAD3ZA>
    <xmx:Q5WoZlNrBEOUPq1b8iJZZCKpBH0xhGzzt-VtHu1eh4UDy4KrzCIEHA>
    <xmx:Q5WoZqnguOznThHOPEuKpkxcLggQKshfsfXU9W2ynoeYT9TEW6OmcA>
    <xmx:Q5WoZnsP-QCi8McV64aWz83ZX2cc54f-YlPXvUFYSSjbn0M9s2UXeQ>
    <xmx:Q5WoZqrycMdXaLqEGcbdfjFYkFgV7cfvoghY72jqUefBbCFt2vNm5YCx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 03:24:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 313b4be0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 07:23:23 +0000 (UTC)
Date: Tue, 30 Jul 2024 09:24:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 4/5] Documentation: document idiomatic function names
Message-ID: <d4ce00303f230e6ebc7099e07bb451811e6eabab.1722323818.git.ps@pks.im>
References: <cover.1721818488.git.ps@pks.im>
 <cover.1722323818.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u4HXaTEN/ZbkxA+Z"
Content-Disposition: inline
In-Reply-To: <cover.1722323818.git.ps@pks.im>


--u4HXaTEN/ZbkxA+Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We semi-regularly have discussions around whether a function shall be
named `S_release()`, `S_clear()` or `S_free()`. Indeed, it may not be
obvious which of these is preferable as we never really defined what
each of these variants means exactly.

Carve out a space where we can add idiomatic names for common functions
in our coding guidelines and define each of those functions. Like this,
we can get to a shared understanding of their respective semantics and
can easily point towards our style guide in future discussions such that
our codebase becomes more consistent over time.

Note that the intent is not to rename all functions which violate these
semantics right away. Rather, the intent is to slowly converge towards a
common style over time.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/CodingGuidelines | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index a6a1ede204..b63a8f9a44 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -560,6 +560,23 @@ For C programs:
=20
 	void reset_strbuf(struct strbuf *buf);
=20
+ - There are several common idiomatic names for functions performing
+   specific tasks on a structure `S`:
+
+    - `S_init()` initializes a structure without allocating the
+      structure itself.
+
+    - `S_release()` releases a structure's contents without freeing the
+      structure.
+
+    - `S_clear()` is equivalent to `S_release()` followed by `S_init()`
+      such that the structure is directly usable after clearing it. When
+      `S_clear()` is provided, `S_init()` shall not allocate resources
+      that need to be released again.
+
+    - `S_free()` releases a structure's contents and frees the
+      structure.
+
 For Perl programs:
=20
  - Most of the C guidelines above apply.
--=20
2.46.0.dirty


--u4HXaTEN/ZbkxA+Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaolT8ACgkQVbJhu7ck
PpQMPhAAqEagEz/ia5VjwFINz9+ws/yF4X8P4H9syKRvumwJsk8Np6N2ioQo6nYR
e1j6TKemlZFrOn5CbiezJk+OK6yVICZhFMeo1j1dzxA1uCL57M8qWHn7mJ24nCBn
+dNkvcvllN5RZxX/VDHT7qMxsS0sDLg6bfx1mDXS/hsYteHgeXJvv8Na5u93JilN
o12p0fC45Z5elnqfLesymVjlO1nUR/oXyuh4txlPvo4gxMCJywKNI0Tcq3EgGBcM
Yn6QjFPpmqAv/o/Goqt8aaBTlDR8anZAY9OY3AU+Y+js4aOkO+qOTFaeH4AuM4yK
ChlTPwiwd1BgHZd8+w34XeUcZeL3JJOPskxN0mths3VDm6RqMjm6D8ubOAxULr5i
ZTEFp8qPRub9mNvqCA/z1WHHg6ilsPnln+gKnHOLrKEl0XNK7WTt9mtBMHojKJHv
tQQzt2glZEOqIVwrwIlzMQyt8vVPQBXXMapRAM25H4+vQMF39hhLGD68JUJ99ESv
tnIOtCfxXCLyU2YdGchCoCO65WEYAH/ce+0XxV052UNMnh7qREiyDs08KlsC/8xv
yefHawZM+hZG2BRy+Lux0x22DM9dVybgmGipH7iY8tZtMdwBL4rkwJG3o0/qBazR
NYDjxijkAPhV8Oh6O0S0jirXRCJrAtEo4eqoN0hzkkYSbeJOCx8=
=oJdc
-----END PGP SIGNATURE-----

--u4HXaTEN/ZbkxA+Z--
