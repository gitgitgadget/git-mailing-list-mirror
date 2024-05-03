Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933EF14F9D5
	for <git@vger.kernel.org>; Fri,  3 May 2024 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730211; cv=none; b=j3lU8Wq8Z52e3KA8q+uUjsyKO8m64mYyoAb8JNOVaSXfLmsyYCweEfRjF1Sq9O78mm2IPa+RbuZ9nfwcvdPAol72XwMjeQxwVBIG7gpKcJayqTkyI3Z6n8aaOeDrtRJQIzulefuv+27nILqwxdLvFRIeFCdzU3LunXl3Cr1YVJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730211; c=relaxed/simple;
	bh=uFVmGiJ6woewGW0lIJHPzHwZHrctFoGqu+13ycw6lng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swyPwJvEyqMgBk6M5n+yjbV5DfQBb844wER+xxsosBavYdH5v3M4qcGUP70syk3SlnhNi/2zZRH7Em6wD5eiusujCzhwu0BY95RwOc0Oy5xfHgAeWoyBd5Vj0DBV+SJJ2DM42KV2se+d4GbNPjc/Deu/51HYXQ+w43BJuE5XGOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vD/zHgO0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gKsedMUt; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vD/zHgO0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gKsedMUt"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7601718000BA;
	Fri,  3 May 2024 05:56:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 03 May 2024 05:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714730207; x=1714816607; bh=a8JAXxRRpA
	K6GIkqUZfDaAFO+GeJoRMqWAuyLvcX4oc=; b=vD/zHgO0XCjr2pMNygtUPJgNoX
	kCxBhN9MRNCYOs+1Ks/f/FMqbvaHtBHYjdHU/075U51qd1arK8g1E0FIdJJ7vIXe
	nQyrrPT6XPn7Rxl4J1Z9o+h0a1OkZ/X3S1Ud/LARPy1dwZX28GKxjkxYC1eBiv4t
	v0R+w/ztPl36kJjzyYgxahVhYnGQ2rZjKxvSm6hASb/XmXFoORtM6ZpZBb4dUaw1
	UEZ9BzCk++Bby4PlBD63Tax7TKPpVK+QpsrqlRu+xgY4qSFUb7/L7YDdqsULyCyH
	LWNR8DkOhMwirVmltjjV7tVwTo8uI48QCnJMXQl5Df9yQsIqCMxJ84092wsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714730207; x=1714816607; bh=a8JAXxRRpAK6GIkqUZfDaAFO+GeJ
	oRMqWAuyLvcX4oc=; b=gKsedMUt/TkvVNZvXpGwahLOEtdZzWU65A9aTt1PaVum
	rGNhGmupFidN5E/mpDFLMTJ9wUlL/Grpautjs/tDcLhVPlCkO69nZ5/BkwT9NKB7
	zA+M9SJsyApA+M/Z/D0cvHHozsSOY3+gAkid+uvoopg65kSQ0YGxDpIh9V9HGun+
	W58cLG9lSvpOOs4Hh4e1jIGaqRC/43ejhLTUN4CVKV+/8UHS1uIqmPED7560QB8u
	034FcM1RousDuIjFQkEoPv0ABjMrC2BDsOb79z/ZGjdZsoadn5D/JzeVlrqoXRsW
	CYZ1IiGgMG+50KMNbvGd6ulRU5LWnKpFNOBnNgrI+Q==
X-ME-Sender: <xms:3rQ0ZqclxZHIozOPPPuchHI8NUBK8Wut78EjECHe3MfO4nOYE9v-0A>
    <xme:3rQ0ZkMurwD6OCzSTojPeAkrtlA-WakUmTTNpeOiyJBRamZt-pRRZ8aVpZHPDKJu0
    K-w0CIfFxOj1eM6mg>
X-ME-Received: <xmr:3rQ0Zrg8S2XKds8Ov5PS8_2n6zfUoYfecLhxXYebPxlSyqkYQCBIku1eTC0oBr1OJk-gA7tBkAztR6i-DYtHVVQarsFU6j9kXBeK487j316skUgI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:3rQ0Zn-WGYhYesay5n8EaDhPzkNpNTRjGqDP5QxDSvNjyVwsYq3VBQ>
    <xmx:3rQ0Zmvycgt0eAaf7qGA5FP03HPDozmy7Y8Mos_jaXP0WeXwBGfclA>
    <xmx:3rQ0ZuH1R-ulm2_RWp-UXFEro_kQwfrdVy0p2uFV5YGbf6aZ16M9mA>
    <xmx:3rQ0ZlNolRCr5CitU12oVq-1ZZXl2Za-M47mFnAgiKMh2K3kmD1igw>
    <xmx:37Q0ZqhCc-i0p1tr29Cs0Jv838EWSCO6-iLs4pOtpwJIas3zP3ABHjz5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 05:56:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 24fcbc08 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 09:56:14 +0000 (UTC)
Date: Fri, 3 May 2024 11:56:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 00/14] builtin/config: introduce subcommands
Message-ID: <cover.1714730169.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nht8GiMUgZ2nVcY6"
Content-Disposition: inline
In-Reply-To: <cover.1709724089.git.ps@pks.im>


--Nht8GiMUgZ2nVcY6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fourth version of my patch series that introduces
subcommands for git-config(1).

Changes compared to v3:

    - Rebased on top of d4cc1ec35f (Start the 2.46 cycle, 2024-04-30).

    - Implemented support for `git config set --comment`. This switch
      has been added since the last version of this patch series.

Here's hoping that there's a bit more interest in this patch series at
the beginning of the release cycle :)

Patrick

Patrick Steinhardt (14):
  config: clarify memory ownership when preparing comment strings
  builtin/config: move option array around
  builtin/config: move "fixed-value" option to correct group
  builtin/config: use `OPT_CMDMODE()` to specify modes
  builtin/config: pull out function to handle config location
  builtin/config: pull out function to handle `--null`
  builtin/config: introduce "list" subcommand
  builtin/config: introduce "get" subcommand
  builtin/config: introduce "set" subcommand
  builtin/config: introduce "unset" subcommand
  builtin/config: introduce "rename-section" subcommand
  builtin/config: introduce "remove-section" subcommand
  builtin/config: introduce "edit" subcommand
  builtin/config: display subcommand help

 Documentation/git-config.txt | 219 ++++++++-------
 builtin/config.c             | 512 ++++++++++++++++++++++++++++-------
 config.c                     |  16 +-
 config.h                     |   2 +-
 t/t0450/txt-help-mismatches  |   1 -
 t/t1300-config.sh            | 432 +++++++++++++++++------------
 6 files changed, 812 insertions(+), 370 deletions(-)

Range-diff against v3:
 -:  ---------- >  1:  3aa26d5bff config: clarify memory ownership when pre=
paring comment strings
 1:  bfcb50e393 !  2:  8f0804ab48 builtin/config: move option array around
    @@ builtin/config.c: static int option_parse_type(const struct option *=
opt, const c
     -	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (=
file, standard input, blob, command line)")),
     -	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (wor=
ktree, local, global, system, command)")),
     -	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get=
, use default value when missing entry")),
    +-	OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readab=
le comment string (# will be prepended as needed)")),
     -	OPT_END(),
     -};
     -
    @@ builtin/config.c: static char *default_user_config(void)
     +	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (=
file, standard input, blob, command line)")),
     +	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (wor=
ktree, local, global, system, command)")),
     +	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get=
, use default value when missing entry")),
    ++	OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readab=
le comment string (# will be prepended as needed)")),
     +	OPT_END(),
     +};
     +
 2:  ff428d8a22 !  3:  ddcd8031d7 builtin/config: move "fixed-value" option=
 to correct group
    @@ builtin/config.c: static struct option builtin_config_options[] =3D {
      	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slo=
t [default]"), ACTION_GET_COLOR),
      	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: sl=
ot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
     @@ builtin/config.c: static struct option builtin_config_options[] =3D=
 {
    - 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (=
file, standard input, blob, command line)")),
      	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (wor=
ktree, local, global, system, command)")),
      	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get=
, use default value when missing entry")),
    + 	OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readab=
le comment string (# will be prepended as needed)")),
     +	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality whe=
n comparing values to 'value-pattern'")),
      	OPT_END(),
      };
 3:  e049c05713 =3D  4:  1bc3918840 builtin/config: use `OPT_CMDMODE()` to =
specify modes
 4:  41585803bf !  5:  3754812309 builtin/config: pull out function to hand=
le config location
    @@ builtin/config.c: static char *default_user_config(void)
     -	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (=
file, standard input, blob, command line)")),
     -	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (wor=
ktree, local, global, system, command)")),
     -	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get=
, use default value when missing entry")),
    +-	OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readab=
le comment string (# will be prepended as needed)")),
     -	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality whe=
n comparing values to 'value-pattern'")),
     -	OPT_END(),
     -};
     -
     -static NORETURN void usage_builtin_config(void)
    --{
    ++static void handle_config_location(const char *prefix)
    + {
     -	usage_with_options(builtin_config_usage, builtin_config_options);
     -}
     -
     -int cmd_config(int argc, const char **argv, const char *prefix)
    -+static void handle_config_location(const char *prefix)
    - {
    +-{
     -	int nongit =3D !startup_info->have_repository;
    --	char *value =3D NULL;
    +-	char *value =3D NULL, *comment =3D NULL;
     -	int flags =3D 0;
     -	int ret =3D 0;
     -	struct key_value_info default_kvi =3D KVI_INIT;
    @@ builtin/config.c: int cmd_config(int argc, const char **argv, const =
char *prefix
     +	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (=
file, standard input, blob, command line)")),
     +	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (wor=
ktree, local, global, system, command)")),
     +	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get=
, use default value when missing entry")),
    ++	OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readab=
le comment string (# will be prepended as needed)")),
     +	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality whe=
n comparing values to 'value-pattern'")),
     +	OPT_END(),
     +};
    @@ builtin/config.c: int cmd_config(int argc, const char **argv, const =
char *prefix
     +
     +int cmd_config(int argc, const char **argv, const char *prefix)
     +{
    -+	char *value =3D NULL;
    ++	char *value =3D NULL, *comment =3D NULL;
     +	int flags =3D 0;
     +	int ret =3D 0;
     +	struct key_value_info default_kvi =3D KVI_INIT;
 5:  95f661f267 =3D  6:  cb1714c493 builtin/config: pull out function to ha=
ndle `--null`
 6:  b50f32d074 !  7:  b3f3c3ba6a builtin/config: introduce "list" subcomma=
nd
    @@ Documentation/git-config.txt: git-config - Get and set repository or=
 global opti
      --------
      [verse]
     +'git config list' [<file-option>] [<display-option>] [--includes]
    - 'git config' [<file-option>] [--type=3D<type>] [--fixed-value] [--sho=
w-origin] [--show-scope] [-z|--null] <name> [<value> [<value-pattern>]]
    - 'git config' [<file-option>] [--type=3D<type>] --add <name> <value>
    - 'git config' [<file-option>] [--type=3D<type>] [--fixed-value] --repl=
ace-all <name> <value> [<value-pattern>]
    + 'git config' [<file-option>] [--type=3D<type>] [--comment=3D<message>=
] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] <name> [<value=
> [<value-pattern>]]
    + 'git config' [<file-option>] [--type=3D<type>] [--comment=3D<message>=
] --add <name> <value>
    + 'git config' [<file-option>] [--type=3D<type>] [--comment=3D<message>=
] [--fixed-value] --replace-all <name> <value> [<value-pattern>]
     @@ Documentation/git-config.txt: SYNOPSIS
      'git config' [<file-option>] [--fixed-value] --unset-all <name> [<val=
ue-pattern>]
      'git config' [<file-option>] --rename-section <old-name> <new-name>
    @@ builtin/config.c: static struct option builtin_config_options[] =3D {
     -	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (=
file, standard input, blob, command line)")),
     -	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (wor=
ktree, local, global, system, command)")),
      	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get=
, use default value when missing entry")),
    + 	OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readab=
le comment string (# will be prepended as needed)")),
      	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality whe=
n comparing values to 'value-pattern'")),
     +	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include d=
irectives on lookup")),
      	OPT_END(),
    @@ builtin/config.c: static NORETURN void usage_builtin_config(void)
     +
      int cmd_config(int argc, const char **argv, const char *prefix)
      {
    - 	char *value =3D NULL;
    + 	char *value =3D NULL, *comment =3D NULL;
     @@ builtin/config.c: int cmd_config(int argc, const char **argv, const=
 char *prefix)
     =20
      	given_config_source.file =3D xstrdup_or_null(getenv(CONFIG_ENVIRONME=
NT));
    @@ t/t1300-config.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     +	BUG "unknown mode $mode";;
     +esac
     +
    - test_expect_success 'clear default config' '
    - 	rm -f .git/config
    - '
    + test_expect_success 'setup whitespace config' '
    + 	sed -e "s/^|//" \
    + 	    -e "s/[$]$//" \
     @@ t/t1300-config.sh: version.1.2.3eX.alpha=3Dbeta
      EOF
     =20
    @@ t/t1300-config.sh: Qsection.sub=3Dsection.val4
      	nul_to_q <result.raw >result &&
      	echo >>result &&
      	test_cmp expect result
    -@@ t/t1300-config.sh: test_expect_success 'inner whitespace kept verba=
tim' '
    +@@ t/t1300-config.sh: test_expect_success 'inner whitespace kept verba=
tim, horizontal tabs and spaces'
      '
     =20
      test_expect_success SYMLINKS 'symlinked configuration' '
 7:  eee1fae50c !  8:  0e6da909ac builtin/config: introduce "get" subcommand
    @@ Documentation/git-config.txt: SYNOPSIS
      [verse]
      'git config list' [<file-option>] [<display-option>] [--includes]
     +'git config get' [<file-option>] [<display-option>] [--includes] [--a=
ll] [--regexp=3D<regexp>] [--value=3D<value>] [--fixed-value] [--default=3D=
<default>] <name>
    - 'git config' [<file-option>] [--type=3D<type>] [--fixed-value] [--sho=
w-origin] [--show-scope] [-z|--null] <name> [<value> [<value-pattern>]]
    - 'git config' [<file-option>] [--type=3D<type>] --add <name> <value>
    - 'git config' [<file-option>] [--type=3D<type>] [--fixed-value] --repl=
ace-all <name> <value> [<value-pattern>]
    + 'git config' [<file-option>] [--type=3D<type>] [--comment=3D<message>=
] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] <name> [<value=
> [<value-pattern>]]
    + 'git config' [<file-option>] [--type=3D<type>] [--comment=3D<message>=
] --add <name> <value>
    + 'git config' [<file-option>] [--type=3D<type>] [--comment=3D<message>=
] [--fixed-value] --replace-all <name> <value> [<value-pattern>]
     -'git config' [<file-option>] [--type=3D<type>] [--show-origin] [--sho=
w-scope] [-z|--null] [--fixed-value] --get <name> [<value-pattern>]
     -'git config' [<file-option>] [--type=3D<type>] [--show-origin] [--sho=
w-scope] [-z|--null] [--fixed-value] --get-all <name> [<value-pattern>]
     -'git config' [<file-option>] [--type=3D<type>] [--show-origin] [--sho=
w-scope] [-z|--null] [--fixed-value] [--name-only] --get-regexp <name-regex=
> [<value-pattern>]
    @@ Documentation/git-config.txt: COMMANDS
      OPTIONS
      -------
     @@ Documentation/git-config.txt: OPTIONS
    - 	values.  This is the same as providing '^$' as the `value-pattern`
    - 	in `--replace-all`.
    + 	not contain linefeed characters (no multi-line comments are
    + 	permitted).
     =20
     ---get::
     -	Get the value for a given key (optionally filtered by a regex
    @@ Documentation/git-config.txt: OPTIONS
     ---get-all::
     -	Like get, but returns all values for a multi-valued key.
     +--all::
    -+	With `get`, Return all values for a multi-valued key.
    ++	With `get`, return all values for a multi-valued key.
     =20
     ---get-regexp::
     -	Like --get-all, but interprets the name as a regular expression and
    @@ t/t1300-config.sh: test_expect_success '--null --list' '
      	nul_to_q <result.raw >result &&
      	echo >>result &&
      	test_cmp expect result
    +@@ t/t1300-config.sh: test_expect_success '--null --get-regexp' '
    + test_expect_success 'inner whitespace kept verbatim, spaces only' '
    + 	echo "foo   bar" >expect &&
    + 	git config section.val "foo   bar" &&
    +-	git config --get section.val >actual &&
    ++	git config ${mode_get} section.val >actual &&
    + 	test_cmp expect actual
    + '
    +=20
    + test_expect_success 'inner whitespace kept verbatim, horizontal tabs =
only' '
    + 	echo "fooQQbar" | q_to_tab >expect &&
    + 	git config section.val "$(cat expect)" &&
    +-	git config --get section.val >actual &&
    ++	git config ${mode_get} section.val >actual &&
    + 	test_cmp expect actual
    + '
    +=20
    + test_expect_success 'inner whitespace kept verbatim, horizontal tabs =
and spaces' '
    + 	echo "foo Q  bar" | q_to_tab >expect &&
    + 	git config section.val "$(cat expect)" &&
    +-	git config --get section.val >actual &&
    ++	git config ${mode_get} section.val >actual &&
    + 	test_cmp expect actual
    + '
    +=20
     @@ t/t1300-config.sh: test_expect_success 'git -c can represent empty =
string' '
      '
     =20
 8:  e2815affab !  9:  8a623a31b9 builtin/config: introduce "set" subcommand
    @@ Documentation/git-config.txt: SYNOPSIS
      [verse]
      'git config list' [<file-option>] [<display-option>] [--includes]
      'git config get' [<file-option>] [<display-option>] [--includes] [--a=
ll] [--regexp=3D<regexp>] [--value=3D<value>] [--fixed-value] [--default=3D=
<default>] <name>
    --'git config' [<file-option>] [--type=3D<type>] [--fixed-value] [--sho=
w-origin] [--show-scope] [-z|--null] <name> [<value> [<value-pattern>]]
    --'git config' [<file-option>] [--type=3D<type>] --add <name> <value>
    --'git config' [<file-option>] [--type=3D<type>] [--fixed-value] --repl=
ace-all <name> <value> [<value-pattern>]
    -+'git config set' [<file-option>] [--type=3D<type>] [--all] [--value=
=3D<value>] [--fixed-value] <name> <value>
    +-'git config' [<file-option>] [--type=3D<type>] [--comment=3D<message>=
] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] <name> [<value=
> [<value-pattern>]]
    +-'git config' [<file-option>] [--type=3D<type>] [--comment=3D<message>=
] --add <name> <value>
    +-'git config' [<file-option>] [--type=3D<type>] [--comment=3D<message>=
] [--fixed-value] --replace-all <name> <value> [<value-pattern>]
    ++'git config set' [<file-option>] [--type=3D<type>] [--comment=3D<mess=
age>] [--all] [--value=3D<value>] [--fixed-value] <name> <value>
      'git config' [<file-option>] [--fixed-value] --unset <name> [<value-p=
attern>]
      'git config' [<file-option>] [--fixed-value] --unset-all <name> [<val=
ue-pattern>]
      'git config' [<file-option>] --rename-section <old-name> <new-name>
    @@ Documentation/git-config.txt: OPTIONS
     -	in `--replace-all`.
     +	values. This is the same as providing '--value=3D^$' in `set`.
     =20
    - --all::
    - 	With `get`, Return all values for a multi-valued key.
    + --comment <message>::
    + 	Append a comment at the end of new or modified lines.
     @@ Documentation/git-config.txt: recommended to migrate to the new syn=
tax.
      'git config <name>'::
      	Replaced by `git config get <name>`.
    @@ builtin/config.c: static const char *const builtin_config_get_usage[=
] =3D {
      };
     =20
     +static const char *const builtin_config_set_usage[] =3D {
    -+	N_("git config set [<file-option>] [--type=3D<type>] [--all] [--valu=
e=3D<value>] [--fixed-value] <name> <value>"),
    ++	N_("git config set [<file-option>] [--type=3D<type>] [--comment=3D<m=
essage>] [--all] [--value=3D<value>] [--fixed-value] <name> <value>"),
     +	NULL
     +};
     +
    @@ builtin/config.c: static int cmd_config_get(int argc, const char **a=
rgv, const c
     =20
     +static int cmd_config_set(int argc, const char **argv, const char *pr=
efix)
     +{
    -+	const char *value_pattern =3D NULL;
    ++	const char *value_pattern =3D NULL, *comment_arg =3D NULL;
    ++	char *comment =3D NULL;
     +	int flags =3D 0, append =3D 0;
     +	struct option opts[] =3D {
     +		CONFIG_LOCATION_OPTIONS,
    @@ builtin/config.c: static int cmd_config_get(int argc, const char **a=
rgv, const c
     +		OPT_STRING(0, "value", &value_pattern, N_("pattern"), N_("show conf=
ig with values matching the pattern")),
     +		OPT_BIT(0, "fixed-value", &flags, N_("use string equality when comp=
aring values to value pattern"), CONFIG_FLAGS_FIXED_VALUE),
     +		OPT_GROUP(N_("Other")),
    ++		OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-reada=
ble comment string (# will be prepended as needed)")),
     +		OPT_BOOL(0, "append", &append, N_("add a new line without altering =
any existing values")),
     +		OPT_END(),
     +	};
    @@ builtin/config.c: static int cmd_config_get(int argc, const char **a=
rgv, const c
     +	if (append)
     +		value_pattern =3D CONFIG_REGEX_NONE;
     +
    ++	comment =3D git_config_prepare_comment_string(comment_arg);
    ++
     +	handle_config_location(prefix);
     +
     +	value =3D normalize_value(argv[0], argv[1], &default_kvi);
    @@ builtin/config.c: static int cmd_config_get(int argc, const char **a=
rgv, const c
     +	if ((flags & CONFIG_FLAGS_MULTI_REPLACE) || value_pattern) {
     +		ret =3D git_config_set_multivar_in_file_gently(given_config_source.=
file,
     +							     argv[0], value, value_pattern,
    -+							     flags);
    ++							     comment, flags);
     +	} else {
    -+		ret =3D git_config_set_in_file_gently(given_config_source.file, arg=
v[0], value);
    ++		ret =3D git_config_set_in_file_gently(given_config_source.file,
    ++						    argv[0], comment, value);
     +		if (ret =3D=3D CONFIG_NOTHING_SET)
     +			error(_("cannot overwrite multiple values with a single value\n"
     +			"       Use a regexp, --add or --replace-all to change %s."), argv=
[0]);
     +	}
     +
    ++	free(comment);
     +	free(value);
     +	return ret;
     +}
    @@ t/t1300-config.sh: cat > expect << EOF
      	test_cmp expect .git/config
      '
     =20
    +@@ t/t1300-config.sh: EOF
    +=20
    + test_expect_success 'append comments' '
    + 	git config --replace-all --comment=3D"Pygoscelis papua" section.peng=
uin gentoo &&
    +-	git config --comment=3D"find fish" section.disposition peckish &&
    +-	git config --comment=3D"#abc" section.foo bar &&
    ++	git config ${mode_set} --comment=3D"find fish" section.disposition p=
eckish &&
    ++	git config ${mode_set} --comment=3D"#abc" section.foo bar &&
    +=20
    + 	git config --comment=3D"and comment" section.spsp value &&
    + 	git config --comment=3D"	# and comment" section.htsp value &&
    +@@ t/t1300-config.sh: test_expect_success 'append comments' '
    + '
    +=20
    + test_expect_success 'Prohibited LF in comment' '
    +-	test_must_fail git config --comment=3D"a${LF}b" section.k v
    ++	test_must_fail git config ${mode_set} --comment=3D"a${LF}b" section.=
k v
    + '
    +=20
    + test_expect_success 'non-match result' 'test_cmp expect .git/config'
     @@ t/t1300-config.sh: test_expect_success 'multiple unset is correct' '
      cp .git/config2 .git/config
     =20
    @@ t/t1300-config.sh: test_expect_success 'key with newline' '
     =20
      cat > .git/config <<\EOF
     @@ t/t1300-config.sh: test_expect_success '--null --get-regexp' '
    +=20
    + test_expect_success 'inner whitespace kept verbatim, spaces only' '
    + 	echo "foo   bar" >expect &&
    +-	git config section.val "foo   bar" &&
    ++	git config ${mode_set} section.val "foo   bar" &&
    + 	git config ${mode_get} section.val >actual &&
    + 	test_cmp expect actual
      '
     =20
    - test_expect_success 'inner whitespace kept verbatim' '
    --	git config section.val "foo 	  bar" &&
    -+	git config ${mode_set} section.val "foo 	  bar" &&
    - 	test_cmp_config "foo 	  bar" section.val
    + test_expect_success 'inner whitespace kept verbatim, horizontal tabs =
only' '
    + 	echo "fooQQbar" | q_to_tab >expect &&
    +-	git config section.val "$(cat expect)" &&
    ++	git config ${mode_set} section.val "$(cat expect)" &&
    + 	git config ${mode_get} section.val >actual &&
    + 	test_cmp expect actual
      '
     =20
    + test_expect_success 'inner whitespace kept verbatim, horizontal tabs =
and spaces' '
    + 	echo "foo Q  bar" | q_to_tab >expect &&
    +-	git config section.val "$(cat expect)" &&
    ++	git config ${mode_set} section.val "$(cat expect)" &&
    + 	git config ${mode_get} section.val >actual &&
    + 	test_cmp expect actual
    + '
     @@ t/t1300-config.sh: test_expect_success 'check split_cmdline return'=
 '
      	git init repo &&
      	(
 9:  90f055ae1d ! 10:  e25e5b69cd builtin/config: introduce "unset" subcomm=
and
    @@ Commit message
    =20
      ## Documentation/git-config.txt ##
     @@ Documentation/git-config.txt: SYNOPSIS
    + [verse]
      'git config list' [<file-option>] [<display-option>] [--includes]
      'git config get' [<file-option>] [<display-option>] [--includes] [--a=
ll] [--regexp=3D<regexp>] [--value=3D<value>] [--fixed-value] [--default=3D=
<default>] <name>
    - 'git config set' [<file-option>] [--type=3D<type>] [--all] [--value=
=3D<value>] [--fixed-value] <name> <value>
    +-'git config set' [<file-option>] [--type=3D<type>] [--comment=3D<mess=
age>] [--all] [--value=3D<value>] [--fixed-value] <name> <value>
     -'git config' [<file-option>] [--fixed-value] --unset <name> [<value-p=
attern>]
     -'git config' [<file-option>] [--fixed-value] --unset-all <name> [<val=
ue-pattern>]
    ++'git config set' [<file-option>] [--type=3D<type>] [--all] [--value=
=3D<value>] [--fixed-value] <name> <value>
     +'git config unset' [<file-option>] [--all] [--value=3D<value>] [--fix=
ed-value] <name> <value>
      'git config' [<file-option>] --rename-section <old-name> <new-name>
      'git config' [<file-option>] --remove-section <name>
    @@ builtin/config.c: static int cmd_config_set(int argc, const char **a=
rgv, const c
     +	if ((flags & CONFIG_FLAGS_MULTI_REPLACE) || value_pattern)
     +		return git_config_set_multivar_in_file_gently(given_config_source.f=
ile,
     +							      argv[0], NULL, value_pattern,
    -+							      flags);
    ++							      NULL, flags);
     +	else
    -+		return git_config_set_in_file_gently(given_config_source.file, argv=
[0], NULL);
    ++		return git_config_set_in_file_gently(given_config_source.file, argv=
[0],
    ++						     NULL, NULL);
     +}
     +
      static struct option builtin_subcommand_options[] =3D {
10:  3e360b1f47 ! 11:  f24008d356 builtin/config: introduce "rename-section=
" subcommand
    @@ builtin/config.c: static const char *const builtin_config_unset_usag=
e[] =3D {
      static regex_t *key_regexp;
      static const char *value_pattern;
     @@ builtin/config.c: static int cmd_config_unset(int argc, const char =
**argv, const char *prefix)
    - 		return git_config_set_in_file_gently(given_config_source.file, argv=
[0], NULL);
    + 						     NULL, NULL);
      }
     =20
     +static int cmd_config_rename_section(int argc, const char **argv, con=
st char *prefix)
11:  d610b5fda1 =3D 12:  fc2ddd3201 builtin/config: introduce "remove-secti=
on" subcommand
12:  4a6512c88a =3D 13:  4c2d817eff builtin/config: introduce "edit" subcom=
mand
13:  657d1355b5 =3D 14:  4c351b12b8 builtin/config: display subcommand help
--=20
2.45.0


--Nht8GiMUgZ2nVcY6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0tNMACgkQVbJhu7ck
PpRnog/8DwpJYU6lzY1jNUCP2fHdde6AE8EfEgKsnKv6mXllcS0mtmx9jZNatrfA
ZRE2EpjLG2xrDMlusJcwwo9G+b8JEJJAObEjvTnpuSk4uR2W0XK5XhPj9N4vVvEf
7vp8Il5RE9V5Y78IGA4VlLl2J55/VJYap4WF6RGc7W8UuTJvkxhqj0K+3ubmymUj
ndksAJjaMgpLBzljErwMN+9G/ErAhVB/b5n/XtolCYIVqsIVWlc4qUtMfW+Jhb5O
hLun/nEPLqEE8+5xHWM5XBZES30kfl8WrWNINLwThEQu2XY7bZ5WxF5O6Xs92vGF
5OPHeZUtHs6LcTha5rvd4QIP6h8PLC8hR0Cln2lEOmOD578dEMAu2927TIg3Ce0d
7Sf36XLxIekWViZF9aS/ckXqlwU2RyKl/Oe1HVdDMsM3FRQJMIbyvH+wwYL3WnWw
7rJd1Oj1giBs0F+YA9IkSihkFbMPhrOE7Szq6GJtqh4sH7S7+zX/GwU63xb2+poc
hcbsbcZIYjQbEObKpeuJe1zXx1WMze6NDFE/yJF2J0NPz1OjUnrZP9+TQn/JSuAu
qo5aUKUWiRV3ov8/Ks1pkZyiQHV5Ua6lwsuYqWugwEajhJq/D8YaW8bfRg7HZtIW
y1SioJ4+OM6phR9MtukJgFoR/ZOGG7daLOPSUhDVU//PrdexkuM=
=bWSX
-----END PGP SIGNATURE-----

--Nht8GiMUgZ2nVcY6--
