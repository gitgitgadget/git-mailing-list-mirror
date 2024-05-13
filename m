Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86187146D76
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595821; cv=none; b=SewbSBzvKpwbrALm1eahdL1QU55qp71GiieZuIezWMCuZ1PJJIF2QiXH13mbBZ41PPtyYC3uv0uFuAh+ZlUaRvBAM3SxidxqWUZ4K6OpTJ9GsFSh7U3WSCwKwVbD/tiRQaQY5VrSJE906RludAZlDIALz1+mMJv522BolT1QYxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595821; c=relaxed/simple;
	bh=bGcMrfwK8s/C4aGlR3rRRJSQWsUvLfds1ertT+RI7j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKPVu17VYIUrQXrmtQEJDbj1Ri4P4K/2rUW90prwW6ph+SHd2lTVPkpxr20D8j5XUSFHWY7H0CRJ7tY5z+8pqO9fWfv39xMKKn5pL3k9mvLPFtxEE4c7/IU5BQ8H4M7di2jkTeVE6Mz6c4zoq/pqmZZ3SXq/bLdWO9QKkl9tWUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bCzgofBk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fsDq3Mkr; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bCzgofBk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fsDq3Mkr"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id D5FDE1800103;
	Mon, 13 May 2024 06:23:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 13 May 2024 06:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595819; x=1715682219; bh=apshIu4FQp
	37RyQaUCdjw07Ew4lfnJKZ/xhBaaRANZY=; b=bCzgofBk4TuXTQ6ZKDi7OhYDY5
	bMwxGKRFbRRaoah5yBw8gxqJfR58cve4YNqZ45Q8PFv+Gs/2wS/3ibwWGD9wD8Qv
	ZCA5pRlnjjsl3WaBrKjbUUO1X/OP+elmXw+DpZLoHmiLiTFOHT8Ah8AkYWlxPRY0
	j9BqHCyt+D+PGV8O/wDBhcUu0ehFDc1LS9EqZXz3sIksJozc8DayefIttX0AUPvR
	Mv77QJpwX7tqkm2GMKgjwkGs2eZR4P4zd7iStH76ED75zJRJUH9cQ2dWbF6117mc
	d4z7ig4czqfOYd8IMdsUXvTEcq7thZQu2Vl3QrMzEa7Qz6f1DW66ZHjznHEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595819; x=1715682219; bh=apshIu4FQp37RyQaUCdjw07Ew4lf
	nJKZ/xhBaaRANZY=; b=fsDq3MkrzmYdhG1EDr1A8juHX4aC4FRK5kJd5NKmlXAf
	o2ay50oSigpid92my4Jgp0SO3xNOTJu1N86YQBufNiChbCmtfHnE0ltc9Tr8yP8Y
	4o0ci0MG+FsOXM4xWtt+gGKQcgQdmz81s+gmVnik0UbDSJwSnvIQHWASIigYVx2U
	z9mKVQzXPnn8yjUqoMRYBuNhdF250gWPi6jC+nCHSY7ASY7THWXmAGqjT6D+iR0U
	JujButAkGldQLFJWoNt6hQPIXCeN4Hbk/Z++kU0slhgDaWx/z3N4gaf8jsWp8krG
	GagMWODce3O2jZUT5unzmNdRmubzIkR6CnO8DLaYFA==
X-ME-Sender: <xms:K-pBZvIZWjROK16TEMMNZSaRXBRS5dfSAJ6ecT2K4J2rniUdnIqupg>
    <xme:K-pBZjKUukwJlKi3t7JfYAN8TyzoLpyCX-6MNTaNSvnoh_8xoesp15K1LHgE4l6zf
    WpNTTz9RRLvkT7XeA>
X-ME-Received: <xmr:K-pBZntdDj5FDwts7gyfBCI8BEjBsZFqPvm2VeMFGnA0Ny_TXOGdShOSNx5Ncb9r-ri212icO0igTvMDerQJES1b54BI9fmHNUrUWByFfjn-guY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:K-pBZoa7YXBUBVr_Cv8ZP5FkUr6cKZ6hA70XB3JCZkRcdCrhPSQNxQ>
    <xmx:K-pBZmYA4_dE9owTipHvW9XdcbZ0M0PIXtlNgbKc1H8gCffFbMGtcw>
    <xmx:K-pBZsBr8dDTFcWHwVFYgYFFfBeQ0mMmUuPfv8JOsWq_xBK41DNBmg>
    <xmx:K-pBZkbyNiWVdfhfKNHquhKFU567h2wDbvytO14K-4mJ3YR9cjWJZA>
    <xmx:K-pBZtVDnr9Wt-SQNBmJDBGEYrDmHQM4aZNIL_kHElzkdIWumYogIvEC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:23:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ede6ed2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:23:19 +0000 (UTC)
Date: Mon, 13 May 2024 12:23:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 19/21] builtin/config: track "fixed value" option via
 flags only
Message-ID: <d83c3d085e4c1dee9501949c296e0ed782ae4436.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ejjPHUmxfICK7aWQ"
Content-Disposition: inline
In-Reply-To: <cover.1715595550.git.ps@pks.im>


--ejjPHUmxfICK7aWQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We track the "fixed value" option via two separate bits: once via the
global variable `fixed_value`, and once via the CONFIG_FLAGS_FIXED_VALUE
bit in `flags`. This is confusing and may easily lead to issues when one
is not aware that this is tracked via two separate mechanisms.

Refactor the code to use the flag exclusively. We already pass it to all
the required callsites anyway, except for `collect_config()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 5737574b25..2ca23a35d2 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -124,7 +124,6 @@ struct config_display_options {
=20
 static int use_key_regexp;
 static int do_all;
-static int fixed_value;
=20
 #define TYPE_BOOL		1
 #define TYPE_INT		2
@@ -327,6 +326,7 @@ struct collect_config_data {
 	regex_t *regexp;
 	regex_t *key_regexp;
 	int do_not_match;
+	unsigned flags;
 };
=20
 static int collect_config(const char *key_, const char *value_,
@@ -340,7 +340,8 @@ static int collect_config(const char *key_, const char =
*value_,
 		return 0;
 	if (use_key_regexp && regexec(data->key_regexp, key_, 0, NULL, 0))
 		return 0;
-	if (fixed_value && strcmp(data->value_pattern, (value_?value_:"")))
+	if ((data->flags & CONFIG_FLAGS_FIXED_VALUE) &&
+	    strcmp(data->value_pattern, (value_?value_:"")))
 		return 0;
 	if (data->regexp &&
 	    (data->do_not_match ^ !!regexec(data->regexp, (value_?value_:""), 0, =
NULL, 0)))
@@ -362,6 +363,7 @@ static int get_value(const struct config_location_optio=
ns *opts,
 	struct collect_config_data data =3D {
 		.display_opts =3D display_opts,
 		.values =3D &values,
+		.flags =3D flags,
 	};
 	char *key =3D NULL;
 	int i;
@@ -1115,6 +1117,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 	struct config_display_options display_opts =3D CONFIG_DISPLAY_OPTIONS_INI=
T;
 	const char *comment_arg =3D NULL;
 	int actions =3D 0;
+	unsigned flags =3D 0;
 	struct option opts[] =3D {
 		CONFIG_LOCATION_OPTIONS(location_opts),
 		OPT_GROUP(N_("Action")),
@@ -1137,13 +1140,12 @@ static int cmd_config_actions(int argc, const char =
**argv, const char *prefix)
 		OPT_STRING(0, "default", &display_opts.default_value,
 			   N_("value"), N_("with --get, use default value when missing entry")),
 		OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readable c=
omment string (# will be prepended as needed)")),
-		OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when co=
mparing values to 'value-pattern'")),
+		OPT_BIT(0, "fixed-value", &flags, N_("use string equality when comparing=
 values to value pattern"), CONFIG_FLAGS_FIXED_VALUE),
 		OPT_BOOL(0, "includes", &location_opts.respect_includes_opt,
 			 N_("respect include directives on lookup")),
 		OPT_END(),
 	};
 	char *value =3D NULL, *comment =3D NULL;
-	int flags =3D 0;
 	int ret =3D 0;
 	struct key_value_info default_kvi =3D KVI_INIT;
=20
@@ -1193,7 +1195,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 	}
=20
 	/* check usage of --fixed-value */
-	if (fixed_value) {
+	if (flags & CONFIG_FLAGS_FIXED_VALUE) {
 		int allowed_usage =3D 0;
=20
 		switch (actions) {
@@ -1224,8 +1226,6 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 			error(_("--fixed-value only applies with 'value-pattern'"));
 			exit(129);
 		}
-
-		flags |=3D CONFIG_FLAGS_FIXED_VALUE;
 	}
=20
 	comment =3D git_config_prepare_comment_string(comment_arg);
--=20
2.45.GIT


--ejjPHUmxfICK7aWQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6iYACgkQVbJhu7ck
PpSwGQ//RMvIsu3rZsEV3GUsu4EaOc2yi3x/iY1281lzu3ZbursgFXYnfF3QkXeJ
/tktin65QpXqMDKwjkDpEtjORbzYGYabpPFNN+HDfERtozthRST4vx8VeYceNvgG
Yix2NH/gRnxixCUvMvtsxAKEmQhHEli12ie3M1XM5SSK4Bx5nQ+ZcizRVHnxzMHu
/dyhrvyjQe4jFHb4IqfuqWWV+40pO1PPZsKDkFy+YRl2F+0SZgE3WQx5TyWC93sz
Yec+h501YDZm77XxZZ5p750lbfNab7wyzjicb081pwblt1QoF5Q8ecoq1Vf5hbHw
Lp2lt0o55kQr99jlwwb3dAzxZ7i89CJMn+30KYZszc6d14mBLa+TJQSxInrIaaw7
FcI/5TC6OmwuYnQWWxVQnn4Y/Qn52qqQdQUeWW9/olJJ/lc44dIupoebskV4yGUj
BGBdxuuZWu6srhz22eTvOvr3EPeA3w5KO4bQQ0Onx5pcOIZ/3Mj+lE8omTYGEwS2
TXzlWEs7papjYzPf5I9Cmbg8HOQLDo4I8YuyFiln7bLn40ywr59wD9iHbJI4UQAQ
D0HOf1aD5Xn6wE0G3/8P5HDPz5jM9ECRcBWcQrQvUCkWchDw+coWuBFIiB5g83TY
DsEzQPj+msdHS8b+ycuXZwGyXV5hr+/gOfKH8w23OYNrQN2rP2w=
=FMZY
-----END PGP SIGNATURE-----

--ejjPHUmxfICK7aWQ--
