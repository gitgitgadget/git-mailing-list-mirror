Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063703839C
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529225; cv=none; b=cRKPemntFcF2+3BNeipXEDLOBXP//l1eqhFfgsVoAB5qwuakTPw3Rlvd/JMwIgWGaNxsry6IEP648HtAeh0P+z9Xm3jd3orZqg0/N51CVpbD3YkYlWxihRWgcKHZvxuK/QLBGJk/Ijpq2sjklNAqv5x4vZR1H2TvjB8J51knqag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529225; c=relaxed/simple;
	bh=UNYCq6IXcT0ESv7z6eQuYg/k2lJUtYrvJIXTshb7CAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/g7KRukuQh5GLaFwR2FNDKjcD9Hdl8s5YD73dFrZrCn3JY5Dbm+jdgbUQLqaWZ5aQZuTSamUDHyx/+UPArmNvoH3UYJEokZdWp8SUHtcraVhO3rBtTe6ta5S48/hX57kAofrczMCjypmNWROy0+jz3eZxVvU8hJuJPOI443YX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EFNhScQp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L/6v1pUJ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EFNhScQp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L/6v1pUJ"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 241F7138015E;
	Wed, 27 Mar 2024 04:47:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 27 Mar 2024 04:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711529223; x=1711615623; bh=k1WQmxZsY7
	3p584j7ogy3ZQtIE7I8mqNcTvR72mO4PI=; b=EFNhScQpnb404eoKxQkvNzxYq8
	yXGcGI8qqT5rr17KrmaR/pUfSy2iCqNaSnp9b5HEt3Imvf4MsU2J3L8OGNXpIVYi
	8qcOji5/qJ+tHpXbuiUt8NErUBB5EgpiDliZ5YS3//VmfgpS2M9okA200VQ7eOm2
	OCGFqJSJMwbZUk+64vpRd5fBa98ldtN7cv52LowY/qA3krsE78fQwRNeO6zUm9dM
	sE1Yqn+a/IMI4BMF5SCjyaEJkA2MEXnrXC3K9dmG8hX4zl1KR2JCDD3Owp3pqkkG
	3U7gUM9Y5+sOyOyj/n7IMlMb3cv2Wr9h1CXXbQaPNazDDe+2Q8c/n0LBdTHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711529223; x=1711615623; bh=k1WQmxZsY73p584j7ogy3ZQtIE7I
	8mqNcTvR72mO4PI=; b=L/6v1pUJE2NcExAVp4UaMcMld9avd/eqJ3C3mBCuinyY
	XyMB74mhyVGBHqm/fszyrhygdICZf2GJ7AHGNFaBhURAXWbmndyXFnOasKY00U6T
	Y9flBun2UOfaS9rZ8dnryrymMAacei17PJ2fqMqmyqnlFqej4mDJF5/7U5skqXCz
	35cMFu8NJ9ibekYYHPQoKJjFMtF4btKX8vHo1MggE/CLhbA9KcGy3R8KRqHq8TWO
	W5yr2Q+WhplxbFREzh8uO4pz1mNVifUrIYwSGoXdpmUg8RCN+75LCMPOlBCooacF
	oePMXOp5YH93AFjXGmRx63gFGhtyDX9KR3D4kvTkuA==
X-ME-Sender: <xms:Bt0DZhCVcno5RmQywKA3lGx0d216lHgF6j5e0V8GKPJAg8E6JDNibw>
    <xme:Bt0DZvjza6dAK0daYJXn8PyftN5J-owrAM_G6SxNq0SER52r3l8btzQ-AOIzeyvbu
    N-mkqdVxPxYui8xQA>
X-ME-Received: <xmr:Bt0DZskIKDbeyss7sFIfudUzOaJ71SyB0Xuk-7IBJ90t05zH7uEaCd5DGIUSA1bhBKwBReysps5nMh9Gk5O551rHGi1Lg7jQnY4vKi9u6ajc8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Bt0DZry_H7OJGv1xXKwC1vSAEl8ePTv0OXVIceVAPffsZp7SYWNlTA>
    <xmx:Bt0DZmRPW9BHL5xssoG7NI6GYHXql3MsYHCxyHzOTEE9izv2HSiq8w>
    <xmx:Bt0DZuZBSykFssr-XG6mS_byL064KiKFeXZaMt_1uPGlRkccpZW-JA>
    <xmx:Bt0DZnRE5dg-CHucBhqpDFM64Zca8zo-8GnBgN6kkzLDGVdTqTmzQw>
    <xmx:B90DZjRsGtnfjocDnGtgzSgUYe_9JeFk8GsXQ3jD2tWWYiFuGYSF9w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 04:47:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 28ea266c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 08:46:47 +0000 (UTC)
Date: Wed, 27 Mar 2024 09:46:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 12/13] builtin/config: introduce "edit" subcommand
Message-ID: <4a6512c88af82013b8a08767515f5715af05c6bb.1711527812.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1711527811.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ec1oBKK8wNoKMjpS"
Content-Disposition: inline
In-Reply-To: <cover.1711527811.git.ps@pks.im>


--ec1oBKK8wNoKMjpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new "edit" subcommand to git-config(1). Please refer to
preceding commits regarding the motivation behind this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-config.txt | 17 ++++----
 builtin/config.c             | 81 ++++++++++++++++++++++++------------
 t/t1300-config.sh            |  6 +--
 3 files changed, 68 insertions(+), 36 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index b9ca5e83a2..448bf43bb3 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -15,8 +15,8 @@ SYNOPSIS
 'git config unset' [<file-option>] [--all] [--value=3D<value>] [--fixed-va=
lue] <name> <value>
 'git config rename-section' [<file-option>] <old-name> <new-name>
 'git config remove-section' [<file-option>] <name>
+'git config edit' [<file-option>]
 'git config' [<file-option>] --get-colorbool <name> [<stdout-is-tty>]
-'git config' [<file-option>] -e | --edit
=20
 DESCRIPTION
 -----------
@@ -98,6 +98,11 @@ rename-section::
 remove-section::
 	Remove the given section from the configuration file.
=20
+edit::
+	Opens an editor to modify the specified config file; either
+	`--system`, `--global`, `--local` (default), `--worktree`, or
+	`--file <config-file>`.
+
 [[OPTIONS]]
 OPTIONS
 -------
@@ -262,12 +267,6 @@ Valid `<type>`'s include:
 	When the color setting for `name` is undefined, the command uses
 	`color.ui` as fallback.
=20
--e::
---edit::
-	Opens an editor to modify the specified config file; either
-	`--system`, `--global`, `--local` (default), `--worktree`, or
-	`--file <config-file>`.
-
 --[no-]includes::
 	Respect `include.*` directives in config files when looking up
 	values. Defaults to `off` when a specific file is given (e.g.,
@@ -324,6 +323,10 @@ recommended to migrate to the new syntax.
 --remove-section <name>::
 	Replaced by `git config remove-section <name>`.
=20
+-e::
+--edit::
+	Replaced by `git config edit`.
+
 CONFIGURATION
 -------------
 `pager.config` is only respected when listing configuration, i.e., when
diff --git a/builtin/config.c b/builtin/config.c
index 6be6717f26..b8cb940b1e 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -22,6 +22,7 @@ static const char *const builtin_config_usage[] =3D {
 	N_("git config unset [<file-option>] [--all] [--value=3D<value>] [--fixed=
-value] <name> <value>"),
 	N_("git config rename-section [<file-option>] <old-name> <new-name>"),
 	N_("git config remove-section [<file-option>] <name>"),
+	N_("git config edit [<file-option>]"),
 	NULL
 };
=20
@@ -55,6 +56,11 @@ static const char *const builtin_config_remove_section_u=
sage[] =3D {
 	NULL
 };
=20
+static const char *const builtin_config_edit_usage[] =3D {
+	N_("git config edit [<file-option>]"),
+	NULL
+};
+
 static char *key;
 static regex_t *key_regexp;
 static const char *value_pattern;
@@ -1002,6 +1008,53 @@ static int cmd_config_remove_section(int argc, const=
 char **argv, const char *pr
 	return 0;
 }
=20
+static int show_editor(void)
+{
+	char *config_file;
+
+	if (!given_config_source.file && !startup_info->have_repository)
+		die(_("not in a git directory"));
+	if (given_config_source.use_stdin)
+		die(_("editing stdin is not supported"));
+	if (given_config_source.blob)
+		die(_("editing blobs is not supported"));
+	git_config(git_default_config, NULL);
+	config_file =3D given_config_source.file ?
+			xstrdup(given_config_source.file) :
+			git_pathdup("config");
+	if (use_global_config) {
+		int fd =3D open(config_file, O_CREAT | O_EXCL | O_WRONLY, 0666);
+		if (fd >=3D 0) {
+			char *content =3D default_user_config();
+			write_str_in_full(fd, content);
+			free(content);
+			close(fd);
+		}
+		else if (errno !=3D EEXIST)
+			die_errno(_("cannot create configuration file %s"), config_file);
+	}
+	launch_editor(config_file, NULL, NULL);
+	free(config_file);
+
+	return 0;
+}
+
+static int cmd_config_edit(int argc, const char **argv, const char *prefix)
+{
+	struct option opts[] =3D {
+		CONFIG_LOCATION_OPTIONS,
+		OPT_END(),
+	};
+
+	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_edit_usag=
e, 0);
+	check_write();
+	check_argc(argc, 0, 0);
+
+	handle_config_location(prefix);
+
+	return show_editor();
+}
+
 static struct option builtin_subcommand_options[] =3D {
 	OPT_SUBCOMMAND("list", &subcommand, cmd_config_list),
 	OPT_SUBCOMMAND("get", &subcommand, cmd_config_get),
@@ -1009,6 +1062,7 @@ static struct option builtin_subcommand_options[] =3D=
 {
 	OPT_SUBCOMMAND("unset", &subcommand, cmd_config_unset),
 	OPT_SUBCOMMAND("rename-section", &subcommand, cmd_config_rename_section),
 	OPT_SUBCOMMAND("remove-section", &subcommand, cmd_config_remove_section),
+	OPT_SUBCOMMAND("edit", &subcommand, cmd_config_edit),
 	OPT_END(),
 };
=20
@@ -1127,32 +1181,7 @@ int cmd_config(int argc, const char **argv, const ch=
ar *prefix)
 		}
 	}
 	else if (actions =3D=3D ACTION_EDIT) {
-		char *config_file;
-
-		check_argc(argc, 0, 0);
-		if (!given_config_source.file && !startup_info->have_repository)
-			die(_("not in a git directory"));
-		if (given_config_source.use_stdin)
-			die(_("editing stdin is not supported"));
-		if (given_config_source.blob)
-			die(_("editing blobs is not supported"));
-		git_config(git_default_config, NULL);
-		config_file =3D given_config_source.file ?
-				xstrdup(given_config_source.file) :
-				git_pathdup("config");
-		if (use_global_config) {
-			int fd =3D open(config_file, O_CREAT | O_EXCL | O_WRONLY, 0666);
-			if (fd >=3D 0) {
-				char *content =3D default_user_config();
-				write_str_in_full(fd, content);
-				free(content);
-				close(fd);
-			}
-			else if (errno !=3D EEXIST)
-				die_errno(_("cannot create configuration file %s"), config_file);
-		}
-		launch_editor(config_file, NULL, NULL);
-		free(config_file);
+		ret =3D show_editor();
 	}
 	else if (actions =3D=3D ACTION_SET) {
 		check_write();
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 2f8d0310b1..3049b61533 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -556,7 +556,7 @@ test_expect_success 'setting a value in stdin is an err=
or' '
 '
=20
 test_expect_success 'editing stdin is an error' '
-	test_must_fail git config --file - --edit
+	test_must_fail git config ${mode_prefix}edit --file -
 '
=20
 test_expect_success 'refer config from subdirectory' '
@@ -1642,7 +1642,7 @@ test_expect_success 'command line overrides environme=
nt config' '
 test_expect_success 'git config --edit works' '
 	git config -f tmp test.value no &&
 	echo test.value=3Dyes >expect &&
-	GIT_EDITOR=3D"echo [test]value=3Dyes >" git config -f tmp --edit &&
+	GIT_EDITOR=3D"echo [test]value=3Dyes >" git config ${mode_prefix}edit -f =
tmp &&
 	git config ${mode_prefix}list -f tmp >actual &&
 	test_cmp expect actual
 '
@@ -1651,7 +1651,7 @@ test_expect_success 'git config --edit respects core.=
editor' '
 	git config -f tmp test.value no &&
 	echo test.value=3Dyes >expect &&
 	test_config core.editor "echo [test]value=3Dyes >" &&
-	git config -f tmp --edit &&
+	git config ${mode_prefix}edit -f tmp &&
 	git config ${mode_prefix}list -f tmp >actual &&
 	test_cmp expect actual
 '
--=20
2.44.GIT


--ec1oBKK8wNoKMjpS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYD3QIACgkQVbJhu7ck
PpSXBg//TuvtwRZ7qK0jlTUdJe+HXX+Octk6+zEVevgUmb/i07ATtfwO8sT9R9k9
9cDOEKBRbfjfs1W8S/Lpla1ubaC9+iMTechbyXVM70QYGayvSB1Udlu+bPys64ov
zuUbB2I6/0a29LzXyjfWbNusNIch5o70e301sxqmWMEIkGpFWcU613JHxhPJsCRX
4EaEcYx0D9nQFXHO/nUPYMJDLx5rKx0rG2eG39D3baiP1MFkD4qipQIkS9/cbPf7
DXg4t8BswmJSGhbAqIq828JIE2Hq3+Gpy64gWvZBkoqU4G10yD3Y7BPryUfPmhvb
FIQm1Lv6780+bPFNKHuCgVv3zXfc43uRZIAxBWLfg+jX/y0f8c8v0ul3ObZoFWlk
9DHUN2SdbMYUq53Op6puOMx41ElzFbsCR1CHlNbStjC1/kSFPRcUCTH4MID/JopK
M2+n6ZZDMIzwki9SKLvdkmbK5PYwEMtwKjjTtt7qPaLTL3MiwqGgOYBIu96HjRtZ
OL54L1l7+ThY0i8fmdVSbLc+AX21mxVeIgKLuvOxblSvLl0LhurnWU1Mfi2Kd7+r
lF0IMep8DooBvniHIMivkYJF16xNh5TzIxjVOypPB4uxBBrzXxVzZLzHAXidS7RA
9d4ZyDDBM+Udwa1cmXDeJFmO/QbZMOqEDUs0xcuXsC5bDm3U4o4=
=2oZH
-----END PGP SIGNATURE-----

--ec1oBKK8wNoKMjpS--
