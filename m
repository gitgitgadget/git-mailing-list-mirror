Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFC514F9E9
	for <git@vger.kernel.org>; Fri,  3 May 2024 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730252; cv=none; b=Qw2Cbd95fv85uXd1Nsczvkud0lqz51OAk45nDmol7jIiUXUHb0LYKfN33+TSVIHHmh9qXIIj04tm+JYgO4QTOpxzU2X/UHRpzZj7lDTcpcsAgNXtZ61fTrgo2Yw0qunhN+Zyp96Kt0/iizmvE9iUm9y3O+k+drxUCvT5mOTlkT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730252; c=relaxed/simple;
	bh=uLiIBIbEQJFmgiTNf6U1Aly/K4dqN2vuIlOHrd4Oyj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNt9g5fwKZpYn23Ej1g3XjwW/yybQgbbfcRhenjjqkXKBEJH6WVLLLSqKi0gjkP11wbaPVWbx+dnx7QmbpLH8Z9BdQX3OfdfNj4WDTTv8kFF9foQ/grlYUoKgdKvXlJLEKWILYVp2m19op2cL0rHvWCKE/i8Fw1F2suKynngVOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BRsjNBID; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ipAzxlMe; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BRsjNBID";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ipAzxlMe"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 968E61C0010C;
	Fri,  3 May 2024 05:57:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 03 May 2024 05:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714730248; x=1714816648; bh=M/kQ51TU5u
	JiCXM75ZwgBJxf5QHCZh+k/KLq513bpfY=; b=BRsjNBIDLbJrQc3ReBOgjiQZ5T
	/chE29MjiL286TQHXbD2f0/r2/w48osm6iQRlgylls+ZbMhzMZ8xITKl+F6u99PF
	qJk4xh/f64vqWdKLea2icomqJq+PLzeDSNw7kBWayQqHgfG+/YCr/u2UKnBr8WZX
	Q8XGz1PhC0elzubfLERIZYDDgkdLgiNTAFb0aeWzRoVzl/rr9hxMMWSnE3KpIeUk
	62PBoRZdIzcdxRr6tJlhoS6c3Ij0TozyJaxBgCT8shBqauv2ddoO9RAEY0x8H5fw
	v021oVG6k6CXKLZn1vGI9eW5NpO/O0DPh+ARqtEvlS7qviOoauPAWgCUuqew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714730248; x=1714816648; bh=M/kQ51TU5uJiCXM75ZwgBJxf5QHC
	Zh+k/KLq513bpfY=; b=ipAzxlMeD7U1urJa9LDnjQQVD/p/4UWTJCA3mK/Encwd
	hhpo5n0WYGUXcACVano9wH+6OZxc/tQv303K11IRoS4lD3hQVvJR7c9CYj8XlCMZ
	1EbOTiFROKsdVZWp9ajLfxjJIOGMsY10KcK2ixl/0TklogyTe4ADRb3DGYqwulNJ
	CDleJeimnSelCupgFSAKi9NOmGfYvg0N4tglIh6gg+npKEk9s7pkE8fvyyTAzm5m
	ej+0llFjw+c9kQqtDuqHMQ9HzmvH+1ENrlFvmLfcT/MYn2BVR7vcoNkmtzkdlO5h
	OzrzwK2B+GvAdH1F2I+pAs5cjU6hGqRiuNCzKZ70xQ==
X-ME-Sender: <xms:CLU0ZhLARcSp7YYhyXfcw4Lr7pM-fwhf83pMj-tBHr9fQfvpicsgBA>
    <xme:CLU0ZtIP0TAoSeTr_-zS15h5BDsWsiFO1CVJK0BoB3N8FxPO9KDZQkjLutnn-2r2s
    RJN2_TqdIwbl9b8xA>
X-ME-Received: <xmr:CLU0ZpvAMkZ3bfQA3q4rEqyRG8jgElgaS9-AV0K7XU5r44gH_LWvcv_BKADVFG8_skw1eJFIzdB-ho8lVsmC2oE8LfUqXbD-hvM2CCdRe9M_jTh7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueejieetgfegleehjeelteejvedtteelteektdfguedvhedtvdefledvteejuedv
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpuhhnihhtrdhinhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:CLU0ZiawbroVDZXz8HY7vwplQ9M6C2QW3YxgYwFIXQ30kaAlasshIQ>
    <xmx:CLU0ZobormaVGPVe_9cj9vimVnx6E3NBszGKC0r7gqZQqCnLnWIKiA>
    <xmx:CLU0ZmAB0O3ccnL0LDjBW5-3NgLY75NfQhfff3eS60UXgSO9d6htwQ>
    <xmx:CLU0ZmZn6hmKntI-I7VLdesLxmoO9v3KZyaSXfDI6G5Cpzu-bn_wMg>
    <xmx:CLU0ZtNNy9QRWehqXs4ANPK-xXiA9vxfevgdxiS691KaBUWghAYq7AKj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 05:57:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 74cd9ba6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 09:56:58 +0000 (UTC)
Date: Fri, 3 May 2024 11:57:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 09/14] builtin/config: introduce "set" subcommand
Message-ID: <8a623a31b9390377a9efbc8ca97e575568a8da4f.1714730170.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714730169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I0RPF6P9sVSXSthF"
Content-Disposition: inline
In-Reply-To: <cover.1714730169.git.ps@pks.im>


--I0RPF6P9sVSXSthF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new "set" subcommand to git-config(1). Please refer to
preceding commits regarding the motivation behind this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-config.txt |  38 ++++++++-----
 builtin/config.c             |  63 ++++++++++++++++++++++
 t/t1300-config.sh            | 102 ++++++++++++++++++-----------------
 3 files changed, 140 insertions(+), 63 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index d0878663db..f57fa01085 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -11,9 +11,7 @@ SYNOPSIS
 [verse]
 'git config list' [<file-option>] [<display-option>] [--includes]
 'git config get' [<file-option>] [<display-option>] [--includes] [--all] [=
--regexp=3D<regexp>] [--value=3D<value>] [--fixed-value] [--default=3D<defa=
ult>] <name>
-'git config' [<file-option>] [--type=3D<type>] [--comment=3D<message>] [--=
fixed-value] [--show-origin] [--show-scope] [-z|--null] <name> [<value> [<v=
alue-pattern>]]
-'git config' [<file-option>] [--type=3D<type>] [--comment=3D<message>] --a=
dd <name> <value>
-'git config' [<file-option>] [--type=3D<type>] [--comment=3D<message>] [--=
fixed-value] --replace-all <name> <value> [<value-pattern>]
+'git config set' [<file-option>] [--type=3D<type>] [--comment=3D<message>]=
 [--all] [--value=3D<value>] [--fixed-value] <name> <value>
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
 	emits all values associated with key. Returns error code 1 if key is
 	not present.
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
 --comment <message>::
 	Append a comment at the end of new or modified lines.
@@ -296,6 +300,9 @@ recommended to migrate to the new syntax.
 'git config <name>'::
 	Replaced by `git config get <name>`.
=20
+'git config <name> <value> [<value-pattern>]'::
+	Replaced by `git config set [--value=3D<pattern>] <name> <value>`.
+
 -l::
 --list::
 	Replaced by `git config list`.
@@ -315,6 +322,9 @@ recommended to migrate to the new syntax.
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
@@ -361,7 +371,7 @@ precedence over values read earlier.  When multiple val=
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
@@ -497,7 +507,7 @@ Given a .git/config like this:
 you can set the filemode to true with
=20
 ------------
-% git config core.filemode true
+% git config set core.filemode true
 ------------
=20
 The hypothetical proxy command entries actually have a postfix to discern
@@ -505,7 +515,7 @@ what URL they apply to. Here is how to change the entry=
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
@@ -541,26 +551,26 @@ If you like to live dangerously, you can replace *all=
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
index 9e7ae49c02..87fd12fda2 100644
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
+	N_("git config set [<file-option>] [--type=3D<type>] [--comment=3D<messag=
e>] [--all] [--value=3D<value>] [--fixed-value] <name> <value>"),
+	NULL
+};
+
 static char *key;
 static regex_t *key_regexp;
 static const char *value_pattern;
@@ -849,9 +855,66 @@ static int cmd_config_get(int argc, const char **argv,=
 const char *prefix)
 	return get_value(argv[0], value_pattern, flags);
 }
=20
+static int cmd_config_set(int argc, const char **argv, const char *prefix)
+{
+	const char *value_pattern =3D NULL, *comment_arg =3D NULL;
+	char *comment =3D NULL;
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
+		OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readable c=
omment string (# will be prepended as needed)")),
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
+	comment =3D git_config_prepare_comment_string(comment_arg);
+
+	handle_config_location(prefix);
+
+	value =3D normalize_value(argv[0], argv[1], &default_kvi);
+
+	if ((flags & CONFIG_FLAGS_MULTI_REPLACE) || value_pattern) {
+		ret =3D git_config_set_multivar_in_file_gently(given_config_source.file,
+							     argv[0], value, value_pattern,
+							     comment, flags);
+	} else {
+		ret =3D git_config_set_in_file_gently(given_config_source.file,
+						    argv[0], comment, value);
+		if (ret =3D=3D CONFIG_NOTHING_SET)
+			error(_("cannot overwrite multiple values with a single value\n"
+			"       Use a regexp, --add or --replace-all to change %s."), argv[0]);
+	}
+
+	free(comment);
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
index 7ce13ed6cd..aa3f179be5 100755
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
 	BUG "unknown mode $mode";;
@@ -132,7 +136,7 @@ cat > expect << EOF
 	penguin =3D little blue
 EOF
 test_expect_success 'initial' '
-	git config section.penguin "little blue" &&
+	git config ${mode_set} section.penguin "little blue" &&
 	test_cmp expect .git/config
 '
=20
@@ -142,7 +146,7 @@ cat > expect << EOF
 	Movie =3D BadPhysics
 EOF
 test_expect_success 'mixed case' '
-	git config Section.Movie BadPhysics &&
+	git config ${mode_set} Section.Movie BadPhysics &&
 	test_cmp expect .git/config
 '
=20
@@ -154,7 +158,7 @@ cat > expect << EOF
 	WhatEver =3D Second
 EOF
 test_expect_success 'similar section' '
-	git config Sections.WhatEver Second &&
+	git config ${mode_set} Sections.WhatEver Second &&
 	test_cmp expect .git/config
 '
=20
@@ -167,7 +171,7 @@ cat > expect << EOF
 	WhatEver =3D Second
 EOF
 test_expect_success 'uppercase section' '
-	git config SECTION.UPPERCASE true &&
+	git config ${mode_set} SECTION.UPPERCASE true &&
 	test_cmp expect .git/config
 '
=20
@@ -194,8 +198,8 @@ EOF
=20
 test_expect_success 'append comments' '
 	git config --replace-all --comment=3D"Pygoscelis papua" section.penguin g=
entoo &&
-	git config --comment=3D"find fish" section.disposition peckish &&
-	git config --comment=3D"#abc" section.foo bar &&
+	git config ${mode_set} --comment=3D"find fish" section.disposition peckis=
h &&
+	git config ${mode_set} --comment=3D"#abc" section.foo bar &&
=20
 	git config --comment=3D"and comment" section.spsp value &&
 	git config --comment=3D"	# and comment" section.htsp value &&
@@ -204,7 +208,7 @@ test_expect_success 'append comments' '
 '
=20
 test_expect_success 'Prohibited LF in comment' '
-	test_must_fail git config --comment=3D"a${LF}b" section.k v
+	test_must_fail git config ${mode_set} --comment=3D"a${LF}b" section.k v
 '
=20
 test_expect_success 'non-match result' 'test_cmp expect .git/config'
@@ -301,14 +305,14 @@ test_expect_success 'multiple unset is correct' '
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
@@ -335,7 +339,7 @@ noIndent=3D sillyValue ; 'nother silly comment
 [nextSection] noNewline =3D ouch
 EOF
 test_expect_success 'really mean test' '
-	git config beta.haha alpha &&
+	git config ${mode_set} beta.haha alpha &&
 	test_cmp expect .git/config
 '
=20
@@ -350,7 +354,7 @@ noIndent=3D sillyValue ; 'nother silly comment
 	nonewline =3D wow
 EOF
 test_expect_success 'really really mean test' '
-	git config nextsection.nonewline wow &&
+	git config ${mode_set} nextsection.nonewline wow &&
 	test_cmp expect .git/config
 '
=20
@@ -824,16 +828,16 @@ EOF
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
@@ -842,20 +846,20 @@ test_expect_success numbers '
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
@@ -885,14 +889,14 @@ EOF
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
@@ -903,7 +907,7 @@ test_expect_success bool '
=20
 test_expect_success 'invalid bool (--get)' '
=20
-	git config bool.nobool foobar &&
+	git config ${mode_set} bool.nobool foobar &&
 	test_must_fail git config --bool --get bool.nobool'
=20
 test_expect_success 'invalid bool (set)' '
@@ -1092,7 +1096,7 @@ test_expect_success 'get --expiry-date' '
=20
 test_expect_success 'get --type=3Dcolor' '
 	rm .git/config &&
-	git config foo.color "red" &&
+	git config ${mode_set} foo.color "red" &&
 	git config --get --type=3Dcolor foo.color >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	echo "<RED>" >expect &&
@@ -1129,10 +1133,10 @@ cat > expect << EOF
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
@@ -1140,7 +1144,7 @@ test_expect_success 'key with newline' '
 	test_must_fail git config ${mode_get} "key.with
 newline" 123'
=20
-test_expect_success 'value with newline' 'git config key.sub value.with\\\
+test_expect_success 'value with newline' 'git config ${mode_set} key.sub v=
alue.with\\\
 newline'
=20
 cat > .git/config <<\EOF
@@ -1199,21 +1203,21 @@ test_expect_success '--null --get-regexp' '
=20
 test_expect_success 'inner whitespace kept verbatim, spaces only' '
 	echo "foo   bar" >expect &&
-	git config section.val "foo   bar" &&
+	git config ${mode_set} section.val "foo   bar" &&
 	git config ${mode_get} section.val >actual &&
 	test_cmp expect actual
 '
=20
 test_expect_success 'inner whitespace kept verbatim, horizontal tabs only'=
 '
 	echo "fooQQbar" | q_to_tab >expect &&
-	git config section.val "$(cat expect)" &&
+	git config ${mode_set} section.val "$(cat expect)" &&
 	git config ${mode_get} section.val >actual &&
 	test_cmp expect actual
 '
=20
 test_expect_success 'inner whitespace kept verbatim, horizontal tabs and s=
paces' '
 	echo "foo Q  bar" | q_to_tab >expect &&
-	git config section.val "$(cat expect)" &&
+	git config ${mode_set} section.val "$(cat expect)" &&
 	git config ${mode_get} section.val >actual &&
 	test_cmp expect actual
 '
@@ -1252,12 +1256,12 @@ test_expect_success 'check split_cmdline return' '
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
@@ -1295,12 +1299,12 @@ test_expect_success 'key sanity-checking' '
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
@@ -2523,7 +2527,7 @@ test_expect_success '--replace-all does not invent ne=
wlines' '
 	[abc]
 	Qkey =3D b
 	EOF
-	git config --replace-all abc.key b &&
+	git config ${mode_replace_all} abc.key b &&
 	test_cmp expect .git/config
 '
=20
@@ -2595,8 +2599,8 @@ test_expect_success 'refuse --fixed-value for incompa=
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
@@ -2637,7 +2641,7 @@ test_expect_success '--fixed-value uses exact string =
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
2.45.0


--I0RPF6P9sVSXSthF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0tQMACgkQVbJhu7ck
PpQ87Q//XCrMHuk+RVC7GTal3fWBH4VEiaTBwPiJMYYAvPcwEgJzy76W/LiAvkhN
whnEdxCR1V05WBZ7wIv5IBpiJQMXqi26j8ouSKhhlBJosaRCS2Nv59i9VR/q+pMx
5klXHw0lAu0Gb7TD58jBwyppmtKPu/FBWxripAOLOVzeL7Vgix5UoioOUrIci1+I
aupCJ4+3xJ8vHkCuPlrv67WbrRpZ2ztTbiarPJrYlMD5QIDE06C/xbh4PS0SnTw8
BD9XvnUPYEVzIE43VvLQAB1DO7ekaZofA6UleUbKbaAyh/0zEw1HYJq81HNmFTCd
YOS/G9YYG8OlgVGATRl5S7FE7ZlUkMRnjhAdhW8HpgAO+ohksRPM593EZc3TXorJ
SXBjEDmXAVkpR/qLsyg97HKq2zD8EXCSp+BklYqey4wdvGttmOqpMp+MQtKPE+uh
eJBstv1HzW5WSyK0rO2K40gZL7TdQGyR3fpz5xSFZaNOHwOUcdfqWEOumPs8Sb5T
mwao77NVfST9aaE7BDOckMayp0G0Tay/N3fDBYi72rI6ESRy7rTr+nZEEluLMHbj
/h5zR+1aebTtJtvcxzwCwLaVf0xbFRWUKiUPw1tRNSLVyD8qpM2qJNezmx6qANeI
Po/xaw9Fv3E9CQkNhoWm9xTCEIMSpzruS6ji7W/8Ki6ixbAZIh0=
=Jgrx
-----END PGP SIGNATURE-----

--I0RPF6P9sVSXSthF--
