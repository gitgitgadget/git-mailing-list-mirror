Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEC916EBE5
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340348; cv=none; b=Kjd/HaNs3VLBnvxplS19Dm8neFlay+esOyn7/jLj4UQff1NEewbZ/+RQCbCmiIMDtpPHEJHkLLKOSfnXsVVh4EY/6a8JgEUsISl7Dg1hBTTP9BuvTnwUV0MdEKq27s3+NoqP8zpHjpsltLe0MLtywvVZq0JmDec/+fhMltTOkaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340348; c=relaxed/simple;
	bh=1wQ5a6WlQM2t4pIITRxvVtcSZcOQIZWRKmMDOSYMhEo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWijxAMnjPzs2mFlWlX5tZqyVGeBdagMEgsepc9gtguhdqBkv8VQDGtvGAZAJ2rhB+vbanG+LDy6i1nE+++MIFRLcMwaXlTQ288QwOmALylqMktpoBwGb3OS6O1a34bfjC5jmcrW/yN8R45bZtjmEsUmn0x3Whjf/qlFUqBtkNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fMrlZy6i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i2j4F0qS; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fMrlZy6i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i2j4F0qS"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id A5D701C000DC
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:25:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 10 May 2024 07:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715340345; x=1715426745; bh=ElsSeS7tx/
	+IlrLs8ftOttmQZbsSltgdQwZ4AIhMN6k=; b=fMrlZy6iGCo/aw5Jeaqs85rJbE
	454JMFkEdF0BuAtm4Pevl3tbeD6W6sCacF9cJR+oZaG9PTkqBbHqtrn6KgmFEGlr
	aT2ayP3E2Fjnxnnhs+sfXJF/Oc8Gis7zOjAOMzS+CuNZxscX1grMJ4TdmQqKs5TU
	2w5Gi2kpPX0rgD6cm3E/On7/UMcwyJ+Otv1uKVS5/DMMVDxyQfcu6LT3j8ZN4/ME
	HHjC8ZBCEwAMng3gDKNQKLultbI0xRaVSmBcEfaXaHzX5JFaPH50SlmGHX0V5EsF
	4hUj6rCSeD1SC6uESsi0iTVoD7bJotBhXCc0aM0PJo5uecu4c2E3ouCTZaHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715340345; x=1715426745; bh=ElsSeS7tx/+IlrLs8ftOttmQZbsS
	ltgdQwZ4AIhMN6k=; b=i2j4F0qSBT0RTtBXYcDJ79G3xugdtcGTBBJzfEkI8fXV
	G/TQGfIWhBGPFiudGzSCOZdvDcoOKbUweEWD0KGgFLI8u6Be9m5R2rzw7fe8A5Y7
	wcBbY4V/zk0ghYA0mqwt64tkyX+eMQA/M+LZDPWcK5e4CM5FuYZT9Xar8Y75ExOx
	G0k6js+d80OULI2nojeBAA1VWbPcxkZv2B6HtvmYs7oVqYW05ousJRkYJv61tDxy
	y30VZo0ce82UfN3+mzgO1PDjAfKZ10Khwo/BcIthjdhU9Y5Esj5JPMbQTMZ1PYxI
	QEvuE1UBhg9udv443fpYVRibLRXMstxGvaSWPLNB9w==
X-ME-Sender: <xms:OQQ-Zlh-t1TDrMZgfTnLlm_1wcXf6WyJpr3XZKTHHVnYCJ13KEHzPA>
    <xme:OQQ-ZqD3uf6ScglcKPUdUnfp7YhdEocVGeeaOGn1exisG2ymS04clRjTt3vDLsWCo
    9xdfJ1CiM8ha7BveA>
X-ME-Received: <xmr:OQQ-ZlGHiIh3arOefZ-CYLKCHu_VAM9L1eOjl_9XNweZ2_ghhgZUmKyngChWH6dtjonB_maaF4Eiz32gI20tnYXQ0IyMbbNiOk1Y5Ztj1K2TRQu0XA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:OQQ-ZqTPQw1vpEqjMBLJ-hN25f_q2Kb4QFaDC7BehMGg0lFn_G2ERg>
    <xmx:OQQ-ZiyF4HEXi-vm_OShtLNiOwPYGRQzU8asEl6O19P1PStLslbd_w>
    <xmx:OQQ-Zg7YtKFxikTvvbyeiu3H5i94obaJKEVcvFwxIRk6btVsTtEy-g>
    <xmx:OQQ-ZnwjohdivFmgkkwlPRuIpNkhAFHK2BI0Ct5FK6e08TMpRCnS4Q>
    <xmx:OQQ-Znqrv80I3Mt7EXh_VN3q82BR-DxYfQQbr-EdAmMC2esxZTuKXnle>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:25:44 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 00ecf814 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:25:31 +0000 (UTC)
Date: Fri, 10 May 2024 13:25:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 16/21] builtin/config: convert `regexp` to a local variable
Message-ID: <c3b340f1193fdf76064b6eec2e3bad591a709267.1715339393.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yeQL3bSKo4gtfCqE"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--yeQL3bSKo4gtfCqE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `regexp` variable is used by the `format_config()` callback when
`CONFIG_FLAGS_FIXED_VALUE` is not set. It is only ever set up by its
only caller, `collect_config()` and can thus easily be moved into the
`collect_config_data` structure.

Do so to remove our reliance on global state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index a681097fbd..fe15f1ee77 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -124,7 +124,6 @@ struct config_display_options {
=20
 static char *key;
 static regex_t *key_regexp;
-static regex_t *regexp;
 static int use_key_regexp;
 static int do_all;
 static int fixed_value;
@@ -326,6 +325,7 @@ struct collect_config_data {
 	const struct config_display_options *display_opts;
 	struct strbuf_list *values;
 	const char *value_pattern;
+	regex_t *regexp;
 	int do_not_match;
 };
=20
@@ -342,8 +342,8 @@ static int collect_config(const char *key_, const char =
*value_,
 		return 0;
 	if (fixed_value && strcmp(data->value_pattern, (value_?value_:"")))
 		return 0;
-	if (regexp !=3D NULL &&
-	    (data->do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, =
0)))
+	if (data->regexp &&
+	    (data->do_not_match ^ !!regexec(data->regexp, (value_?value_:""), 0, =
NULL, 0)))
 		return 0;
=20
 	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
@@ -404,10 +404,10 @@ static int get_value(const struct config_location_opt=
ions *opts,
 			regex_++;
 		}
=20
-		regexp =3D (regex_t*)xmalloc(sizeof(regex_t));
-		if (regcomp(regexp, regex_, REG_EXTENDED)) {
+		data.regexp =3D (regex_t*)xmalloc(sizeof(regex_t));
+		if (regcomp(data.regexp, regex_, REG_EXTENDED)) {
 			error(_("invalid pattern: %s"), regex_);
-			FREE_AND_NULL(regexp);
+			FREE_AND_NULL(data.regexp);
 			ret =3D CONFIG_INVALID_PATTERN;
 			goto free_strings;
 		}
@@ -447,9 +447,9 @@ static int get_value(const struct config_location_optio=
ns *opts,
 		regfree(key_regexp);
 		free(key_regexp);
 	}
-	if (regexp) {
-		regfree(regexp);
-		free(regexp);
+	if (data.regexp) {
+		regfree(data.regexp);
+		free(data.regexp);
 	}
=20
 	return ret;
--=20
2.45.GIT


--yeQL3bSKo4gtfCqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+BDQACgkQVbJhu7ck
PpRvnw//VgjLoXXlctTnxx6leBR33obnYx4j7NpT/3XNjtLwvWCDLc7oxfk4CChW
fPtdPX1q2KkfiF8No6IPdIYEQMLYFmPu2Gy4P+0t4aVuFsDd981SiiO6qs9FWUfz
609pkqCHXf13a5TrjCsPi4/DgO/tI7R/EKMvjhW77bX9LxZTYmqsW0j0+nJ+lhXw
e/N9BYDAbek04n4kdARa+2+OCTlEl+J9EteNd92UIQQjviYlEjwP2FfyLKkR3+/G
RCmutupX2sgfxU5CdI0qEFDfTJA6/P6cjiDdecrvcGUMst1t4CG00p+mVpAFF1e2
4MJuczDQ2ws4DXqu9FR/RFEOl/lx3EL/fKjnIGUswB2WsebDyNJOs78lZe6PpoHX
cW2+YGO71wjntKauotc3KGwf8Jd4YhiO6PhfZgQt6jy/PcKSVf/APLhJvBrdo2/M
qZMI/6Z5BQ4FpV7c3ZQd34zqXzsjkyAUPna9bnl+2VXAXgeDlnFmOW5rYsg+Ws5W
tE4hy15+nzhNQhQ/SaGUYwsih7sdgsmMVwIhpVIStwbw4ctkGcAuHSTLpasp7tDp
sGz9R2H8nRho/3UaY6dwy0urAqBkkbjY2AkqeeQDcP3oPKA4Xx8kSUYYg4fEEX3O
Ehp1W4u8QnpRMj1mShax+unAqWB8+W4NHHQcUmHTwGGVh5jnsmc=
=jrM6
-----END PGP SIGNATURE-----

--yeQL3bSKo4gtfCqE--
