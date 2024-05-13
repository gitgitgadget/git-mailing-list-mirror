Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B12146D76
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595801; cv=none; b=ZTjI5pJoXwN/a45LKQF/oLrYE33f1zPTvVlo3tOepdLIPFtgs5zTCnqfviJNrdWLtD2pJzQtx9g1ZZakAyLtFlEZPcCV99q8XBX9jBxpsYC4UvlmiOOGIARODqNIXThDiBb2xnUyTSdhhgI71IHEalYLYMb4fh5CReowHGP8ng0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595801; c=relaxed/simple;
	bh=FwWnck4Fe7vbzNybcIjshHM2d2kaUn/5j3dZAATy9EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVwQRhsxAtX5L8C+f/3xDffaYJmHYLL5Yx/52/+8n++fVKv2ldYUsUIfNiVBByf41Q3b1q9pb1QM0IcxMxOptM0tvgvT8WqCG4/s+Qzez2nZVQbTbmC7KBw8CObhrJYTthKJMPvwr9SR9gedOWYrRR8YXOOLjdBsZmg4a3y1cis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oSST+2aY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OPzs4LB2; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oSST+2aY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OPzs4LB2"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 90C151800105;
	Mon, 13 May 2024 06:23:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 13 May 2024 06:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595799; x=1715682199; bh=UO2dj4aUGU
	8J1avARLpaFfR5DNvIAtaUr+SHqxd7Cs8=; b=oSST+2aYhLGr1dMy9qzCyTvflt
	Wy4lQixEnzN3+Yg6RyKGjesbL9G0s6uT1Dn/QAc4Z9c2vYL592vhjtcLFRVMEivw
	edDGe9q0Ayusy2y4kT4ghuP9SlkJijBpnE8hUWruVm+Taf3bPqOD+IS3Xj7eFnYJ
	Ov1PfG8nPaiDf4pIR/364B54pWypbHjKnFG6Q/jNG4TGbxgZhkKaRwq2YlIrxm+A
	zY7LopMlJXPCfTeNmDUVWiv1caVT3xq5tcg4LwndPYaZs6MCYk0F44IoJ1GtuFHv
	TtJ5+lYePuzTEY8xRAiyvHo9PexxhXXj8lz4LcuftLpt6u9ly96q2con/SnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595799; x=1715682199; bh=UO2dj4aUGU8J1avARLpaFfR5DNvI
	AtaUr+SHqxd7Cs8=; b=OPzs4LB24EU/yT/krosPo7KXWUXe5rmFtGd8XFShMrXe
	rtyFr42tHjLdfRm3T0hBpMhyIkAb3MIWUeFJi68EMo3vzWLaAsREMXevFbguJv85
	9XtuWQ/IlmomAu8PNzj3XUFLp66z+DkdZMBUVkro8TnG+ol3w0znrb5B1f7laGen
	TlC7qDw4N7YJuhNYFc2Vdo8Rr3OVOjSh7QEmbpw/6RymsyGL/o22X512t9apVyoE
	VNnl6w2z787NhYI5cLASzeQ1PYOcAJrvfhlD8nUmJjXzmUxvEr/oktwhprRMTPwV
	UeEYaB+36tMsp6iCfCKY9AdOonGMRUDGnxAdl1OBZQ==
X-ME-Sender: <xms:F-pBZrSQjXsPgiUi_vsbkYj_vAS0eaCEMz59UdW0ejiQIprmYcCdMw>
    <xme:F-pBZsxwLpGE2Zv05FfzjCZ-F1UF866-4ukciAczvDZw8JEAn6wAlwpVKbfoeZfBv
    Fh1xEMignd2Xgotxw>
X-ME-Received: <xmr:F-pBZg2njWV7WKzl0yOQ7vzua7swbSCbKVe5FHyQdVmNGp60Ik_UPo4rVJpbHkBmm-L6KKhhGo-IMtnU1RmUitIw1-VOsaeZxPaZuhkjdCKczro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:F-pBZrA6RQxjwEufzspvT7RlNnAWsMlFPczXSJM00n3Qzs1lYUTneA>
    <xmx:F-pBZkjht2JQUwebYLNFDkiSxNaZXs14ipoPioSCjb1z3_OeHAy3zg>
    <xmx:F-pBZvo3-NsBZ4yxi0KtRD15in8aswsmeIQlg2DPnRGNKLgzhj9IhQ>
    <xmx:F-pBZvgCEISuLYLrdZ36e6PP2rJWEFOBEm3rPBXzzrCPBMF81w6vqQ>
    <xmx:F-pBZsf4scIrk43TNiVkT1penIXoyx1qs5VK68yP_4rCqgk_HmKrjSKF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:23:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 21511ac7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:22:59 +0000 (UTC)
Date: Mon, 13 May 2024 12:23:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 15/21] builtin/config: convert `value_pattern` to a local
 variable
Message-ID: <b656951f0c7bb169169fc8eba77aab101940ab9c.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EVpOJXVWIpIblOzU"
Content-Disposition: inline
In-Reply-To: <cover.1715595550.git.ps@pks.im>


--EVpOJXVWIpIblOzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `value_pattern` variable is used by the `format_config()` callback
when `CONFIG_FLAGS_FIXED_VALUE` is used. It is only ever set up by its
only caller, `collect_config()` and can thus easily be moved into the
`collect_config_data` structure.

Do so to remove our reliance on global state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 16d92ab176..a17e274ece 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -124,7 +124,6 @@ struct config_display_options {
=20
 static char *key;
 static regex_t *key_regexp;
-static const char *value_pattern;
 static regex_t *regexp;
 static int use_key_regexp;
 static int do_all;
@@ -326,6 +325,7 @@ static int format_config(const struct config_display_op=
tions *opts,
 struct collect_config_data {
 	const struct config_display_options *display_opts;
 	struct strbuf_list *values;
+	const char *value_pattern;
 	int do_not_match;
 };
=20
@@ -340,7 +340,7 @@ static int collect_config(const char *key_, const char =
*value_,
 		return 0;
 	if (use_key_regexp && regexec(key_regexp, key_, 0, NULL, 0))
 		return 0;
-	if (fixed_value && strcmp(value_pattern, (value_?value_:"")))
+	if (fixed_value && strcmp(data->value_pattern, (value_?value_:"")))
 		return 0;
 	if (regexp !=3D NULL &&
 	    (data->do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, =
0)))
@@ -397,7 +397,7 @@ static int get_value(const struct config_location_optio=
ns *opts,
 	}
=20
 	if (regex_ && (flags & CONFIG_FLAGS_FIXED_VALUE))
-		value_pattern =3D regex_;
+		data.value_pattern =3D regex_;
 	else if (regex_) {
 		if (regex_[0] =3D=3D '!') {
 			data.do_not_match =3D 1;
--=20
2.45.GIT


--EVpOJXVWIpIblOzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6hIACgkQVbJhu7ck
PpRZUg//ZtljudQUYGGPsvWpRkfVG58J6bDQ1RHEvRSIQFk5XW7gb8CNsTCP3Ohe
31wJt/nuiFfWUeZRFgoCZd8p3vLnLSPAWfPiGluNA33wRoIleo5KAtaNWVSYz8wC
O1O6dzGy9MB/PAwKT6aSQ+zLuWn2/hryutSTObznjAKo/vV0YwHTYUXs5yomuQSp
bFuYZo8TzRw3FajtRGqJCRCn23AwjnYP/ctDVYh88+gk+W+JAbCq46cJDTwBC7uv
xELHkUX3R2ROqk3PWJSfd3a+SKbJ06ldtFMuQDxg5K2/3OKwMaN4BNc1BMA5U6qq
ysrDLxfFdOaFRu2OP25V/DkyDXrbLMBNfLLCzbOdjmN/zJt7x9ChNs7sgNmv00cX
2cNSTfCBnmOq+s1x1X9pdJEG3sQslYFKhK02ZDA1KeO7HKjbSSPC2tp8aSsMHhvP
cndJy4C8Zl8j4tH4/ETkTFX+Sp0YqEDy/Q6qqLlCedFweRg/tXRG/PaiGYEnm9Yx
WXC+DzCSzA1gROq9unKlyFowl5p9nMY3/+pZbazxHsZkdPJBsm/mcaXg1kANWW7X
tTaTJfiyZE1BiJm5p8JNBvb4GcfBUWWAZVIz2kz4BbBdFJyhjZHrz9k3tA6zgPFs
Dp9jFiowls0UlQjcbQX2syArwoDRCaHG8n/JFv/9Q/aEpknaEtw=
=+uDP
-----END PGP SIGNATURE-----

--EVpOJXVWIpIblOzU--
