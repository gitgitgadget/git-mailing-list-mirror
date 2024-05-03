Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BB114F9E8
	for <git@vger.kernel.org>; Fri,  3 May 2024 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730255; cv=none; b=VQND0xxenSvcCzxiQkZiMfDoT/tAL4Lca39AslO4zGCFr4jnQCbkCp3zZRtWveIdJT7lRbdCqf3KYrMpjROpFZl+oJqQxM8f2ufVout2kagTm035VH0D/z8AmeFk4u675rbN3RfKY8m02Q8pY2DRU4+AxQg/+N7Yqb33ma96HC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730255; c=relaxed/simple;
	bh=nLCkhMJbNoWei2FmQkfXCT88aarilPULTdtgRMNGqUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eURTjZ8FBrBRHzWF3yAVWDROca89k/GjnZ2SWdYuIiuRDcYY9Mp7Np1OAX4gh7fvwN+KlHdmA+3l4ehfILLFUr4jyQbU0EdYotZx6Wymk3Pvd8BTEykZ0/ncIAPXUSDlAhOKiIRBGnd7RhR15QPhSKgyMQGJWV0Neep/GF5V2G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VbP9hlmL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rw6Zg1jF; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VbP9hlmL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rw6Zg1jF"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2D3FC18000BE;
	Fri,  3 May 2024 05:57:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 03 May 2024 05:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714730252; x=1714816652; bh=emLlLS5utG
	k2MJmk1Dizkq2AO9RDtQCFv2Bn8wiziM8=; b=VbP9hlmLQihypoo6TPEnddISL9
	E4ApAF7qpCPs0CFUnsnpbCGwiIFk9xamKdZomjCFs9pcW1WB3AYootJ+dCVgEZZt
	6p8r6OYVvqIliGD6PfwXQHzZBj/pAiGUAk2+zOU5LG0Qt4KaiHvDGidqPkH5FovQ
	oR8ORYtZYgbfVOydvrP9+LBHQqEvxgpVSgU8OJME7A8xySm75waslxh4QpaNKaY8
	c5A5KjtEcImNyRcZB/QoY58cLYGVj65exB0YJ5xFbwBGrQdJiG8T+DSO7r8JafFt
	TNoN9yLjVsPuk4uvHgkhIaR+58Z+DX+D+9zdt9P8Zs+SOREYYYYsbyXjHAYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714730252; x=1714816652; bh=emLlLS5utGk2MJmk1Dizkq2AO9RD
	tQCFv2Bn8wiziM8=; b=Rw6Zg1jFGGzuHN1T6ayXz8E7kVP6nYp6TqDHcOoP+/5c
	nHWr8ZkqprOU/m1OWdZj97KpY5jecztXVZ4NEByvuROPod8Y3tjlQgzlnSXXiL8f
	rQaGFnC26IK06G6Cqhto5eHRmiAJRRe+VoqrhIAXuX9lb4hrjevY3ZStFWVCWdFp
	O3Ty2WfiBv+vTNb3znewihwUaQr43YpIuaEupBYa38LHOnhaVsYOLAyFzXr4Bs1Y
	YKPk/aIByYR0I4I8B9oZaXxWQU2i7HpZ4NC4YZVos7/LzrNdarLSpWaofLs4gSLc
	w99k2CEDNWKxNCF6OfoiFGfTdvxO88Lnql8PESK8zQ==
X-ME-Sender: <xms:DLU0Zln47FqHe_Z5HismOIg2SFKOX9ohiAGeo04134OQWlwTkeKDnQ>
    <xme:DLU0Zg3QBwYqbuS95D-5oiwP5PYuVtfJC7rExI32LB2p7YpdEGUm3M47htG-x37Un
    5OTctGLKeOcTMQhXg>
X-ME-Received: <xmr:DLU0Zrqbm59QrTWshKLf73i0kyQ4nExupVXDiruRk7pZXx7vs7gIDDZ5wKuGftDFabCGWWGx7lUbBHqLIm_mB9Fm_ZNxyRUbK5SsAYW49_HtujYY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepieevkedtgffgleeugfdvledvfedthfegueegfeevjeelueefkeegfeffhefglefg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:DLU0ZlnWheMAlLgLGmp0Oma44xIJF0FcJj94PtYAGfn84MwA0uL4kg>
    <xmx:DLU0Zj3-3yIdoxrMBaDiyOu95OB3aACsnuXTgfZ7NJORabHFQN0bmg>
    <xmx:DLU0Zkuq7N4XOpweyO-Dn85AVy4WWNPI-EqMJpujGVhLtKFyqnWiyA>
    <xmx:DLU0ZnV1hQWo0Zs-PgbJ7HfO1NitEbThWmsm9ELYnv5AxDNrKDRYvw>
    <xmx:DLU0Ztol3YO2wwq3hwEtW-k-8j1RIjJiL5ebjbAExf2mZBOBi9pzVFQM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 05:57:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id eabfe0d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 09:57:03 +0000 (UTC)
Date: Fri, 3 May 2024 11:57:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 10/14] builtin/config: introduce "unset" subcommand
Message-ID: <e25e5b69cd60f5e6f6779158ddfc67cda51da52e.1714730170.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714730169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mX730volSyX0CxbO"
Content-Disposition: inline
In-Reply-To: <cover.1714730169.git.ps@pks.im>


--mX730volSyX0CxbO
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


--mX730volSyX0CxbO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0tQcACgkQVbJhu7ck
PpQg3Q//TXy+Qlg3TyJI8gImb+QV7YITzeIZjyAUvq0ZpT0TnCgvOHwfeT2xusC0
ver9C2mgjpgTWGutXs6LYe9mh0xCsgJU1oiSqoNQSSM34/ujmj6zdF4W14VNcjyX
fma/yPdkKjT+ZtTA/mg0P6B9fcTTJU4EWCeMngbKa3bBOTRJaW85N7k27EkmtGXo
IwwVEzmNsjEJZOEPERc9KpqH1YdOPxrM2C48dJGIXoSMYkF+LnS/uBqsdFFXCb2E
bB2Rq/bJSd5r4MmsesNgNwJMJbUnKpIUn+q2QJ3k1H12xrZNJ5pM3yAwJdC+CkUc
nwC6TMtpVMaltb4uLYKrqhoEnSBeUN1iJvxHtLKt9fDOMVqMzha5el1i8wblC9NR
0TAQ2ffBAIJQmGhFw7N67NakNUsnnYzw96E+3b8jKEsB5Ye4T8swoychrQxCfrEl
9ujLSrAIMBSyxZjuZp+9upCXkMSC11Lvw69n9xkhrjPXHVbc1knhNGwCZZZeqoa9
q8B/TE1a9iTrMG8tHIOgNN99gKyh2h3rm5LbVnAcEcTvQOH3GYZJ+i4HVkqeJbYC
gMQw66zipaLf0eBCc1JFUWsBUHbRFavjBepVO7KA/Vln5OC1irylgOsZEW1xbzid
rOW950djneXSUMpEccOIdZz7JB5thYxDm/758VW7ZseCO9nOy4o=
=EFrS
-----END PGP SIGNATURE-----

--mX730volSyX0CxbO--
