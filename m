Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6F8176AD4
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107086; cv=none; b=HPxIg+QiSOJGxR2rbwDIMqqoJ0E+TK9UJCZ7AsrcMAKvi/gQZLT/x2y6NypCsAElso8P0/+ONdsyie7Mu4SjXVCdCgeSB84ezB/W1oSOaxhdrhfPH5oZnpTICtOr9Rt0hNM7yj8ffJSBXWLx+kASFvATE7QqtHPz/kzAsakjunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107086; c=relaxed/simple;
	bh=1+JXHHSWsHC8Bpgl0Yicw/as4Vfnp58LuGEWMzyoGG0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U66tjui3SUtZjJg7K8uZX5et7A4AyEYyBkGQEGfwG5zdvMGMpaqA01TyeDzSLZlnwpnsW77GjsIc2nC6a6GQ+bO78KSpqHetX1LzLGv1bCLY7J5nSxcB5PrPHXw/z+AOaFHOwxseceAN5liR+1Sm6Qn5TGZhec1ePaJ6JXTwFEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eTBcAJAS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dCR9Z6Sw; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eTBcAJAS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dCR9Z6Sw"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 6DECC1C000EC
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:58:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 11 Jun 2024 07:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718107084; x=1718193484; bh=mcyp5NQZBj
	HlfyvUpUI5PYjmw8lASHKqrKm2sB9ghF0=; b=eTBcAJASUoLdQfZRdgjl5vL7TG
	otLueEqNcRCOAFxpJ0gL6J/zaskt1KJZtN80ZTF3Omv+zE3DdDgNRxLAGd/O7APP
	P9ukKB70K12UWszJA1YM81/It/ptuIeDp/iuMu1SznUDp3PUv7RzLO5M0pfIZyxr
	z+ChPOtMwHIHFADkgEDaZ8ohuJiTXiddonjw+wJB/n/zsaq5VEbOLu498R8PJmY7
	jXxSfKDd2HRbd17mW3gM8QHuUCT6voviFfDbONSn4h23vF/x+j7NCi+Sku2oCEN+
	VkPy9PfDC5R9y0etSDDG99Hu9iLj4ix6SRyu7XjHNr8GDVdbZnNLRsDN3n1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718107084; x=1718193484; bh=mcyp5NQZBjHlfyvUpUI5PYjmw8lA
	SHKqrKm2sB9ghF0=; b=dCR9Z6Sw8Rxs0dEP880hvWSxHdHQzVS2CxtaRg0l9Rb4
	qVhF3kkP59fKrkQUh+NEd48y+hAMu6qJXje9xUR422zG3WK7WHtVMcACm+Ixd74v
	17BjJq47c2AAzBADH0d+47wXnvZGGpFRZvyLVkBlXG4xjZa/K8cIX4qkk0UPuedm
	oCDXnHUc7oDJnDZOHwDOrNfFdHbM+fPMcnxZRjLcD36R+r34xx4TYN5EXT4sLHNc
	3wv+gtmsE7XvrR6MCnvQjP+Ir9aWYQ6DftXEO9i/rX9X0JUfkuegRS3YKiEAvFch
	1V8JNK67nTDqLEbtcGddS4zTJTZHd/alY3OCqndEvg==
X-ME-Sender: <xms:yztoZm-x1zLPff0AE8uXes9LcA4wH46l4Fv-oZErAAZlQW3Zo9wygA>
    <xme:yztoZmtiiouGGwIuTSz7TSAJaweIWrc8iTRiIljfaKu3Kgt14wVMEGBDtbuWLSzk9
    UX7sW5MTw9KUHQxiQ>
X-ME-Received: <xmr:yztoZsBhXDo6due08x49qxYzuLkWX41Z-HIlJQOhXhsWYvM9Ww0h6D7EnYzUbGInVVSqHTZZ06t34nojmud4UFNnvnFMexs707Cb_viHC2tbDE7UI1jQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:yztoZueKC7s_VYs3AhfIDRojyhzCwIcoeCmL5mS56U0MqnKH9DSg8A>
    <xmx:yztoZrNy7Z34_PtUVcpw1wnYtWM_s8oPPQj57E2DBoGb360GWOl2LA>
    <xmx:yztoZolEEQvRWpPnvyQ3f4-XizPbLBRXaRbImaAIx2vrWFeY85QEnQ>
    <xmx:yztoZtvV1qg-EHz5Dewb2JmLf2S_EVPHW3Fcm1qEMMHbukPrJM1f1w>
    <xmx:zDtoZh1sfO88kJWSmNOL2JdA5x0KYgWGlA9ZpsumnWie2qFX6xVraJxv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 11 Jun 2024 07:58:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3dca1ae9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 11 Jun 2024 11:57:54 +0000 (UTC)
Date: Tue, 11 Jun 2024 13:58:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/21] hash: make `is_null_oid()` independent of
 `the_repository`
Message-ID: <3b6ce3b26c5d2c736cec54074a0aca4183db6b10.1718106285.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9DT+2xhjC8e59pxg"
Content-Disposition: inline
In-Reply-To: <cover.1718106284.git.ps@pks.im>


--9DT+2xhjC8e59pxg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function `is_null_oid()` uses `oideq(oid, null_oid())` to check
whether a given object ID is the all-zero object ID. `null_oid()`
implicitly relies on `the_repository` though to return the correct null
object ID.

Get rid of this dependency by always comparing the complete hash array
for being all-zeroes. This is possible due to the refactoring of object
IDs so that their hash arrays are always fully initialized.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 hash-ll.h | 6 ++++++
 hash.h    | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hash-ll.h b/hash-ll.h
index b04fe12aef..faf6c292d2 100644
--- a/hash-ll.h
+++ b/hash-ll.h
@@ -341,6 +341,12 @@ static inline unsigned int oidhash(const struct object=
_id *oid)
 	return hash;
 }
=20
+static inline int is_null_oid(const struct object_id *oid)
+{
+	static const unsigned char null_hash[GIT_MAX_RAWSZ];
+	return !memcmp(oid->hash, null_hash, GIT_MAX_RAWSZ);
+}
+
 const char *empty_tree_oid_hex(void);
 const char *empty_blob_oid_hex(void);
=20
diff --git a/hash.h b/hash.h
index ddc2e5ca47..84f2296cfb 100644
--- a/hash.h
+++ b/hash.h
@@ -6,11 +6,6 @@
=20
 #define the_hash_algo the_repository->hash_algo
=20
-static inline int is_null_oid(const struct object_id *oid)
-{
-	return oideq(oid, null_oid());
-}
-
 static inline int is_empty_blob_oid(const struct object_id *oid)
 {
 	return oideq(oid, the_hash_algo->empty_blob);
--=20
2.45.2.436.gcd77e87115.dirty


--9DT+2xhjC8e59pxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoO8gACgkQVbJhu7ck
PpRiWQ/+Nxv8JSJdr/IjC3bRZyMuBe+PNr/tpmZn7dSiwavHajD1JfzEEgLdIjPv
TS2ynayH3gN5zFxO7QD64xIJ1vVyDuEBr4Y9mmc4aG0UtOqhdGtJN5mz8Os4Ih2S
dFFW6CXna/eTyp5wIYVZaNF1aMiJY0fVvmFypPouDmaffktJkPRdROX+hpYvIbx6
0Wio8JsxitYb1Q/3jrpKtmhumYkDjwJ/+y8+PMAdMSVDpwwodYqueBwX/h+zkyrq
eVKr6M1P/EYg4cxNugyhC7A8IECBmjTJlrK0/MB6KVqkO9S8zBVaGy55d38bPV7n
p/TNP2n6v815YMSdQOwiqbBolUf94QA/dM9wwfBvOmJtCk24q+M5Aqg6U0sKrxWX
MUGj5ZWbdIvvyCBsrfevuYJFhAcYmyyp36F+XELAx5gxV/9yYOcdQyHJvp/vnjAo
nnmbi+PvI/SF8CgR3wLlCjFhs/OQOkrP9Q4+1eDCplj1vpWioxhS+CxI+zhTbgHF
He+ZcgtnxZtj0pXSLgn+I3k9gcJxJc84ri9oAIkL6WrgsJEfMBJJEwAZV3dC3c5p
D3jrAzufyPA8R4uzdf5CjnbsT5r2kSFHE6PINO5JA3M106BJdhsbRR7feNPiaqxH
nyXAzkxrqOAprCxE+1ysTThUNDcy4y/ruU58nWqJYV5FI3hx8zE=
=7rP9
-----END PGP SIGNATURE-----

--9DT+2xhjC8e59pxg--
