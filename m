Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971B6374D3
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529209; cv=none; b=l3lzOTE6FgpI5f57BBLOYPWs+75PbRn2vFwQrnyhKvaT9CoN2QCiaJUhv9vAMHMLyHeha+VrZmAAVeTSLmUs+bRUsjyx/o62FZVaKkEIFuQpXYRW2jb3qxVZ54Ab7CM1bqHUSmf+v8MzVRO1usbKlbDqljd5xnPJ13ev6wEEz08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529209; c=relaxed/simple;
	bh=vT6a5ul5oNJGkcQ4EdQSYlryxsNMfNUObwSrvqIRzNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLnbB+BMDcvDFGFBV5lIqAWXAtwQfJ7dDINA2Ow+Y1RIh/PjICorH62pIadzsgJOCPTtCmKuGWUrBMcjPnzbG3kBY+Mi9TM2ietjFpvZbN9fBA/n7VrChQ9OEd5EAhYL5xKZ2dumH9bomYfqkzNJwv/xgmgIBDu156OO8BRH11E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fjqIkHHm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yzvu9a/j; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fjqIkHHm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yzvu9a/j"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B40AB11400CD;
	Wed, 27 Mar 2024 04:46:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 27 Mar 2024 04:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711529206; x=1711615606; bh=MfHmB5RcO4
	vX7VaUwVtaWS+zV40OnkxDPPYTva+YZKQ=; b=fjqIkHHm4lb83jcS6D9aTyCP4v
	yD8J0ZIZgqEknsmG334+xiNBnspU4MjMW/K+oZhBZvJCpi+BGwJ8niEYot4UdPI3
	RKEE1wqRUk7K7EqHsu6Q2S3nGiTvdUdxd/PiloheJkbsBk2wwm4lBC4+ZkI8glHV
	4o0jbWwB3/w8Ih9aaOh1CulPTldYLLQLMQyV4bkUQYDUyyXY68TY2DL7lSiHbnUA
	ZSDpm8ZGTOcbMCe7CXVMNFVVqP/Sjzeiyqas1tzO+wTjUX1dXHCz6q2mqChYDTab
	PKFECg0Azr2DnLFUKigGy0fiBZDj+vrVqtgDAsu6mtFSzbWD8f9Ia2Km5Luw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711529206; x=1711615606; bh=MfHmB5RcO4vX7VaUwVtaWS+zV40O
	nkxDPPYTva+YZKQ=; b=Yzvu9a/j0tBBSrD63XHjLb6JQNa2S3shcd8RqzDV4J+E
	gynjJQs104ZxhTxB7fQpBeTFf8QYJ8ONjIGN0noPPbWp1Q+9xbBcVOwepYw9qkET
	JnOMmTpwuaYveO27swU/ARnxx2QHWNOxPm7VFd1WdNY28MB5ikJDWIY5QttY6g2f
	h0lx7ZvClLgj7Cb43a8ARYlZHplVgqJH7mwFC4hwuwJVZohU7WTHRy2Rcq81rxLq
	Or6ggBTV0/RgxlF6+vyu6bZsNkrNKZXUWiMGgP/9i0scTtosH8/xvglXjpH5lQ2C
	KoVJ8uPJwMjBuWwY2wIx7f/2muFa8OzFtdomN2dq+g==
X-ME-Sender: <xms:9twDZhRFwbfeUThLlZJ2d9BaW4FF-3kqzYQb46VIQq558jeAJX5PsQ>
    <xme:9twDZqx9wC8Ah8b64IzfQ86hmtcLqgbLNCxlaCH729jNfmFTWOkFCiL9NIsSPhJpq
    MWw9cgJ3F9N1MOr8Q>
X-ME-Received: <xmr:9twDZm1izj_aXHuTcQBNYEpZlZvdWkq9fGbBqE6CRuG9c_PM_VbIv7P0Q6B15KgGG6ZU9pyo3YuwGiWpnHQ64IBiniE4kMHHBsfh2tG8TKo0Hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeujeeitefggeelheejleetjeevtdetleetkedtgfeuvdehtddvfeelvdetjeeu
    vdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhunhhithdrihhnnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:9twDZpBCrR7UwkuS44RyABTKxH_uGGCrvS3cY3S1kh6uhsfjpbbMBA>
    <xmx:9twDZqh7ljL6w_5VJvbkQdErc3Qam-0uWlBx7sZb7jE6DJSLd3T__w>
    <xmx:9twDZtoy8uzae7_qHCK26RX8_bndXFWjnPhjOprAK4LQQwY06RYh_Q>
    <xmx:9twDZlgUZdwASICATr2F3YQH7pk8TZj0z8PM0FJ7U38xhZtnRE3vHw>
    <xmx:9twDZujKNAWB_YxeQhfsdPBp4VEP4lYBss_4-tDtNSQ93_9zfnZNjw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 04:46:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a25e1896 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 08:46:31 +0000 (UTC)
Date: Wed, 27 Mar 2024 09:46:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 08/13] builtin/config: introduce "set" subcommand
Message-ID: <e2815affab8c1dce9e2112920ec94a237bd476e0.1711527812.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1711527811.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0+Ms6lUyg+YyKKnn"
Content-Disposition: inline
In-Reply-To: <cover.1711527811.git.ps@pks.im>


--0+Ms6lUyg+YyKKnn
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
index 4a7d6b7543..7fdf9b434e 100644
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
 --all::
 	With `get`, Return all values for a multi-valued key.
@@ -284,6 +288,9 @@ recommended to migrate to the new syntax.
 'git config <name>'::
 	Replaced by `git config get <name>`.
=20
+'git config <name> <value> [<value-pattern>]'::
+	Replaced by `git config set [--value=3D<pattern>] <name> <value>`.
+
 -l::
 --list::
 	Replaced by `git config list`.
@@ -303,6 +310,9 @@ recommended to migrate to the new syntax.
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
@@ -349,7 +359,7 @@ precedence over values read earlier.  When multiple val=
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
@@ -485,7 +495,7 @@ Given a .git/config like this:
 you can set the filemode to true with
=20
 ------------
-% git config core.filemode true
+% git config set core.filemode true
 ------------
=20
 The hypothetical proxy command entries actually have a postfix to discern
@@ -493,7 +503,7 @@ what URL they apply to. Here is how to change the entry=
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
@@ -529,26 +539,26 @@ If you like to live dangerously, you can replace *all=
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
index 447500dbd2..eec57fbd17 100644
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
index f1547921c6..f435b8f194 100755
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
@@ -40,7 +44,7 @@ cat > expect << EOF
 	penguin =3D little blue
 EOF
 test_expect_success 'initial' '
-	git config section.penguin "little blue" &&
+	git config ${mode_set} section.penguin "little blue" &&
 	test_cmp expect .git/config
 '
=20
@@ -50,7 +54,7 @@ cat > expect << EOF
 	Movie =3D BadPhysics
 EOF
 test_expect_success 'mixed case' '
-	git config Section.Movie BadPhysics &&
+	git config ${mode_set} Section.Movie BadPhysics &&
 	test_cmp expect .git/config
 '
=20
@@ -62,7 +66,7 @@ cat > expect << EOF
 	WhatEver =3D Second
 EOF
 test_expect_success 'similar section' '
-	git config Sections.WhatEver Second &&
+	git config ${mode_set} Sections.WhatEver Second &&
 	test_cmp expect .git/config
 '
=20
@@ -75,7 +79,7 @@ cat > expect << EOF
 	WhatEver =3D Second
 EOF
 test_expect_success 'uppercase section' '
-	git config SECTION.UPPERCASE true &&
+	git config ${mode_set} SECTION.UPPERCASE true &&
 	test_cmp expect .git/config
 '
=20
@@ -191,14 +195,14 @@ test_expect_success 'multiple unset is correct' '
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
@@ -225,7 +229,7 @@ noIndent=3D sillyValue ; 'nother silly comment
 [nextSection] noNewline =3D ouch
 EOF
 test_expect_success 'really mean test' '
-	git config beta.haha alpha &&
+	git config ${mode_set} beta.haha alpha &&
 	test_cmp expect .git/config
 '
=20
@@ -240,7 +244,7 @@ noIndent=3D sillyValue ; 'nother silly comment
 	nonewline =3D wow
 EOF
 test_expect_success 'really really mean test' '
-	git config nextsection.nonewline wow &&
+	git config ${mode_set} nextsection.nonewline wow &&
 	test_cmp expect .git/config
 '
=20
@@ -714,16 +718,16 @@ EOF
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
@@ -732,20 +736,20 @@ test_expect_success numbers '
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
@@ -775,14 +779,14 @@ EOF
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
@@ -793,7 +797,7 @@ test_expect_success bool '
=20
 test_expect_success 'invalid bool (--get)' '
=20
-	git config bool.nobool foobar &&
+	git config ${mode_set} bool.nobool foobar &&
 	test_must_fail git config --bool --get bool.nobool'
=20
 test_expect_success 'invalid bool (set)' '
@@ -982,7 +986,7 @@ test_expect_success 'get --expiry-date' '
=20
 test_expect_success 'get --type=3Dcolor' '
 	rm .git/config &&
-	git config foo.color "red" &&
+	git config ${mode_set} foo.color "red" &&
 	git config --get --type=3Dcolor foo.color >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	echo "<RED>" >expect &&
@@ -1019,10 +1023,10 @@ cat > expect << EOF
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
@@ -1030,7 +1034,7 @@ test_expect_success 'key with newline' '
 	test_must_fail git config ${mode_get} "key.with
 newline" 123'
=20
-test_expect_success 'value with newline' 'git config key.sub value.with\\\
+test_expect_success 'value with newline' 'git config ${mode_set} key.sub v=
alue.with\\\
 newline'
=20
 cat > .git/config <<\EOF
@@ -1088,7 +1092,7 @@ test_expect_success '--null --get-regexp' '
 '
=20
 test_expect_success 'inner whitespace kept verbatim' '
-	git config section.val "foo 	  bar" &&
+	git config ${mode_set} section.val "foo 	  bar" &&
 	test_cmp_config "foo 	  bar" section.val
 '
=20
@@ -1126,12 +1130,12 @@ test_expect_success 'check split_cmdline return' '
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
@@ -1169,12 +1173,12 @@ test_expect_success 'key sanity-checking' '
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
@@ -2397,7 +2401,7 @@ test_expect_success '--replace-all does not invent ne=
wlines' '
 	[abc]
 	Qkey =3D b
 	EOF
-	git config --replace-all abc.key b &&
+	git config ${mode_replace_all} abc.key b &&
 	test_cmp expect .git/config
 '
=20
@@ -2469,8 +2473,8 @@ test_expect_success 'refuse --fixed-value for incompa=
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
@@ -2511,7 +2515,7 @@ test_expect_success '--fixed-value uses exact string =
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
2.44.GIT


--0+Ms6lUyg+YyKKnn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYD3PIACgkQVbJhu7ck
PpTZuxAAjEvMHhW8b4kEVyx5g8QfCzj2wNNyb0k1XNm4yA6ZEnwgo8LU8vPkkcwP
lmXef8dWojhwhUeQnk23CiOuh9peCI1+fhVpq7QMND422OLbKpmtOx2uHbgYvVO0
WPqfTitwm9cH0MYwP2I7IY4suUkqDGcPznneWGKZw6Yway8acfTuGd2umQbg2Erx
FvhomBBsBpHcj68VgimQUUuzeL84s4YxCPhxp5J26Q7S5AWkjCZBNACEFtz4rPLQ
GMEdePDbb/l11TsBp1MZUFtSy4/BXVfHaBZfLkv0BiLGUv5GlHYyFzKxYq2bq319
Qqe4rceJbylevGXxEFbz34TZBp7B+GQcHyhuYC6HSw8PcjDsOxZOMYYfad8tL2d7
1txyIX869eWsjJ7WN+MtN0wXLMSOD7r86lWgFsv/V7+MKEBKAGb2QHinr/i/I+YI
z3CzahljuPKxwlMZGO6jUg7Q5wmryDd3BImIld+09kLdlPV2bdXO2TIwpRQniv+X
NMy2jIWoGxZVlLvI33sM6/n1hAgKxeIhkgonVokTiZk7B1G2nNmo1P9K1lCu+1Er
55efJDggBo0nQm1mr2tyo56cxWL+zBhulbpuEQcWaXHUXZ9SjWZ5F0L8yYI5nfBQ
EJEwhlNV39lZWxgFkii9BAYjR1dPoOt3oU7WuMLK4pjPrWkUvF0=
=d9h1
-----END PGP SIGNATURE-----

--0+Ms6lUyg+YyKKnn--
