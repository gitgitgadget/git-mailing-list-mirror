Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB2E59B40
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199276; cv=none; b=A9DGqzrTdy72Pyr5V3wi0vRe5MLo2cgWF63xt8HbWW3DihbqvEj/Fqd+vIfRx/mXAy1bynn8PSwkcpvsoUFfa+byN7jC8t5ukb8ID8tRInOd6rKj1PlIKHM711ueY2TC+sMzjETSI0WU68J6d4ti8Wlt6WQTvDWrJKNJ9OO679M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199276; c=relaxed/simple;
	bh=DNAD0FCxSQyZzykpYCPrs/3nGZzHMJaIlHEbepTToLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+W1tqqVjrz9n4ckhng/HBb4ANsC8ZY8ABCLyC4sAjTtz1ocPmByCpWRMkJSibhNRihPmVHoW8IiEqx/tq2OeU8b4pZswGGoAfpf+3bMSw+Itm9Z4P7Y1cBB9edi90XQeQR9A+Esb3m0OpDg9y4ItFboTkyudfsZPk0ZrPxoBgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SWL1wwUX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RqXpT3Y7; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SWL1wwUX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RqXpT3Y7"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 253F01140121;
	Mon, 11 Mar 2024 19:21:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 11 Mar 2024 19:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710199274; x=1710285674; bh=BS0Ku5FBU1
	og25JNgbKOadkmMyR1hPSVFLkjaZkiWxY=; b=SWL1wwUXLk5rwuhUMdhT/bgyeL
	O70uvHqi0exaM+XCmIYDC9Bv6r7OKX46AUy/bPTmMKx0Q2cBW0OtWIoK5nSGnDcw
	ggaGhxSVw0HNLm/Fomk+MnugMhUo9ySDt+XBYlYQLLCc14bkte727b3TZt6MO397
	JRbwGmPHSbZfAGko6pWfcY99j399MD+4kppj5WABiDdu8+vYGMjauEgo9eKv3ivl
	PKgNvtQ8Ly9vTm3867ZCPRXAf3ZzQhWwHTYzTapIKvYf5Hnp8JIU0msTvZwiz2Wp
	94WQurNbTE8AIhKht6lywSstmyADg8FHeh0RNThIOhyy81ar/jv5aRupwtZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710199274; x=1710285674; bh=BS0Ku5FBU1og25JNgbKOadkmMyR1
	hPSVFLkjaZkiWxY=; b=RqXpT3Y7IDyRlHRujJsvXtAeo5yXZqls+ItpDOxZlUFF
	n6DjJoodvs/6c+9HBkYb9ivH2Qy7kwoXUwPWJQZxmfFASum9S4cY728fudxrLPxR
	M1zIl4ghC7CcX2//+K/9+7vDH5p/SU+G1XyH1atVpRHVPnc/f6zvOZ239FcBHxc8
	LC2W/2P1X8NdGPHYQwlvzJnlm5qxonDD1yI3DNjRdZVdzZm9W75oVghRwIRRmxni
	mHboOfaDalxPQiRjNjgPa8BVjr1XIzKMZT/8mJEvaV55s4sOj5UpWlzuWW3f0SOf
	1BaPngyagqKIUCsyk1ld89snW+GccDeYoQO9HpgzpA==
X-ME-Sender: <xms:6ZHvZUbSxipLfRUjuLiT-u5zdFEIhIa3pIhTQ2OQOiFBGqINMe3PqA>
    <xme:6ZHvZfaHEKwn4OlsC5RPmdK51yKz6wwHGQeNmapkQdRJUsgcX1h8OAXSJTolx-4Ee
    Vk0lkMxIXUTiNDslA>
X-ME-Received: <xmr:6ZHvZe8_Wb_en6N230XmoZz9wzJ0zpFRH6cq-t5q-TQhFG0j_L81mOzihHId7HUwUTwC7lzAQboUi4UQIILHpVDXLM2pHWDL5vxKTZs1TjJhgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeiveektdfggfeluefgvdelvdeftdfhgeeugeefveejleeufeekgeefffehgfelgfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:6pHvZepeqB-fEoBY1QpoRKSJdlV4104_W8VCyEEeb-TqeNRB2J-XAw>
    <xmx:6pHvZfpp8mdOjErKkM9gZQc4stGBoPORJBZLaOiEOI-xJjrFpxSEEw>
    <xmx:6pHvZcRXzAyAfhQhDPBMpMlATO5xduyWadB4HK0DBRO0yBgCVGW5uw>
    <xmx:6pHvZQdVRZ3aEyQTlwWEsfxtRdrpEeUaj2-vm-PiLh_du1yFH_DU0A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 19:21:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cf2d0e67 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Mar 2024 23:16:33 +0000 (UTC)
Date: Tue, 12 Mar 2024 00:21:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/13] builtin/config: introduce "unset" subcommand
Message-ID: <c8a44b6189ad247d7b5a4b6e490ffa89c8461ddd.1710198711.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1710198711.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FaNnNo3C8GzWc30X"
Content-Disposition: inline
In-Reply-To: <cover.1710198711.git.ps@pks.im>


--FaNnNo3C8GzWc30X
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
index e540f41b56..42e659ae63 100644
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
@@ -312,6 +311,12 @@ recommended to migrate to the new syntax.
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
@@ -359,7 +364,7 @@ values of a key from all files will be used.
=20
 By default, options are only written to the repository specific
 configuration file. Note that this also affects options like `set`
-and `--unset`. *'git config' will only ever change one file at a time*.
+and `unset`. *'git config' will only ever change one file at a time*.
=20
 You can limit which configuration sources are read from or written to by
 specifying the path of a file with the `--file` option, or by specifying a
@@ -510,7 +515,7 @@ This makes sure that only the key/value pair for kernel=
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
index 18f6dc69d5..e62a09061f 100644
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
index 2c2d97e0e9..06d34b1d6a 100755
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
 	echo "unknown mode $mode" >&2
@@ -150,7 +154,7 @@ foo =3D bar
 EOF
=20
 test_expect_success 'unset with cont. lines' '
-	git config --unset beta.baz
+	git config ${mode_unset} beta.baz
 '
=20
 cat > expect <<\EOF
@@ -177,7 +181,7 @@ EOF
 cp .git/config .git/config2
=20
 test_expect_success 'multiple unset' '
-	git config --unset-all beta.haha
+	git config ${mode_unset_all} beta.haha
 '
=20
 cat > expect << EOF
@@ -263,7 +267,7 @@ noIndent=3D sillyValue ; 'nother silly comment
 	nonewline =3D wow
 EOF
 test_expect_success 'unset' '
-	git config --unset beta.haha &&
+	git config ${mode_unset} beta.haha &&
 	test_cmp expect .git/config
 '
=20
@@ -319,11 +323,11 @@ test_expect_success 'multivar replace' '
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
@@ -337,7 +341,12 @@ noIndent=3D sillyValue ; 'nother silly comment
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
@@ -1888,7 +1897,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	# please be careful when you update the above variable
 	EOF
=20
-	git config --unset section.key &&
+	git config ${mode_unset} section.key &&
 	test_cmp expect .git/config &&
=20
 	cat >.git/config <<-\EOF &&
@@ -1901,7 +1910,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	[next-section]
 	EOF
=20
-	git config --unset section.key &&
+	git config ${mode_unset} section.key &&
 	test_cmp expect .git/config &&
=20
 	q_to_tab >.git/config <<-\EOF &&
@@ -1911,7 +1920,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	[two]
 	key =3D true
 	EOF
-	git config --unset two.key &&
+	git config ${mode_unset} two.key &&
 	! grep two .git/config &&
=20
 	q_to_tab >.git/config <<-\EOF &&
@@ -1921,7 +1930,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	[one]
 	key =3D true
 	EOF
-	git config --unset-all one.key &&
+	git config ${mode_unset_all} one.key &&
 	test_line_count =3D 0 .git/config &&
=20
 	q_to_tab >.git/config <<-\EOF &&
@@ -1931,7 +1940,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	[two]
 	Qkey =3D true
 	EOF
-	git config --unset two.key &&
+	git config ${mode_unset} two.key &&
 	grep two .git/config &&
=20
 	q_to_tab >.git/config <<-\EOF &&
@@ -1943,7 +1952,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	[TWO "subsection"]
 	[one]
 	EOF
-	git config --unset two.subsection.key &&
+	git config ${mode_unset} two.subsection.key &&
 	test "not [two subsection]" =3D "$(git config ${mode_get} one.key)" &&
 	test_line_count =3D 3 .git/config
 '
@@ -1955,7 +1964,7 @@ test_expect_success '--unset-all removes section if e=
mpty & uncommented' '
 	key =3D value2
 	EOF
=20
-	git config --unset-all section.key &&
+	git config ${mode_unset_all} section.key &&
 	test_line_count =3D 0 .git/config
 '
=20
@@ -2479,8 +2488,8 @@ test_expect_success 'refuse --fixed-value for incompa=
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
@@ -2510,6 +2519,11 @@ test_expect_success '--fixed-value uses exact string=
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
2.44.0


--FaNnNo3C8GzWc30X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXvkeEACgkQVbJhu7ck
PpTTBw//WCZQCKftbkgNqlAsSM1Oe7m9lVWf2t2adYwm+0rpvi+BfvLaSzNR5t5R
pea3a+40v8xQDs4oPfbB+FgNA/2/+bT/ttF90lnHiqfvaYqxPntagfWJyq0uUIcR
h32qpquGdKG7qSQHct4RFQZd9ArGhcEi+VHEnD7lLJYF7Hupk09REzx3wPO0OQPx
hJuHVvU2n6dKgdisMYMspBnNAJ4UJxTaF2byTBN08mJoeYCxZZw8/h0u41Prdgur
4un1qbCQ8MTbL9pSzBfCl2zNji0WrlElwgE8SZU82rK75hVERri2xcIig36BsjFb
pgA2UpwmSUEFAtnCrpx8MjEhOCVtvcQ/toepQEq+UscCMmYBOTUYyOD0JX51MXO0
WZXu9kZqLCuY8nnS1p3BNbPL2CD0hJK+FjHc/526roljn0G8MOpZIU0rZKTs9SQE
YOX6VXBeDxMKvZIilnFjA4fwrcFSm97iha8RjuYYAyYIdH0xDOMXXJbcLPl6f+CR
/MYSyrgvVkxOY/QrBsHDa2+vy3t/Tnn8Nv1BS0a+AyaqT+MAvZoeO5COFVNqHtoq
Vdx4LbgNuCYeFtA28BEMENXadsgMSxOF2y2VbBFIql/Oiq0pzetQ+GNTMMdadaF7
R5V9a/YdchJnWmp+q+NCZ+eO8HxZjY8nVeJoWsN1Y3dDjL0fWsw=
=Ejan
-----END PGP SIGNATURE-----

--FaNnNo3C8GzWc30X--
