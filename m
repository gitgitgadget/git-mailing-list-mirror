Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A84414A097
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595776; cv=none; b=Q4/rnQDjzi//baEJny8n0PtCM6Au7/YU3I94HlLoiNS4pVU9qYnlINEOTbRidXpM/0huEzWCEXJMUZALbZw6Ewsp9FFGM5CYh85drFudlyysKCVsNGI6pqCPOxijX9igo2ZpJMqEOQyjHnEhXZzomYfDfgF13P6092sAEmmbKTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595776; c=relaxed/simple;
	bh=0Y0olY73uw+h+g60v07DeJbsRiK0DhvevSF4Z+zlrK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFYfM93B71STTiEgHE566IheLLL2yW/A/9bbN17Z0bsRBEv5vy8oG3BAP7HoSM0oFQ+aZBB4h/VnE5Qo6dwmYZbvf29+eaPuAx6+53cPPa2/SHXn1iVvGilDvyaHFWi7bprfsRKqsz8CuB1mCSDdElGLTZWQ5eIgVRJQWj3ztg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bxwz6bK7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O69mHQ7w; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bxwz6bK7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O69mHQ7w"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 6A6181C0009A;
	Mon, 13 May 2024 06:22:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 13 May 2024 06:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595773; x=1715682173; bh=qM3lgkDQ+H
	UVnXpul4lK0qpNm5LUlyI2bgdZ5H5r0yg=; b=bxwz6bK79Qa6f6e56Yc7p8vOBI
	DlCRJ0eSC6q/V13RcUtWOysWXDduhBiz2Xgv0cWcka2SXT7uU5wuzAeZBHukGRkL
	CSk2pnzq0jT69Zxo0GgrnufkObZbBO+yYdhUE2siD5C3qVlds3vySh6OYf9dam6A
	RCM/0xqm3WhZg98CxQ3noyYoDN7x3yFeQkH3s73R10Tl/srmBMZTOEBr8QjffhiT
	rwvS3I+JTMrXMOVKXxYdJSP1nKkROefFxarcrbNXjsAv1NFQ4h2s4s+pxa4uLG2x
	B0HJiDfFfDE5eLegWuBQKpyw4z8GXljgxSC+7BDZVBWFg3lTWdjyL2OlI4kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595773; x=1715682173; bh=qM3lgkDQ+HUVnXpul4lK0qpNm5LU
	lyI2bgdZ5H5r0yg=; b=O69mHQ7wvMSf2kchpeZQRHBB/byvDmYZ5zC7sDmrxtE4
	fr+seMCry8SiSrm8mmYpxGeo+e0gLggS32D3i4y26yFbBr0KUm3xdeTWHKW5o9Xi
	WPvHesGXqVyIuHaFKCDyGtirTCG7XGum+As4cIfXOjaerH4pydJDrYwXXRdooWXo
	50Nr5XkLDbd76iKIZH8JHodhPyShI/TBX5lKxk8InSZrSK4JHVe/WcC314Bony06
	ybzTqO4ZHRLbGFd1GcaI0gplxN4N5YZaOUE08WMXzhix8xADX9ufm84GIKCHRGuA
	m4pSbPrPNkjqEpDjstxN0MO6rYw5/N+0GEPkUEN//g==
X-ME-Sender: <xms:_OlBZkZ_TiGaVfhC5XRDUO_9qJgL2mS00o8OhE3UHuGzCt5ax_Wp-w>
    <xme:_OlBZvYwQwV-2bUpNWrpED-P1vwEGX4bWzIJnp_eooJI13Qg8MgTu7YXr6KN1XsyH
    AAr4CVsMP8Dt_iAZQ>
X-ME-Received: <xmr:_OlBZu80wQm4-2tx-izR1QHzZAjcUzJY92NzGfpjQTTc4svMEOBklQUwIH3NL_Oi_mHUohkydG2AUieRFoSPUFrBmTaH5D28MLE9B5RcsJQPTQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:_OlBZuqvCRBx3UMH9Dz5ZbYpvDKtpkpg7RUqry9atMiF75-3t0TxwQ>
    <xmx:_OlBZvrmJ9w2d7dNgjJBf0vGTnetzuE-dgqDX_m-6kHjrATeFw9XXQ>
    <xmx:_OlBZsSQ4NFDIeeD6Uu91vW6S1YCRB9I_c3ZPWUZKPCeLyjVuLHUmA>
    <xmx:_OlBZvpM-_0zzgrhGXSMsNLjPG1QtiaOIkDXVY4u2c7x0--DJ9TByA>
    <xmx:_elBZgnBR43FV509p7480SUzZojg5XcKOHr_5xfQNnUgA3w0sM4F-1PU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:22:51 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4a33adbf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:22:32 +0000 (UTC)
Date: Mon, 13 May 2024 12:22:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 10/21] builtin/config: move display options into local
 variables
Message-ID: <d66e14af30062a0d5acfb51d02cdc072f8336f2f.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fDViYqr5apx/vVUl"
Content-Disposition: inline
In-Reply-To: <cover.1715595550.git.ps@pks.im>


--fDViYqr5apx/vVUl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The display options are tracked via a set of global variables. Move
them into a self-contained structure so that we can easily parse all
relevant options and hand them over to the various functions that
require them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 171 ++++++++++++++++++++++++++++-------------------
 1 file changed, 101 insertions(+), 70 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index c309497e23..24ad8e7476 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -81,25 +81,42 @@ struct config_location_options {
 };
 #define CONFIG_LOCATION_OPTIONS_INIT {0}
=20
+#define CONFIG_DISPLAY_OPTIONS(opts) \
+	OPT_GROUP(N_("Display options")), \
+	OPT_BOOL('z', "null", &opts.end_nul, N_("terminate values with NUL byte")=
), \
+	OPT_BOOL(0, "name-only", &opts.omit_values, N_("show variable names only"=
)), \
+	OPT_BOOL(0, "show-origin", &opts.show_origin, N_("show origin of config (=
file, standard input, blob, command line)")), \
+	OPT_BOOL(0, "show-scope", &opts.show_scope, N_("show scope of config (wor=
ktree, local, global, system, command)")), \
+	OPT_BOOL(0, "show-names", &opts.show_keys, N_("show config keys in additi=
on to their values"))
+
+struct config_display_options {
+	int end_nul;
+	int omit_values;
+	int show_origin;
+	int show_scope;
+	int show_keys;
+	/* Populated via `display_options_init()`. */
+	int term;
+	int delim;
+	int key_delim;
+};
+#define CONFIG_DISPLAY_OPTIONS_INIT { \
+	.term =3D '\n', \
+	.delim =3D '=3D', \
+	.key_delim =3D ' ', \
+}
+
 static char *key;
 static regex_t *key_regexp;
 static const char *value_pattern;
 static regex_t *regexp;
-static int show_keys;
-static int omit_values;
 static int use_key_regexp;
 static int do_all;
 static int do_not_match;
-static char delim =3D '=3D';
-static char key_delim =3D ' ';
-static char term =3D '\n';
=20
 static int type;
 static char *default_value;
-static int end_nul;
 static int respect_includes_opt =3D -1;
-static int show_origin;
-static int show_scope;
 static int fixed_value;
=20
 #define TYPE_BOOL		1
@@ -177,24 +194,26 @@ static void check_argc(int argc, int min, int max)
 	exit(129);
 }
=20
-static void show_config_origin(const struct key_value_info *kvi,
+static void show_config_origin(const struct config_display_options *opts,
+			       const struct key_value_info *kvi,
 			       struct strbuf *buf)
 {
-	const char term =3D end_nul ? '\0' : '\t';
+	const char term =3D opts->end_nul ? '\0' : '\t';
=20
 	strbuf_addstr(buf, config_origin_type_name(kvi->origin_type));
 	strbuf_addch(buf, ':');
-	if (end_nul)
+	if (opts->end_nul)
 		strbuf_addstr(buf, kvi->filename ? kvi->filename : "");
 	else
 		quote_c_style(kvi->filename ? kvi->filename : "", buf, NULL, 0);
 	strbuf_addch(buf, term);
 }
=20
-static void show_config_scope(const struct key_value_info *kvi,
+static void show_config_scope(const struct config_display_options *opts,
+			      const struct key_value_info *kvi,
 			      struct strbuf *buf)
 {
-	const char term =3D end_nul ? '\0' : '\t';
+	const char term =3D opts->end_nul ? '\0' : '\t';
 	const char *scope =3D config_scope_name(kvi->scope);
=20
 	strbuf_addstr(buf, N_(scope));
@@ -203,24 +222,25 @@ static void show_config_scope(const struct key_value_=
info *kvi,
=20
 static int show_all_config(const char *key_, const char *value_,
 			   const struct config_context *ctx,
-			   void *cb UNUSED)
+			   void *cb)
 {
+	const struct config_display_options *opts =3D cb;
 	const struct key_value_info *kvi =3D ctx->kvi;
=20
-	if (show_origin || show_scope) {
+	if (opts->show_origin || opts->show_scope) {
 		struct strbuf buf =3D STRBUF_INIT;
-		if (show_scope)
-			show_config_scope(kvi, &buf);
-		if (show_origin)
-			show_config_origin(kvi, &buf);
+		if (opts->show_scope)
+			show_config_scope(opts, kvi, &buf);
+		if (opts->show_origin)
+			show_config_origin(opts, kvi, &buf);
 		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
 		fwrite(buf.buf, 1, buf.len, stdout);
 		strbuf_release(&buf);
 	}
-	if (!omit_values && value_)
-		printf("%s%c%s%c", key_, delim, value_, term);
+	if (!opts->omit_values && value_)
+		printf("%s%c%s%c", key_, opts->delim, value_, opts->term);
 	else
-		printf("%s%c", key_, term);
+		printf("%s%c", key_, opts->term);
 	return 0;
 }
=20
@@ -230,18 +250,19 @@ struct strbuf_list {
 	int alloc;
 };
=20
-static int format_config(struct strbuf *buf, const char *key_,
+static int format_config(const struct config_display_options *opts,
+			 struct strbuf *buf, const char *key_,
 			 const char *value_, const struct key_value_info *kvi)
 {
-	if (show_scope)
-		show_config_scope(kvi, buf);
-	if (show_origin)
-		show_config_origin(kvi, buf);
-	if (show_keys)
+	if (opts->show_scope)
+		show_config_scope(opts, kvi, buf);
+	if (opts->show_origin)
+		show_config_origin(opts, kvi, buf);
+	if (opts->show_keys)
 		strbuf_addstr(buf, key_);
-	if (!omit_values) {
-		if (show_keys)
-			strbuf_addch(buf, key_delim);
+	if (!opts->omit_values) {
+		if (opts->show_keys)
+			strbuf_addch(buf, opts->key_delim);
=20
 		if (type =3D=3D TYPE_INT)
 			strbuf_addf(buf, "%"PRId64,
@@ -283,18 +304,24 @@ static int format_config(struct strbuf *buf, const ch=
ar *key_,
 			strbuf_addstr(buf, value_);
 		} else {
 			/* Just show the key name; back out delimiter */
-			if (show_keys)
+			if (opts->show_keys)
 				strbuf_setlen(buf, buf->len - 1);
 		}
 	}
-	strbuf_addch(buf, term);
+	strbuf_addch(buf, opts->term);
 	return 0;
 }
=20
+struct collect_config_data {
+	const struct config_display_options *display_opts;
+	struct strbuf_list *values;
+};
+
 static int collect_config(const char *key_, const char *value_,
 			  const struct config_context *ctx, void *cb)
 {
-	struct strbuf_list *values =3D cb;
+	struct collect_config_data *data =3D cb;
+	struct strbuf_list *values =3D data->values;
 	const struct key_value_info *kvi =3D ctx->kvi;
=20
 	if (!use_key_regexp && strcmp(key_, key))
@@ -310,14 +337,20 @@ static int collect_config(const char *key_, const cha=
r *value_,
 	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
 	strbuf_init(&values->items[values->nr], 0);
=20
-	return format_config(&values->items[values->nr++], key_, value_, kvi);
+	return format_config(data->display_opts, &values->items[values->nr++],
+			     key_, value_, kvi);
 }
=20
 static int get_value(const struct config_location_options *opts,
+		     const struct config_display_options *display_opts,
 		     const char *key_, const char *regex_, unsigned flags)
 {
 	int ret =3D CONFIG_GENERIC_ERROR;
 	struct strbuf_list values =3D {NULL};
+	struct collect_config_data data =3D {
+		.display_opts =3D display_opts,
+		.values =3D &values,
+	};
 	int i;
=20
 	if (use_key_regexp) {
@@ -368,7 +401,7 @@ static int get_value(const struct config_location_optio=
ns *opts,
 		}
 	}
=20
-	config_with_options(collect_config, &values,
+	config_with_options(collect_config, &data,
 			    &opts->source, the_repository,
 			    &opts->options);
=20
@@ -380,7 +413,7 @@ static int get_value(const struct config_location_optio=
ns *opts,
 		ALLOC_GROW(values.items, values.nr + 1, values.alloc);
 		item =3D &values.items[values.nr++];
 		strbuf_init(item, 0);
-		if (format_config(item, key_, default_value, &kvi) < 0)
+		if (format_config(display_opts, item, key_, default_value, &kvi) < 0)
 			die(_("failed to format default config value: %s"),
 				default_value);
 	}
@@ -591,10 +624,12 @@ static int urlmatch_collect_fn(const char *var, const=
 char *value,
 }
=20
 static int get_urlmatch(const struct config_location_options *opts,
+			const struct config_display_options *_display_opts,
 			const char *var, const char *url)
 {
 	int ret;
 	char *section_tail;
+	struct config_display_options display_opts =3D *_display_opts;
 	struct string_list_item *item;
 	struct urlmatch_config config =3D URLMATCH_CONFIG_INIT;
 	struct string_list values =3D STRING_LIST_INIT_DUP;
@@ -611,10 +646,10 @@ static int get_urlmatch(const struct config_location_=
options *opts,
 	if (section_tail) {
 		*section_tail =3D '\0';
 		config.key =3D section_tail + 1;
-		show_keys =3D 0;
+		display_opts.show_keys =3D 0;
 	} else {
 		config.key =3D NULL;
-		show_keys =3D 1;
+		display_opts.show_keys =3D 1;
 	}
=20
 	config_with_options(urlmatch_config_entry, &config,
@@ -627,7 +662,7 @@ static int get_urlmatch(const struct config_location_op=
tions *opts,
 		struct urlmatch_current_candidate_value *matched =3D item->util;
 		struct strbuf buf =3D STRBUF_INIT;
=20
-		format_config(&buf, item->string,
+		format_config(&display_opts, &buf, item->string,
 			      matched->value_is_null ? NULL : matched->value.buf,
 			      &matched->kvi);
 		fwrite(buf.buf, 1, buf.len, stdout);
@@ -743,11 +778,12 @@ static void location_options_release(struct config_lo=
cation_options *opts)
 	free((char *) opts->source.file);
 }
=20
-static void handle_nul(void) {
-	if (end_nul) {
-		term =3D '\0';
-		delim =3D '\n';
-		key_delim =3D '\n';
+static void display_options_init(struct config_display_options *opts)
+{
+	if (opts->end_nul) {
+		opts->term =3D '\0';
+		opts->delim =3D '\n';
+		opts->key_delim =3D '\n';
 	}
 }
=20
@@ -761,19 +797,13 @@ static void handle_nul(void) {
 	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directo=
ry name)"), TYPE_PATH), \
 	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date")=
, TYPE_EXPIRY_DATE)
=20
-#define CONFIG_DISPLAY_OPTIONS \
-	OPT_GROUP(N_("Display options")), \
-	OPT_BOOL('z', "null", &end_nul, N_("terminate values with NUL byte")), \
-	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")), \
-	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file,=
 standard input, blob, command line)")), \
-	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree=
, local, global, system, command)"))
-
 static int cmd_config_list(int argc, const char **argv, const char *prefix)
 {
 	struct config_location_options location_opts =3D CONFIG_LOCATION_OPTIONS_=
INIT;
+	struct config_display_options display_opts =3D CONFIG_DISPLAY_OPTIONS_INI=
T;
 	struct option opts[] =3D {
 		CONFIG_LOCATION_OPTIONS(location_opts),
-		CONFIG_DISPLAY_OPTIONS,
+		CONFIG_DISPLAY_OPTIONS(display_opts),
 		OPT_GROUP(N_("Other")),
 		OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direc=
tives on lookup")),
 		OPT_END(),
@@ -783,11 +813,11 @@ static int cmd_config_list(int argc, const char **arg=
v, const char *prefix)
 	check_argc(argc, 0, 0);
=20
 	location_options_init(&location_opts, prefix);
-	handle_nul();
+	display_options_init(&display_opts);
=20
 	setup_auto_pager("config", 1);
=20
-	if (config_with_options(show_all_config, NULL,
+	if (config_with_options(show_all_config, &display_opts,
 				&location_opts.source, the_repository,
 				&location_opts.options) < 0) {
 		if (location_opts.source.file)
@@ -804,6 +834,7 @@ static int cmd_config_list(int argc, const char **argv,=
 const char *prefix)
 static int cmd_config_get(int argc, const char **argv, const char *prefix)
 {
 	struct config_location_options location_opts =3D CONFIG_LOCATION_OPTIONS_=
INIT;
+	struct config_display_options display_opts =3D CONFIG_DISPLAY_OPTIONS_INI=
T;
 	const char *value_pattern =3D NULL, *url =3D NULL;
 	int flags =3D 0;
 	struct option opts[] =3D {
@@ -815,8 +846,7 @@ static int cmd_config_get(int argc, const char **argv, =
const char *prefix)
 		OPT_STRING(0, "value", &value_pattern, N_("pattern"), N_("show config wi=
th values matching the pattern")),
 		OPT_BIT(0, "fixed-value", &flags, N_("use string equality when comparing=
 values to value pattern"), CONFIG_FLAGS_FIXED_VALUE),
 		OPT_STRING(0, "url", &url, N_("URL"), N_("show config matching the given=
 URL")),
-		CONFIG_DISPLAY_OPTIONS,
-		OPT_BOOL(0, "show-names", &show_keys, N_("show config keys in addition t=
o their values")),
+		CONFIG_DISPLAY_OPTIONS(display_opts),
 		OPT_GROUP(N_("Other")),
 		OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direc=
tives on lookup")),
 		OPT_STRING(0, "default", &default_value, N_("value"), N_("use default va=
lue when missing entry")),
@@ -836,14 +866,14 @@ static int cmd_config_get(int argc, const char **argv=
, const char *prefix)
 		die(_("--url=3D cannot be used with --all, --regexp or --value"));
=20
 	location_options_init(&location_opts, prefix);
-	handle_nul();
+	display_options_init(&display_opts);
=20
 	setup_auto_pager("config", 1);
=20
 	if (url)
-		ret =3D get_urlmatch(&location_opts, argv[0], url);
+		ret =3D get_urlmatch(&location_opts, &display_opts, argv[0], url);
 	else
-		ret =3D get_value(&location_opts, argv[0], value_pattern, flags);
+		ret =3D get_value(&location_opts, &display_opts, argv[0], value_pattern,=
 flags);
=20
 	location_options_release(&location_opts);
 	return ret;
@@ -1074,6 +1104,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 		ACTION_GET_URLMATCH =3D (1<<15),
 	};
 	struct config_location_options location_opts =3D CONFIG_LOCATION_OPTIONS_=
INIT;
+	struct config_display_options display_opts =3D CONFIG_DISPLAY_OPTIONS_INI=
T;
 	const char *comment_arg =3D NULL;
 	int actions =3D 0;
 	struct option opts[] =3D {
@@ -1094,7 +1125,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 		OPT_CMDMODE(0, "get-color", &actions, N_("find the color configured: slo=
t [<default>]"), ACTION_GET_COLOR),
 		OPT_CMDMODE(0, "get-colorbool", &actions, N_("find the color setting: sl=
ot [<stdout-is-tty>]"), ACTION_GET_COLORBOOL),
 		CONFIG_TYPE_OPTIONS,
-		CONFIG_DISPLAY_OPTIONS,
+		CONFIG_DISPLAY_OPTIONS(display_opts),
 		OPT_GROUP(N_("Other")),
 		OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, us=
e default value when missing entry")),
 		OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readable c=
omment string (# will be prepended as needed)")),
@@ -1112,7 +1143,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
=20
 	location_options_init(&location_opts, prefix);
-	handle_nul();
+	display_options_init(&display_opts);
=20
 	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && type) {
 		error(_("--get-color and variable type are incoherent"));
@@ -1128,13 +1159,13 @@ static int cmd_config_actions(int argc, const char =
**argv, const char *prefix)
 			error(_("no action specified"));
 			exit(129);
 		}
-	if (omit_values &&
+	if (display_opts.omit_values &&
 	    !(actions =3D=3D ACTION_LIST || actions =3D=3D ACTION_GET_REGEXP)) {
 		error(_("--name-only is only applicable to --list or --get-regexp"));
 		exit(129);
 	}
=20
-	if (show_origin && !(actions &
+	if (display_opts.show_origin && !(actions &
 		(ACTION_GET|ACTION_GET_ALL|ACTION_GET_REGEXP|ACTION_LIST))) {
 		error(_("--show-origin is only applicable to --get, --get-all, "
 			"--get-regexp, and --list"));
@@ -1199,7 +1230,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
=20
 	if (actions =3D=3D ACTION_LIST) {
 		check_argc(argc, 0, 0);
-		if (config_with_options(show_all_config, NULL,
+		if (config_with_options(show_all_config, &display_opts,
 					&location_opts.source, the_repository,
 					&location_opts.options) < 0) {
 			if (location_opts.source.file)
@@ -1248,23 +1279,23 @@ static int cmd_config_actions(int argc, const char =
**argv, const char *prefix)
 	}
 	else if (actions =3D=3D ACTION_GET) {
 		check_argc(argc, 1, 2);
-		ret =3D get_value(&location_opts, argv[0], argv[1], flags);
+		ret =3D get_value(&location_opts, &display_opts, argv[0], argv[1], flags=
);
 	}
 	else if (actions =3D=3D ACTION_GET_ALL) {
 		do_all =3D 1;
 		check_argc(argc, 1, 2);
-		ret =3D get_value(&location_opts, argv[0], argv[1], flags);
+		ret =3D get_value(&location_opts, &display_opts, argv[0], argv[1], flags=
);
 	}
 	else if (actions =3D=3D ACTION_GET_REGEXP) {
-		show_keys =3D 1;
+		display_opts.show_keys =3D 1;
 		use_key_regexp =3D 1;
 		do_all =3D 1;
 		check_argc(argc, 1, 2);
-		ret =3D get_value(&location_opts, argv[0], argv[1], flags);
+		ret =3D get_value(&location_opts, &display_opts, argv[0], argv[1], flags=
);
 	}
 	else if (actions =3D=3D ACTION_GET_URLMATCH) {
 		check_argc(argc, 2, 2);
-		ret =3D get_urlmatch(&location_opts, argv[0], argv[1]);
+		ret =3D get_urlmatch(&location_opts, &display_opts, argv[0], argv[1]);
 	}
 	else if (actions =3D=3D ACTION_UNSET) {
 		check_write(&location_opts.source);
--=20
2.45.GIT


--fDViYqr5apx/vVUl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6fgACgkQVbJhu7ck
PpQjpQ//R/nTBXwlDfyAv7hvs4jfS7e16moqWe4QoU55yXee6NAC3LCrs0kCIPYL
sj6kFRwL6GdWZUpMyQRMWSmY8anTHQTdwKeRy0nHOfHRneRX/te9HJqkEVV82bo1
CPM3ck+jY6z5/NzPJmHunAmav4NLmphuDwlH9G+1AWTurXyVTskEFYXVbYkmeJ4C
rVKgXwDwLyJK2Vk0u5Uv2OU734kpxLqNJzcMUH6gm55j7T8HFb75yS1yzquhO1t0
F32t5/EIaSQSJvzMVhtxwAOB288LR4nfwjN+kOEI7vWyYdI0a0NQK9xczr9nkIl0
+wJqs14/yhHeqxvYp7ajSR0HWeCKzBDBsAvKuQYRqgs4lDkGX7JWqLegq/9PQVxq
PPws0e0/JnIK+xatWevOMnuDhAnPRtY0XQb5qBIUUxF1jVNDD0md6d4MF/WO8nNb
aum28LOuDSl59AcOyUMk6qMxDTqw6OSN2mGOlGKzNxXXm31xmZZCC5/WFjW+MB3X
ohIFQnNIWqalgLHHz1ym+prwL1iW3FyMdpyK26W7pW9yZPiYEonJ6Lk+gVUKxU2m
zEuG7QOGvI4FdTq9UxN7qUnaaHesKKOApvdc/EOmPet3FSQAqQGz5RG8xH0C1Jk3
JZFswdEykHXRgy6Hf0OLHq9BYdL15COrFW7YCNKmY/CXGWMZ4x4=
=yrUH
-----END PGP SIGNATURE-----

--fDViYqr5apx/vVUl--
