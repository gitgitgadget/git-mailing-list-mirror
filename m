Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05F31422D0
	for <git@vger.kernel.org>; Mon,  6 May 2024 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985810; cv=none; b=PAQ2CCCS7X9jafyOQJ+c7D1ARYByKCT+oKbvN6z0iGww6OHaOmW01GuJS2RgqVWyWF/rhXvs+5/UaEEYinKjBMKjqSL6JkNDzFbNNdZFkAqMdHXH0XBswBhtY6QuVTkM+4r3xpscFciEZ+EHyZkwNJL7vhSn2F4Qa6JfXRMkQMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985810; c=relaxed/simple;
	bh=ItUyQnbSaQXzVVwB0QWlVMaMOoPo/TVpx0OH9ZVs0vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TISx+vcWql7Yp6QweGXJ2C9eInK3jQQh0sTA4Fl2kz1eajCIEGCXiQGhR/VJckZJaRyIh/CNfXLoPE7SkTr/7DnDXbRVA3tu571I1T8IKGdb1WMo/HvYK8NhhQB2t4mIwzlhXrUktrS6zd1ye1gMIiqb65Q84qT6ggeep0gjv6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GRHaNxAC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ohkrs6/2; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GRHaNxAC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ohkrs6/2"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id B119A1C0012E;
	Mon,  6 May 2024 04:56:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 06 May 2024 04:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714985807; x=1715072207; bh=F/bYwzmBiw
	+JzFjGCwWmcfiSFEvlOWvCHgPbVwUhNb4=; b=GRHaNxACjw+HSq7ElI1n3p4uHX
	2l7PB6YFMkfYNFAJWt1KXzF4/z6eulAX2Mhb1EpE3Bxflv6uCr9EAvrabPy9WuOj
	bck39in4s1PfICUyZTYxb5zIaYUtEYxIzA8GTD8d/BKqTa75DRlqg4hjhBniV3YC
	Gb1mPbv0UT9Sl8+k8Qdp3aNVhzd4NTbYg3HkZwvQa5YquwZBpQICzEvNE7HU/0EM
	kcaaVfgNZgFXc9kifYU7jW8bjfeEVNwHfKXERz3kHO6iuGspGzsHTEojjYvI3eKb
	nDpfUGSYrfgdjUn5bWT3RQ48GSyhy9LK+3Sw3wpbvTL80k0cdbUzNsTtAvcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714985807; x=1715072207; bh=F/bYwzmBiw+JzFjGCwWmcfiSFEvl
	OWvCHgPbVwUhNb4=; b=Ohkrs6/2cvkKlOZFKvaT/oEn+xlMaco1p098woh7Q/l+
	ajmcrett9Apy8JCHYaf4Nxw0hRq9l0DxXPC0jeMbbShxcOsy8y38n1KYtrWi30Nk
	eJmgsuN1zTz9uMKv1D/fUkjzeKuKVCRFGFj+1vOk4JbXdfIXtD9zT0srd2rET4kk
	z2rgH3Aoce6Odl4OPHafpAH1zks+1+PLPX3W6YR+/ENiT2j919oboEEAkYfh5OFd
	/9dGPDsbIR0g3/JYXmfSwKYSN76o2HscKhWCXE1oag8xN2JgjLXDe9XSHuVAFQkv
	P8zffUyrhcmZYh968Mifsuw0np98MJmQG1+9VRt4/A==
X-ME-Sender: <xms:T5s4Zl-59ywPDrN8ebCFqMCo8cM3jEGIQDK-H7L4-rj-VOWrVfgBSA>
    <xme:T5s4Zptjj0NrTvHrAPdG9ZkOkrzb1g7NtznedlpuTw0AQJffVrKnSpbkkkKeVxSAg
    hwRsykuap0njtLNOA>
X-ME-Received: <xmr:T5s4ZjADz8vmP0bI48k6gZs6UPk6HAJKLgVCkc2uBWilRWYjX71l_bYdb_1WkMCFcmGH4pQ4gGsU-X89Ga1HddVKWUzlDMZBStLZ4Nc0elEnhu3a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:T5s4ZpfnJJmuXwBXxgzazLZh8nTOc-Xk9IigtA-LdnUlHFhRiTZhHg>
    <xmx:T5s4ZqMJQAoYniWP7Xo30NxGZ51MSEBJexieY_hEMoLBVVeOJdPi-w>
    <xmx:T5s4ZrkoF6PJYjcQSYqIyVNkRvVfKsArVR1cs7V-45dX1yg3V7ZRyg>
    <xmx:T5s4ZksenKpu7D65clbQ6gJf1ofvtEAsND4V3i78Zds5guzL53_9Cg>
    <xmx:T5s4ZrgXBQcZ1XUC4zaZqoBXVK4gnqquSNeirip3xg55Q3JRgzaN7Qx3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 04:56:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fda5ce5d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 08:56:40 +0000 (UTC)
Date: Mon, 6 May 2024 10:56:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>, rsbecker@nexbridge.com
Subject: [PATCH v5 11/14] builtin/config: introduce "rename-section"
 subcommand
Message-ID: <a79788989049f41053b985307f35441519e6b3b9.1714982328.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714982328.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="faT9fSogMyxkRHOU"
Content-Disposition: inline
In-Reply-To: <cover.1714982328.git.ps@pks.im>


--faT9fSogMyxkRHOU
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


--faT9fSogMyxkRHOU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4m0oACgkQVbJhu7ck
PpQ2eQ//TV/d/KeLyX1Czfilz70AeO/FPhmtvv9bCHXEIkQEBdjCQFPcGxWqTSxQ
weK1177KwRAXKtg3/qHY5a/5ihDAjqBqSdy7awQ7xy8IOlYz3hx5bJrb9q10RQO+
pBF3pW7dfM2iFYA1qR8R799ZC6c/d/Pjoso1EGLzX9o9ED49/cQm8MP0hpnwTi1s
UVfFbZfkhf9zknDnmptcuaBW6xJ3fivTZHsUJA2p3im1u4kb5cycitTym03HTThs
I33vvVTIV2LbLG+mBv20PFKg2JY5qFc85kXuB7kZTFMWwL2FpMr9hI6M2bqak5T8
NCOCqn/rYJ7rAfjkfBTv0A3zCle4wWWm0ZuzYy3zDWF7qB6SONg9zDxlelUpUyyy
XqdYmonuORXEh6VNdXmmDCAsvjQRNlm+fF4DgHvq0LDBbN5nZld81PK7xaSIhUt5
HWXRx0wJU22yofgg8Tkekff6hOQ/MYCslctulz+38Hcl2F5xkCtAo1YA8CCZ30y0
BoMt1J/QVHyfWnPsP5i/dtC/8+wPi6YNeKWZZjg34t0aixBF4K0g985i1CXYZjRp
NgKIV9MkCScBd4yv4xTeA3LrbssmKFdUOzTPIoahW+d01iCPvV7ihpZRUa6Wz2IO
CzNXZk9X7A36GCimOz5PWrnv5SQwVMEvBtO9VkU8fOApER+LO28=
=WwfA
-----END PGP SIGNATURE-----

--faT9fSogMyxkRHOU--
