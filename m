Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A935F1649CF
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340357; cv=none; b=bvMTSRR2pPNAaDSp5QCO9P+URbTMfZ0nZ5p9gR1ynFfiTA4VXX2jrMtUxYIuQrqhfrtfgnUz0BLoxtTDd53j1SME/6gCD25jKBm7Zmn/zdf+CfRJ8N1yHB75U9JItqjkI4BwRyWi3jjwoEcErYItNQeCTR2dvQD35I556iPIgik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340357; c=relaxed/simple;
	bh=GA/Ee83BqxQuz8MQhk7szPhgA6Ucg4Y4wgBmL6q+ciE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V86qUWp2j8ChI+EK26DcwfASk1IuNucZ4pDjAAN2vVTCuZIMISmu9xHy7KxTTvpBNlBpoNur+MgS2jTP2WadEN5pvonoQxoyILqFeW5C2Bi9XZreUrbP9LHbg2QSDKUX5aET/t7RUA43RbOYV8GwL8DjKUrhTv7T00zCsfHsb2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G+gljhY3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ChagHVKz; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G+gljhY3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ChagHVKz"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id EB71C1C000CF
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:25:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 May 2024 07:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715340354; x=1715426754; bh=0YGWgtM8H4
	/43lxYIp2kZ41P6JvoBhXTnbcUJ2baMGw=; b=G+gljhY36tmjsWLFq7C7c7R7SO
	Ek5dgg9OWFGECVGnZiny1NOczh1fTL9EXGVOkiTb1GEyhhIlLlXQOAAlxvaMXn1K
	Bw/WBWSjRMJcU9U0AwAsgk+lDzSU7UFqqteUC6q5mv7hzC+u5N041zn4FKy7rcf+
	PUA9yXjuQfF8IxB/me5wUUsSzPvUr+C052dv1I2TP+hBvFZkwSd5AZ8yiFPACjV9
	Zzvk0qPn/zwN74T0jUdW6Ajq5YS/BSGXhkXC5qkA0c1yFPtbizjwVmgz4YQZgvDc
	DshYhMyatuk+D7ruyafTDfvcncoi3hVcdIy03wQiQvLTAJXsYQMsXdow74KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715340354; x=1715426754; bh=0YGWgtM8H4/43lxYIp2kZ41P6Jvo
	BhXTnbcUJ2baMGw=; b=ChagHVKzyXY0mrIgs+Z9bpPs/70cEYeBH0fD1vxnE8rQ
	3dmKfRUclPW4qLGo3pI0kZWJJyYHcrzJVqYlhZT+SWda6xRIrIlP2/MVk5vQ4pYJ
	UjMIk6p+IOUX5NVn1NmiKFrjvyNGIIsS+moVSBoW7FwV3PwqyItb5dSDSpZeIpFO
	piTr0G/6kv8n9Dm8bhNVfQpxShu/apr6WT0tIy34OKCMZDfkzNSODFsvfVlr8lL0
	GNTzllMq9PHU8R1KmaNCbhd2ImY8tDRvvJMDDK5wyKqKgwhpfvMl4/ukkKGVUIP/
	0z8PYlYKa2BkTfXtsuPHBO5x81LC8ZoiGXMRj5HRmQ==
X-ME-Sender: <xms:QgQ-Zsz0MEbEKDSjSafcW_IfHxMQHvW7kGAcv3Gwh1sbH2o9w70KZw>
    <xme:QgQ-ZgSfzbr3w8H6s5LtqHCfRGaNJ_ZG4LraiJc0yzKTNmQ3TJ6VpMFCsVAudQ0pV
    kPN6JKoitbRckZoww>
X-ME-Received: <xmr:QgQ-ZuWkek1cKoH_XbEEZuqiTcdaV4LSJ5n7_p_uHnsNnc3Kp7fdFa8R30Xq7Z8tUnokU0ICKuSVA1EZGGAYE9PBsNt4BC_9iBOMW1bYyrCvmWO2ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:QgQ-ZqhfXQsdXNZuB-i87F246qlk7nehvsutavHqjQBegexMydNQiA>
    <xmx:QgQ-ZuBu1tWs6gUUAMToLKYRgjA0xhuANrUa-HTnF4sMNfXJYkQGZw>
    <xmx:QgQ-ZrIRUasZ-MYJpkr4k42HAttgNOdLbrLlvvOfWksdu6BC3jOrww>
    <xmx:QgQ-ZlAGIOZQ6oEPaMTI5c7034_perg0CeIoMQCGO6CXYmHVC9saMQ>
    <xmx:QgQ-Zv63Ebyg5ScXqC40oeOs1_JoXUXcWi56Air93JWoiVKxxMUBl_w->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:25:53 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2d81fba0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:25:41 +0000 (UTC)
Date: Fri, 10 May 2024 13:25:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 18/21] builtin/config: convert `key` to a local variable
Message-ID: <2aee7ec5d8dcd301decec75c6d0fd49da700ac3a.1715339393.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UOckSJO2m+z4MPOr"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--UOckSJO2m+z4MPOr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `key` variable is used by the `get_value()` function for two
purposes:

  - It is used to store the result of `git_config_parse_key()`, which si
    then passed on to `collect_config()`.

  - It is used as a store to convert the provided key to an
    all-lowercase key when `use_key_regexp` is set.

Both of these cases don't warrant a global variable at all. In the
former case we can pass the key via `struct collect_config_data`. And in
the latter case we really only want to have it as a temporary local
variable such that we can free associated memory.

Refactor the code accordingly to reduce our reliance on global state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 1c6d9c734c..8cedf67a4f 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -122,7 +122,6 @@ struct config_display_options {
 	.key_delim =3D ' ', \
 }
=20
-static char *key;
 static int use_key_regexp;
 static int do_all;
 static int fixed_value;
@@ -324,6 +323,7 @@ struct collect_config_data {
 	const struct config_display_options *display_opts;
 	struct strbuf_list *values;
 	const char *value_pattern;
+	const char *key;
 	regex_t *regexp;
 	regex_t *key_regexp;
 	int do_not_match;
@@ -336,7 +336,7 @@ static int collect_config(const char *key_, const char =
*value_,
 	struct strbuf_list *values =3D data->values;
 	const struct key_value_info *kvi =3D ctx->kvi;
=20
-	if (!use_key_regexp && strcmp(key_, key))
+	if (!use_key_regexp && strcmp(key_, data->key))
 		return 0;
 	if (use_key_regexp && regexec(data->key_regexp, key_, 0, NULL, 0))
 		return 0;
@@ -363,6 +363,7 @@ static int get_value(const struct config_location_optio=
ns *opts,
 		.display_opts =3D display_opts,
 		.values =3D &values,
 	};
+	char *key =3D NULL;
 	int i;
=20
 	if (use_key_regexp) {
@@ -394,6 +395,8 @@ static int get_value(const struct config_location_optio=
ns *opts,
 			ret =3D CONFIG_INVALID_KEY;
 			goto free_strings;
 		}
+
+		data.key =3D key;
 	}
=20
 	if (regex_ && (flags & CONFIG_FLAGS_FIXED_VALUE))
--=20
2.45.GIT


--UOckSJO2m+z4MPOr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+BD8ACgkQVbJhu7ck
PpRddQ/+JQUUlSazdJum/pVAx9lUIgZmWqkg7f08Ngqtd1L+mSe2DiZuaL/FjDAJ
CO7W2eP9aQFQEpBcwPCpaVaHzyWRDGi9y7h1FGJND1pbHNhWAzlZxyCLvBDauN3U
Vld8+XbAJW2ynmo7hHPlg2EAHF7k/3IvrWwljwI4f0pXfnTwOGwETFChHhp5sYJI
Cx6YTUrWEW+vC7+0af+We8bkkxGiPdpPcOSCdsIAA49gN9H7jCefpOEx6OkgkzM/
yRD887PvavcERkqmhP0ShPMABiGVTynmgo8gRYePJeqv3+EoAjf5L/pe29UtNiBN
tyyNximiICKYMIPO3OLvIOCTSaP6/daURswA4P1JvSS1fLjuYy6X48UPMupbO/ya
8e69leTHkl0paYMFjEh1fURLa5oYT2Tx20fFqJNCvB9Lkj5STnfG3yBLytTYaf/9
cU9E75sdYVn2XEDjA+1HCFq6R0YW7WIiAlYa3FgWQoOTr/PVNrGnZp8nSnt02oxk
MK0Ix2pKvwLmfAg2MDvWGyz8J79Q2zc12kKVB2gxLNU/0w/DrEfUldJM9kGXO5Dd
K4N2U6cStg/O5+0yovOSqnVGJhyvS1ubAqX5tP7G3D+o72KaPupj8z84XkDsxbeK
BTwkU7XwO6doX//DBTWUQwTk7QeA98rMB+UocmYikR8tDOguJe8=
=13be
-----END PGP SIGNATURE-----

--UOckSJO2m+z4MPOr--
