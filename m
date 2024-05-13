Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F5F146D76
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595796; cv=none; b=maNn8Dlr+IwTtbp+D1oSYrc6kcR1KgtfaoM0lO5cOCx8FCWQgdkuwc7Mye7gPOFbCO8LAAZol4LkLJ59u9RxEgnjL9GkwTkiWkxKFVnavO/UwginbwKnPrgPVuNSWOiHdWlGl/HKJBzn8514+fkL6hAdnw0885qdO5g9rbgEd8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595796; c=relaxed/simple;
	bh=R4fB6rnmK8nEaqOCs9pdnVKnJIx6eAoIYT+5xCS2cfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbPGqD6mleXOjKRZ7NwCUjol4PJBPWBUe9fuBbM+9gjKJog3Ld3Of5POuuBJax+jkKY6gGfxGAWKNTHXmJKRyY5YCJWJExahowmJ6+keCEIn7umY/6SPPIutM2bEaNXQj1OI58rSRCXgqr4VH3AMaR7WqhcV4wft2k5IjNapQiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tjNyBr4o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hiuBV7V0; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tjNyBr4o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hiuBV7V0"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 8B3A51C00143;
	Mon, 13 May 2024 06:23:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 13 May 2024 06:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595794; x=1715682194; bh=NGeJi3MsXF
	Ih44XipEkCZywtnFykP48Rr2BrF3f0kTM=; b=tjNyBr4oaaLh5F1BKtde6XRCIm
	BmmnMgdZ0iAROIGBCqpZj7cYFveZfxFUIxqUxAC8erWqOH5S6IzwneBmcXHZBnsr
	RzmXblwY5A7qS52cex9N3mS3L0959ugUZVEWOMakPWqln0ykymWtv2iUS3Wv+dj6
	F6jdx/Vgz6qv1SBoQ2G9U4uty7Fo63eL3voPHenyFtQsozgL82aq0RcWAlobrKeZ
	x+ldXaRaguKsq1FHmqhbyjXMRfkmL8p0+eN77Lsy245z1kM+Zb7jsAl4D/Io7sr+
	QV3DsE/QlCsJtMpzNJX+Z+Pi1MC3QCji+HxjXnTuZH5zGJw6vKfoc0iZYMIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595794; x=1715682194; bh=NGeJi3MsXFIh44XipEkCZywtnFyk
	P48Rr2BrF3f0kTM=; b=hiuBV7V0LKB6Dum050pjB/VldW4ig7TMzwUV/bFe7NP7
	rBnvvzJqjb8EWzLpeY56djIkeKCCF0xLVKb3+nESi6IjDXfgDO/q2DE/aboWslBS
	jK6mnDfWsE8T3CgcL7xw7GcvrA7ymrimnff/wstvX5wDCELcs8qIZJnXu7ZiymPC
	7DErdDbOmWZ6i6EFFKarptGm1EK00B0eEqIWykbMSuSdFz7nG2PpugSkRX2pUCzb
	PFqwYgOZTLvt77Bzc10l4Bz3GkBPKOAZQOnHqS3LRTfI+NrnrGlMhldYxC4YRM7M
	H/NWULSgjTFSTHvZfh655JYdKlMRiJU/CPPCsjtgzg==
X-ME-Sender: <xms:EepBZjKdFKKRg5D69K6Z9HBXZR0RfAWlBfgHCTKXupU3H3HUz4TpfA>
    <xme:EepBZnL2DxbdbZl97ShDPP3tEyJ7efNvG-o1rWL4Xr21oJJDTTRxS2qMPFfN0uVFw
    x0ROchm8PNTs1dvfQ>
X-ME-Received: <xmr:EepBZruyrsDghE_mCmkgXoF0-4l5PiMfCk3SGkQD9hH8eABKJg8QNjRIeYuVVWxWMfdnQle3GvN3Mk6GY8kSHYiumusv7WVN2tjeG4J_aXlnQ_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:EupBZsaHPTKLZ3UKfdoMYMeDaPK1S2I84meVxpKEMJ-9b83aOa07Hw>
    <xmx:EupBZqZ3-sZgMCI2XzfTPgZ8ZQN6tbOxljAfH8yVHm4010o9sWkCBw>
    <xmx:EupBZgCyEoI6jPqH75KsluHMxKl7F9MgEa8u8M1ZyLn16JxC6d-b1Q>
    <xmx:EupBZoZbf7hMKD5yS8X5MUPZyt4pjHvJf6OVVq3Ft3CG3VNEU1I-1w>
    <xmx:EupBZhWVkqvK3Zo7CM8swR5SovDO3v70c9yTwmS9ecnLQ23nDmpQZhGa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:23:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 86d79767 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:22:54 +0000 (UTC)
Date: Mon, 13 May 2024 12:23:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 14/21] builtin/config: convert `do_not_match` to a local
 variable
Message-ID: <0dd22bf51a4e16161b3704295b8026b8e32a835b.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jMFD5VowELv/8ooi"
Content-Disposition: inline
In-Reply-To: <cover.1715595550.git.ps@pks.im>


--jMFD5VowELv/8ooi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `do_not_match` variable is used by the `format_config()` callback as
an indicator whether or not the passed regular expression is negated. It
is only ever set up by its only caller, `collect_config()` and can thus
easily be moved into the `collect_config_data` structure.

Do so to remove our reliance on global state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 3424d602f2..16d92ab176 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -128,7 +128,6 @@ static const char *value_pattern;
 static regex_t *regexp;
 static int use_key_regexp;
 static int do_all;
-static int do_not_match;
 static int fixed_value;
=20
 #define TYPE_BOOL		1
@@ -327,6 +326,7 @@ static int format_config(const struct config_display_op=
tions *opts,
 struct collect_config_data {
 	const struct config_display_options *display_opts;
 	struct strbuf_list *values;
+	int do_not_match;
 };
=20
 static int collect_config(const char *key_, const char *value_,
@@ -343,7 +343,7 @@ static int collect_config(const char *key_, const char =
*value_,
 	if (fixed_value && strcmp(value_pattern, (value_?value_:"")))
 		return 0;
 	if (regexp !=3D NULL &&
-	    (do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, 0)))
+	    (data->do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, =
0)))
 		return 0;
=20
 	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
@@ -400,7 +400,7 @@ static int get_value(const struct config_location_optio=
ns *opts,
 		value_pattern =3D regex_;
 	else if (regex_) {
 		if (regex_[0] =3D=3D '!') {
-			do_not_match =3D 1;
+			data.do_not_match =3D 1;
 			regex_++;
 		}
=20
--=20
2.45.GIT


--jMFD5VowELv/8ooi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6g0ACgkQVbJhu7ck
PpTdzw/9HKedh8NrqpAeLT4fi5bRPoDlV2Mpss9cU8mBGkp5vmKr/5TVKGxCzZhB
AYXwU95xdDXOlh0WN9nTVuNd/5UI6WfIGHI1RLH1JRJOZPSZ2paOAJod8Xto+xri
KxC7T8X+3DCvrHFqhLUkU2OWWPQNXteZi5FOqu3AK7cVT03p/9NO43pO1tsmLncP
bK5aff9ET3HpSxA0QNgi2ic8EMj3g6Kx2ppdjweJTJ4zXRI6UwjVCxJQHyDuyuh4
KvnbknkcyhrVZ2ZQk4T9Du6FtPvZcUBkmiig2RQW6XPfamRc3xiit33cuZIVInaJ
blJhsyQupK4kRPk9abGojGz8rRbB+iCOoMcscIJPyWquWiRtQp6yU2HnJF1xG8iA
bYAu+9DEHx8yzLJa3jTMiRY87UndfxLBVPf0+WSRQpnQJ4CCHXHisf2m1qCpFsb/
rYlr3OeYfLJrEEVYyLAhTzu25JzCGVtJIv995+s8Zzk5WQYkeREC5P7Gzh1kkBue
DhADNLFKG/LItkW3yBkQsPToIZweXuha04OVKWt4Ff4gw3isE/vOANz576C0wKXR
pvUtZsq5jGJvW8z3iLyWDjwuBj0Z2ELASwuta9TGm1FYmYlNQfzgx2wW8nfUBxnK
zNcGVpJdMF3jA6Pzleof2AMbwRu4VPXd6hI6yEumOJiJqk+7MuE=
=4HrB
-----END PGP SIGNATURE-----

--jMFD5VowELv/8ooi--
