Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1794E146582
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504682; cv=none; b=jrqzQre6+Be6efmuHljOit5/gaZHz5+zOs+FNAGAyut0btCTvPW/+ta49lqfkq5hkMc23WS9OKQACXLBmW1dAnOA3K0tmtukmcgNntMV/lvlLu4wpt2M2V7mKBnG2OEZiJ/USYi7E1V+EjSo008SFuudklAVGZj9kvTGWayS18I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504682; c=relaxed/simple;
	bh=z1SIwVwkkGLBHi2tan0c81mRFl6OjcBhwM8dvI6HiGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWeIhDAWObapedjtBiSuTRwhsJu54dSwmrWeGzT6WztnRF6xWqQ2QVvPSYe/2I/zbleHoHBQLebDBEjq1s2uP8/lwL+6O3HD/Yyeyh/zxJJ5rVnaXjqF0LAnxgfM2SfcorPvRbvss5yDyFziCTs8dlORFICtyfKlypKyCrNmNzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ALZ6XkhL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iB8JaQk+; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ALZ6XkhL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iB8JaQk+"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 636061380153;
	Tue,  4 Jun 2024 08:38:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 04 Jun 2024 08:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504680; x=1717591080; bh=MHJdbu/MT/
	8jYz39qRHwABgjY+LPSTrOY8iAO+v4L7A=; b=ALZ6XkhLzdC5cc5MR2fO65e08r
	nJx9V7Ljgjp86eSkbwVLjStC97kx5ScFiyN9u5H7/dpj4yFrWYnBZXHXWphxSz3I
	bxQ8VpbQAd6qcELrciO9FkSu7Vr2agUUeycdQW07I+Lj2Z6F4e8jtYBcyerp2a1G
	Qe2u5jyLdYbqmcjV2wmNz8RexQEIxUdxXtckEi2GaJcyMi/TryJi5uJVg2l0H3Hp
	CKOFa7i5KYn8BFK0iMqwUN9ejsIxJyhSEWEuPtJdx2kZVhuIH3pOb2zHpzuxYR1g
	s6t7Hn3xiwARUEwWBg5O5lkhxroxdXF52u+gr+/fQMSzQnLsHCIgS0VgN9qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504680; x=1717591080; bh=MHJdbu/MT/8jYz39qRHwABgjY+LP
	STrOY8iAO+v4L7A=; b=iB8JaQk+vvz/5KaWEibM4uagdO+Jmp8QrtjfvoO13CmF
	ccgPEId0wbs0dpCPrRRKnzOdNHj+7S6tr4pRKU4zObYQZZPuZ/VrYzdcBpDaHDiV
	X0/sclVkkE8R/PxssX+4nLU4xTnYDjwFrbKZMFI6gufJ0XxVTlY13Fc5i7djzIKO
	yK8ygvzGg3Ke9sA0oQr9UQwvV8xnlDdkQTJjpN9TFxCToa8Jfyu07seQEepWTP3F
	7dvpc6rIlMsRiOwJsSxH6YHdj4YQMVjUcKkYjSBtHfMBNLr+YMe9M68OLCxIXiAj
	OuAeP6bve9fUx7DlWjRSk5D8YnWoVAlXltOUzInHFg==
X-ME-Sender: <xms:qApfZrwy3YjKFQv-j9XZBXSOEFyLJRbZy_YqCxuPQ7OWstX5f1psjA>
    <xme:qApfZjSeCReu71Box-Yx7imc9GcuIcLyeDpD33LutQ74WRtZww8MKxgL2axVoVnXL
    QKZsRQxlFFjWYc_fQ>
X-ME-Received: <xmr:qApfZlVsi1qR-OqPe3empKW8gqOqJ4ZXKPPZMOdYvKh2Hsdxo-vxmNAW1njMIeOACEOBjLQsYZ6c9m9evJPJuaJncVdOM4JzsItAANFwWUvn4ebw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:qApfZljq8KmFmoU4pf49-SXA8ncsmGp2PlLmkc9lE3jlXQwNlKM9tg>
    <xmx:qApfZtCbgmM322mDcEHBHqikaZ6tDBJSd-tXmivQIdStxCtdcMbMyg>
    <xmx:qApfZuLTPzuCUmsC_kgxDLqlDu0T95u3UibZAFi2oTI0RtG-qNOSbw>
    <xmx:qApfZsDUf1UuDVstKmaLAnktl3pEAlq2UrQFgBf_L0Ai0-jPVIGbsA>
    <xmx:qApfZo87T78V5kd3u-1ZwmadFM6I-7h8tmXiIV85sBPumiFoZdAKwFoi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:37:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c07f4bf0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:37:32 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:37:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 14/27] pretty: add casts for decoration option pointers
Message-ID: <e057ead2b49cec1f5d7d5df1bf172bc45d139478.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cdUC0vRsy54PNAgW"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--cdUC0vRsy54PNAgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `struct decoration_options` have a prefix and suffix field which are
both non-constant, but we assign a constant pointer to them. This is
safe to do because we pass them to `format_decorations()`, which never
modifies these pointers, and then immediately discard the structure. Add
explicit casts to avoid compilation warnings with `-Wwrite-strings`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pretty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index ec05db5655..1df9d635fb 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1584,8 +1584,8 @@ static size_t format_commit_one(struct strbuf *sb, /*=
 in UTF-8 */
 	case 'D':
 		{
 			const struct decoration_options opts =3D {
-				.prefix =3D "",
-				.suffix =3D ""
+				.prefix =3D (char *) "",
+				.suffix =3D (char *) "",
 			};
=20
 			format_decorations(sb, commit, c->auto_color, &opts);
--=20
2.45.1.410.g58bac47f8e.dirty


--cdUC0vRsy54PNAgW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCqQACgkQVbJhu7ck
PpTRGw//TnzEAQf3Mkj/1gMgD7nAQNvRhaPET3ATr/TvgY7WQ3u3F8FdOU/FZFr0
WHRrkQ0C+/UvP4rASLwSc6NeKWv1r+GtSOEHq5geovgEvDQhUZO5IxV3rnnEsozu
bS+UcDFfDH5LjdgRihGzJuLTOqi4GjuGQL7WB0F20Oy7FKMcQA5b+ZLOoKIRzhg7
ehMqlsZaGX3rhix/bH+qrBgbxuz6BSqOclappL2RRRFRyB5Lf+guSuY7jYmJQvYp
V1vi/6fLieVddRRaCHozQhdolZJPIofkuf1Ct8lw4/i4quO0NcHS7Vdw1zPK6vK9
f2SpPxYF2+WPnA0rb3M2tefe8NkHZfRTwiIbkb3Kuxfex3d1RSe3nHP4gFUObkAB
c5g0WHFYAudGni7XRAdDC6C1+2G4gKOnqkClw/1Buv5HHcIrz7ikgqUxtjESZd97
NKPabmthzcPIV+7CyvJxerD+0n45zziKE7cUpPmQybvzOAynRcdf6Kqr07g4e71w
eyYoyICOwpHlikHZmcol1NR/BrOQfLwPdQlorYKjBhNuo+zhTZbhH1hl0MVbXHBI
SyvTIFcMF1SXCxPbFilGstmjjPsUWZA2sDD4otrUa2dLkLkihpXRVRo8EQiGfgRA
Ca4iPsMKaUROsn9m9sy2fUJehEJRodT5/KmanSUoIGE7TKcd0Xk=
=rrGf
-----END PGP SIGNATURE-----

--cdUC0vRsy54PNAgW--
