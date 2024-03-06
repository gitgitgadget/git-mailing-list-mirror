Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012CD7FBC5
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724703; cv=none; b=EOmI1mm12HNG3z8r2mYSyGmX12kt/7LTxjAcbfnFZK0ZC8KzN3ZcPNl1t6TyLcvcnGTT9Sqfl32dsY0ccXKWqF3ZfHPgLcq4cA5DqCDDztbDrtuA0j88Ml1yW4Hvk0EvM09QJfRFEUzm/Mijl6tUzOgJe1Cl2nPSbFMIsaHKXho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724703; c=relaxed/simple;
	bh=B+pmX9y1AMaO3yw38gCrP9JwMRU/2MV2dOdSvvH7JOo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBZ8bUZidlsxBrpiaILxl2dtrPoYxsoXPLh7ZXzORkoZqc7ulauCxao0YfUknnml+tfI+NdQ1sMzwbDW3VKg2MkEAvgXGPtQhiU35/cn0bFRcXpU0sbiO0lNqQ5yXbUqGAoEvN8IQ+qvAaZWJZetPbJvu5Xa2oJW+G7ZqHX5Fs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G0i72UGr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kBoVBPQX; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G0i72UGr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kBoVBPQX"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1E7E91140087
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 06:31:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 06 Mar 2024 06:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709724701; x=1709811101; bh=n4amtdMpjF
	XUbqhAlpC7nT12kHAdrFTqr6WpcnrlAPU=; b=G0i72UGr2KWe/VxsPujhxZYD70
	PcycdC2VC8CDKOXpRL+l5mPGqYWJV16/dMmcSo7x0NbRsdN/7TJfeR9V/fSnWuPX
	HOIwsB4wTgV0UP4AMCDr47c5p8S8tEXTKKvfAqO6Y4TFY1PmYHQrZFcg/+BqZqi6
	aJNZ9vxqOFnylB7sMSQk4K/3X1BwAk7/KyHcBb+NU8Y/pUiLtiwbmbawGbQuBxrk
	xW2068zFfzps9RTNp/CxvtGOtXGwgHwZySniKUTQoOdcMfBnl4zqEWz5LDmB+aHI
	dVqC5fdO/YMix3YOIvuI+xeqhfkDMSJgQvNuzlr0HUlTQ6Kzq5NkA0RdQ0Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709724701; x=1709811101; bh=n4amtdMpjFXUbqhAlpC7nT12kHAd
	rFTqr6WpcnrlAPU=; b=kBoVBPQXVxMRECCZyEVaLnKZho/Pd4p3VHnsTO+xBB5Q
	93KqZRklsDYxEmGDuSoFCza9n2WplYbZbu4yvMxpw4F1L9sSznfAyaiQ3Nz5Alux
	YgfOuKYRqSf2VgUQHSk27R2q2sdgmv17wah2jRUCI6TVJJYqxL+iUyXG0xDhrj3+
	mZQ8PmZhAgztzysXxh5QcLijDslFwTgaHGwecOsQewFulGbgh8bsTv7fsKTP1CfL
	2xaussWDgtJwFdIxN/CEVFb4ukNprmrsS/OpjWKIeV5UH59B21oOGZg+BYYquqOP
	eH16U1Sa3PwFKGlSLse2N+t73c3MDoyxrchp18vd+w==
X-ME-Sender: <xms:HFToZSUMMud9Dj99q1cSwxigoVi_62ZfTr3bXkllhFpDZ0cKXWnEBA>
    <xme:HFToZemFSvcBMW4zvZPDcpyTrn__ttkbFTR6_m_A2PGbzCljRWclrgkJUUmgSRYnp
    0LcEHQidxhyq3LBSA>
X-ME-Received: <xmr:HFToZWayNrf1vnY4z50YfpvhuejVMf0sDi9mCYpXkMjZSc8e0Eh7mK1bP56ixh67Bjhe1gyKKPnL7TQBgsmKj0xEvv-C6C0fVXkyB8L7R32RgVGqVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:HFToZZUFfVWRe3HDCCA1UQPvT6D7PpbrQD9QQTwYGUrYh65FpEtdow>
    <xmx:HFToZckC31B2aZX80Wte5sU0Xbr2Y7hu4OHRVXYSZI5GZs-OcmXpjQ>
    <xmx:HFToZedhpyukUpMNpjzNaCWKUeu0Y_mIQt_j-CdLMrFEXnRtohXHJA>
    <xmx:HVToZYtOdSChLGNwLzB3aKM8SkuSwF1UsaMWdQp8seorVYeSYBYHeg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Mar 2024 06:31:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 53f4194d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Mar 2024 11:27:11 +0000 (UTC)
Date: Wed, 6 Mar 2024 12:31:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/8] builtin/config: move "fixed-value" option to correct
 group
Message-ID: <4c3655574ab7ef1eadf75aed883536204e542979.1709724089.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mY4siYNi5BP5v7gw"
Content-Disposition: inline
In-Reply-To: <cover.1709724089.git.ps@pks.im>


--mY4siYNi5BP5v7gw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `--fixed-value` option can be used to alter how the value-pattern
parameter is interpreted for the various submodes of git-config(1). But
while it is an option, it is currently listed as part of the submodes
group the command, which is wrong.

Move the option to the "Other" group, which hosts the various options
known to git-config(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 6eb6aff917..fcd6190f12 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -642,7 +642,6 @@ static struct option builtin_config_options[] =3D {
 	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name new-n=
ame"), ACTION_RENAME_SECTION),
 	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTI=
ON_REMOVE_SECTION),
 	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
-	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when com=
paring values to 'value-pattern'")),
 	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
 	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [de=
fault]"), ACTION_GET_COLOR),
 	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [s=
tdout-is-tty]"), ACTION_GET_COLORBOOL),
@@ -661,6 +660,7 @@ static struct option builtin_config_options[] =3D {
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file,=
 standard input, blob, command line)")),
 	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree=
, local, global, system, command)")),
 	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use=
 default value when missing entry")),
+	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when com=
paring values to 'value-pattern'")),
 	OPT_END(),
 };
=20
--=20
2.44.0


--mY4siYNi5BP5v7gw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXoVBkACgkQVbJhu7ck
PpTf4RAAnkl+S+jTFoCmqFChpIBK4AUMbB4NlhZYf2C7VIrGQpzgaqHJgOnpt57Y
NzvwTHAUD+wHJIjl6vOKs3f/W9Istf9Bor10+D5J0PVE6yD8qrumcr4XbwRIoYGa
+5Zdcfq3H6tjjOELZcnBWaUFaKjXJVcAI+st1LCfI5wQxnQJ4Jv3qpzpBTOpknlZ
dnXqPOa4eaBUobuVzOhwGQzz0UrCvQb2x5eNgGotRnajDDWo8xje7GI0d8AMrLC2
Y0vBbGenzxssoKI1VZA3liInHjq3FaRgG3NKUi87zcvSdm4aFfrYafKj58rMbqcc
08VDMlbQ846M/RYv+HqZv8LK18MCiJuKIrP9uYzqsohAJqaC/TOQ/VOrTNby+uZr
2UeQoNbLuxOTNbrA1FgeH/iNSAtsWL9SDuCO/EaBB+GYVZBf82ocZKhIuZXAmneN
7v+4qHjsDJEYGMpbNClzkKJLl9Ns7z0q/yy1Be+tWg3pDsF3fKKNtNKDYqSo4KN8
Qi4v8PQwuHBZW4570G3L/rh9T5kA3OSoMYyM7sYhV7BYl6WPdbfdSjnOTN+I5GfO
86/xMZt7yR0AIckW9vtpahNaAb2zHTK8qzoDI9Or7c7JjGeZ/28WE63IF5kjLIWK
UpP7Jw5ms8cThoOGUxsNtKubhG1AlnLH3zuIGEC02TWPeKDWp3M=
=fYN0
-----END PGP SIGNATURE-----

--mY4siYNi5BP5v7gw--
