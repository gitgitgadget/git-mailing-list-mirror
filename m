Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4371422D8
	for <git@vger.kernel.org>; Mon,  6 May 2024 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985805; cv=none; b=XgwU0OBUmQrJuGuWyRc4gZY1R9h7RIOtPlVLdSEyl8yULu16b5d2lkhDBHMwWuxGIvaMSD2hWph2gLmbZOUjUFEDqhVkk3MLhH3+yfeh2PyIW1YBLlXyFoQpgvqnJEC0nZczRu5F/M8B/qiYXYudDAORAud7BYGrfhGkrlkfA2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985805; c=relaxed/simple;
	bh=Q8ZMj9icnrUpe+Up6TiX1iVSNFm8ApCLPyiVKGFOeaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoX9pLHqWG6i6y8C8brtlxgNGBsTA3g+lbGWtO2lNIQdSE/vh9NaQq5OQ4/WwJJEhILAWmhPcNg2wvYkxGCwolnMd8O1vrHTmq2KyfxGJia9HvOAcH+U5BE0f30Erz/5ZGpSIPowKXXDOCXOIMq3wjd2Wl0OB9FBirzYZlBBbNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sUkPOkWz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R0cvdUge; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sUkPOkWz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R0cvdUge"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id BD0BF18000CC;
	Mon,  6 May 2024 04:56:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 06 May 2024 04:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714985802; x=1715072202; bh=HviME28Q4e
	NMiZRwL9jLRK0pV0Tkhhp4SGBXvlbzxx0=; b=sUkPOkWz/u5/rQ/dBD1PrWxzEH
	SrBZ4Ni6uN2Ztm04PsgIP6isHOt+fpIkv+Wyjf+QssOGHTrIDaUW0nOsEfqle/7w
	XjHb8k9yvb4chQhX4QTbSq2Bk/LAZ949lP8NW3SeDSStEDylIDGbwDfSm3NTiG2Q
	E7/8g6XHYQ1H7QbYe/5Xr5gB1QH9vZSTw/L7YpKmvOha27ETVVt5QPdI1mZwaJtw
	dO4KRzyDg4MAQcQVPAU/UX5N9Zxu6SdP5fKj85yUoJcyRe6G1SQWe8oo+qmqFQYy
	t+bEMmFHvXFGoPEloDSbYWs7dOpj5hPb0pCzs3QKWDt1lSL0eu8hQlVlaNcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714985802; x=1715072202; bh=HviME28Q4eNMiZRwL9jLRK0pV0Tk
	hhp4SGBXvlbzxx0=; b=R0cvdUgeAOU3+RUt9k2GOBfm2rqu27uYNC4APQ/TnvLV
	meO/Ea5zyiHqC6Vcr9lKqfJTJeH4mOSwf4frYFoF0nHlHc+DM59B2aWQRCc+9iu/
	Ew9PFFtQslXSzJHnA3hctijl4aAvmRe5RwJtgrRzyIrTir1NiuxUxQeuMtpJWzsO
	VE2c/eyLjBcTmDw83UOIVtEY26/TEBKcU6YLnYt9WAXrzk7hrN7MCqEusJcvneKz
	1xN+Z5L7QwIT+9fTOzT+E3hBKkUxM9+XQ2xXKReypbkeRKgZhrwKAlU5Ygwfi5kl
	aADT2LtvJXy7NZ5Ol6uS8CM9CmnNaGUgnQgWyBPDxQ==
X-ME-Sender: <xms:Sps4Zuu_GV1NXHYn6xaYgFTeoT2oU7gj4Jfpe8BSDV3D16m6dikndw>
    <xme:Sps4Zjf1_cStK90S7j8CtNiHHEh4e-LV4fklHohxU0QpystqaevlOJPdeF0BbeH1n
    nCYkVMFpkahDjVKiQ>
X-ME-Received: <xmr:Sps4ZpwqhcKqPVCWwB8AhN3l5lTOd9MzFZ9VLEh6M9BzK3DeR8c3s0fPM9xIWEhvE9A4mhichbXJtShtwgnTZCKPDfSnTdLc_mB7Tl8MK8FDcR1Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepieevkedtgffgleeugfdvledvfedthfegueegfeevjeelueefkeegfeffhefglefg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Sps4ZpO4rkudTQ_cCaXCMOOfM0b1UXotb_CYfPcE2s6VI_YIea2sMA>
    <xmx:Sps4Zu9sABGAKcTqoD3PXJAEu9ve7Ia_xxEZzr9ETRENAJNRfxcC1w>
    <xmx:Sps4ZhW4R847Z4x3jW5xPjq04Yjdyc1IkXI9qPfsfQl7kjvOXaL4Eg>
    <xmx:Sps4ZnfQ5Z9L-sFQJJHeMcdg418lk8w0U5xmekr2-1cFiuDu9nWWTA>
    <xmx:Sps4ZiTyg3QAmuHjF9y9Ea1zCeRKVzLB7qtPcEJZ4zDQA5yZP_WXou0b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 04:56:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 086a5cb7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 08:56:35 +0000 (UTC)
Date: Mon, 6 May 2024 10:56:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>, rsbecker@nexbridge.com
Subject: [PATCH v5 10/14] builtin/config: introduce "unset" subcommand
Message-ID: <e525c2326a3908bf77edf1e5e0752a34a28b4449.1714982328.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714982328.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iH3dSIgQNVbeAZrQ"
Content-Disposition: inline
In-Reply-To: <cover.1714982328.git.ps@pks.im>


--iH3dSIgQNVbeAZrQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new "unset" subcommand to git-config(1). Please refer to
preceding commits regarding the motivation behind this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-config.txt | 27 +++++++++++++---------
 builtin/config.c             | 39 ++++++++++++++++++++++++++++++++
 t/t1300-config.sh            | 44 ++++++++++++++++++++++++------------
 3 files changed, 84 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index f57fa01085..5575fe55ea 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -11,9 +11,8 @@ SYNOPSIS
 [verse]
 'git config list' [<file-option>] [<display-option>] [--includes]
 'git config get' [<file-option>] [<display-option>] [--includes] [--all] [=
--regexp=3D<regexp>] [--value=3D<value>] [--fixed-value] [--default=3D<defa=
ult>] <name>
-'git config set' [<file-option>] [--type=3D<type>] [--comment=3D<message>]=
 [--all] [--value=3D<value>] [--fixed-value] <name> <value>
-'git config' [<file-option>] [--fixed-value] --unset <name> [<value-patter=
n>]
-'git config' [<file-option>] [--fixed-value] --unset-all <name> [<value-pa=
ttern>]
+'git config set' [<file-option>] [--type=3D<type>] [--all] [--value=3D<val=
ue>] [--fixed-value] <name> <value>
+'git config unset' [<file-option>] [--all] [--value=3D<value>] [--fixed-va=
lue] <name> <value>
 'git config' [<file-option>] --rename-section <old-name> <new-name>
 'git config' [<file-option>] --remove-section <name>
 'git config' [<file-option>] --get-colorbool <name> [<stdout-is-tty>]
@@ -87,6 +86,12 @@ set::
 	`--value=3D` will replace all config options whose values match the given
 	pattern.
=20
+unset::
+	Unset value for one or more config options. By default, this command
+	refuses to unset multi-valued keys. Passing `--all` will unset all
+	multi-valued config options, whereas `--value` will unset all config
+	options whose values match the given pattern.
+
 [[OPTIONS]]
 OPTIONS
 -------
@@ -190,12 +195,6 @@ See also <<FILES>>.
 --rename-section::
 	Rename the given section to a new name.
=20
---unset::
-	Remove the line matching the key from config file.
-
---unset-all::
-	Remove all lines matching the key from config file.
-
 --fixed-value::
 	When used with the `value-pattern` argument, treat `value-pattern` as
 	an exact string instead of a regular expression. This will restrict
@@ -325,6 +324,12 @@ recommended to migrate to the new syntax.
 --add <name> <value>::
 	Replaced by `git config set --append <name> <value>`.
=20
+--unset <name> [<value-pattern>]::
+	Replaced by `git config unset [--value=3D<pattern>] <name>`.
+
+--unset-all <name> [<value-pattern>]::
+	Replaced by `git config unset [--value=3D<pattern>] --all <name>`.
+
 CONFIGURATION
 -------------
 `pager.config` is only respected when listing configuration, i.e., when
@@ -372,7 +377,7 @@ values of a key from all files will be used.
=20
 By default, options are only written to the repository specific
 configuration file. Note that this also affects options like `set`
-and `--unset`. *'git config' will only ever change one file at a time*.
+and `unset`. *'git config' will only ever change one file at a time*.
=20
 You can limit which configuration sources are read from or written to by
 specifying the path of a file with the `--file` option, or by specifying a
@@ -523,7 +528,7 @@ This makes sure that only the key/value pair for kernel=
=2Eorg is replaced.
 To delete the entry for renames, do
=20
 ------------
-% git config --unset diff.renames
+% git config unset diff.renames
 ------------
=20
 If you want to delete an entry for a multivar (like core.gitproxy above),
diff --git a/builtin/config.c b/builtin/config.c
index 87fd12fda2..2578d4c930 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -19,6 +19,7 @@ static const char *const builtin_config_usage[] =3D {
 	N_("git config list [<file-option>] [<display-option>] [--includes]"),
 	N_("git config get [<file-option>] [<display-option>] [--includes] [--all=
] [--regexp=3D<regexp>] [--value=3D<value>] [--fixed-value] [--default=3D<d=
efault>] <name>"),
 	N_("git config set [<file-option>] [--type=3D<type>] [--all] [--value=3D<=
value>] [--fixed-value] <name> <value>"),
+	N_("git config unset [<file-option>] [--all] [--value=3D<value>] [--fixed=
-value] <name> <value>"),
 	NULL
 };
=20
@@ -37,6 +38,11 @@ static const char *const builtin_config_set_usage[] =3D {
 	NULL
 };
=20
+static const char *const builtin_config_unset_usage[] =3D {
+	N_("git config unset [<file-option>] [--all] [--value=3D<value>] [--fixed=
-value] <name> <value>"),
+	NULL
+};
+
 static char *key;
 static regex_t *key_regexp;
 static const char *value_pattern;
@@ -911,10 +917,43 @@ static int cmd_config_set(int argc, const char **argv=
, const char *prefix)
 	return ret;
 }
=20
+static int cmd_config_unset(int argc, const char **argv, const char *prefi=
x)
+{
+	const char *value_pattern =3D NULL;
+	int flags =3D 0;
+	struct option opts[] =3D {
+		CONFIG_LOCATION_OPTIONS,
+		OPT_GROUP(N_("Filter")),
+		OPT_BIT(0, "all", &flags, N_("replace multi-valued config option with ne=
w value"), CONFIG_FLAGS_MULTI_REPLACE),
+		OPT_STRING(0, "value", &value_pattern, N_("pattern"), N_("show config wi=
th values matching the pattern")),
+		OPT_BIT(0, "fixed-value", &flags, N_("use string equality when comparing=
 values to value pattern"), CONFIG_FLAGS_FIXED_VALUE),
+		OPT_END(),
+	};
+
+	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_unset_usa=
ge,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	check_write();
+	check_argc(argc, 1, 1);
+
+	if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
+		die(_("--fixed-value only applies with 'value-pattern'"));
+
+	handle_config_location(prefix);
+
+	if ((flags & CONFIG_FLAGS_MULTI_REPLACE) || value_pattern)
+		return git_config_set_multivar_in_file_gently(given_config_source.file,
+							      argv[0], NULL, value_pattern,
+							      NULL, flags);
+	else
+		return git_config_set_in_file_gently(given_config_source.file, argv[0],
+						     NULL, NULL);
+}
+
 static struct option builtin_subcommand_options[] =3D {
 	OPT_SUBCOMMAND("list", &subcommand, cmd_config_list),
 	OPT_SUBCOMMAND("get", &subcommand, cmd_config_get),
 	OPT_SUBCOMMAND("set", &subcommand, cmd_config_set),
+	OPT_SUBCOMMAND("unset", &subcommand, cmd_config_unset),
 	OPT_END(),
 };
=20
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index aa3f179be5..2ab58bbd95 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -22,6 +22,8 @@ legacy)
 	mode_get_regexp=3D"--get-regexp"
 	mode_set=3D""
 	mode_replace_all=3D"--replace-all"
+	mode_unset=3D"--unset"
+	mode_unset_all=3D"--unset-all"
 	;;
 subcommands)
 	mode_prefix=3D""
@@ -30,6 +32,8 @@ subcommands)
 	mode_get_regexp=3D"get --regexp --all --show-names"
 	mode_set=3D"set"
 	mode_replace_all=3D"set --all"
+	mode_unset=3D"unset"
+	mode_unset_all=3D"unset --all"
 	;;
 *)
 	BUG "unknown mode $mode";;
@@ -259,7 +263,7 @@ foo =3D bar
 EOF
=20
 test_expect_success 'unset with cont. lines' '
-	git config --unset beta.baz
+	git config ${mode_unset} beta.baz
 '
=20
 cat > expect <<\EOF
@@ -286,7 +290,7 @@ EOF
 cp .git/config .git/config2
=20
 test_expect_success 'multiple unset' '
-	git config --unset-all beta.haha
+	git config ${mode_unset_all} beta.haha
 '
=20
 cat > expect << EOF
@@ -372,7 +376,7 @@ noIndent=3D sillyValue ; 'nother silly comment
 	nonewline =3D wow
 EOF
 test_expect_success 'unset' '
-	git config --unset beta.haha &&
+	git config ${mode_unset} beta.haha &&
 	test_cmp expect .git/config
 '
=20
@@ -428,11 +432,11 @@ test_expect_success 'multivar replace' '
 '
=20
 test_expect_success 'ambiguous unset' '
-	test_must_fail git config --unset nextsection.nonewline
+	test_must_fail git config ${mode_unset} nextsection.nonewline
 '
=20
 test_expect_success 'invalid unset' '
-	test_must_fail git config --unset somesection.nonewline
+	test_must_fail git config ${mode_unset} somesection.nonewline
 '
=20
 cat > expect << EOF
@@ -446,7 +450,12 @@ noIndent=3D sillyValue ; 'nother silly comment
 EOF
=20
 test_expect_success 'multivar unset' '
-	git config --unset nextsection.nonewline "wow3$" &&
+	case "$mode" in
+	legacy)
+		git config --unset nextsection.nonewline "wow3$";;
+	subcommands)
+		git config unset --value=3D"wow3$" nextsection.nonewline;;
+	esac &&
 	test_cmp expect .git/config
 '
=20
@@ -2013,7 +2022,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	# please be careful when you update the above variable
 	EOF
=20
-	git config --unset section.key &&
+	git config ${mode_unset} section.key &&
 	test_cmp expect .git/config &&
=20
 	cat >.git/config <<-\EOF &&
@@ -2026,7 +2035,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	[next-section]
 	EOF
=20
-	git config --unset section.key &&
+	git config ${mode_unset} section.key &&
 	test_cmp expect .git/config &&
=20
 	q_to_tab >.git/config <<-\EOF &&
@@ -2036,7 +2045,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	[two]
 	key =3D true
 	EOF
-	git config --unset two.key &&
+	git config ${mode_unset} two.key &&
 	! grep two .git/config &&
=20
 	q_to_tab >.git/config <<-\EOF &&
@@ -2046,7 +2055,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	[one]
 	key =3D true
 	EOF
-	git config --unset-all one.key &&
+	git config ${mode_unset_all} one.key &&
 	test_line_count =3D 0 .git/config &&
=20
 	q_to_tab >.git/config <<-\EOF &&
@@ -2056,7 +2065,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	[two]
 	Qkey =3D true
 	EOF
-	git config --unset two.key &&
+	git config ${mode_unset} two.key &&
 	grep two .git/config &&
=20
 	q_to_tab >.git/config <<-\EOF &&
@@ -2068,7 +2077,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	[TWO "subsection"]
 	[one]
 	EOF
-	git config --unset two.subsection.key &&
+	git config ${mode_unset} two.subsection.key &&
 	test "not [two subsection]" =3D "$(git config ${mode_get} one.key)" &&
 	test_line_count =3D 3 .git/config
 '
@@ -2080,7 +2089,7 @@ test_expect_success '--unset-all removes section if e=
mpty & uncommented' '
 	key =3D value2
 	EOF
=20
-	git config --unset-all section.key &&
+	git config ${mode_unset_all} section.key &&
 	test_line_count =3D 0 .git/config
 '
=20
@@ -2604,8 +2613,8 @@ test_expect_success 'refuse --fixed-value for incompa=
tible actions' '
 	test_must_fail git config ${mode_prefix}get --file=3Dconfig --fixed-value=
 dev.null &&
 	test_must_fail git config ${mode_get_all} --file=3Dconfig --fixed-value d=
ev.null &&
 	test_must_fail git config ${mode_get_regexp} --file=3Dconfig --fixed-valu=
e "dev.*" &&
-	test_must_fail git config --file=3Dconfig --fixed-value --unset dev.null =
&&
-	test_must_fail git config --file=3Dconfig --fixed-value --unset-all dev.n=
ull
+	test_must_fail git config ${mode_unset} --file=3Dconfig --fixed-value dev=
=2Enull &&
+	test_must_fail git config ${mode_unset_all} --file=3Dconfig --fixed-value=
 dev.null
 '
=20
 test_expect_success '--fixed-value uses exact string matching' '
@@ -2635,6 +2644,11 @@ test_expect_success '--fixed-value uses exact string=
 matching' '
 	git config --file=3Dconfig --fixed-value --unset fixed.test "$META" &&
 	test_must_fail git config ${mode_get} --file=3Dconfig fixed.test &&
=20
+	cp initial config &&
+	test_must_fail git config unset --file=3Dconfig --value=3D"$META" fixed.t=
est &&
+	git config unset --file=3Dconfig --fixed-value --value=3D"$META" fixed.te=
st &&
+	test_must_fail git config ${mode_get} --file=3Dconfig fixed.test &&
+
 	cp initial config &&
 	test_must_fail git config --file=3Dconfig --unset-all fixed.test "$META" =
&&
 	git config --file=3Dconfig --fixed-value --unset-all fixed.test "$META" &&
--=20
2.45.0


--iH3dSIgQNVbeAZrQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4m0UACgkQVbJhu7ck
PpQq0Q//VTdir+G+fNIHuUjpVUA0hlm8ECQn+JjCHwRjYqlRGpKuQDV+uoJ+fQlv
GSPA0WoG83ja1mn/EmZgqMDJU3Drmu4zvdHRuVjLAxo0VzFRlMuFwtJXr053pvdL
Hujrj3aDPp17kMP4yX2YaFc/lquBO+c8L8TCeVilUy8u+BYf0iDCZiDyiaiBLSFe
diat4DN2SyTUVqfI5iDTAp8XiBxdshFB9fifAJQZOVy6MWgtsqebH8Sr2bS08ytU
t5MyTQGZBlPaI2EpnG3e/FeEbvmHlBVXvz2PqVPH8qUR8FYrIG65I52bffK+iXeC
scl8tSZhiu23k2pskWjy6pPO10LxzmfMaT19dVUnJwwa0dxgW27F7rRF21ZU7a51
nLJkLTeJZ28KtyClZLRRF+N7XdhomQipE28LU1G6JSTRVNDROqJ4LORvw1ZV85gC
lrh2in9hahqd5TgHQjNng+c7Ho38iugqlwOm0BnlW/wQCB5cmHOI1ltwNZNUMgfq
oyIVvlPrIdgmEEcsgo1v/Dq1GiP9UbRX+y2RGyU0b2kICnnWhioS/KYaQ52aYeDs
wRQsYWyjtEF2VbQKM2uXNOnmYSjvkYfCwQ/RgtlNZPcg4uxMiyn/Wzmh1XAPPKkg
1J+ZGDSTxI0zOGaXJHTK2ns4y6+l0iIxjgEGDEnclUJc4JNeD6o=
=GWy4
-----END PGP SIGNATURE-----

--iH3dSIgQNVbeAZrQ--
