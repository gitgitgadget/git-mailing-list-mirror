Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2500F31A67
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595754; cv=none; b=ZHMJp8wbFedRuGHOlXmWCBYCPOSg/C34OUzgNyM2fwdb2inigRzxVgWkx31x366nM91tDW2345Gim8oaVQQzgIlquiPuppAJGmivAQKkyq7TPnA+UKEmGRt/jRBnMrRnhMJcXJ3Q/Ckoawd5by3Dbi/G/wW05gt/DKcMfPIyJCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595754; c=relaxed/simple;
	bh=i29iRBgL2LTrt5uzgeMDZJ7WFiZED+XrIH2axjZ2GTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClWWEMiWFACyXwsnBjHmMzugoKZHUZXJp15uT9R2i26cpgtRUbwht6Sij9lL4qGnTHPUYmvUtNuV724OP9DI4Uj9CRD5KDWEUFCOTk8LXZwtl/0BZJ9Qgn+neeMVJzPd7Y3TJrKeZiL7L1HAE99adOdEpHUDO0FBmdKmp4eRQOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uP36Y5Om; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y/pkpKZl; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uP36Y5Om";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y/pkpKZl"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4CF23180012E;
	Mon, 13 May 2024 06:22:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 13 May 2024 06:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595751; x=1715682151; bh=tJphtNqawJ
	863crK1scVIM/jvmWpUMz/5NtFEQPSzZU=; b=uP36Y5OmuSj6Ljr4URbp1qObP6
	IO4Ac5i6v5Cw1HK/3ru0QI0YvY/inVD/RZ9my93bEMkXW9MKZ4LDfibtBxVfuN4S
	IYdAEXu5LERwEdqWk4JgVda5bsUNcjA0pU7VYlWNQzlQMXfXYG766I75qEouMDDE
	tVS0Z5u/0PQzD8mBS2j+XzE3Cla1sHvN/envqLQG9EWtXsETdzXLRoM3NlKjfYn/
	cEvyH7XpKf94c0PtUev/NQlk+2O10R5lveJX2Z/8A5zcGRbPHasfP7u7/8gfMgoQ
	k1nlr8O2+3fsZAmFg5SgdZ4k+DLcD2jkKPhzgPTuxcFZZR48C612jJMymbGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595751; x=1715682151; bh=tJphtNqawJ863crK1scVIM/jvmWp
	UMz/5NtFEQPSzZU=; b=Y/pkpKZlspiwGHWl4navVN0us9ps8cfvNeYg1pvWmIKG
	vc4qcNdf283r1xP/6kTmU/0XHvaYrtAt6hJC9HfWXMPse73tVAwLiB96Nbx1NK6m
	XxqFTdmAqaZz9VuS33/67AaB0woTqwYVss97v7WjAZKDWTox3xZPwzAf/l91GXS6
	nJgqGOODN3+1ONGr5oYu///JSepl1RLeXK1l272Qcyr95cx/2U8eS3PqSeOu8fga
	Ll8B16BD7KHDjRDKJdGAyWdDIq/+Yly2b4GfK/7H3nwandZA2JWFST9p2cLLDIU7
	3nWwqpWTkUkzlIzCnPinf7uxyoNCCIDufOGJ3E3qIA==
X-ME-Sender: <xms:5-lBZhtq5Mfk5tEjlgXWrYqjy8p7yWeo_xCibrkRFv6FSXv1DhqmJg>
    <xme:5-lBZqeLb9ax_S6UJI-RNJhFVQSG2BOAXtTRhzJm6eyhcsPqqFRBrihNcIlDoA0lu
    ZZDJxSUIyptfXmNYw>
X-ME-Received: <xmr:5-lBZkzYSgzIneKwW6ys_VuPnepJve6TnaYk9-9S2mdJHHKLGMq-YAXf5AwLEWsh_gjZcbRgNvRF7_Bz9Dqx1iAEJDZwGmKklANSdj3PHp_agws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:5-lBZoPMJQ1_Oj15TuMgxt1TCTAmFyS82y-kq7zcX2A5QauPTGq2hw>
    <xmx:5-lBZh-K3e0IuMVfLK35XnGKoTYOlFf-s65OfD8duXRNbJTPKl7ImA>
    <xmx:5-lBZoVF5gig0ZJHztpeP9V77-W2Zlwoyj4SCFYz3KNnCqMty8lurA>
    <xmx:5-lBZiepuotOb1mwyn_CfPSWys8igUw3mQpBifep3d52s2e4DSKFlw>
    <xmx:5-lBZtaVs_K0Fz4nLEiRDF5KX_H1hCvGKHEdrUSzFuzzpbT60MHPIr3r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:22:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fea539cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:22:11 +0000 (UTC)
Date: Mon, 13 May 2024 12:22:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 06/21] builtin/config: check for writeability after source
 is set up
Message-ID: <7ab99a27c16718ad4dff1f7862e80c52b48c3812.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CFikwyUvDDp7QM/S"
Content-Disposition: inline
In-Reply-To: <cover.1715595550.git.ps@pks.im>


--CFikwyUvDDp7QM/S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `check_write()` function verifies that we do not try to write to a
config source that cannot be written to, like for example stdin. But
while the new subcommands do call this function, they do so before
calling `handle_config_location()`. Consequently, we only end up
checking the default config location for writeability, not the location
that was actually specified by the caller of git-config(1).

Fix this by calling `check_write()` after `handle_config_location()`. We
will further clarify the relationship between those two functions in a
subsequent commit where we remove the global state that both implicitly
rely on.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c  | 10 +++++-----
 t/t1300-config.sh |  6 ++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 0842e4f198..9866d1a055 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -843,7 +843,6 @@ static int cmd_config_set(int argc, const char **argv, =
const char *prefix)
=20
 	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_set_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
-	check_write();
 	check_argc(argc, 2, 2);
=20
 	if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
@@ -856,6 +855,7 @@ static int cmd_config_set(int argc, const char **argv, =
const char *prefix)
 	comment =3D git_config_prepare_comment_string(comment_arg);
=20
 	handle_config_location(prefix);
+	check_write();
=20
 	value =3D normalize_value(argv[0], argv[1], &default_kvi);
=20
@@ -891,13 +891,13 @@ static int cmd_config_unset(int argc, const char **ar=
gv, const char *prefix)
=20
 	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_unset_usa=
ge,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
-	check_write();
 	check_argc(argc, 1, 1);
=20
 	if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
 		die(_("--fixed-value only applies with 'value-pattern'"));
=20
 	handle_config_location(prefix);
+	check_write();
=20
 	if ((flags & CONFIG_FLAGS_MULTI_REPLACE) || value_pattern)
 		return git_config_set_multivar_in_file_gently(given_config_source.file,
@@ -918,10 +918,10 @@ static int cmd_config_rename_section(int argc, const =
char **argv, const char *pr
=20
 	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_rename_se=
ction_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
-	check_write();
 	check_argc(argc, 2, 2);
=20
 	handle_config_location(prefix);
+	check_write();
=20
 	ret =3D git_config_rename_section_in_file(given_config_source.file,
 						argv[0], argv[1]);
@@ -943,10 +943,10 @@ static int cmd_config_remove_section(int argc, const =
char **argv, const char *pr
=20
 	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_remove_se=
ction_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
-	check_write();
 	check_argc(argc, 1, 1);
=20
 	handle_config_location(prefix);
+	check_write();
=20
 	ret =3D git_config_rename_section_in_file(given_config_source.file,
 						argv[0], NULL);
@@ -997,10 +997,10 @@ static int cmd_config_edit(int argc, const char **arg=
v, const char *prefix)
 	};
=20
 	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_edit_usag=
e, 0);
-	check_write();
 	check_argc(argc, 0, 0);
=20
 	handle_config_location(prefix);
+	check_write();
=20
 	return show_editor();
 }
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index d90a69b29f..9de2d95f06 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2835,6 +2835,12 @@ test_expect_success 'specifying multiple modes cause=
s failure' '
 	test_cmp expect err
 '
=20
+test_expect_success 'writing to stdin is rejected' '
+	echo "fatal: writing to stdin is not supported" >expect &&
+	test_must_fail git config ${mode_set} --file - foo.bar baz 2>err &&
+	test_cmp expect err
+'
+
 done
=20
 test_done
--=20
2.45.GIT


--CFikwyUvDDp7QM/S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6eMACgkQVbJhu7ck
PpSVsg/9HfMnRnYPsQI8rh2UaeOZb8Elfjca7lEML+yXCjC2+AuXxbyCnlfZJHHK
DwwnfTeeXhI7FyVcB9yv5+1z9FjULqUsiXtZzwGUqKUL+FCFMPp3CxLzPEAaQ1Pi
vpj7+8OVxL8JWv7xyOLFgEKBiB0hUct4rGxFslpasCtXZxGwXwyUjsi8p1clb5n7
GOe2tQnTfzyhx62xYQn6Q3kGFM5+RctEODuB6lXtQYAJIFPruuo7xoy9LUhwpw+n
DAhDMmd6UswjJD++JXbfSVnWl2tiQ9wZFLz6IHlWFdPrTLzrZ1Wu09CgZRz0DxDt
rerM1RJ4t+U6qwbPkuFiD8l2GLulppHTtOHhX7bSJB5Bw+b7rRNB7p1Gu1R4MAEK
SnuP+cxR1e9QxfaSwPsAqg3GF+LhwelUEAIBJbw1mcGzRyd1j3EHu8CcT90LZymk
dqmZQddLcDjqJ5/HUEHI5ke7xKzrdMjtTWZ4NhEIWBgKGmZTeloYRJ1B0smm6lnw
CyQupDvxNtV7Ic9k501yyDt46P+M9QgxEym4jsr2DkGyS2XeKk4AUogkH5oMtrrA
VilCe11gjM4AkFNIHofuvauaFR9ZKmychDmBEngaJkypD78V05PD03uGRWt/8124
8hmqHYiqaCgWzJRGtlq9loNrcbOswXzst1lOJEIfn9pxK4/ZbeA=
=S8EH
-----END PGP SIGNATURE-----

--CFikwyUvDDp7QM/S--
