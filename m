Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0071E869
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529213; cv=none; b=lEUGY406NsztZYC8hAqLfOvgpyGkO0Vv9cE32kNNUA0ekWT6djv4VSLY3I1N7Lo+DfxDsgnvmC2ldrrzgAo18XzPlUb/M8HZgrX9oadBWuF/e/XIAQG0pj84v7GI2P1s14XRWz9/MXuy1LcjU7gfhZJjUTMWNeAu2bLUrKujJ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529213; c=relaxed/simple;
	bh=s8F6yFuoIxBrmUcu3PYJNR/fLqP9IuqXKG/m2SOAJVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjMTA5u08XFzUjIg6GddkLmqgkPm2U4cK9uklZfEHpjSHWZIzbJhcWN7Dr21vm4pQfxZCc2+DAsKRE8dQ52fHyrIfPPnLuXk2Am9PIHoJPaa2TcEMjRnjkVbKqC9oMOqf0IDLQZgQTC/6ld+u6mnIPntq28t5ceOL5oUlC51MP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gLdcc3Ps; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TsMyuwR2; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gLdcc3Ps";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TsMyuwR2"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5759B138015E;
	Wed, 27 Mar 2024 04:46:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 27 Mar 2024 04:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711529210; x=1711615610; bh=9tq7zqU4dr
	EYmiQokqR9Sm3A7sqwiigTEcYDUbLbeGg=; b=gLdcc3PsNc0yFKxS42N9YOMjqI
	FZV1QPIbP48LkzSS/tKrrUNNG1OU3zcEBSUqd8FHDqKKWlCVY+R3EB2Qr/IIKwyj
	BYIXM6mUDsv2dL5+1mhjMiZPJRQWTn53UbS1cuFp+5WRC3KGiLO3COStQ0+nV8J4
	53BDkHovse5CrBRqukr3jmmNMWfSXkAuMpLr1IP8rzVi5rkZUrPPXczvyQEDxV6b
	sK2FIqwwttZKz8cM0vC5IRzIPXUHa5EYwjjy+U+n3kbIdi7RAc/ZnQEm9Rpq8K9O
	bv5XoMr4Q54/NTQiFuvaoaetzHebO2FANuxix+98sQaZQlcNtA4VuTVNj5vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711529210; x=1711615610; bh=9tq7zqU4drEYmiQokqR9Sm3A7sqw
	iigTEcYDUbLbeGg=; b=TsMyuwR2q/9NlXf5dsBNpS9zSIgTAKHBdbr+8pJ6PE2k
	izcJ1k7xN4eUBRQfwUmWcS87OQbcDxvCrX5rguLRuXFNY1dt6/ao0S2DDefunWel
	FWrE6tpBLEuvwW0HWmgSjvLpRNpIM+/Pzc4qUhyK9/OmdDI6TdhXEiCK+LDqmFag
	llb/dPQtk+xlvSua2KLrBS7vEoRO3DuTQP8IgruAPVIRaqTHcU2jueDsMX7aG7Uy
	KoCA0bq4VY4E3SMSLZSdzuNwR+ltIwX9s/FMJ7UsaS52+7MNRih0ZCINweUop0mI
	G8ZmKrxQUAXgJ6F1thoOO+8rZ8tesWvT91gQhnr+eA==
X-ME-Sender: <xms:-twDZkzTDRDaJncDk-6w2YcQ97VhoTY0S5A65KoYvIubYoO-wq_eug>
    <xme:-twDZoRbvzuMJoKZ8XOlHp0CNKAO7NEm_t2cO_shnPJIGtV21GmAFFwx94FFMOVEH
    JbXiVWXaF9MQvb0Xw>
X-ME-Received: <xmr:-twDZmXnwin-NPvLujocQJSj2bTSTwgdxvLDwxc7467omy1Fp2Mlwd0J6e9pOjTbGjLnexEj-cg4dAUUap2_MzU3DKVvMaYet8Rp6LklP9lRRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeiveektdfggfeluefgvdelvdeftdfhgeeugeefveejleeufeekgeefffehgfel
    gfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:-twDZiiw4A-ShSoxOQA3erS5JdpaTmCQU7ROh6B0OYgWmV4NiecInw>
    <xmx:-twDZmC1EvJ544-TcWKZiwYBg-yu9JfogunU9f24al0UIAybSXdOwA>
    <xmx:-twDZjIWUta-rM2ykQrYMX7A8EoO6CjrI447uSN653nvWqxKF9JirQ>
    <xmx:-twDZtDwmUXliRMxU6vBAGfxZjTD46pglz1A9n0KcXLrFpx6eu-lxw>
    <xmx:-twDZsDOhpRPCRtEGoDcRsBk8meuMAxcGYQ9aqJX23SmfaaGPVUPBw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 04:46:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9c381e8f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 08:46:35 +0000 (UTC)
Date: Wed, 27 Mar 2024 09:46:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 09/13] builtin/config: introduce "unset" subcommand
Message-ID: <90f055ae1d9e735560b66dc9aac534fafaf27c23.1711527812.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1711527811.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8rHDCpL6tVcS1kQe"
Content-Disposition: inline
In-Reply-To: <cover.1711527811.git.ps@pks.im>


--8rHDCpL6tVcS1kQe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new "unset" subcommand to git-config(1). Please refer to
preceding commits regarding the motivation behind this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-config.txt | 25 ++++++++++++--------
 builtin/config.c             | 38 +++++++++++++++++++++++++++++++
 t/t1300-config.sh            | 44 ++++++++++++++++++++++++------------
 3 files changed, 82 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 7fdf9b434e..4fbc73a19e 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -12,8 +12,7 @@ SYNOPSIS
 'git config list' [<file-option>] [<display-option>] [--includes]
 'git config get' [<file-option>] [<display-option>] [--includes] [--all] [=
--regexp=3D<regexp>] [--value=3D<value>] [--fixed-value] [--default=3D<defa=
ult>] <name>
 'git config set' [<file-option>] [--type=3D<type>] [--all] [--value=3D<val=
ue>] [--fixed-value] <name> <value>
-'git config' [<file-option>] [--fixed-value] --unset <name> [<value-patter=
n>]
-'git config' [<file-option>] [--fixed-value] --unset-all <name> [<value-pa=
ttern>]
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
@@ -178,12 +183,6 @@ See also <<FILES>>.
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
@@ -313,6 +312,12 @@ recommended to migrate to the new syntax.
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
@@ -360,7 +365,7 @@ values of a key from all files will be used.
=20
 By default, options are only written to the repository specific
 configuration file. Note that this also affects options like `set`
-and `--unset`. *'git config' will only ever change one file at a time*.
+and `unset`. *'git config' will only ever change one file at a time*.
=20
 You can limit which configuration sources are read from or written to by
 specifying the path of a file with the `--file` option, or by specifying a
@@ -511,7 +516,7 @@ This makes sure that only the key/value pair for kernel=
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
index eec57fbd17..c53b68887e 100644
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
@@ -903,10 +909,42 @@ static int cmd_config_set(int argc, const char **argv=
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
+							      flags);
+	else
+		return git_config_set_in_file_gently(given_config_source.file, argv[0], =
NULL);
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
index f435b8f194..c9610a1f5b 100755
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
@@ -149,7 +153,7 @@ foo =3D bar
 EOF
=20
 test_expect_success 'unset with cont. lines' '
-	git config --unset beta.baz
+	git config ${mode_unset} beta.baz
 '
=20
 cat > expect <<\EOF
@@ -176,7 +180,7 @@ EOF
 cp .git/config .git/config2
=20
 test_expect_success 'multiple unset' '
-	git config --unset-all beta.haha
+	git config ${mode_unset_all} beta.haha
 '
=20
 cat > expect << EOF
@@ -262,7 +266,7 @@ noIndent=3D sillyValue ; 'nother silly comment
 	nonewline =3D wow
 EOF
 test_expect_success 'unset' '
-	git config --unset beta.haha &&
+	git config ${mode_unset} beta.haha &&
 	test_cmp expect .git/config
 '
=20
@@ -318,11 +322,11 @@ test_expect_success 'multivar replace' '
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
@@ -336,7 +340,12 @@ noIndent=3D sillyValue ; 'nother silly comment
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
@@ -1887,7 +1896,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	# please be careful when you update the above variable
 	EOF
=20
-	git config --unset section.key &&
+	git config ${mode_unset} section.key &&
 	test_cmp expect .git/config &&
=20
 	cat >.git/config <<-\EOF &&
@@ -1900,7 +1909,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	[next-section]
 	EOF
=20
-	git config --unset section.key &&
+	git config ${mode_unset} section.key &&
 	test_cmp expect .git/config &&
=20
 	q_to_tab >.git/config <<-\EOF &&
@@ -1910,7 +1919,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	[two]
 	key =3D true
 	EOF
-	git config --unset two.key &&
+	git config ${mode_unset} two.key &&
 	! grep two .git/config &&
=20
 	q_to_tab >.git/config <<-\EOF &&
@@ -1920,7 +1929,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	[one]
 	key =3D true
 	EOF
-	git config --unset-all one.key &&
+	git config ${mode_unset_all} one.key &&
 	test_line_count =3D 0 .git/config &&
=20
 	q_to_tab >.git/config <<-\EOF &&
@@ -1930,7 +1939,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	[two]
 	Qkey =3D true
 	EOF
-	git config --unset two.key &&
+	git config ${mode_unset} two.key &&
 	grep two .git/config &&
=20
 	q_to_tab >.git/config <<-\EOF &&
@@ -1942,7 +1951,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	[TWO "subsection"]
 	[one]
 	EOF
-	git config --unset two.subsection.key &&
+	git config ${mode_unset} two.subsection.key &&
 	test "not [two subsection]" =3D "$(git config ${mode_get} one.key)" &&
 	test_line_count =3D 3 .git/config
 '
@@ -1954,7 +1963,7 @@ test_expect_success '--unset-all removes section if e=
mpty & uncommented' '
 	key =3D value2
 	EOF
=20
-	git config --unset-all section.key &&
+	git config ${mode_unset_all} section.key &&
 	test_line_count =3D 0 .git/config
 '
=20
@@ -2478,8 +2487,8 @@ test_expect_success 'refuse --fixed-value for incompa=
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
@@ -2509,6 +2518,11 @@ test_expect_success '--fixed-value uses exact string=
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
2.44.GIT


--8rHDCpL6tVcS1kQe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYD3PYACgkQVbJhu7ck
PpREzxAAq+kkScFHTsd2N/ph+9zol2W4GS14zyTOzQbW+5puCEZ4ZLmpoZVAr6Zc
dyU0p/nOPPhn49cdgEGaWfQoh/4aHeWEmRukVU7ZYhhhdwoXHMg7hARitvLyIIw9
M/F2ttbk1l5ObsC4aAqM3dB/VUbZdt0cqDY7yaVeKpzryFRK8O9RtNKn6fTzHHrW
Z8Z459cWiC0nQAy+gIh82FHnwp8ySdr8yW7VPTszF6bleSIUQG6Ppy1FZjnvJ/R7
OS1fsKVoL5eUNw3UkCu4wDhq9Sbhz/0H6rwKTbdKW0vrmnl7ZJY8byj8EJZrg0+D
Zu8OQbfd9aqYl7Qm0SIKmVJhkGHPD90t1BXK9QAH1H3IH0kuh6/fEiFuFdxNHMFs
QXJLdQRAulrRtlPlWtrRZ684cyQbhRGdHPcX3DKmBDcTqLEuDQTP96f4oLnXCbtn
tahkgGdS5irnQZfwxAq2kydJKWbMg4uMT5ZB6hPRfdRvJmf4RS7wVpfjPkASjQgf
NvjGz+UVBVmds/pZ6ouiyrSinUkhQhwTLNlvYlI4MlS2NtKseYCs2hiHs5DR+5Sl
efL32381YeJLuddUfudWmmpFovabcWZphGpaBSv9yDE1IfOjrANy8mlhSI62TM4X
nNYLmycatdgu5jmx8R4H2WY/8xjs8VYCEXL2a2xb3qbA86Zm3x8=
=V2En
-----END PGP SIGNATURE-----

--8rHDCpL6tVcS1kQe--
