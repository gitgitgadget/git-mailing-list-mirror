Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70597A15D
	for <git@vger.kernel.org>; Wed,  8 May 2024 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166231; cv=none; b=Rupym5ZD0/l97BeU2fw1x2iUJEG5zgz6upbZupuuPL4Mps9tyr29kis8iTiN/4y4Y0uaSEt2vjpGOsztL4l0t/AxKErnw7ASl17zH7fMyGcvvmST8S+MBlqVNFniY/xmaX/SNQsdCkNoVF9TL5FgP+4S/knY1IUEoW6Da0oFT1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166231; c=relaxed/simple;
	bh=wAncPLGt3t4OOdRAIlz+DITqp8Sar0AO59jbtqwGq5k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+8B7I9dXzixQzygL/CTNkdxvbmcGbvFuixF2x6MCvRUgfYCJQh6r6vflnTVQdA8taQm/mJyPWQwE4cj3qk6MU6v7TURUKdUEan6FtZFWkjzOLuhRzGPXEhuSyM2SAf7Gki9WtLqjxoMh6/mEhig74EsmwROx9ZEZRJ6Qt4vkbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ti84UTIH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TA72747t; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ti84UTIH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TA72747t"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id C31EB1380FDD
	for <git@vger.kernel.org>; Wed,  8 May 2024 07:03:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 08 May 2024 07:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715166228; x=1715252628; bh=FAtcAZs2Vr
	kqjmodc9Yl/RYAGdYG+Otb0P45Zpi803M=; b=ti84UTIHJcnC3RpP3erdnzwN8A
	cAdTxINXz4LOUEh8rwEPnY3uzcV2K4t+i1+zKoJpOYPA3fap3KvbBW0G5zXPIfLy
	8iSf+zn30IX4BunnWV7cor08UUEdUec/S/jKycAwzwA8Pr08SVuiJar9m7VbSXPt
	9C+qbNuFaWzEpeBeIoebVbgNYR4wXVp4HcoLfZQE/Ep3o63BV7EHP7fHtgoLcDOJ
	PW2MghlVH1M7cN8ELqDhZa5QJ/r/70zzAHiZlbVE5YoOlVOycKOrtJ365iNf5wtn
	LitT+p/cxe6GQbrJ/krC+fFP6Urmdof3lmF5qyGP/zxayNEAwJ272kAjXw1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715166228; x=1715252628; bh=FAtcAZs2Vrkqjmodc9Yl/RYAGdYG
	+Otb0P45Zpi803M=; b=TA72747tj4KMOEq1mioL45KmZn/NAAKK2ZFG4LMm2c9/
	yAVn/8fpZdQRjk48zxuEJ2gVmGcD5ov/c+ROIomTqDhu+Gcin3PaAg1SOy88Xlg0
	mkUAU1LnMf3RRqX6p45rXY/ucTEtNM9FfCz3cuS7D2A5QZGexxQWzBSkqcTTWCyG
	YxWGhTbBPNyRdyrvT42oyE6pHI3Yl7UpaMQRYvhS3NevyCCKtNbOfCY0Cj+RHuiY
	S6S/RImCc2LBdHMBHpKAerkUPt6LJ6CKWsJMpgvZe75EZHUdqMcYcy6Y3eQFk1XB
	XRHL3M2ZLU4hBFkmBZuj6KasA3OYJanPqUKocHUypQ==
X-ME-Sender: <xms:FFw7Zr8kgksW85XQqMRtzPyvUfFwWM5xmICFnXOxFqSQkL43h6SLLQ>
    <xme:FFw7Zntbd91gBZrU6v2MwAWTAjxkz5ydJNR4y6InB6Qu7oF4-_AXe0qyup-uGcofz
    CoLMbsawaGjoVceIA>
X-ME-Received: <xmr:FFw7ZpDNxn5VXg6nqGVNmi6ImXNhIKdiGzjS5qJ_TLfEJgokUW1TeAjcpC_2Fc3yE1tjMVW82aAZXUWNqB9hxtw1VP2LaA5H-8Nzrj5jaEl07sn9xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:FFw7ZndS-Dy5esgeE57BjX6kqBguYNAxlXYB4XAx1k463pUbvsKG3g>
    <xmx:FFw7ZgPLyYNVkpXzyjffmQgURjFGFMPH4zCGUeaI-LuP_OaN4nMISg>
    <xmx:FFw7Zpm--qoijCQxCni19_6znWGDC_5WMUWTn7loKwfJVAf0EPS0Vg>
    <xmx:FFw7ZqsuqumovEGgndaMXbUzRucaVUIwuB4eMdEjGjnQVvM7uqLIjQ>
    <xmx:FFw7Zq2VxAaqvIwcVOe5aDgL55XG-MFG9LiIPDPePdvrAtyPwAGzlpWI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 8 May 2024 07:03:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a0f50e60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 8 May 2024 11:03:30 +0000 (UTC)
Date: Wed, 8 May 2024 13:03:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 01/13] reftable/block: use `size_t` to track restart point
 index
Message-ID: <ca86a8b58dd074287dd2dd352610ffe46e1605b9.1715166175.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ytCJ56WEd7H4FYe0"
Content-Disposition: inline
In-Reply-To: <cover.1715166175.git.ps@pks.im>


--ytCJ56WEd7H4FYe0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function `block_reader_restart_offset()` gets the offset of the
`i`th restart point. `i` is a signed integer though, which is certainly
not the correct type to track indices like this. Furthermore, both
callers end up passing a `size_t`.

Refactor the code to use a `size_t` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 5942cb4053..00030eee06 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -326,9 +326,9 @@ int block_reader_first_key(const struct block_reader *b=
r, struct strbuf *key)
 	return 0;
 }
=20
-static uint32_t block_reader_restart_offset(const struct block_reader *br,=
 int i)
+static uint32_t block_reader_restart_offset(const struct block_reader *br,=
 size_t idx)
 {
-	return get_be24(br->restart_bytes + 3 * i);
+	return get_be24(br->restart_bytes + 3 * idx);
 }
=20
 void block_iter_seek_start(struct block_iter *it, const struct block_reade=
r *br)
--=20
2.45.0


--ytCJ56WEd7H4FYe0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY7XAkACgkQVbJhu7ck
PpSDthAAgUcDSUPJCkBpX9z8suVMUCN7Q2R8S98TTwlq3rDno7KxvMTFeq/AyU6o
8sJlM+KYIJxfm2dBLB+eKUniy9OLEUPsw8/oGUzgdYV6iJBrl7FM8n0FyD2xxynK
+ugYx08VqQWuh98jWJbUvcTntioFnLykGgbayZ+4rmVvXCCG7umluIXtEz/hzjjx
iMTNzEs7KlCEXrJ+/g6fJwkEOYeHVg6cGi36jbJWMCqbKBhZXNeKAyhYYgf3e0eJ
a60Ygwy3Xsf1C2QAysYjyKzTlxo6zLT7t+xTp2WPBLmAbdkDp3kbAVwwihp13mrH
pY3YSsjKmMHLOLQ7m8VkdT3Mbs9GYhfLfP00Lv8wBXFB1Z6Wkj1y6cPxlHZgdKZJ
JG+bsfly1/M97U/5SxANLnwRuwyCUFMjSpP1uzt426Tt/k36fNLZXAK8F2MAN3XO
OCVCN9Ev90aYn4sGQnyEsizdzi5TowGdczheVvk6ryyV/vJAMJS5etgHI5oCdPGI
lqFR0xYA28A+oJnpF9ZzpBqBoxgzEOQr/QOqFRQABNLEgWEmeoxsXb38m7y3b4I2
+K4mU7m/3PQ2YuPtIRpIWm+jsEbAUv/1/PmMkQHDUDSezSsFNTlFe06fDynVWp/z
Vc76gSoV2Miy+gnm1XteJsovpG+Pb2uz6paha5P8e19j7137b7Q=
=gINu
-----END PGP SIGNATURE-----

--ytCJ56WEd7H4FYe0--
