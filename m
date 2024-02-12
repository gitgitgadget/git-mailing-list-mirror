Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDD5171BF
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726782; cv=none; b=hQl7KiiUnLB3XHaqNLejRKLnMcIfBWwqi3mrBxQJvGcpczgMQgcqbaLgvAquY8EuwQQpmv7U1RQIPXT1D2y2iPJrZIbcXLgKSnC+Aprq8jww6HufNC8iYiioTcMoCLnygl2zdVLb7buEoQwHyRZEapxH84+V2qnzysiamO0mH5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726782; c=relaxed/simple;
	bh=2EgDi3phXmNUlLsMxAsU37jyBnHUTs9ZsrwDQNBTdA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwt4KsIImvoL7XovYqoA+jF3RzJ24wKxeYZE8PQvsjuk3gtQ/gGFaaS78gLxvgnTnJcpveRoSWvejvgZ8A8U6vYadYgL5NnjYVo53hYNA7eXdlFW0QBm52dZgCvIZFkdACNpr9X78IlXeomIemQUNyTMPHw2RGG6lSipRDv12SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=asAoQR0t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IjDqDvJz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="asAoQR0t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IjDqDvJz"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9853E1140091;
	Mon, 12 Feb 2024 03:32:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 12 Feb 2024 03:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707726779; x=1707813179; bh=P0O5cnO4RQ
	q7yqB8Y9NpgICI1dXNHsUFquFVZRWwRvA=; b=asAoQR0tftCphib2tzQgaaI0wV
	JzY5A2O4c59kZ7TwGX+JJD2hmlfE2FoqvOD/wJuFuY4lydp3DN0puOPEynIXgkQy
	m1HifiT9ogUtWxvRT3TScmUKQrn+V5AB6j3hzt/zCkE+bmflTm1eEtj7clmcsMAx
	d7kSrZVUtioL8WYJStFQLe1btyay0WVg/J/QQVxG7k0zDJah/AJx6IxqnDyUwY5x
	S4uZfCP4BKDr31GmV81bGuRmXlmT3bxndgGgR4sA9f1lfQKEwsvxU31VqlhNSLOr
	H2+vBMhAHo8PKaPYB4JUV446+0WSDrXQJ5F3PHBP1q2Xcr51ZSdg9FiogmEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707726779; x=1707813179; bh=P0O5cnO4RQq7yqB8Y9NpgICI1dXN
	HsUFquFVZRWwRvA=; b=IjDqDvJz1MbDxGMtPYCUZ0TdROD1/hgdGe3Neh5BIdlR
	qqy3imXNkWFPWg9TCL1aCpXPLOqIkTTd+sQYSuG/59OQ6bkM3R88tMr4QXc6e3aV
	JepLBx1SQiRA4uP5cFrQPlKGVA2jtJ1QrfA3du8Xin0WYP4IhV+7t08bEoG/Aq53
	umMcSrlSvzVsTRUlkACt7l2Y1xLNuJSG/ykdUjbnHBDDHC692OMudr9lAS8BYsyF
	dFWoDdde/EYw6M2pKuHUnVUH6wWe4j+DTOFDW8qXjwNk4jrLWt1pFN+i2ssPf3b5
	2sKWTarpKxw8EWVYYXvx1mOB7XXdQp9eb9+fQhGWlw==
X-ME-Sender: <xms:u9fJZRqZgQ94F3hGjPN7rvdLagcpBss5-IFPj1176Ca8e7QCm_k8uQ>
    <xme:u9fJZTqoqQG8gfQ-FA89ndfsYGHGrr-vBm9yl7G59XSSesekzj7mqKcYQAt77yV6u
    L7RRmaIB1vUXrADAg>
X-ME-Received: <xmr:u9fJZeMUOXtqG5_KNfibQBd3ReFR335q27gvBKPtNKYTr1ZyXpSs-UIhze8lyKX_WQg3UwA0gaXo2-nZz-zai1jjb59oTqJv7U9GuiiSeSzglMY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:u9fJZc5COSC8rx4xq9gREaVAhSEagLHzgj3L63gEoMZ81zB-gRMQqw>
    <xmx:u9fJZQ5KkqCqQ3_1u9yTklQsBLqL3hyQtXF7pK6gZZknqWX_uE1SnA>
    <xmx:u9fJZUi4oLbxb9kHjRc3D7RjvwaWlCFbgCLgvFPq1KAPzisIPllJ_g>
    <xmx:u9fJZenePJ0b32QQNu8qeKFL5teOp5nf8p7Djj23b7Rq04pnNu7b1g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 03:32:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f02954d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Feb 2024 08:29:13 +0000 (UTC)
Date: Mon, 12 Feb 2024 09:32:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, John Cai <johncai86@gmail.com>
Subject: [PATCH v2 7/7] reftable/reader: add comments to `table_iter_next()`
Message-ID: <167f67fad841ad06535a5532088fa6c9125fb1cd.1707726654.git.ps@pks.im>
References: <cover.1706782841.git.ps@pks.im>
 <cover.1707726654.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wLwY7SWV7cnHy30h"
Content-Disposition: inline
In-Reply-To: <cover.1707726654.git.ps@pks.im>


--wLwY7SWV7cnHy30h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While working on the optimizations in the preceding patches I stumbled
upon `table_iter_next()` multiple times. It is quite easy to miss the
fact that we don't call `table_iter_next_in_block()` twice, but that the
second call is in fact `table_iter_next_block()`.

Add comments to explain what exactly is going on here to make things
more obvious. While at it, touch up the code to conform to our code
style better.

Note that one of the refactorings merges two conditional blocks into
one. Before, we had the following code:

```
err =3D table_iter_next_block(&next, ti
if (err !=3D 0) {
	ti->is_finished =3D 1;
}
table_iter_block_done(ti);
if (err !=3D 0) {
	return err;
}
```

As `table_iter_block_done()` does not care about `is_finished`, the
conditional blocks can be merged into one block:

```
err =3D table_iter_next_block(&next, ti
table_iter_block_done(ti);
if (err !=3D 0) {
	ti->is_finished =3D 1;
	return err;
}
```

This is both easier to reason about and more performant because we have
one branch less.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index 64dc366fb1..add7d57f0b 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -357,24 +357,32 @@ static int table_iter_next(struct table_iter *ti, str=
uct reftable_record *rec)
=20
 	while (1) {
 		struct table_iter next =3D TABLE_ITER_INIT;
-		int err =3D 0;
-		if (ti->is_finished) {
+		int err;
+
+		if (ti->is_finished)
 			return 1;
-		}
=20
+		/*
+		 * Check whether the current block still has more records. If
+		 * so, return it. If the iterator returns positive then the
+		 * current block has been exhausted.
+		 */
 		err =3D table_iter_next_in_block(ti, rec);
-		if (err <=3D 0) {
+		if (err <=3D 0)
 			return err;
-		}
=20
+		/*
+		 * Otherwise, we need to continue to the next block in the
+		 * table and retry. If there are no more blocks then the
+		 * iterator is drained.
+		 */
 		err =3D table_iter_next_block(&next, ti);
-		if (err !=3D 0) {
-			ti->is_finished =3D 1;
-		}
 		table_iter_block_done(ti);
-		if (err !=3D 0) {
+		if (err) {
+			ti->is_finished =3D 1;
 			return err;
 		}
+
 		table_iter_copy_from(ti, &next);
 		block_iter_close(&next.bi);
 	}
--=20
2.43.GIT


--wLwY7SWV7cnHy30h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXJ17gACgkQVbJhu7ck
PpSlsBAAjvn2mWTqKZORi8i6wyvs/lyNnJu7i2iurWllHCH85hv920pnG2wS+DWv
B/lIF+IQbBMdxlQ1JkUnmIbB3iXLbdf//rb/miXi8QV+v8u+DiipjORi2/4tgsk1
atKpyTNIS6XdJPNlFdSrgA9H26AjnTPUtPsQTiTqIKITFcm6wR36FTWW7Sd5dats
Rk/NvcSCuXgYzLmBVIqvtEtxalBmiNWt0uc+r7+TRbYaG3f+5Gi728Lm4+eS6YjY
bbBcU7rg7d1hQYs4UQ5LZqM12BXN1PSa8Kgx3RfnhyQhl2KYXVqElMiDm08PNCny
cGUbfMz2je4nAlEGHaJNwZYTE5Wt50FP5k5fvGb7EH3LStyXmw4jkdYXY9UdrNp9
fuKO9WdH4387v5BI7XC+sYrTDqDFPVGa03+BreA3wc6uWemNaKJG0kOSrfl3dOAN
Zs+d9cS3o2/oC4ffTwGBbGL0Gw9FkhLA8yzL0gMUUpdFA21rvAiIi7ZMYASdqvRZ
xpB4GM6B09fOxkez0e7so0seCGfMuW12Z5zbCoajqLVQW+XLRMKbTSezVOX3/jt8
Ad9mFjX5BnP7ihcEHOLkLQqcnw9ed1OEgVqzvGzZfm0347RDeziBlGaAodMZhq6z
rwvMWghMmEFoOBNpItPsZ2V0oR+siwW7AjOYpFjqwby4VdmysM4=
=RuPR
-----END PGP SIGNATURE-----

--wLwY7SWV7cnHy30h--
