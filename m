Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29911422A7
	for <git@vger.kernel.org>; Mon,  6 May 2024 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985815; cv=none; b=qcRXsCFmHCFyjNmcAP0rnreaE10ZTanCfX9gCCt3GyXi2gTK6ti6JJR8B96TO2VvnjRRN+QPnwx/aN19sP5ab27mFdsTpnJW1IIWV09++wqp1F1jBiPdNvq3dGYRx5e6HQdqckpgDCgCFrZ54nBNAg+KkYswV0cTcE5BF0qkIes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985815; c=relaxed/simple;
	bh=49yspa44GMZx2HRE2gtjDewdFxbhL26qvyPLAbzysD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MK/PQIVwGUhZTtewuQu/hYPbPJ1PtpQu4FB0x6Dst/njWdQXTTSg7WdOnfbqe2h96KeuHqdG5lDKdxuf6329e6nL0OLXdZNUR2Rb48DKB+WXlQns8uq86Ys3sk2CfzXF6lWQwA2NpMsSqScd7aOdCynGqOwgfl18eiZsAM01+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TauaP8H9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gfY4ZHeZ; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TauaP8H9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gfY4ZHeZ"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id A2ADA18000D2;
	Mon,  6 May 2024 04:56:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 06 May 2024 04:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714985812; x=1715072212; bh=g5p3VpYQCJ
	JbYWmg2oNPK9uWkgJin0kMiNZ2SsnFtFE=; b=TauaP8H969+lG6QZXtGK2aEkHW
	pilTLuHHONKwbd8GRT3dckJUcNLTvrxYRWl77vHKwk9z9XmTlR/QG4hh98b9mxNV
	YiszFAIM5F9RnAhZ1UhWS5N6LuGgh/sBz+H+Ti4LTl+7SlMiPQWaSTT56Pia4KjP
	o10jawv/M2yn6y6eRpw/dr8srKIKtjiOgPRv8T+7yelKslmxDVeonshlSuvmWkpP
	60wh9BygZgpDEtgOfyQpK7ik89M8DSD0nF3GZ4KLqiyf1iuGRfFKY7hZe86DeU5E
	9vzfzwGudE0NZpaJtHCrkss6IZWXyzaow/QZ+a4hmaUEmskTIDrfIng/C6Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714985812; x=1715072212; bh=g5p3VpYQCJJbYWmg2oNPK9uWkgJi
	n0kMiNZ2SsnFtFE=; b=gfY4ZHeZHwA+cyTY8qIx+YDPnXE1DTEFusibEGk+oU+z
	RvjfJSHqCzkjG2UoH2bgXxOveud6dFsYeN7MpMmCw0iOIolaokWmb/QIHQfpn2SF
	zIChw7lgFA95eiTc1fXdFmH2RoR7a3hBZ30JZ+dEZqyue0Ji6Udqqpw4CZNSfeqT
	lTGTMfUi2Kbwy5vx/X9mCXHi7nCCZutc9QjW2/PPqFOW0n2FYl5FBAO8pkPqCTV7
	5jNkJKDDy4Y1WVppA13nxrDlCSn6vcoPXAry9azOaVK4dOJp1lmIbOcVjBT7CUoj
	TlY+OuQSdffxa/8XDyzfFYyYFQHbfqfXl7da88xsfw==
X-ME-Sender: <xms:VJs4ZurpTTyvIZ1Id7Jt_7IXQjb48xli28j3TZW1dZQxzDvxgKpR9Q>
    <xme:VJs4ZsrwAoX-b-Xk8Sbl9aJiEl614yilQM0urE6-k_-f6Y63ZAqKgeaXpFQ-34Kk5
    EML1PcKstxCJe_ccA>
X-ME-Received: <xmr:VJs4ZjNaLmQSY6ywkKTZ8mYbXcsyFb3V3lW4xRYSr8VMm4AllNyqO1IOVBLFveOnU-WO3CB50i6XAY8GdQwE1m5O95o5zRPet3dMCkbythgT2bu0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:VJs4Zt6lrfLaRmmE0n_wvL0jgtjPlII3Flzg0A1-Eg-yDpSdS143Fg>
    <xmx:VJs4Zt7X4P_ULKWSceHygVynsLMgqcvNYnuN5sfCh1oDivWOe283JA>
    <xmx:VJs4Ztj5O_prXikJ5d3XDmS672emwRAzQaoK5AR3CwMMevHUXPeCSA>
    <xmx:VJs4Zn4Cv4PiyOIffBdcWj3xtdP1t6HMCZYSDXOHWVDAt_9_zrrH-g>
    <xmx:VJs4Zns1RAMeEvDMj-FzeZozcb3Z-D0TDo9tAgz-WFhv1DaDdM-BY00W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 04:56:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 39c9cb1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 08:56:44 +0000 (UTC)
Date: Mon, 6 May 2024 10:56:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>, rsbecker@nexbridge.com
Subject: [PATCH v5 12/14] builtin/config: introduce "remove-section"
 subcommand
Message-ID: <8ec214755ea1e37f2b49e9d5f88a8d719ed84996.1714982328.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714982328.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SnDh7dN2HECvPovT"
Content-Disposition: inline
In-Reply-To: <cover.1714982328.git.ps@pks.im>


--SnDh7dN2HECvPovT
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


--SnDh7dN2HECvPovT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4m08ACgkQVbJhu7ck
PpT++g/+JW5s3pxfp8ZgD8jLjkCuAEFuO5Hj6Tzg9LHdQgi/W32JQeSX8rfDyoZp
Ncf+HyU7B75/RG8djh26DJdSHvS3W0BqDlnm2bx83FcqymvmZLz9havszqNiJQou
m9lp0/tq3zad8Zsxw1YEG/byuiUea6I7sj2JOHGV95TQ9DUOARtsEeFIyDWUqF9l
IQw5FrON6Zr0K7nkCOFslaHH3qdWW9X9760qSKpJfl4e1UsjgyT9yTN/ryl3W63E
Zvqi/4XMXQFjo66aQwKZvaJbj9UGGFj+0bl/i95Y0RwF2DsiQxWOc7DTMMJRQbCe
HmyyinAiYRcUqjjmPXzoU69rLONDHNkQhq5dj9Qbu6zoDsWudMkiKZdHv3WhT0aS
GYeddamgSdIoTLLMpzUsuI/U7tf07cAIfJRtKESsSz3G3VSOmzVBWi3EbY1UtBz+
rEOJelkzmMvFHMGW7iv+ybtThMwxp+vIcm1kk/31yXecf7hi8IYUGLA1vYoCdu1G
CDkl58fR2keUheVAu8Jpv8u6anWlmTsgoAmY9U2IhC7cFKFRCzkSMBOSkyUkPMMd
Bfc7lU8RcMCyAR8rzOKgTwdmZ3GYFCOo93orF2QYasEnk+YL49p25Ef70IpP15sF
bSstDlJSKpcT53rTel13GP5TW5f4RzUsHDGPcWsEZeCHO0OUxcM=
=srV7
-----END PGP SIGNATURE-----

--SnDh7dN2HECvPovT--
