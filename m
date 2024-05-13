Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAE014A0A5
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595739; cv=none; b=FZIKKt0IY9NQB6tvEeY9htLE1iSJBB9jdsVO3skQhsD0sFLGq00IPQ8uzuZJVjMRnY3gdQHff2V1QifTuQdZhXvqLxiNukkn4mec0MPlq4b/5aPfZ56HcdKxfQjvPXSm5/HAhcVodYgOlfZ9GazgCNDNE7X5gWEbnvIUD/RKe9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595739; c=relaxed/simple;
	bh=0uc9Dl2Fhc+gXsh6eXDbLK3J2kdivZRjnqlT1uJroF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEj8rBkW2soo41raq8XmzJg92xjmOTBR597eS/uKxHiwFMfWDFrhkvYz5VB0k5ZzPzVDtV9A3oc7UUF/yHKQrbyttOSP4jHjcgMs63ZZGVWuqDi51FyawJcf536mOWHV69bIBtKlZbZoHQG7j/NPzS85QkMo8o0L0rmQ7Rxltn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r3EzAKub; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=baYKrs/2; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r3EzAKub";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="baYKrs/2"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 15EBC180012E;
	Mon, 13 May 2024 06:22:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 13 May 2024 06:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595736; x=1715682136; bh=PL0eWXUMXG
	Cgr9fZvoz2FcczpORjOYge/LsL130dPbc=; b=r3EzAKubPNHYIMcrtcD9qbfq4e
	VS8cN4A0WbHZvDvY5bkOyhA7Cwxi2wtMp/C+29p3KLBCJg3o+Aw8qaJsNKHqrb05
	CoOh6xtuc0q8oKWe1Vi0To8WqU6125t41623emUtT6tEweMiYQUXHg8szHxKs2Om
	PvVOfxSFYVJEDnAjpSxBt9J0Mc7gDnLCexp7mRgXNANHwDZ7jXpYH9MO2JaDBa8c
	ZVTGpXxmpuhWAJKb91Wh/WfW9xfBEUk03epK5/DEYcrjxGyT8ZuNEYS6xlagFck0
	Yiy69+LVT8qjhG91pUF4lXO2loKrc1EE1/gxL8EN7xoXlkF+WAicvula3C2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595736; x=1715682136; bh=PL0eWXUMXGCgr9fZvoz2FcczpORj
	OYge/LsL130dPbc=; b=baYKrs/2v3r7K+jnw36l1cs0aJ5WfBzpTCtUtrC8+Z3v
	iSG6nIT8f/bQOcvi9krcSi0CrFOXT4WeTHPLZvezjEuiUfYw6fbXMxyb5LARMVqo
	w1jO9WMkxbjhvHMFyCuIrxMiZPLGfrFRmnOLMqCHiuJPa9EYEQ7D3PDKO9IwfOHG
	3a8y6HqcJFGo1sn/Bok+eMQ7kyP6TIyudl468HWl3QuW1n/48imuClZwer/G7Htq
	3g9LlxXcbytcB9x7iBNdqY06GtVc55+Efb5V/xnD+ROoxjsmOiquwspxYFAZ3+EU
	5G/2UbKeDVqFARkBKEY/Xr7V+WWePf3gaO3x3AA2iw==
X-ME-Sender: <xms:2OlBZmPhjdr4bMiSNOU4JDzWe6wyEZlYq4iRlE-kKJ7oY2LvKlB_Ag>
    <xme:2OlBZk8FInARjNN1xVCbncIEoq0d9LGIACE9NkY3SjZj7Eyf-qI0uf3_zB5f_dPql
    WPGc8DbnKnF0DVpAA>
X-ME-Received: <xmr:2OlBZtSUda37QpRy1x2mSh9o36NtUkLr6J_8dhX8OY4wcsSYAmci4qVrD9QSc-oDe0b-0TIyi1KNu8eUUqjhqg_YPWxQG9abAOiIPirdNveWQm0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:2OlBZmtCGs8HjV8kZXTFlNevS_nPyHu3EYylXZ0jKZ-WXS8RFQlU3w>
    <xmx:2OlBZuctwgbWk3X5XCQCRQS0qbmEiOBg7ZAKynloFYaahl0DTjhX1Q>
    <xmx:2OlBZq2xxXlMSJ3O6PwHYl8rPFGq8EO_lT3mYH6EP4kikjA5gDfi8g>
    <xmx:2OlBZi-m57r33TfUuQ5xv7Tyjk5-sqUn5a-mLCzo1zE6ivPbmG1Y3Q>
    <xmx:2OlBZt4r0IL9fki9kZkOiNyxagoSlHwfcz2QLc15K-HrXtPzKZu3lXtJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:22:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0621c4eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:21:56 +0000 (UTC)
Date: Mon, 13 May 2024 12:22:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 03/21] builtin/config: move subcommand options into
 `cmd_config()`
Message-ID: <1239c151d08448f5782cdd12c5cf10fd5d2719d4.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vtmk/Ck1t/W6P91K"
Content-Disposition: inline
In-Reply-To: <cover.1715595550.git.ps@pks.im>


--vtmk/Ck1t/W6P91K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Move the subcommand options as well as the `subcommand` variable into
`cmd_config()`. This reduces our reliance on global state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index f6c7e7a082..58c8b0abda 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -75,7 +75,6 @@ static char delim =3D '=3D';
 static char key_delim =3D ' ';
 static char term =3D '\n';
=20
-static parse_opt_subcommand_fn *subcommand;
 static int use_global_config, use_system_config, use_local_config;
 static int use_worktree_config;
 static struct git_config_source given_config_source;
@@ -1058,17 +1057,6 @@ static int cmd_config_edit(int argc, const char **ar=
gv, const char *prefix)
 	return show_editor();
 }
=20
-static struct option builtin_subcommand_options[] =3D {
-	OPT_SUBCOMMAND("list", &subcommand, cmd_config_list),
-	OPT_SUBCOMMAND("get", &subcommand, cmd_config_get),
-	OPT_SUBCOMMAND("set", &subcommand, cmd_config_set),
-	OPT_SUBCOMMAND("unset", &subcommand, cmd_config_unset),
-	OPT_SUBCOMMAND("rename-section", &subcommand, cmd_config_rename_section),
-	OPT_SUBCOMMAND("remove-section", &subcommand, cmd_config_remove_section),
-	OPT_SUBCOMMAND("edit", &subcommand, cmd_config_edit),
-	OPT_END(),
-};
-
 static int cmd_config_actions(int argc, const char **argv, const char *pre=
fix)
 {
 	char *value =3D NULL, *comment =3D NULL;
@@ -1291,6 +1279,18 @@ static int cmd_config_actions(int argc, const char *=
*argv, const char *prefix)
=20
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
+	parse_opt_subcommand_fn *subcommand =3D NULL;
+	struct option subcommand_opts[] =3D {
+		OPT_SUBCOMMAND("list", &subcommand, cmd_config_list),
+		OPT_SUBCOMMAND("get", &subcommand, cmd_config_get),
+		OPT_SUBCOMMAND("set", &subcommand, cmd_config_set),
+		OPT_SUBCOMMAND("unset", &subcommand, cmd_config_unset),
+		OPT_SUBCOMMAND("rename-section", &subcommand, cmd_config_rename_section),
+		OPT_SUBCOMMAND("remove-section", &subcommand, cmd_config_remove_section),
+		OPT_SUBCOMMAND("edit", &subcommand, cmd_config_edit),
+		OPT_END(),
+	};
+
 	given_config_source.file =3D xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
=20
 	/*
@@ -1301,10 +1301,10 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 	 * line in case no subcommand was given, which would otherwise confuse
 	 * us when parsing the legacy-style modes that don't use subcommands.
 	 */
-	argc =3D parse_options(argc, argv, prefix, builtin_subcommand_options, bu=
iltin_config_usage,
+	argc =3D parse_options(argc, argv, prefix, subcommand_opts, builtin_confi=
g_usage,
 			     PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_ARGV0|PARSE_OPT_KEEP_=
UNKNOWN_OPT);
 	if (subcommand) {
-		argc =3D parse_options(argc, argv, prefix, builtin_subcommand_options, b=
uiltin_config_usage,
+		argc =3D parse_options(argc, argv, prefix, subcommand_opts, builtin_conf=
ig_usage,
 		       PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_UNKNOWN_OPT);
 		return subcommand(argc, argv, prefix);
 	}
--=20
2.45.GIT


--vtmk/Ck1t/W6P91K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6dQACgkQVbJhu7ck
PpQHARAAmGlnJmjdbs90vW1+Qhj4bn69U6IqbpfvFzaiAEPeuZhhRqlz5oV3QWM5
nq1v0TwLV2F/Lg7B3oSEtvlMKCqnFuLSp1EEBuh78VkskcaKBaaETAR0lM0fPoX+
sE8U+AsRBV9dwNqkYPwYprgjEJ8la/JU3t+lOBg2BWrgukBuvMpL6t/nmuOFZIb+
RxcnOdEM2d95d9F9fhVmoMwUN/YRm1VlvzBrWvHekYhXW24ysXF5g7Jn54ADmkOn
UoczDd0baC1eVB4LRQrvFo2pUegAHjs7ciNSKyN8jfvhL9HotMGRYd6nKnoLASd5
2SLwn7Q7h2Koo7VDZX+gv+8CfpyeBtVxbdvvcyVPO7z8T5Aa5z0tqEnV2tXiD2UC
AS1LSAC8MEei41R+bnb8Q4EcihLhgjU2oTJAqgLijQdQlLEICtPz0bVqO9E9yKpq
zw8cjLT7cnOVxOTlZVk3Lh7W/qQTytsPn0iLoI2o4LiK826AJA9j+0R0VzTV2c9m
5aEc+TJZJjTiaAicP+QP5uRRvaY+T8nuqXtRTsPkFNEQ9eEklLHWb06mwdwWt6QN
7U/SiszZESGXm5wVvcwr5g1GHU5t+TqTIJjmR21Gdky7h8x1m59YCdpjFVcD0yh/
B9Z3l0oPMNflmXSHarjrg9a7jH+9jnJqiwvxBMhjK3zluWmxrnU=
=UFeP
-----END PGP SIGNATURE-----

--vtmk/Ck1t/W6P91K--
