Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D236014F9D6
	for <git@vger.kernel.org>; Fri,  3 May 2024 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730246; cv=none; b=cgBoE+dGwnqBF56EaaqQa0OJuBPnuV4CO1Mz3F7POGe2nFfDAGDXJXE8M4m+Hyw9De3Gu+HxbBgKIn7o21J29LABAP6ucFOjtuyFewsTF/+isWoGjghYxz+dHngxiFxQNJurPlr0mqDaW9TlJAW2MloPqx761IXkGoy0NtVj87g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730246; c=relaxed/simple;
	bh=ng+Q8QpXgBm+QXrtQX6XJ3JOelskHNIi8x9471xaJiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKnDJs5/KbcdsT2FXMDdObQJlY/e7AE1T2YCwhFO5ND0gM1jkXz9F7yiIbNPu0h1URfMWIOrKWt5C5n8Z4QHHP2iwwBjLIlAKCAZ757Idxf1ceLdWBXDgetlIFTFX6RNbWnFlvF2wUvtFPGG87lNFdZOz63bz0YzrKTNYrSi+0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QlS2YYqO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GDGTn+xN; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QlS2YYqO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GDGTn+xN"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id EF46E18000BA;
	Fri,  3 May 2024 05:57:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 03 May 2024 05:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714730242; x=1714816642; bh=nTTTB8iACX
	/ov2eM9vO17SIvZy9vPl2MmyLaRMZhIPo=; b=QlS2YYqOmwNk92pMfntLhzAeyE
	0SX/v8M1qlnQFfpYQjANgZ6h5ADlI9Q2S1kA3I6dWV2uVeSQv/hTy66axTyq7l4d
	kBWOOlftoDXWj1nRChzZi0iqSRtDA8qmifmsCFQHo2nOue1o0xx5GWnrGDKuk/G7
	FTatHVrzjTKgsY0kYy5+GY1SwpYCCT2PGpHHIQr792godGku9YXfZJHx6gltOcpT
	MHE1LB1DQSPYrYuFOjEF4HtK3u0MmU6Awkv1ywTKB0g8nh5gdeGaRXXBint/KTcx
	P69ib6aleE5a1x2zCyowkoxewZ+WzOBmIpN8Pom3qZh20ifgW1+jLGV4rfwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714730242; x=1714816642; bh=nTTTB8iACX/ov2eM9vO17SIvZy9v
	Pl2MmyLaRMZhIPo=; b=GDGTn+xNvJsxYLgrIJLo9uSbcUWwO+qh/OmFzN9rMBYO
	braB+hG/CEcY3PShyVvkM2iZq/K3NPVYh4id23lGbwjjOgyl0XZt0h3w+bdDpq7o
	pwycWeI6aW2alJhgTlp2TYH52szOTR68p1Cy7QVTHH3g0Jv7wH0f96NECwTehdR4
	+gRKvBsGdyTFeQA+2ll36PlJUphoOcFIdKet5jbK2yTnC9YS3/dZWdhMLoJZR+UY
	9T+OaEMwRKXAxhQ4mX/IjMsxFkWZ6n1aNagohevooc5At/nXJTSYIZndfRTHVBfy
	y/rNcw4tKcRg0p4PP7nqHAI1b4+/DPjY/TP50/5zLw==
X-ME-Sender: <xms:ArU0ZkJ5vmbHTSjB7lNLPizoRgVkjLRv-RhDaLwaObagfxNCsW5MPg>
    <xme:ArU0ZkIJ2Sy-IfODlfm4bMQbCfG7DuFmm1RNsXhVmzLkRTf769cw2fKkfphvI2CE_
    5B1WBEG-SP6SpUIKg>
X-ME-Received: <xmr:ArU0ZkuV8tJd0octjguohL31rLHew6DwLroR_ZbMSSqNjCeW-F91tFLQm9YHBpdsLH0cJRjH05QYbMqO6VrP5Pd7tVsM0Hzecqhtzqe68Eqr4cwN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    hushgvrhcuihhnuchlihhnkhculdeitddmnecujfgurhepfffhvfevuffkfhggtggujges
    ghdtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceoph
    hssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepudfgledtuedtvdfhlefhfeefjefg
    gfejvdehhfekgeevleelhfehieeiffdtgfdunecuffhomhgrihhnpeguihhffhdrnhgvfi
    dpkhgvrhhnvghlrdhorhhgpdgvgigrmhhplhgvrdgtohhmpdgvgigrmhhplhgvrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ArU0ZhZfcrMMgBP6hPO8_XEOtiwre6jCZe29mxxnhMTS02ykIELxIA>
    <xmx:ArU0ZrYErCFZKL1XFTqIiOo7fwpFO4TbegIeSQr14EWSTZ0-ftMlsw>
    <xmx:ArU0ZtAhKI9VAUNf9YjtSgn93fXQhqpIcadMogdv0Xri6HYZkFwT2A>
    <xmx:ArU0ZhbX1AARXt1fzvelSb4cy5MRgZ8PxjbGMSN6DFS4AwMyju896Q>
    <xmx:ArU0ZgOzpPDSqiY1nFz4BlCcd5uXiHdB0M9V3SyvfkdjJwJIH70Vc0B3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 05:57:21 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 851dc0aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 09:56:53 +0000 (UTC)
Date: Fri, 3 May 2024 11:57:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 08/14] builtin/config: introduce "get" subcommand
Message-ID: <0e6da909ac75b9cdf5b32c3b6a29a1a2adbed9bd.1714730170.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714730169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ut+InGgadfpl4M3E"
Content-Disposition: inline
In-Reply-To: <cover.1714730169.git.ps@pks.im>


--Ut+InGgadfpl4M3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new "get" subcommand to git-config(1). Please refer to
preceding commits regarding the motivation behind this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-config.txt |  93 ++++++++++++-------------
 builtin/config.c             |  69 +++++++++++++++---
 t/t1300-config.sh            | 131 ++++++++++++++++++++++++-----------
 3 files changed, 194 insertions(+), 99 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index c83c97cb7e..d0878663db 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -10,18 +10,14 @@ SYNOPSIS
 --------
 [verse]
 'git config list' [<file-option>] [<display-option>] [--includes]
+'git config get' [<file-option>] [<display-option>] [--includes] [--all] [=
--regexp=3D<regexp>] [--value=3D<value>] [--fixed-value] [--default=3D<defa=
ult>] <name>
 'git config' [<file-option>] [--type=3D<type>] [--comment=3D<message>] [--=
fixed-value] [--show-origin] [--show-scope] [-z|--null] <name> [<value> [<v=
alue-pattern>]]
 'git config' [<file-option>] [--type=3D<type>] [--comment=3D<message>] --a=
dd <name> <value>
 'git config' [<file-option>] [--type=3D<type>] [--comment=3D<message>] [--=
fixed-value] --replace-all <name> <value> [<value-pattern>]
-'git config' [<file-option>] [--type=3D<type>] [--show-origin] [--show-sco=
pe] [-z|--null] [--fixed-value] --get <name> [<value-pattern>]
-'git config' [<file-option>] [--type=3D<type>] [--show-origin] [--show-sco=
pe] [-z|--null] [--fixed-value] --get-all <name> [<value-pattern>]
-'git config' [<file-option>] [--type=3D<type>] [--show-origin] [--show-sco=
pe] [-z|--null] [--fixed-value] [--name-only] --get-regexp <name-regex> [<v=
alue-pattern>]
-'git config' [<file-option>] [--type=3D<type>] [-z|--null] --get-urlmatch =
<name> <URL>
 'git config' [<file-option>] [--fixed-value] --unset <name> [<value-patter=
n>]
 'git config' [<file-option>] [--fixed-value] --unset-all <name> [<value-pa=
ttern>]
 'git config' [<file-option>] --rename-section <old-name> <new-name>
 'git config' [<file-option>] --remove-section <name>
-'git config' [<file-option>] --get-color <name> [<default>]
 'git config' [<file-option>] --get-colorbool <name> [<stdout-is-tty>]
 'git config' [<file-option>] -e | --edit
=20
@@ -80,6 +76,12 @@ COMMANDS
 list::
 	List all variables set in config file, along with their values.
=20
+get::
+	Emits the value of the specified key. If key is present multiple times
+	in the configuration, emits the last value. If `--all` is specified,
+	emits all values associated with key. Returns error code 1 if key is
+	not present.
+
 [[OPTIONS]]
 OPTIONS
 -------
@@ -105,22 +107,16 @@ OPTIONS
 	not contain linefeed characters (no multi-line comments are
 	permitted).
=20
---get::
-	Get the value for a given key (optionally filtered by a regex
-	matching the value). Returns error code 1 if the key was not
-	found and the last value if multiple key values were found.
-
---get-all::
-	Like get, but returns all values for a multi-valued key.
+--all::
+	With `get`, return all values for a multi-valued key.
=20
---get-regexp::
-	Like --get-all, but interprets the name as a regular expression and
-	writes out the key names.  Regular expression matching is currently
-	case-sensitive and done against a canonicalized version of the key
-	in which section and variable names are lowercased, but subsection
-	names are not.
+---regexp::
+	With `get`, interpret the name as a regular expression. Regular
+	expression matching is currently case-sensitive and done against a
+	canonicalized version of the key in which section and variable names
+	are lowercased, but subsection names are not.
=20
---get-urlmatch <name> <URL>::
+--url=3D<URL>::
 	When given a two-part <name> as <section>.<key>, the value for
 	<section>.<URL>.<key> whose <URL> part matches the best to the
 	given URL is returned (if no such key exists, the value for
@@ -251,7 +247,7 @@ Valid `<type>`'s include:
=20
 --name-only::
 	Output only the names of config variables for `list` or
-	`--get-regexp`.
+	`get`.
=20
 --show-origin::
 	Augment the output of all queried config options with the
@@ -275,17 +271,6 @@ Valid `<type>`'s include:
 	When the color setting for `name` is undefined, the command uses
 	`color.ui` as fallback.
=20
---get-color <name> [<default>]::
-
-	Find the color configured for `name` (e.g. `color.diff.new`) and
-	output it as the ANSI color escape sequence to the standard
-	output.  The optional `default` parameter is used instead, if
-	there is no color configured for `name`.
-+
-`--type=3Dcolor [--default=3D<default>]` is preferred over `--get-color`
-(but note that `--get-color` will omit the trailing newline printed by
-`--type=3Dcolor`).
-
 -e::
 --edit::
 	Opens an editor to modify the specified config file; either
@@ -299,7 +284,7 @@ Valid `<type>`'s include:
 	config files.
=20
 --default <value>::
-  When using `--get`, and the requested variable is not found, behave as if
+  When using `get`, and the requested variable is not found, behave as if
   <value> were the value assigned to that variable.
=20
 DEPRECATED MODES
@@ -308,15 +293,33 @@ DEPRECATED MODES
 The following modes have been deprecated in favor of subcommands. It is
 recommended to migrate to the new syntax.
=20
+'git config <name>'::
+	Replaced by `git config get <name>`.
+
 -l::
 --list::
 	Replaced by `git config list`.
=20
+--get <name> [<value-pattern>]::
+	Replaced by `git config get [--value=3D<pattern>] <name>`.
+
+--get-all <name> [<value-pattern>]::
+	Replaced by `git config get [--value=3D<pattern>] --all --show-names <nam=
e>`.
+
+--get-regexp <name-regexp>::
+	Replaced by `git config get --all --show-names --regexp <name-regexp>`.
+
+--get-urlmatch <name> <URL>::
+	Replaced by `git config get --all --show-names --url=3D<URL> <name>`.
+
+--get-color <name> [<default>]::
+	Replaced by `git config get --type=3Dcolor [--default=3D<default>] <name>=
`.
+
 CONFIGURATION
 -------------
 `pager.config` is only respected when listing configuration, i.e., when
-using `list` or any of the `--get-*` which may return multiple results.
-The default is to use a pager.
+using `list` or `get` which may return multiple results. The default is to=
 use
+a pager.
=20
 [[FILES]]
 FILES
@@ -519,25 +522,19 @@ you have to provide a regex matching the value of exa=
ctly one line.
 To query the value for a given key, do
=20
 ------------
-% git config --get core.filemode
-------------
-
-or
-
-------------
-% git config core.filemode
+% git config get core.filemode
 ------------
=20
 or, to query a multivar:
=20
 ------------
-% git config --get core.gitproxy "for kernel.org$"
+% git config get --value=3D"for kernel.org$" core.gitproxy
 ------------
=20
 If you want to know all the values for a multivar, do:
=20
 ------------
-% git config --get-all core.gitproxy
+% git config get --all --show-names core.gitproxy
 ------------
=20
 If you like to live dangerously, you can replace *all* core.gitproxy by a
@@ -571,8 +568,8 @@ script:
=20
 ------------
 #!/bin/sh
-WS=3D$(git config --get-color color.diff.whitespace "blue reverse")
-RESET=3D$(git config --get-color "" "reset")
+WS=3D$(git config get --type=3Dcolor --default=3D"blue reverse" color.diff=
=2Ewhitespace)
+RESET=3D$(git config get --type=3Dcolor --default=3D"reset" "")
 echo "${WS}your whitespace color or blue reverse${RESET}"
 ------------
=20
@@ -580,11 +577,11 @@ For URLs in `https://weak.example.com`, `http.sslVeri=
fy` is set to
 false, while it is set to `true` for all others:
=20
 ------------
-% git config --type=3Dbool --get-urlmatch http.sslverify https://good.exam=
ple.com
+% git config get --type=3Dbool --url=3Dhttps://good.example.com http.sslve=
rify
 true
-% git config --type=3Dbool --get-urlmatch http.sslverify https://weak.exam=
ple.com
+% git config get --type=3Dbool --url=3Dhttps://weak.example.com http.sslve=
rify
 false
-% git config --get-urlmatch http https://weak.example.com
+% git config get --url=3Dhttps://weak.example.com http
 http.cookieFile /tmp/cookie.txt
 http.sslverify false
 ------------
diff --git a/builtin/config.c b/builtin/config.c
index f89ddce8da..9e7ae49c02 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -17,7 +17,7 @@
=20
 static const char *const builtin_config_usage[] =3D {
 	N_("git config list [<file-option>] [<display-option>] [--includes]"),
-	N_("git config [<options>]"),
+	N_("git config get [<file-option>] [<display-option>] [--includes] [--all=
] [--regexp=3D<regexp>] [--value=3D<value>] [--fixed-value] [--default=3D<d=
efault>] <name>"),
 	NULL
 };
=20
@@ -26,6 +26,11 @@ static const char *const builtin_config_list_usage[] =3D=
 {
 	NULL
 };
=20
+static const char *const builtin_config_get_usage[] =3D {
+	N_("git config get [<file-option>] [<display-option>] [--includes] [--all=
] [--regexp=3D<regexp>] [--value=3D<value>] [--fixed-value] [--default=3D<d=
efault>] <name>"),
+	NULL
+};
+
 static char *key;
 static regex_t *key_regexp;
 static const char *value_pattern;
@@ -722,6 +727,16 @@ static void handle_nul(void) {
 	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use gi=
ven config file")), \
 	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read =
config from given blob object"))
=20
+#define CONFIG_TYPE_OPTIONS \
+	OPT_GROUP(N_("Type")), \
+	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type=
"), option_parse_type), \
+	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\"")=
, TYPE_BOOL), \
+	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE_I=
NT), \
+	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"=
), TYPE_BOOL_OR_INT), \
+	OPT_CALLBACK_VALUE(0, "bool-or-str", &type, N_("value is --bool or string=
"), TYPE_BOOL_OR_STR), \
+	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directo=
ry name)"), TYPE_PATH), \
+	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date")=
, TYPE_EXPIRY_DATE)
+
 #define CONFIG_DISPLAY_OPTIONS \
 	OPT_GROUP(N_("Display options")), \
 	OPT_BOOL('z', "null", &end_nul, N_("terminate values with NUL byte")), \
@@ -746,14 +761,7 @@ static struct option builtin_config_options[] =3D {
 	OPT_CMDMODE('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
 	OPT_CMDMODE(0, "get-color", &actions, N_("find the color configured: slot=
 [<default>]"), ACTION_GET_COLOR),
 	OPT_CMDMODE(0, "get-colorbool", &actions, N_("find the color setting: slo=
t [<stdout-is-tty>]"), ACTION_GET_COLORBOOL),
-	OPT_GROUP(N_("Type")),
-	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type=
"), option_parse_type),
-	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\"")=
, TYPE_BOOL),
-	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE_I=
NT),
-	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"=
), TYPE_BOOL_OR_INT),
-	OPT_CALLBACK_VALUE(0, "bool-or-str", &type, N_("value is --bool or string=
"), TYPE_BOOL_OR_STR),
-	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directo=
ry name)"), TYPE_PATH),
-	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date")=
, TYPE_EXPIRY_DATE),
+	CONFIG_TYPE_OPTIONS,
 	CONFIG_DISPLAY_OPTIONS,
 	OPT_GROUP(N_("Other")),
 	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use=
 default value when missing entry")),
@@ -799,8 +807,51 @@ static int cmd_config_list(int argc, const char **argv=
, const char *prefix)
 	return 0;
 }
=20
+static int cmd_config_get(int argc, const char **argv, const char *prefix)
+{
+	const char *value_pattern =3D NULL, *url =3D NULL;
+	int flags =3D 0;
+	struct option opts[] =3D {
+		CONFIG_LOCATION_OPTIONS,
+		CONFIG_TYPE_OPTIONS,
+		OPT_GROUP(N_("Filter options")),
+		OPT_BOOL(0, "all", &do_all, N_("return all values for multi-valued confi=
g options")),
+		OPT_BOOL(0, "regexp", &use_key_regexp, N_("interpret the name as a regul=
ar expression")),
+		OPT_STRING(0, "value", &value_pattern, N_("pattern"), N_("show config wi=
th values matching the pattern")),
+		OPT_BIT(0, "fixed-value", &flags, N_("use string equality when comparing=
 values to value pattern"), CONFIG_FLAGS_FIXED_VALUE),
+		OPT_STRING(0, "url", &url, N_("URL"), N_("show config matching the given=
 URL")),
+		CONFIG_DISPLAY_OPTIONS,
+		OPT_BOOL(0, "show-names", &show_keys, N_("show config keys in addition t=
o their values")),
+		OPT_GROUP(N_("Other")),
+		OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direc=
tives on lookup")),
+		OPT_STRING(0, "default", &default_value, N_("value"), N_("use default va=
lue when missing entry")),
+		OPT_END(),
+	};
+
+	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_get_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	check_argc(argc, 1, 1);
+
+	if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
+		die(_("--fixed-value only applies with 'value-pattern'"));
+	if (default_value && (do_all || url))
+		die(_("--default=3D cannot be used with --all or --url=3D"));
+	if (url && (do_all || use_key_regexp || value_pattern))
+		die(_("--url=3D cannot be used with --all, --regexp or --value"));
+
+	handle_config_location(prefix);
+	handle_nul();
+
+	setup_auto_pager("config", 1);
+
+	if (url)
+		return get_urlmatch(argv[0], url);
+	return get_value(argv[0], value_pattern, flags);
+}
+
 static struct option builtin_subcommand_options[] =3D {
 	OPT_SUBCOMMAND("list", &subcommand, cmd_config_list),
+	OPT_SUBCOMMAND("get", &subcommand, cmd_config_get),
 	OPT_END(),
 };
=20
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index f77d2f7847..7ce13ed6cd 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -17,9 +17,15 @@ do
 case "$mode" in
 legacy)
 	mode_prefix=3D"--"
+	mode_get=3D""
+	mode_get_all=3D"--get-all"
+	mode_get_regexp=3D"--get-regexp"
 	;;
 subcommands)
 	mode_prefix=3D""
+	mode_get=3D"get"
+	mode_get_all=3D"get --all"
+	mode_get_regexp=3D"get --regexp --all --show-names"
 	;;
 *)
 	BUG "unknown mode $mode";;
@@ -398,7 +404,7 @@ test_expect_success 'multi-valued get-all returns all' '
 	wow
 	wow2 for me
 	EOF
-	git config --get-all nextsection.nonewline >actual &&
+	git config ${mode_get_all} nextsection.nonewline >actual &&
 	test_cmp expect actual
 '
=20
@@ -500,7 +506,7 @@ nextsection.nonewline wow2 for me
 EOF
=20
 test_expect_success '--get-regexp' '
-	git config --get-regexp in >output &&
+	git config ${mode_get_regexp} in >output &&
 	test_cmp expect output
 '
=20
@@ -510,7 +516,7 @@ nextsection.nonewline
 EOF
=20
 test_expect_success '--name-only --get-regexp' '
-	git config --name-only --get-regexp in >output &&
+	git config ${mode_get_regexp} --name-only in >output &&
 	test_cmp expect output
 '
=20
@@ -521,7 +527,7 @@ EOF
=20
 test_expect_success '--add' '
 	git config --add nextsection.nonewline "wow4 for you" &&
-	git config --get-all nextsection.nonewline > output &&
+	git config ${mode_get_all} nextsection.nonewline > output &&
 	test_cmp expect output
 '
=20
@@ -543,21 +549,21 @@ test_expect_success 'get variable with empty value' '
 echo novalue.variable > expect
=20
 test_expect_success 'get-regexp variable with no value' '
-	git config --get-regexp novalue > output &&
+	git config ${mode_get_regexp} novalue > output &&
 	test_cmp expect output
 '
=20
 echo 'novalue.variable true' > expect
=20
 test_expect_success 'get-regexp --bool variable with no value' '
-	git config --bool --get-regexp novalue > output &&
+	git config ${mode_get_regexp} --bool novalue > output &&
 	test_cmp expect output
 '
=20
 echo 'emptyvalue.variable ' > expect
=20
 test_expect_success 'get-regexp variable with empty value' '
-	git config --get-regexp emptyvalue > output &&
+	git config ${mode_get_regexp} emptyvalue > output &&
 	test_cmp expect output
 '
=20
@@ -1131,7 +1137,7 @@ test_expect_success 'quoting' '
 '
=20
 test_expect_success 'key with newline' '
-	test_must_fail git config "key.with
+	test_must_fail git config ${mode_get} "key.with
 newline" 123'
=20
 test_expect_success 'value with newline' 'git config key.sub value.with\\\
@@ -1185,7 +1191,7 @@ test_expect_success '--null --list' '
 '
=20
 test_expect_success '--null --get-regexp' '
-	git config --null --get-regexp "val[0-9]" >result.raw &&
+	git config ${mode_get_regexp} --null "val[0-9]" >result.raw &&
 	nul_to_q <result.raw >result &&
 	echo >>result &&
 	test_cmp expect result
@@ -1194,21 +1200,21 @@ test_expect_success '--null --get-regexp' '
 test_expect_success 'inner whitespace kept verbatim, spaces only' '
 	echo "foo   bar" >expect &&
 	git config section.val "foo   bar" &&
-	git config --get section.val >actual &&
+	git config ${mode_get} section.val >actual &&
 	test_cmp expect actual
 '
=20
 test_expect_success 'inner whitespace kept verbatim, horizontal tabs only'=
 '
 	echo "fooQQbar" | q_to_tab >expect &&
 	git config section.val "$(cat expect)" &&
-	git config --get section.val >actual &&
+	git config ${mode_get} section.val >actual &&
 	test_cmp expect actual
 '
=20
 test_expect_success 'inner whitespace kept verbatim, horizontal tabs and s=
paces' '
 	echo "foo Q  bar" | q_to_tab >expect &&
 	git config section.val "$(cat expect)" &&
-	git config --get section.val >actual &&
+	git config ${mode_get} section.val >actual &&
 	test_cmp expect actual
 '
=20
@@ -1283,11 +1289,11 @@ test_expect_success 'git -c can represent empty str=
ing' '
 '
=20
 test_expect_success 'key sanity-checking' '
-	test_must_fail git config foo=3Dbar &&
-	test_must_fail git config foo=3D.bar &&
-	test_must_fail git config foo.ba=3Dr &&
-	test_must_fail git config foo.1bar &&
-	test_must_fail git config foo."ba
+	test_must_fail git config ${mode_get} foo=3Dbar &&
+	test_must_fail git config ${mode_get} foo=3D.bar &&
+	test_must_fail git config ${mode_get} foo.ba=3Dr &&
+	test_must_fail git config ${mode_get} foo.1bar &&
+	test_must_fail git config ${mode_get} foo."ba
 				z".bar &&
 	test_must_fail git config . false &&
 	test_must_fail git config .foo false &&
@@ -1336,7 +1342,7 @@ test_expect_success 'git -c complains about empty key=
 and value' '
 '
=20
 test_expect_success 'multiple git -c appends config' '
-	test_config alias.x "!git -c x.two=3D2 config --get-regexp ^x\.*" &&
+	test_config alias.x "!git -c x.two=3D2 config ${mode_get_regexp} ^x\.*" &&
 	cat >expect <<-\EOF &&
 	x.one 1
 	x.two 2
@@ -1502,7 +1508,7 @@ test_expect_success 'GIT_CONFIG_PARAMETERS handles ol=
d-style entries' '
 	v=3D"${SQ}key.one=3Dfoo${SQ}" &&
 	v=3D"$v  ${SQ}key.two=3Dbar${SQ}" &&
 	v=3D"$v ${SQ}key.ambiguous=3Dsection.whatever=3Dvalue${SQ}" &&
-	GIT_CONFIG_PARAMETERS=3D$v git config --get-regexp "key.*" >actual &&
+	GIT_CONFIG_PARAMETERS=3D$v git config ${mode_get_regexp} "key.*" >actual =
&&
 	cat >expect <<-EOF &&
 	key.one foo
 	key.two bar
@@ -1515,7 +1521,7 @@ test_expect_success 'GIT_CONFIG_PARAMETERS handles ne=
w-style entries' '
 	v=3D"${SQ}key.one${SQ}=3D${SQ}foo${SQ}" &&
 	v=3D"$v  ${SQ}key.two${SQ}=3D${SQ}bar${SQ}" &&
 	v=3D"$v ${SQ}key.ambiguous=3Dsection.whatever${SQ}=3D${SQ}value${SQ}" &&
-	GIT_CONFIG_PARAMETERS=3D$v git config --get-regexp "key.*" >actual &&
+	GIT_CONFIG_PARAMETERS=3D$v git config ${mode_get_regexp} "key.*" >actual =
&&
 	cat >expect <<-EOF &&
 	key.one foo
 	key.two bar
@@ -1529,7 +1535,7 @@ test_expect_success 'old and new-style entries can mi=
x' '
 	v=3D"$v ${SQ}key.newone${SQ}=3D${SQ}newfoo${SQ}" &&
 	v=3D"$v ${SQ}key.oldtwo=3Doldbar${SQ}" &&
 	v=3D"$v ${SQ}key.newtwo${SQ}=3D${SQ}newbar${SQ}" &&
-	GIT_CONFIG_PARAMETERS=3D$v git config --get-regexp "key.*" >actual &&
+	GIT_CONFIG_PARAMETERS=3D$v git config ${mode_get_regexp} "key.*" >actual =
&&
 	cat >expect <<-EOF &&
 	key.oldone oldfoo
 	key.newone newfoo
@@ -1542,7 +1548,7 @@ test_expect_success 'old and new-style entries can mi=
x' '
 test_expect_success 'old and new bools with ambiguous subsection' '
 	v=3D"${SQ}key.with=3Dequals.oldbool${SQ}" &&
 	v=3D"$v ${SQ}key.with=3Dequals.newbool${SQ}=3D" &&
-	GIT_CONFIG_PARAMETERS=3D$v git config --get-regexp "key.*" >actual &&
+	GIT_CONFIG_PARAMETERS=3D$v git config ${mode_get_regexp} "key.*" >actual =
&&
 	cat >expect <<-EOF &&
 	key.with equals.oldbool
 	key.with=3Dequals.newbool
@@ -1556,7 +1562,7 @@ test_expect_success 'detect bogus GIT_CONFIG_PARAMETE=
RS' '
 	env.two two
 	EOF
 	GIT_CONFIG_PARAMETERS=3D"${SQ}env.one=3Done${SQ} ${SQ}env.two=3Dtwo${SQ}"=
 \
-		git config --get-regexp "env.*" >actual &&
+		git config ${mode_get_regexp} "env.*" >actual &&
 	test_cmp expect actual &&
=20
 	cat >expect <<-EOF &&
@@ -1564,12 +1570,12 @@ test_expect_success 'detect bogus GIT_CONFIG_PARAME=
TERS' '
 	env.two two
 	EOF
 	GIT_CONFIG_PARAMETERS=3D"${SQ}env.one=3Done${SQ}\\$SQ$SQ$SQ ${SQ}env.two=
=3Dtwo${SQ}" \
-		git config --get-regexp "env.*" >actual &&
+		git config ${mode_get_regexp} "env.*" >actual &&
 	test_cmp expect actual &&
=20
 	test_must_fail env \
 		GIT_CONFIG_PARAMETERS=3D"${SQ}env.one=3Done${SQ}\\$SQ ${SQ}env.two=3Dtwo=
${SQ}" \
-		git config --get-regexp "env.*"
+		git config ${mode_get_regexp} "env.*"
 '
=20
 test_expect_success 'git --config-env=3Dkey=3Denvvar support' '
@@ -1617,7 +1623,7 @@ test_expect_success 'git -c and --config-env work tog=
ether' '
 	ENVVAR=3Denv-value git \
 		-c bar.cmd=3Dcmd-value \
 		--config-env=3Dbar.env=3DENVVAR \
-		config --get-regexp "^bar.*" >actual &&
+		config ${mode_get_regexp} "^bar.*" >actual &&
 	test_cmp expect actual
 '
=20
@@ -1645,7 +1651,7 @@ test_expect_success 'git config handles environment c=
onfig pairs' '
 	GIT_CONFIG_COUNT=3D2 \
 		GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D"foo" \
 		GIT_CONFIG_KEY_1=3D"pair.two" GIT_CONFIG_VALUE_1=3D"bar" \
-		git config --get-regexp "pair.*" >actual &&
+		git config ${mode_get_regexp} "pair.*" >actual &&
 	cat >expect <<-EOF &&
 	pair.one foo
 	pair.two bar
@@ -1655,7 +1661,7 @@ test_expect_success 'git config handles environment c=
onfig pairs' '
=20
 test_expect_success 'git config ignores pairs without count' '
 	test_must_fail env GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D"va=
lue" \
-		git config pair.one 2>error &&
+		git config ${mode_get} pair.one 2>error &&
 	test_must_be_empty error
 '
=20
@@ -1663,7 +1669,7 @@ test_expect_success 'git config ignores pairs exceedi=
ng count' '
 	GIT_CONFIG_COUNT=3D1 \
 		GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D"value" \
 		GIT_CONFIG_KEY_1=3D"pair.two" GIT_CONFIG_VALUE_1=3D"value" \
-		git config --get-regexp "pair.*" >actual 2>error &&
+		git config ${mode_get_regexp} "pair.*" >actual 2>error &&
 	cat >expect <<-EOF &&
 	pair.one value
 	EOF
@@ -1674,14 +1680,14 @@ test_expect_success 'git config ignores pairs excee=
ding count' '
 test_expect_success 'git config ignores pairs with zero count' '
 	test_must_fail env \
 		GIT_CONFIG_COUNT=3D0 GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D=
"value" \
-		git config pair.one 2>error &&
+		git config ${mode_get} pair.one 2>error &&
 	test_must_be_empty error
 '
=20
 test_expect_success 'git config ignores pairs with empty count' '
 	test_must_fail env \
 		GIT_CONFIG_COUNT=3D GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D"=
value" \
-		git config pair.one 2>error &&
+		git config ${mode_get} pair.one 2>error &&
 	test_must_be_empty error
 '
=20
@@ -1720,7 +1726,7 @@ test_expect_success 'environment overrides config fil=
e' '
 	one =3D value
 	EOF
 	GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3Dpair.one GIT_CONFIG_VALUE_0=3Dove=
rride \
-		git config pair.one >actual &&
+		git config ${mode_get} pair.one >actual &&
 	cat >expect <<-EOF &&
 	override
 	EOF
@@ -1730,7 +1736,7 @@ test_expect_success 'environment overrides config fil=
e' '
 test_expect_success 'GIT_CONFIG_PARAMETERS overrides environment config' '
 	GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3Dpair.one GIT_CONFIG_VALUE_0=3Dval=
ue \
 		GIT_CONFIG_PARAMETERS=3D"${SQ}pair.one=3Doverride${SQ}" \
-		git config pair.one >actual &&
+		git config ${mode_get} pair.one >actual &&
 	cat >expect <<-EOF &&
 	override
 	EOF
@@ -1805,20 +1811,28 @@ test_expect_success 'urlmatch' '
=20
 	test_expect_code 1 git config --bool --get-urlmatch doesnt.exist https://=
good.example.com >actual &&
 	test_must_be_empty actual &&
+	test_expect_code 1 git config get --url=3Dhttps://good.example.com --bool=
 doesnt.exist >actual &&
+	test_must_be_empty actual &&
=20
 	echo true >expect &&
 	git config --bool --get-urlmatch http.SSLverify https://good.example.com =
>actual &&
 	test_cmp expect actual &&
+	git config get --bool --url=3Dhttps://good.example.com http.SSLverify >ac=
tual &&
+	test_cmp expect actual &&
=20
 	echo false >expect &&
 	git config --bool --get-urlmatch http.sslverify https://weak.example.com =
>actual &&
 	test_cmp expect actual &&
+	git config get --bool --url=3Dhttps://weak.example.com http.sslverify >ac=
tual &&
+	test_cmp expect actual &&
=20
 	{
 		echo http.cookiefile /tmp/cookie.txt &&
 		echo http.sslverify false
 	} >expect &&
 	git config --get-urlmatch HTTP https://weak.example.com >actual &&
+	test_cmp expect actual &&
+	git config get --url=3Dhttps://weak.example.com HTTP >actual &&
 	test_cmp expect actual
 '
=20
@@ -1834,6 +1848,8 @@ test_expect_success 'urlmatch with --show-scope' '
 	local	http.sslverify false
 	EOF
 	git config --get-urlmatch --show-scope HTTP https://weak.example.com >act=
ual &&
+	test_cmp expect actual &&
+	git config get --url=3Dhttps://weak.example.com --show-scope HTTP >actual=
 &&
 	test_cmp expect actual
 '
=20
@@ -1866,45 +1882,67 @@ test_expect_success 'urlmatch favors more specific =
URLs' '
 	echo http.cookiefile /tmp/root.txt >expect &&
 	git config --get-urlmatch HTTP https://example.com >actual &&
 	test_cmp expect actual &&
+	git config get --url=3Dhttps://example.com HTTP >actual &&
+	test_cmp expect actual &&
=20
 	echo http.cookiefile /tmp/subdirectory.txt >expect &&
 	git config --get-urlmatch HTTP https://example.com/subdirectory >actual &&
 	test_cmp expect actual &&
+	git config get --url=3Dhttps://example.com/subdirectory HTTP >actual &&
+	test_cmp expect actual &&
=20
 	echo http.cookiefile /tmp/subdirectory.txt >expect &&
 	git config --get-urlmatch HTTP https://example.com/subdirectory/nested >a=
ctual &&
 	test_cmp expect actual &&
+	git config get --url=3Dhttps://example.com/subdirectory/nested HTTP >actu=
al &&
+	test_cmp expect actual &&
=20
 	echo http.cookiefile /tmp/user.txt >expect &&
 	git config --get-urlmatch HTTP https://user@example.com/ >actual &&
 	test_cmp expect actual &&
+	git config get --url=3Dhttps://user@example.com/ HTTP >actual &&
+	test_cmp expect actual &&
=20
 	echo http.cookiefile /tmp/subdirectory.txt >expect &&
 	git config --get-urlmatch HTTP https://averylonguser@example.com/subdirec=
tory >actual &&
 	test_cmp expect actual &&
+	git config get --url=3Dhttps://averylonguser@example.com/subdirectory HTT=
P >actual &&
+	test_cmp expect actual &&
=20
 	echo http.cookiefile /tmp/preceding.txt >expect &&
 	git config --get-urlmatch HTTP https://preceding.example.com >actual &&
 	test_cmp expect actual &&
+	git config get --url=3Dhttps://preceding.example.com HTTP >actual &&
+	test_cmp expect actual &&
=20
 	echo http.cookiefile /tmp/wildcard.txt >expect &&
 	git config --get-urlmatch HTTP https://wildcard.example.com >actual &&
 	test_cmp expect actual &&
+	git config get --url=3Dhttps://wildcard.example.com HTTP >actual &&
+	test_cmp expect actual &&
=20
 	echo http.cookiefile /tmp/sub.txt >expect &&
 	git config --get-urlmatch HTTP https://sub.example.com/wildcardwithsubdom=
ain >actual &&
 	test_cmp expect actual &&
+	git config get --url=3Dhttps://sub.example.com/wildcardwithsubdomain HTTP=
 >actual &&
+	test_cmp expect actual &&
=20
 	echo http.cookiefile /tmp/trailing.txt >expect &&
 	git config --get-urlmatch HTTP https://trailing.example.com >actual &&
 	test_cmp expect actual &&
+	git config get --url=3Dhttps://trailing.example.com HTTP >actual &&
+	test_cmp expect actual &&
=20
 	echo http.cookiefile /tmp/sub.txt >expect &&
 	git config --get-urlmatch HTTP https://user@sub.example.com >actual &&
 	test_cmp expect actual &&
+	git config get --url=3Dhttps://user@sub.example.com HTTP >actual &&
+	test_cmp expect actual &&
=20
 	echo http.cookiefile /tmp/multiwildcard.txt >expect &&
 	git config --get-urlmatch HTTP https://wildcard.example.org >actual &&
+	test_cmp expect actual &&
+	git config get --url=3Dhttps://wildcard.example.org HTTP >actual &&
 	test_cmp expect actual
 '
=20
@@ -2027,7 +2065,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	[one]
 	EOF
 	git config --unset two.subsection.key &&
-	test "not [two subsection]" =3D "$(git config one.key)" &&
+	test "not [two subsection]" =3D "$(git config ${mode_get} one.key)" &&
 	test_line_count =3D 3 .git/config
 '
=20
@@ -2150,7 +2188,7 @@ test_expect_success '--show-origin with --get-regexp'=
 '
 	file:$HOME/.gitconfig	user.global true
 	file:.git/config	user.local true
 	EOF
-	git config --show-origin --get-regexp "user\.[g|l].*" >output &&
+	git config ${mode_get_regexp} --show-origin "user\.[g|l].*" >output &&
 	test_cmp expect output
 '
=20
@@ -2158,7 +2196,7 @@ test_expect_success '--show-origin getting a single k=
ey' '
 	cat >expect <<-\EOF &&
 	file:.git/config	local
 	EOF
-	git config --show-origin user.override >output &&
+	git config ${mode_get} --show-origin user.override >output &&
 	test_cmp expect output
 '
=20
@@ -2290,7 +2328,7 @@ test_expect_success '--show-scope getting a single va=
lue' '
 	cat >expect <<-\EOF &&
 	local	true
 	EOF
-	git config --show-scope --get user.local >output &&
+	git config ${mode_get} --show-scope user.local >output &&
 	test_cmp expect output
 '
=20
@@ -2559,9 +2597,9 @@ test_expect_success 'refuse --fixed-value for incompa=
tible actions' '
 	# These modes complain when --fixed-value has no value-pattern
 	test_must_fail git config --file=3Dconfig --fixed-value dev.null bogus &&
 	test_must_fail git config --file=3Dconfig --fixed-value --replace-all dev=
=2Enull bogus &&
-	test_must_fail git config --file=3Dconfig --fixed-value --get dev.null &&
-	test_must_fail git config --file=3Dconfig --fixed-value --get-all dev.nul=
l &&
-	test_must_fail git config --file=3Dconfig --fixed-value --get-regexp "dev=
=2E*" &&
+	test_must_fail git config ${mode_prefix}get --file=3Dconfig --fixed-value=
 dev.null &&
+	test_must_fail git config ${mode_get_all} --file=3Dconfig --fixed-value d=
ev.null &&
+	test_must_fail git config ${mode_get_regexp} --file=3Dconfig --fixed-valu=
e "dev.*" &&
 	test_must_fail git config --file=3Dconfig --fixed-value --unset dev.null =
&&
 	test_must_fail git config --file=3Dconfig --fixed-value --unset-all dev.n=
ull
 '
@@ -2591,12 +2629,12 @@ test_expect_success '--fixed-value uses exact strin=
g matching' '
 	cp initial config &&
 	test_must_fail git config --file=3Dconfig --unset fixed.test "$META" &&
 	git config --file=3Dconfig --fixed-value --unset fixed.test "$META" &&
-	test_must_fail git config --file=3Dconfig fixed.test &&
+	test_must_fail git config ${mode_get} --file=3Dconfig fixed.test &&
=20
 	cp initial config &&
 	test_must_fail git config --file=3Dconfig --unset-all fixed.test "$META" =
&&
 	git config --file=3Dconfig --fixed-value --unset-all fixed.test "$META" &&
-	test_must_fail git config --file=3Dconfig fixed.test &&
+	test_must_fail git config ${mode_get} --file=3Dconfig fixed.test &&
=20
 	cp initial config &&
 	git config --file=3Dconfig --replace-all fixed.test bogus "$META" &&
@@ -2623,18 +2661,27 @@ test_expect_success '--get and --get-all with --fix=
ed-value' '
 	git config --file=3Dconfig --add fixed.test "$META" &&
=20
 	git config --file=3Dconfig --get fixed.test bogus &&
+	git config get --file=3Dconfig --value=3Dbogus fixed.test &&
 	test_must_fail git config --file=3Dconfig --get fixed.test "$META" &&
+	test_must_fail git config get --file=3Dconfig --value=3D"$META" fixed.tes=
t &&
 	git config --file=3Dconfig --get --fixed-value fixed.test "$META" &&
+	git config get --file=3Dconfig --fixed-value --value=3D"$META" fixed.test=
 &&
 	test_must_fail git config --file=3Dconfig --get --fixed-value fixed.test =
non-existent &&
=20
 	git config --file=3Dconfig --get-all fixed.test bogus &&
+	git config get --all --file=3Dconfig --value=3Dbogus fixed.test &&
 	test_must_fail git config --file=3Dconfig --get-all fixed.test "$META" &&
+	test_must_fail git config get --all --file=3Dconfig --value=3D"$META" fix=
ed.test &&
 	git config --file=3Dconfig --get-all --fixed-value fixed.test "$META" &&
+	git config get --all --file=3Dconfig --value=3D"$META" --fixed-value fixe=
d.test &&
 	test_must_fail git config --file=3Dconfig --get-all --fixed-value fixed.t=
est non-existent &&
=20
 	git config --file=3Dconfig --get-regexp fixed+ bogus &&
+	git config get --regexp --file=3Dconfig --value=3Dbogus fixed+ &&
 	test_must_fail git config --file=3Dconfig --get-regexp fixed+ "$META" &&
+	test_must_fail git config get --regexp --file=3Dconfig --value=3D"$META" =
fixed+ &&
 	git config --file=3Dconfig --get-regexp --fixed-value fixed+ "$META" &&
+	git config get --regexp --file=3Dconfig --fixed-value --value=3D"$META" f=
ixed+ &&
 	test_must_fail git config --file=3Dconfig --get-regexp --fixed-value fixe=
d+ non-existent
 '
=20
--=20
2.45.0


--Ut+InGgadfpl4M3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0tP4ACgkQVbJhu7ck
PpSWhg//RVwJrS+Y/ojAseXWK3dT8EaQTb+ycxATHlD2COLrHJVXhFCB9nTjEGeP
kjMpsv0Gi/MuAyo6ZSNKBT6ry094zDoniM+XJvM/ZeQMGC7eNuk2ecf6StUk+yvy
A643ZxIIR7dDCFpqlqYa2xKQ9zeJex1qbxoctah1Y+ZuPpO7zJgJUVT4ARKuymjH
Jvohu4rNxvH45bnuO2Q+GdRVr0C4ArF/axu6TzcP0qzhI18ZAxg+6z0p/3UpGjw7
JmzqLoob9HucZtObkBp/oOKCRTmVfkMM57TE5/qqx4bjC5udWiiTQYUncZrRqa0k
WkGbXQFqlig7HMYoUWislcPlV8WRMAopEpD8M5KxdkInEEmRjV3vwVf+JFKVHDox
6R+CQRdlWh86eljfSp14DwwAAvPkg8XArZHqjwQi7trH/oyhCMPFsG4vufQkS8fH
XpQiCYWgjV2GoAWWfd1qy3Kf2D+MB5vCPz/kw3/Evbg0bvgy5q5pek+NU3Nh1/RB
Ekiv6squwwikhMd4JoP6djOBMhptWwEBj+2+fyFlpfCZ5SVSMvFDPMsVciHpxw48
YU0qjDCz4dWwWgOIXLXb4EyCC2LT/39ZfOi376o6jxGeBIyrLbnPTKowyXA0M/+b
DYdUpVnbijLLCF+4U9xkEcp+b/RLEvH2M2cE0nvrpkxfBftUCKc=
=9Uct
-----END PGP SIGNATURE-----

--Ut+InGgadfpl4M3E--
