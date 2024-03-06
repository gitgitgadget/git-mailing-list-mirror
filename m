Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DD5763FC
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724711; cv=none; b=Ubv3Vf3jAYgK8uI+C1wAYWQMVnYPgIF6LF2XBqDjZL4bXwyGtuq631oplkWArlr54elE9jMOr2gkUFT0MzEUC5kR4FvkWf83yND0/YJez9lel1ukcHWXcEAzmskuAWIpJvNBs82CpNzslbF6Zbgj1BFoQ2DQUgASJe49cMpHWSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724711; c=relaxed/simple;
	bh=WXThz9gaAYjRePvHBXPpZJlPe7/LpRzeBnRjEZkm8RQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOrfWhGN69ciwhaoN866MB/AehsBMbW2L76hRy26qvfzvl8qFVh//K+bMBW1r2Isg8nVgGjwAuSV7TWlcfY5h4ioOgbSNYwrx3OvZ7Ho8zbLxVX9mOg2CTFrwP1VxhbTrQ93ieYxKErKN1PhDoQ901Kvl/1JYMjQ3kjla9Yc6K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LTjlqjMT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iaW5kaG8; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LTjlqjMT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iaW5kaG8"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DB07111400D9
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 06:31:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 06 Mar 2024 06:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709724708; x=1709811108; bh=tXtGp0beN8
	zvPqLmF7sjQupDSF79Lvqfk2DL9pRoED4=; b=LTjlqjMTX0E0HGdq4de9o+RRzL
	3Bl7ZENw6xXL4RzHo7re3O6S5lT9u0CSMfHI/nyHXsV245b/SVixdkrOXt1FWRSw
	/giZ+MHtQqwbfOLq0uDOhx3oOjq5k9+OZjA/mjKZjWUCnQQZUE4TNA1KaMYoHPjZ
	yOcWGWXVJNlPAEtuOceqlGZgazaMAUQFhBxi5Tm8jc6uekg+vHC+6uA0QQ/6kMhP
	IqBIWUqTNHrLT3QW6v+kttObS6RFWBJnbZc5YVb4m5LQFMetkMWfsFfkU7zknS2K
	8NxRPoUBcAsUPGVXd1ZzjZobbfBQ84JUac0a+TsKWF2NasalrST6q+A2+CNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709724708; x=1709811108; bh=tXtGp0beN8zvPqLmF7sjQupDSF79
	Lvqfk2DL9pRoED4=; b=iaW5kaG8nrtCuhHtHghcK+Tlj32MfttJFZK7CLqERRn9
	yHs5v4ChwC82eMWkdWrUczTjNIqkvbmrb8GUOukHL0j1MhpuP0XE92VJjE9m94QJ
	8LwoeHOK1N/Z7o0aQz9g+XHXFMgX6UAFksLJXcwoANII2AUDXm+UghylcpE1gJKJ
	Kq9lC4OeD6WLsR6eVXqk2jLw6F/qteIdlQ4/AFmGAzPWb2XVFNGr5y7QyDs7UlB6
	5fL2Uvc6xSHvpC05Beyu1tQ0V6oTd9KefSLKQcZuoCCfJZZyy7cwMbamIWK658Uy
	LrIl1oAGWPgL+mbmHimCACzGtu90zFmfuFR1i1fSmw==
X-ME-Sender: <xms:JFToZeE4m8yqb42s15z_v57drb4cFuaocnjfy2S7ei2JrTPJSxtETA>
    <xme:JFToZfV5k2gcQjiIPZ9g-WgtXDLujYT8O-arz_sD2jj9apxCVqdgVYp308q9hd7iw
    HCCHSMNwNGAMkESwA>
X-ME-Received: <xmr:JFToZYJjmeH__F6hWabr3d-l_o8RSZE3G_afim1V0WPG8Krpe3Uarz0W7_ZWM1w_Kfx4t0r0EurvmRJRgV3O6QLVzOikX8w0gjbw2In8qp6X3p-L5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:JFToZYGWcZr-26zVlddGMvqi8auesTqThaLmuCsDYEJdtUBFMeaXWg>
    <xmx:JFToZUW_xKgEohsszp1Vn4VolDL56EEQDb_nM7mndJXQK671AmLYsA>
    <xmx:JFToZbMKIEpqhT4L-HZsxMNUK8CrYFUqSfOL5KFR3gpZdMo93VoUnQ>
    <xmx:JFToZfeQGnAV8-f82JXUAZNyN2ngqaY_KtaNRf8GBHSzsbjbMydSyg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Mar 2024 06:31:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7269e439 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Mar 2024 11:27:19 +0000 (UTC)
Date: Wed, 6 Mar 2024 12:31:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/8] builtin/config: move modes into separate functions
Message-ID: <b258f31b7d9d7bb104175b7dedc3e13506cea9e9.1709724089.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Vb3p166XncIH2rZa"
Content-Disposition: inline
In-Reply-To: <cover.1709724089.git.ps@pks.im>


--Vb3p166XncIH2rZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-config(1) command has several different modes which cause it to
do different things. The logic for each of these modes is hosted in a
giant switch in `cmd_config()` itself. For one, this is hard to read.
But second, we're about to introduce proper subcommands to git-config(1)
that will require separate functions for each of the modes.

Refactor the code and move each mode into its own function to prepare
for this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 410 +++++++++++++++++++++++++++++------------------
 1 file changed, 255 insertions(+), 155 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8a2d1a5de7..a6ab9b8204 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -44,6 +44,7 @@ static struct config_options config_options;
 static int show_origin;
 static int show_scope;
 static int fixed_value;
+static int config_flags;
=20
 #define ACTION_GET (1<<0)
 #define ACTION_GET_ALL (1<<1)
@@ -622,6 +623,225 @@ static char *default_user_config(void)
 	return strbuf_detach(&buf, NULL);
 }
=20
+static int cmd_config_list(int argc, const char **argv, const char *prefix)
+{
+	check_argc(argc, 0, 0);
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
+static int cmd_config_edit(int argc, const char **argv, const char *prefix)
+{
+	char *config_file;
+
+	check_argc(argc, 0, 0);
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
+static int cmd_config_set(int argc, const char **argv, const char *prefix)
+{
+	struct key_value_info default_kvi =3D KVI_INIT;
+	char *value =3D NULL;
+	int ret;
+
+	check_write();
+	check_argc(argc, 2, 2);
+	value =3D normalize_value(argv[0], argv[1], &default_kvi);
+	ret =3D git_config_set_in_file_gently(given_config_source.file, argv[0], =
value);
+	if (ret =3D=3D CONFIG_NOTHING_SET)
+		error(_("cannot overwrite multiple values with a single value\n"
+		"       Use a regexp, --add or --replace-all to change %s."), argv[0]);
+
+	free(value);
+	return ret;
+}
+
+static int cmd_config_set_all(int argc, const char **argv, const char *pre=
fix)
+{
+	struct key_value_info default_kvi =3D KVI_INIT;
+	char *value =3D NULL;
+	int ret;
+
+	check_write();
+	check_argc(argc, 2, 3);
+	value =3D normalize_value(argv[0], argv[1], &default_kvi);
+	ret =3D git_config_set_multivar_in_file_gently(given_config_source.file,
+						     argv[0], value, argv[2],
+						     config_flags);
+
+	free(value);
+	return ret;
+}
+
+static int cmd_config_add(int argc, const char **argv, const char *prefix)
+{
+	struct key_value_info default_kvi =3D KVI_INIT;
+	char *value =3D NULL;
+	int ret;
+
+	check_write();
+	check_argc(argc, 2, 2);
+	value =3D normalize_value(argv[0], argv[1], &default_kvi);
+	ret =3D git_config_set_multivar_in_file_gently(given_config_source.file,
+						     argv[0], value,
+						     CONFIG_REGEX_NONE,
+						     config_flags);
+
+	free(value);
+	return ret;
+}
+
+static int cmd_config_replace_all(int argc, const char **argv, const char =
*prefix)
+{
+	struct key_value_info default_kvi =3D KVI_INIT;
+	char *value =3D NULL;
+	int ret;
+
+	check_write();
+	check_argc(argc, 2, 3);
+	value =3D normalize_value(argv[0], argv[1], &default_kvi);
+	ret =3D git_config_set_multivar_in_file_gently(given_config_source.file,
+						     argv[0], value, argv[2],
+						     config_flags | CONFIG_FLAGS_MULTI_REPLACE);
+
+	free(value);
+	return ret;
+}
+
+static int cmd_config_get(int argc, const char **argv, const char *prefix)
+{
+	check_argc(argc, 1, 2);
+	return get_value(argv[0], argv[1], config_flags);
+}
+
+static int cmd_config_get_all(int argc, const char **argv, const char *pre=
fix)
+{
+	do_all =3D 1;
+	check_argc(argc, 1, 2);
+	return get_value(argv[0], argv[1], config_flags);
+}
+
+static int cmd_config_get_regexp(int argc, const char **argv, const char *=
prefix)
+{
+	show_keys =3D 1;
+	use_key_regexp =3D 1;
+	do_all =3D 1;
+	check_argc(argc, 1, 2);
+	return get_value(argv[0], argv[1], config_flags);
+}
+
+static int cmd_config_get_urlmatch(int argc, const char **argv, const char=
 *prefix)
+{
+	check_argc(argc, 2, 2);
+	return get_urlmatch(argv[0], argv[1]);
+}
+
+static int cmd_config_unset(int argc, const char **argv, const char *prefi=
x)
+{
+	check_write();
+	check_argc(argc, 1, 2);
+	if (argc =3D=3D 2)
+		return git_config_set_multivar_in_file_gently(given_config_source.file,
+							      argv[0], NULL, argv[1],
+							      config_flags);
+	else
+		return git_config_set_in_file_gently(given_config_source.file,
+						     argv[0], NULL);
+}
+
+static int cmd_config_unset_all(int argc, const char **argv, const char *p=
refix)
+{
+	check_write();
+	check_argc(argc, 1, 2);
+	return git_config_set_multivar_in_file_gently(given_config_source.file,
+						      argv[0], NULL, argv[1],
+						      config_flags | CONFIG_FLAGS_MULTI_REPLACE);
+}
+
+static int cmd_config_rename_section(int argc, const char **argv, const ch=
ar *prefix)
+{
+	int ret;
+
+	check_write();
+	check_argc(argc, 2, 2);
+	ret =3D git_config_rename_section_in_file(given_config_source.file,
+						argv[0], argv[1]);
+	if (ret < 0)
+		return ret;
+	else if (!ret)
+		die(_("no such section: %s"), argv[0]);
+	else
+		ret =3D 0;
+
+	return ret;
+}
+
+static int cmd_config_remove_section(int argc, const char **argv, const ch=
ar *prefix)
+{
+	int ret;
+
+	check_write();
+	check_argc(argc, 1, 1);
+	ret =3D git_config_rename_section_in_file(given_config_source.file,
+						argv[0], NULL);
+	if (ret < 0)
+		return ret;
+	else if (!ret)
+		die(_("no such section: %s"), argv[0]);
+	else
+		ret =3D 0;
+
+	return ret;
+}
+
+static int cmd_config_get_color(int argc, const char **argv, const char *p=
refix)
+{
+	check_argc(argc, 1, 2);
+	get_color(argv[0], argv[1]);
+	return 0;
+}
+
+static int cmd_config_get_colorbool(int argc, const char **argv, const cha=
r *prefix)
+{
+	check_argc(argc, 1, 2);
+	if (argc =3D=3D 2)
+		color_stdout_is_tty =3D git_config_bool("command line", argv[1]);
+	return get_colorbool(argv[0], argc =3D=3D 2);
+}
+
 static struct option builtin_config_options[] =3D {
 	OPT_GROUP(N_("Config file location")),
 	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
@@ -671,12 +891,6 @@ static NORETURN void usage_builtin_config(void)
=20
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
-	int nongit =3D !startup_info->have_repository;
-	char *value =3D NULL;
-	int flags =3D 0;
-	int ret =3D 0;
-	struct key_value_info default_kvi =3D KVI_INIT;
-
 	given_config_source.file =3D xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
=20
 	argc =3D parse_options(argc, argv, prefix, builtin_config_options,
@@ -690,7 +904,7 @@ int cmd_config(int argc, const char **argv, const char =
*prefix)
 		usage_builtin_config();
 	}
=20
-	if (nongit) {
+	if (!startup_info->have_repository) {
 		if (use_local_config)
 			die(_("--local can only be used inside a git repository"));
 		if (given_config_source.blob)
@@ -751,7 +965,7 @@ int cmd_config(int argc, const char **argv, const char =
*prefix)
 		config_options.respect_includes =3D !given_config_source.file;
 	else
 		config_options.respect_includes =3D respect_includes_opt;
-	if (!nongit) {
+	if (startup_info->have_repository) {
 		config_options.commondir =3D get_git_common_dir();
 		config_options.git_dir =3D get_git_dir();
 	}
@@ -826,159 +1040,45 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 			usage_builtin_config();
 		}
=20
-		flags |=3D CONFIG_FLAGS_FIXED_VALUE;
+		config_flags |=3D CONFIG_FLAGS_FIXED_VALUE;
 	}
=20
 	if (actions & PAGING_ACTIONS)
 		setup_auto_pager("config", 1);
=20
 	if (actions =3D=3D ACTION_LIST) {
-		check_argc(argc, 0, 0);
-		if (config_with_options(show_all_config, NULL,
-					&given_config_source, the_repository,
-					&config_options) < 0) {
-			if (given_config_source.file)
-				die_errno(_("unable to read config file '%s'"),
-					  given_config_source.file);
-			else
-				die(_("error processing config file(s)"));
-		}
+		return cmd_config_list(argc, argv, prefix);
+	} else if (actions =3D=3D ACTION_EDIT) {
+		return cmd_config_edit(argc, argv, prefix);
+	} else if (actions =3D=3D ACTION_SET) {
+		return cmd_config_set(argc, argv, prefix);
+	} else if (actions =3D=3D ACTION_SET_ALL) {
+		return cmd_config_set_all(argc, argv, prefix);
+	} else if (actions =3D=3D ACTION_ADD) {
+		return cmd_config_add(argc, argv, prefix);
+	} else if (actions =3D=3D ACTION_REPLACE_ALL) {
+		return cmd_config_replace_all(argc, argv, prefix);
+	} else if (actions =3D=3D ACTION_GET) {
+		return cmd_config_get(argc, argv, prefix);
+	} else if (actions =3D=3D ACTION_GET_ALL) {
+		return cmd_config_get_all(argc, argv, prefix);
+	} else if (actions =3D=3D ACTION_GET_REGEXP) {
+		return cmd_config_get_regexp(argc, argv, prefix);
+	} else if (actions =3D=3D ACTION_GET_URLMATCH) {
+		return cmd_config_get_urlmatch(argc, argv, prefix);
+	} else if (actions =3D=3D ACTION_UNSET) {
+		return cmd_config_unset(argc, argv, prefix);
+	} else if (actions =3D=3D ACTION_UNSET_ALL) {
+		return cmd_config_unset_all(argc, argv, prefix);
+	} else if (actions =3D=3D ACTION_RENAME_SECTION) {
+		return cmd_config_rename_section(argc, argv, prefix);
+	} else if (actions =3D=3D ACTION_REMOVE_SECTION) {
+		return cmd_config_remove_section(argc, argv, prefix);
+	} else if (actions =3D=3D ACTION_GET_COLOR) {
+		return cmd_config_get_color(argc, argv, prefix);
+	} else if (actions =3D=3D ACTION_GET_COLORBOOL) {
+		return cmd_config_get_colorbool(argc, argv, prefix);
 	}
-	else if (actions =3D=3D ACTION_EDIT) {
-		char *config_file;
=20
-		check_argc(argc, 0, 0);
-		if (!given_config_source.file && nongit)
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
-	}
-	else if (actions =3D=3D ACTION_SET) {
-		check_write();
-		check_argc(argc, 2, 2);
-		value =3D normalize_value(argv[0], argv[1], &default_kvi);
-		ret =3D git_config_set_in_file_gently(given_config_source.file, argv[0],=
 value);
-		if (ret =3D=3D CONFIG_NOTHING_SET)
-			error(_("cannot overwrite multiple values with a single value\n"
-			"       Use a regexp, --add or --replace-all to change %s."), argv[0]);
-	}
-	else if (actions =3D=3D ACTION_SET_ALL) {
-		check_write();
-		check_argc(argc, 2, 3);
-		value =3D normalize_value(argv[0], argv[1], &default_kvi);
-		ret =3D git_config_set_multivar_in_file_gently(given_config_source.file,
-							     argv[0], value, argv[2],
-							     flags);
-	}
-	else if (actions =3D=3D ACTION_ADD) {
-		check_write();
-		check_argc(argc, 2, 2);
-		value =3D normalize_value(argv[0], argv[1], &default_kvi);
-		ret =3D git_config_set_multivar_in_file_gently(given_config_source.file,
-							     argv[0], value,
-							     CONFIG_REGEX_NONE,
-							     flags);
-	}
-	else if (actions =3D=3D ACTION_REPLACE_ALL) {
-		check_write();
-		check_argc(argc, 2, 3);
-		value =3D normalize_value(argv[0], argv[1], &default_kvi);
-		ret =3D git_config_set_multivar_in_file_gently(given_config_source.file,
-							     argv[0], value, argv[2],
-							     flags | CONFIG_FLAGS_MULTI_REPLACE);
-	}
-	else if (actions =3D=3D ACTION_GET) {
-		check_argc(argc, 1, 2);
-		return get_value(argv[0], argv[1], flags);
-	}
-	else if (actions =3D=3D ACTION_GET_ALL) {
-		do_all =3D 1;
-		check_argc(argc, 1, 2);
-		return get_value(argv[0], argv[1], flags);
-	}
-	else if (actions =3D=3D ACTION_GET_REGEXP) {
-		show_keys =3D 1;
-		use_key_regexp =3D 1;
-		do_all =3D 1;
-		check_argc(argc, 1, 2);
-		return get_value(argv[0], argv[1], flags);
-	}
-	else if (actions =3D=3D ACTION_GET_URLMATCH) {
-		check_argc(argc, 2, 2);
-		return get_urlmatch(argv[0], argv[1]);
-	}
-	else if (actions =3D=3D ACTION_UNSET) {
-		check_write();
-		check_argc(argc, 1, 2);
-		if (argc =3D=3D 2)
-			return git_config_set_multivar_in_file_gently(given_config_source.file,
-								      argv[0], NULL, argv[1],
-								      flags);
-		else
-			return git_config_set_in_file_gently(given_config_source.file,
-							     argv[0], NULL);
-	}
-	else if (actions =3D=3D ACTION_UNSET_ALL) {
-		check_write();
-		check_argc(argc, 1, 2);
-		return git_config_set_multivar_in_file_gently(given_config_source.file,
-							      argv[0], NULL, argv[1],
-							      flags | CONFIG_FLAGS_MULTI_REPLACE);
-	}
-	else if (actions =3D=3D ACTION_RENAME_SECTION) {
-		check_write();
-		check_argc(argc, 2, 2);
-		ret =3D git_config_rename_section_in_file(given_config_source.file,
-							argv[0], argv[1]);
-		if (ret < 0)
-			return ret;
-		else if (!ret)
-			die(_("no such section: %s"), argv[0]);
-		else
-			ret =3D 0;
-	}
-	else if (actions =3D=3D ACTION_REMOVE_SECTION) {
-		check_write();
-		check_argc(argc, 1, 1);
-		ret =3D git_config_rename_section_in_file(given_config_source.file,
-							argv[0], NULL);
-		if (ret < 0)
-			return ret;
-		else if (!ret)
-			die(_("no such section: %s"), argv[0]);
-		else
-			ret =3D 0;
-	}
-	else if (actions =3D=3D ACTION_GET_COLOR) {
-		check_argc(argc, 1, 2);
-		get_color(argv[0], argv[1]);
-	}
-	else if (actions =3D=3D ACTION_GET_COLORBOOL) {
-		check_argc(argc, 1, 2);
-		if (argc =3D=3D 2)
-			color_stdout_is_tty =3D git_config_bool("command line", argv[1]);
-		return get_colorbool(argv[0], argc =3D=3D 2);
-	}
-
-	free(value);
-	return ret;
+	BUG("invalid action");
 }
--=20
2.44.0


--Vb3p166XncIH2rZa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXoVCEACgkQVbJhu7ck
PpRihA//ZzA4IiT4TGhT7zY8yDx7DuDeRfoEFkh1YaZ9FCJ3VgLKDFsSd1PBw0wL
bYY0ZNfrh0gcvHqItBgymJZePzxP8KL99fprE8ZZ1NEBqZ+J+A/23qXuw3NgwtMh
9mhCF9L206XiHvC6yQbsx9e1nYEr7kaz5o4X7SM9bjGcqpAZMbBQGBhSr65wEjeA
EgVbZRGMcSpwntoYZKcxZ5NCYEuzuPfloUPEnuJW7PHRMN7M9ljx5FW398yV8b6z
HHDIpE4JBfHmFAzOT7/I3v17H4GFR8lFoUQDOhU6HlmIs60ruj7r+K3Z66luAV76
ZkqL6dX8wliS58xWb8ghPdi2Qk27rZki98p2BWVCFB/HfQhtVbhcvqJeMydZSeJR
xPLkwRCN1yP7KPfk+ZekAfXbxS9ubHxTCQXP0h610Fe+qO8jAU83ZH70XdMfLLnb
QolDSToW6pnRYA3rSy+v5XOpaQnHhNlajWhzTSOwUiQ+XWdbeupEBzMXsNcjUXVN
Ado606osxvokSlvh2RnTFOWpqg6ohzgrIt7V0FYdNdxTEqn+g/aCJGm9QLGNZibQ
+oo717vjPkoIpZq7Cx3m49Urg8aDvL+w+1hg/inW297Hbz43cJqd9qmVEahAh+6s
CcGCaj6N+e1Lrj8iwoVYMBcDivWNWJfrQu5nmyCFaM4pkiQ7Vzg=
=AIon
-----END PGP SIGNATURE-----

--Vb3p166XncIH2rZa--
