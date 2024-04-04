Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCBD4C637
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 05:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209715; cv=none; b=rvVMFIFapFEf4dTuvcbT6b84ZSR+BKZI8KWgrmcC+C+2BY26kDZIxuPRpATFzRiDXM2gabN5rhwQMG/BOKwBB9drHjM06B12JozPX/epPvVZg3xoweMGWGjeaTWIBubGkwAdeOi2Ufd/hxMayvg/r+4ZlAeEAz8ggRK11uJ+T2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209715; c=relaxed/simple;
	bh=P7tBzf2mLSD77PUkIJLik4X1C0q3lNSZbgxtdhmq/Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Al2Mtmx9csdVgQxQSWJpdM7g6z5TsYRQhj//3q4/cXGMUjPBYbMkzm31WTLe2EaiYOk+xmeZHWzhqtX7F9lHv2wKLLiM/YRzk7MhM17d1nmv6vTxXG4AdfO3Fb9wAMqaxiBLvfwT1broxVXtGLVNfnOtSKCWzxyqgqHKSVQtiLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AvPNaqrK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qkQhCpK1; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AvPNaqrK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qkQhCpK1"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1189E1380157;
	Thu,  4 Apr 2024 01:48:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 04 Apr 2024 01:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712209713; x=1712296113; bh=Hps/sudSxh
	UcF1p3L1sTCd1mwhfFAWayjIIQNJ1Ryeg=; b=AvPNaqrKHm3GD6ohWhEkxr6DqV
	yjzTwdm5KQPthm5SH5vbXey9MBVNrabM+yqolTZxHWsnk/KsKLI99PFb1/LCVzH6
	QlvotYs7MjlDOsXVVSkBFexuxdJsZtFaT9Xd3EtVATpesA3O7OtoF9vDxo2s35NN
	Ah/vHtEKF1PoUkUKweANvjtC5SLMFbKJrHVbq+Al6TRclmY48CU5JQmjFqurqDzU
	oaHVsC/KESSwoBvlDWW0ra93ZNoff8CO/Fhre2Mfgru673ToWNqUg3jaK2t8Bm3v
	xMDKP92nkzYaVZJagSuohSPtp+SmrZAITPxelCJvaJ+ctOIhwbJhGijRlvFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712209713; x=1712296113; bh=Hps/sudSxhUcF1p3L1sTCd1mwhfF
	AWayjIIQNJ1Ryeg=; b=qkQhCpK1EINIoghEsl/0d61BFmrdzVEEU4I0SKhYtc+S
	jmF8hskscHCwozNrjeNW5A0dGWZ9KP5fpaUBp/B3b7A4uJAWrTWqo2beIzyCWu9k
	pNpIpvpqT66JfLq+OHk3d8bKUqV441PFtogeHhEKI9SxnlbjHDnaAxY08SoubVMo
	oVJo6YZjmLdN/DCWYOlKSWLJFSf1izD398HYJy7HOJe64SIiEamx4v019RgjLaNc
	Uml2AbjtUkVJ2XMrt3PsweUFeJ3IspbNXSxKYD1uXCcW1iqPEMq3ScE8y/Szj6UP
	EilLOE5ZBBBXypBTKoAL9U53Qlql1QsfG1imda6mUw==
X-ME-Sender: <xms:MD8OZhJOP0epPLEJtkktxsY0FUHxkqSfJY4h19VSxc5Ve6bbia8kgA>
    <xme:MD8OZtKFphLH0x4H7OR0E5W1sJ77aAFuPtE7YZ8LKAiixhJoL9AugDNAQEYPTZGCP
    vyQLLp47KLYToVafw>
X-ME-Received: <xmr:MD8OZpv-Gf5mGBZJUOZMldeRXWFDquHfnGvuPDIj99oLp7O4h_HE_Hzoq73bpt02SlfflBaUz10fxmT1uxAarDcGubecfr5EOyH65a6NJ0Szu7HD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:MD8OZiYWmPHwX4TRcXHM_8UAnpodftrH4dHGWWjz4O98GuXygdUNTg>
    <xmx:MD8OZoZW8xww3MVww3F7nPuxbMJhffyGXRTS1H4QGbWXt2ewaMw1iw>
    <xmx:MD8OZmDXxms3mSoGaaNc66WUwt1SCwrgjv3FB0qaGN8eePlJgQtLrQ>
    <xmx:MD8OZmaFR8hbrxXgadKpGEATsLZ9dPTxZ_ECaEHYQ7YTtyvkXAIXUA>
    <xmx:MT8OZvUawjNXCZktiW2H4jq7nth6uOh44_aosXPqLSlPFdeOiyOTKZpm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 01:48:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9555533f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 05:48:29 +0000 (UTC)
Date: Thu, 4 Apr 2024 07:48:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v2 06/11] reftable/writer: refactorings for
 `writer_add_record()`
Message-ID: <4877ab39212867e91058c60f99fe0dc2a592d583.1712209149.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712209149.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1++tFV3UJDwm8tq7"
Content-Disposition: inline
In-Reply-To: <cover.1712209149.git.ps@pks.im>


--1++tFV3UJDwm8tq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Large parts of the reftable library do not conform to Git's typical code
style. Refactor `writer_add_record()` such that it conforms better to it
and add some documentation that explains some of its more intricate
behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index 1d9ff0fbfa..0ad5eb8887 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -209,7 +209,8 @@ static int writer_add_record(struct reftable_writer *w,
 			     struct reftable_record *rec)
 {
 	struct strbuf key =3D STRBUF_INIT;
-	int err =3D -1;
+	int err;
+
 	reftable_record_key(rec, &key);
 	if (strbuf_cmp(&w->last_key, &key) >=3D 0) {
 		err =3D REFTABLE_API_ERROR;
@@ -218,27 +219,42 @@ static int writer_add_record(struct reftable_writer *=
w,
=20
 	strbuf_reset(&w->last_key);
 	strbuf_addbuf(&w->last_key, &key);
-	if (!w->block_writer) {
+	if (!w->block_writer)
 		writer_reinit_block_writer(w, reftable_record_type(rec));
-	}
=20
-	assert(block_writer_type(w->block_writer) =3D=3D reftable_record_type(rec=
));
+	if (block_writer_type(w->block_writer) !=3D reftable_record_type(rec))
+		BUG("record of type %d added to writer of type %d",
+		    reftable_record_type(rec), block_writer_type(w->block_writer));
=20
-	if (block_writer_add(w->block_writer, rec) =3D=3D 0) {
+	/*
+	 * Try to add the record to the writer. If this succeeds then we're
+	 * done. Otherwise the block writer may have hit the block size limit
+	 * and needs to be flushed.
+	 */
+	if (!block_writer_add(w->block_writer, rec)) {
 		err =3D 0;
 		goto done;
 	}
=20
+	/*
+	 * The current block is full, so we need to flush and reinitialize the
+	 * writer to start writing the next block.
+	 */
 	err =3D writer_flush_block(w);
-	if (err < 0) {
+	if (err < 0)
 		goto done;
-	}
-
 	writer_reinit_block_writer(w, reftable_record_type(rec));
+
+	/*
+	 * Try to add the record to the writer again. If this still fails then
+	 * the record does not fit into the block size.
+	 *
+	 * TODO: it would be great to have `block_writer_add()` return proper
+	 *       error codes so that we don't have to second-guess the failure
+	 *       mode here.
+	 */
 	err =3D block_writer_add(w->block_writer, rec);
-	if (err =3D=3D -1) {
-		/* we are writing into memory, so an error can only mean it
-		 * doesn't fit. */
+	if (err) {
 		err =3D REFTABLE_ENTRY_TOO_BIG_ERROR;
 		goto done;
 	}
--=20
2.44.GIT


--1++tFV3UJDwm8tq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOPywACgkQVbJhu7ck
PpSiIw/+OF7iyvY0ojt0KWIukHNGUZiwkfjumo+7NPANVLG+9j9UER8bhcfwyZsV
xQ0pfANoSxm1ewbBf5zxgsbwWdM6sA85tLTYAxYEco+bZGxNPEOAjX7ogGyaKNyx
k4E8tlsXfDBPXtj53b6KnARvihYE5D/1HgryLqxjQCFqkQ9Zo2X0VPRBhDsQ98fI
lIVEeM/+fn7q6OMAzYdUdFTCP1TiHd5PRSuGp64Vo55qv7ctrFhBNFROnomI6a48
M+eXO9+kUzomD12pulfC1E2tWWqL0tfWGvtM94LfizWklOUiN/VyZnlVwI2518oU
1g7k/Zi92G8DuiPhhxuK1n4u6oKjhAO0qWlSEOpNcwhwqsLxG5KobJbPtGjKPN3D
JyaSaJBy7mCFQHuY0Wsdtbjp0kah/QfGHUIvdCbsgW3IdEV0h+2EsJIOwHj2tEcj
AH0R6K3hy+Ay4fnRePDzzJhZzztCvHrTX2CDAMYbrcpYXvs8W3giwUA9Ko+qWYWT
NS+JgYzsq1IEkytDcOBvq3F86uZ6J+uaZMv5a38cuyaqZJLeb9KXGXAntcVk9/6N
gUwcBGOxndoPlhAEjAAEAT98Ih/npS8wyKaN4rNGFfzWOr/UTmXg2nL70RCcHrTn
6CdpsWodRDBeDOBDMDwCq/CoqUy+ZF7Ai7fpsq/n33Zacoc1RwU=
=BzbM
-----END PGP SIGNATURE-----

--1++tFV3UJDwm8tq7--
