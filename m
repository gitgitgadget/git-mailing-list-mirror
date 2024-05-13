Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527AA31A67
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595758; cv=none; b=Hj041SGaU2MqHc8YDcoD4YHjOLVUN4k2qfTTRrgb5BZT3Qx6xq49l39coAyWFxkQ4lTGeiB4wGhDICaiu5ZtX/96ezVTYJzVLuLlgCDtqRxVhRYHkaNe44aE8RtlcNtW2TcTKsHhhzPrhvvkTy9yDPEo4d3XaNFM1mHroAzd9r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595758; c=relaxed/simple;
	bh=uW9/R5SUpEwnyUlye8cGQSNrEv5y3fr9NU78UkQjUnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwbUJE0w/iqo1syHVsWPQ1WA4kkWRKrSgjf4gJCVFPaupI4Alre1bIGSXq4WJqI6fe+FdfG6m/diMjcTsE0FyHl+ciE3yMquP+kHCILfqVT5usOoPec1noCOXmixiS3cH5BzQQV4fwthPOgJCLSEEeEfGbBAa+SwktcVfsW+jHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=khc2iuTx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HvjYvuQ3; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="khc2iuTx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HvjYvuQ3"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5D05C180013A;
	Mon, 13 May 2024 06:22:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 13 May 2024 06:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595756; x=1715682156; bh=QQSaLB+heb
	1sdAXjS9cid2TeLDMrMtK2752O0f6Bu1A=; b=khc2iuTxDPY12T594eVXKKRZ1T
	xlKgkpfxXnPQfq2/r4zVdWh4wEBfHUtyF3ihrCEoZ+ZvAxSP/n2vK0ULglbK8ose
	o8VXO9SC/W5yUPxpS6ZkROhrekyiyJ+Yn3Ho7rYjn0WFQH7ovX4B6SvgGlbMVTqE
	ofFeEp8UW6BFrX5WuoFV0XnVdP4XaG/6VnoWtbelD47/foPYuAKc42zbckOE06RN
	pXC+8zFNz7E+ng0AUT48pVykq6ilDdBgyRpixWkoVFBKLJn9lz+Wfl9agxnSSkGl
	axbkMEHEqlmGQQ3iDCfLPEjcWqiHwowBdJj0ptKeLWUGrpbo0kqV2P3DcEDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595756; x=1715682156; bh=QQSaLB+heb1sdAXjS9cid2TeLDMr
	MtK2752O0f6Bu1A=; b=HvjYvuQ3hp1OIpXhpvn4C9dFT3ed3DbhG/Vl3Jtj4+42
	qaCsybMuZdVWKRb4qaf5r3Fn5Le1ritHWlGabSj0vbfSWXpQqE403EQ2jofcl4Kj
	UB/mMNWUljBWIN1puYsiZgRfjxxfdRRw3Ilta533Ukx6jH9JLQL+pPLOKNxNq1DX
	mjGd7yFBuo5NEXUQqdyX3DtZfzNZfz0n/0NsS3W0cHFLAFrBoUrJGg5MXqldRPzB
	9Ps4HJU2sTPT8KumYsf2fu4Cd3TfCaE27nuRU4+vCGeAfRMSDZgVaQCLC/EjIgDO
	PlJD1Zanfnny/T2dnPvvCh6bQ/xlwo92AGhHXOSo+A==
X-ME-Sender: <xms:6-lBZsoVBeCaE3jxOGDLUcPfxdOdjUUl2Czuzq4LKZ394REu3-m39g>
    <xme:6-lBZirf632YLg_kM96O8bVbN5ocnzLbSqaD_h2zsUNHMogiC_ampK4jh5RsDUS-H
    hFmNJrC4RRmei6qVQ>
X-ME-Received: <xmr:6-lBZhMZBqZHjIhWjC8QIbGLVjmrBncMo0cPByDM4wVK7yptCQBd9Z0c2TnRfhNlFzBcwyxr-9QZoP4H6R-uHRKxi9eo_w1z1E6yDh9YiZtSiCM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:6-lBZj4rhwfaSEigF-uTlQUPZvE92dsLjU2yZsE6F_hopG25Uww08A>
    <xmx:6-lBZr7h0oJgarVPGnJ3KiwA1gAiUks13uFGWqk20QYkUVcq2021uA>
    <xmx:6-lBZjhuqYrAbQCZ2vlT9_JkTKYlcO8sxNxVA94r61DDQDi-8NkDnw>
    <xmx:6-lBZl7PZ-HpUdEYoSsJnJr4FQG0n_3KR-3o6yWGGaer9y_RBSKo9Q>
    <xmx:6-lBZu2rtDfIBnKQlmD0eOh7YgzjnLZxbCMs_g-gf-GtbrdxT2voY52j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:22:34 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 05d7606d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:22:16 +0000 (UTC)
Date: Mon, 13 May 2024 12:22:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 07/21] config: make the config source const
Message-ID: <1460d3a36c4f5357310164114e23ba32f3098802.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="91R9xNbZqxO0IGHH"
Content-Disposition: inline
In-Reply-To: <cover.1715595550.git.ps@pks.im>


--91R9xNbZqxO0IGHH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `struct git_config_source` passed to `config_with_options()` is
never modified. Let's mark it as `const` to clarify.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c | 4 ++--
 config.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 13cf9eeb16..bc0c005039 100644
--- a/config.c
+++ b/config.c
@@ -125,7 +125,7 @@ struct config_include_data {
 	config_fn_t fn;
 	void *data;
 	const struct config_options *opts;
-	struct git_config_source *config_source;
+	const struct git_config_source *config_source;
 	struct repository *repo;
=20
 	/*
@@ -2105,7 +2105,7 @@ static int do_git_config_sequence(const struct config=
_options *opts,
 }
=20
 int config_with_options(config_fn_t fn, void *data,
-			struct git_config_source *config_source,
+			const struct git_config_source *config_source,
 			struct repository *repo,
 			const struct config_options *opts)
 {
diff --git a/config.h b/config.h
index db8b608064..e66c84520b 100644
--- a/config.h
+++ b/config.h
@@ -232,7 +232,7 @@ void git_config(config_fn_t fn, void *);
  * sets `opts.respect_includes` to `1` by default.
  */
 int config_with_options(config_fn_t fn, void *,
-			struct git_config_source *config_source,
+			const struct git_config_source *config_source,
 			struct repository *repo,
 			const struct config_options *opts);
=20
--=20
2.45.GIT


--91R9xNbZqxO0IGHH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6ecACgkQVbJhu7ck
PpTLrxAAiYt76X/DieS7kxyiSI7XGa3/K09wrTgtA/7wytUj42MWmeFm3YgH69vo
tYKg7JRbqfLMbuHXvpI2sYrUc8hA0ZyyxxyWYlbKUr3Vg3HAueYx9dVns1p5Pmow
AxrpEvISaveeJipF64r+gDG1oHnZ1/xTY0lPKTtDxuyA13H/aKlr+RCH0emKhXW+
F9nPN2UWBoifhz7OhN0v+YoAkAiM/jxs5y/UDT9mx5+FPKeub3sBy0092XofbyfO
BJrqzAGip433qH6FwnUKSKRVlQw0Ai/EHqDIE6tCiUwJiNxVrtwkrcn7J7z7UmWy
afmJkNYGjpHHgAP4QFiuERBlcF0eBCKuWvoVfV/9R32aFI9c747uY3oFwtp+Qzhu
XebtrdKdDVXRHbjMLlTkBtq4ImRBZUvngv26eJrOyexsGw4XnOZDuKmSCBWEgzot
+VVYktKFYTgVOl5TybyJdsuWqYDfp3UUGCZIKbNZu29qZqhWIyHsXFylLZTY+W0j
JjUnQw6rt9hi8GRus4ISdktwHJ4dvdGbCJ7I6/rAHHFRRvPoIVmVCZXOEtfO50Zt
J1w0yfbIACGg2lNGWkZKlRImb+ltx3Upr8feCDE9LQqaHrx1IjlO9B1ke7SdAC6h
LF/Hev5WaRYNxcgr6iKfbVZFp//VNxj6sS9kVMNyj7F9ZMGYoUo=
=s0D0
-----END PGP SIGNATURE-----

--91R9xNbZqxO0IGHH--
