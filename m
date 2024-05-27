Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BAF15DBCB
	for <git@vger.kernel.org>; Mon, 27 May 2024 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810403; cv=none; b=MKsEQnGI3bR+QSR9P0k9B3acSABAYlAHyYTIuJSWchTLP1eTx0q7VSCHzcPYeKtfC1AaaFBnQEU2dkRCim8q6X3jecrKVWGtiZfcNhUL97Exucvfr2tHwotbW515ndfn2qkQsj2KhMcj7VHl6KJAoY5LkLRfmkCCqxh5v0I0ovQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810403; c=relaxed/simple;
	bh=+/ecPN7RySnlxogbxaYeLPM67IVKX6UP7jlRL3n/tII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1+P15nkVrDKlbu052eP6tgP6SQE2kmW6jxmsSh2kQ8YmUiXcvscBfUyP7G0VYB+BjNRDwNX7tZF0wddd4WWSRSQPBlQrRiaUSBnO6QCqD7kEMyNq3s0MxVlj4FKIaGdPcM5SI5Wl10caT/APxk5Z+wKMQtoUjOn+HZle9D6q/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AJwJNjXI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hJKJnqet; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AJwJNjXI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hJKJnqet"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id A616E18000B6;
	Mon, 27 May 2024 07:46:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 27 May 2024 07:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716810399; x=1716896799; bh=HlAb04M8S6
	5okCCk6ktoQU7j9vaWH11VO9R/5jiU66E=; b=AJwJNjXIYv5V4nZ8TIsVA8soLh
	EfS0GIWYI3jP6hI3tbdCFeFJv8uCg2Q2Aj2ltmP+bNCcZVYPqMgA27pNvYr0KdzN
	2UQF96NPM+0nElXYNQVwImmM3zYMA/ST8ptUH9QDTnD0mkLxzjmly24bn2NqPq0S
	xnbCJRrzZrBvbIlmP58W3KCymIJ6vrwTRmvC9qefUXkO37mMVzyJ7ocIULn0F2nQ
	L6w2INexknoEsxCe+IxE2xLzDUpgRhg2X43Mr0FnSgv3vlMrTfFfPvpvGbwozUl1
	lskfEsUyxsxeia2qA9wZTMZ/14mnFpV7eIP3JT/9uPSXOLYfPTIm9P6hm71Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716810399; x=1716896799; bh=HlAb04M8S65okCCk6ktoQU7j9vaW
	H11VO9R/5jiU66E=; b=hJKJnqetVkUDmBhuMCXW7+uUgypW5svgQ9Cc2VM/JgF2
	CtB4dNvyopf9b+eO/btxn56ciEEJO1bM7FAHYoK28dMJ5OTd1Ln+FhoP+Yqtc4WD
	tgLf+pSeUGoUFmRiYCHDqieIyrAMx/uR2jcg/eJao7dyoehmXHHgQp/MuWSHpndK
	7O98e2sOJpJHI1/7aGzC9G+siigiqTDKAjIgrE3lsdC7AZhfhTAVwLmJFJFHmvad
	+ZmpItecfl6O+SZPPux9pVZEfXu0SXoIB4xEU3iQ+giAVdgRL4ukOEkizDYFSMQm
	pUIK+qoDM9J9TF3mr50ilDhdflbzjoa66xjKL5UcBw==
X-ME-Sender: <xms:n3JUZuRyuZ2d5FI3TEnhpAx63Jsw6suclUzmDP-HKUnewzULpDPG1A>
    <xme:n3JUZjzfVK9D_cY3qbg8OczPoaAqcZkVyRvjffd3egb_ZVdO2cOxOTxfM-caNxmZp
    5f43Od5VbGJnfcYSQ>
X-ME-Received: <xmr:n3JUZr1MY7IQTxGQ4nhj5Usz3lunK20J1TCetez4SN5lhjJPfOfwGdd9BVzDKRmiNEYc1UTBTaVXqHuoPMspesdNesuCUaZUUghLBt5Ycm3Yj282zRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueegheeuheejuefgjeejfffgkeeugffgudfhudejkeevjefhkeefueeggfegueet
    necuffhomhgrihhnpegvgihtrhgrpghhughrrdhnrhdpvgigthhrrggpthhordhnrhdpvg
    igthhrrggptggtrdhnrhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:n3JUZqDmWBRZuyzoIeLIsg6wD4beI-tEy4uttrKevIaHPT7H3y10gg>
    <xmx:n3JUZni20SDfAyQW3w6Dw_5KPYNGUTm3inCAJm7PU2oenbu2FR3Bjw>
    <xmx:n3JUZmodwSo6QVDdC5XWi3gEWJIRMZng7jKrgr0H5gVk0PAw80b1bA>
    <xmx:n3JUZqhT_DDr0rFpOLV1S3YcSNrpRhYHy638vI0zyrbckafWz6Bxcw>
    <xmx:n3JUZtaV_Yy9xADRHKNncrvAS43vudqy8lMibE90E94-ovEw6b8M8C33>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 07:46:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id efe6760d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 11:46:27 +0000 (UTC)
Date: Mon, 27 May 2024 13:46:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 11/21] builtin/log: stop using globals for format config
Message-ID: <eeba79678a80dfb2dcd6e9e9800c862a83d2aed0.1716810168.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716810168.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/HFnr0HsjhoXQEBB"
Content-Disposition: inline
In-Reply-To: <cover.1716810168.git.ps@pks.im>


--/HFnr0HsjhoXQEBB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This commit does the exact same as the preceding commit, only for the
format configuration instead of the log configuration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/log.c | 467 ++++++++++++++++++++++++++++----------------------
 1 file changed, 265 insertions(+), 202 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index f5da29ee2a..890bf0c425 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -945,36 +945,6 @@ int cmd_log(int argc, const char **argv, const char *p=
refix)
=20
 /* format-patch */
=20
-static const char *fmt_patch_suffix =3D ".patch";
-static int numbered =3D 0;
-static int auto_number =3D 1;
-
-static char *default_attach =3D NULL;
-
-static struct string_list extra_hdr =3D STRING_LIST_INIT_NODUP;
-static struct string_list extra_to =3D STRING_LIST_INIT_NODUP;
-static struct string_list extra_cc =3D STRING_LIST_INIT_NODUP;
-
-static void add_header(const char *value)
-{
-	struct string_list_item *item;
-	int len =3D strlen(value);
-	while (len && value[len - 1] =3D=3D '\n')
-		len--;
-
-	if (!strncasecmp(value, "to: ", 4)) {
-		item =3D string_list_append(&extra_to, value + 4);
-		len -=3D 4;
-	} else if (!strncasecmp(value, "cc: ", 4)) {
-		item =3D string_list_append(&extra_cc, value + 4);
-		len -=3D 4;
-	} else {
-		item =3D string_list_append(&extra_hdr, value);
-	}
-
-	item->string[len] =3D '\0';
-}
-
 enum cover_setting {
 	COVER_UNSET,
 	COVER_OFF,
@@ -1001,17 +971,61 @@ enum auto_base_setting {
 	AUTO_BASE_WHEN_ABLE
 };
=20
-static enum thread_level thread;
-static int do_signoff;
-static enum auto_base_setting auto_base;
-static char *from;
-static const char *signature =3D git_version_string;
-static char *signature_file;
-static enum cover_setting config_cover_letter;
-static const char *config_output_directory;
-static enum cover_from_description cover_from_description_mode =3D COVER_F=
ROM_MESSAGE;
-static int show_notes;
-static struct display_notes_opt notes_opt;
+struct format_config {
+	struct log_config log;
+	enum thread_level thread;
+	int do_signoff;
+	enum auto_base_setting auto_base;
+	char *base_commit;
+	char *from;
+	char *signature;
+	char *signature_file;
+	enum cover_setting config_cover_letter;
+	char *config_output_directory;
+	enum cover_from_description cover_from_description_mode;
+	int show_notes;
+	struct display_notes_opt notes_opt;
+	int numbered_cmdline_opt;
+	int numbered;
+	int auto_number;
+	char *default_attach;
+	struct string_list extra_hdr;
+	struct string_list extra_to;
+	struct string_list extra_cc;
+	int keep_subject;
+	int subject_prefix;
+	struct strbuf sprefix;
+	char *fmt_patch_suffix;
+};
+
+static void format_config_init(struct format_config *cfg)
+{
+	memset(cfg, 0, sizeof(*cfg));
+	log_config_init(&cfg->log);
+	cfg->cover_from_description_mode =3D COVER_FROM_MESSAGE;
+	cfg->auto_number =3D 1;
+	string_list_init_dup(&cfg->extra_hdr);
+	string_list_init_dup(&cfg->extra_to);
+	string_list_init_dup(&cfg->extra_cc);
+	strbuf_init(&cfg->sprefix, 0);
+	cfg->fmt_patch_suffix =3D xstrdup(".patch");
+}
+
+static void format_config_release(struct format_config *cfg)
+{
+	log_config_release(&cfg->log);
+	free(cfg->base_commit);
+	free(cfg->from);
+	free(cfg->signature);
+	free(cfg->signature_file);
+	free(cfg->config_output_directory);
+	free(cfg->default_attach);
+	string_list_clear(&cfg->extra_hdr, 0);
+	string_list_clear(&cfg->extra_to, 0);
+	string_list_clear(&cfg->extra_cc, 0);
+	strbuf_release(&cfg->sprefix);
+	free(cfg->fmt_patch_suffix);
+}
=20
 static enum cover_from_description parse_cover_from_description(const char=
 *arg)
 {
@@ -1029,27 +1043,51 @@ static enum cover_from_description parse_cover_from=
_description(const char *arg)
 		die(_("%s: invalid cover from description mode"), arg);
 }
=20
+static void add_header(struct format_config *cfg, const char *value)
+{
+	struct string_list_item *item;
+	int len =3D strlen(value);
+	while (len && value[len - 1] =3D=3D '\n')
+		len--;
+
+	if (!strncasecmp(value, "to: ", 4)) {
+		item =3D string_list_append(&cfg->extra_to, value + 4);
+		len -=3D 4;
+	} else if (!strncasecmp(value, "cc: ", 4)) {
+		item =3D string_list_append(&cfg->extra_cc, value + 4);
+		len -=3D 4;
+	} else {
+		item =3D string_list_append(&cfg->extra_hdr, value);
+	}
+
+	item->string[len] =3D '\0';
+}
+
 static int git_format_config(const char *var, const char *value,
 			     const struct config_context *ctx, void *cb)
 {
+	struct format_config *cfg =3D cb;
+
 	if (!strcmp(var, "format.headers")) {
 		if (!value)
 			die(_("format.headers without value"));
-		add_header(value);
+		add_header(cfg, value);
 		return 0;
 	}
-	if (!strcmp(var, "format.suffix"))
-		return git_config_string(&fmt_patch_suffix, var, value);
+	if (!strcmp(var, "format.suffix")) {
+		FREE_AND_NULL(cfg->fmt_patch_suffix);
+		return git_config_string((const char **) &cfg->fmt_patch_suffix, var, va=
lue);
+	}
 	if (!strcmp(var, "format.to")) {
 		if (!value)
 			return config_error_nonbool(var);
-		string_list_append(&extra_to, value);
+		string_list_append(&cfg->extra_to, value);
 		return 0;
 	}
 	if (!strcmp(var, "format.cc")) {
 		if (!value)
 			return config_error_nonbool(var);
-		string_list_append(&extra_cc, value);
+		string_list_append(&cfg->extra_cc, value);
 		return 0;
 	}
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff") ||
@@ -1058,69 +1096,76 @@ static int git_format_config(const char *var, const=
 char *value,
 	}
 	if (!strcmp(var, "format.numbered")) {
 		if (value && !strcasecmp(value, "auto")) {
-			auto_number =3D 1;
+			cfg->auto_number =3D 1;
 			return 0;
 		}
-		numbered =3D git_config_bool(var, value);
-		auto_number =3D auto_number && numbered;
+		cfg->numbered =3D git_config_bool(var, value);
+		cfg->auto_number =3D cfg->auto_number && cfg->numbered;
 		return 0;
 	}
 	if (!strcmp(var, "format.attach")) {
-		if (value && *value)
-			default_attach =3D xstrdup(value);
-		else if (value && !*value)
-			FREE_AND_NULL(default_attach);
-		else
-			default_attach =3D xstrdup(git_version_string);
+		if (value && *value) {
+			FREE_AND_NULL(cfg->default_attach);
+			cfg->default_attach =3D xstrdup(value);
+		} else if (value && !*value) {
+			FREE_AND_NULL(cfg->default_attach);
+		} else {
+			FREE_AND_NULL(cfg->default_attach);
+			cfg->default_attach =3D xstrdup(git_version_string);
+		}
 		return 0;
 	}
 	if (!strcmp(var, "format.thread")) {
 		if (value && !strcasecmp(value, "deep")) {
-			thread =3D THREAD_DEEP;
+			cfg->thread =3D THREAD_DEEP;
 			return 0;
 		}
 		if (value && !strcasecmp(value, "shallow")) {
-			thread =3D THREAD_SHALLOW;
+			cfg->thread =3D THREAD_SHALLOW;
 			return 0;
 		}
-		thread =3D git_config_bool(var, value) ? THREAD_SHALLOW : THREAD_UNSET;
+		cfg->thread =3D git_config_bool(var, value) ? THREAD_SHALLOW : THREAD_UN=
SET;
 		return 0;
 	}
 	if (!strcmp(var, "format.signoff")) {
-		do_signoff =3D git_config_bool(var, value);
+		cfg->do_signoff =3D git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "format.signature"))
-		return git_config_string(&signature, var, value);
-	if (!strcmp(var, "format.signaturefile"))
-		return git_config_pathname(&signature_file, var, value);
+	if (!strcmp(var, "format.signature")) {
+		FREE_AND_NULL(cfg->signature);
+		return git_config_string((const char **) &cfg->signature, var, value);
+	}
+	if (!strcmp(var, "format.signaturefile")) {
+		FREE_AND_NULL(cfg->signature_file);
+		return git_config_pathname(&cfg->signature_file, var, value);
+	}
 	if (!strcmp(var, "format.coverletter")) {
 		if (value && !strcasecmp(value, "auto")) {
-			config_cover_letter =3D COVER_AUTO;
+			cfg->config_cover_letter =3D COVER_AUTO;
 			return 0;
 		}
-		config_cover_letter =3D git_config_bool(var, value) ? COVER_ON : COVER_O=
FF;
+		cfg->config_cover_letter =3D git_config_bool(var, value) ? COVER_ON : CO=
VER_OFF;
 		return 0;
 	}
-	if (!strcmp(var, "format.outputdirectory"))
-		return git_config_string(&config_output_directory, var, value);
+	if (!strcmp(var, "format.outputdirectory")) {
+		FREE_AND_NULL(cfg->config_output_directory);
+		return git_config_string((const char **) &cfg->config_output_directory, =
var, value);
+	}
 	if (!strcmp(var, "format.useautobase")) {
 		if (value && !strcasecmp(value, "whenAble")) {
-			auto_base =3D AUTO_BASE_WHEN_ABLE;
+			cfg->auto_base =3D AUTO_BASE_WHEN_ABLE;
 			return 0;
 		}
-		auto_base =3D git_config_bool(var, value) ? AUTO_BASE_ALWAYS : AUTO_BASE=
_NEVER;
+		cfg->auto_base =3D git_config_bool(var, value) ? AUTO_BASE_ALWAYS : AUTO=
_BASE_NEVER;
 		return 0;
 	}
 	if (!strcmp(var, "format.from")) {
 		int b =3D git_parse_maybe_bool(value);
-		free(from);
+		FREE_AND_NULL(cfg->from);
 		if (b < 0)
-			from =3D xstrdup(value);
+			cfg->from =3D xstrdup(value);
 		else if (b)
-			from =3D xstrdup(git_committer_info(IDENT_NO_DATE));
-		else
-			from =3D NULL;
+			cfg->from =3D xstrdup(git_committer_info(IDENT_NO_DATE));
 		return 0;
 	}
 	if (!strcmp(var, "format.forceinbodyfrom")) {
@@ -1130,15 +1175,15 @@ static int git_format_config(const char *var, const=
 char *value,
 	if (!strcmp(var, "format.notes")) {
 		int b =3D git_parse_maybe_bool(value);
 		if (b < 0)
-			enable_ref_display_notes(&notes_opt, &show_notes, value);
+			enable_ref_display_notes(&cfg->notes_opt, &cfg->show_notes, value);
 		else if (b)
-			enable_default_display_notes(&notes_opt, &show_notes);
+			enable_default_display_notes(&cfg->notes_opt, &cfg->show_notes);
 		else
-			disable_display_notes(&notes_opt, &show_notes);
+			disable_display_notes(&cfg->notes_opt, &cfg->show_notes);
 		return 0;
 	}
 	if (!strcmp(var, "format.coverfromdescription")) {
-		cover_from_description_mode =3D parse_cover_from_description(value);
+		cfg->cover_from_description_mode =3D parse_cover_from_description(value);
 		return 0;
 	}
 	if (!strcmp(var, "format.mboxrd")) {
@@ -1159,7 +1204,7 @@ static int git_format_config(const char *var, const c=
har *value,
 	if (!strcmp(var, "diff.noprefix"))
 		return 0;
=20
-	return git_log_config(var, value, ctx, cb);
+	return git_log_config(var, value, ctx, &cfg->log);
 }
=20
 static const char *output_directory =3D NULL;
@@ -1247,7 +1292,7 @@ static void gen_message_id(struct rev_info *info, cha=
r *base)
 	info->message_id =3D strbuf_detach(&buf, NULL);
 }
=20
-static void print_signature(FILE *file)
+static void print_signature(const char *signature, FILE *file)
 {
 	if (!signature || !*signature)
 		return;
@@ -1317,14 +1362,15 @@ static void prepare_cover_text(struct pretty_print_=
context *pp,
 			       const char *branch_name,
 			       struct strbuf *sb,
 			       const char *encoding,
-			       int need_8bit_cte)
+			       int need_8bit_cte,
+			       const struct format_config *cfg)
 {
 	const char *subject =3D "*** SUBJECT HERE ***";
 	const char *body =3D "*** BLURB HERE ***";
 	struct strbuf description_sb =3D STRBUF_INIT;
 	struct strbuf subject_sb =3D STRBUF_INIT;
=20
-	if (cover_from_description_mode =3D=3D COVER_FROM_NONE)
+	if (cfg->cover_from_description_mode =3D=3D COVER_FROM_NONE)
 		goto do_pp;
=20
 	if (description_file && *description_file)
@@ -1334,13 +1380,13 @@ static void prepare_cover_text(struct pretty_print_=
context *pp,
 	if (!description_sb.len)
 		goto do_pp;
=20
-	if (cover_from_description_mode =3D=3D COVER_FROM_SUBJECT ||
-			cover_from_description_mode =3D=3D COVER_FROM_AUTO)
+	if (cfg->cover_from_description_mode =3D=3D COVER_FROM_SUBJECT ||
+	    cfg->cover_from_description_mode =3D=3D COVER_FROM_AUTO)
 		body =3D format_subject(&subject_sb, description_sb.buf, " ");
=20
-	if (cover_from_description_mode =3D=3D COVER_FROM_MESSAGE ||
-			(cover_from_description_mode =3D=3D COVER_FROM_AUTO &&
-			 subject_sb.len > COVER_FROM_AUTO_MAX_SUBJECT_LEN))
+	if (cfg->cover_from_description_mode =3D=3D COVER_FROM_MESSAGE ||
+	    (cfg->cover_from_description_mode =3D=3D COVER_FROM_AUTO &&
+	     subject_sb.len > COVER_FROM_AUTO_MAX_SUBJECT_LEN))
 		body =3D description_sb.buf;
 	else
 		subject =3D subject_sb.buf;
@@ -1377,7 +1423,8 @@ static void make_cover_letter(struct rev_info *rev, i=
nt use_separate_file,
 			      int nr, struct commit **list,
 			      const char *description_file,
 			      const char *branch_name,
-			      int quiet)
+			      int quiet,
+			      const struct format_config *cfg)
 {
 	const char *committer;
 	struct shortlog log;
@@ -1416,7 +1463,7 @@ static void make_cover_letter(struct rev_info *rev, i=
nt use_separate_file,
 	pp.encode_email_headers =3D rev->encode_email_headers;
 	pp_user_info(&pp, NULL, &sb, committer, encoding);
 	prepare_cover_text(&pp, description_file, branch_name, &sb,
-			   encoding, need_8bit_cte);
+			   encoding, need_8bit_cte, cfg);
 	fprintf(rev->diffopt.file, "%s\n", sb.buf);
=20
 	free(pp.after_subject);
@@ -1517,29 +1564,30 @@ static const char * const builtin_format_patch_usag=
e[] =3D {
 	NULL
 };
=20
-static int keep_subject =3D 0;
+struct keep_callback_data {
+	struct format_config *cfg;
+	struct rev_info *revs;
+};
=20
 static int keep_callback(const struct option *opt, const char *arg, int un=
set)
 {
+	struct keep_callback_data *data =3D opt->value;
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
-	((struct rev_info *)opt->value)->total =3D -1;
-	keep_subject =3D 1;
+	data->revs->total =3D -1;
+	data->cfg->keep_subject =3D 1;
 	return 0;
 }
=20
-static int subject_prefix =3D 0;
-
 static int subject_prefix_callback(const struct option *opt, const char *a=
rg,
 			    int unset)
 {
-	struct strbuf *sprefix;
+	struct format_config *cfg =3D opt->value;
=20
 	BUG_ON_OPT_NEG(unset);
-	sprefix =3D opt->value;
-	subject_prefix =3D 1;
-	strbuf_reset(sprefix);
-	strbuf_addstr(sprefix, arg);
+	cfg->subject_prefix =3D 1;
+	strbuf_reset(&cfg->sprefix);
+	strbuf_addstr(&cfg->sprefix, arg);
 	return 0;
 }
=20
@@ -1556,15 +1604,14 @@ static int rfc_callback(const struct option *opt, c=
onst char *arg,
 	return 0;
 }
=20
-static int numbered_cmdline_opt =3D 0;
-
 static int numbered_callback(const struct option *opt, const char *arg,
 			     int unset)
 {
+	struct format_config *cfg =3D opt->value;
 	BUG_ON_OPT_ARG(arg);
-	*(int *)opt->value =3D numbered_cmdline_opt =3D unset ? 0 : 1;
+	cfg->numbered =3D cfg->numbered_cmdline_opt =3D unset ? 0 : 1;
 	if (unset)
-		auto_number =3D  0;
+		cfg->auto_number =3D  0;
 	return 0;
 }
=20
@@ -1588,13 +1635,14 @@ static int output_directory_callback(const struct o=
ption *opt, const char *arg,
=20
 static int thread_callback(const struct option *opt, const char *arg, int =
unset)
 {
-	enum thread_level *thread =3D (enum thread_level *)opt->value;
+	struct format_config *cfg =3D opt->value;
+
 	if (unset)
-		*thread =3D THREAD_UNSET;
+		cfg->thread =3D THREAD_UNSET;
 	else if (!arg || !strcmp(arg, "shallow"))
-		*thread =3D THREAD_SHALLOW;
+		cfg->thread =3D THREAD_SHALLOW;
 	else if (!strcmp(arg, "deep"))
-		*thread =3D THREAD_DEEP;
+		cfg->thread =3D THREAD_DEEP;
 	/*
 	 * Please update _git_formatpatch() in git-completion.bash
 	 * when you add new options.
@@ -1630,15 +1678,17 @@ static int inline_callback(const struct option *opt=
, const char *arg, int unset)
 	return 0;
 }
=20
-static int header_callback(const struct option *opt UNUSED, const char *ar=
g,
+static int header_callback(const struct option *opt, const char *arg,
 			   int unset)
 {
+	struct format_config *cfg =3D opt->value;
+
 	if (unset) {
-		string_list_clear(&extra_hdr, 0);
-		string_list_clear(&extra_to, 0);
-		string_list_clear(&extra_cc, 0);
+		string_list_clear(&cfg->extra_hdr, 0);
+		string_list_clear(&cfg->extra_to, 0);
+		string_list_clear(&cfg->extra_cc, 0);
 	} else {
-		add_header(arg);
+		add_header(cfg, arg);
 	}
 	return 0;
 }
@@ -1660,17 +1710,17 @@ static int from_callback(const struct option *opt, =
const char *arg, int unset)
=20
 static int base_callback(const struct option *opt, const char *arg, int un=
set)
 {
-	const char **base_commit =3D opt->value;
+	struct format_config *cfg =3D opt->value;
=20
 	if (unset) {
-		auto_base =3D AUTO_BASE_NEVER;
-		*base_commit =3D NULL;
+		cfg->auto_base =3D AUTO_BASE_NEVER;
+		FREE_AND_NULL(cfg->base_commit);
 	} else if (!strcmp(arg, "auto")) {
-		auto_base =3D AUTO_BASE_ALWAYS;
-		*base_commit =3D NULL;
+		cfg->auto_base =3D AUTO_BASE_ALWAYS;
+		FREE_AND_NULL(cfg->base_commit);
 	} else {
-		auto_base =3D AUTO_BASE_NEVER;
-		*base_commit =3D arg;
+		cfg->auto_base =3D AUTO_BASE_NEVER;
+		cfg->base_commit =3D xstrdup(arg);
 	}
 	return 0;
 }
@@ -1681,7 +1731,7 @@ struct base_tree_info {
 	struct object_id *patch_id;
 };
=20
-static struct commit *get_base_commit(const char *base_commit,
+static struct commit *get_base_commit(const struct format_config *cfg,
 				      struct commit **list,
 				      int total)
 {
@@ -1689,9 +1739,9 @@ static struct commit *get_base_commit(const char *bas=
e_commit,
 	struct commit **rev;
 	int i =3D 0, rev_nr =3D 0, auto_select, die_on_failure, ret;
=20
-	switch (auto_base) {
+	switch (cfg->auto_base) {
 	case AUTO_BASE_NEVER:
-		if (base_commit) {
+		if (cfg->base_commit) {
 			auto_select =3D 0;
 			die_on_failure =3D 1;
 		} else {
@@ -1701,11 +1751,11 @@ static struct commit *get_base_commit(const char *b=
ase_commit,
 		break;
 	case AUTO_BASE_ALWAYS:
 	case AUTO_BASE_WHEN_ABLE:
-		if (base_commit) {
+		if (cfg->base_commit) {
 			BUG("requested automatic base selection but a commit was provided");
 		} else {
 			auto_select =3D 1;
-			die_on_failure =3D auto_base =3D=3D AUTO_BASE_ALWAYS;
+			die_on_failure =3D cfg->auto_base =3D=3D AUTO_BASE_ALWAYS;
 		}
 		break;
 	default:
@@ -1713,9 +1763,9 @@ static struct commit *get_base_commit(const char *bas=
e_commit,
 	}
=20
 	if (!auto_select) {
-		base =3D lookup_commit_reference_by_name(base_commit);
+		base =3D lookup_commit_reference_by_name(cfg->base_commit);
 		if (!base)
-			die(_("unknown commit %s"), base_commit);
+			die(_("unknown commit %s"), cfg->base_commit);
 	} else {
 		struct branch *curr_branch =3D branch_get(NULL);
 		const char *upstream =3D branch_get_upstream(curr_branch, NULL);
@@ -1933,7 +1983,7 @@ static void infer_range_diff_ranges(struct strbuf *r1,
=20
 int cmd_format_patch(int argc, const char **argv, const char *prefix)
 {
-	struct log_config cfg;
+	struct format_config cfg;
 	struct commit *commit;
 	struct commit **list =3D NULL;
 	struct rev_info rev;
@@ -1958,7 +2008,6 @@ int cmd_format_patch(int argc, const char **argv, con=
st char *prefix)
 	char *cover_from_description_arg =3D NULL;
 	char *description_file =3D NULL;
 	char *branch_name =3D NULL;
-	char *base_commit =3D NULL;
 	struct base_tree_info bases;
 	struct commit *base;
 	int show_progress =3D 0;
@@ -1969,18 +2018,24 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 	struct strbuf rdiff1 =3D STRBUF_INIT;
 	struct strbuf rdiff2 =3D STRBUF_INIT;
 	struct strbuf rdiff_title =3D STRBUF_INIT;
-	struct strbuf sprefix =3D STRBUF_INIT;
 	const char *rfc =3D NULL;
 	int creation_factor =3D -1;
+	const char *signature =3D git_version_string;
+	const char *signature_file_arg =3D NULL;
+	struct keep_callback_data keep_callback_data =3D {
+		.cfg =3D &cfg,
+		.revs =3D &rev,
+	};
+	const char *fmt_patch_suffix =3D NULL;
=20
 	const struct option builtin_format_patch_options[] =3D {
-		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
+		OPT_CALLBACK_F('n', "numbered", &cfg, NULL,
 			    N_("use [PATCH n/m] even with a single patch"),
 			    PARSE_OPT_NOARG, numbered_callback),
-		OPT_CALLBACK_F('N', "no-numbered", &numbered, NULL,
+		OPT_CALLBACK_F('N', "no-numbered", &cfg, NULL,
 			    N_("use [PATCH] even with multiple patches"),
 			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, no_numbered_callback),
-		OPT_BOOL('s', "signoff", &do_signoff, N_("add a Signed-off-by trailer")),
+		OPT_BOOL('s', "signoff", &cfg.do_signoff, N_("add a Signed-off-by traile=
r")),
 		OPT_BOOL(0, "stdout", &use_stdout,
 			    N_("print patches to standard out")),
 		OPT_BOOL(0, "cover-letter", &cover_letter,
@@ -1993,7 +2048,7 @@ int cmd_format_patch(int argc, const char **argv, con=
st char *prefix)
 			    N_("start numbering patches at <n> instead of 1")),
 		OPT_STRING('v', "reroll-count", &reroll_count, N_("reroll-count"),
 			    N_("mark the series as Nth re-roll")),
-		OPT_INTEGER(0, "filename-max-length", &cfg.fmt_patch_name_max,
+		OPT_INTEGER(0, "filename-max-length", &cfg.log.fmt_patch_name_max,
 			    N_("max length of output filename")),
 		OPT_CALLBACK_F(0, "rfc", &rfc, N_("rfc"),
 			       N_("add <rfc> (default 'RFC') before 'PATCH'"),
@@ -2003,13 +2058,13 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 			    N_("generate parts of a cover letter based on a branch's descriptio=
n")),
 		OPT_FILENAME(0, "description-file", &description_file,
 			     N_("use branch description from file")),
-		OPT_CALLBACK_F(0, "subject-prefix", &sprefix, N_("prefix"),
+		OPT_CALLBACK_F(0, "subject-prefix", &cfg, N_("prefix"),
 			    N_("use [<prefix>] instead of [PATCH]"),
 			    PARSE_OPT_NONEG, subject_prefix_callback),
 		OPT_CALLBACK_F('o', "output-directory", &output_directory,
 			    N_("dir"), N_("store resulting files in <dir>"),
 			    PARSE_OPT_NONEG, output_directory_callback),
-		OPT_CALLBACK_F('k', "keep-subject", &rev, NULL,
+		OPT_CALLBACK_F('k', "keep-subject", &keep_callback_data, NULL,
 			    N_("don't strip/add [PATCH]"),
 			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, keep_callback),
 		OPT_BOOL(0, "no-binary", &no_binary_diff,
@@ -2022,11 +2077,11 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 			      N_("show patch format instead of default (patch + stat)"),
 			      1, PARSE_OPT_NONEG),
 		OPT_GROUP(N_("Messaging")),
-		OPT_CALLBACK(0, "add-header", NULL, N_("header"),
+		OPT_CALLBACK(0, "add-header", &cfg, N_("header"),
 			    N_("add email header"), header_callback),
-		OPT_STRING_LIST(0, "to", &extra_to, N_("email"), N_("add To: header")),
-		OPT_STRING_LIST(0, "cc", &extra_cc, N_("email"), N_("add Cc: header")),
-		OPT_CALLBACK_F(0, "from", &from, N_("ident"),
+		OPT_STRING_LIST(0, "to", &cfg.extra_to, N_("email"), N_("add To: header"=
)),
+		OPT_STRING_LIST(0, "cc", &cfg.extra_cc, N_("email"), N_("add Cc: header"=
)),
+		OPT_CALLBACK_F(0, "from", &cfg.from, N_("ident"),
 			    N_("set From address to <ident> (or committer ident if absent)"),
 			    PARSE_OPT_OPTARG, from_callback),
 		OPT_STRING(0, "in-reply-to", &in_reply_to, N_("message-id"),
@@ -2038,15 +2093,15 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 			    N_("inline the patch"),
 			    PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
 			    inline_callback),
-		OPT_CALLBACK_F(0, "thread", &thread, N_("style"),
+		OPT_CALLBACK_F(0, "thread", &cfg, N_("style"),
 			    N_("enable message threading, styles: shallow, deep"),
 			    PARSE_OPT_OPTARG, thread_callback),
 		OPT_STRING(0, "signature", &signature, N_("signature"),
 			    N_("add a signature")),
-		OPT_CALLBACK_F(0, "base", &base_commit, N_("base-commit"),
+		OPT_CALLBACK_F(0, "base", &cfg, N_("base-commit"),
 			       N_("add prerequisite tree info to the patch series"),
 			       0, base_callback),
-		OPT_FILENAME(0, "signature-file", &signature_file,
+		OPT_FILENAME(0, "signature-file", &signature_file_arg,
 				N_("add a signature from a file")),
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
 		OPT_BOOL(0, "progress", &show_progress,
@@ -2063,21 +2118,17 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 		OPT_END()
 	};
=20
-	extra_hdr.strdup_strings =3D 1;
-	extra_to.strdup_strings =3D 1;
-	extra_cc.strdup_strings =3D 1;
-
-	log_config_init(&cfg);
+	format_config_init(&cfg);
 	init_diff_ui_defaults();
-	init_display_notes(&notes_opt);
+	init_display_notes(&cfg.notes_opt);
 	git_config(git_format_config, &cfg);
 	repo_init_revisions(the_repository, &rev, prefix);
 	git_config(grep_config, &rev.grep_filter);
=20
-	rev.show_notes =3D show_notes;
-	memcpy(&rev.notes_opt, &notes_opt, sizeof(notes_opt));
+	rev.show_notes =3D cfg.show_notes;
+	memcpy(&rev.notes_opt, &cfg.notes_opt, sizeof(cfg.notes_opt));
 	rev.commit_format =3D CMIT_FMT_EMAIL;
-	rev.encode_email_headers =3D cfg.default_encode_email_headers;
+	rev.encode_email_headers =3D cfg.log.default_encode_email_headers;
 	rev.expand_tabs_in_log_default =3D 0;
 	rev.verbose_header =3D 1;
 	rev.diff =3D 1;
@@ -2088,12 +2139,12 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 	s_r_opt.def =3D "HEAD";
 	s_r_opt.revarg_opt =3D REVARG_COMMITTISH;
=20
-	strbuf_addstr(&sprefix, cfg.fmt_patch_subject_prefix);
+	strbuf_addstr(&cfg.sprefix, cfg.log.fmt_patch_subject_prefix);
 	if (format_no_prefix)
 		diff_set_noprefix(&rev.diffopt);
=20
-	if (default_attach) {
-		rev.mime_boundary =3D default_attach;
+	if (cfg.default_attach) {
+		rev.mime_boundary =3D cfg.default_attach;
 		rev.no_inline =3D 1;
 	}
=20
@@ -2109,60 +2160,63 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
=20
 	rev.force_in_body_from =3D force_in_body_from;
=20
+	if (!fmt_patch_suffix)
+		fmt_patch_suffix =3D cfg.fmt_patch_suffix;
+
 	/* Make sure "0000-$sub.patch" gives non-negative length for $sub */
-	if (cfg.fmt_patch_name_max <=3D strlen("0000-") + strlen(fmt_patch_suffix=
))
-		cfg.fmt_patch_name_max =3D strlen("0000-") + strlen(fmt_patch_suffix);
+	if (cfg.log.fmt_patch_name_max <=3D strlen("0000-") + strlen(fmt_patch_su=
ffix))
+		cfg.log.fmt_patch_name_max =3D strlen("0000-") + strlen(fmt_patch_suffix=
);
=20
 	if (cover_from_description_arg)
-		cover_from_description_mode =3D parse_cover_from_description(cover_from_=
description_arg);
+		cfg.cover_from_description_mode =3D parse_cover_from_description(cover_f=
rom_description_arg);
=20
 	if (rfc && rfc[0]) {
-		subject_prefix =3D 1;
+		cfg.subject_prefix =3D 1;
 		if (rfc[0] =3D=3D '-')
-			strbuf_addf(&sprefix, " %s", rfc + 1);
+			strbuf_addf(&cfg.sprefix, " %s", rfc + 1);
 		else
-			strbuf_insertf(&sprefix, 0, "%s ", rfc);
+			strbuf_insertf(&cfg.sprefix, 0, "%s ", rfc);
 	}
=20
 	if (reroll_count) {
-		strbuf_addf(&sprefix, " v%s", reroll_count);
+		strbuf_addf(&cfg.sprefix, " v%s", reroll_count);
 		rev.reroll_count =3D reroll_count;
 	}
=20
-	rev.subject_prefix =3D sprefix.buf;
+	rev.subject_prefix =3D cfg.sprefix.buf;
=20
-	for (i =3D 0; i < extra_hdr.nr; i++) {
-		strbuf_addstr(&buf, extra_hdr.items[i].string);
+	for (i =3D 0; i < cfg.extra_hdr.nr; i++) {
+		strbuf_addstr(&buf, cfg.extra_hdr.items[i].string);
 		strbuf_addch(&buf, '\n');
 	}
=20
-	if (extra_to.nr)
+	if (cfg.extra_to.nr)
 		strbuf_addstr(&buf, "To: ");
-	for (i =3D 0; i < extra_to.nr; i++) {
+	for (i =3D 0; i < cfg.extra_to.nr; i++) {
 		if (i)
 			strbuf_addstr(&buf, "    ");
-		strbuf_addstr(&buf, extra_to.items[i].string);
-		if (i + 1 < extra_to.nr)
+		strbuf_addstr(&buf, cfg.extra_to.items[i].string);
+		if (i + 1 < cfg.extra_to.nr)
 			strbuf_addch(&buf, ',');
 		strbuf_addch(&buf, '\n');
 	}
=20
-	if (extra_cc.nr)
+	if (cfg.extra_cc.nr)
 		strbuf_addstr(&buf, "Cc: ");
-	for (i =3D 0; i < extra_cc.nr; i++) {
+	for (i =3D 0; i < cfg.extra_cc.nr; i++) {
 		if (i)
 			strbuf_addstr(&buf, "    ");
-		strbuf_addstr(&buf, extra_cc.items[i].string);
-		if (i + 1 < extra_cc.nr)
+		strbuf_addstr(&buf, cfg.extra_cc.items[i].string);
+		if (i + 1 < cfg.extra_cc.nr)
 			strbuf_addch(&buf, ',');
 		strbuf_addch(&buf, '\n');
 	}
=20
 	rev.extra_headers =3D to_free =3D strbuf_detach(&buf, NULL);
=20
-	if (from) {
-		if (split_ident_line(&rev.from_ident, from, strlen(from)))
-			die(_("invalid ident line: %s"), from);
+	if (cfg.from) {
+		if (split_ident_line(&rev.from_ident, cfg.from, strlen(cfg.from)))
+			die(_("invalid ident line: %s"), cfg.from);
 	}
=20
 	if (start_number < 0)
@@ -2173,14 +2227,14 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 	 * and it would conflict with --keep-subject (-k) from the
 	 * command line, reset "numbered".
 	 */
-	if (numbered && keep_subject && !numbered_cmdline_opt)
-		numbered =3D 0;
+	if (cfg.numbered && cfg.keep_subject && !cfg.numbered_cmdline_opt)
+		cfg.numbered =3D 0;
=20
-	if (numbered && keep_subject)
+	if (cfg.numbered && cfg.keep_subject)
 		die(_("options '%s' and '%s' cannot be used together"), "-n", "-k");
-	if (keep_subject && subject_prefix)
+	if (cfg.keep_subject && cfg.subject_prefix)
 		die(_("options '%s' and '%s' cannot be used together"), "--subject-prefi=
x/--rfc", "-k");
-	rev.preserve_subject =3D keep_subject;
+	rev.preserve_subject =3D cfg.keep_subject;
=20
 	argc =3D setup_revisions(argc, argv, &rev, &s_r_opt);
 	if (argc > 1)
@@ -2207,7 +2261,7 @@ int cmd_format_patch(int argc, const char **argv, con=
st char *prefix)
 	rev.always_show_header =3D 1;
=20
 	rev.zero_commit =3D zero_commit;
-	rev.patch_name_max =3D cfg.fmt_patch_name_max;
+	rev.patch_name_max =3D cfg.log.fmt_patch_name_max;
=20
 	if (!rev.diffopt.flags.text && !no_binary_diff)
 		rev.diffopt.flags.binary =3D 1;
@@ -2228,7 +2282,7 @@ int cmd_format_patch(int argc, const char **argv, con=
st char *prefix)
 		int saved;
=20
 		if (!output_directory)
-			output_directory =3D config_output_directory;
+			output_directory =3D cfg.config_output_directory;
 		output_directory =3D set_outdir(prefix, output_directory);
=20
 		if (rev.diffopt.use_color !=3D GIT_COLOR_ALWAYS)
@@ -2326,14 +2380,14 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 		goto done;
 	total =3D nr;
 	if (cover_letter =3D=3D -1) {
-		if (config_cover_letter =3D=3D COVER_AUTO)
+		if (cfg.config_cover_letter =3D=3D COVER_AUTO)
 			cover_letter =3D (total > 1);
 		else
-			cover_letter =3D (config_cover_letter =3D=3D COVER_ON);
+			cover_letter =3D (cfg.config_cover_letter =3D=3D COVER_ON);
 	}
-	if (!keep_subject && auto_number && (total > 1 || cover_letter))
-		numbered =3D 1;
-	if (numbered)
+	if (!cfg.keep_subject && cfg.auto_number && (total > 1 || cover_letter))
+		cfg.numbered =3D 1;
+	if (cfg.numbered)
 		rev.total =3D total + start_number - 1;
=20
 	if (idiff_prev.nr) {
@@ -2365,27 +2419,40 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 					     _("Range-diff against v%d:"));
 	}
=20
+	/*
+	 * The order of precedence is:
+	 *
+	 *   1. The `--signature` and `--no-signature` options.
+	 *   2. The `--signature-file` option.
+	 *   3. The `format.signature` config.
+	 *   4. The `format.signatureFile` config.
+	 *   5. Default `git_version_string`.
+	 */
 	if (!signature) {
 		; /* --no-signature inhibits all signatures */
 	} else if (signature && signature !=3D git_version_string) {
 		; /* non-default signature already set */
-	} else if (signature_file) {
+	} else if (signature_file_arg || (cfg.signature_file && !cfg.signature)) {
 		struct strbuf buf =3D STRBUF_INIT;
+		const char *signature_file =3D signature_file_arg ?
+			signature_file_arg : cfg.signature_file;
=20
 		if (strbuf_read_file(&buf, signature_file, 128) < 0)
 			die_errno(_("unable to read signature file '%s'"), signature_file);
 		signature =3D strbuf_detach(&buf, NULL);
+	} else if (cfg.signature) {
+		signature =3D cfg.signature;
 	}
=20
 	memset(&bases, 0, sizeof(bases));
-	base =3D get_base_commit(base_commit, list, nr);
+	base =3D get_base_commit(&cfg, list, nr);
 	if (base) {
 		reset_revision_walk();
 		clear_object_flags(UNINTERESTING);
 		prepare_bases(&bases, base, list, nr);
 	}
=20
-	if (in_reply_to || thread || cover_letter) {
+	if (in_reply_to || cfg.thread || cover_letter) {
 		rev.ref_message_ids =3D xmalloc(sizeof(*rev.ref_message_ids));
 		string_list_init_dup(rev.ref_message_ids);
 	}
@@ -2396,19 +2463,19 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 	rev.numbered_files =3D just_numbers;
 	rev.patch_suffix =3D fmt_patch_suffix;
 	if (cover_letter) {
-		if (thread)
+		if (cfg.thread)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, !!output_directory,
-				  origin, nr, list, description_file, branch_name, quiet);
+				  origin, nr, list, description_file, branch_name, quiet, &cfg);
 		print_bases(&bases, rev.diffopt.file);
-		print_signature(rev.diffopt.file);
+		print_signature(signature, rev.diffopt.file);
 		total++;
 		start_number--;
 		/* interdiff/range-diff in cover-letter; omit from patches */
 		rev.idiff_oid1 =3D NULL;
 		rev.rdiff1 =3D NULL;
 	}
-	rev.add_signoff =3D do_signoff;
+	rev.add_signoff =3D cfg.do_signoff;
=20
 	if (show_progress)
 		progress =3D start_delayed_progress(_("Generating patches"), total);
@@ -2418,7 +2485,7 @@ int cmd_format_patch(int argc, const char **argv, con=
st char *prefix)
 		commit =3D list[nr];
 		rev.nr =3D total - nr + (start_number - 1);
 		/* Make the second and subsequent mails replies to the first */
-		if (thread) {
+		if (cfg.thread) {
 			/* Have we already had a message ID? */
 			if (rev.message_id) {
 				/*
@@ -2442,7 +2509,7 @@ int cmd_format_patch(int argc, const char **argv, con=
st char *prefix)
 				 * letter is a reply to the
 				 * --in-reply-to, if specified.
 				 */
-				if (thread =3D=3D THREAD_SHALLOW
+				if (cfg.thread =3D=3D THREAD_SHALLOW
 				    && rev.ref_message_ids->nr > 0
 				    && (!cover_letter || rev.nr > 1))
 					free(rev.message_id);
@@ -2475,7 +2542,7 @@ int cmd_format_patch(int argc, const char **argv, con=
st char *prefix)
 				       mime_boundary_leader,
 				       rev.mime_boundary);
 			else
-				print_signature(rev.diffopt.file);
+				print_signature(signature, rev.diffopt.file);
 		}
 		if (output_directory)
 			fclose(rev.diffopt.file);
@@ -2483,9 +2550,6 @@ int cmd_format_patch(int argc, const char **argv, con=
st char *prefix)
 	stop_progress(&progress);
 	free(list);
 	free(branch_name);
-	string_list_clear(&extra_to, 0);
-	string_list_clear(&extra_cc, 0);
-	string_list_clear(&extra_hdr, 0);
 	if (ignore_if_in_upstream)
 		free_patch_ids(&ids);
=20
@@ -2495,14 +2559,13 @@ int cmd_format_patch(int argc, const char **argv, c=
onst char *prefix)
 	strbuf_release(&rdiff1);
 	strbuf_release(&rdiff2);
 	strbuf_release(&rdiff_title);
-	strbuf_release(&sprefix);
 	free(to_free);
 	free(rev.message_id);
 	if (rev.ref_message_ids)
 		string_list_clear(rev.ref_message_ids, 0);
 	free(rev.ref_message_ids);
 	release_revisions(&rev);
-	log_config_release(&cfg);
+	format_config_release(&cfg);
 	return 0;
 }
=20
--=20
2.45.1.246.gb9cfe4845c.dirty


--/HFnr0HsjhoXQEBB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUcpoACgkQVbJhu7ck
PpTM6xAAi9spiGhtPu5/ex5rS89JMdomBP2p8FE1HSKh7KOTH0M14mWZgjY8dsjY
6aBnmMjQmYbu4fOCysCeMhcQAAlwWuNOmByqjkAEQr5DyAYcKLbKTAQgyzJjIZ/E
inxkthoRqyjGttE6goPsyR5eht3fB+1T/9wO8Vnw7uWKeaiihTS2D0aXys0hvNBG
FUmMFYpQesDPJD1fptWtLUUh7zT2FgCgP6ZjnGFcm9H9ZSerMO5aNx6cpz8OR0ep
m+2UXS0gQOrZbuiiwotEzDXtpOlq59UlPuyLTRGqz4ZToNIJT7M2pvZiNCCH/khF
Rf+cB0W75NrcX26P+Cy4XkioYoXcP2GA50CbvZa8Paf7u2M7Agga90pKO6Z3TIqT
3Q3jOW4nEOQk5GB2OAqxLE8Y+J+Uq7MxOIBQibSM9aGaOV3IYyLBX2jPoNf7C9Dh
H3UI66WY1YKspYZynR29ort9iBwVSlzGylH/5gwB5IptnW4fkdrTqH7oeMx7BSHH
CCElwDRKXeUmX1abLcLFdO3Fi6UJn9EzaM1uHP9PDuRvvDrDKFtq69JzImtNs6An
LwGVP9XZGcOh7znMzz0Podm3Pa5Sfwxb/rlfS3jbaYKmdAWpYWlnPVh9mWDMIzsA
Jn8FxIEw1bWbTdrxbUzBZAUljSWBdFHx3yDqfgMhXBflrjLLzNc=
=ZFv8
-----END PGP SIGNATURE-----

--/HFnr0HsjhoXQEBB--
