Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7DC31A67
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595764; cv=none; b=TNtg6jR45mbtqILtrOVE52yQ7BcoVilT7SEeYVbpVjBDDhvjWYxc2Jg/ztCxBBnr8Pr5LUDp7ZG5Mn97Nn6M23OAmdJQyMONNaK7XoergYEQ2zcZOmv+XsnQYXGGdx/L2QkQc5vheiq7UizK+4sOkfh0Twy7rGQWd1t3SWWdcu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595764; c=relaxed/simple;
	bh=n8fi+yKilsyZM1S8Mc77p8NQun/SApqhfRI1QgdRzUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgMnRsRyF3UqN/+PIjBbSR4wso+fhhP0IUgSPhjlM0jBS0SYgPhLCQc6Zk1s2ffp7MozXoHI8to6yRi+i72AUUXNl2/5PTboIBONeWd3REIEPiOgs/JqjhPSKuI26eFkIed7BK1R0jyzkiAFa4NAegqka142POHpclWzATKnH+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L89uLP0l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QKocp6++; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L89uLP0l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QKocp6++"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5E724180010F;
	Mon, 13 May 2024 06:22:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 13 May 2024 06:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595762; x=1715682162; bh=WezW4VwHlZ
	k7s2qpTKfLp4hrqOD/aBN27jaBHSoG9sw=; b=L89uLP0lb+Nv5I32I2fwhNg62w
	VR7tRwti/imYRUgZ17XQpnu0EICjElRHqAmyB9zGabAY8gJySt8tw6fPB1/53Wpp
	Rcm4QhipVA+81hT+3UhlEgcUneAZFtQ3fzPvyJmtudqSwmxkUAu6GOg9cUDpbFBt
	j9PNSXuAWdvVW/fKoKBSP7ixeErZ4ksCf5zhGguyobmiO8g+3Yd414SM2PnQuQz6
	A/SzmL8INOcDmW4ZytZvp33ARQuRe/cWxGRCzNcGXokK0XggdSH4R1GV0TRlUzhY
	+SNW6I/cV/vACcNoDy85E7yT07XcGVLak56GIXNgxec63T0TemOzf5S4JesA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595762; x=1715682162; bh=WezW4VwHlZk7s2qpTKfLp4hrqOD/
	aBN27jaBHSoG9sw=; b=QKocp6++1FJRN2Oy8YlKL6SRIkEMKZWOV0hB+OV4vD1M
	3sg+pAtgQfh2AH7IrZJqgWp0/sjZ3YScnwgAGHZZ2SBlWnvRoo1vEZ0tyWoqVjWU
	29BJ1nmWTqOvpfs+qNr70pDpQ7X2nBb7mtkVx0vWqvcGqI/We1TOolqEoFf7XaTR
	XEmt9/8mMJ5w5azdq1MfSJlZv8KRxJALxW1wxdmEd5HkhXXS9r2Qhr8Fzhh2BlSp
	7FpdsfkXxqq1uRrYUDI3MW0R4ZWrkCinEqlvlniOMWWRUDWq1epdJM6KzF7286TZ
	1Fo71x57/JIvBNK7+HiStkfnWoojGNu9Aj2RsTKI6w==
X-ME-Sender: <xms:8elBZsSYeMnaSJltxYQBxNsDcPr-AuGCBoB637ca5yS40Nfr2yqtFw>
    <xme:8elBZpw_PzZ-NTVcnxeFOgLv3pANXGmHL6o6r5DtCEgTdZ0VXdjZSzJfAYJswuE4U
    F8tLaXBT3mZCGCXlA>
X-ME-Received: <xmr:8elBZp2VRM9nZ8GijiIm8BVMFXQkk9lI_-UYKvOFKny_WPzYZpQrtFWj68x1xr2rThRXQEftqhp_0DQsAvcdN6knXxlbzPK9weysPPObNCLADMc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:8elBZgAuPjZNEH9ADZGCnnqZy0Ii6glxyoGOlH2BJ0nQlZ8P1w64XQ>
    <xmx:8elBZlhaEZp220NjbVbfplvRXWnum5j0FlRYcwBmGyTp8lasdRrRHg>
    <xmx:8elBZsojlUpa4oBpJoJfXJBfGCHiRohNpr93xzjAKsM_tP1g50U7QA>
    <xmx:8elBZohKfVzt0d0Qjw8RJg2aE3gjvAwkJfud1tIRVdePlkC62wwMtQ>
    <xmx:8elBZleiClDoBs6W4DpuRzhhamMV_wlMPZ7Zu3cdD-gnzu95TcS35MX2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:22:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id abb1698d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:22:22 +0000 (UTC)
Date: Mon, 13 May 2024 12:22:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 08/21] builtin/config: refactor functions to have common
 exit paths
Message-ID: <018ed0226ba670616c44db20a35d456188cf0604.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="icBJ5gbI5n7HMppU"
Content-Disposition: inline
In-Reply-To: <cover.1715595550.git.ps@pks.im>


--icBJ5gbI5n7HMppU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor functions to have a single exit path. This will make it easier
in subsequent commits to add common cleanup code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 64 ++++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 9866d1a055..155564b832 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -798,6 +798,7 @@ static int cmd_config_get(int argc, const char **argv, =
const char *prefix)
 		OPT_STRING(0, "default", &default_value, N_("value"), N_("use default va=
lue when missing entry")),
 		OPT_END(),
 	};
+	int ret;
=20
 	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_get_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
@@ -816,8 +817,11 @@ static int cmd_config_get(int argc, const char **argv,=
 const char *prefix)
 	setup_auto_pager("config", 1);
=20
 	if (url)
-		return get_urlmatch(argv[0], url);
-	return get_value(argv[0], value_pattern, flags);
+		ret =3D get_urlmatch(argv[0], url);
+	else
+		ret =3D get_value(argv[0], value_pattern, flags);
+
+	return ret;
 }
=20
 static int cmd_config_set(int argc, const char **argv, const char *prefix)
@@ -888,6 +892,7 @@ static int cmd_config_unset(int argc, const char **argv=
, const char *prefix)
 		OPT_BIT(0, "fixed-value", &flags, N_("use string equality when comparing=
 values to value pattern"), CONFIG_FLAGS_FIXED_VALUE),
 		OPT_END(),
 	};
+	int ret;
=20
 	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_unset_usa=
ge,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
@@ -900,12 +905,14 @@ static int cmd_config_unset(int argc, const char **ar=
gv, const char *prefix)
 	check_write();
=20
 	if ((flags & CONFIG_FLAGS_MULTI_REPLACE) || value_pattern)
-		return git_config_set_multivar_in_file_gently(given_config_source.file,
-							      argv[0], NULL, value_pattern,
-							      NULL, flags);
+		ret =3D git_config_set_multivar_in_file_gently(given_config_source.file,
+							     argv[0], NULL, value_pattern,
+							     NULL, flags);
 	else
-		return git_config_set_in_file_gently(given_config_source.file, argv[0],
-						     NULL, NULL);
+		ret =3D git_config_set_in_file_gently(given_config_source.file, argv[0],
+						    NULL, NULL);
+
+	return ret;
 }
=20
 static int cmd_config_rename_section(int argc, const char **argv, const ch=
ar *prefix)
@@ -926,11 +933,13 @@ static int cmd_config_rename_section(int argc, const =
char **argv, const char *pr
 	ret =3D git_config_rename_section_in_file(given_config_source.file,
 						argv[0], argv[1]);
 	if (ret < 0)
-		return ret;
+		goto out;
 	else if (!ret)
 		die(_("no such section: %s"), argv[0]);
+	ret =3D 0;
=20
-	return 0;
+out:
+	return ret;
 }
=20
 static int cmd_config_remove_section(int argc, const char **argv, const ch=
ar *prefix)
@@ -951,11 +960,13 @@ static int cmd_config_remove_section(int argc, const =
char **argv, const char *pr
 	ret =3D git_config_rename_section_in_file(given_config_source.file,
 						argv[0], NULL);
 	if (ret < 0)
-		return ret;
+		goto out;
 	else if (!ret)
 		die(_("no such section: %s"), argv[0]);
+	ret =3D 0;
=20
-	return 0;
+out:
+	return ret;
 }
=20
 static int show_editor(void)
@@ -1199,41 +1210,41 @@ static int cmd_config_actions(int argc, const char =
**argv, const char *prefix)
 	}
 	else if (actions =3D=3D ACTION_GET) {
 		check_argc(argc, 1, 2);
-		return get_value(argv[0], argv[1], flags);
+		ret =3D get_value(argv[0], argv[1], flags);
 	}
 	else if (actions =3D=3D ACTION_GET_ALL) {
 		do_all =3D 1;
 		check_argc(argc, 1, 2);
-		return get_value(argv[0], argv[1], flags);
+		ret =3D get_value(argv[0], argv[1], flags);
 	}
 	else if (actions =3D=3D ACTION_GET_REGEXP) {
 		show_keys =3D 1;
 		use_key_regexp =3D 1;
 		do_all =3D 1;
 		check_argc(argc, 1, 2);
-		return get_value(argv[0], argv[1], flags);
+		ret =3D get_value(argv[0], argv[1], flags);
 	}
 	else if (actions =3D=3D ACTION_GET_URLMATCH) {
 		check_argc(argc, 2, 2);
-		return get_urlmatch(argv[0], argv[1]);
+		ret =3D get_urlmatch(argv[0], argv[1]);
 	}
 	else if (actions =3D=3D ACTION_UNSET) {
 		check_write();
 		check_argc(argc, 1, 2);
 		if (argc =3D=3D 2)
-			return git_config_set_multivar_in_file_gently(given_config_source.file,
-								      argv[0], NULL, argv[1],
-								      NULL, flags);
+			ret =3D git_config_set_multivar_in_file_gently(given_config_source.file,
+								     argv[0], NULL, argv[1],
+								     NULL, flags);
 		else
-			return git_config_set_in_file_gently(given_config_source.file,
-							     argv[0], NULL, NULL);
+			ret =3D git_config_set_in_file_gently(given_config_source.file,
+							    argv[0], NULL, NULL);
 	}
 	else if (actions =3D=3D ACTION_UNSET_ALL) {
 		check_write();
 		check_argc(argc, 1, 2);
-		return git_config_set_multivar_in_file_gently(given_config_source.file,
-							      argv[0], NULL, argv[1],
-							      NULL, flags | CONFIG_FLAGS_MULTI_REPLACE);
+		ret =3D git_config_set_multivar_in_file_gently(given_config_source.file,
+							     argv[0], NULL, argv[1],
+							     NULL, flags | CONFIG_FLAGS_MULTI_REPLACE);
 	}
 	else if (actions =3D=3D ACTION_RENAME_SECTION) {
 		check_write();
@@ -1241,7 +1252,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 		ret =3D git_config_rename_section_in_file(given_config_source.file,
 							argv[0], argv[1]);
 		if (ret < 0)
-			return ret;
+			goto out;
 		else if (!ret)
 			die(_("no such section: %s"), argv[0]);
 		else
@@ -1253,7 +1264,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 		ret =3D git_config_rename_section_in_file(given_config_source.file,
 							argv[0], NULL);
 		if (ret < 0)
-			return ret;
+			goto out;
 		else if (!ret)
 			die(_("no such section: %s"), argv[0]);
 		else
@@ -1267,9 +1278,10 @@ static int cmd_config_actions(int argc, const char *=
*argv, const char *prefix)
 		check_argc(argc, 1, 2);
 		if (argc =3D=3D 2)
 			color_stdout_is_tty =3D git_config_bool("command line", argv[1]);
-		return get_colorbool(argv[0], argc =3D=3D 2);
+		ret =3D get_colorbool(argv[0], argc =3D=3D 2);
 	}
=20
+out:
 	free(comment);
 	free(value);
 	return ret;
--=20
2.45.GIT


--icBJ5gbI5n7HMppU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6e0ACgkQVbJhu7ck
PpSf+g//UraUqhoBBDXePIcA2qBDLRkO5Ph76SqW8phYk6A94sv+uQz1FURuAsxY
ahAqCU7vrrRW+S0B7q8cyzMSzYkSPktH5UaBbxogAyUS63VCA/sSZ2ecxJVoUV/s
Rrppwi0/+y+FIQxCzVxfo6OR6/YckXLPTzec6RND5KIh//CePCBH4iNsJZht9d2+
9r6ZJaY8VFbbMf4vRqHl8LLw382LJwY4n2wr0jxdsRB5DM19oP2E2eVuFN377RiG
I8gspe0bz6j9oFbkof0A3zkyxb1jCEphrMHplGk1QvOCBt9rBtVzCLDQ8HAGTAsA
AyfuYfD6GMaRQhpgGiaxArDEhZRYjfDruKwnGWlmJOT04+/oUGo9sCO7c0k21Zh7
U7cKg/Y2S2LgcJpltvQjjnZU0F3Wq3ArTL0kK5hKjtZckZBxYBMmxxDGoH5GT3us
gyKH5eSGUbAOlJZM6CCE/vnMGHtdiyRMA79A1HcLiIJs3dIDqve0+A/Q12fI4EO3
aAdI9sdPxq9MDBRSeRVy+7/FQXiouj9ADzENEbAnpjVnfrf3BqRorshqz/DOvp6I
txXfN03bgQ+fqVORK0aRFtZnwFuRUp5PhtUCvXvqKupRxLBHOk2R+uNS2IPhwlyh
izLRSIg/KkfGKliE2s5W6xjFO96B4lP2Ab2jnZPH6I7Gks37Utc=
=LSas
-----END PGP SIGNATURE-----

--icBJ5gbI5n7HMppU--
