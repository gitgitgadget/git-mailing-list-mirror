Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B9856B99
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 23:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199266; cv=none; b=Anez/VSK2eyQpaQxeHsv+QX5/CTN6/t/hqqO5oWmSPAgYQ5JFZhr+8yDX0+99KbdQ4kyOBiAOQ7nKA7myyPEfvrNTwqHIEEUmiSkec8Rt+aqNo7pKtu32J8jfXT7Ut1JTJPMaDCLiBdJIfbx3o1l2Ag5tUvHrI90dW3Tiz6vhxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199266; c=relaxed/simple;
	bh=HvclNO4rMVyjwnuxTop954JUuEHV7cmA1tjRBsLLRQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dl0NadiDN6p0aE6WedWFZ5WWOdX24iLWHWptyZ7sHkMsbwq5rxSmWwWEdQ1Cjo0ANZXcpF6LuJvViFNIoIHIT2CInRaZHeefK5DqbZB6KwmGERtJke/c+MsNnMltlRfBo6pEdwKYs4xih7brMva1Y1aS0ZoVGT0951ajnzP1n48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dAAYWe/p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nGXhumWi; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dAAYWe/p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nGXhumWi"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 826D8138011E;
	Mon, 11 Mar 2024 19:21:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 11 Mar 2024 19:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710199263; x=1710285663; bh=QNspwcjDOk
	hPzV/2f5hJMOWvTDnMNB1gV/eWjdfjpfA=; b=dAAYWe/peqacQKVrXolBeBykUn
	ddvQk0NFRfYFwW17PrNev7b7pPQECWHqarwOU3OEsrauEHP6ESESLf17NkDyIRpL
	9QHizgkWTSMbjq6EyHMHuYw0WOKLzqBKWuRaGM9MCRmtImd3Vh9OdYS/bzTaSntY
	MSKoxcIziAqzwGuntxYJEfoJEvD9SksYeqcLrLZgUm9ynHBDu6pIKUcrpEBKXZjI
	L/cxfydT0DdimTUfBaXV30KoYX6PPN50UoZrIgWv9RUaRhi9/sfmhHn+Kr/RyfrA
	8V7W94c3IWHb1r2uBhXqF7lpNQmfN5uuY+wzniU6orrB12bTEnVVvrMoDrNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710199263; x=1710285663; bh=QNspwcjDOkhPzV/2f5hJMOWvTDnM
	NB1gV/eWjdfjpfA=; b=nGXhumWiHX5ZXKfyzporfnHTrIDHrUP6QpGoB5pg3pXq
	i4hoY8YK9ZqCRln9uIXqWVpktmPVlWnYi9vIcRBs4E7EDBrnJ3Nj6CVpNlwZu9r5
	7kWckGtRwPbCGR8cMH653Rt+57gfovsrVz/PTFghcFXPU0Fxka0pDaDi9W/WvtM1
	2UQVoHYaw06aUc9drcjIG4c/x0cIq0xMo31FhEC4Mc6BdQgnl1LzFkpKRu2zLHek
	YjSIdPcpZ6NkowPyyGdCtaI7smwI95Xmvu68vomHNM5bRUH7yCEvOJL6q9EnaC/O
	kltZcTcuWvUmRyuBAF2HtD3FT7STUsjfX4pDDn1cNg==
X-ME-Sender: <xms:35HvZee0Tk-EQyie7gyXEhcCmwWGspa9005Bsnub8si3C15-wgC0qw>
    <xme:35HvZYOs9NkxXmfOcad8moXI5iFNAORHb4eb75QCpZfAuRjKEWtlYxPc2dZPQ6THt
    aJR8mM4kDkQf7hOaA>
X-ME-Received: <xmr:35HvZfh9TzqpPkbV2O2Jtp5RuSQXkxAA8PZyROMPJ0DNQuuiqQskYilOfokjmAJdE_gowBAGOa3msjQSnrn7TrFYx5R44cfhrJ-IafKrjKxrSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeujeeitefggeelheejleetjeevtdetleetkedtgfeuvdehtddvfeelvdetjeeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhunhhithdrihhnnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:35HvZb_eiLS282qzj40st1wr9UOssEzcrgXnR8UgLp6jjYvQzB67iQ>
    <xmx:35HvZas1vgx2pQRDwI9P4XXxR8BKAVfxRANyihve5ffIV7psFdCW6g>
    <xmx:35HvZSEYv5VmE9PhVzyXwtfWX-CD_ZvP3lhSEUfengpq7jk15Anr1g>
    <xmx:35HvZeghfwRii-u0LqBGtABuZZ5VoHseVSaPHkeZn1fm2WtxyPcqcA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 19:21:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d25f084e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Mar 2024 23:16:23 +0000 (UTC)
Date: Tue, 12 Mar 2024 00:20:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/13] builtin/config: introduce "set" subcommand
Message-ID: <aa5c9743ad2efa17dc96536144bd938fdcfed584.1710198711.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1710198711.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FH25gbeRtmrQNieh"
Content-Disposition: inline
In-Reply-To: <cover.1710198711.git.ps@pks.im>


--FH25gbeRtmrQNieh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new "set" subcommand to git-config(1). Please refer to
preceding commits regarding the motivation behind this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-config.txt | 38 +++++++++------
 builtin/config.c             | 57 ++++++++++++++++++++++
 t/t1300-config.sh            | 92 +++++++++++++++++++-----------------
 3 files changed, 129 insertions(+), 58 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index f3d5e3e613..e540f41b56 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -11,9 +11,7 @@ SYNOPSIS
 [verse]
 'git config list' [<file-option>] [<display-option>] [--includes]
 'git config get' [<file-option>] [<display-option>] [--includes] [--all] [=
--regexp=3D<regexp>] [--value=3D<value>] [--fixed-value] [--default=3D<defa=
ult>] <name>
-'git config' [<file-option>] [--type=3D<type>] [--fixed-value] [--show-ori=
gin] [--show-scope] [-z|--null] <name> [<value> [<value-pattern>]]
-'git config' [<file-option>] [--type=3D<type>] --add <name> <value>
-'git config' [<file-option>] [--type=3D<type>] [--fixed-value] --replace-a=
ll <name> <value> [<value-pattern>]
+'git config set' [<file-option>] [--type=3D<type>] [--all] [--value=3D<val=
ue>] [--fixed-value] <name> <value>
 'git config' [<file-option>] [--fixed-value] --unset <name> [<value-patter=
n>]
 'git config' [<file-option>] [--fixed-value] --unset-all <name> [<value-pa=
ttern>]
 'git config' [<file-option>] --rename-section <old-name> <new-name>
@@ -27,7 +25,7 @@ You can query/set/replace/unset options with this command=
=2E The name is
 actually the section and the key separated by a dot, and the value will be
 escaped.
=20
-Multiple lines can be added to an option by using the `--add` option.
+Multiple lines can be added to an option by using the `--append` option.
 If you want to update or unset an option which can occur on multiple
 lines, a `value-pattern` (which is an extended regular expression,
 unless the `--fixed-value` option is given) needs to be given.  Only the
@@ -82,6 +80,13 @@ get::
 	last value if multiple key values were found. If `--all` is set, then
 	all values will be shown.
=20
+set::
+	Set value for one or more config options. By default, this command
+	refuses to write multi-valued config options. Passing `--all` will
+	replace all multi-valued config options with the new value, whereas
+	`--value=3D` will replace all config options whose values match the given
+	pattern.
+
 [[OPTIONS]]
 OPTIONS
 -------
@@ -90,10 +95,9 @@ OPTIONS
 	Default behavior is to replace at most one line. This replaces
 	all lines matching the key (and optionally the `value-pattern`).
=20
---add::
+--append::
 	Adds a new line to the option without altering any existing
-	values.  This is the same as providing '^$' as the `value-pattern`
-	in `--replace-all`.
+	values. This is the same as providing '--value=3D^$' in `set`.
=20
 --all::
 	With "get", Return all values for a multi-valued key.
@@ -283,6 +287,9 @@ recommended to migrate to the new syntax.
 'git config <name>'::
 	Replaced by `git config get <name>`.
=20
+'git config <name> <value> [<value-pattern>]'::
+	Replaced by `git config set [--value=3D<pattern>] <name> <value>`.
+
 -l::
 --list::
 	Replaced by `git config list`.
@@ -302,6 +309,9 @@ recommended to migrate to the new syntax.
 --get-color <name> [<default>]::
 	Replaced by `git config get --type=3Dcolor [--default=3D<default>] <name>=
`.
=20
+--add <name> <value>::
+	Replaced by `git config set --append <name> <value>`.
+
 CONFIGURATION
 -------------
 `pager.config` is only respected when listing configuration, i.e., when
@@ -348,7 +358,7 @@ precedence over values read earlier.  When multiple val=
ues are taken then all
 values of a key from all files will be used.
=20
 By default, options are only written to the repository specific
-configuration file. Note that this also affects options like `--replace-al=
l`
+configuration file. Note that this also affects options like `set`
 and `--unset`. *'git config' will only ever change one file at a time*.
=20
 You can limit which configuration sources are read from or written to by
@@ -484,7 +494,7 @@ Given a .git/config like this:
 you can set the filemode to true with
=20
 ------------
-% git config core.filemode true
+% git config set core.filemode true
 ------------
=20
 The hypothetical proxy command entries actually have a postfix to discern
@@ -492,7 +502,7 @@ what URL they apply to. Here is how to change the entry=
 for kernel.org
 to "ssh".
=20
 ------------
-% git config core.gitproxy '"ssh" for kernel.org' 'for kernel.org$'
+% git config set --value=3D'for kernel.org$' core.gitproxy '"ssh" for kern=
el.org'
 ------------
=20
 This makes sure that only the key/value pair for kernel.org is replaced.
@@ -534,26 +544,26 @@ If you like to live dangerously, you can replace *all=
* core.gitproxy by a
 new one with
=20
 ------------
-% git config --replace-all core.gitproxy ssh
+% git config set --all core.gitproxy ssh
 ------------
=20
 However, if you really only want to replace the line for the default proxy,
 i.e. the one without a "for ..." postfix, do something like this:
=20
 ------------
-% git config core.gitproxy ssh '! for '
+% git config set --value=3D'! for ' core.gitproxy ssh
 ------------
=20
 To actually match only values with an exclamation mark, you have to
=20
 ------------
-% git config section.key value '[!]'
+% git config set --value=3D'[!]' section.key value
 ------------
=20
 To add a new proxy, without altering any of the existing ones, use
=20
 ------------
-% git config --add core.gitproxy '"proxy-command" for example.com'
+% git config set --append core.gitproxy '"proxy-command" for example.com'
 ------------
=20
 An example to use customized color from the configuration in your
diff --git a/builtin/config.c b/builtin/config.c
index aaa8b15e86..18f6dc69d5 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -18,6 +18,7 @@
 static const char *const builtin_config_usage[] =3D {
 	N_("git config list [<file-option>] [<display-option>] [--includes]"),
 	N_("git config get [<file-option>] [<display-option>] [--includes] [--all=
] [--regexp=3D<regexp>] [--value=3D<value>] [--fixed-value] [--default=3D<d=
efault>] <name>"),
+	N_("git config set [<file-option>] [--type=3D<type>] [--all] [--value=3D<=
value>] [--fixed-value] <name> <value>"),
 	NULL
 };
=20
@@ -31,6 +32,11 @@ static const char *const builtin_config_get_usage[] =3D {
 	NULL
 };
=20
+static const char *const builtin_config_set_usage[] =3D {
+	N_("git config set [<file-option>] [--type=3D<type>] [--all] [--value=3D<=
value>] [--fixed-value] <name> <value>"),
+	NULL
+};
+
 static char *key;
 static regex_t *key_regexp;
 static const char *value_pattern;
@@ -847,9 +853,60 @@ static int cmd_config_get(int argc, const char **argv,=
 const char *prefix)
 	return get_value(argv[0], value_pattern, flags);
 }
=20
+static int cmd_config_set(int argc, const char **argv, const char *prefix)
+{
+	const char *value_pattern =3D NULL;
+	int flags =3D 0, append =3D 0;
+	struct option opts[] =3D {
+		CONFIG_LOCATION_OPTIONS,
+		CONFIG_TYPE_OPTIONS,
+		OPT_GROUP(N_("Filter")),
+		OPT_BIT(0, "all", &flags, N_("replace multi-valued config option with ne=
w value"), CONFIG_FLAGS_MULTI_REPLACE),
+		OPT_STRING(0, "value", &value_pattern, N_("pattern"), N_("show config wi=
th values matching the pattern")),
+		OPT_BIT(0, "fixed-value", &flags, N_("use string equality when comparing=
 values to value pattern"), CONFIG_FLAGS_FIXED_VALUE),
+		OPT_GROUP(N_("Other")),
+		OPT_BOOL(0, "append", &append, N_("add a new line without altering any e=
xisting values")),
+		OPT_END(),
+	};
+	struct key_value_info default_kvi =3D KVI_INIT;
+	char *value;
+	int ret;
+
+	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_set_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	check_write();
+	check_argc(argc, 2, 2);
+
+	if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
+		die(_("--fixed-value only applies with --value=3D<pattern>"));
+	if (append && value_pattern)
+		die(_("--append cannot be used with --value=3D<pattern>"));
+	if (append)
+		value_pattern =3D CONFIG_REGEX_NONE;
+
+	handle_config_location(prefix);
+
+	value =3D normalize_value(argv[0], argv[1], &default_kvi);
+
+	if ((flags & CONFIG_FLAGS_MULTI_REPLACE) || value_pattern) {
+		ret =3D git_config_set_multivar_in_file_gently(given_config_source.file,
+							     argv[0], value, value_pattern,
+							     flags);
+	} else {
+		ret =3D git_config_set_in_file_gently(given_config_source.file, argv[0],=
 value);
+		if (ret =3D=3D CONFIG_NOTHING_SET)
+			error(_("cannot overwrite multiple values with a single value\n"
+			"       Use a regexp, --add or --replace-all to change %s."), argv[0]);
+	}
+
+	free(value);
+	return ret;
+}
+
 static struct option builtin_subcommand_options[] =3D {
 	OPT_SUBCOMMAND("list", &subcommand, cmd_config_list),
 	OPT_SUBCOMMAND("get", &subcommand, cmd_config_get),
+	OPT_SUBCOMMAND("set", &subcommand, cmd_config_set),
 	OPT_END(),
 };
=20
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 7f6746936e..2c2d97e0e9 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -20,12 +20,16 @@ legacy)
 	mode_get=3D""
 	mode_get_all=3D"--get-all"
 	mode_get_regexp=3D"--get-regexp"
+	mode_set=3D""
+	mode_replace_all=3D"--replace-all"
 	;;
 subcommands)
 	mode_prefix=3D""
 	mode_get=3D"get"
 	mode_get_all=3D"get --all"
 	mode_get_regexp=3D"get --regexp --all --show-names"
+	mode_set=3D"set"
+	mode_replace_all=3D"set --all"
 	;;
 *)
 	echo "unknown mode $mode" >&2
@@ -41,7 +45,7 @@ cat > expect << EOF
 	penguin =3D little blue
 EOF
 test_expect_success 'initial' '
-	git config section.penguin "little blue" &&
+	git config ${mode_set} section.penguin "little blue" &&
 	test_cmp expect .git/config
 '
=20
@@ -51,7 +55,7 @@ cat > expect << EOF
 	Movie =3D BadPhysics
 EOF
 test_expect_success 'mixed case' '
-	git config Section.Movie BadPhysics &&
+	git config ${mode_set} Section.Movie BadPhysics &&
 	test_cmp expect .git/config
 '
=20
@@ -63,7 +67,7 @@ cat > expect << EOF
 	WhatEver =3D Second
 EOF
 test_expect_success 'similar section' '
-	git config Sections.WhatEver Second &&
+	git config ${mode_set} Sections.WhatEver Second &&
 	test_cmp expect .git/config
 '
=20
@@ -76,7 +80,7 @@ cat > expect << EOF
 	WhatEver =3D Second
 EOF
 test_expect_success 'uppercase section' '
-	git config SECTION.UPPERCASE true &&
+	git config ${mode_set} SECTION.UPPERCASE true &&
 	test_cmp expect .git/config
 '
=20
@@ -192,14 +196,14 @@ test_expect_success 'multiple unset is correct' '
 cp .git/config2 .git/config
=20
 test_expect_success '--replace-all missing value' '
-	test_must_fail git config --replace-all beta.haha &&
+	test_must_fail git config ${mode_replace_all} beta.haha &&
 	test_cmp .git/config2 .git/config
 '
=20
 rm .git/config2
=20
 test_expect_success '--replace-all' '
-	git config --replace-all beta.haha gamma
+	git config ${mode_replace_all} beta.haha gamma
 '
=20
 cat > expect << EOF
@@ -226,7 +230,7 @@ noIndent=3D sillyValue ; 'nother silly comment
 [nextSection] noNewline =3D ouch
 EOF
 test_expect_success 'really mean test' '
-	git config beta.haha alpha &&
+	git config ${mode_set} beta.haha alpha &&
 	test_cmp expect .git/config
 '
=20
@@ -241,7 +245,7 @@ noIndent=3D sillyValue ; 'nother silly comment
 	nonewline =3D wow
 EOF
 test_expect_success 'really really mean test' '
-	git config nextsection.nonewline wow &&
+	git config ${mode_set} nextsection.nonewline wow &&
 	test_cmp expect .git/config
 '
=20
@@ -715,16 +719,16 @@ EOF
=20
 test_expect_success 'section ending' '
 	rm -f .git/config &&
-	git config gitcvs.enabled true &&
-	git config gitcvs.ext.dbname %Ggitcvs1.%a.%m.sqlite &&
-	git config gitcvs.dbname %Ggitcvs2.%a.%m.sqlite &&
+	git config ${mode_set} gitcvs.enabled true &&
+	git config ${mode_set} gitcvs.ext.dbname %Ggitcvs1.%a.%m.sqlite &&
+	git config ${mode_set} gitcvs.dbname %Ggitcvs2.%a.%m.sqlite &&
 	test_cmp expect .git/config
=20
 '
=20
 test_expect_success numbers '
-	git config kilo.gram 1k &&
-	git config mega.ton 1m &&
+	git config ${mode_set} kilo.gram 1k &&
+	git config ${mode_set} mega.ton 1m &&
 	echo 1024 >expect &&
 	echo 1048576 >>expect &&
 	git config --int --get kilo.gram >actual &&
@@ -733,20 +737,20 @@ test_expect_success numbers '
 '
=20
 test_expect_success '--int is at least 64 bits' '
-	git config giga.watts 121g &&
+	git config ${mode_set} giga.watts 121g &&
 	echo  >expect &&
 	test_cmp_config 129922760704 --int --get giga.watts
 '
=20
 test_expect_success 'invalid unit' '
-	git config aninvalid.unit "1auto" &&
+	git config ${mode_set} aninvalid.unit "1auto" &&
 	test_cmp_config 1auto aninvalid.unit &&
 	test_must_fail git config --int --get aninvalid.unit 2>actual &&
 	test_grep "bad numeric config value .1auto. for .aninvalid.unit. in file =
=2Egit/config: invalid unit" actual
 '
=20
 test_expect_success 'invalid unit boolean' '
-	git config commit.gpgsign "1true" &&
+	git config ${mode_set} commit.gpgsign "1true" &&
 	test_cmp_config 1true commit.gpgsign &&
 	test_must_fail git config --bool --get commit.gpgsign 2>actual &&
 	test_grep "bad boolean config value .1true. for .commit.gpgsign." actual
@@ -776,14 +780,14 @@ EOF
=20
 test_expect_success bool '
=20
-	git config bool.true1 01 &&
-	git config bool.true2 -1 &&
-	git config bool.true3 YeS &&
-	git config bool.true4 true &&
-	git config bool.false1 000 &&
-	git config bool.false2 "" &&
-	git config bool.false3 nO &&
-	git config bool.false4 FALSE &&
+	git config ${mode_set} bool.true1 01 &&
+	git config ${mode_set} bool.true2 -1 &&
+	git config ${mode_set} bool.true3 YeS &&
+	git config ${mode_set} bool.true4 true &&
+	git config ${mode_set} bool.false1 000 &&
+	git config ${mode_set} bool.false2 "" &&
+	git config ${mode_set} bool.false3 nO &&
+	git config ${mode_set} bool.false4 FALSE &&
 	rm -f result &&
 	for i in 1 2 3 4
 	do
@@ -794,7 +798,7 @@ test_expect_success bool '
=20
 test_expect_success 'invalid bool (--get)' '
=20
-	git config bool.nobool foobar &&
+	git config ${mode_set} bool.nobool foobar &&
 	test_must_fail git config --bool --get bool.nobool'
=20
 test_expect_success 'invalid bool (set)' '
@@ -983,7 +987,7 @@ test_expect_success 'get --expiry-date' '
=20
 test_expect_success 'get --type=3Dcolor' '
 	rm .git/config &&
-	git config foo.color "red" &&
+	git config ${mode_set} foo.color "red" &&
 	git config --get --type=3Dcolor foo.color >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	echo "<RED>" >expect &&
@@ -1020,10 +1024,10 @@ cat > expect << EOF
 EOF
 test_expect_success 'quoting' '
 	rm -f .git/config &&
-	git config quote.leading " test" &&
-	git config quote.ending "test " &&
-	git config quote.semicolon "test;test" &&
-	git config quote.hash "test#test" &&
+	git config ${mode_set} quote.leading " test" &&
+	git config ${mode_set} quote.ending "test " &&
+	git config ${mode_set} quote.semicolon "test;test" &&
+	git config ${mode_set} quote.hash "test#test" &&
 	test_cmp expect .git/config
 '
=20
@@ -1031,7 +1035,7 @@ test_expect_success 'key with newline' '
 	test_must_fail git config ${mode_get} "key.with
 newline" 123'
=20
-test_expect_success 'value with newline' 'git config key.sub value.with\\\
+test_expect_success 'value with newline' 'git config ${mode_set} key.sub v=
alue.with\\\
 newline'
=20
 cat > .git/config <<\EOF
@@ -1089,7 +1093,7 @@ test_expect_success '--null --get-regexp' '
 '
=20
 test_expect_success 'inner whitespace kept verbatim' '
-	git config section.val "foo 	  bar" &&
+	git config ${mode_set} section.val "foo 	  bar" &&
 	test_cmp_config "foo 	  bar" section.val
 '
=20
@@ -1127,12 +1131,12 @@ test_expect_success 'check split_cmdline return' '
 	git init repo &&
 	(
 		cd repo &&
-		git config alias.split-cmdline-fix "echo \"" &&
+		git config ${mode_set} alias.split-cmdline-fix "echo \"" &&
 		test_must_fail git split-cmdline-fix &&
 		echo foo >foo &&
 		git add foo &&
 		git commit -m "initial commit" &&
-		git config branch.main.mergeoptions "echo \"" &&
+		git config ${mode_set} branch.main.mergeoptions "echo \"" &&
 		test_must_fail git merge main
 	)
 '
@@ -1170,12 +1174,12 @@ test_expect_success 'key sanity-checking' '
 	test_must_fail git config ${mode_get} foo.1bar &&
 	test_must_fail git config ${mode_get} foo."ba
 				z".bar &&
-	test_must_fail git config . false &&
-	test_must_fail git config .foo false &&
-	test_must_fail git config foo. false &&
-	test_must_fail git config .foo. false &&
-	git config foo.bar true &&
-	git config foo."ba =3Dz".bar false
+	test_must_fail git config ${mode_set} . false &&
+	test_must_fail git config ${mode_set} .foo false &&
+	test_must_fail git config ${mode_set} foo. false &&
+	test_must_fail git config ${mode_set} .foo. false &&
+	git config ${mode_set} foo.bar true &&
+	git config ${mode_set} foo."ba =3Dz".bar false
 '
=20
 test_expect_success 'git -c works with aliases of builtins' '
@@ -2398,7 +2402,7 @@ test_expect_success '--replace-all does not invent ne=
wlines' '
 	[abc]
 	Qkey =3D b
 	EOF
-	git config --replace-all abc.key b &&
+	git config ${mode_replace_all} abc.key b &&
 	test_cmp expect .git/config
 '
=20
@@ -2470,8 +2474,8 @@ test_expect_success 'refuse --fixed-value for incompa=
tible actions' '
 	test_must_fail git config --file=3Dconfig --fixed-value --get-colorbool d=
ev.null &&
=20
 	# These modes complain when --fixed-value has no value-pattern
-	test_must_fail git config --file=3Dconfig --fixed-value dev.null bogus &&
-	test_must_fail git config --file=3Dconfig --fixed-value --replace-all dev=
=2Enull bogus &&
+	test_must_fail git config ${mode_set} --file=3Dconfig --fixed-value dev.n=
ull bogus &&
+	test_must_fail git config ${mode_replace_all} --file=3Dconfig --fixed-val=
ue dev.null bogus &&
 	test_must_fail git config ${mode_prefix}get --file=3Dconfig --fixed-value=
 dev.null &&
 	test_must_fail git config ${mode_get_all} --file=3Dconfig --fixed-value d=
ev.null &&
 	test_must_fail git config ${mode_get_regexp} --file=3Dconfig --fixed-valu=
e "dev.*" &&
@@ -2512,7 +2516,7 @@ test_expect_success '--fixed-value uses exact string =
matching' '
 	test_must_fail git config ${mode_get} --file=3Dconfig fixed.test &&
=20
 	cp initial config &&
-	git config --file=3Dconfig --replace-all fixed.test bogus "$META" &&
+	git config --file=3Dconfig fixed.test bogus "$META" &&
 	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-EOF &&
 	fixed.test=3D$META
--=20
2.44.0


--FH25gbeRtmrQNieh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXvkdcACgkQVbJhu7ck
PpS03BAArSHuKjq5u+JkqyggT99VK4NgaG0beD3VMwltB905hA9KCWl2jGmwy4vo
8Nvvw/d/l9XF8QHH/E9YTRs0swfELSWd8+3zx5iJZZosqxMurhhROaunYzbkcDVE
JCMsW8S+kEZQDGgMa/8g0EUHNghKmT0+2cGJBkXbMs+nXKFXZTAXRUSlZJhHY12S
jEbHg7adbuyOfp5Lwxf5SBSIfcgXeDqS4SpG6wrgn2YrCZijMqIvq95J00ztWrjd
cQw/fh93j+3OIgZweBcj+PotGSqXY9kF4ty1LZEK57iUBIPqfKnnfwsHDPlMLpv2
9xkBk291szuG/wTWyFzboXgwae2Bs5x8eAaFhswLOqaZi0YhHz3E5wjdZ9fvptAC
5vt/Rz/rADElOxDkUvSbRT7NMphNPjqq1gdG46vga0DW/c/qB5n8UpMLCvD3Wxeg
rg9RW9ZS8TeGzBc/1KTCWiagCG7tlufmL06550YMxsmJGnowBpd/L8wOpkvjd0um
76disVpmqggux9hyOlPADLnrSnoKmbTRIX69PZB3gbCSaC+QkdSXJ4EVycxktmQe
8NbuDQXoxyPD0aXaXWTSlLjLi1EaIIe+0ZGbk/oYYjQDCvUKXyg14PczA21rgc/G
ztTejaw/9q4+n/C90mzorpfBnBqZNQvRoDz+y9n7Dr0HjQU9RnA=
=ZFI7
-----END PGP SIGNATURE-----

--FH25gbeRtmrQNieh--
