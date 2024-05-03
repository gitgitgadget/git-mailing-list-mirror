Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D5515098B
	for <git@vger.kernel.org>; Fri,  3 May 2024 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730270; cv=none; b=jRvz7G1I0LwoBqvfG5xcCYdpkWZVZvVOkZ1Q72c+jF3InlXU/O3RpoLkRHe3IQiCaaDlOUzLCoU8kGum+BvZ2aAHsCIOzulz94tagTEN4oMzx9HDvn0+A1219PWTlAc8+19DWZNyzW7wCA+Fg5hbcQdYIZxCUZhFGTLO/bxAl0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730270; c=relaxed/simple;
	bh=P62RppfaJacepu/fChoVT0NuN7s3asrdz9Qhp1JY19E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tifo//R7O/5pOKTqdyZCMcu7DsOWzlm/yQEhtoSESk4v9BElFoEML/wHeDVB5wNqtEHVDZnwcaPFIBHJvhT6UEP2nwnAbDm8JECHF2NtLZTKj6WgJLCrEDlN0TJy0Y8DX0ic7xzTh3iEao949/6+dVOf59nIXj/LLaC/DbX4sIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GM14FcgT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QQZ1Q0nl; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GM14FcgT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QQZ1Q0nl"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id D732C18000BE;
	Fri,  3 May 2024 05:57:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 03 May 2024 05:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714730267; x=1714816667; bh=3pNj2pI/SQ
	K1yUxV1t7Ay5SEkdKQAy1UFQyxyJuc/74=; b=GM14FcgTjMVqePuGad/bIBDIN6
	XvcaYJor0zcZjswN7thz2dxoa61fq+GIj749KznF2Y8n9UeZdjOQTNWZehWVQqdS
	58LHRAzXh3rGZVhKd6nl9wZphupMlN8kJSTXC8lgeGRxLqV13SN19kZqOBNHU8LZ
	Tg3k2eYgtaCHknIuker5kgaBH9dtpiP5VVRJQQ+UqKfeWvZlkjgPlm+8FrejKzis
	48u3GS3KnWaGOjPQPlNLrBDLm/WOzkIctcnI9eiUpraQLBej2+DjQQ+x8xgHYO4a
	wYw7B43CJqTZHsa2YUzwV8ON52j4H7J8wo8/RsUFENMZpmXFHRttwWNJg7kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714730267; x=1714816667; bh=3pNj2pI/SQK1yUxV1t7Ay5SEkdKQ
	Ay1UFQyxyJuc/74=; b=QQZ1Q0nl9uSB+YZRqNUHinkfjgedVUrXxZE84c6AT9FU
	yG5SJXhIrNG10Gz9pGna8jAg/vlw5xE+af5PuBdV54edfZlP5b1bVrZqPIld8Srm
	wQnRsLuycGDNO1vZ/91/bevvPfSr1gW318tbwQkL09xMoWmrr3RE6vPhH0mxNzZM
	JXif79gN6cvaTTb6cWHBJsoEpsvCLoGjqSdoI4tJn1vjynjpOqK9SstqmAJ21rEO
	5eRIlsibgqIExfocIf1DW8ZgJ/F/em6AWUTINoKz3fYJPgbXxmLOSe2cbUtEszTC
	YuTNlZS7ldYvs1Opq00G5QzGJJamR3CsqfaQKJKWyA==
X-ME-Sender: <xms:G7U0ZgVNPd9IO1saM58G3FMPom-u4jvMstAKCmMb0eXRsyDtI0fWGQ>
    <xme:G7U0Zkll3r4jRfwsjHXrg7_TMTK7SSr2t_1woIlDPgi2Af6ursck1SSZnNbi7-7Lp
    txBDT_e_VDvRkvu9w>
X-ME-Received: <xmr:G7U0ZkYOXbh5kdjVePlKQdln1Ao_y3nBD8JeM3Kgmfi4_vaNW0mPATRam4o7_Io2jO64m2nOECxwBkqwciWrwdV8tUFdUVCx3eev8hTw9L6jyGK3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:G7U0ZvVj3TsUWNfthan-TudTX0tpBhtpuYwPrXf6jKsQ2UE7C889Gg>
    <xmx:G7U0ZqlxMT3v_p9_q3tCB2-oYDuyxUZupPVYigMT4eP-k3rPSTEEjg>
    <xmx:G7U0ZkfX3VD-6MOvnKrhfUHw5PqgBshiSfc_GXmlWCl3H6YxmKD05A>
    <xmx:G7U0ZsEE8DelSXxAIvX6pna4lM70KZAhKNs-wIAq_qI97hqrDNEuvw>
    <xmx:G7U0Zob925pCG3Ml8c8DUmSNmn6_QL93pV1h5cBq7xUhX96JvUejKc-R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 05:57:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6a9d3f6c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 09:57:18 +0000 (UTC)
Date: Fri, 3 May 2024 11:57:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 13/14] builtin/config: introduce "edit" subcommand
Message-ID: <4c2d817eff2ceb29725ef101269216dcd632f489.1714730170.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714730169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8cCdDOxpPF8r4gRL"
Content-Disposition: inline
In-Reply-To: <cover.1714730169.git.ps@pks.im>


--8cCdDOxpPF8r4gRL
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


--8cCdDOxpPF8r4gRL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0tRcACgkQVbJhu7ck
PpRoXw/8DkiEl8kL8gEtIx4FCtY8Y+2Ya374uvKIymBtfuxdxXZY1uqLn8vEu7B2
CJgtZIippgk6tR36DE8Buuj2ngp9rhp9yRvqoI23vAlPvpvhJWpVWWY/41KK87Hr
4qyC5AzJaugg9xUa5rWSYuB4ZI+OYna0Joj7FVMKbEszqzzWwn+j759JBxpG5mu7
95WlvEkY+e27X+JYvIfkqwMw0TlBbziXrWgqOcWy16OAMYPbm6a0lI/zXBZu44WR
qo4kFf/sM/ZqYeUW5cP4rCPQ7aClfWrGTXmRyPV3nryFR2u7cGIlTb88g66B6ulE
iZ206QpQtA8vj4ZbZRhFUKC+1Qn5KgRK7Bw/rS6hhMJbMGm3ELYIQRg671O8aY93
tPc9TW4ljMoCYg1ZF7TbSRgwgc1BXyxbWAxgzDWWmJLMt/JfySgRHKCP4pyKFE9I
9fUzklsmVTdacm6OphcqN6/fNjawG+LngWFBE8+RkxVQFP0vhR7zJTaFyRf6bk5/
n5urWbTP7pxu+lOYvJhzzUVfIBHRyS7rPC/Bf/db3FjaqxXi2fl4XDW8ZB0vttQl
diJcBa96ZPc/ELM05TSeyAEJuB4vwJYXfrah5VJL3xdCen2z4cER3uGacW0w5i5r
KCqmA2MYp2foVC2jNIWmGDVPY6oA6PiVTTfS/c7x1IqrepnivfE=
=x/H6
-----END PGP SIGNATURE-----

--8cCdDOxpPF8r4gRL--
