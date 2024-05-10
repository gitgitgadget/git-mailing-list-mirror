Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D36D17279C
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340352; cv=none; b=uYmKVKxRdCrWBA7JQFq3asbG84t0Fh8wcTker5lBwWzW2v7n3RxqPZy2vRnJq/azSvPRBbqLvQEMQTYFtiMzXJQ1c/62e2RlrItH/MPM3dp5tuFyXicrWUBUpTd1GrafRt2pWenN6Pbaau08MGrWhre85AYI94iQVI1WOMXqsRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340352; c=relaxed/simple;
	bh=XD0k1450NI4viBqvOBt9R1Vgu1uL6MVaWkf4XIdPFoM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojC1XAmkMIkypHRjlW292qp07s8hEj15U9oBjeSK+bArJvWbh8szvLJ7QoquS/RaI9K/xxOGz54mK3pphllme1BjmYovNO8TQhiZNA+5z4KuqCeQkPEi4f9g8JrYnF0bMykFL+AQFOW7AG6oixsfjJhBUlWEyiV53CdFo1t2yiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hZJnf716; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MwMyD1Q6; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hZJnf716";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MwMyD1Q6"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 739871C000DC
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:25:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 10 May 2024 07:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715340350; x=1715426750; bh=8NhkNZwg91
	K2J17hUhPUN1bH8yCmiFMmE+y8HJJi9vQ=; b=hZJnf716aT6atLWnzJ7zS/jmMR
	8OUPwHTGDqB1eTn+FYhSgcQtBI+/ZaDoeuF/8azSO2zLesKR7YrN8PkA2dSaO4SB
	LdFmX2ZqJnk8FRrmwV2woPDcibNupOTboyQ0Mbc7hwMX2LkQ5FaPplvmndiLqeq2
	8x/QhdF+BP71Xl5Iq+iIZt08jjWCOgT3z/+AGQNGoEDZL/OECYFil8vrGs1SP1dD
	L7b0LvmavYWqXVcebyWqR/16+S3u5eRkv9iHa836aitAlA+cb/dnaACdE1mi+00b
	6LjMT5KzDwW12d9jvlu3ctWhbkCI9bJtCJ7hyQLDpPkkMK74okyre0soEs/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715340350; x=1715426750; bh=8NhkNZwg91K2J17hUhPUN1bH8yCm
	iFMmE+y8HJJi9vQ=; b=MwMyD1Q6gGWWZFIhHJ9tldfeSj1vrFYxjKlZ9Py8H0Fw
	vdIvVf/agT08KHzfqWtd9LeiV3eheIt7kNAvLoaQU1S/gfkccn3Uc1A2gaaRTdD4
	v26hAgyK0SBcH0nwpHPsILHwiIIBrng13BmEnMK4kaS8F+IXUbNvAwDlbWzpH7yc
	wS9xvz31Avsna2jtXJ9P7B6vsvlM6noW79inLec/rc1YyPBBBvSwHjKZ2eFtS+zD
	+EZAyPTe/Dv1CZ1qBAFf/qoI2ehTHkSRafOdSgaRx6yQPZDbnfMzCTMTwC4+nUlD
	PvNvY7nY2toOJT1cmc63h4QvaaFrV/OlQvSxazocAw==
X-ME-Sender: <xms:PQQ-ZsaXI-wgJfuakPjPMGvupo9wNyvTHcEkOUj4JCMD5phcCO62-g>
    <xme:PQQ-ZnafAWyfciB--WqBMwRFF8jPOILd083ArtnG0393mwnV6QvnrCsiPgAEDpfuj
    04jkZICz3NNj95WKw>
X-ME-Received: <xmr:PQQ-Zm9BHb6fFjyStSEObSwIlRAlxasHI0DmM3eTCJpyqnqoHqBpxMXh-qb_QYT3xwvd5ToSV-fJ831ajXCDaizVltoHPMvzBog8g4xxAUGERZWsgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:PQQ-ZmoCdhS4Ql8vnY4e3Aptz3m8PFhR95bv6Vi4D8xqV7QO8FoARA>
    <xmx:PQQ-ZnoHZh4oEhN4cnPcenb8bpJwRU1r1UHUSeH3IbxknOwZOTWcUQ>
    <xmx:PQQ-ZkRnh83_Gx6GpA9_HcKFP7yr7gkxU6P-z887E_D4swueCY2b7g>
    <xmx:PQQ-Znqhu8Z8VkfkUR7OUWvkogVHdPhkEtVkxURNIRzkzMaCSuuzWA>
    <xmx:PgQ-ZgAxXzl0qrAanICJfQGruzKlh01mE8XgchTecruXzB4DHl584D8q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:25:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 54a46c09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:25:36 +0000 (UTC)
Date: Fri, 10 May 2024 13:25:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 17/21] builtin/config: convert `key_regexp` to a local
 variable
Message-ID: <835cc0acfb2bf027f67edb1ea537674f5236f453.1715339393.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1W6YiFQTdHWO+AzQ"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--1W6YiFQTdHWO+AzQ
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
index fe15f1ee77..1c6d9c734c 100644
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


--1W6YiFQTdHWO+AzQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+BDkACgkQVbJhu7ck
PpT95A/+JCMK6mMoe50S40QVX/YFG7fc8TmIDZW32TCw0tqVdFI02nNtDtH7+VH6
2vmm1iLCwqDNYNHOTqdS/p+YRVCWuP876LS3UUNp3vXBQUL8yNZ2hCQ+b0vFadVS
cyyltVt9I5TtMKBP7wAYcopkHDdVxnOLhhUDHlIRb1RPxR98kWuH+cIDUYg/pgB1
nOdIES1urRwUXckur7xnCha2+9aR46n4dGlZuN7IRk+g6YqcUKuYPsZTB747J5CL
IUdl1nUO7+S5yN8Ff3xjK3AMId/6JMLu99rnJl8sfOOvfKWlAnvx6BfSC6CZGXvQ
pshWps0nHxaTEY6ryvPatYf0JIWYUiDFB3t9NDSXKD3rvPIXn3l4meMYTtqfQxQ1
SGgZyf3m8Q8wkrPs/B+cASBMfdpJ5pj5qAyxWiCvcfEuk4mcnVNrKkuQC+Qtl2Lb
49oPem7+uMIzC5NQRYXn/rhgE613lu+Pteiuxoe/Zdp4qsE+OFj2stSVByARQiq+
06v6GwxoZUu11gDQXyvDGuVKJabtHlXXCG+Ce97HMdx1XxynrDPY2c7+4tGsnlbe
9vImTVC0rJ+FhqSzZuPwW+XPk3GUUvsfnTfZNArlvrt4Tkz5Ko1wsZOfVsQnF7Rn
WRRqe1GKZGILiO5v13mBdg9cM7yc6N6Kn0zHf87jjAUgPXYKfx8=
=wP5m
-----END PGP SIGNATURE-----

--1W6YiFQTdHWO+AzQ--
