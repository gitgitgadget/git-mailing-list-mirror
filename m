Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73E51AE053
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013854; cv=none; b=qcy3vpKtR+fuJUwXeP353TDX71y5t6I175lUvv0VW/q0gqwB1h8kheyiC2AbY+6Tju1hyoNLCm/A1PZVV0y+ZZyiwWe8khutLOI9nTG83HJ9DTmyacgEBCETXi5DWd4yemgOzYPAxfCNSZShxFiFKKDIm5akVDIANKYpuGGXTY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013854; c=relaxed/simple;
	bh=GMv57+A8V9ZLOnNKoe85t84YHzqxr2BCz9U+D4w5D9I=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsNYxOZT6skmPHurZ5MVAj4NurJwVdp+U0M5qJm7gBlSlptdN+7eSE/0g0UPjWAwR1cU4xovsO6Obx4pg9lzZEjSqzj64TxyqH7vEafCOTx0OzU94MimGw3NYO8ARoSThUoz8GN5qDUyQcWFza2X+z/aRIfbXL6ZVw9rvu6whYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nSVXY8Hj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EP1Sgu72; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nSVXY8Hj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EP1Sgu72"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C8A9A1151AB2
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 02:57:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Wed, 07 Aug 2024 02:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723013851; x=1723100251; bh=tGIYBPwCfW
	BxkD2X67rIMywCoAtMOtefRu1kVr1BcKk=; b=nSVXY8HjVpHpfStH9wx+vcJJPY
	JiTqhIVrkoqhNL1yW5bXwdjrJkOh/+lR0S/vpXp8mx2NnMvdntTDH7oYcis3GC+P
	A2dUxP/xohazASkGQLxU1bVY86QwMIRZnBUWCyO3nyrcuoxU6aJ62C2HQMetB8fT
	wF3Haljm1WZZ7QNn76pslaBaCPab/9TOi1sWalzIZBad0DvOz0ElC0F0tIGd3RGx
	LwmFi3ON7je5zgt2gfOXDIKI/d4zoe+qcU6E7IzO1jYCkF26XO1khraMsDN5n607
	7Z9w4wzL0gHjNrSYB37DO5H6yQUmpSaobyevOUqjLehJySvnRsJr81NKBCMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723013851; x=1723100251; bh=tGIYBPwCfWBxkD2X67rIMywCoAtM
	OtefRu1kVr1BcKk=; b=EP1Sgu72gsZ6TB6A2hl5Gz7CvOnWvvfxMOcWrYCGTcV/
	EX6CgnjlwjPhM9A+lQLEV25qIUh2BYIGp0D86x7I5TjTm2aC5SdtGlK6c+F2onjM
	c1XEgAxjNRCuGovfHnmtStmDSRJ8BAf6EOaAH2s7JC9hk9F0bq78/bzC0iFpLvs1
	AOxQmvUXQBsGO+0vK0zGbrLFwLu3QuWBcjmpHPtjw2Dyzjct+D0KNi4rrXYvUd6Y
	NT12+0qxRfsgh26b4/KIX+FUif9LOUz43mm9AS7s96pFYTER+CsLvBfnsX2A4QZK
	AsivxAB+Dt65ePD1Nmi5dL4rIOujxT2g2+Jx2Iekcg==
X-ME-Sender: <xms:2xqzZqO2mjf1qX1Koa_HQ_b_YRXoqC0xQcf8Oe--ots19L7HOe9Img>
    <xme:2xqzZo9RMK1roHO2xa5IGYVJbmE7brg1T9m2vUpKCV0DVjHQwPX79g6IZhEl0foxI
    8Uqbv9AKksmCe_gvw>
X-ME-Received: <xmr:2xqzZhSMDVBwrJWnjGT7J1pprBjWGMGYVaS870_PEXEJg8_RkWHdXws7DH0T8VIw5p2q8rIbrMj9tRWzDz_0XyNGbSuUELM-brauXC5TuHngvZpx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:2xqzZqsI8gDqF0UcDaEXwrQsvGo4uKzDDUHHbPI-D_nE2WQtNcXPQQ>
    <xmx:2xqzZicXv16VaQgY37A0gDM30gi_AeNcNVUoV8sszx8HZAVsu0uIcw>
    <xmx:2xqzZu2BBLEHVR-8QjwJsDr0H7ymz8cPEA4fKfyVq0PfDpGU01KwrQ>
    <xmx:2xqzZm_RvyqRttfUB7u9A9nJF9-s28mylQuk-7j2puIYq5eTzmAClw>
    <xmx:2xqzZmFeowNHaYhc2yRRLWw-5xKq1wFfhtsbIgcmT8P68UO5fezBz_oX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Aug 2024 02:57:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ed0552f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 Aug 2024 06:57:27 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:57:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 10/20] config: pass repo to `git_config_get_index_threads()`
Message-ID: <03df1277f70faaaf52df24bcb10732c107c2294c.1723013714.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="plfMG+mJHJBymbpI"
Content-Disposition: inline
In-Reply-To: <cover.1723013714.git.ps@pks.im>


--plfMG+mJHJBymbpI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor `git_config_get_index_threads()` to accept a `struct
repository` such that we can get rid of the implicit dependency on
`the_repository`. Rename the function accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c     | 4 ++--
 config.h     | 2 +-
 read-cache.c | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/config.c b/config.c
index 476cd73c9e..387c7282e9 100644
--- a/config.c
+++ b/config.c
@@ -2826,7 +2826,7 @@ int git_config_get_max_percent_split_change(void)
 	return -1; /* default value */
 }
=20
-int git_config_get_index_threads(int *dest)
+int repo_config_get_index_threads(struct repository *r, int *dest)
 {
 	int is_bool, val;
=20
@@ -2836,7 +2836,7 @@ int git_config_get_index_threads(int *dest)
 		return 0;
 	}
=20
-	if (!git_config_get_bool_or_int("index.threads", &is_bool, &val)) {
+	if (!repo_config_get_bool_or_int(r, "index.threads", &is_bool, &val)) {
 		if (is_bool)
 			*dest =3D val ? 0 : 1;
 		else
diff --git a/config.h b/config.h
index 8eb3efa0c4..3f68b30047 100644
--- a/config.h
+++ b/config.h
@@ -710,7 +710,7 @@ int git_config_get_maybe_bool(const char *key, int *des=
t);
  */
 int git_config_get_pathname(const char *key, char **dest);
=20
-int git_config_get_index_threads(int *dest);
+int repo_config_get_index_threads(struct repository *r, int *dest);
 int git_config_get_split_index(void);
 int git_config_get_max_percent_split_change(void);
=20
diff --git a/read-cache.c b/read-cache.c
index 742369b295..ad09950153 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2267,7 +2267,7 @@ int do_read_index(struct index_state *istate, const c=
har *path, int must_exist)
=20
 	src_offset =3D sizeof(*hdr);
=20
-	if (git_config_get_index_threads(&nr_threads))
+	if (repo_config_get_index_threads(the_repository, &nr_threads))
 		nr_threads =3D 1;
=20
 	/* TODO: does creating more threads than cores help? */
@@ -2787,7 +2787,7 @@ static int record_eoie(void)
 	 * used for threading is written by default if the user
 	 * explicitly requested threaded index reads.
 	 */
-	return !git_config_get_index_threads(&val) && val !=3D 1;
+	return !repo_config_get_index_threads(the_repository, &val) && val !=3D 1;
 }
=20
 static int record_ieot(void)
@@ -2802,7 +2802,7 @@ static int record_ieot(void)
 	 * written by default if the user explicitly requested
 	 * threaded index reads.
 	 */
-	return !git_config_get_index_threads(&val) && val !=3D 1;
+	return !repo_config_get_index_threads(the_repository, &val) && val !=3D 1;
 }
=20
 enum write_extensions {
@@ -2875,7 +2875,7 @@ static int do_write_index(struct index_state *istate,=
 struct tempfile *tempfile,
=20
 	hashwrite(f, &hdr, sizeof(hdr));
=20
-	if (!HAVE_THREADS || git_config_get_index_threads(&nr_threads))
+	if (!HAVE_THREADS || repo_config_get_index_threads(the_repository, &nr_th=
reads))
 		nr_threads =3D 1;
=20
 	if (nr_threads !=3D 1 && record_ieot()) {
--=20
2.46.0.dirty


--plfMG+mJHJBymbpI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazGtgACgkQVbJhu7ck
PpTarg//cSSI5AIx29xCKOTJpOWUpk76zFzz3GdJZtE86ozCox4yT4Sa5DNhtPCc
DCmADO+QipK4EEewJpvCna67nTfLMKs413PxM++wDPDac/gOSwwxhJjQ7tdXAoa+
lQcK+BmZfkEavprJbavDl6FUVtjwvXC2tLR1aHZ0J6/2WL++p9RjW3Fub7ypKAUQ
Ch0zSiY5MWJcvhvVXcuGjTk6k+9bbmLxWWTpoh2d6bshPPzpNq4hoOhn/F6fevhw
Qgo9DyWB65b3dMuZJxlqSe+xrKwKl676EiBP5+mS6X/xZAS5lxFlst76d91yTdHg
Vv8EL7DyNjPtfFVMlY/YD2YgrvQ41kqC1oVKOpJ7LKIppis70diUoZ4OD79W+mg8
G4nG3hM1Nrr3FuDUMgLeJJfdPNUDlxq6TYML/0xklsCRChUmKs0yCDu484ija0vE
bl/kxe9BZpDPln8+YSkLhlnsHxVL58SXxpug8d1ZXxIZFaz6Z9pSTUTrGt4jxNuf
1yAFeqDkNOqnHkNCXOcZ+4kSGQiZicdKrhlFVyc81ATeUno95H12i/TCSxTYWKeI
8TiUhX5qkP2U0noTZDZdncUVsUg7I+wmD7QGZQPJMXg01m9ZNFBsVMsWTL8ot1zq
r/rzBCqz44WGNOgBDrOO9SSdlewVFVKqYdJ2Oj0MK/Z2q8ow2CU=
=rJGO
-----END PGP SIGNATURE-----

--plfMG+mJHJBymbpI--
