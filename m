Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E66814F133
	for <git@vger.kernel.org>; Fri,  3 May 2024 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730265; cv=none; b=kFHApMpzCj746NlDjdvXdjFbul2C+bxQJEoHOFit8R2+H1JtCYnyjK5TFH3W5yMmPFx/qcRqDX2LFeRqI9Xq4xznX+P7SrxrtM/izAhHmdP4OVbeca3PCbm6zvf8MLUlvzK6HEVX5PRj6EPzTLt4t29iDY8yXvgHOYLlGyOnqms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730265; c=relaxed/simple;
	bh=rUzRwwiXVj8BeLZ0Sw2EMCfT/S3ckOYvPzSwFTEXlt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZAxwx15ndSarI5eOmwKd5+tsY6JCtqvviKfUSwVO4s4aelonX5gt/M8K6E4W7CDqenGKCfvFN+wkOzlRAlZzU9IwaYa12aQdOTFLFeD9pHcIny0bA52QwiWc3+IebSkAl1jpVSU8QKJ4J8kON8zii6tGvDlgwKnAiOcZ4rjAa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C2uYRVp8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fhRRlmyT; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C2uYRVp8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fhRRlmyT"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 57AEF1C000CF;
	Fri,  3 May 2024 05:57:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 03 May 2024 05:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714730262; x=1714816662; bh=zE3AhEL0TE
	uuTeqwRHR0dzgSEjXLngpVS+bqLESoYMY=; b=C2uYRVp8+ovZ8MIDZ+immZH6G8
	7wQ0bO+B2GblDUfYNkvCgUNabzp47Ptg4deyQL4dOaifbnvMI38EDxNCaFVZ259u
	+/7p7XJ6Az/gCevGXpnmq1XWqfS6m5l4tgj1rN8HZ8sR/QAqWxUF7DdDguCGyTA4
	HhUOZB73dqgEUZ6WqYu7Qcvj2y+DYDopS/sh7Lf+6DEjwAU47hMr+urfsc1D/dUB
	99djo6XCUaPpNAZh0NByBfyn7qJcPdXcWQW2SLRXxxPBH4YdIV5BEud2PGzR+hSK
	LG/nk/uBXVRP+6J+ISxUiyn7D8FHsnd6+VA/e17LKUUtVtZIQCoF0fWFMTVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714730262; x=1714816662; bh=zE3AhEL0TEuuTeqwRHR0dzgSEjXL
	ngpVS+bqLESoYMY=; b=fhRRlmyTAzIbRtBaBSUYXoJaCJZHCBQVF9c66zb6O/vZ
	Q5fPZ3SDfwFJDOHlXApSEtsBlYwOxZ6yDOQkb+zb/NO+CAmXWdkoqkVkkHDvhZWU
	x7bpmFs0IjZu3f6EZmZhhGn0lrWmkJOkSgqHlPhNsQPpSY+0x1Y9vCXaGAfR/TZ9
	Gt2pwJ9IDq0S9rIS/2upt5PHRYiFvVZZqGZFJ0zd+dttUkhYs1L9FaDilJJU8pr1
	1Mne9i1o3GYKdmTWrKIjNvCc/LKy+vTI42Jx029qZlNR1tUuVY6F+FCTB0ziIXSS
	/IBCThh7v0Hcd5FlOl3q4VezOIJ6fE+zZKjMy1Whjw==
X-ME-Sender: <xms:FrU0Zmnmx30hMLWA5AMUQiE_H1KYgY4557KW2ig6hYrFV98jKyv7xg>
    <xme:FrU0Zt2M4eXyfVq0YCMI6rFGyiiZ0ikfFve7hE7aaWlCRYaX1D5krjCu_-qwm5CDF
    nzHN4Dd3pall7QjoA>
X-ME-Received: <xmr:FrU0Zkrgs_65lRE080fLczCEV6EOhbEyONneDpNz62z_-RSFU_yRjczj8JBVx0EqKpSkBy2IRqd_f9VALtsyAcRD01FyTB7sQlJh4HAe_NsrxpXP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:FrU0ZqlnNENFQAdIQZ26pmTkuG1OpzOAHbdS_YTN-RSNppNOoa91FA>
    <xmx:FrU0Zk29gQwwDad4q_HTqar4wYdC_nAPPGzL6dvuuXSVFttIANLGjw>
    <xmx:FrU0ZhtkM61j9IEkZRDQ5g0Br4-sT0oUbiV9rptOcJlEBLVBGRvqbw>
    <xmx:FrU0ZgVzUxBaGiBhQxx6z0U3DEWQOMzjbS6Rupp-Bqjyh682vQ4IHQ>
    <xmx:FrU0Zuq3j_LTodSuosForTolJ02APF5XHzlLZulX5gQkBGpceylmRWyQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 05:57:41 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 207d5656 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 09:57:13 +0000 (UTC)
Date: Fri, 3 May 2024 11:57:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 12/14] builtin/config: introduce "remove-section"
 subcommand
Message-ID: <fc2ddd3201c01939a52293a80c134cae96adee23.1714730170.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714730169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r0tG30MVIPe8J3U4"
Content-Disposition: inline
In-Reply-To: <cover.1714730169.git.ps@pks.im>


--r0tG30MVIPe8J3U4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new "remove-section" subcommand to git-config(1). Please
refer to preceding commits regarding the motivation behind this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-config.txt | 11 +++++++----
 builtin/config.c             | 32 ++++++++++++++++++++++++++++++++
 t/t1300-config.sh            |  4 ++--
 3 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index ede86ad085..ef46520c15 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 'git config set' [<file-option>] [--type=3D<type>] [--all] [--value=3D<val=
ue>] [--fixed-value] <name> <value>
 'git config unset' [<file-option>] [--all] [--value=3D<value>] [--fixed-va=
lue] <name> <value>
 'git config rename-section' [<file-option>] <old-name> <new-name>
-'git config' [<file-option>] --remove-section <name>
+'git config remove-section' [<file-option>] <name>
 'git config' [<file-option>] --get-colorbool <name> [<stdout-is-tty>]
 'git config' [<file-option>] -e | --edit
=20
@@ -95,6 +95,9 @@ unset::
 rename-section::
 	Rename the given section to a new name.
=20
+remove-section::
+	Remove the given section from the configuration file.
+
 [[OPTIONS]]
 OPTIONS
 -------
@@ -192,9 +195,6 @@ See also <<FILES>>.
 	section in linkgit:gitrevisions[7] for a more complete list of
 	ways to spell blob names.
=20
---remove-section::
-	Remove the given section from the configuration file.
-
 --fixed-value::
 	When used with the `value-pattern` argument, treat `value-pattern` as
 	an exact string instead of a regular expression. This will restrict
@@ -333,6 +333,9 @@ recommended to migrate to the new syntax.
 --rename-section <old-name> <new-name>::
 	Replaced by `git config rename-section <old-name> <new-name>`.
=20
+--remove-section <name>::
+	Replaced by `git config remove-section <name>`.
+
 CONFIGURATION
 -------------
 `pager.config` is only respected when listing configuration, i.e., when
diff --git a/builtin/config.c b/builtin/config.c
index a60dca9b2b..cea03fb517 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -21,6 +21,7 @@ static const char *const builtin_config_usage[] =3D {
 	N_("git config set [<file-option>] [--type=3D<type>] [--all] [--value=3D<=
value>] [--fixed-value] <name> <value>"),
 	N_("git config unset [<file-option>] [--all] [--value=3D<value>] [--fixed=
-value] <name> <value>"),
 	N_("git config rename-section [<file-option>] <old-name> <new-name>"),
+	N_("git config remove-section [<file-option>] <name>"),
 	NULL
 };
=20
@@ -49,6 +50,11 @@ static const char *const builtin_config_rename_section_u=
sage[] =3D {
 	NULL
 };
=20
+static const char *const builtin_config_remove_section_usage[] =3D {
+	N_("git config remove-section [<file-option>] <name>"),
+	NULL
+};
+
 static char *key;
 static regex_t *key_regexp;
 static const char *value_pattern;
@@ -980,12 +986,38 @@ static int cmd_config_rename_section(int argc, const =
char **argv, const char *pr
 	return 0;
 }
=20
+static int cmd_config_remove_section(int argc, const char **argv, const ch=
ar *prefix)
+{
+	struct option opts[] =3D {
+		CONFIG_LOCATION_OPTIONS,
+		OPT_END(),
+	};
+	int ret;
+
+	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_remove_se=
ction_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	check_write();
+	check_argc(argc, 1, 1);
+
+	handle_config_location(prefix);
+
+	ret =3D git_config_rename_section_in_file(given_config_source.file,
+						argv[0], NULL);
+	if (ret < 0)
+		return ret;
+	else if (!ret)
+		die(_("no such section: %s"), argv[0]);
+
+	return 0;
+}
+
 static struct option builtin_subcommand_options[] =3D {
 	OPT_SUBCOMMAND("list", &subcommand, cmd_config_list),
 	OPT_SUBCOMMAND("get", &subcommand, cmd_config_get),
 	OPT_SUBCOMMAND("set", &subcommand, cmd_config_set),
 	OPT_SUBCOMMAND("unset", &subcommand, cmd_config_unset),
 	OPT_SUBCOMMAND("rename-section", &subcommand, cmd_config_rename_section),
+	OPT_SUBCOMMAND("remove-section", &subcommand, cmd_config_remove_section),
 	OPT_END(),
 };
=20
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 5d7b08fa4c..9d71ec1260 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -813,7 +813,7 @@ cat >> .git/config << EOF
 EOF
=20
 test_expect_success 'remove section' '
-	git config --remove-section branch.zwei
+	git config ${mode_prefix}remove-section branch.zwei
 '
=20
 cat > expect << EOF
@@ -2602,7 +2602,7 @@ test_expect_success 'refuse --fixed-value for incompa=
tible actions' '
 	test_must_fail git config --file=3Dconfig --fixed-value --get-urlmatch de=
v.null bogus &&
 	test_must_fail git config --file=3Dconfig --fixed-value --get-urlmatch de=
v.null bogus &&
 	test_must_fail git config ${mode_prefix}rename-section --file=3Dconfig --=
fixed-value dev null &&
-	test_must_fail git config --file=3Dconfig --fixed-value --remove-section =
dev &&
+	test_must_fail git config ${mode_prefix}remove-section --file=3Dconfig --=
fixed-value dev &&
 	test_must_fail git config ${mode_prefix}list --file=3Dconfig --fixed-valu=
e &&
 	test_must_fail git config --file=3Dconfig --fixed-value --get-color dev.n=
ull &&
 	test_must_fail git config --file=3Dconfig --fixed-value --get-colorbool d=
ev.null &&
--=20
2.45.0


--r0tG30MVIPe8J3U4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0tREACgkQVbJhu7ck
PpSxkg//Qt6mETWh9qdIW374hjOSkZnmexY3Khy7ox1y3Y/rCU7oMqPQBYP8mkxs
p6ArrdrBtxGKTG7gGxjjS5IfDLxt/kcc5otyKuSf6+qktBE5bglZFz4UPje4Mjix
V9MHBVuM9ZXNHYf1HwdbGv3no9SkoKf4K1SxEx+h0SiZVF7eaHPoQxzp20CDngwR
njiCbjC6zzS0sYukbyF4AP/kkp99wrpyBMuBrWxWQfc+1cn1vrgzTc3vcQ5cgFwM
QPABKM3Dt7/R9g/fexIgpQrOX49K/V6B6MoIuGSRY+LDVmIJbEogh5obgWxDR8YX
76HNRusUCXyD/vZQxu+O5HOKQK6SlvVTMxxl5Vbd1wjLLbrJHNSP7y6YFj8VpCcE
SYhpBD1u0w8V7Tnb9G4r79dzeUs4ZwKdnsxmGb/GHEaNJYmQ/rstCSHKDi+lWS68
SGiGYkp6ozq7cGDuZ4P9R2GG0o0Er/6QQIyIudJIyqV51/5rWWZJgA+B52dpu7KM
fElDoUc5L7QDZiN6tTDkKodTOIfsy1Y5UwuxE+4QJwjRGPtQDw80+Rfg9t6r/0Zf
e5q0FKFKOOEDZhGqfu4dNWnLJHleLSt+MFZlFU9dQhs8bAsKmd13r8xUmYX2pVT4
/L8eiyzxJl37M1tpbk1/RegC0HH2MXJHBByq0TlZLwYWnaS0jXQ=
=iv/V
-----END PGP SIGNATURE-----

--r0tG30MVIPe8J3U4--
