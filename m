Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F4D36B17
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529201; cv=none; b=t//BuviDGwRVyjCfiTEomZyEvSfoS4c5geLDHpkEhHi6MxumtLNA9f5TkVy92BNZd1Uw4//rReLzH/ntE1gNOfUs2JkchBmCwYLL1VZgbfNy4p1HqtkVDlEnRik3AwKbp+ZernTgL4d3m74/2TcOZeuu3oqpHUuSbvKvuaRQiO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529201; c=relaxed/simple;
	bh=uN5oIhbfJfpHPrEqnFTAu2diYY2STOqQ1lKKaXNYWUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJvcqGBXh/KvF4BEFpv9q7AbdxCNQXH7+G9eEZNPHGvWF4xwYTLOa6Wp24Ffs1DKyRp3OAOSYODoWiz/i9dYypgeuyQ0pUGPQkQEoGNo3Pj7DmyX7+9S3oZwZQcddJz+RxYyLOMZwTkRu+F70Gqi/drMLvFcqbjZfjavb+eojug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Meda+mAk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CFhwNu4Z; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Meda+mAk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CFhwNu4Z"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 783F311400CD;
	Wed, 27 Mar 2024 04:46:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 27 Mar 2024 04:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711529198; x=1711615598; bh=rKLqOVbsvl
	UCxzdYv6BNwRih4vGrBLuxV7Kxuh5W8wo=; b=Meda+mAkoO6wMPRAOKoNoviIZd
	euUGSyg80ssF5RG2VC97ZPFbF0aa6XYO4ZJPHPk6lkFVTxX5l2XPb9HtdUnEFVph
	0cu6MfcJVEuR1hPFQXbqKQJgS+wlqndbVQcmjd4HRRhl0i+FI9blhqSYnG3mQIvt
	N8tI8shgGsEt1Y4flmPB82vMWzblXOPA0MlSkytvIMWyUDXLX6+HYEy6hZiJ0YgU
	TRT2v9fWGjKlCM968iuNfqjPfuepEf363zeKHBP50rj8BW0fwWNxgyfwX5pX0MpP
	0DSCOkouI7gacWlpOnd3c709rVZ7fAhaVccS6olCtVTaG0TVF62aIJ7BEzcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711529198; x=1711615598; bh=rKLqOVbsvlUCxzdYv6BNwRih4vGr
	BLuxV7Kxuh5W8wo=; b=CFhwNu4Zz/syKDpy1YeHoJlzUrdefHn4ivrCA5eJYSvl
	z1SVgNynK+9hO3/5xUI+I/ryzY1JqnuuXrZZs0hCCef07jn0soBOZupDBWzIEt6z
	VZg8qMNBwYS3xxGvN/oXN7KFxyLZKyLBNNc81n2AAk72pdmUAo7YIP/o/b14vFNo
	7CMfDuKQi7vvYQ2JlSCPKp/8Pf23K/bfjfjDQCCtsbGsrp9rrbqW+fpueI0azfri
	rsLRhF4HUUHV8DKISxQVL1y2+uVFKq1uRsRiTV5OssdSutAiIof78vwnlXm1v1+u
	qQ7jjufmZastrOxzJF6G+jzy3uJBz/uGm6ny+qmHpg==
X-ME-Sender: <xms:7twDZkzF1j0y_cZNjqUPTSIiwdv4hXJ2VLwaMoQ6ZNXLdcRqHPaSpA>
    <xme:7twDZoRlulstUmsrb3lKjoekbsMyisYEdN9cxJXhHGJThsI5qUgJZT-u5zKV7Xji2
    fi6FtQNIHef9ZW_DQ>
X-ME-Received: <xmr:7twDZmUpooqjVoHXYKBS7Q4WIZIRg5ko_7DE-W25iEWLPjxtZJznJTxzDgnz3wM-2vYcOfh37FwXNJmb3U8pxl08roOFqR-yCvXxiRvjEmKKsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:7twDZijKO7yW9KzrFugrCHIxaxajaIXGFxTy3nXoushqj00_04o2bA>
    <xmx:7twDZmDHOCY3tE4BIql9XVupSSgKb7svuiQB84r9xYRovz1wRmWgIA>
    <xmx:7twDZjLAs9bUW5Xpxz1U9jT7898CT92MtItUlwGJjCHCcAYWmf4CYA>
    <xmx:7twDZtBS6-UH8gFAehPGFWpYNsUu1zAsBsG42xh1E_vSpLGheAogjQ>
    <xmx:7twDZsBYWDGcsrn0fyXwH4JJvQzBkp-xjHcXuACK5yvikssWOe_-Ew>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 04:46:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bdfd174e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 08:46:23 +0000 (UTC)
Date: Wed, 27 Mar 2024 09:46:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 06/13] builtin/config: introduce "list" subcommand
Message-ID: <b50f32d074a7a15f07140a4ed0b3d06a0d58792d.1711527812.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1711527811.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UnFK6MdIVOKaBdxj"
Content-Disposition: inline
In-Reply-To: <cover.1711527811.git.ps@pks.im>


--UnFK6MdIVOKaBdxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While git-config(1) has several modes, those modes are not exposed with
subcommands but instead by specifying e.g. `--unset` or `--list`. This
user interface is not really in line with how our more modern commands
work, where it is a lot more customary to say e.g. `git remote list`.
Furthermore, to add to the confusion, git-config(1) also allows the user
to request modes implicitly by just specifying the correct number of
arguments. Thus, `git config foo.bar` will retrieve the value of
"foo.bar" while `git config foo.bar baz` will set it to "baz".

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
index a6e82b871b..485e84cd0f 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,6 +9,7 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
+'git config list' [<file-option>] [<display-option>] [--includes]
 'git config' [<file-option>] [--type=3D<type>] [--fixed-value] [--show-ori=
gin] [--show-scope] [-z|--null] <name> [<value> [<value-pattern>]]
 'git config' [<file-option>] [--type=3D<type>] --add <name> <value>
 'git config' [<file-option>] [--type=3D<type>] [--fixed-value] --replace-a=
ll <name> <value> [<value-pattern>]
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
@@ -178,10 +184,6 @@ See also <<FILES>>.
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
@@ -236,7 +238,7 @@ Valid `<type>`'s include:
 	contain line breaks.
=20
 --name-only::
-	Output only the names of config variables for `--list` or
+	Output only the names of config variables for `list` or
 	`--get-regexp`.
=20
 --show-origin::
@@ -288,10 +290,20 @@ Valid `<type>`'s include:
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
index ce2d3fecd4..7dd588a622 100644
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
@@ -705,14 +712,24 @@ static void handle_nul(void) {
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
@@ -736,14 +753,11 @@ static struct option builtin_config_options[] =3D {
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
 	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when com=
paring values to 'value-pattern'")),
+	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direct=
ives on lookup")),
 	OPT_END(),
 };
=20
@@ -752,6 +766,42 @@ static NORETURN void usage_builtin_config(void)
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
 	char *value =3D NULL;
@@ -761,6 +811,22 @@ int cmd_config(int argc, const char **argv, const char=
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
index 2d1bc1e27e..b140674293 100755
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
 test_expect_success 'clear default config' '
 	rm -f .git/config
 '
@@ -350,11 +364,11 @@ version.1.2.3eX.alpha=3Dbeta
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
@@ -366,7 +380,7 @@ version.1.2.3eX.alpha
 EOF
=20
 test_expect_success '--name-only --list' '
-	git config --name-only --list >output &&
+	git config ${mode_prefix}list --name-only >output &&
 	test_cmp expect output
 '
=20
@@ -504,17 +518,17 @@ ein.bahn=3Dstrasse
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
@@ -527,6 +541,7 @@ test_expect_success 'editing stdin is an error' '
 '
=20
 test_expect_success 'refer config from subdirectory' '
+	test_when_finished "rm -r x" &&
 	mkdir x &&
 	test_cmp_config -C x strasse --file=3D../other-config --get ein.bahn
 '
@@ -737,7 +752,7 @@ test_expect_success 'line number is reported correctly'=
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
@@ -1029,7 +1044,7 @@ section.quotecont=3Dcont;inued
 EOF
=20
 test_expect_success 'value continued on next line' '
-	git config --list > result &&
+	git config ${mode_prefix}list > result &&
 	test_cmp expect result
 '
=20
@@ -1053,7 +1068,7 @@ Qsection.sub=3Dsection.val4
 Qsection.sub=3Dsection.val5Q
 EOF
 test_expect_success '--null --list' '
-	git config --null --list >result.raw &&
+	git config ${mode_prefix}list --null >result.raw &&
 	nul_to_q <result.raw >result &&
 	echo >>result &&
 	test_cmp expect result
@@ -1072,6 +1087,7 @@ test_expect_success 'inner whitespace kept verbatim' '
 '
=20
 test_expect_success SYMLINKS 'symlinked configuration' '
+	test_when_finished "rm myconfig" &&
 	ln -s notyet myconfig &&
 	git config --file=3Dmyconfig test.frotz nitfol &&
 	test -h myconfig &&
@@ -1092,10 +1108,11 @@ test_expect_success SYMLINKS 'symlinked configurati=
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
@@ -1352,7 +1369,7 @@ do
 done
=20
 test_expect_success 'git -c is not confused by empty environment' '
-	GIT_CONFIG_PARAMETERS=3D"" git -c x.one=3D1 config --list
+	GIT_CONFIG_PARAMETERS=3D"" git -c x.one=3D1 config ${mode_prefix}list
 '
=20
 test_expect_success 'GIT_CONFIG_PARAMETERS handles old-style entries' '
@@ -1543,31 +1560,31 @@ test_expect_success 'git config ignores pairs with =
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
@@ -1607,7 +1624,7 @@ test_expect_success 'git config --edit works' '
 	git config -f tmp test.value no &&
 	echo test.value=3Dyes >expect &&
 	GIT_EDITOR=3D"echo [test]value=3Dyes >" git config -f tmp --edit &&
-	git config -f tmp --list >actual &&
+	git config ${mode_prefix}list -f tmp >actual &&
 	test_cmp expect actual
 '
=20
@@ -1616,7 +1633,7 @@ test_expect_success 'git config --edit respects core.=
editor' '
 	echo test.value=3Dyes >expect &&
 	test_config core.editor "echo [test]value=3Dyes >" &&
 	git config -f tmp --edit &&
-	git config -f tmp --list >actual &&
+	git config ${mode_prefix}list -f tmp >actual &&
 	test_cmp expect actual
 '
=20
@@ -1967,7 +1984,7 @@ test_expect_success '--show-origin with --list' '
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
@@ -1984,7 +2001,7 @@ test_expect_success '--show-origin with --list --null=
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
@@ -1998,7 +2015,7 @@ test_expect_success '--show-origin with single file' '
 	file:.git/config	user.override=3Dlocal
 	file:.git/config	include.path=3D../include/relative.include
 	EOF
-	git config --local --list --show-origin >output &&
+	git config ${mode_prefix}list --local --show-origin >output &&
 	test_cmp expect output
 '
=20
@@ -2036,7 +2053,7 @@ test_expect_success !MINGW '--show-origin escape spec=
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
@@ -2044,7 +2061,7 @@ test_expect_success '--show-origin stdin' '
 	cat >expect <<-\EOF &&
 	standard input:	user.custom=3Dtrue
 	EOF
-	git config --file - --show-origin --list <"$CUSTOM_CONFIG_FILE" >output &&
+	git config ${mode_prefix}list --file - --show-origin <"$CUSTOM_CONFIG_FIL=
E" >output &&
 	test_cmp expect output
 '
=20
@@ -2071,7 +2088,7 @@ test_expect_success '--show-origin blob' '
 		cat >expect <<-EOF &&
 		blob:$blob	user.custom=3Dtrue
 		EOF
-		git config --blob=3D$blob --show-origin --list >output &&
+		git config ${mode_prefix}list --blob=3D$blob --show-origin >output &&
 		test_cmp expect output
 	)
 '
@@ -2087,7 +2104,7 @@ test_expect_success '--show-origin blob ref' '
 		cp "$CUSTOM_CONFIG_FILE" custom.conf &&
 		git add custom.conf &&
 		git commit -m "new config file" &&
-		git config --blob=3Dmain:custom.conf --show-origin --list >output &&
+		git config ${mode_prefix}list --blob=3Dmain:custom.conf --show-origin >o=
utput &&
 		test_cmp expect output
 	)
 '
@@ -2113,13 +2130,14 @@ test_expect_success '--show-scope with --list' '
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
@@ -2128,7 +2146,7 @@ test_expect_success !MINGW '--show-scope with --blob'=
 '
 	cat >expect <<-EOF &&
 	command	user.custom=3Dtrue
 	EOF
-	git config --blob=3D$blob --show-scope --list >output &&
+	git config ${mode_prefix}list --blob=3D$blob --show-scope >output &&
 	test_cmp expect output
 '
=20
@@ -2138,7 +2156,7 @@ test_expect_success '--show-scope with --local' '
 	local	user.override=3Dlocal
 	local	include.path=3D../include/relative.include
 	EOF
-	git config --local --list --show-scope >output &&
+	git config ${mode_prefix}list --local --show-scope >output &&
 	test_cmp expect output
 '
=20
@@ -2162,7 +2180,7 @@ test_expect_success '--show-scope with --show-origin'=
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
@@ -2203,7 +2221,7 @@ test_expect_success 'override global and system confi=
g' '
 	global	home.config=3Dtrue
 	local	local.config=3Dtrue
 	EOF
-	git config --show-scope --list >output &&
+	git config ${mode_prefix}list --show-scope >output &&
 	test_cmp expect output &&
=20
 	cat >expect <<-EOF &&
@@ -2212,20 +2230,20 @@ test_expect_success 'override global and system con=
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
@@ -2352,7 +2370,7 @@ test_expect_success 'set all config with value-patter=
n' '
 	# no match =3D> add new entry
 	cp initial config &&
 	git config --file=3Dconfig abc.key two a+ &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-\EOF &&
 	abc.key=3Done
 	abc.key=3Dtwo
@@ -2365,7 +2383,7 @@ test_expect_success 'set all config with value-patter=
n' '
=20
 	# multiple values, no match =3D> add
 	git config --file=3Dconfig abc.key three a+ &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-\EOF &&
 	abc.key=3Done
 	abc.key=3Dtwo
@@ -2375,7 +2393,7 @@ test_expect_success 'set all config with value-patter=
n' '
=20
 	# single match =3D> replace
 	git config --file=3Dconfig abc.key four h+ &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-\EOF &&
 	abc.key=3Done
 	abc.key=3Dtwo
@@ -2390,7 +2408,7 @@ test_expect_success '--replace-all and value-pattern'=
 '
 	git config --file=3Dconfig --add abc.key two &&
 	git config --file=3Dconfig --add abc.key three &&
 	git config --file=3Dconfig --replace-all abc.key four "o+" &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-\EOF &&
 	abc.key=3Dfour
 	abc.key=3Dthree
@@ -2408,7 +2426,7 @@ test_expect_success 'refuse --fixed-value for incompa=
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
@@ -2429,7 +2447,7 @@ test_expect_success '--fixed-value uses exact string =
matching' '
=20
 	cp initial config &&
 	git config --file=3Dconfig fixed.test bogus "$META" &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-EOF &&
 	fixed.test=3D$META
 	fixed.test=3Dbogus
@@ -2438,7 +2456,7 @@ test_expect_success '--fixed-value uses exact string =
matching' '
=20
 	cp initial config &&
 	git config --file=3Dconfig --fixed-value fixed.test bogus "$META" &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-\EOF &&
 	fixed.test=3Dbogus
 	EOF
@@ -2456,7 +2474,7 @@ test_expect_success '--fixed-value uses exact string =
matching' '
=20
 	cp initial config &&
 	git config --file=3Dconfig --replace-all fixed.test bogus "$META" &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-EOF &&
 	fixed.test=3D$META
 	fixed.test=3Dbogus
@@ -2464,7 +2482,7 @@ test_expect_success '--fixed-value uses exact string =
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
@@ -2625,4 +2643,6 @@ test_expect_success 'specifying multiple modes causes=
 failure' '
 	test_cmp expect err
 '
=20
+done
+
 test_done
--=20
2.44.GIT


--UnFK6MdIVOKaBdxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYD3OkACgkQVbJhu7ck
PpRhxQ//ca00JUG1wVGI+iXa7L46sYz/PUbKHU4ylIjlkGZ2O77N6FAsaWQrj1Td
Pu1Z5mdQhXPE5cmoouxzuCvSOOYejGNOeNPhXXszi4vfFIyAlsqFs/q+WMIfXjIf
HOHRVdIVkkokL9MrP7BIKkXzlvQR18+TMunJEHsHrWszRXEJ4FJdshEfg9nQ+gbX
yAWATsNKp03tK7iN099yDcnzzODbGVVqSVoMsFk464fV4wFPBRrn5xVau79bL2DQ
C5JH1rPn8EmAkMazwqi3tSBzctOYPCioM+yXsvB0+FVP1lsU5dTC9gU6W170Bv+/
xgEF4/ftRHC5oOnITyCMxSUS3Tin+oFwPILky2znSIIYdlmfTfOqaWOxo/Qd0yMG
KqAtN3dUV5uKLd1js7KEJNmFjEIWHrJyOViEHoa2TMBoTN/PBSxt60Br8CmncPwj
+7sdcsP03xUF18+IQWzr7y68AXidLf6iWZw4ZnqWoUsCCakGOYer3Ws3Gbw8jXGr
7yoFZi4vZSFvqb5LR9bNFyx+ciDOaQ3R8G18E+DsufN1aKPLmEf+BdqzEix0ucvW
1uFfi5pZOcrKHHpT0fdzjUT49Agpn28Rn034kD+F+DfswAYbwRxW8cvqKPHe0NbP
2p3xUtB6zsAZAHbXLIG2PdBPilj/3f3uE4GOb49+s6S3gIzFgss=
=l3e0
-----END PGP SIGNATURE-----

--UnFK6MdIVOKaBdxj--
