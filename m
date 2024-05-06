Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC041419A1
	for <git@vger.kernel.org>; Mon,  6 May 2024 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985792; cv=none; b=CZG7gwQOJTrQ+1Ku9JvAM7DC5jwUnm+Exv+1AaMaIktaEFQO3svpn+yh/r6wFeO8syUPJor0yrSmWfEb3SHA3FU2BhGUvUvhYyR5qmrLeBX1GbeYzj5yzAGyM8Q0zSLsOj6juvlEKDP5hZjxOyXu0scnPYApw2xChOz7FPR6AJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985792; c=relaxed/simple;
	bh=ijas9RwWupzfS6QMgNPhae+AnVdMvYwpMkC7zpLg1VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcacLKyKR72kCEyx51pgRisW3MJOjmQFOixRsFBAsYKlLBds5HwMVBbLfhoE6uCZCE8iH4k6OQp2Ksfi/nh9nm3dp+LFmpaIN8CjJ0KIZ2d66t0vfcXLTyjMlNPb6+sNFLMTjhpiZtSDDAYHY0SQtNKMjk1sepCVJMmRwjWKSX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TlMef1Ga; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KtW6st36; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TlMef1Ga";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KtW6st36"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id C2C4718000CC;
	Mon,  6 May 2024 04:56:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 06 May 2024 04:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714985788; x=1715072188; bh=eXIC0bNRSM
	OWzK32yTjOP0q20V6BM+SYx7NrKBKP4X8=; b=TlMef1GazcWLG1y1PkhJEF/FMX
	z+nOjFqq1ADrOReUFqM3vldX9yMOAs17jRDyGRWPpjlN7G865OZGvrC/7Kpv3qDD
	x68ejPVv3e9Uc0G/9dtK8oFpJ33AmCntlJq/wMAHbd2uOueFOLQsw0MAalmrlgeR
	bTTmYH/D0jqWD5wdhiyj19VGCb1tiUnA+5t052oY2h6xsJ5Cvv0AizV3q1sMxAal
	F0djn2KjQaxZ/s+rWcN7h7YeNBpc020J8QM/PHbaWI6/CyYTv3ITLdgj2myV7mys
	6bFBz4j8rQqsDbHWeCpMAa3U1U2IjEPEB1aulhv7gTgHzZuv3NZBAwLGwOBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714985788; x=1715072188; bh=eXIC0bNRSMOWzK32yTjOP0q20V6B
	M+SYx7NrKBKP4X8=; b=KtW6st36UmHNunNFxK5VKlJK3gzb4wcmf/UZB1hRXqEl
	NZqqEgyZiHSdA6wEYMUrFbaaBV0Gbw//e1FZ6eDHkJJsaRwWFF81DoJmYfMAgup8
	KU7fyCZzVzlt/9ZqmR7jWdEPZhAibD32sLmzV5LvbS0jV/M7Hi9dbh+TMLK0mwew
	n5MDaiII6gv+RdTIelRg69FMOGc3GwyTSN/SYKNMIjJmPr6uaiAqMVmktgOW7Po9
	CzaTMXnvqseJcpWb3yV7b7QgNjQv9kRVgdt5J2ZUKjibddS9D2OOMyJwIDZ+MseD
	che041bhNvsM2z0w8diSHXJawR7gJyLcsEzS3WMGnQ==
X-ME-Sender: <xms:PJs4ZvIitj6PRanqYSqf99XtZ5F68d5Ck3MnH_ZZ0h-3R_WebydceQ>
    <xme:PJs4ZjJpALIwKx8x0L340lhA_aJOB_fEgoUt7MkSV13uhB2e_qRJZz-4UurRBk0pu
    H_QhP2bCky3U2ikiw>
X-ME-Received: <xmr:PJs4ZnsOKHYkst-RobcMnTC5lLzKtzNxbX-sembVPmjNSaUn2liRikM47UXOXIsnJkG8vtVbtAdiVAHaSWk_SjLKWLgLWnrBspPxQywcAfhirTAW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:PJs4ZoYYWJRNVKg46a_1Xizhq3NRlWcSdp6lzBeQ7mVCZEps13HofQ>
    <xmx:PJs4ZmaZVltAoKe_clbUPRStcz5C7aogsys8uVIlsGph1ypLYYNXVg>
    <xmx:PJs4ZsCQnxBsKqz4B9BbNaIxzWaYuLxxJMmK4D12ePGYChIOqz9yaQ>
    <xmx:PJs4ZkazmtPzNg24Q4EWP1H-4pJE4ivirT0yrJP8BqJ-9VjDFpYKfQ>
    <xmx:PJs4ZsOLszd-OgqfllTj8bQ8c_VOujhsjqgVfXA4pEA3AWI9Qd8GsfIg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 04:56:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1df4064c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 08:56:21 +0000 (UTC)
Date: Mon, 6 May 2024 10:56:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>, rsbecker@nexbridge.com
Subject: [PATCH v5 07/14] builtin/config: introduce "list" subcommand
Message-ID: <1df76a99704fec6d5306db73744007278e97157b.1714982328.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714982328.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eVGEirF29z7Bl7Hv"
Content-Disposition: inline
In-Reply-To: <cover.1714982328.git.ps@pks.im>


--eVGEirF29z7Bl7Hv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While git-config(1) has several modes, those modes are not exposed with
subcommands but instead by specifying action flags like `--unset` or
`--list`. This user interface is not really in line with how our more
modern commands work, where it is a lot more customary to say e.g. `git
remote list`. Furthermore, to add to the confusion, git-config(1) also
allows the user to request modes implicitly by just specifying the
correct number of arguments. Thus, `git config foo.bar` will retrieve
the value of "foo.bar" while `git config foo.bar baz` will set it to
"baz".

Overall, this makes for a confusing interface that could really use a
makeover. It hurts discoverability of what you can do with git-config(1)
and is comparatively easy to get wrong. Converting the command to have
subcommands instead would go a long way to help address these issues.

One concern in this context is backwards compatibility. Luckily, we can
introduce subcommands without breaking backwards compatibility at all.
This is because all the implicit modes of git-config(1) require that the
first argument is a properly formatted config key. And as config keys
_must_ have a dot in their name, any value without a dot would have been
discarded by git-config(1) previous to this change. Thus, given that
none of the subcommands do have a dot, they are unambiguous.

Introduce the first such new subcommand, which is "git config list". To
retain backwards compatibility we only conditionally use subcommands and
will fall back to the old syntax in case no subcommand was detected.
This should help to transition to the new-style syntax until we
eventually deprecate and remove the old-style syntax.

Note that the way we handle this we're duplicating some functionality
across old and new syntax. While this isn't pretty, it helps us to
ensure that there really is no change in behaviour for the old syntax.

Amend tests such that we run them both with old and new style syntax.
As tests are now run twice, state from the first run may be still be
around in the second run and thus cause tests to fail. Add cleanup logic
as required to fix such tests.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-config.txt |  26 ++++++---
 builtin/config.c             |  90 ++++++++++++++++++++++++----
 t/t1300-config.sh            | 110 +++++++++++++++++++++--------------
 3 files changed, 162 insertions(+), 64 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index ac61113fcc..c83c97cb7e 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,6 +9,7 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
+'git config list' [<file-option>] [<display-option>] [--includes]
 'git config' [<file-option>] [--type=3D<type>] [--comment=3D<message>] [--=
fixed-value] [--show-origin] [--show-scope] [-z|--null] <name> [<value> [<v=
alue-pattern>]]
 'git config' [<file-option>] [--type=3D<type>] [--comment=3D<message>] --a=
dd <name> <value>
 'git config' [<file-option>] [--type=3D<type>] [--comment=3D<message>] [--=
fixed-value] --replace-all <name> <value> [<value-pattern>]
@@ -20,7 +21,6 @@ SYNOPSIS
 'git config' [<file-option>] [--fixed-value] --unset-all <name> [<value-pa=
ttern>]
 'git config' [<file-option>] --rename-section <old-name> <new-name>
 'git config' [<file-option>] --remove-section <name>
-'git config' [<file-option>] [--show-origin] [--show-scope] [-z|--null] [-=
-name-only] -l | --list
 'git config' [<file-option>] --get-color <name> [<default>]
 'git config' [<file-option>] --get-colorbool <name> [<stdout-is-tty>]
 'git config' [<file-option>] -e | --edit
@@ -74,6 +74,12 @@ On success, the command returns the exit code 0.
 A list of all available configuration variables can be obtained using the
 `git help --config` command.
=20
+COMMANDS
+--------
+
+list::
+	List all variables set in config file, along with their values.
+
 [[OPTIONS]]
 OPTIONS
 -------
@@ -190,10 +196,6 @@ See also <<FILES>>.
 --unset-all::
 	Remove all lines matching the key from config file.
=20
--l::
---list::
-	List all variables set in config file, along with their values.
-
 --fixed-value::
 	When used with the `value-pattern` argument, treat `value-pattern` as
 	an exact string instead of a regular expression. This will restrict
@@ -248,7 +250,7 @@ Valid `<type>`'s include:
 	contain line breaks.
=20
 --name-only::
-	Output only the names of config variables for `--list` or
+	Output only the names of config variables for `list` or
 	`--get-regexp`.
=20
 --show-origin::
@@ -300,10 +302,20 @@ Valid `<type>`'s include:
   When using `--get`, and the requested variable is not found, behave as if
   <value> were the value assigned to that variable.
=20
+DEPRECATED MODES
+----------------
+
+The following modes have been deprecated in favor of subcommands. It is
+recommended to migrate to the new syntax.
+
+-l::
+--list::
+	Replaced by `git config list`.
+
 CONFIGURATION
 -------------
 `pager.config` is only respected when listing configuration, i.e., when
-using `--list` or any of the `--get-*` which may return multiple results.
+using `list` or any of the `--get-*` which may return multiple results.
 The default is to use a pager.
=20
 [[FILES]]
diff --git a/builtin/config.c b/builtin/config.c
index 59877065f8..f89ddce8da 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -16,10 +16,16 @@
 #include "worktree.h"
=20
 static const char *const builtin_config_usage[] =3D {
+	N_("git config list [<file-option>] [<display-option>] [--includes]"),
 	N_("git config [<options>]"),
 	NULL
 };
=20
+static const char *const builtin_config_list_usage[] =3D {
+	N_("git config list [<file-option>] [<display-option>] [--includes]"),
+	NULL
+};
+
 static char *key;
 static regex_t *key_regexp;
 static const char *value_pattern;
@@ -33,6 +39,7 @@ static char delim =3D '=3D';
 static char key_delim =3D ' ';
 static char term =3D '\n';
=20
+static parse_opt_subcommand_fn *subcommand;
 static int use_global_config, use_system_config, use_local_config;
 static int use_worktree_config;
 static struct git_config_source given_config_source;
@@ -706,14 +713,24 @@ static void handle_nul(void) {
 	}
 }
=20
+#define CONFIG_LOCATION_OPTIONS \
+	OPT_GROUP(N_("Config file location")), \
+	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")), \
+	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")), \
+	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file"))=
, \
+	OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree config=
 file")), \
+	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use gi=
ven config file")), \
+	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read =
config from given blob object"))
+
+#define CONFIG_DISPLAY_OPTIONS \
+	OPT_GROUP(N_("Display options")), \
+	OPT_BOOL('z', "null", &end_nul, N_("terminate values with NUL byte")), \
+	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")), \
+	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file,=
 standard input, blob, command line)")), \
+	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree=
, local, global, system, command)"))
+
 static struct option builtin_config_options[] =3D {
-	OPT_GROUP(N_("Config file location")),
-	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
-	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
-	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
-	OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree config=
 file")),
-	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use gi=
ven config file")),
-	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read =
config from given blob object")),
+	CONFIG_LOCATION_OPTIONS,
 	OPT_GROUP(N_("Action")),
 	OPT_CMDMODE(0, "get", &actions, N_("get value: name [<value-pattern>]"), =
ACTION_GET),
 	OPT_CMDMODE(0, "get-all", &actions, N_("get all values: key [<value-patte=
rn>]"), ACTION_GET_ALL),
@@ -737,15 +754,12 @@ static struct option builtin_config_options[] =3D {
 	OPT_CALLBACK_VALUE(0, "bool-or-str", &type, N_("value is --bool or string=
"), TYPE_BOOL_OR_STR),
 	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directo=
ry name)"), TYPE_PATH),
 	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date")=
, TYPE_EXPIRY_DATE),
+	CONFIG_DISPLAY_OPTIONS,
 	OPT_GROUP(N_("Other")),
-	OPT_BOOL('z', "null", &end_nul, N_("terminate values with NUL byte")),
-	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
-	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direct=
ives on lookup")),
-	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file,=
 standard input, blob, command line)")),
-	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree=
, local, global, system, command)")),
 	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use=
 default value when missing entry")),
 	OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readable co=
mment string (# will be prepended as needed)")),
 	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when com=
paring values to 'value-pattern'")),
+	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direct=
ives on lookup")),
 	OPT_END(),
 };
=20
@@ -754,6 +768,42 @@ static NORETURN void usage_builtin_config(void)
 	usage_with_options(builtin_config_usage, builtin_config_options);
 }
=20
+static int cmd_config_list(int argc, const char **argv, const char *prefix)
+{
+	struct option opts[] =3D {
+		CONFIG_LOCATION_OPTIONS,
+		CONFIG_DISPLAY_OPTIONS,
+		OPT_GROUP(N_("Other")),
+		OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direc=
tives on lookup")),
+		OPT_END(),
+	};
+
+	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_list_usag=
e, 0);
+	check_argc(argc, 0, 0);
+
+	handle_config_location(prefix);
+	handle_nul();
+
+	setup_auto_pager("config", 1);
+
+	if (config_with_options(show_all_config, NULL,
+				&given_config_source, the_repository,
+				&config_options) < 0) {
+		if (given_config_source.file)
+			die_errno(_("unable to read config file '%s'"),
+				  given_config_source.file);
+		else
+			die(_("error processing config file(s)"));
+	}
+
+	return 0;
+}
+
+static struct option builtin_subcommand_options[] =3D {
+	OPT_SUBCOMMAND("list", &subcommand, cmd_config_list),
+	OPT_END(),
+};
+
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	char *value =3D NULL, *comment =3D NULL;
@@ -763,6 +813,22 @@ int cmd_config(int argc, const char **argv, const char=
 *prefix)
=20
 	given_config_source.file =3D xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
=20
+	/*
+	 * This is somewhat hacky: we first parse the command line while
+	 * keeping all args intact in order to determine whether a subcommand
+	 * has been specified. If so, we re-parse it a second time, but this
+	 * time we drop KEEP_ARGV0. This is so that we don't munge the command
+	 * line in case no subcommand was given, which would otherwise confuse
+	 * us when parsing the legacy-style modes that don't use subcommands.
+	 */
+	argc =3D parse_options(argc, argv, prefix, builtin_subcommand_options, bu=
iltin_config_usage,
+			     PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_NO_INTERNAL_HELP|PARSE_OPT=
_KEEP_ARGV0|PARSE_OPT_KEEP_UNKNOWN_OPT);
+	if (subcommand) {
+		argc =3D parse_options(argc, argv, prefix, builtin_subcommand_options, b=
uiltin_config_usage,
+		       PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_NO_INTERNAL_HELP|PARSE_OP=
T_KEEP_UNKNOWN_OPT);
+		return subcommand(argc, argv, prefix);
+	}
+
 	argc =3D parse_options(argc, argv, prefix, builtin_config_options,
 			     builtin_config_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 86dc70769a..f77d2f7847 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -11,6 +11,20 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
+for mode in legacy subcommands
+do
+
+case "$mode" in
+legacy)
+	mode_prefix=3D"--"
+	;;
+subcommands)
+	mode_prefix=3D""
+	;;
+*)
+	BUG "unknown mode $mode";;
+esac
+
 test_expect_success 'setup whitespace config' '
 	sed -e "s/^|//" \
 	    -e "s/[$]$//" \
@@ -460,11 +474,11 @@ version.1.2.3eX.alpha=3Dbeta
 EOF
=20
 test_expect_success 'working --list' '
-	git config --list > output &&
+	git config ${mode_prefix}list > output &&
 	test_cmp expect output
 '
 test_expect_success '--list without repo produces empty output' '
-	git --git-dir=3Dnonexistent config --list >output &&
+	git --git-dir=3Dnonexistent config ${mode_prefix}list >output &&
 	test_must_be_empty output
 '
=20
@@ -476,7 +490,7 @@ version.1.2.3eX.alpha
 EOF
=20
 test_expect_success '--name-only --list' '
-	git config --name-only --list >output &&
+	git config ${mode_prefix}list --name-only >output &&
 	test_cmp expect output
 '
=20
@@ -614,17 +628,17 @@ ein.bahn=3Dstrasse
 EOF
=20
 test_expect_success 'alternative GIT_CONFIG' '
-	GIT_CONFIG=3Dother-config git config --list >output &&
+	GIT_CONFIG=3Dother-config git config ${mode_prefix}list >output &&
 	test_cmp expect output
 '
=20
 test_expect_success 'alternative GIT_CONFIG (--file)' '
-	git config --file other-config --list >output &&
+	git config ${mode_prefix}list --file other-config >output &&
 	test_cmp expect output
 '
=20
 test_expect_success 'alternative GIT_CONFIG (--file=3D-)' '
-	git config --file - --list <other-config >output &&
+	git config ${mode_prefix}list --file - <other-config >output &&
 	test_cmp expect output
 '
=20
@@ -637,6 +651,7 @@ test_expect_success 'editing stdin is an error' '
 '
=20
 test_expect_success 'refer config from subdirectory' '
+	test_when_finished "rm -r x" &&
 	mkdir x &&
 	test_cmp_config -C x strasse --file=3D../other-config --get ein.bahn
 '
@@ -847,7 +862,7 @@ test_expect_success 'line number is reported correctly'=
 '
 '
=20
 test_expect_success 'invalid stdin config' '
-	echo "[broken" | test_must_fail git config --list --file - >output 2>&1 &&
+	echo "[broken" | test_must_fail git config ${mode_prefix}list --file - >o=
utput 2>&1 &&
 	test_grep "bad config line 1 in standard input" output
 '
=20
@@ -1139,7 +1154,7 @@ section.quotecont=3Dcont;inued
 EOF
=20
 test_expect_success 'value continued on next line' '
-	git config --list > result &&
+	git config ${mode_prefix}list > result &&
 	test_cmp expect result
 '
=20
@@ -1163,7 +1178,7 @@ Qsection.sub=3Dsection.val4
 Qsection.sub=3Dsection.val5Q
 EOF
 test_expect_success '--null --list' '
-	git config --null --list >result.raw &&
+	git config ${mode_prefix}list --null >result.raw &&
 	nul_to_q <result.raw >result &&
 	echo >>result &&
 	test_cmp expect result
@@ -1198,6 +1213,7 @@ test_expect_success 'inner whitespace kept verbatim, =
horizontal tabs and spaces'
 '
=20
 test_expect_success SYMLINKS 'symlinked configuration' '
+	test_when_finished "rm myconfig" &&
 	ln -s notyet myconfig &&
 	git config --file=3Dmyconfig test.frotz nitfol &&
 	test -h myconfig &&
@@ -1218,10 +1234,11 @@ test_expect_success SYMLINKS 'symlinked configurati=
on' '
 '
=20
 test_expect_success SYMLINKS 'symlink to nonexistent configuration' '
+	test_when_finished "rm linktonada linktolinktonada" &&
 	ln -s doesnotexist linktonada &&
 	ln -s linktonada linktolinktonada &&
-	test_must_fail git config --file=3Dlinktonada --list &&
-	test_must_fail git config --file=3Dlinktolinktonada --list
+	test_must_fail git config ${mode_prefix}list --file=3Dlinktonada &&
+	test_must_fail git config ${mode_prefix}list --file=3Dlinktolinktonada
 '
=20
 test_expect_success 'check split_cmdline return' '
@@ -1478,7 +1495,7 @@ do
 done
=20
 test_expect_success 'git -c is not confused by empty environment' '
-	GIT_CONFIG_PARAMETERS=3D"" git -c x.one=3D1 config --list
+	GIT_CONFIG_PARAMETERS=3D"" git -c x.one=3D1 config ${mode_prefix}list
 '
=20
 test_expect_success 'GIT_CONFIG_PARAMETERS handles old-style entries' '
@@ -1669,31 +1686,31 @@ test_expect_success 'git config ignores pairs with =
empty count' '
 '
=20
 test_expect_success 'git config fails with invalid count' '
-	test_must_fail env GIT_CONFIG_COUNT=3D10a git config --list 2>error &&
+	test_must_fail env GIT_CONFIG_COUNT=3D10a git config ${mode_prefix}list 2=
>error &&
 	test_grep "bogus count" error &&
-	test_must_fail env GIT_CONFIG_COUNT=3D9999999999999999 git config --list =
2>error &&
+	test_must_fail env GIT_CONFIG_COUNT=3D9999999999999999 git config ${mode_=
prefix}list 2>error &&
 	test_grep "too many entries" error
 '
=20
 test_expect_success 'git config fails with missing config key' '
 	test_must_fail env GIT_CONFIG_COUNT=3D1 GIT_CONFIG_VALUE_0=3D"value" \
-		git config --list 2>error &&
+		git config ${mode_prefix}list 2>error &&
 	test_grep "missing config key" error
 '
=20
 test_expect_success 'git config fails with missing config value' '
 	test_must_fail env GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3D"pair.one" \
-		git config --list 2>error &&
+		git config ${mode_prefix}list 2>error &&
 	test_grep "missing config value" error
 '
=20
 test_expect_success 'git config fails with invalid config pair key' '
 	test_must_fail env GIT_CONFIG_COUNT=3D1 \
 		GIT_CONFIG_KEY_0=3D GIT_CONFIG_VALUE_0=3Dvalue \
-		git config --list &&
+		git config ${mode_prefix}list &&
 	test_must_fail env GIT_CONFIG_COUNT=3D1 \
 		GIT_CONFIG_KEY_0=3Dmissing-section GIT_CONFIG_VALUE_0=3Dvalue \
-		git config --list
+		git config ${mode_prefix}list
 '
=20
 test_expect_success 'environment overrides config file' '
@@ -1733,7 +1750,7 @@ test_expect_success 'git config --edit works' '
 	git config -f tmp test.value no &&
 	echo test.value=3Dyes >expect &&
 	GIT_EDITOR=3D"echo [test]value=3Dyes >" git config -f tmp --edit &&
-	git config -f tmp --list >actual &&
+	git config ${mode_prefix}list -f tmp >actual &&
 	test_cmp expect actual
 '
=20
@@ -1742,7 +1759,7 @@ test_expect_success 'git config --edit respects core.=
editor' '
 	echo test.value=3Dyes >expect &&
 	test_config core.editor "echo [test]value=3Dyes >" &&
 	git config -f tmp --edit &&
-	git config -f tmp --list >actual &&
+	git config ${mode_prefix}list -f tmp >actual &&
 	test_cmp expect actual
 '
=20
@@ -2093,7 +2110,7 @@ test_expect_success '--show-origin with --list' '
 	command line:	user.cmdline=3Dtrue
 	EOF
 	GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3Duser.environ GIT_CONFIG_VALUE_0=
=3Dtrue\
-		git -c user.cmdline=3Dtrue config --list --show-origin >output &&
+		git -c user.cmdline=3Dtrue config ${mode_prefix}list --show-origin >outp=
ut &&
 	test_cmp expect output
 '
=20
@@ -2110,7 +2127,7 @@ test_expect_success '--show-origin with --list --null=
' '
 	includeQcommand line:Quser.cmdline
 	trueQ
 	EOF
-	git -c user.cmdline=3Dtrue config --null --list --show-origin >output.raw=
 &&
+	git -c user.cmdline=3Dtrue config ${mode_prefix}list --null --show-origin=
 >output.raw &&
 	nul_to_q <output.raw >output &&
 	# The here-doc above adds a newline that the --null output would not
 	# include. Add it here to make the two comparable.
@@ -2124,7 +2141,7 @@ test_expect_success '--show-origin with single file' '
 	file:.git/config	user.override=3Dlocal
 	file:.git/config	include.path=3D../include/relative.include
 	EOF
-	git config --local --list --show-origin >output &&
+	git config ${mode_prefix}list --local --show-origin >output &&
 	test_cmp expect output
 '
=20
@@ -2162,7 +2179,7 @@ test_expect_success !MINGW '--show-origin escape spec=
ial file name characters' '
 	cat >expect <<-\EOF &&
 	file:"file\" (dq) and spaces.conf"	user.custom=3Dtrue
 	EOF
-	git config --file "$WEIRDLY_NAMED_FILE" --show-origin --list >output &&
+	git config ${mode_prefix}list --file "$WEIRDLY_NAMED_FILE" --show-origin =
>output &&
 	test_cmp expect output
 '
=20
@@ -2170,7 +2187,7 @@ test_expect_success '--show-origin stdin' '
 	cat >expect <<-\EOF &&
 	standard input:	user.custom=3Dtrue
 	EOF
-	git config --file - --show-origin --list <"$CUSTOM_CONFIG_FILE" >output &&
+	git config ${mode_prefix}list --file - --show-origin <"$CUSTOM_CONFIG_FIL=
E" >output &&
 	test_cmp expect output
 '
=20
@@ -2197,7 +2214,7 @@ test_expect_success '--show-origin blob' '
 		cat >expect <<-EOF &&
 		blob:$blob	user.custom=3Dtrue
 		EOF
-		git config --blob=3D$blob --show-origin --list >output &&
+		git config ${mode_prefix}list --blob=3D$blob --show-origin >output &&
 		test_cmp expect output
 	)
 '
@@ -2213,7 +2230,7 @@ test_expect_success '--show-origin blob ref' '
 		cp "$CUSTOM_CONFIG_FILE" custom.conf &&
 		git add custom.conf &&
 		git commit -m "new config file" &&
-		git config --blob=3Dmain:custom.conf --show-origin --list >output &&
+		git config ${mode_prefix}list --blob=3Dmain:custom.conf --show-origin >o=
utput &&
 		test_cmp expect output
 	)
 '
@@ -2239,13 +2256,14 @@ test_expect_success '--show-scope with --list' '
 	worktree	user.worktree=3Dtrue
 	command	user.cmdline=3Dtrue
 	EOF
+	test_when_finished "git worktree remove wt1" &&
 	git worktree add wt1 &&
 	# We need these to test for worktree scope, but outside of this
 	# test, this is just noise
 	test_config core.repositoryformatversion 1 &&
 	test_config extensions.worktreeConfig true &&
 	git config --worktree user.worktree true &&
-	git -c user.cmdline=3Dtrue config --list --show-scope >output &&
+	git -c user.cmdline=3Dtrue config ${mode_prefix}list --show-scope >output=
 &&
 	test_cmp expect output
 '
=20
@@ -2254,7 +2272,7 @@ test_expect_success !MINGW '--show-scope with --blob'=
 '
 	cat >expect <<-EOF &&
 	command	user.custom=3Dtrue
 	EOF
-	git config --blob=3D$blob --show-scope --list >output &&
+	git config ${mode_prefix}list --blob=3D$blob --show-scope >output &&
 	test_cmp expect output
 '
=20
@@ -2264,7 +2282,7 @@ test_expect_success '--show-scope with --local' '
 	local	user.override=3Dlocal
 	local	include.path=3D../include/relative.include
 	EOF
-	git config --local --list --show-scope >output &&
+	git config ${mode_prefix}list --local --show-scope >output &&
 	test_cmp expect output
 '
=20
@@ -2288,7 +2306,7 @@ test_expect_success '--show-scope with --show-origin'=
 '
 	local	file:.git/../include/relative.include	user.relative=3Dinclude
 	command	command line:	user.cmdline=3Dtrue
 	EOF
-	git -c user.cmdline=3Dtrue config --list --show-origin --show-scope >outp=
ut &&
+	git -c user.cmdline=3Dtrue config ${mode_prefix}list --show-origin --show=
-scope >output &&
 	test_cmp expect output
 '
=20
@@ -2329,7 +2347,7 @@ test_expect_success 'override global and system confi=
g' '
 	global	home.config=3Dtrue
 	local	local.config=3Dtrue
 	EOF
-	git config --show-scope --list >output &&
+	git config ${mode_prefix}list --show-scope >output &&
 	test_cmp expect output &&
=20
 	cat >expect <<-EOF &&
@@ -2338,20 +2356,20 @@ test_expect_success 'override global and system con=
fig' '
 	local	local.config=3Dtrue
 	EOF
 	GIT_CONFIG_NOSYSTEM=3Dfalse GIT_CONFIG_SYSTEM=3Dcustom-system-config GIT_=
CONFIG_GLOBAL=3Dcustom-global-config \
-		git config --show-scope --list >output &&
+		git config ${mode_prefix}list --show-scope >output &&
 	test_cmp expect output &&
=20
 	cat >expect <<-EOF &&
 	local	local.config=3Dtrue
 	EOF
 	GIT_CONFIG_NOSYSTEM=3Dfalse GIT_CONFIG_SYSTEM=3D/dev/null GIT_CONFIG_GLOB=
AL=3D/dev/null \
-		git config --show-scope --list >output &&
+		git config ${mode_prefix}list --show-scope >output &&
 	test_cmp expect output
 '
=20
 test_expect_success 'override global and system config with missing file' '
-	test_must_fail env GIT_CONFIG_GLOBAL=3Ddoes-not-exist GIT_CONFIG_SYSTEM=
=3D/dev/null git config --global --list &&
-	test_must_fail env GIT_CONFIG_GLOBAL=3D/dev/null GIT_CONFIG_SYSTEM=3Ddoes=
-not-exist git config --system --list &&
+	test_must_fail env GIT_CONFIG_GLOBAL=3Ddoes-not-exist GIT_CONFIG_SYSTEM=
=3D/dev/null git config ${mode_prefix}list --global &&
+	test_must_fail env GIT_CONFIG_GLOBAL=3D/dev/null GIT_CONFIG_SYSTEM=3Ddoes=
-not-exist git config ${mode_prefix}list --system &&
 	GIT_CONFIG_GLOBAL=3Ddoes-not-exist GIT_CONFIG_SYSTEM=3Ddoes-not-exist git=
 version
 '
=20
@@ -2478,7 +2496,7 @@ test_expect_success 'set all config with value-patter=
n' '
 	# no match =3D> add new entry
 	cp initial config &&
 	git config --file=3Dconfig abc.key two a+ &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-\EOF &&
 	abc.key=3Done
 	abc.key=3Dtwo
@@ -2491,7 +2509,7 @@ test_expect_success 'set all config with value-patter=
n' '
=20
 	# multiple values, no match =3D> add
 	git config --file=3Dconfig abc.key three a+ &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-\EOF &&
 	abc.key=3Done
 	abc.key=3Dtwo
@@ -2501,7 +2519,7 @@ test_expect_success 'set all config with value-patter=
n' '
=20
 	# single match =3D> replace
 	git config --file=3Dconfig abc.key four h+ &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-\EOF &&
 	abc.key=3Done
 	abc.key=3Dtwo
@@ -2516,7 +2534,7 @@ test_expect_success '--replace-all and value-pattern'=
 '
 	git config --file=3Dconfig --add abc.key two &&
 	git config --file=3Dconfig --add abc.key three &&
 	git config --file=3Dconfig --replace-all abc.key four "o+" &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-\EOF &&
 	abc.key=3Dfour
 	abc.key=3Dthree
@@ -2534,7 +2552,7 @@ test_expect_success 'refuse --fixed-value for incompa=
tible actions' '
 	test_must_fail git config --file=3Dconfig --fixed-value --get-urlmatch de=
v.null bogus &&
 	test_must_fail git config --file=3Dconfig --fixed-value --rename-section =
dev null &&
 	test_must_fail git config --file=3Dconfig --fixed-value --remove-section =
dev &&
-	test_must_fail git config --file=3Dconfig --fixed-value --list &&
+	test_must_fail git config ${mode_prefix}list --file=3Dconfig --fixed-valu=
e &&
 	test_must_fail git config --file=3Dconfig --fixed-value --get-color dev.n=
ull &&
 	test_must_fail git config --file=3Dconfig --fixed-value --get-colorbool d=
ev.null &&
=20
@@ -2555,7 +2573,7 @@ test_expect_success '--fixed-value uses exact string =
matching' '
=20
 	cp initial config &&
 	git config --file=3Dconfig fixed.test bogus "$META" &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-EOF &&
 	fixed.test=3D$META
 	fixed.test=3Dbogus
@@ -2564,7 +2582,7 @@ test_expect_success '--fixed-value uses exact string =
matching' '
=20
 	cp initial config &&
 	git config --file=3Dconfig --fixed-value fixed.test bogus "$META" &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-\EOF &&
 	fixed.test=3Dbogus
 	EOF
@@ -2582,7 +2600,7 @@ test_expect_success '--fixed-value uses exact string =
matching' '
=20
 	cp initial config &&
 	git config --file=3Dconfig --replace-all fixed.test bogus "$META" &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-EOF &&
 	fixed.test=3D$META
 	fixed.test=3Dbogus
@@ -2590,7 +2608,7 @@ test_expect_success '--fixed-value uses exact string =
matching' '
 	test_cmp expect actual &&
=20
 	git config --file=3Dconfig --fixed-value --replace-all fixed.test bogus "=
$META" &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-EOF &&
 	fixed.test=3Dbogus
 	fixed.test=3Dbogus
@@ -2751,4 +2769,6 @@ test_expect_success 'specifying multiple modes causes=
 failure' '
 	test_cmp expect err
 '
=20
+done
+
 test_done
--=20
2.45.0


--eVGEirF29z7Bl7Hv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4mzcACgkQVbJhu7ck
PpSWDhAApsvq9zUbnIkvSRKyQqk9tEwJtjuAM9W+uf16RBM1f7T+D1ZaFqaXt688
5X/w2dMKXv7d6m0jVBcAx0+zpjPniCfJv6oSiY1JbRIKuLOVxhOIYQsDd+DRL7Sx
loK2n6bFZsR/MBqLc+BbdKMMneCKmYmRNQmKpZYJzVT6g+IEgS/X1yCkwC9E5c1Y
fKE0f2BCj7vLifots/bc64sBJVoilw1cAiT0neUqvKpaXOn7WJiiTj5eUnvy8EJM
A6i1bAqhHpjVaHri3J9PXrXfNES8AkWQM1vEZdP6zsL4UeZATf6YoIpmf+Mhr1Ev
WlChsqzTQlzdiTp6yjvMnNbHAxrOWb5O6/kmQxkTgZC4npNSgm020vfgqh8u29HP
UVDhn0y2lj35EQlnSwiY28NsF+1ETjI/dUZeshLQ8yw1Wy+u3B/p1ePZ5DYSCT7d
4HxWcthEu/MlW7j6QxGerwwJHhQU0aclUnbx6jG3aGwx+/8W3HJriwcxg4MIfGlQ
IZtUYCt0m2VohfXxegEhNY+CEN6Y9wyLRTnysMPW+Kx7zaFl3wu48m4I08hMj3/F
5ZgZ1p5d8OZ8QrkAIJK+eYkFnQCC1EHIzjtgujnzn9lko0SqYygGuEMcmyN/Pa7u
GWk2iY+QwUtRYKsjX+9E0OUbBZTb45A+NhwjhyFiJJalBJjzNnI=
=5G0G
-----END PGP SIGNATURE-----

--eVGEirF29z7Bl7Hv--
