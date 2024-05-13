Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFDB146D76
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595729; cv=none; b=C0MPyi3JUWpj+AGOaO3AHYUhO7Ek4w/NP/JGqWYjWlNn6vXj+jz5iTmfiIgt/rRfOaj6caSHmTlp0QlmIk+sKWD8H3xOUbw6MjQRtMsi6n818TLlJRi3JnC8rvVG64Wgbs6A6cUjbTMWvtfNydmgzm82OxiJfYOCxy4mZAUIWZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595729; c=relaxed/simple;
	bh=tiy3CYyWMnHEtVtKrk2U8dgDGw4+ZjNM10dbjZEkVLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXzI3Rh+C+vA4Zc8T1C8IZNRYDFDZ51JRGb3ZtXmKV4qBe3vnGdrjL3D9iLsGluCFvfCm0VtkfN6dIY/yPIKFzd0JC+WWxfhGJMWpXAL9PKERVGI43jSrjLCJS2PiEV0QvzkzRVB5Fp0Wy18igUPOzDrFyW5G880j7I2UGL04dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ccuRLSUH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FT0wwnRG; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ccuRLSUH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FT0wwnRG"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 12C781C0012E;
	Mon, 13 May 2024 06:22:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 13 May 2024 06:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595726; x=1715682126; bh=e3FKSpqPOH
	qCV79Zh0pWZVLfOVj/ZgesYWhGkcUuHQo=; b=ccuRLSUHyykB/GlAr7Z0XS3ntN
	io0+8re61ub0qobEFzFZn5Yeff+ILqMhkCB+L9YbZQ05ayIC7PD3pFDYw8KG3DG9
	SzKiZf+TRohtPMlgj2MmE9kHhavdl+QT3O+S9eNYT77JDxYq0yQ41ChPpwCqvtqw
	Bx7aa7wMHQjZ1qSOf2OkHP66Acnckpdada3qePVAwA20kddJ1PeZiTYhxI/85KyU
	WBKyaKLa0KLLvi4X123IqwSl8fB97ZeWUPTfEFRrW0j80VRqBukzy5GmEIvGTLnz
	gsEEEeeaf9rT2ZAHwP70Ok2sMo1+HXXzuDoNbvS/EciS9z+A6g1PD6Y/qIrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595726; x=1715682126; bh=e3FKSpqPOHqCV79Zh0pWZVLfOVj/
	ZgesYWhGkcUuHQo=; b=FT0wwnRGCaa3mjbES91b4wzTacCqBuCUELUd/ptXko9b
	Wm4MPi/ohVPp6v7WJ1APJA7NRKg9w5tdyM9PlOh/f71u8dQgFdtR+BayWOSBvvwV
	ANrkYHAMM6dclEQ+4KQEDHrLsUy0155k9PVKHMG4Ib+j9TB7aVtKGFFOGVpLA5/7
	3KeelzQhHWMsR5DFcVH3wa4iGOWbRrCDSKA410JY8UePY4YuTPxivuLNRVZpOy3s
	4YGznZHFSRadmoN4UxRRXe+mhsGh2qNmdgJMDEExu1hGXw2sSfSWLyau/JXrIupM
	hAguD/3wHjw+v3AKF8LBv8Ot78utokJH4F45X2/Xyg==
X-ME-Sender: <xms:zulBZoKNg6Y_A4iOz5Jhqem1Bqw68jpiz-mPM8nXpU0cAvCVfLr9dg>
    <xme:zulBZoIo9I4zYh1c20utF-6Wvccn3n6x1-bYfd1ijF5fcLavYhUzlbtACpTMlf_NA
    wZ-t7sL_vHwTpd_kg>
X-ME-Received: <xmr:zulBZotjkkUZyVkkTukXCP_ORFm5LYWHexljEE_mYp8TAj8HbudjqPPU2p4RUTGD71BSEaJ_-NJcl7_1Yqrr8tPxmaJiZMd7E4ChmNOgTjGUyZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:zulBZlawyrfmRA9JUt1w6dv9mxPNSuk1sR97g8Lt4YGLjMbuSSrtow>
    <xmx:zulBZvYcRrsvHojpx_uzgnAeInsLoSRYcaq9vtmuW59WqrWDiGOzDw>
    <xmx:zulBZhD1jULCKWO2zhpRt-bI0EJBiRf-YhVBFo72k7k9rODIMozN4w>
    <xmx:zulBZlZJ-x17agvbX5GMixVV2R7v5Z0jianJIf1bx5QFRilEtP1LEw>
    <xmx:zulBZuVsUEjpZJS5yoT3DXiv0WuMZmDf2RwFDIpjQn6ZuTrg-QQVZ2sv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:22:05 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0f3f0ccd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:21:47 +0000 (UTC)
Date: Mon, 13 May 2024 12:22:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 01/21] builtin/config: stop printing full usage on misuse
Message-ID: <0ba76281267b324dd7fe8094132dbce11e9f2182.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3BdTSBzmJvuVP42Z"
Content-Disposition: inline
In-Reply-To: <cover.1715595550.git.ps@pks.im>


--3BdTSBzmJvuVP42Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When invoking git-config(1) with a wrong set of arguments we end up
calling `usage_builtin_config()` after printing an error message that
says what was wrong. As that function ends up printing the full list of
options, which is quite long, the actual error message will be buried by
a wall of text. This makes it really hard to figure out what exactly
caused the error.

Furthermore, now that we have recently introduced subcommands, the usage
information may actually be misleading as we unconditionally print
options of the subcommand-less mode.

Fix both of these issues by just not printing the options at all
anymore. Instead, we call `usage()` that makes us report in a single
line what has gone wrong. This should be way more discoverable for our
users and addresses the inconsistency.

Furthermore, this change allow us to inline the options into the
respective functions that use them to parse the command line.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c  | 28 +++++++++++-----------------
 t/t1300-config.sh |  3 ++-
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 80aa9d8a66..3a71d3253f 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -125,8 +125,6 @@ static const char *comment_arg;
 	{ OPTION_CALLBACK, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG | \
 	PARSE_OPT_NONEG, option_parse_type, (i) }
=20
-static NORETURN void usage_builtin_config(void);
-
 static int option_parse_type(const struct option *opt, const char *arg,
 			     int unset)
 {
@@ -171,7 +169,7 @@ static int option_parse_type(const struct option *opt, =
const char *arg,
 		 * --type=3Dint'.
 		 */
 		error(_("only one type at a time"));
-		usage_builtin_config();
+		exit(129);
 	}
 	*to_type =3D new_type;
=20
@@ -187,7 +185,7 @@ static void check_argc(int argc, int min, int max)
 	else
 		error(_("wrong number of arguments, should be from %d to %d"),
 		      min, max);
-	usage_builtin_config();
+	exit(129);
 }
=20
 static void show_config_origin(const struct key_value_info *kvi,
@@ -672,7 +670,7 @@ static void handle_config_location(const char *prefix)
 	    use_worktree_config +
 	    !!given_config_source.file + !!given_config_source.blob > 1) {
 		error(_("only one config file at a time"));
-		usage_builtin_config();
+		exit(129);
 	}
=20
 	if (!startup_info->have_repository) {
@@ -802,11 +800,6 @@ static struct option builtin_config_options[] =3D {
 	OPT_END(),
 };
=20
-static NORETURN void usage_builtin_config(void)
-{
-	usage_with_options(builtin_config_usage, builtin_config_options);
-}
-
 static int cmd_config_list(int argc, const char **argv, const char *prefix)
 {
 	struct option opts[] =3D {
@@ -1110,7 +1103,7 @@ int cmd_config(int argc, const char **argv, const cha=
r *prefix)
=20
 	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && type) {
 		error(_("--get-color and variable type are incoherent"));
-		usage_builtin_config();
+		exit(129);
 	}
=20
 	if (actions =3D=3D 0)
@@ -1119,30 +1112,31 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 		case 2: actions =3D ACTION_SET; break;
 		case 3: actions =3D ACTION_SET_ALL; break;
 		default:
-			usage_builtin_config();
+			error(_("no action specified"));
+			exit(129);
 		}
 	if (omit_values &&
 	    !(actions =3D=3D ACTION_LIST || actions =3D=3D ACTION_GET_REGEXP)) {
 		error(_("--name-only is only applicable to --list or --get-regexp"));
-		usage_builtin_config();
+		exit(129);
 	}
=20
 	if (show_origin && !(actions &
 		(ACTION_GET|ACTION_GET_ALL|ACTION_GET_REGEXP|ACTION_LIST))) {
 		error(_("--show-origin is only applicable to --get, --get-all, "
 			"--get-regexp, and --list"));
-		usage_builtin_config();
+		exit(129);
 	}
=20
 	if (default_value && !(actions & ACTION_GET)) {
 		error(_("--default is only applicable to --get"));
-		usage_builtin_config();
+		exit(129);
 	}
=20
 	if (comment_arg &&
 	    !(actions & (ACTION_ADD|ACTION_SET|ACTION_SET_ALL|ACTION_REPLACE_ALL)=
)) {
 		error(_("--comment is only applicable to add/set/replace operations"));
-		usage_builtin_config();
+		exit(129);
 	}
=20
 	/* check usage of --fixed-value */
@@ -1175,7 +1169,7 @@ int cmd_config(int argc, const char **argv, const cha=
r *prefix)
=20
 		if (!allowed_usage) {
 			error(_("--fixed-value only applies with 'value-pattern'"));
-			usage_builtin_config();
+			exit(129);
 		}
=20
 		flags |=3D CONFIG_FLAGS_FIXED_VALUE;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index f3c4d28e06..d90a69b29f 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -596,7 +596,8 @@ test_expect_success 'get bool variable with empty value=
' '
=20
 test_expect_success 'no arguments, but no crash' '
 	test_must_fail git config >output 2>&1 &&
-	test_grep usage output
+	echo "error: no action specified" >expect &&
+	test_cmp expect output
 '
=20
 cat > .git/config << EOF
--=20
2.45.GIT


--3BdTSBzmJvuVP42Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6coACgkQVbJhu7ck
PpS6vRAAht9Z519u4F7jrWnYW/k8b9zvLJyaeVPaVYK5ljAA/gRz+zDzYBjQqC/y
B13x/HLTdW1GlPePWGjVBPw+n2JWoh6QWNNaazjX95Yiwad5VQ0VUBBslZUW9PZS
ldAi9a3L4Xb9giyNwUJBAdZnRNNu86tivQpnmMVUC4+J4obAb2sAzXa6pQXe+Vl8
iF4WdV3/EwTGhx/nSdwXO5IjIX861GRseBk6mp+/uaC8NLYcMisckRNjVMLh3hUV
XUjR7nqyo+QqH+VIDdMerHjbph+L2gfArIf3fkQr1VkwthU469CLlPArzWmukyfV
rtwbfIaj4rdfp+xyGpG7ZBgq5ihiwl7K+r2Z6LAfByhpqlnHv6Y/1vhNued9KWxH
HquVJDULFwcTufBCWEWMVUn/puvl2HDeSki5waW65dY49pxvGZxbHivnTUWkdsrd
yXjChedtIo+UFLAiIHEHyYTGPsYdnnpuKrJ3ZNRGTLbSl3duYS/YrEWoAJfFEi9L
n35k3+2Ov0OkozRO1fKlbe8Y6Dj6MjxAEFIUsyWGrVScI+8WctgNTSUpDfr/9jH9
NFALywDu5A74ULI3QjGd1a68ITK2W6N5m937B4oWXbiL9S86xHK9JjQmrGHtTmpw
notFBij3Ga28YouqBg2KTOCP4ASzwXL/7PwiVrI5hPaItJMfoLc=
=96Qz
-----END PGP SIGNATURE-----

--3BdTSBzmJvuVP42Z--
