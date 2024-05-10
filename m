Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB79C16E860
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340314; cv=none; b=eWD4F916T7DnWJ8IAKvx8k8ZAL+gx8e4r8As40chJn1VyCzdXsnIUtHcg7AIdDzC0uP5rhRdoaULjB0X08eibbpQrGg3YZUUmBvnC25WQCkFuf8hbz/zDxecHvySFI9n93n+wyl1q/7lT2YQIczd4jPsY+yqwAdo4JpqG5pHpzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340314; c=relaxed/simple;
	bh=mSc77ECuMXlv8v42dBtBbdI+obX1fqVlFVsLnxqFUYE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpHwhbSPQ8LQn+sOkgCAwJgUK4EytZvgtHMm62IuArCX4gHh6hn64gG8ohMJgPqLbtYuWNFJF6tg3Tz11n1o9yYYcjnbrMFpSoER6aIzHhZ5XUuDNwF1rQ9uB+zgZjDOcTNSraasWaqjrFmFZ26sy8/iqNCJU8AHS2P3JoNi2U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l1kBGCq7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IYR1y2dR; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l1kBGCq7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IYR1y2dR"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 0AB3C1C000D9
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:25:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 10 May 2024 07:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715340310; x=1715426710; bh=bOr4L0vG5K
	yGEv/5DdwStSDPn2yNdJdYssKxkDFQLNk=; b=l1kBGCq70a0578HIohFfqIXSKj
	frwFfT+oCJ1LgIJP6bjSr17OUwGcluK3b/FiCYbJhuRkNMoc7pQeMwrpImzzkd6e
	Kb8sOFrulj6AXUeGIx9Qna16SGYUkE52Tg8mOhkBbt240clCST5wBSVIP4yoPBTs
	WLmATh5QS2nz2wcoOD5KvF+1vGQb80zNpD+VyRhMfuiXWLIsdQi1ZEvaU/GXKpHm
	Y+HJ2YRxTO3roeh+JW6zthejzGQyc0YO+xUhxowoLMyvS6GEs0QuWlraKLmUdI5x
	pZR358YDAuQJML1CT42757aU19jCJ+KQZI6r7muzlovHB+q5UbHLSXoKWDmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715340310; x=1715426710; bh=bOr4L0vG5KyGEv/5DdwStSDPn2yN
	dJdYssKxkDFQLNk=; b=IYR1y2dRk9Atd3SjfkWshzferhMrTY/ZabHnEvkKigba
	ieg+5iyWjLLoaLwwMkVIK4dLwXElkOmFnU2QIfdKYAIJo8nuAxyq71FT7s94sDYC
	3ryiZ6Hd5Owrwe45abvtpRBXrpb3QHPB5HRBnQkyZC00YlSbR5HjIZmZQbqXmjkk
	Vtv3c5p9LUqeoefaQLdmlACr/PWOMPImioLAFUMd4Xswai8rNmE+3YxyX48nDx4b
	w56VWW/enXlp/wtOcHTC4C5QeZ/p+oEw0S8vPM0NwdxiVIZ/6eXm3i/nmiMieAPQ
	6WtL5TOmYsU0Mdz9b+7m5rCv2JRWYr7h57cxK3a+KA==
X-ME-Sender: <xms:FgQ-Zrkl6R1n_dtESDkyRc7Wcg8FIuSxFUhgzUzC5v4uzJ9Y2Bi5jQ>
    <xme:FgQ-Zu1hq7Ctyfilmp0WFGp0TjdYOizO87K3-FC1yS5UEb8aLk_ZWpkOAFKyZVShw
    aiGPi6ygYeebYCumA>
X-ME-Received: <xmr:FgQ-Zhr4z_bgK16s75zsIo15K2fKnISV4-e5nXolS4NKBRYKn5u5KsCFR_jJ9RLNZ7QM-ujpilCpl8yQ7dGBr-tPEYSdgScKHZjDyNBlkVG6xBIYIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:FgQ-ZjlrT3i1QIJsH1XMckAzljuyc-FWKlEBBFRJ3QCcvB4FFyL8LA>
    <xmx:FgQ-Zp2h9RbCf3E4AsRvSZacBT2NlH65ji_w5aTZSpC0m7xlMcz9jA>
    <xmx:FgQ-Zit6axn-8Zt86nzMR1AnMDZQ1v1TmcdbtbR_KbiTgCRnV4Xgww>
    <xmx:FgQ-ZtU3x76KUCYjnqMk7e4HMr1UxPCZXmwepUyDADSw5mL84hCQgA>
    <xmx:FgQ-Zq9EadeJQWKcktN-4-T8SMWz-e6APFv4zqks-kg-nJpejZMxMBUL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:25:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ac1b94c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:24:57 +0000 (UTC)
Date: Fri, 10 May 2024 13:25:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 09/21] builtin/config: move location options into local
 variables
Message-ID: <a96c122280ad025f94c1343cca85c67c7c617c8f.1715339393.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0hafaSqo0Kq2+Vus"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--0hafaSqo0Kq2+Vus
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
index 9b90eda328..5346a782d0 100644
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
+		opts->source.file =3D xstrdup_or_null(git_global_config());
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
@@ -1158,94 +1196,94 @@ static int cmd_config_actions(int argc, const char =
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
@@ -1255,9 +1293,9 @@ static int cmd_config_actions(int argc, const char **=
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
@@ -1268,16 +1306,17 @@ static int cmd_config_actions(int argc, const char =
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
@@ -1297,8 +1336,6 @@ int cmd_config(int argc, const char **argv, const cha=
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


--0hafaSqo0Kq2+Vus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+BBIACgkQVbJhu7ck
PpTHSg//ZdsCN5nPydJyx16afYLr+eRrX5JKrBTiiKBwsg0ZlokG8oRJvQkqJv4o
snOteVebJzx42h1UoOaGd8CibBFRuUcRILQSznchsiAtBSnbRH+it1YdIeu296D6
G+vH2ij0awUoOr53qXVBY4hed2q8I76mtj4ZTyqR79Z1ZzYvbVTEeW+8vti7RxXg
5eRNwCwv2L6H+Jw+yUR7fnE0vDNMu3KkWWRz/yihxUtiaivRtcH+Ndbi70s4Ut1f
6qanm3+jUhy4pf4gIC+bL2QZts/BHGR2x8T9DzFLl9KlzXDINmPTBVu+jNq5sSGi
XHCzUAS0dIUjVR4KbzYpfhfdESOAwlLxpl6gLfS37JWARLKX15Mb6Vze5VbOm3Bj
nBGFc1WgXMoQgo9YxnvsJn+M2tc+TW4kL7cvQ0jc73naZS3uYyCf7FG6SGxFS9pE
18ZdBwBlsfZUR+YD7dmLKo6Vbq7WRe1DjsvzgjewIENtCP6yUga2YFd6VUePpfBU
ok7hlnejpiq0eEDT5/H3PMhrkoe32fHFj2NqQvDbvILcrjb1Et06sreUT+Dld/7a
ft0PWjUk59yZVvDAsnbSmIUY46HRJNvuNqjXV+Q0WFnUJLJT+drxWBqejTyzo+Dn
vkxSEVkstTwuf45wWFgLWupsOw49hukBO3DP26e+YdPtHHc8Yvs=
=kMjA
-----END PGP SIGNATURE-----

--0hafaSqo0Kq2+Vus--
