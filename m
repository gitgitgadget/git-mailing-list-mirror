Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AEB16D4F5
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340343; cv=none; b=F6fYAUV5OKjmCN/sN1w4dcx7nxI+IhbiNzYtgZaTDVz4DiKi7zKjiRk17YqAByRkTIXBRaAcHoO50psxf0fQLU4Fg2NV3eCQMGqk7bbqXDzmpgxQJ9OP8ve774Xp6yNdF5p1dHhJv0fpDokOHhpiuA7o/ICAJjwKId6D7e54yow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340343; c=relaxed/simple;
	bh=WOzx43Kt2VW+H/Z+M7TwkH4TLR3OkzL+JwaiXEu81WU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9V6eZujmDfwsm/3c+g1GVvlkKl/TV3gL3ujEYpVN+w5fDkoIl47LVoHpnr37+hregKmY1RkyZI3p1sFno76tZCFbEeEUQozFdPH9TAvRCi79quPW/dRt/yvGBYd+0OlU4tisdVkwRCSnAI6r1mB+kDqyDcMbggjXzUP7Z3ye0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WrJbvh5h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CxNu6SId; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WrJbvh5h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CxNu6SId"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 28EF018000DF
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:25:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 10 May 2024 07:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715340339; x=1715426739; bh=pqro0FEtM8
	b6w30utlfdqlrWeK+fPv20cZ3dFLCyXfw=; b=WrJbvh5hDG92fkZvnqWwaKqUja
	/VrTMnOwdIM6DNEg7Saich4hkm2VuTrRRbq2L70kbKPVzaLfvHvrPNmEbHSay4gR
	W4FGaQwmMHp3BnWbdyUlT1XfLmhg5E6DKTmONJLj+ZJA/rjfIfWoBggoHsgdR8sa
	IfVY/1W8qFWSq3bZk3NUgqScfEQL7CrMvNdnwH699IRwYJnUg/P2uelja1pPrN6A
	hmANPswt5zmEPN/yWzobnrTWVRWc5CRVWZm/BcRQ6iWMG855SUaCJdvHeOZiUQc1
	/7XtAEgltQKP2ZiBp6fBeCv+2b1iKKCXErV6BsGjOUAub+hhCcJesHhCdzAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715340339; x=1715426739; bh=pqro0FEtM8b6w30utlfdqlrWeK+f
	Pv20cZ3dFLCyXfw=; b=CxNu6SIdtTHf6oLJFAkj1HGEBt9OK2zGGtIaocyb5cX5
	8Nn+x96Nh1NG1DBfEbQOhVFO9clRbJu1LsPDfJkqAcOMIKjLrVLjLSZ4eplXJSyY
	YP2xyBynGSEat58cc7g8AmRqv+CcJCXIc6wzbVznFvXvpsHltkQLoHKD60VsGAoR
	FcDD57Pgj0JJDW30KJhl//2lz43COWkRPOWvQloOlq162FqkIFklRvUZLTtTv5Fz
	ZbRxBkf97bDCKV42Uc4DgJxJLadfqfnN+1rve6gzHussBgO5qOaNsMDW5uFjl85s
	H2BBXnyJq4plQrlyIwl1bSp1bFumE/4ZNxJGCZRo5Q==
X-ME-Sender: <xms:MwQ-Zu7c7vlKWdtj1n3dbKKuiOiatX-vZf7TRxAAB_DSBxhahEGCug>
    <xme:MwQ-Zn4BkFzJuLnrPvH20EVDiwFbZD0-m9HNHj42N80mYTlN_uCgiinuevUdzMCK6
    MzeiCWauPW_fCsQ_Q>
X-ME-Received: <xmr:MwQ-ZtcuMGZqj4n89NBs0_aNzMf6vfDJyeq-di5nj1yAXsSlvB4R3wy_aQ7ULFH3X38WPoHMprJmtkbBHeV3nJfa9MowpXGc4A0hoB3uxFKwDcKACA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:MwQ-ZrKHsLFKWAXcWNTGQaqGiNGry2DlAwDuL_FZnyNuStkpun79rw>
    <xmx:MwQ-ZiJ3b_ImyITRjSEtGM0bp8H2sULIHmDT8EJrzPcCbEmjxQP9RA>
    <xmx:MwQ-ZszhvC63jFEa2W0BwmXsuJZECeI_G5pq_elftFrnBkYqDSzgjQ>
    <xmx:MwQ-ZmL99hs3xhIWR__YtNpTatlenjbPXzcb-0MEwH3pbfaPrl9n9w>
    <xmx:MwQ-ZkgXGtI9xExtvvlqyGKeP6YxSpCNjD0EnMfl33c6cLLAQJBdTSjE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:25:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id df4bbd69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:25:26 +0000 (UTC)
Date: Fri, 10 May 2024 13:25:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 15/21] builtin/config: convert `value_pattern` to a local
 variable
Message-ID: <71d1b7a51b0908c50661b975677061b8121b92cc.1715339393.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5W/hBZ2AG5D2kzCX"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--5W/hBZ2AG5D2kzCX
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
index 9d5d8c8df3..a681097fbd 100644
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


--5W/hBZ2AG5D2kzCX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+BDAACgkQVbJhu7ck
PpQXLA//cibijCPn/pHZxogkyxLaO5ki9LhDGMWiphgfDGGGyOBf3Q5J98c1wWjL
WTAzBKO8yMpnuph85Cb5MWJwiqekRiJtg7gHFOd9Ep4uHRaTjYni/MJ5bxvY/FU+
mf+pq2Ur2YLBo1p/otEH/vtlQG8AkYoGRGo+OzQaG10ytrBNM7chNWVcY4XkJT9C
jfLEpnXkO0eMyzbVE+HUtt2jG/4Z8P6TjbvP4TwGDLmpeiF4+F4VHCWtvDQ5znFu
YOs9H7NUJ0d82+tcg1RZgGHsAhF9YxBEqQwct/VVzyZXxLOiiqlkbLBR2FAgla89
WItAb47I/XBzIty5wyZBpI6iVtm13I5Uy3GkY20MBt+fWc93mjwbPup312Rb0e1W
PQRPJMmouiVe124xC0yxayEA+sFG0jvWMzNXEjQhuT/JvDdvMRLMbk1I16xVxN+z
1/Yswhm0F1NAFbBa18nZ3jTlGnyWmr3jQcYufJsb/sAlDAPEW71lcLDQUtfHZR3K
22WeJMuVSRHqeF+q8eecFvM2i6CNShqdZ7Vs4oDTLVD2iYDe9njyNh08KKV0UN9B
Qkm9QAEI6pCG5Yo53YNEX0InCwa7MYc4jzhqI0Q++cEPpePBxySWnxiloGRWXIEX
84v1r5bb53tFfij1BM4UkDESWKaymBef0r1tG10YTYuq8iAyd8Y=
=ac4s
-----END PGP SIGNATURE-----

--5W/hBZ2AG5D2kzCX--
