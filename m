Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A853C146D76
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595813; cv=none; b=LlWIjvEb12cBw4h2FWvrYxtlJY9aTWnlb1GC+g6HVOcbfQDqaoFEL8bGj16Qht6yzY1xryftImLM1tTwt/oR7tEWed+S0nA7rFgU0eisV6CRme4wAdatDisl1SDCbQT4JoJHLSsYY3aMPh97kEh+wqOD9SN/+18pgdP+YxLj7c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595813; c=relaxed/simple;
	bh=hzgHBq1lGVSSVeXTLpuQ3gxY6Zh2fsi0IGBHgkZwWgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEBbg0P+GhwzM/KBCfW/WqiY15rcIVCzsOjUDS5TTOa03kYrgSU5UgDCCDbSklKOzzRveeKLgjsSvaA8g+TV8tg7DdhWa7qUHf6+Fu2U4ELHCMjS/XiWZMUFBWBL5Uhrz4SMbI7tUcUNNbBAy45liCSd8w3F5dVmOTyXYRYTMvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I7GiUZdq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WXfp/ToT; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I7GiUZdq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WXfp/ToT"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id CD5AE1800076;
	Mon, 13 May 2024 06:23:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 13 May 2024 06:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595809; x=1715682209; bh=egk5idBIGj
	BYPeIEuY2aOraKBh1dCHvVf6eqwf3v6SM=; b=I7GiUZdqVXYkhd6w/g2e6jFXep
	Qq/Rk1uOOtnxtkJ8Ka04OxNFt1xlaBnFiKzBPtO6v2BMU3cfRmeM/Ed0S+iAr7B7
	N7124PghGfmi6LayTk6q9wlpGIfME8AJhni7z8SgIO2rPTxnbtXOrNqqeXbzXZWG
	/YO9ZdHoLM/q8LqeO8lIgyckVFJmzSK+eYObCYgK3pjBbknvgYMYRzAHbszgLo/y
	3S6swMuxmk9gdM+YiMrLtG+A+p00nrDB+g+oNxv2sN65jk9Yr4T0dWBm32TtybWW
	GrXzA7cjzR98sYBdBX5PCkSUfrdLTyS4gpOuqFDCiMR7ZOS3lVvLPcIVoOpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595809; x=1715682209; bh=egk5idBIGjBYPeIEuY2aOraKBh1d
	CHvVf6eqwf3v6SM=; b=WXfp/ToTcgWPbVOXvw8p6S530hoUEaMPf7QnrOZvVSRG
	/jGueZQ19AZwTKltNdY9oKdmGD1gfFOGKnp5WqxdiaeXNafS4lLvph3M+vNUIH/t
	2Ub6VshVjRWhC73Vl2ZOE1mbdW2vPKAJtnnNbhOHknyV+6pns72xa+nRjQlxJ9kk
	m/j8oiQglhGKU5EBvWHiIERqjF5f/c0vHuBokGuYRLdJAMdEYQqCBkQoZ56+o0ww
	sgjtjsK2zhDG/MH6Al2RrZgyWTlf6NSZkgt7tGoQ/AV4PZVstfOG6gYdkYYeuGb2
	+NTJJLq6FSSyDiH2/MC89p54/Ckol1S4ValMwzDs6g==
X-ME-Sender: <xms:IepBZhahTevDfl-YDSOOA3huUOCWhhvAiP16JdKOhF9QE54KLejobQ>
    <xme:IepBZoZ2Bcvg-OGlLCMW-BK36BWaenIM5KinceDCMP7z5v8qz6EJGq4HjFc-V4zn4
    UIqTkf4S4ka3DHJcw>
X-ME-Received: <xmr:IepBZj8zuMgS5kqK7PLwuX25XjgnpnkGgqGHFq9p8Tim-pq_y2lMF6eHl1bYHP7r1Ry79FHdZSaEZazPHgeMGf7vLf192Q_LVhjQZ37HmEk9ydc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:IepBZvrXbxlz3h2NAG5PNwvHz2AKz4GcOLj_Zis9VK2fjN5718azyw>
    <xmx:IepBZspVZXNYmg-tqlAN7xU65RVo0_8Gr3YEgR_05HSt5ZeI5U8wdw>
    <xmx:IepBZlSfV_Auh_ZnYuN6TjTTF6naAdKu-339gKap_Rg5FyPVUyTrOQ>
    <xmx:IepBZkrggTrgBIwzhCVpCTNchEqhzlnCpvWW80F-RoK6ckWVTru9kg>
    <xmx:IepBZllur-q2Y7cByUBrhq2Q-pndHrGB2NxsmKcIm4m8V_vANTHX6pj3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:23:28 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e0ace114 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:23:09 +0000 (UTC)
Date: Mon, 13 May 2024 12:23:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 17/21] builtin/config: convert `key_regexp` to a local
 variable
Message-ID: <323cb051205fdde86eb3e996d0a9fc089780eaee.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8x1K+K5AD4vdicUd"
Content-Disposition: inline
In-Reply-To: <cover.1715595550.git.ps@pks.im>


--8x1K+K5AD4vdicUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `key_regexp` variable is used by the `format_config()` callback when
`use_key_regexp` is set. It is only ever set up by its only caller,
`collect_config()` and can thus easily be moved into the
`collect_config_data` structure.

Do so to remove our reliance on global state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 1909de22fc..8fc9ee20a3 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -123,7 +123,6 @@ struct config_display_options {
 }
=20
 static char *key;
-static regex_t *key_regexp;
 static int use_key_regexp;
 static int do_all;
 static int fixed_value;
@@ -326,6 +325,7 @@ struct collect_config_data {
 	struct strbuf_list *values;
 	const char *value_pattern;
 	regex_t *regexp;
+	regex_t *key_regexp;
 	int do_not_match;
 };
=20
@@ -338,7 +338,7 @@ static int collect_config(const char *key_, const char =
*value_,
=20
 	if (!use_key_regexp && strcmp(key_, key))
 		return 0;
-	if (use_key_regexp && regexec(key_regexp, key_, 0, NULL, 0))
+	if (use_key_regexp && regexec(data->key_regexp, key_, 0, NULL, 0))
 		return 0;
 	if (fixed_value && strcmp(data->value_pattern, (value_?value_:"")))
 		return 0;
@@ -382,10 +382,10 @@ static int get_value(const struct config_location_opt=
ions *opts,
 		for (tl =3D key; *tl && *tl !=3D '.'; tl++)
 			*tl =3D tolower(*tl);
=20
-		key_regexp =3D (regex_t*)xmalloc(sizeof(regex_t));
-		if (regcomp(key_regexp, key, REG_EXTENDED)) {
+		data.key_regexp =3D (regex_t*)xmalloc(sizeof(regex_t));
+		if (regcomp(data.key_regexp, key, REG_EXTENDED)) {
 			error(_("invalid key pattern: %s"), key_);
-			FREE_AND_NULL(key_regexp);
+			FREE_AND_NULL(data.key_regexp);
 			ret =3D CONFIG_INVALID_PATTERN;
 			goto free_strings;
 		}
@@ -443,9 +443,9 @@ static int get_value(const struct config_location_optio=
ns *opts,
=20
 free_strings:
 	free(key);
-	if (key_regexp) {
-		regfree(key_regexp);
-		free(key_regexp);
+	if (data.key_regexp) {
+		regfree(data.key_regexp);
+		free(data.key_regexp);
 	}
 	if (data.regexp) {
 		regfree(data.regexp);
--=20
2.45.GIT


--8x1K+K5AD4vdicUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6hwACgkQVbJhu7ck
PpQhbxAArnB8ADmhJcSjMBwQGfTOVdM60kFYc660E1EHp6N8wr/ymTK8aRsC/sNm
v4+i8WHr851XjcIHRcnK/N/GvZOsnJ0/hNXoxk9uShkwMqnycz9wgkbvlgkWVAXZ
lV1upygvjI2YIB7nNAB4F8BXaOMhGqcj3HEdRbAiTbantFtvRaKW6EEQ10XrQqTR
L9BjIHqpvOhUfPg+Ojn7NXS/G4FmydUDaQ4KSGDK3mEFNxZ9lzcoqFmGjj8kdjgX
ez3U7ombdzVA/iOmLDRCbSYvz52smQGcPBs3tqrzckYe0qsdvXY2Qus2QVf84fW3
B/dn7Ffh2/wJUwdoGl6/domhi3dGZglDRNjbC5KkFIQi8rD79qaWo9cQ/I7WIQ0s
FA6oWcAYMYoTtLwaR6L1ZVR6OTt5216+cNmUBnydDkC2wSTwQuOZ8AEyneOu35kh
ABxt00tzG9bB2d0PizR75KRcbNfLL4OJutc8GXSxyrIRKlo6akMcBJZpGAyO1EPW
Ni57bVrUHsPoGQpkUoCQZbkusZiMUTNia+bMZsHv+Y7sPOgNS8KThjZjWonhyPrx
DLvpk4W6A9BLdEipwz9AqTXiFheRZoc0/tmSvJqru0Wxs/QLambEOnwif98Vz5n5
rraKcCpWZx2XIRJfq2zYuWcAQo3e3f+LwDgWfpbiBh+/E4+vA1M=
=Fjfa
-----END PGP SIGNATURE-----

--8x1K+K5AD4vdicUd--
