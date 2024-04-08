Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57EC6A8A3
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578619; cv=none; b=qu7q8rUjbRgebXhfGK5mHhUrCXkz9KldZPvIDb4mZFLDsmd3KRGECkjtuEWJSxOjeWEfIMKypbHDgIJnT+JvrwlUovVmg3N8t9DRy1Yko/EMXD5dN85hEnYN4laQ6yAGLVLbi6Seh1dunCkVInaEXGzkUiPIZQ/0OF/hpZOfrP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578619; c=relaxed/simple;
	bh=HzRr0J6eFAjXeVqNXsGRR6aGFJP55W0WvuXfjTZCejE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCiZIPas5l3TTm4zWae0kMz4jbGA4XVJ8/sTKupYt1q5NOYgTnltbaAwh6+UjEvpSPZ0B3zYMMBsN6q1rXA7h1QEhce3RijWBjA62cgfQVgjI34aoJdHKIzX0MqmKAwB+bEWDq0yy0D3a6F0RvbVFnhmCbx/QmwJM2/DiOCXxWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cIff7wFi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GZpL6gL2; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cIff7wFi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GZpL6gL2"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3CB671140077;
	Mon,  8 Apr 2024 08:16:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 08 Apr 2024 08:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712578604; x=1712665004; bh=MpVXaBDT+9
	GHdv574Gar3EYI1kJvGsH4TGuUo3QnhzA=; b=cIff7wFiZSv+IzQ8MxLOvoaxvl
	WZorVgvnJyBnA1hwGt7s1N1DCTJH3/jv33Qqew1JGLo5IqaK5kgntaF3D++Fmj7h
	l/9v4T8E55DlFCTF7RNtXWMo5IFXqA8IPCLjUC2D9A+jpNz7BlE3saK0VLYZWlt6
	lzeEZPWSlMZOjNw2F3JRJ7gcNhxyu/omdZmtJH7KlyKapX0h7KEQt+8JCH7M/08d
	1ZUnkipCKjv+Yt2DE4TcJJJwZJ065bMcGoe/pmE8s8ucIejmw8mWHzUT/k/Bv9iS
	+XNgANf9SNbjuHzEFczkhc8cgYz2IzRj3l/hLdUYplWf3biiDc7BQU67EgnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712578604; x=1712665004; bh=MpVXaBDT+9GHdv574Gar3EYI1kJv
	GsH4TGuUo3QnhzA=; b=GZpL6gL2vlCvCJpQWFWC0WjRH9OOHpM3NpmErFTV6u30
	zvGF4f9e49FNssxuBRF+tK9hJyPEawXHJkaAV0zl2bg35kt66b3LVSstGlRoEEtf
	gT9HmxszRVBEe1mAFY/kj1wVrrdVfv5226IFfNdIHZjAVhteVIGGPsTd7KdXH1sZ
	+mNc2yrhxF00YhVvkm2QI090AReBqpuClYaaG1vijwKOlemQv1OpITRVP+YOust0
	F3836ZVQH2bGnTpQ7EZoIWLIDu9BTxChqOkYMZdprlbcFD2bakfhk6RZ5759FgUS
	8/OGAN8s6IbK53QHQKpB+yeRI+3+7w4+URirDsH7gw==
X-ME-Sender: <xms:LOATZs14u8QKaE6AXJnjmizPtUn7qu_ZK8ddmBV1ArgFkY8Jdk7aDA>
    <xme:LOATZnG5TJ3XTx6gz34WKD-YqBJQC_WZC3u9_90qBssbjV8fQ0tP9X63MZJug3Dir
    g51q8uRrQg6wy0a_g>
X-ME-Received: <xmr:LOATZk7T0tFQECUD8QOYRf2hNumChaPANjjY_T6kJjwwOF19QRKoHKZ3rkya1DAFJyljt7Bat6Ta9sLopFR107rThMl_mFLHJJxoqyKRENgkIAJFXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:LOATZl14Z3XiTxvOhQdTbzAT0KzVRXPBpUZXp9d4ti3jaH7bpqz1jg>
    <xmx:LOATZvGRMcuo7HriXe8LQyUim0C5xgN6nnbB5vu3luhMj_Lxf-yb5g>
    <xmx:LOATZu9FTBbMPPajoPPfpoVegVR-nv8-bsS0ZKLsbyVEZ85RxzM3fQ>
    <xmx:LOATZkkSQDLK6kM0Ij0qKlr7RISt8aTBy_xxqNgAgUV7d650hBlDSA>
    <xmx:LOATZjhBHJbpnTvroaRZFMX6OcR8zHzKHNYVLm351nsaISvRl3XuIzHc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:16:43 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9d347e97 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:16:37 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:16:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 04/10] reftable/block: introduce `block_reader_release()`
Message-ID: <35f1bf50729efcee7b9162ffe79d40142418c0cf.1712578376.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im>
 <cover.1712578376.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bHFt6VQuwA24agW8"
Content-Disposition: inline
In-Reply-To: <cover.1712578376.git.ps@pks.im>


--bHFt6VQuwA24agW8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new function `block_reader_release()` that releases
resources acquired by the block reader. This function will be extended
in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c  | 5 +++++
 reftable/block.h  | 2 ++
 reftable/reader.c | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/reftable/block.c b/reftable/block.c
index e65453e11b..fe836c21e5 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -256,6 +256,11 @@ int block_reader_init(struct block_reader *br, struct =
reftable_block *block,
 	return err;
 }
=20
+void block_reader_release(struct block_reader *br)
+{
+	reftable_block_done(&br->block);
+}
+
 uint8_t block_reader_type(struct block_reader *r)
 {
 	return r->block.data[r->header_off];
diff --git a/reftable/block.h b/reftable/block.h
index d73ed73549..601a1e0e89 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -81,6 +81,8 @@ int block_reader_init(struct block_reader *br, struct ref=
table_block *bl,
 		      uint32_t header_off, uint32_t table_block_size,
 		      int hash_size);
=20
+void block_reader_release(struct block_reader *br);
+
 /* Returns the block type (eg. 'r' for refs) */
 uint8_t block_reader_type(struct block_reader *r);
=20
diff --git a/reftable/reader.c b/reftable/reader.c
index f70efa2b7c..f925570bf3 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -253,7 +253,7 @@ static void table_iter_block_done(struct table_iter *ti)
 	if (!ti->bi.br) {
 		return;
 	}
-	reftable_block_done(&ti->bi.br->block);
+	block_reader_release(ti->bi.br);
 	FREE_AND_NULL(ti->bi.br);
=20
 	ti->bi.last_key.len =3D 0;
--=20
2.44.GIT


--bHFt6VQuwA24agW8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4CcACgkQVbJhu7ck
PpQctw//VE7dVBHSMXxspp3vtm6XNdzvJPsaKyPmWG8LdtWvI+h3+21gPuOCxMz2
y8T3EfNn34l8uoNnQ8S/dtTAR3T6e5S6lWmLvtg3DQaYKr9VlA2BsBO4DC0WB/A/
fqiEl7Ta4aBu86rmsgvgm+5u9m384NSIKRBFQhV0YAaWVzO90n4b7xV+a2NLZuMW
fdkhmbCN17UHnsy394HJehnryeZSCPzGhiJ/ZebB4zlt6EA/SIxn4rhLxSMEIcwm
cKoDaiRm1Yp9YKF9WJKpvm4xmQanRsjeKQoCnW3IJF5dDv7ngaNQg0oesIWJ8maW
ESBhgvbstxSLnyKmCgPVM5Gnkum4OqO3qayxsHd5e/KYoquQ/4dBTl8hM05LQSPz
slajHlwJ1xn6u9w+I0HDBoy5CO8RXTvjYGzs/EZfOA+eBou7MOE5d63Lhj7nj46F
K7FsooSylOabKXmlq0kYx28L4ia3liGXEAqytFMdXOQrvuNuUfMNddzdO6Wo80s0
cTUQBR/LO0HnrkIgPPgfIF6EQD3wEpA8uiLYPk0SJys5mjlZWefiFfhpGHzQxzpk
voy6iXgquGiz3fEyQO6krVZN+/KhK9ZmXxU5GP9K39m0IrDk6R/676+Jlhhu9vct
URF6fzTy7jH1CFmusHEyFOFSNr7aE5w4p3/OtyXDO0Sb+TwPrck=
=snzh
-----END PGP SIGNATURE-----

--bHFt6VQuwA24agW8--
