Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4955683CCC
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545044; cv=none; b=iPFX9Iqv1v1ZX7g1UW1VoZK1sLzusCos3vWL9vmI2LmkGFAZQxcRCrLgSBCB6pbtDA2WY9aizC+0uDhxEeT9cdez4uZxDZGHAz/VsjMUETXnPVF8/v396NoxLz2QnXHhWxDivRv37nwlAPAZclF9sET+aCOUi9f/IxeZRQ2FwL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545044; c=relaxed/simple;
	bh=/CL24fyn4R/WTwIYM3Efw2mZb3bxGKY3k0ErhAK7zYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqzryTE3cy8QPxgeYSrqW0gPXgpATvbuggvfjn0n2/aEtzrFkdTah49IIDcg6Y0mJLsGEerTjZlHWdcT4sklPfr/qPIojzaVZbYhyPyzLOMyS+MybbDDwnBMg5Ja0JyhD3Csh+3e43z0FJzAkbRrGb4TFUoZ1CSa6k/YcFw097I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fu516c5+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SXPQ2t32; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fu516c5+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SXPQ2t32"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9BFDD114019E;
	Fri, 24 May 2024 06:04:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 24 May 2024 06:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545041; x=1716631441; bh=MvoWn8uj9b
	5FZxlHNLJMRx7FoxdNgKqHxw0J3WydN/Q=; b=fu516c5+fkmZrLLb0MTJeoVBtJ
	NuG7sOSvCF7011pkNUcDu2VajSFMqSulbmw2nR69vU1nZfQxqSYK/Yw81hPv6hx+
	N3Ex9QkgTqakszGLambUm8Y8UxttP8QoXaCYdiIcuzMC9wk/waVPOlcyNoiw5q8u
	sUj/gj06SeCDi9pY3pLgE2C1ESKqHMSDl7CwZiRjwPo1DUBP9RoAswoteUCLOP9E
	N7R8Y/FpxujdJYTjGpPKso2+Hvqq9f/9zxk5gfgWYgsgJXvuUzXlWPeXb0c3Wse9
	1bPmMeO6eJBU1R1xNnS5jQdpMAel/uT7SKx666K0OYXZSme9b4uW1vpU3q1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545041; x=1716631441; bh=MvoWn8uj9b5FZxlHNLJMRx7FoxdN
	gKqHxw0J3WydN/Q=; b=SXPQ2t32NwlUN7PjmMDj9VVaiAz2nVpzDzwJtGfJyXKE
	PnZrOEURr/Y9q/+2204pfXK+OZj+Vsw+giy3UWMKgBW/J4YTKhk+OD11L91svcZm
	c8KLH5gcUDEFNkmDooBu8+/OReloJ23LwCh7svMvsqqP49c2hUxiVQ2rhwrdqga1
	72Fyam0Dtr5KApuEIg7tcL/qvrKsQwk4nsSsUoezRv5D820q9h8IBVIux1lcHBFT
	OgLuL0wXFCCAJH5J3vsz16U6i9We4zGOKXxlQQFTNM3b27lf3dKbvVVZyf3woHjh
	sm4RSN96W/tmPNgznIih0bvu10TrvjEEWw8ZRjqWUQ==
X-ME-Sender: <xms:EWZQZhUIbzMM06ktvGBEA10jlROfJs__ZrG3KBEOP_evufoe783M4w>
    <xme:EWZQZhlr25icXxT3UBkjt6TUDoaG3ZWfrXYMCL7WyJVqXGJlYe91wPiFw97sqaL8A
    aFVulJR7UdmhQwsdA>
X-ME-Received: <xmr:EWZQZtZnEZj8318eSnRZ4F9Cdejm26PcGGm7Od0Jwsbp6rE4Q8sCRmInXHzEHzTkLAe4CK7Kb9UEvCy62A3_TkcrlCsuEcIpncN6YK6TamimPXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteelteekleeitdevffdvgfffffekueektedutdffleetvdegteffgeeuhfeivddv
    necuffhomhgrihhnpeguihhffhhophhtrdhnohdpphgvnhguihhnghdrnhhrnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mh
X-ME-Proxy: <xmx:EWZQZkXm3vSVZ2ljIoVpJ-hn7TvkBui4MlS_fTqVNOghOfeDrTpupg>
    <xmx:EWZQZrnNqd_FkujXEWJk6nxnp9qcvS1K0tzQEUbqPEOvYPxeAWd5Pw>
    <xmx:EWZQZhdqk19lauOnRw-pckSynZyc0E4VDwfHoXtV5RfdrIUBcDPJIg>
    <xmx:EWZQZlFn5lR228xfxk3byxs9te9gwtASqJbSNYTH-ie3FWqGPglvog>
    <xmx:EWZQZphb4GQu2KU16CgX0G0D2qfsSdwvNmiqKPbZZnOl7Eu-ymKUE4hH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:04:00 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 524e6147 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:03:57 +0000 (UTC)
Date: Fri, 24 May 2024 12:03:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/21] builtin/log: stop using globals for log config
Message-ID: <ee2fcf388c0855ec30f98eb576e9896dd90d2924.1716541556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mJa6B+FWR9bLwN/S"
Content-Disposition: inline
In-Reply-To: <cover.1716541556.git.ps@pks.im>


--mJa6B+FWR9bLwN/S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're using global variables to store the log configuration. Many of
these can be set both via the command line and via the config, and
depending on how they are being set, they may contain allocated strings.
This leads to hard-to-track memory ownership and memory leaks.

Refactor the code to instead use a `struct log_config` that is being
allocated on the stack. This allows us to more clearly scope the
variables, track memory ownership and ultimately release the memory.

This also prepares us for a change to `git_config_string()`, which will
be adapted to have a `char **` out parameter instead of `const char **`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/log.c | 259 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 156 insertions(+), 103 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index a2f5845556..f5da29ee2a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -48,22 +48,8 @@
 #define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
 #define FORMAT_PATCH_NAME_MAX_DEFAULT 64
=20
-/* Set a default date-time format for git log ("log.date" config variable)=
 */
-static const char *default_date_mode =3D NULL;
-
-static int default_abbrev_commit;
-static int default_show_root =3D 1;
-static int default_follow;
-static int default_show_signature;
-static int default_encode_email_headers =3D 1;
-static int decoration_style;
-static int decoration_given;
-static int use_mailmap_config =3D 1;
 static unsigned int force_in_body_from;
 static int stdout_mboxrd;
-static const char *fmt_patch_subject_prefix =3D "PATCH";
-static int fmt_patch_name_max =3D FORMAT_PATCH_NAME_MAX_DEFAULT;
-static const char *fmt_pretty;
 static int format_no_prefix;
=20
 static const char * const builtin_log_usage[] =3D {
@@ -111,6 +97,39 @@ static int parse_decoration_style(const char *value)
 	return -1;
 }
=20
+struct log_config {
+	int default_abbrev_commit;
+	int default_show_root;
+	int default_follow;
+	int default_show_signature;
+	int default_encode_email_headers;
+	int decoration_style;
+	int decoration_given;
+	int use_mailmap_config;
+	char *fmt_patch_subject_prefix;
+	int fmt_patch_name_max;
+	char *fmt_pretty;
+	char *default_date_mode;
+};
+
+static void log_config_init(struct log_config *cfg)
+{
+	memset(cfg, 0, sizeof(*cfg));
+	cfg->default_show_root =3D 1;
+	cfg->default_encode_email_headers =3D 1;
+	cfg->use_mailmap_config =3D 1;
+	cfg->fmt_patch_subject_prefix =3D xstrdup("PATCH");
+	cfg->fmt_patch_name_max =3D FORMAT_PATCH_NAME_MAX_DEFAULT;
+	cfg->decoration_style =3D auto_decoration_style();
+}
+
+static void log_config_release(struct log_config *cfg)
+{
+	free(cfg->default_date_mode);
+	free(cfg->fmt_pretty);
+	free(cfg->fmt_patch_subject_prefix);
+}
+
 static int use_default_decoration_filter =3D 1;
 static struct string_list decorate_refs_exclude =3D STRING_LIST_INIT_NODUP;
 static struct string_list decorate_refs_exclude_config =3D STRING_LIST_INI=
T_NODUP;
@@ -127,20 +146,22 @@ static int clear_decorations_callback(const struct op=
tion *opt UNUSED,
 	return 0;
 }
=20
-static int decorate_callback(const struct option *opt UNUSED, const char *=
arg,
+static int decorate_callback(const struct option *opt, const char *arg,
 			     int unset)
 {
+	struct log_config *cfg =3D opt->value;
+
 	if (unset)
-		decoration_style =3D 0;
+		cfg->decoration_style =3D 0;
 	else if (arg)
-		decoration_style =3D parse_decoration_style(arg);
+		cfg->decoration_style =3D parse_decoration_style(arg);
 	else
-		decoration_style =3D DECORATE_SHORT_REFS;
+		cfg->decoration_style =3D DECORATE_SHORT_REFS;
=20
-	if (decoration_style < 0)
+	if (cfg->decoration_style < 0)
 		die(_("invalid --decorate option: %s"), arg);
=20
-	decoration_given =3D 1;
+	cfg->decoration_given =3D 1;
=20
 	return 0;
 }
@@ -160,32 +181,26 @@ static int log_line_range_callback(const struct optio=
n *option, const char *arg,
 	return 0;
 }
=20
-static void init_log_defaults(void)
+static void cmd_log_init_defaults(struct rev_info *rev,
+				  struct log_config *cfg)
 {
-	init_diff_ui_defaults();
-
-	decoration_style =3D auto_decoration_style();
-}
-
-static void cmd_log_init_defaults(struct rev_info *rev)
-{
-	if (fmt_pretty)
-		get_commit_format(fmt_pretty, rev);
-	if (default_follow)
+	if (cfg->fmt_pretty)
+		get_commit_format(cfg->fmt_pretty, rev);
+	if (cfg->default_follow)
 		rev->diffopt.flags.default_follow_renames =3D 1;
 	rev->verbose_header =3D 1;
 	init_diffstat_widths(&rev->diffopt);
 	rev->diffopt.flags.recursive =3D 1;
 	rev->diffopt.flags.allow_textconv =3D 1;
-	rev->abbrev_commit =3D default_abbrev_commit;
-	rev->show_root_diff =3D default_show_root;
-	rev->subject_prefix =3D fmt_patch_subject_prefix;
-	rev->patch_name_max =3D fmt_patch_name_max;
-	rev->show_signature =3D default_show_signature;
-	rev->encode_email_headers =3D default_encode_email_headers;
+	rev->abbrev_commit =3D cfg->default_abbrev_commit;
+	rev->show_root_diff =3D cfg->default_show_root;
+	rev->subject_prefix =3D cfg->fmt_patch_subject_prefix;
+	rev->patch_name_max =3D cfg->fmt_patch_name_max;
+	rev->show_signature =3D cfg->default_show_signature;
+	rev->encode_email_headers =3D cfg->default_encode_email_headers;
=20
-	if (default_date_mode)
-		parse_date_format(default_date_mode, &rev->date_mode);
+	if (cfg->default_date_mode)
+		parse_date_format(cfg->default_date_mode, &rev->date_mode);
 }
=20
 static void set_default_decoration_filter(struct decoration_filter *decora=
tion_filter)
@@ -233,7 +248,8 @@ static void set_default_decoration_filter(struct decora=
tion_filter *decoration_f
 }
=20
 static void cmd_log_init_finish(int argc, const char **argv, const char *p=
refix,
-			 struct rev_info *rev, struct setup_revision_opt *opt)
+			 struct rev_info *rev, struct setup_revision_opt *opt,
+			 struct log_config *cfg)
 {
 	struct userformat_want w;
 	int quiet =3D 0, source =3D 0, mailmap;
@@ -258,7 +274,7 @@ static void cmd_log_init_finish(int argc, const char **=
argv, const char *prefix,
 				N_("pattern"), N_("only decorate refs that match <pattern>")),
 		OPT_STRING_LIST(0, "decorate-refs-exclude", &decorate_refs_exclude,
 				N_("pattern"), N_("do not decorate refs that match <pattern>")),
-		OPT_CALLBACK_F(0, "decorate", NULL, NULL, N_("decorate options"),
+		OPT_CALLBACK_F(0, "decorate", cfg, NULL, N_("decorate options"),
 			       PARSE_OPT_OPTARG, decorate_callback),
 		OPT_CALLBACK('L', NULL, &line_cb, "range:file",
 			     N_("trace the evolution of line range <start>,<end> or function :<=
funcname> in <file>"),
@@ -269,7 +285,7 @@ static void cmd_log_init_finish(int argc, const char **=
argv, const char *prefix,
 	line_cb.rev =3D rev;
 	line_cb.prefix =3D prefix;
=20
-	mailmap =3D use_mailmap_config;
+	mailmap =3D cfg->use_mailmap_config;
 	argc =3D parse_options(argc, argv, prefix,
 			     builtin_log_options, builtin_log_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT |
@@ -314,8 +330,8 @@ static void cmd_log_init_finish(int argc, const char **=
argv, const char *prefix,
 		 * "log --pretty=3Draw" is special; ignore UI oriented
 		 * configuration variables such as decoration.
 		 */
-		if (!decoration_given)
-			decoration_style =3D 0;
+		if (!cfg->decoration_given)
+			cfg->decoration_style =3D 0;
 		if (!rev->abbrev_commit_given)
 			rev->abbrev_commit =3D 0;
 	}
@@ -326,24 +342,24 @@ static void cmd_log_init_finish(int argc, const char =
**argv, const char *prefix,
 			 * Disable decoration loading if the format will not
 			 * show them anyway.
 			 */
-			decoration_style =3D 0;
-		} else if (!decoration_style) {
+			cfg->decoration_style =3D 0;
+		} else if (!cfg->decoration_style) {
 			/*
 			 * If we are going to show them, make sure we do load
 			 * them here, but taking care not to override a
 			 * specific style set by config or --decorate.
 			 */
-			decoration_style =3D DECORATE_SHORT_REFS;
+			cfg->decoration_style =3D DECORATE_SHORT_REFS;
 		}
 	}
=20
-	if (decoration_style || rev->simplify_by_decoration) {
+	if (cfg->decoration_style || rev->simplify_by_decoration) {
 		set_default_decoration_filter(&decoration_filter);
=20
-		if (decoration_style)
+		if (cfg->decoration_style)
 			rev->show_decorations =3D 1;
=20
-		load_ref_decorations(&decoration_filter, decoration_style);
+		load_ref_decorations(&decoration_filter, cfg->decoration_style);
 	}
=20
 	if (rev->line_level_traverse)
@@ -353,16 +369,11 @@ static void cmd_log_init_finish(int argc, const char =
**argv, const char *prefix,
 }
=20
 static void cmd_log_init(int argc, const char **argv, const char *prefix,
-			 struct rev_info *rev, struct setup_revision_opt *opt)
+			 struct rev_info *rev, struct setup_revision_opt *opt,
+			 struct log_config *cfg)
 {
-	cmd_log_init_defaults(rev);
-	cmd_log_init_finish(argc, argv, prefix, rev, opt);
-}
-
-static int cmd_log_deinit(int ret, struct rev_info *rev)
-{
-	release_revisions(rev);
-	return ret;
+	cmd_log_init_defaults(rev, cfg);
+	cmd_log_init_finish(argc, argv, prefix, rev, opt, cfg);
 }
=20
 /*
@@ -566,30 +577,37 @@ static int cmd_log_walk(struct rev_info *rev)
 static int git_log_config(const char *var, const char *value,
 			  const struct config_context *ctx, void *cb)
 {
+	struct log_config *cfg =3D cb;
 	const char *slot_name;
=20
-	if (!strcmp(var, "format.pretty"))
-		return git_config_string(&fmt_pretty, var, value);
-	if (!strcmp(var, "format.subjectprefix"))
-		return git_config_string(&fmt_patch_subject_prefix, var, value);
+	if (!strcmp(var, "format.pretty")) {
+		FREE_AND_NULL(cfg->fmt_pretty);
+		return git_config_string((const char **) &cfg->fmt_pretty, var, value);
+	}
+	if (!strcmp(var, "format.subjectprefix")) {
+		FREE_AND_NULL(cfg->fmt_patch_subject_prefix);
+		return git_config_string((const char **) &cfg->fmt_patch_subject_prefix,=
 var, value);
+	}
 	if (!strcmp(var, "format.filenamemaxlength")) {
-		fmt_patch_name_max =3D git_config_int(var, value, ctx->kvi);
+		cfg->fmt_patch_name_max =3D git_config_int(var, value, ctx->kvi);
 		return 0;
 	}
 	if (!strcmp(var, "format.encodeemailheaders")) {
-		default_encode_email_headers =3D git_config_bool(var, value);
+		cfg->default_encode_email_headers =3D git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "log.abbrevcommit")) {
-		default_abbrev_commit =3D git_config_bool(var, value);
+		cfg->default_abbrev_commit =3D git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "log.date"))
-		return git_config_string(&default_date_mode, var, value);
+	if (!strcmp(var, "log.date")) {
+		FREE_AND_NULL(cfg->default_date_mode);
+		return git_config_string((const char **) &cfg->default_date_mode, var, v=
alue);
+	}
 	if (!strcmp(var, "log.decorate")) {
-		decoration_style =3D parse_decoration_style(value);
-		if (decoration_style < 0)
-			decoration_style =3D 0; /* maybe warn? */
+		cfg->decoration_style =3D parse_decoration_style(value);
+		if (cfg->decoration_style < 0)
+			cfg->decoration_style =3D 0; /* maybe warn? */
 		return 0;
 	}
 	if (!strcmp(var, "log.diffmerges")) {
@@ -598,21 +616,21 @@ static int git_log_config(const char *var, const char=
 *value,
 		return diff_merges_config(value);
 	}
 	if (!strcmp(var, "log.showroot")) {
-		default_show_root =3D git_config_bool(var, value);
+		cfg->default_show_root =3D git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "log.follow")) {
-		default_follow =3D git_config_bool(var, value);
+		cfg->default_follow =3D git_config_bool(var, value);
 		return 0;
 	}
 	if (skip_prefix(var, "color.decorate.", &slot_name))
 		return parse_decorate_color_config(var, slot_name, value);
 	if (!strcmp(var, "log.mailmap")) {
-		use_mailmap_config =3D git_config_bool(var, value);
+		cfg->use_mailmap_config =3D git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "log.showsignature")) {
-		default_show_signature =3D git_config_bool(var, value);
+		cfg->default_show_signature =3D git_config_bool(var, value);
 		return 0;
 	}
=20
@@ -621,11 +639,14 @@ static int git_log_config(const char *var, const char=
 *value,
=20
 int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 {
+	struct log_config cfg;
 	struct rev_info rev;
 	struct setup_revision_opt opt;
+	int ret;
=20
-	init_log_defaults();
-	git_config(git_log_config, NULL);
+	log_config_init(&cfg);
+	init_diff_ui_defaults();
+	git_config(git_log_config, &cfg);
=20
 	repo_init_revisions(the_repository, &rev, prefix);
 	git_config(grep_config, &rev.grep_filter);
@@ -635,10 +656,15 @@ int cmd_whatchanged(int argc, const char **argv, cons=
t char *prefix)
 	memset(&opt, 0, sizeof(opt));
 	opt.def =3D "HEAD";
 	opt.revarg_opt =3D REVARG_COMMITTISH;
-	cmd_log_init(argc, argv, prefix, &rev, &opt);
+	cmd_log_init(argc, argv, prefix, &rev, &opt, &cfg);
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format =3D DIFF_FORMAT_RAW;
-	return cmd_log_deinit(cmd_log_walk(&rev), &rev);
+
+	ret =3D cmd_log_walk(&rev);
+
+	release_revisions(&rev);
+	log_config_release(&cfg);
+	return ret;
 }
=20
 static void show_tagger(const char *buf, struct rev_info *rev)
@@ -733,14 +759,16 @@ static void show_setup_revisions_tweak(struct rev_inf=
o *rev)
=20
 int cmd_show(int argc, const char **argv, const char *prefix)
 {
+	struct log_config cfg;
 	struct rev_info rev;
 	unsigned int i;
 	struct setup_revision_opt opt;
 	struct pathspec match_all;
 	int ret =3D 0;
=20
-	init_log_defaults();
-	git_config(git_log_config, NULL);
+	log_config_init(&cfg);
+	init_diff_ui_defaults();
+	git_config(git_log_config, &cfg);
=20
 	if (the_repository->gitdir) {
 		prepare_repo_settings(the_repository);
@@ -759,10 +787,14 @@ int cmd_show(int argc, const char **argv, const char =
*prefix)
 	memset(&opt, 0, sizeof(opt));
 	opt.def =3D "HEAD";
 	opt.tweak =3D show_setup_revisions_tweak;
-	cmd_log_init(argc, argv, prefix, &rev, &opt);
+	cmd_log_init(argc, argv, prefix, &rev, &opt, &cfg);
=20
-	if (!rev.no_walk)
-		return cmd_log_deinit(cmd_log_walk(&rev), &rev);
+	if (!rev.no_walk) {
+		ret =3D cmd_log_walk(&rev);
+		release_revisions(&rev);
+		log_config_release(&cfg);
+		return ret;
+	}
=20
 	rev.diffopt.no_free =3D 1;
 	for (i =3D 0; i < rev.pending.nr && !ret; i++) {
@@ -832,8 +864,10 @@ int cmd_show(int argc, const char **argv, const char *=
prefix)
=20
 	rev.diffopt.no_free =3D 0;
 	diff_free(&rev.diffopt);
+	release_revisions(&rev);
+	log_config_release(&cfg);
=20
-	return cmd_log_deinit(ret, &rev);
+	return ret;
 }
=20
 /*
@@ -841,11 +875,14 @@ int cmd_show(int argc, const char **argv, const char =
*prefix)
  */
 int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 {
+	struct log_config cfg;
 	struct rev_info rev;
 	struct setup_revision_opt opt;
+	int ret;
=20
-	init_log_defaults();
-	git_config(git_log_config, NULL);
+	log_config_init(&cfg);
+	init_diff_ui_defaults();
+	git_config(git_log_config, &cfg);
=20
 	repo_init_revisions(the_repository, &rev, prefix);
 	init_reflog_walk(&rev.reflog_info);
@@ -854,14 +891,18 @@ int cmd_log_reflog(int argc, const char **argv, const=
 char *prefix)
 	rev.verbose_header =3D 1;
 	memset(&opt, 0, sizeof(opt));
 	opt.def =3D "HEAD";
-	cmd_log_init_defaults(&rev);
+	cmd_log_init_defaults(&rev, &cfg);
 	rev.abbrev_commit =3D 1;
 	rev.commit_format =3D CMIT_FMT_ONELINE;
 	rev.use_terminator =3D 1;
 	rev.always_show_header =3D 1;
-	cmd_log_init_finish(argc, argv, prefix, &rev, &opt);
+	cmd_log_init_finish(argc, argv, prefix, &rev, &opt, &cfg);
+
+	ret =3D cmd_log_walk(&rev);
=20
-	return cmd_log_deinit(cmd_log_walk(&rev), &rev);
+	release_revisions(&rev);
+	log_config_release(&cfg);
+	return ret;
 }
=20
 static void log_setup_revisions_tweak(struct rev_info *rev)
@@ -876,11 +917,14 @@ static void log_setup_revisions_tweak(struct rev_info=
 *rev)
=20
 int cmd_log(int argc, const char **argv, const char *prefix)
 {
+	struct log_config cfg;
 	struct rev_info rev;
 	struct setup_revision_opt opt;
+	int ret;
=20
-	init_log_defaults();
-	git_config(git_log_config, NULL);
+	log_config_init(&cfg);
+	init_diff_ui_defaults();
+	git_config(git_log_config, &cfg);
=20
 	repo_init_revisions(the_repository, &rev, prefix);
 	git_config(grep_config, &rev.grep_filter);
@@ -890,8 +934,13 @@ int cmd_log(int argc, const char **argv, const char *p=
refix)
 	opt.def =3D "HEAD";
 	opt.revarg_opt =3D REVARG_COMMITTISH;
 	opt.tweak =3D log_setup_revisions_tweak;
-	cmd_log_init(argc, argv, prefix, &rev, &opt);
-	return cmd_log_deinit(cmd_log_walk(&rev), &rev);
+	cmd_log_init(argc, argv, prefix, &rev, &opt, &cfg);
+
+	ret =3D cmd_log_walk(&rev);
+
+	release_revisions(&rev);
+	log_config_release(&cfg);
+	return ret;
 }
=20
 /* format-patch */
@@ -1884,6 +1933,7 @@ static void infer_range_diff_ranges(struct strbuf *r1,
=20
 int cmd_format_patch(int argc, const char **argv, const char *prefix)
 {
+	struct log_config cfg;
 	struct commit *commit;
 	struct commit **list =3D NULL;
 	struct rev_info rev;
@@ -1943,7 +1993,7 @@ int cmd_format_patch(int argc, const char **argv, con=
st char *prefix)
 			    N_("start numbering patches at <n> instead of 1")),
 		OPT_STRING('v', "reroll-count", &reroll_count, N_("reroll-count"),
 			    N_("mark the series as Nth re-roll")),
-		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
+		OPT_INTEGER(0, "filename-max-length", &cfg.fmt_patch_name_max,
 			    N_("max length of output filename")),
 		OPT_CALLBACK_F(0, "rfc", &rfc, N_("rfc"),
 			       N_("add <rfc> (default 'RFC') before 'PATCH'"),
@@ -2017,16 +2067,17 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 	extra_to.strdup_strings =3D 1;
 	extra_cc.strdup_strings =3D 1;
=20
-	init_log_defaults();
+	log_config_init(&cfg);
+	init_diff_ui_defaults();
 	init_display_notes(&notes_opt);
-	git_config(git_format_config, NULL);
+	git_config(git_format_config, &cfg);
 	repo_init_revisions(the_repository, &rev, prefix);
 	git_config(grep_config, &rev.grep_filter);
=20
 	rev.show_notes =3D show_notes;
 	memcpy(&rev.notes_opt, &notes_opt, sizeof(notes_opt));
 	rev.commit_format =3D CMIT_FMT_EMAIL;
-	rev.encode_email_headers =3D default_encode_email_headers;
+	rev.encode_email_headers =3D cfg.default_encode_email_headers;
 	rev.expand_tabs_in_log_default =3D 0;
 	rev.verbose_header =3D 1;
 	rev.diff =3D 1;
@@ -2037,7 +2088,7 @@ int cmd_format_patch(int argc, const char **argv, con=
st char *prefix)
 	s_r_opt.def =3D "HEAD";
 	s_r_opt.revarg_opt =3D REVARG_COMMITTISH;
=20
-	strbuf_addstr(&sprefix, fmt_patch_subject_prefix);
+	strbuf_addstr(&sprefix, cfg.fmt_patch_subject_prefix);
 	if (format_no_prefix)
 		diff_set_noprefix(&rev.diffopt);
=20
@@ -2059,8 +2110,8 @@ int cmd_format_patch(int argc, const char **argv, con=
st char *prefix)
 	rev.force_in_body_from =3D force_in_body_from;
=20
 	/* Make sure "0000-$sub.patch" gives non-negative length for $sub */
-	if (fmt_patch_name_max <=3D strlen("0000-") + strlen(fmt_patch_suffix))
-		fmt_patch_name_max =3D strlen("0000-") + strlen(fmt_patch_suffix);
+	if (cfg.fmt_patch_name_max <=3D strlen("0000-") + strlen(fmt_patch_suffix=
))
+		cfg.fmt_patch_name_max =3D strlen("0000-") + strlen(fmt_patch_suffix);
=20
 	if (cover_from_description_arg)
 		cover_from_description_mode =3D parse_cover_from_description(cover_from_=
description_arg);
@@ -2156,7 +2207,7 @@ int cmd_format_patch(int argc, const char **argv, con=
st char *prefix)
 	rev.always_show_header =3D 1;
=20
 	rev.zero_commit =3D zero_commit;
-	rev.patch_name_max =3D fmt_patch_name_max;
+	rev.patch_name_max =3D cfg.fmt_patch_name_max;
=20
 	if (!rev.diffopt.flags.text && !no_binary_diff)
 		rev.diffopt.flags.binary =3D 1;
@@ -2450,7 +2501,9 @@ int cmd_format_patch(int argc, const char **argv, con=
st char *prefix)
 	if (rev.ref_message_ids)
 		string_list_clear(rev.ref_message_ids, 0);
 	free(rev.ref_message_ids);
-	return cmd_log_deinit(0, &rev);
+	release_revisions(&rev);
+	log_config_release(&cfg);
+	return 0;
 }
=20
 static int add_pending_commit(const char *arg, struct rev_info *revs, int =
flags)
--=20
2.45.1.216.g4365c6fcf9.dirty


--mJa6B+FWR9bLwN/S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQZg0ACgkQVbJhu7ck
PpQaWg/+O87lXFmy7z8JzQ2zCYh4eLz4gddTKGn37rdwSNce4hooySbcyyUS6mwj
d5zDiNOF87zHU8slAbbsO39JBvB10BOH48egEkgRtnaMtcnTJIb4C9YM+6gA2lkH
MkLI1/O1WicC5GiEyFSVzBuV8sAlCa8Btr1ePJmrWdcfX+HWJWmVTbB4RrNhQyT+
JRxFCTrBAUriQb9hLtoMWhOogRAcKzKlq8fVjXfT+J9tEK6AiZht4VME3Zv9f8u+
X/6thxlyD/k2AJQO/a/2hxqxjr8yYsImwFnmpyLA2iR1T6Rk5cyVxgQIK7XKlZAO
vQM6fefrBYy6ujJEXAqMfK4NsKg2MnzGb9QCuxNOI+XIoVggm/FuS8u0zfqdLRL3
LAP2j5vf4t+oQEZOiNbqeCQqeTZxRByJAVsZAjT78T9bGNV6Q9Jcc8PPoeZe7qmt
xUlgc3Ol9+DaYdqEOhUfKS0OaWBTIFjJYJ1ducBpCbhrWCR8vmL8/LlHubhBWVmu
Jp7gPg8jQ/mlqZkZFdSeSYZh5KYlUP9UPo1qAow0vDsYnS5/TVS+uPvsM05e5Zzv
h7EEHv6yy5I57+gajDzUvZiWVPJfglCUfxAuNspZVmjRIQBLRfYqcw98iSBs99+s
I1usCgjWlT4ZT5ZwffIRA+FQBGzMtJWEMHUcQRZd0iikBLZOVF8=
=hMfm
-----END PGP SIGNATURE-----

--mJa6B+FWR9bLwN/S--
