Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B32214F9D8
	for <git@vger.kernel.org>; Fri,  3 May 2024 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730260; cv=none; b=DccNtGvcvLXh7kqkIQOy1IIZ3gN0l71O4fQsqRo2Jn24XLrHajAdE5zDkTkOko19jcTE+ay/sKKJ8Db0tAOrB1vnYb9Ngsg/YBYRhDDWZl/zeQyxkrvnWYQsIlVtoijzqzxjF1X9H/T/WjUrZsqsDBV6I600fHvCk13NAJG49DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730260; c=relaxed/simple;
	bh=TF+F93DDnn67tOxSySw5vXMfRHZqtkWoMf+gC8H+3ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxDd/kQQscw/wy6t4PLcGJW/QeUSfS1/IExKB4q2RKYn9fnUK+/FRsiixA/PUBgNW+EdrU0aLPVospub+ScHfJqTRM6c7yhs9ChDNoxuutZvMAyuzAfuqHNgIG8bHamKnPh4myh7lxbjzL0JueAec6hcBYV0ZnVyLAU0/IJQIk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JdYrJFDP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HeadPfVv; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JdYrJFDP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HeadPfVv"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id B1D661800130;
	Fri,  3 May 2024 05:57:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 03 May 2024 05:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714730257; x=1714816657; bh=r8s8Yd/QTx
	JPimGTDZdce2JjJnPDi2VchQocpRx95Pc=; b=JdYrJFDPn80tCJjTDDITYJvPCZ
	8q015qZ+4Wee4JhqT1qr9m23NO7g3AvcFItn9bg/NGASL2karhFk4+p0ikzDXztM
	OB3B8gnctkkIFlaQCdWnD+joiWyj4gXiJhjhyP6Fs0qhBYjfpfSWSZnnu68IAZCi
	MocjyIE+Dtocj2QRGpIiZHC6WrIjDnhwBs+qu6Ogst2scKshFe3hyWH6+6bfE/4M
	KaiFs7ssO2U7AU2R0XRBjtoahmXUzAqZtXmB92Me7g8QHEiaGBWs4F8sezW7NN3V
	EGD4TciaUfGkm+GClqV9eK+g5X7lR56vQzwDkC7FaUCULFZVYJrpo88s9AkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714730257; x=1714816657; bh=r8s8Yd/QTxJPimGTDZdce2JjJnPD
	i2VchQocpRx95Pc=; b=HeadPfVvRZ5tOcCznLejsmgezls+2murAmpMhDbkgipX
	K9wBNjIOoWGAC+soeKlL6EfC2sWOAhuKjhg9D9S1QTSSryUURYwheKM4hj+80R2e
	vAMfrrHf9xqo2XBagbqWYaKNc7X/Osvzd9/HaEpR02uC7Sa5DJhJJcs5A3ia5ATu
	I0J0PXKu6xik0W2XYv11oPZM4HzxgzHZlmyYU+SVJHXVAjy26kHq+OFhb2cKymVF
	HsgLc0dQrswdrdK2VjdebuzR1Rbfy2Nk/N5j/WzL9NSIP2Mq0mWsTvMw++asiXSt
	1iYch8j9L+gSsyTSi8qSa83otg7MEeM19REUkPloXg==
X-ME-Sender: <xms:EbU0Zof1gGNWbRM6JaQ1YQ0jKlbedBDW96Gi77jycf9KKkxDwd-NBw>
    <xme:EbU0ZqPw6ezemIYi7QrSICiLepu-k7GjoZdDOxvgDFzGR8CfB9SNqit-vCKdTDvzR
    UiV6ocz2kkUvbFxbg>
X-ME-Received: <xmr:EbU0Zpg_cjWlZOcjx7r_xvzlbqAKCZu8brcwTiKAgjqiBHYwHBykZYUlwmfXNeyjK-JYXue1LQSQMa8IlUBpPg_b8dhdgKh6MIqZWFZ4yd0kX5ec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:EbU0Zt8PyxtVluWSNmCjpGrRghvU8cHK6eH6b5aB0mVju2ws1Kkeyg>
    <xmx:EbU0Zkvgj4X5z7BLVnu_7cL6rgxsoR6YJfqK9mXv0hDP0v7zTRHJag>
    <xmx:EbU0ZkF-0HHfjnTMQJ2T_ltzino629Ha_eI7D3CPBxmhIqPSnmiljA>
    <xmx:EbU0ZjO5vfs_DbGsO7wsYr6DjKaOxuwnjHY25no8MHkWacZGzWhfnA>
    <xmx:EbU0ZojKQtIzZMUtv8pFOiMBGsI80QbnyKAfDWIyrJ6FaC2X2kBeKP_e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 05:57:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0457b159 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 09:57:08 +0000 (UTC)
Date: Fri, 3 May 2024 11:57:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 11/14] builtin/config: introduce "rename-section"
 subcommand
Message-ID: <f24008d3563a07445ebf8d63ec3a86f4c0983010.1714730170.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714730169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MPijdJPjqOrTAdVv"
Content-Disposition: inline
In-Reply-To: <cover.1714730169.git.ps@pks.im>


--MPijdJPjqOrTAdVv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new "rename-section" subcommand to git-config(1). Please
refer to preceding commits regarding the motivation behind this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-config.txt | 11 +++++++----
 builtin/config.c             | 32 ++++++++++++++++++++++++++++++++
 t/t1300-config.sh            | 22 +++++++++++-----------
 3 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 5575fe55ea..ede86ad085 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git config get' [<file-option>] [<display-option>] [--includes] [--all] [=
--regexp=3D<regexp>] [--value=3D<value>] [--fixed-value] [--default=3D<defa=
ult>] <name>
 'git config set' [<file-option>] [--type=3D<type>] [--all] [--value=3D<val=
ue>] [--fixed-value] <name> <value>
 'git config unset' [<file-option>] [--all] [--value=3D<value>] [--fixed-va=
lue] <name> <value>
-'git config' [<file-option>] --rename-section <old-name> <new-name>
+'git config rename-section' [<file-option>] <old-name> <new-name>
 'git config' [<file-option>] --remove-section <name>
 'git config' [<file-option>] --get-colorbool <name> [<stdout-is-tty>]
 'git config' [<file-option>] -e | --edit
@@ -92,6 +92,9 @@ unset::
 	multi-valued config options, whereas `--value` will unset all config
 	options whose values match the given pattern.
=20
+rename-section::
+	Rename the given section to a new name.
+
 [[OPTIONS]]
 OPTIONS
 -------
@@ -192,9 +195,6 @@ See also <<FILES>>.
 --remove-section::
 	Remove the given section from the configuration file.
=20
---rename-section::
-	Rename the given section to a new name.
-
 --fixed-value::
 	When used with the `value-pattern` argument, treat `value-pattern` as
 	an exact string instead of a regular expression. This will restrict
@@ -330,6 +330,9 @@ recommended to migrate to the new syntax.
 --unset-all <name> [<value-pattern>]::
 	Replaced by `git config unset [--value=3D<pattern>] --all <name>`.
=20
+--rename-section <old-name> <new-name>::
+	Replaced by `git config rename-section <old-name> <new-name>`.
+
 CONFIGURATION
 -------------
 `pager.config` is only respected when listing configuration, i.e., when
diff --git a/builtin/config.c b/builtin/config.c
index 2578d4c930..a60dca9b2b 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -20,6 +20,7 @@ static const char *const builtin_config_usage[] =3D {
 	N_("git config get [<file-option>] [<display-option>] [--includes] [--all=
] [--regexp=3D<regexp>] [--value=3D<value>] [--fixed-value] [--default=3D<d=
efault>] <name>"),
 	N_("git config set [<file-option>] [--type=3D<type>] [--all] [--value=3D<=
value>] [--fixed-value] <name> <value>"),
 	N_("git config unset [<file-option>] [--all] [--value=3D<value>] [--fixed=
-value] <name> <value>"),
+	N_("git config rename-section [<file-option>] <old-name> <new-name>"),
 	NULL
 };
=20
@@ -43,6 +44,11 @@ static const char *const builtin_config_unset_usage[] =
=3D {
 	NULL
 };
=20
+static const char *const builtin_config_rename_section_usage[] =3D {
+	N_("git config rename-section [<file-option>] <old-name> <new-name>"),
+	NULL
+};
+
 static char *key;
 static regex_t *key_regexp;
 static const char *value_pattern;
@@ -949,11 +955,37 @@ static int cmd_config_unset(int argc, const char **ar=
gv, const char *prefix)
 						     NULL, NULL);
 }
=20
+static int cmd_config_rename_section(int argc, const char **argv, const ch=
ar *prefix)
+{
+	struct option opts[] =3D {
+		CONFIG_LOCATION_OPTIONS,
+		OPT_END(),
+	};
+	int ret;
+
+	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_rename_se=
ction_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	check_write();
+	check_argc(argc, 2, 2);
+
+	handle_config_location(prefix);
+
+	ret =3D git_config_rename_section_in_file(given_config_source.file,
+						argv[0], argv[1]);
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
+	OPT_SUBCOMMAND("rename-section", &subcommand, cmd_config_rename_section),
 	OPT_END(),
 };
=20
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 2ab58bbd95..5d7b08fa4c 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -699,7 +699,7 @@ weird
 EOF
=20
 test_expect_success 'rename section' '
-	git config --rename-section branch.eins branch.zwei
+	git config ${mode_prefix}rename-section branch.eins branch.zwei
 '
=20
 cat > expect << EOF
@@ -718,7 +718,7 @@ test_expect_success 'rename succeeded' '
 '
=20
 test_expect_success 'rename non-existing section' '
-	test_must_fail git config --rename-section \
+	test_must_fail git config ${mode_prefix}rename-section \
 		branch."world domination" branch.drei
 '
=20
@@ -727,7 +727,7 @@ test_expect_success 'rename succeeded' '
 '
=20
 test_expect_success 'rename another section' '
-	git config --rename-section branch."1 234 blabl/a" branch.drei
+	git config ${mode_prefix}rename-section branch."1 234 blabl/a" branch.drei
 '
=20
 cat > expect << EOF
@@ -750,7 +750,7 @@ cat >> .git/config << EOF
 EOF
=20
 test_expect_success 'rename a section with a var on the same line' '
-	git config --rename-section branch.vier branch.zwei
+	git config ${mode_prefix}rename-section branch.vier branch.zwei
 '
=20
 cat > expect << EOF
@@ -771,11 +771,11 @@ test_expect_success 'rename succeeded' '
 '
=20
 test_expect_success 'renaming empty section name is rejected' '
-	test_must_fail git config --rename-section branch.zwei ""
+	test_must_fail git config ${mode_prefix}rename-section branch.zwei ""
 '
=20
 test_expect_success 'renaming to bogus section is rejected' '
-	test_must_fail git config --rename-section branch.zwei "bogus name"
+	test_must_fail git config ${mode_prefix}rename-section branch.zwei "bogus=
 name"
 '
=20
 test_expect_success 'renaming a section with a long line' '
@@ -784,7 +784,7 @@ test_expect_success 'renaming a section with a long lin=
e' '
 		printf "  c =3D d %1024s [a] e =3D f\\n" " " &&
 		printf "[a] g =3D h\\n"
 	} >y &&
-	git config -f y --rename-section a xyz &&
+	git config ${mode_prefix}rename-section -f y a xyz &&
 	test_must_fail git config -f y b.e
 '
=20
@@ -794,7 +794,7 @@ test_expect_success 'renaming an embedded section with =
a long line' '
 		printf "  c =3D d %1024s [a] [foo] e =3D f\\n" " " &&
 		printf "[a] g =3D h\\n"
 	} >y &&
-	git config -f y --rename-section a xyz &&
+	git config ${mode_prefix}rename-section -f y a xyz &&
 	test_must_fail git config -f y foo.e
 '
=20
@@ -804,7 +804,7 @@ test_expect_success 'renaming a section with an overly-=
long line' '
 		printf "  c =3D d %525000s e" " " &&
 		printf "[a] g =3D h\\n"
 	} >y &&
-	test_must_fail git config -f y --rename-section a xyz 2>err &&
+	test_must_fail git config ${mode_prefix}rename-section -f y a xyz 2>err &&
 	grep "refusing to work with overly long line in .y. on line 2" err
 '
=20
@@ -2112,7 +2112,7 @@ test_expect_success POSIXPERM,PERL 'preserves existin=
g permissions' '
 	git config imap.pass Hunter2 &&
 	perl -e \
 	  "die q(badset) if ((stat(q(.git/config)))[2] & 07777) !=3D 0600" &&
-	git config --rename-section imap pop &&
+	git config ${mode_prefix}rename-section imap pop &&
 	perl -e \
 	  "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) !=3D 0600"
 '
@@ -2601,7 +2601,7 @@ test_expect_success 'refuse --fixed-value for incompa=
tible actions' '
 	test_must_fail git config --file=3Dconfig --fixed-value --add dev.null bo=
gus &&
 	test_must_fail git config --file=3Dconfig --fixed-value --get-urlmatch de=
v.null bogus &&
 	test_must_fail git config --file=3Dconfig --fixed-value --get-urlmatch de=
v.null bogus &&
-	test_must_fail git config --file=3Dconfig --fixed-value --rename-section =
dev null &&
+	test_must_fail git config ${mode_prefix}rename-section --file=3Dconfig --=
fixed-value dev null &&
 	test_must_fail git config --file=3Dconfig --fixed-value --remove-section =
dev &&
 	test_must_fail git config ${mode_prefix}list --file=3Dconfig --fixed-valu=
e &&
 	test_must_fail git config --file=3Dconfig --fixed-value --get-color dev.n=
ull &&
--=20
2.45.0


--MPijdJPjqOrTAdVv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0tQwACgkQVbJhu7ck
PpT6Vg/9HONhgFZG/Cld6//Y+ECiPehc+PwB4FXCyWKJrq58cePqiEYQ1peLXQGx
PnDBZPZW1lyE5XvZa75M4TXM+Icz+8MBEYozy1pgoePYdJc7bs8+JBsYxtAP4xyw
EEd1rUC/0/yXnIkndf3hflpi/Hr1msOuJPzzTGcIJPyzJnlyIZpSwNfZOOy+r4R6
0zJCDWv/RhIil3vLegHPw/aOiFIq4vbwo8zx+s/4fR/k1LFOSQHaWMa1AW4Qltmb
iAcSdvw0im22g2Mm5pSyc941y8uji3y2LPIS61tByNTuCCQfMV1+dVK3OmpWY5gL
Crcfu/hTDYWksw3o9AhreFig6nKVeL8tEC/ZNaRecP7EA9QrdHCzFbqhFm9P8rba
MwjI2uJChEIuyDTsKELh3B/L5nFl+h0oHOvj3LlaZaqhqppD2woUtMtTpaJj6aYg
fRPPUDfd7VNjFzxdpTZQYiRdDaXyO2RGmuGkTCh/Nxcp406qGNOHBaUnhriFDfH4
noVeJgTxFiLbHLLyKgCHp2O8bWPG8DucvefG86j2i1bhJeyGQRGYG7OosKVbpUwt
8QT1QA4he3CvPRsW/dMN9fzcQx5br4m4x8pvBkw/vf7DiXJ05tRz4GVzQD8LIhns
2wBN/15tseRhVIEvvAAbH2PAoUZaJEZc44digsP9bzkokj6bhiU=
=B17A
-----END PGP SIGNATURE-----

--MPijdJPjqOrTAdVv--
