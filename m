Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30E41422A7
	for <git@vger.kernel.org>; Mon,  6 May 2024 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985820; cv=none; b=oCW6zAIEYz7oaeOGu7lHVEsGqwHqUj0iYrPcOeWpbpGjYiatHTPeHOkNt6RWdycfTJQqi7+NR6dY0At4jLFNVLctn9U7vlZIDCFgLVuapvuqPHJv0dgF1tZrfwj+4WjJvSHv7JlNL52KdmaCI4FhgV3OTSLFgyLssW3B9e6x+bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985820; c=relaxed/simple;
	bh=O6S9J94zeCk05aeNBKP3r0L01W0EWtZYt3fBwxiB4zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmN1CI/v27Pyerh/2c0ZHCyJIygIXBy0f4bF9V2cInFF/fN0Tf6GjaF9fGkkNi/ROjlvSC3IHn1iWmJJgnPvm+popy1LLF2pPtu3V89RsDMeKCYkYWYy7QdciInID37bU3/2wOp9Mb750moLgmZBZsEcbgwSIP+NeDFVGVoDqY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rhi4ksnf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b55OmuCy; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rhi4ksnf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b55OmuCy"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 927181C0012E;
	Mon,  6 May 2024 04:56:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 06 May 2024 04:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714985817; x=1715072217; bh=b7iJmiMKCl
	Coxu6dfljLANIrxXolpcvQRNPRmVVXYZA=; b=Rhi4ksnf12NPRnlk0tS80P6ZZ1
	LBQJLQ7yuC7QoDUXnMA99T1iiwEj+3cWfaLvciH1Oh9ANtrx94N9sl8f1CYys62O
	OWXi62TU3c13eTNPxtHNJxbWiDBG5L7+78bCI+RPQWLzY5l9lJyN6lfYY57xbRvi
	KZyED3PEdq68ihKlwnqVZwKr89usxlH1AmHWUiZt8gTpRVBAphnAwb3/vbP5m7ah
	7MrdcGJI6YEHkZkUrkY9opULCDTS1SuGsbbBWn8di9o68kZXq1t42taayDjpUris
	2YLyEP93VAl1CWseDfDVpsjxqqFuO9eVM6D89D1M0s+cRJ/i47Es6ODq2H/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714985817; x=1715072217; bh=b7iJmiMKClCoxu6dfljLANIrxXol
	pcvQRNPRmVVXYZA=; b=b55OmuCyhpxtHSEK03/uv9z/yLkz5A47q6d/jF24/2hh
	RHuoIXTECWOEFd4VPQW5EiLSA503eZT8ynsaaZSsdi6YTfFavubm6rg48urwnsHF
	bQ5toNVYENnVti/kW3xItKpGukeEgzgYdz+3Z+ZHQtgECjhvWkWBb5P4wssCOPTO
	PWeA21m+U9cEASuET/zSdPu2hKHzmH595YSaL5fAGSylEzMFb6IvpBROuvDZ3TCW
	fsDpRWdVZO966veX6EsFwTXcfpVWy7fd5kTja58U0qQXJSls8QAWaCFk2Z6Z2g41
	Dp3BFfiPEr+Mb4ypALOUz8MaddIBMr1DJ7i20LVjbg==
X-ME-Sender: <xms:WZs4ZrpvDsWpEewqRfe2bdVvHUVkMaiy35AIbNF55xjYt27LqVcNIw>
    <xme:WZs4ZlrK9HKcumu4gW-i4If_b80ncRUw8zME2wUW-lIjrmm7iC4x6jul4H72qlMpx
    196X8HT2uKk7CTX1w>
X-ME-Received: <xmr:WZs4ZoNcX24JNFAJll9jwKmtkqEb6huXtNbH4jXO7EyigCMVchyhS_zBIww2CvdrzThPnFb5TQ0be3tRowirlQYdj1tSzx4AWPDkq4OqVVsqQXcJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:WZs4Zu6BX9OGbzCEWlULeJbc-tm7xUsa15jHcGsV6-juvoHoFLaFnw>
    <xmx:WZs4Zq7qETZBpOizfAH5f6NKwFjD8V8ykguirg8rAfz-YuOCYWgrFw>
    <xmx:WZs4Zmjcx9t0SAt-SB_WlJ26yw7vPKdOzeAIcSGvLYdoapCw6CNk5g>
    <xmx:WZs4Zs7Zm_aasnsHl4mQ0G14E8DmTYjWAOUtXifQaOW1Z99VNPZdug>
    <xmx:WZs4Zstr-gc_SAnD0M9xsBUZbQoodho8owb_U4V07HhV-I9DUHe0rgSC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 04:56:55 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d5c094d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 08:56:49 +0000 (UTC)
Date: Mon, 6 May 2024 10:56:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>, rsbecker@nexbridge.com
Subject: [PATCH v5 13/14] builtin/config: introduce "edit" subcommand
Message-ID: <1893c23afc982e1d442f50b5e4b8ab0073aaa05d.1714982328.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714982328.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qn1BfWb+BVlli2Qo"
Content-Disposition: inline
In-Reply-To: <cover.1714982328.git.ps@pks.im>


--Qn1BfWb+BVlli2Qo
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
index ef46520c15..65c645d461 100644
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
@@ -274,12 +279,6 @@ Valid `<type>`'s include:
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
@@ -336,6 +335,10 @@ recommended to migrate to the new syntax.
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
index cea03fb517..8f7fa8f31a 100644
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
@@ -1011,6 +1017,53 @@ static int cmd_config_remove_section(int argc, const=
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
@@ -1018,6 +1071,7 @@ static struct option builtin_subcommand_options[] =3D=
 {
 	OPT_SUBCOMMAND("unset", &subcommand, cmd_config_unset),
 	OPT_SUBCOMMAND("rename-section", &subcommand, cmd_config_rename_section),
 	OPT_SUBCOMMAND("remove-section", &subcommand, cmd_config_remove_section),
+	OPT_SUBCOMMAND("edit", &subcommand, cmd_config_edit),
 	OPT_END(),
 };
=20
@@ -1144,32 +1198,7 @@ int cmd_config(int argc, const char **argv, const ch=
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
index 9d71ec1260..f3c4d28e06 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -666,7 +666,7 @@ test_expect_success 'setting a value in stdin is an err=
or' '
 '
=20
 test_expect_success 'editing stdin is an error' '
-	test_must_fail git config --file - --edit
+	test_must_fail git config ${mode_prefix}edit --file -
 '
=20
 test_expect_success 'refer config from subdirectory' '
@@ -1768,7 +1768,7 @@ test_expect_success 'command line overrides environme=
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
@@ -1777,7 +1777,7 @@ test_expect_success 'git config --edit respects core.=
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
2.45.0


--Qn1BfWb+BVlli2Qo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4m1MACgkQVbJhu7ck
PpRBVg/+LW1GpzDyUsvzxUNJq7LO68pfjO0JAYmFewPdPBE+2JXd6rSZ/Gg5yxJb
nNFhq7rb52ipytY/J5Br0XpltVnypy5ic2HHXUbx/Qsis/PgduBEtUlGdteI2taA
Q0xh/AthBDULHZ1TLkGMdE8m5+S98DgnhiCiSAngMa1pStR3vdzmFCYXkFxYT5tQ
cyLimPsD804GvhOK9tfjuMvy/ob/YjEDf+yBoXU18QjYEUmO8BMsZU3GG0JXrIfJ
dhwobmnH9TZQL96lbW3R9E2f0Ijko3iP3Cg0SGxZTiIHfVe5kv2sr1wDaB4mnJWR
XEPbohuwqgt23u2ZtX4MtVb67j3ABZJTygZR3C9qbLkLPWvC0lToa9YIPAqr/ymE
YkFJWZZf3wkhSK06S1FxpuvXqbBYjN/rpIoWDsvnflyMNFCcxgNQWjKAcrbgFxBd
X32K0ME9QxGK0eGGCHx45ZUqbIs9X+bFsnwpG3D+i5lR95YmU//2Kcty3Rd3xs7i
21D8NoITeEODmR5Chhov7SMbNu0vbYETaAm0dR0pe+JPjyzEOWSOcsfPlFRO44ug
xMjUhUw0PrHqltqZWTtBDsedPO1Vfywr78keAdCJveKqcR8nMYMYg9TxZBX5g3Fj
T+H15g4FCrwXjFmpHH/L8Llh0bACuAhRoFCoDXOq0Rd/D1JWPFY=
=Mysv
-----END PGP SIGNATURE-----

--Qn1BfWb+BVlli2Qo--
