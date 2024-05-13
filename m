Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BA514A097
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595770; cv=none; b=UroJIORPHst1C351OJncSFn/TCZ9sVEoLcGVWbricXy/mpCmZsWk460o2Y7OcANcFv4MUuM7sPAPMmGiJ/2Tce40Zh7Zx1Sra8Rx+b58Lo+47wIE5eeWVLyr9NiCwT+kpdXykBP8alYPdIimJ90y7QMkjX33IvEQtMeZae9uDXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595770; c=relaxed/simple;
	bh=GmiogVNobWWnq7D3tv122e6B3pvV9b0Yq7jaFxMEzR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXKUyjXDq8tg2Wc+8XRlC13uyDOYmsc3MGy5Lua6PPFFdV83gCXZ1naaJYkMBS4jfWjSzlvOYJWWDWsQZ5YG0HzTtVyG9cS3sX3qr9+1CPPqN3u+i9vIw9Xq093U9ELRwuzrf9gDHosbsDGw89cR8H9ECuw5/CKqx0j99QhN7Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZC4GNLp2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L+Lp25IU; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZC4GNLp2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L+Lp25IU"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 66EBE1C000F2;
	Mon, 13 May 2024 06:22:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 13 May 2024 06:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595767; x=1715682167; bh=Z+tvmaDW57
	zUI651ik8ZCX+RPXzjQQIdOxp1AtG2tJE=; b=ZC4GNLp2KagdFvWT4q1KPuiNlq
	w5Cyr93pdeAqSz4m+2bw2eMLGWOzCcs8SrYwdae0nP6yPi1u0qbY9CRPu80n+UXc
	KlwCIqqPycWMp7yTH1/HzgKkYDzqgJQTgPKmfuqrhHtqiQZKiDtwXeLplYd2367N
	9ubucXlTQHCj5F7eZqFa/Kjqz/PfugzD0Y/1Bffo97fufdCzrJCbS9JbTl65vdzh
	gwOndNI93Itui8ksVqhne8dE0mjVamcHEue7o1HAQxkjqDPHRQO1KoazYhsN4bW0
	1oUkcKRD3AuAqpZ8M1ndFNEfSIJYRifdXzo7ehxVOA8wtuSI09uUbwAbq6yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595767; x=1715682167; bh=Z+tvmaDW57zUI651ik8ZCX+RPXzj
	QQIdOxp1AtG2tJE=; b=L+Lp25IUKHytoRpHRaAlGIy+Qrm6Is2L7ZkInwG6iX6u
	XKu9Gy9oKrDH19kHKVHic1jsrJGqp4sXW/6+PzsumIey/CgN977DmDUmos1TOl6a
	05qsbv6e/Rr4pNTMGhlKNyzUCjMgxV+r8VPkkGQXPAFLYRtuCnSElr4UraLBGYSU
	/WdbdZ6wMnwF0GTXBnzNpCg8Je15/ccUgppGPTJnplIwTKqtB9/YX8clJ5hqEw8o
	jG5KdcMGmKYRzM1IMpmG6oTVzGjwIEU6woIr23sfUlh7M0andZrGQEM7mhSPGaPO
	6UvS7q2ouZTQaqVGkTN/zgtGuRPFxCdghyHafL5Kaw==
X-ME-Sender: <xms:9ulBZo9L_X5zXaIv8EEKFv0RZdWimMkI735tuh_6Qsm_BRagdzis8Q>
    <xme:9ulBZgvChZUIphsXY8Ibp5YPgkbQzzLLE0uYnfWbGu3BppnNLq6S-Qw9dY0hnXl3f
    1kJ8fUahwRFOMaI_Q>
X-ME-Received: <xmr:9ulBZuDYzTmgkFSlEIWAzv1sSnyWkOKfVT5gQzOfeYfelaTU6oLVJ4pXwEjaKpiKSEg634Zokx7PY-dsf62IFJdVpn2VgGGdZeLqEED5SMR1npA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:9ulBZocD4gDHfZwNMXp2ww-4M-f1BlUjFzy9gJz1IiXpzaqZhdFlbQ>
    <xmx:9ulBZtOOHv5mZhp75Yca8s6OJABFAHX0ZlaWTQis3HGBqt4H8wklXg>
    <xmx:9ulBZin-vszgI6sK2mgj8qlLkOUlazXnRx65cB7nIpekqNYqBc7WeA>
    <xmx:9ulBZvueFBSxTQsgz6zFXB5flFXELhMymwcabSHhj4O-RlKg-DY2QA>
    <xmx:9-lBZirynpk1x_xNqjqyjTb_H-3C0E0ON8w1chZE5qy1CUOQQrA_HA8z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:22:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b08a646e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:22:27 +0000 (UTC)
Date: Mon, 13 May 2024 12:22:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 09/21] builtin/config: move location options into local
 variables
Message-ID: <b5d43b6f852d99021236b187ad016dfe7b5f3d09.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZQaZ/m8HGbEbursa"
Content-Disposition: inline
In-Reply-To: <cover.1715595550.git.ps@pks.im>


--ZQaZ/m8HGbEbursa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The location options are tracked via a set of global variables. Move
them into a self-contained structure so that we can easily parse all
relevant options and hand them over to the various functions that
require them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 311 ++++++++++++++++++++++++++---------------------
 1 file changed, 174 insertions(+), 137 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 155564b832..c309497e23 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -62,6 +62,25 @@ static const char *const builtin_config_edit_usage[] =3D=
 {
 	NULL
 };
=20
+#define CONFIG_LOCATION_OPTIONS(opts) \
+	OPT_GROUP(N_("Config file location")), \
+	OPT_BOOL(0, "global", &opts.use_global_config, N_("use global config file=
")), \
+	OPT_BOOL(0, "system", &opts.use_system_config, N_("use system config file=
")), \
+	OPT_BOOL(0, "local", &opts.use_local_config, N_("use repository config fi=
le")), \
+	OPT_BOOL(0, "worktree", &opts.use_worktree_config, N_("use per-worktree c=
onfig file")), \
+	OPT_STRING('f', "file", &opts.source.file, N_("file"), N_("use given conf=
ig file")), \
+	OPT_STRING(0, "blob", &opts.source.blob, N_("blob-id"), N_("read config f=
rom given blob object"))
+
+struct config_location_options {
+	struct git_config_source source;
+	struct config_options options;
+	int use_global_config;
+	int use_system_config;
+	int use_local_config;
+	int use_worktree_config;
+};
+#define CONFIG_LOCATION_OPTIONS_INIT {0}
+
 static char *key;
 static regex_t *key_regexp;
 static const char *value_pattern;
@@ -75,14 +94,10 @@ static char delim =3D '=3D';
 static char key_delim =3D ' ';
 static char term =3D '\n';
=20
-static int use_global_config, use_system_config, use_local_config;
-static int use_worktree_config;
-static struct git_config_source given_config_source;
 static int type;
 static char *default_value;
 static int end_nul;
 static int respect_includes_opt =3D -1;
-static struct config_options config_options;
 static int show_origin;
 static int show_scope;
 static int fixed_value;
@@ -298,7 +313,8 @@ static int collect_config(const char *key_, const char =
*value_,
 	return format_config(&values->items[values->nr++], key_, value_, kvi);
 }
=20
-static int get_value(const char *key_, const char *regex_, unsigned flags)
+static int get_value(const struct config_location_options *opts,
+		     const char *key_, const char *regex_, unsigned flags)
 {
 	int ret =3D CONFIG_GENERIC_ERROR;
 	struct strbuf_list values =3D {NULL};
@@ -353,8 +369,8 @@ static int get_value(const char *key_, const char *rege=
x_, unsigned flags)
 	}
=20
 	config_with_options(collect_config, &values,
-			    &given_config_source, the_repository,
-			    &config_options);
+			    &opts->source, the_repository,
+			    &opts->options);
=20
 	if (!values.nr && default_value) {
 		struct key_value_info kvi =3D KVI_INIT;
@@ -464,14 +480,15 @@ static int git_get_color_config(const char *var, cons=
t char *value,
 	return 0;
 }
=20
-static void get_color(const char *var, const char *def_color)
+static void get_color(const struct config_location_options *opts,
+		      const char *var, const char *def_color)
 {
 	get_color_slot =3D var;
 	get_color_found =3D 0;
 	parsed_color[0] =3D '\0';
 	config_with_options(git_get_color_config, NULL,
-			    &given_config_source, the_repository,
-			    &config_options);
+			    &opts->source, the_repository,
+			    &opts->options);
=20
 	if (!get_color_found && def_color) {
 		if (color_parse(def_color, parsed_color) < 0)
@@ -497,15 +514,16 @@ static int git_get_colorbool_config(const char *var, =
const char *value,
 	return 0;
 }
=20
-static int get_colorbool(const char *var, int print)
+static int get_colorbool(const struct config_location_options *opts,
+			 const char *var, int print)
 {
 	get_colorbool_slot =3D var;
 	get_colorbool_found =3D -1;
 	get_diff_color_found =3D -1;
 	get_color_ui_found =3D -1;
 	config_with_options(git_get_colorbool_config, NULL,
-			    &given_config_source, the_repository,
-			    &config_options);
+			    &opts->source, the_repository,
+			    &opts->options);
=20
 	if (get_colorbool_found < 0) {
 		if (!strcmp(get_colorbool_slot, "color.diff"))
@@ -527,15 +545,15 @@ static int get_colorbool(const char *var, int print)
 		return get_colorbool_found ? 0 : 1;
 }
=20
-static void check_write(void)
+static void check_write(const struct git_config_source *source)
 {
-	if (!given_config_source.file && !startup_info->have_repository)
+	if (!source->file && !startup_info->have_repository)
 		die(_("not in a git directory"));
=20
-	if (given_config_source.use_stdin)
+	if (source->use_stdin)
 		die(_("writing to stdin is not supported"));
=20
-	if (given_config_source.blob)
+	if (source->blob)
 		die(_("writing config blobs is not supported"));
 }
=20
@@ -572,7 +590,8 @@ static int urlmatch_collect_fn(const char *var, const c=
har *value,
 	return 0;
 }
=20
-static int get_urlmatch(const char *var, const char *url)
+static int get_urlmatch(const struct config_location_options *opts,
+			const char *var, const char *url)
 {
 	int ret;
 	char *section_tail;
@@ -599,8 +618,8 @@ static int get_urlmatch(const char *var, const char *ur=
l)
 	}
=20
 	config_with_options(urlmatch_config_entry, &config,
-			    &given_config_source, the_repository,
-			    &config_options);
+			    &opts->source, the_repository,
+			    &opts->options);
=20
 	ret =3D !values.nr;
=20
@@ -638,34 +657,40 @@ static char *default_user_config(void)
 	return strbuf_detach(&buf, NULL);
 }
=20
-static void handle_config_location(const char *prefix)
+static void location_options_init(struct config_location_options *opts,
+				  const char *prefix)
 {
-	if (use_global_config + use_system_config + use_local_config +
-	    use_worktree_config +
-	    !!given_config_source.file + !!given_config_source.blob > 1) {
+	if (!opts->source.file)
+		opts->source.file =3D xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
+	else
+		opts->source.file =3D xstrdup(opts->source.file);
+
+	if (opts->use_global_config + opts->use_system_config +
+	    opts->use_local_config + opts->use_worktree_config +
+	    !!opts->source.file + !!opts->source.blob > 1) {
 		error(_("only one config file at a time"));
 		exit(129);
 	}
=20
 	if (!startup_info->have_repository) {
-		if (use_local_config)
+		if (opts->use_local_config)
 			die(_("--local can only be used inside a git repository"));
-		if (given_config_source.blob)
+		if (opts->source.blob)
 			die(_("--blob can only be used inside a git repository"));
-		if (use_worktree_config)
+		if (opts->use_worktree_config)
 			die(_("--worktree can only be used inside a git repository"));
 	}
=20
-	if (given_config_source.file &&
-			!strcmp(given_config_source.file, "-")) {
-		given_config_source.file =3D NULL;
-		given_config_source.use_stdin =3D 1;
-		given_config_source.scope =3D CONFIG_SCOPE_COMMAND;
+	if (opts->source.file &&
+			!strcmp(opts->source.file, "-")) {
+		opts->source.file =3D NULL;
+		opts->source.use_stdin =3D 1;
+		opts->source.scope =3D CONFIG_SCOPE_COMMAND;
 	}
=20
-	if (use_global_config) {
-		given_config_source.file =3D git_global_config();
-		if (!given_config_source.file)
+	if (opts->use_global_config) {
+		opts->source.file =3D git_global_config();
+		if (!opts->source.file)
 			/*
 			 * It is unknown if HOME/.gitconfig exists, so
 			 * we do not know if we should write to XDG
@@ -673,17 +698,17 @@ static void handle_config_location(const char *prefix)
 			 * is set and points at a sane location.
 			 */
 			die(_("$HOME not set"));
-		given_config_source.scope =3D CONFIG_SCOPE_GLOBAL;
-	} else if (use_system_config) {
-		given_config_source.file =3D git_system_config();
-		given_config_source.scope =3D CONFIG_SCOPE_SYSTEM;
-	} else if (use_local_config) {
-		given_config_source.file =3D git_pathdup("config");
-		given_config_source.scope =3D CONFIG_SCOPE_LOCAL;
-	} else if (use_worktree_config) {
+		opts->source.scope =3D CONFIG_SCOPE_GLOBAL;
+	} else if (opts->use_system_config) {
+		opts->source.file =3D xstrdup_or_null(git_system_config());
+		opts->source.scope =3D CONFIG_SCOPE_SYSTEM;
+	} else if (opts->use_local_config) {
+		opts->source.file =3D xstrdup_or_null(git_pathdup("config"));
+		opts->source.scope =3D CONFIG_SCOPE_LOCAL;
+	} else if (opts->use_worktree_config) {
 		struct worktree **worktrees =3D get_worktrees();
 		if (the_repository->repository_format_worktree_config)
-			given_config_source.file =3D git_pathdup("config.worktree");
+			opts->source.file =3D git_pathdup("config.worktree");
 		else if (worktrees[0] && worktrees[1])
 			die(_("--worktree cannot be used with multiple "
 			      "working trees unless the config\n"
@@ -691,28 +716,33 @@ static void handle_config_location(const char *prefix)
 			      "Please read \"CONFIGURATION FILE\"\n"
 			      "section in \"git help worktree\" for details"));
 		else
-			given_config_source.file =3D git_pathdup("config");
-		given_config_source.scope =3D CONFIG_SCOPE_LOCAL;
+			opts->source.file =3D git_pathdup("config");
+		opts->source.scope =3D CONFIG_SCOPE_LOCAL;
 		free_worktrees(worktrees);
-	} else if (given_config_source.file) {
-		if (!is_absolute_path(given_config_source.file) && prefix)
-			given_config_source.file =3D
-				prefix_filename(prefix, given_config_source.file);
-		given_config_source.scope =3D CONFIG_SCOPE_COMMAND;
-	} else if (given_config_source.blob) {
-		given_config_source.scope =3D CONFIG_SCOPE_COMMAND;
+	} else if (opts->source.file) {
+		if (!is_absolute_path(opts->source.file) && prefix)
+			opts->source.file =3D
+				prefix_filename(prefix, opts->source.file);
+		opts->source.scope =3D CONFIG_SCOPE_COMMAND;
+	} else if (opts->source.blob) {
+		opts->source.scope =3D CONFIG_SCOPE_COMMAND;
 	}
=20
 	if (respect_includes_opt =3D=3D -1)
-		config_options.respect_includes =3D !given_config_source.file;
+		opts->options.respect_includes =3D !opts->source.file;
 	else
-		config_options.respect_includes =3D respect_includes_opt;
+		opts->options.respect_includes =3D respect_includes_opt;
 	if (startup_info->have_repository) {
-		config_options.commondir =3D get_git_common_dir();
-		config_options.git_dir =3D get_git_dir();
+		opts->options.commondir =3D get_git_common_dir();
+		opts->options.git_dir =3D get_git_dir();
 	}
 }
=20
+static void location_options_release(struct config_location_options *opts)
+{
+	free((char *) opts->source.file);
+}
+
 static void handle_nul(void) {
 	if (end_nul) {
 		term =3D '\0';
@@ -721,15 +751,6 @@ static void handle_nul(void) {
 	}
 }
=20
-#define CONFIG_LOCATION_OPTIONS \
-	OPT_GROUP(N_("Config file location")), \
-	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")), \
-	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")), \
-	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file"))=
, \
-	OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree config=
 file")), \
-	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use gi=
ven config file")), \
-	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read =
config from given blob object"))
-
 #define CONFIG_TYPE_OPTIONS \
 	OPT_GROUP(N_("Type")), \
 	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type=
"), option_parse_type), \
@@ -749,8 +770,9 @@ static void handle_nul(void) {
=20
 static int cmd_config_list(int argc, const char **argv, const char *prefix)
 {
+	struct config_location_options location_opts =3D CONFIG_LOCATION_OPTIONS_=
INIT;
 	struct option opts[] =3D {
-		CONFIG_LOCATION_OPTIONS,
+		CONFIG_LOCATION_OPTIONS(location_opts),
 		CONFIG_DISPLAY_OPTIONS,
 		OPT_GROUP(N_("Other")),
 		OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direc=
tives on lookup")),
@@ -760,30 +782,32 @@ static int cmd_config_list(int argc, const char **arg=
v, const char *prefix)
 	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_list_usag=
e, 0);
 	check_argc(argc, 0, 0);
=20
-	handle_config_location(prefix);
+	location_options_init(&location_opts, prefix);
 	handle_nul();
=20
 	setup_auto_pager("config", 1);
=20
 	if (config_with_options(show_all_config, NULL,
-				&given_config_source, the_repository,
-				&config_options) < 0) {
-		if (given_config_source.file)
+				&location_opts.source, the_repository,
+				&location_opts.options) < 0) {
+		if (location_opts.source.file)
 			die_errno(_("unable to read config file '%s'"),
-				  given_config_source.file);
+				  location_opts.source.file);
 		else
 			die(_("error processing config file(s)"));
 	}
=20
+	location_options_release(&location_opts);
 	return 0;
 }
=20
 static int cmd_config_get(int argc, const char **argv, const char *prefix)
 {
+	struct config_location_options location_opts =3D CONFIG_LOCATION_OPTIONS_=
INIT;
 	const char *value_pattern =3D NULL, *url =3D NULL;
 	int flags =3D 0;
 	struct option opts[] =3D {
-		CONFIG_LOCATION_OPTIONS,
+		CONFIG_LOCATION_OPTIONS(location_opts),
 		CONFIG_TYPE_OPTIONS,
 		OPT_GROUP(N_("Filter options")),
 		OPT_BOOL(0, "all", &do_all, N_("return all values for multi-valued confi=
g options")),
@@ -811,26 +835,28 @@ static int cmd_config_get(int argc, const char **argv=
, const char *prefix)
 	if (url && (do_all || use_key_regexp || value_pattern))
 		die(_("--url=3D cannot be used with --all, --regexp or --value"));
=20
-	handle_config_location(prefix);
+	location_options_init(&location_opts, prefix);
 	handle_nul();
=20
 	setup_auto_pager("config", 1);
=20
 	if (url)
-		ret =3D get_urlmatch(argv[0], url);
+		ret =3D get_urlmatch(&location_opts, argv[0], url);
 	else
-		ret =3D get_value(argv[0], value_pattern, flags);
+		ret =3D get_value(&location_opts, argv[0], value_pattern, flags);
=20
+	location_options_release(&location_opts);
 	return ret;
 }
=20
 static int cmd_config_set(int argc, const char **argv, const char *prefix)
 {
+	struct config_location_options location_opts =3D CONFIG_LOCATION_OPTIONS_=
INIT;
 	const char *value_pattern =3D NULL, *comment_arg =3D NULL;
 	char *comment =3D NULL;
 	int flags =3D 0, append =3D 0;
 	struct option opts[] =3D {
-		CONFIG_LOCATION_OPTIONS,
+		CONFIG_LOCATION_OPTIONS(location_opts),
 		CONFIG_TYPE_OPTIONS,
 		OPT_GROUP(N_("Filter")),
 		OPT_BIT(0, "all", &flags, N_("replace multi-valued config option with ne=
w value"), CONFIG_FLAGS_MULTI_REPLACE),
@@ -858,23 +884,24 @@ static int cmd_config_set(int argc, const char **argv=
, const char *prefix)
=20
 	comment =3D git_config_prepare_comment_string(comment_arg);
=20
-	handle_config_location(prefix);
-	check_write();
+	location_options_init(&location_opts, prefix);
+	check_write(&location_opts.source);
=20
 	value =3D normalize_value(argv[0], argv[1], &default_kvi);
=20
 	if ((flags & CONFIG_FLAGS_MULTI_REPLACE) || value_pattern) {
-		ret =3D git_config_set_multivar_in_file_gently(given_config_source.file,
+		ret =3D git_config_set_multivar_in_file_gently(location_opts.source.file,
 							     argv[0], value, value_pattern,
 							     comment, flags);
 	} else {
-		ret =3D git_config_set_in_file_gently(given_config_source.file,
+		ret =3D git_config_set_in_file_gently(location_opts.source.file,
 						    argv[0], comment, value);
 		if (ret =3D=3D CONFIG_NOTHING_SET)
 			error(_("cannot overwrite multiple values with a single value\n"
 			"       Use a regexp, --add or --replace-all to change %s."), argv[0]);
 	}
=20
+	location_options_release(&location_opts);
 	free(comment);
 	free(value);
 	return ret;
@@ -882,10 +909,11 @@ static int cmd_config_set(int argc, const char **argv=
, const char *prefix)
=20
 static int cmd_config_unset(int argc, const char **argv, const char *prefi=
x)
 {
+	struct config_location_options location_opts =3D CONFIG_LOCATION_OPTIONS_=
INIT;
 	const char *value_pattern =3D NULL;
 	int flags =3D 0;
 	struct option opts[] =3D {
-		CONFIG_LOCATION_OPTIONS,
+		CONFIG_LOCATION_OPTIONS(location_opts),
 		OPT_GROUP(N_("Filter")),
 		OPT_BIT(0, "all", &flags, N_("replace multi-valued config option with ne=
w value"), CONFIG_FLAGS_MULTI_REPLACE),
 		OPT_STRING(0, "value", &value_pattern, N_("pattern"), N_("show config wi=
th values matching the pattern")),
@@ -901,24 +929,26 @@ static int cmd_config_unset(int argc, const char **ar=
gv, const char *prefix)
 	if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
 		die(_("--fixed-value only applies with 'value-pattern'"));
=20
-	handle_config_location(prefix);
-	check_write();
+	location_options_init(&location_opts, prefix);
+	check_write(&location_opts.source);
=20
 	if ((flags & CONFIG_FLAGS_MULTI_REPLACE) || value_pattern)
-		ret =3D git_config_set_multivar_in_file_gently(given_config_source.file,
+		ret =3D git_config_set_multivar_in_file_gently(location_opts.source.file,
 							     argv[0], NULL, value_pattern,
 							     NULL, flags);
 	else
-		ret =3D git_config_set_in_file_gently(given_config_source.file, argv[0],
+		ret =3D git_config_set_in_file_gently(location_opts.source.file, argv[0],
 						    NULL, NULL);
=20
+	location_options_release(&location_opts);
 	return ret;
 }
=20
 static int cmd_config_rename_section(int argc, const char **argv, const ch=
ar *prefix)
 {
+	struct config_location_options location_opts =3D CONFIG_LOCATION_OPTIONS_=
INIT;
 	struct option opts[] =3D {
-		CONFIG_LOCATION_OPTIONS,
+		CONFIG_LOCATION_OPTIONS(location_opts),
 		OPT_END(),
 	};
 	int ret;
@@ -927,10 +957,10 @@ static int cmd_config_rename_section(int argc, const =
char **argv, const char *pr
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	check_argc(argc, 2, 2);
=20
-	handle_config_location(prefix);
-	check_write();
+	location_options_init(&location_opts, prefix);
+	check_write(&location_opts.source);
=20
-	ret =3D git_config_rename_section_in_file(given_config_source.file,
+	ret =3D git_config_rename_section_in_file(location_opts.source.file,
 						argv[0], argv[1]);
 	if (ret < 0)
 		goto out;
@@ -939,13 +969,15 @@ static int cmd_config_rename_section(int argc, const =
char **argv, const char *pr
 	ret =3D 0;
=20
 out:
+	location_options_release(&location_opts);
 	return ret;
 }
=20
 static int cmd_config_remove_section(int argc, const char **argv, const ch=
ar *prefix)
 {
+	struct config_location_options location_opts =3D CONFIG_LOCATION_OPTIONS_=
INIT;
 	struct option opts[] =3D {
-		CONFIG_LOCATION_OPTIONS,
+		CONFIG_LOCATION_OPTIONS(location_opts),
 		OPT_END(),
 	};
 	int ret;
@@ -954,10 +986,10 @@ static int cmd_config_remove_section(int argc, const =
char **argv, const char *pr
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	check_argc(argc, 1, 1);
=20
-	handle_config_location(prefix);
-	check_write();
+	location_options_init(&location_opts, prefix);
+	check_write(&location_opts.source);
=20
-	ret =3D git_config_rename_section_in_file(given_config_source.file,
+	ret =3D git_config_rename_section_in_file(location_opts.source.file,
 						argv[0], NULL);
 	if (ret < 0)
 		goto out;
@@ -966,24 +998,25 @@ static int cmd_config_remove_section(int argc, const =
char **argv, const char *pr
 	ret =3D 0;
=20
 out:
+	location_options_release(&location_opts);
 	return ret;
 }
=20
-static int show_editor(void)
+static int show_editor(struct config_location_options *opts)
 {
 	char *config_file;
=20
-	if (!given_config_source.file && !startup_info->have_repository)
+	if (!opts->source.file && !startup_info->have_repository)
 		die(_("not in a git directory"));
-	if (given_config_source.use_stdin)
+	if (opts->source.use_stdin)
 		die(_("editing stdin is not supported"));
-	if (given_config_source.blob)
+	if (opts->source.blob)
 		die(_("editing blobs is not supported"));
 	git_config(git_default_config, NULL);
-	config_file =3D given_config_source.file ?
-			xstrdup(given_config_source.file) :
+	config_file =3D opts->source.file ?
+			xstrdup(opts->source.file) :
 			git_pathdup("config");
-	if (use_global_config) {
+	if (opts->use_global_config) {
 		int fd =3D open(config_file, O_CREAT | O_EXCL | O_WRONLY, 0666);
 		if (fd >=3D 0) {
 			char *content =3D default_user_config();
@@ -1002,18 +1035,22 @@ static int show_editor(void)
=20
 static int cmd_config_edit(int argc, const char **argv, const char *prefix)
 {
+	struct config_location_options location_opts =3D CONFIG_LOCATION_OPTIONS_=
INIT;
 	struct option opts[] =3D {
-		CONFIG_LOCATION_OPTIONS,
+		CONFIG_LOCATION_OPTIONS(location_opts),
 		OPT_END(),
 	};
+	int ret;
=20
 	argc =3D parse_options(argc, argv, prefix, opts, builtin_config_edit_usag=
e, 0);
 	check_argc(argc, 0, 0);
=20
-	handle_config_location(prefix);
-	check_write();
+	location_options_init(&location_opts, prefix);
+	check_write(&location_opts.source);
=20
-	return show_editor();
+	ret =3D show_editor(&location_opts);
+	location_options_release(&location_opts);
+	return ret;
 }
=20
 static int cmd_config_actions(int argc, const char **argv, const char *pre=
fix)
@@ -1036,10 +1073,11 @@ static int cmd_config_actions(int argc, const char =
**argv, const char *prefix)
 		ACTION_GET_COLORBOOL =3D (1<<14),
 		ACTION_GET_URLMATCH =3D (1<<15),
 	};
+	struct config_location_options location_opts =3D CONFIG_LOCATION_OPTIONS_=
INIT;
 	const char *comment_arg =3D NULL;
 	int actions =3D 0;
 	struct option opts[] =3D {
-		CONFIG_LOCATION_OPTIONS,
+		CONFIG_LOCATION_OPTIONS(location_opts),
 		OPT_GROUP(N_("Action")),
 		OPT_CMDMODE(0, "get", &actions, N_("get value: name [<value-pattern>]"),=
 ACTION_GET),
 		OPT_CMDMODE(0, "get-all", &actions, N_("get all values: key [<value-patt=
ern>]"), ACTION_GET_ALL),
@@ -1073,7 +1111,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 			     builtin_config_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
=20
-	handle_config_location(prefix);
+	location_options_init(&location_opts, prefix);
 	handle_nul();
=20
 	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && type) {
@@ -1162,94 +1200,94 @@ static int cmd_config_actions(int argc, const char =
**argv, const char *prefix)
 	if (actions =3D=3D ACTION_LIST) {
 		check_argc(argc, 0, 0);
 		if (config_with_options(show_all_config, NULL,
-					&given_config_source, the_repository,
-					&config_options) < 0) {
-			if (given_config_source.file)
+					&location_opts.source, the_repository,
+					&location_opts.options) < 0) {
+			if (location_opts.source.file)
 				die_errno(_("unable to read config file '%s'"),
-					  given_config_source.file);
+					  location_opts.source.file);
 			else
 				die(_("error processing config file(s)"));
 		}
 	}
 	else if (actions =3D=3D ACTION_EDIT) {
-		ret =3D show_editor();
+		ret =3D show_editor(&location_opts);
 	}
 	else if (actions =3D=3D ACTION_SET) {
-		check_write();
+		check_write(&location_opts.source);
 		check_argc(argc, 2, 2);
 		value =3D normalize_value(argv[0], argv[1], &default_kvi);
-		ret =3D git_config_set_in_file_gently(given_config_source.file, argv[0],=
 comment, value);
+		ret =3D git_config_set_in_file_gently(location_opts.source.file, argv[0]=
, comment, value);
 		if (ret =3D=3D CONFIG_NOTHING_SET)
 			error(_("cannot overwrite multiple values with a single value\n"
 			"       Use a regexp, --add or --replace-all to change %s."), argv[0]);
 	}
 	else if (actions =3D=3D ACTION_SET_ALL) {
-		check_write();
+		check_write(&location_opts.source);
 		check_argc(argc, 2, 3);
 		value =3D normalize_value(argv[0], argv[1], &default_kvi);
-		ret =3D git_config_set_multivar_in_file_gently(given_config_source.file,
+		ret =3D git_config_set_multivar_in_file_gently(location_opts.source.file,
 							     argv[0], value, argv[2],
 							     comment, flags);
 	}
 	else if (actions =3D=3D ACTION_ADD) {
-		check_write();
+		check_write(&location_opts.source);
 		check_argc(argc, 2, 2);
 		value =3D normalize_value(argv[0], argv[1], &default_kvi);
-		ret =3D git_config_set_multivar_in_file_gently(given_config_source.file,
+		ret =3D git_config_set_multivar_in_file_gently(location_opts.source.file,
 							     argv[0], value,
 							     CONFIG_REGEX_NONE,
 							     comment, flags);
 	}
 	else if (actions =3D=3D ACTION_REPLACE_ALL) {
-		check_write();
+		check_write(&location_opts.source);
 		check_argc(argc, 2, 3);
 		value =3D normalize_value(argv[0], argv[1], &default_kvi);
-		ret =3D git_config_set_multivar_in_file_gently(given_config_source.file,
+		ret =3D git_config_set_multivar_in_file_gently(location_opts.source.file,
 							     argv[0], value, argv[2],
 							     comment, flags | CONFIG_FLAGS_MULTI_REPLACE);
 	}
 	else if (actions =3D=3D ACTION_GET) {
 		check_argc(argc, 1, 2);
-		ret =3D get_value(argv[0], argv[1], flags);
+		ret =3D get_value(&location_opts, argv[0], argv[1], flags);
 	}
 	else if (actions =3D=3D ACTION_GET_ALL) {
 		do_all =3D 1;
 		check_argc(argc, 1, 2);
-		ret =3D get_value(argv[0], argv[1], flags);
+		ret =3D get_value(&location_opts, argv[0], argv[1], flags);
 	}
 	else if (actions =3D=3D ACTION_GET_REGEXP) {
 		show_keys =3D 1;
 		use_key_regexp =3D 1;
 		do_all =3D 1;
 		check_argc(argc, 1, 2);
-		ret =3D get_value(argv[0], argv[1], flags);
+		ret =3D get_value(&location_opts, argv[0], argv[1], flags);
 	}
 	else if (actions =3D=3D ACTION_GET_URLMATCH) {
 		check_argc(argc, 2, 2);
-		ret =3D get_urlmatch(argv[0], argv[1]);
+		ret =3D get_urlmatch(&location_opts, argv[0], argv[1]);
 	}
 	else if (actions =3D=3D ACTION_UNSET) {
-		check_write();
+		check_write(&location_opts.source);
 		check_argc(argc, 1, 2);
 		if (argc =3D=3D 2)
-			ret =3D git_config_set_multivar_in_file_gently(given_config_source.file,
+			ret =3D git_config_set_multivar_in_file_gently(location_opts.source.fil=
e,
 								     argv[0], NULL, argv[1],
 								     NULL, flags);
 		else
-			ret =3D git_config_set_in_file_gently(given_config_source.file,
+			ret =3D git_config_set_in_file_gently(location_opts.source.file,
 							    argv[0], NULL, NULL);
 	}
 	else if (actions =3D=3D ACTION_UNSET_ALL) {
-		check_write();
+		check_write(&location_opts.source);
 		check_argc(argc, 1, 2);
-		ret =3D git_config_set_multivar_in_file_gently(given_config_source.file,
+		ret =3D git_config_set_multivar_in_file_gently(location_opts.source.file,
 							     argv[0], NULL, argv[1],
 							     NULL, flags | CONFIG_FLAGS_MULTI_REPLACE);
 	}
 	else if (actions =3D=3D ACTION_RENAME_SECTION) {
-		check_write();
+		check_write(&location_opts.source);
 		check_argc(argc, 2, 2);
-		ret =3D git_config_rename_section_in_file(given_config_source.file,
+		ret =3D git_config_rename_section_in_file(location_opts.source.file,
 							argv[0], argv[1]);
 		if (ret < 0)
 			goto out;
@@ -1259,9 +1297,9 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 			ret =3D 0;
 	}
 	else if (actions =3D=3D ACTION_REMOVE_SECTION) {
-		check_write();
+		check_write(&location_opts.source);
 		check_argc(argc, 1, 1);
-		ret =3D git_config_rename_section_in_file(given_config_source.file,
+		ret =3D git_config_rename_section_in_file(location_opts.source.file,
 							argv[0], NULL);
 		if (ret < 0)
 			goto out;
@@ -1272,16 +1310,17 @@ static int cmd_config_actions(int argc, const char =
**argv, const char *prefix)
 	}
 	else if (actions =3D=3D ACTION_GET_COLOR) {
 		check_argc(argc, 1, 2);
-		get_color(argv[0], argv[1]);
+		get_color(&location_opts, argv[0], argv[1]);
 	}
 	else if (actions =3D=3D ACTION_GET_COLORBOOL) {
 		check_argc(argc, 1, 2);
 		if (argc =3D=3D 2)
 			color_stdout_is_tty =3D git_config_bool("command line", argv[1]);
-		ret =3D get_colorbool(argv[0], argc =3D=3D 2);
+		ret =3D get_colorbool(&location_opts, argv[0], argc =3D=3D 2);
 	}
=20
 out:
+	location_options_release(&location_opts);
 	free(comment);
 	free(value);
 	return ret;
@@ -1301,8 +1340,6 @@ int cmd_config(int argc, const char **argv, const cha=
r *prefix)
 		OPT_END(),
 	};
=20
-	given_config_source.file =3D xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
-
 	/*
 	 * This is somewhat hacky: we first parse the command line while
 	 * keeping all args intact in order to determine whether a subcommand
--=20
2.45.GIT


--ZQaZ/m8HGbEbursa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6fIACgkQVbJhu7ck
PpRqjhAAmF7w00Yq8/6xy0X3V4LNO1MCAldm5qpwkVqbyha3t/fe8ys/yr17S/Nv
S5a5mPfJT3vgT3uSi55XRT5tv0GRld+02A8DGYsVNxmYLmQlwYCvEwt05WPmAyuE
ZeMZhywLFbPR/ntdH9vXEIo7cxkXbptURpo70AH17eLNAZ6DZEsa1iPrvR+WmUqE
MHmCWXySNKobJcmyhxv4AxVlr9T05HSbB054hhcFkibjIDbriPl8876U9j5bQxD3
+jtE1Ec47wnNG7C5BPXpJxDa6+hCyyZHR+PEHf9ZWZskbb3m993YvHXleWY7ZTiZ
vBoT66n4byoypxf7vzTSU5bGKR6rjCguTgWgjN1XIzQplsVhc2DCCYau94wpizZ4
vwDd/8gEC5a7yheMdXSAi9ApWDN+zLy+CXnciWzlPpl7Q2KV7HA270Z8VZEFBL/5
AB7vu/CNbKkIJdm8AmEDMUtEVTljdZCk29XVnNXVPjXelkvb+9AtpWTMWcIyIwwQ
koEnbs7Nxg6llTAQK5OYaNV7ekZ1Ig6uvRKlQjMBPDfR5DJzxvjNFhLXP3oSr+A+
uB2SweZBzi6e1kIRwinkA5toYO7RRPz6f5Nx9FdeK4Z/9pIlkWdp1F68JlThOayh
jHUe8tZpJW142mzqRVOtuCIhPoRxdXB5mGzoLuStECuX8UfJoms=
=EDLt
-----END PGP SIGNATURE-----

--ZQaZ/m8HGbEbursa--
