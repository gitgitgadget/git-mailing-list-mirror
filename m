Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC4916D4F5
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340337; cv=none; b=BOVX+gwA9uqppo35nipDDrNDXaPH0SZVDh2qMwPoJhd8db9kl3gm0YHfFlJTcS5+VmcJLqo8n1ainLcjC9HPNYWov3lUUUFoTNZqWh7vZIdmi0rRSvPNEIlCxaCLbKH+VWrn+88yZI9sJJTsyMSXp+BfLY6YrYetS/L9J09IbRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340337; c=relaxed/simple;
	bh=oJW4IBk/8vtroidW/LyNmGuw/3vcqHnCJdgsuTeOaLg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcgSfsGwe3Uo1eRFvADu9udz2IxeXpp0hLMr1WTCM/qR97zEvQE1OGsMwIc4GYyS+ZjYRulgsuSYkTGqW/xIAGRNSTu+b5dUBObhY6sIWUA999I4kP8nAMvGZucHMdZFP8oxvNyruvAj21q4K+sIE0bqlfeCCTY/DKfxZvDgWPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gcRT3laM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jRoJ0EtS; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gcRT3laM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jRoJ0EtS"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9109618000A0
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:25:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 10 May 2024 07:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715340335; x=1715426735; bh=CVkmEFe2k4
	LwNCOx89OG2xwBR/SoQjmEb8RK7WMvn30=; b=gcRT3laM6ELlN7ildSlDltFhHv
	edk2ou6Tzt7det45kwBHmy36NNb6awY4Nk+99tlkFJZLvnVoWGiliubdgaQBH0ln
	MPeIvT5ivbWH5cJy+1B9AsU8kzu10N4xPPK8TjAH4lwjf+U9JgyzeI1tXCPCb8Ur
	pjv7ntADMqQrhlLh3fjzFzZM5ZTdzrXSispYBKG8PiBewB7isM9raAm2BSO/pC3S
	DMHGSGddbM7Y522Uyy5Ytjs8KqaoJCuxARBqTUCh3ZGXSjdmM4+lurCHBuc3wHRt
	8TJWUE4NYJ/1gu9slF2HYly+OMIMgmVHT9w9BSGbWtA7IYNSQmyBfyvGG7Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715340335; x=1715426735; bh=CVkmEFe2k4LwNCOx89OG2xwBR/So
	QjmEb8RK7WMvn30=; b=jRoJ0EtS72emfyG9JvZpH0BKylSByG7CtRGsqcb8QdDm
	0De7gnUsqLpRwfHJJqu/WJbx+LFrSpXOul/Y3bzPWb8AFCQJWuPeBrFVNa05823l
	BFT3e9oBCmmd8W2TVs8AlZScUd5kJbPS87zX/2BPSGS/RhF7R2iVyqzJOSymiKno
	WKW0CwqrPr4wKFKKDXqoJg3Aa8eONVDPeu3YqQFkhTf0Bvzg7kXgQMkX8+Tkjk5e
	SKwOQblvVMq6/dVVLebg26bwgajuyRki2VD9sLOdgRe+mC9PSUtprHPH2R/aDE0S
	WTCutpI7cfYGY69SpQJXHw86O9K5hO2D93zT2qCthw==
X-ME-Sender: <xms:LwQ-Zjan6UY4kzjUpBf4GlOsXRKVJbGH0i8q04i_S4L5dXkZrKYQBg>
    <xme:LwQ-ZibSdF9jiN-EBIIYPG02HyLz1ucns3e6Ff1cax4tc1aqKapalXehiHlmCR0nQ
    wnLcdIW-woU4yFuoQ>
X-ME-Received: <xmr:LwQ-Zl_28z9r7qwlcnlrxSY9X_kM9ql_lBAmZGV9c89S--MD737ULddGst92RcP9JYcAiYv4uFUIE7XvGA6kYOVLffDa5vext9UsEsUNMgpTWdgB2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:LwQ-ZpqssDBmYclQRej9J0QDwAb2iSJGqQ6PfvvJS0LcWmBOcuRtPw>
    <xmx:LwQ-Zuqdh1yRbdJgV_ixa-EEeip5fwuV-VtxUFDOdKZb_Gd5dLkHPw>
    <xmx:LwQ-ZvQUPT4wZCylJoQ_gn7HEzZOQSkoLEKc18vqRexWlt7O8PUH0A>
    <xmx:LwQ-Zmq1YryHbS6o4az6-KL9dotlOQqRYv9V3Azsj9cMXwT10VgyWA>
    <xmx:LwQ-ZjDxkrXuixOipwyJ-QjCG615ErwftraD6MS0xqwd64Ki82fjhidR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:25:34 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 56b98524 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:25:21 +0000 (UTC)
Date: Fri, 10 May 2024 13:25:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 14/21] builtin/config: convert `do_not_match` to a local
 variable
Message-ID: <2b40b784fe146b4d17de9accd4afc53144c93812.1715339393.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I05iqOPEagN4GaBK"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--I05iqOPEagN4GaBK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `do_not_match` variable is used by the `format_config()` callback as
an indicator whteher or not the passed regular expression is negated. It
is only ever set up by its only caller, `collect_config()` and can thus
easily be moved into the `collect_config_data` structure.

Do so to remove our reliance on global state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index d11d0b4784..9d5d8c8df3 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -128,7 +128,6 @@ static const char *value_pattern;
 static regex_t *regexp;
 static int use_key_regexp;
 static int do_all;
-static int do_not_match;
 static int fixed_value;
=20
 #define TYPE_BOOL		1
@@ -327,6 +326,7 @@ static int format_config(const struct config_display_op=
tions *opts,
 struct collect_config_data {
 	const struct config_display_options *display_opts;
 	struct strbuf_list *values;
+	int do_not_match;
 };
=20
 static int collect_config(const char *key_, const char *value_,
@@ -343,7 +343,7 @@ static int collect_config(const char *key_, const char =
*value_,
 	if (fixed_value && strcmp(value_pattern, (value_?value_:"")))
 		return 0;
 	if (regexp !=3D NULL &&
-	    (do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, 0)))
+	    (data->do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, =
0)))
 		return 0;
=20
 	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
@@ -400,7 +400,7 @@ static int get_value(const struct config_location_optio=
ns *opts,
 		value_pattern =3D regex_;
 	else if (regex_) {
 		if (regex_[0] =3D=3D '!') {
-			do_not_match =3D 1;
+			data.do_not_match =3D 1;
 			regex_++;
 		}
=20
--=20
2.45.GIT


--I05iqOPEagN4GaBK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+BCsACgkQVbJhu7ck
PpQt4A/+OEozgSPDlDnDk8+WOD4zXK54FONsRROLn2pK69EBLbFTw9zRgt85R5DF
3NMP56grHYkvGxQVI+kLdOQHwG6W/WN4uHEtUWGI2BW07C80BnFJidu505USXZOY
GuYCC7ppOEp3bbESt9UFZQtGgKsKrDMMUBqWTgkeq+43LY3/kpk6WPyoNr1YAHyf
FGJ9zKIva8jOce/R/xi7kLwSv+yKcRPS4iJjwvgvOovF7OaF1Nhuqg54QhNcHdD6
oneWhfnfz2MbkISgyeASetHkfGA/g2CkBD8snUTTadUnq38a0XyU4l2C+3vQdlSk
vI85/M5Re+jpDNhOWhg9cRLCX/YSxKhafa1RL0Z2GHLelHO2Iukrl43HNdrTnAPE
uPyiNyR8/BNh87E3NeRuzHJTq5oHr2qCkAyf2KhDdOL4d99E1jL3Decl6vF4Cqk3
dRNjQfvN8b1wKWlnZ7YvimCgNZStKHUzgRrd3pReDdt5Aw4+3ghNDJcZCVW0pU5q
UfqUfZu8E04NEdwXKSvzXB7t42jvvo4PKoiox5+JstDZZv+wFyCwf9e9Ri1Jxf+G
bSVBzFFwqexiF41HD9FdsNbZKOBsFAlcecxgCn+j07pxs/pQuG8jbt7IgOh67j1w
9lICussHHL95Q3LFAXEysF/8XQVJ+NWujB6a8Y+aSsOMg/SCb2k=
=Nilr
-----END PGP SIGNATURE-----

--I05iqOPEagN4GaBK--
