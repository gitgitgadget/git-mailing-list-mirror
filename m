Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C938B58AA8
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199306; cv=none; b=mc/hKCnhc02rZaGIQ+goxu/4qxnNTAXkW3gVrZSIgG8iZdNlAGd4PMDfWQnedLGCwKBNSOSzaNwXqtEOLS3XAw3COcP9uIp09cgw/4N0l54pdoI4zI6AtMmJ+dqGeuHN+1HBgmW7O3YUs80TZnyndZCAvPGcmp10JdTjlBW5uvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199306; c=relaxed/simple;
	bh=kW7NXvGqb2H/ZXqP9BMvwOTdgqagHKaGsytYUKbiysY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjbOQ3A3OiTNenJzw5UDyjT8IjRduuo5bXcIzEjf3IAA1jU9fO59msmN+DKhZEvlEb+QAOB6R75ifPi9doiaoV35CEQZIY6AnyksOGWo1SBrcj2n/zMYSZvKaFy2C2QyGBAB71CWqpn4us8TV/7jy3NRAZ6PyJ3JFinQ+u2lb8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QfW3P/Ao; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PmTSWjCx; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QfW3P/Ao";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PmTSWjCx"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 0244C5C0067;
	Mon, 11 Mar 2024 19:21:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 11 Mar 2024 19:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710199303; x=1710285703; bh=eYDhQ4r89U
	fnUe9ckKzQJGpkArjEY+QEAJPJz+v4/Eo=; b=QfW3P/AoPEC2hnUdHHo0DQNBpm
	m4KycyIhDD778LeC7DgAclIaHjfVlhyhl0sAV7YzhsQW1sgm28ulSg8whaesUC8E
	IEkmhqeSB1N9Ebo/JBaxWVaV+D1my04NNPtW3oaHtJ8qReuUBSd+EeLX77bYUITX
	d/7PW7dLGY/tR1xRnJyrBpWFh1BhCxGF0YrKA+SB+W7+pFq5Z6oLUxAHMTpo+UX4
	WaQYEtcCG72ECnf05cxWmwTVk81mx1/5mNv7xylA8aPHv1NWqki2z9IOB6nvL7RR
	o6yHPWcDMK22LaOM4fhCJcZgNWpjPwKslnwUPBDPBM7EejS5Q6febv8ruzLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710199303; x=1710285703; bh=eYDhQ4r89UfnUe9ckKzQJGpkArjE
	Y+QEAJPJz+v4/Eo=; b=PmTSWjCx6ZJibzNxacfYMazMoBDV5CBYmRXHY67p0IpE
	gvETXolTIVOJDZnJlHsB2IvJvdmyX2BEo/WfcYgIe/qW8W44K/qdbMn+r+nJ7Tvt
	6I4uQ+t3GXafi9SC8r/7cA1V+3jPZQ90M7/yqZeVXh4m6DzvcmlwE3IV+238rlm0
	C8xftVIiK+TWzXTeuorrgjAvIx1m0t64yOX9DcQ5LdQCeWyzVzFINIzjNFPHL6Px
	/F/HPdtR5NSSn2xaKFgOTPZEhuPJm1k86dM6KrYojTVd9HZYD3tN6I5x4dTZ99Hr
	iS6fLEPw4F4SFeK3tNGqEcSLKfiXPBohdmcqJK0koQ==
X-ME-Sender: <xms:B5LvZcLiarvlfGOWQoWZGt5LQQaPbvNYfHmo8KTTGONZNh8NDCe-bA>
    <xme:B5LvZcL0CmMuaV8MKpcKOMIjasGLzNE6B6_haFCVunT_BeEGwK5-Fa33Qs8G8henN
    EsSzOHzo41WJ_iACQ>
X-ME-Received: <xmr:B5LvZcvayNnkxNPfgRNfL7h25DJfJuIruYZS17-eEqE5x-6IU6Gw_5jMuj_0qnzumicsCmzBaCo-6pLoW33jO7lC6TMauU8sNou9xLNWYEGvYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:B5LvZZb2HjEN3_C09Um35R6WrKIWK38nAYohGtrszXGLh4eJ3EpkvQ>
    <xmx:B5LvZTaGRV6_nvjTYZLPvE0vy2QnTTSBJhve7pe3cmBU6Yg-T0f2tg>
    <xmx:B5LvZVBF3agxu8jsLwtaOYuu7gbtEVqgx5rNQyRdCTkMGiFVysh9ww>
    <xmx:B5LvZeyDrknCG0VO4jLTCRjXiPCJV3HvuRFC9xq2M6nKc7n5eKR3mA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 19:21:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 864a94b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Mar 2024 23:17:03 +0000 (UTC)
Date: Tue, 12 Mar 2024 00:21:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/13] builtin/config: introduce "edit" subcommand
Message-ID: <12011714e3ee1459fb078850f1c1ebd6d275af0e.1710198711.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1710198711.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cIW5QFtxnfWc70Om"
Content-Disposition: inline
In-Reply-To: <cover.1710198711.git.ps@pks.im>


--cIW5QFtxnfWc70Om
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Introduce a new "edit" subcommand to git-config(1). Please refer to
preceding commits regarding the motivation behind this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-config.txt | 15 ++++---
 builtin/config.c             | 81 ++++++++++++++++++++++++------------
 t/t1300-config.sh            |  6 +--
 3 files changed, 67 insertions(+), 35 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 615ed44350..9fb94e2fad 100644
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
@@ -98,6 +98,10 @@ rename-section::
 remove-section::
 	Remove the given section from the configuration file.
=20
+edit::
+	Opens an editor to modify the specified config file; either
+	`--system`, `--global`, or repository (default).
+
 [[OPTIONS]]
 OPTIONS
 -------
@@ -262,11 +266,6 @@ Valid `<type>`'s include:
 	When the color setting for `name` is undefined, the command uses
 	`color.ui` as fallback.
=20
--e::
---edit::
-	Opens an editor to modify the specified config file; either
-	`--system`, `--global`, or repository (default).
-
 --[no-]includes::
 	Respect `include.*` directives in config files when looking up
 	values. Defaults to `off` when a specific file is given (e.g.,
@@ -323,6 +322,10 @@ recommended to migrate to the new syntax.
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
index d3aa5bc298..b1008c487d 100644
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
index eafecf84a4..f820f87619 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -557,7 +557,7 @@ test_expect_success 'setting a value in stdin is an err=
or' '
 '
=20
 test_expect_success 'editing stdin is an error' '
-	test_must_fail git config --file - --edit
+	test_must_fail git config ${mode_prefix}edit --file -
 '
=20
 test_expect_success 'refer config from subdirectory' '
@@ -1643,7 +1643,7 @@ test_expect_success 'command line overrides environme=
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
@@ -1652,7 +1652,7 @@ test_expect_success 'git config --edit respects core.=
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
2.44.0


--cIW5QFtxnfWc70Om
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXvkf8ACgkQVbJhu7ck
PpTaCBAAgkXYQFImm6XNMrMBXhQWqQoVWjQ3RNKzolcf6jlS48bvWYxFDaCml49X
NWuuUgAR/AZyFcLz0ChTAoXwnMSavJerYp14r+/YJVDvWWrn8/Jq/KI5yEkYzMdQ
J2ZsEEWhwTXu0ZvL0QJHavVTkDMWrJth8nmb0jHxuldQPel48l6w95UTBf3fu/IE
EVktRSAd2+4W7VwaXE/QJ4CYkzMaGUsx2+OiShIc5PpJ53n9hTgjH1MJN+RKasjw
M5rG/6F3nhFA/ZLSmhX2DCPngUolBhaU8c9tdMqIjICIdOt+Y2+CTu303PqQpcLI
4VMslUTDLWvdj9swi2ppIsCnI59fB7EBd0MLyPP71hVJ5VqQEnufFKu1fQHvNCm4
SrJF7nV08QtHMXrzFKoTjcsfHsFKh2xKHgPh6QI1SNOmhYsP6Mk0ANEeSHXXoUpV
jECIzzbzDwzTUgctwEn4nj3tDfwfsqpyAARFvBtzWgcQ75MYVGvrZGqXmLvyDflW
ghu9IMvEs4FmnqAdKxPYICS15rekF1xxgfkw7AVUXPp4zFOrUioFyHwNJwlbwdkj
HLc09CrnWXJYZiPxCO2SLnnAU55dSg+gmk7SKFnssxlRDnS+UI0dK+gMemNPNddM
mQBtdn++/ANiEtWOOZp2yUPtrf4Zxvfc70jH2OviCHKC2lDf8lM=
=TqVH
-----END PGP SIGNATURE-----

--cIW5QFtxnfWc70Om--
