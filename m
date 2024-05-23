Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64491487E6
	for <git@vger.kernel.org>; Thu, 23 May 2024 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467146; cv=none; b=XDY25qLZEPaCBpU5d7xaqxGMCIglrSXUD+IaB1SD1SwC0EVyD8odpyCS3EIf6AVUYLfNFVrfzdMUw5sIZ/e0D87mwMw7pOkjIY/2eX2vcEHPeQKbzzOxY1Jsr7RGizAzYGNpypIXDz8aa8T1BekthAUi3QyTTZiGwTAawx9QcF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467146; c=relaxed/simple;
	bh=ksvK6hbNRBgoQhepTVhDE7/Mrs5xfvnPoFGxWqVUtFw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDvDoODikdAPhLLRx4XIdGR8xyiWrUFZydABqqcjDZM7jSZlQ5B+O2gTfojfkOxX2A3s05vV5vsjOB9oDWU+EJdZgmFu7B4yVQlmhiXVOCq5nh6+utRP7ZcIdi1ZKeVnb/0+mF/VfYaUAuW4vRqs7nKRZhExB3noCHvI8WSpg3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JpfTTA2K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KJvX320Y; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JpfTTA2K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KJvX320Y"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 156AE1C000C4
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:25:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 23 May 2024 08:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716467143; x=1716553543; bh=eU+/CK/fve
	fR0FXVMdm+KFNZFNb9HhkMO62bRdvLL9Y=; b=JpfTTA2KLJGyqApUCbALxcekGQ
	uFJpaCEYmThhwypKGZ04pA/5iPLUmFSTtiDlz2S8qiDyXeZbCarAey+hoIjtbDAL
	rT35JEDLcydZYSuEX3kJkgymDBwG3/gJhbUXuSmjKzlwJtyxgKN4l3xvANpWhe9b
	6HrtTMrsvTupsyqfwY2gjwEQswQKQW41r6x6TmDix7FUvUi8ThU0/Kq/oN6J9nYS
	VYkc/62bUOD1AZJYUs0FrZvReZqt6/JE0XAUngYWMLvwFC8XSOMD18P2DmF5RoE9
	UNFOonW4I6Dv4C2yHibZmXfcP395ckQSOMLmha6dKPaip7HU9xjPntb4vfgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716467143; x=1716553543; bh=eU+/CK/fvefR0FXVMdm+KFNZFNb9
	HhkMO62bRdvLL9Y=; b=KJvX320YWrCpeWFlayWa6oZ4x1mHNxH7l/K0r0y4+Mze
	SLl/QSX9n0Zbh1UOZqySS/nqyBF4MhQCylS8T9OCBAh4f2Djn7HjVlfCGMeOFSil
	mCCGglWUvcFkquAB1Ysx9943oZFe+oBHkn49hIfURHA/C0+e5VJWCtguKjSQ0ofw
	f7hDKdQvoOu4E2Oa2mWxctLEDInTooLMF1qlxXTWKQ4pWbdi/7p4Mpwuwb3nVbTH
	vW74aAtnbxEaUIb8Z2TnquMDYzHEuZJKrKblT7nJb7uGkg5ubHqWPEGYUCyElJdT
	qFDpEdqcaLHqo/qs4gik5joojM0GHcx/mTsKz/oLbA==
X-ME-Sender: <xms:xzVPZtzM9FYp4Xp_DPy9NQUd1pHcX7NLrxz3QB9WlyaB_uKOQ5P5pw>
    <xme:xzVPZtT9DuFvdCU2ojH9d9GHUKzv8V1RboaUNkWSUKMhuBFxXaGHOWXLp3XAvPLIj
    O0xUQcQxNFx4klfdA>
X-ME-Received: <xmr:xzVPZnXjPhpmhMQ37rdKG2O3gUfJ1bPloHUazvFwvD2sM0Q-oDdehoVrwXqNhACZYh2GT2hU-vowW3Tmiyc8vXMDn885JJdTfzFOnfNpiVJtl7sVxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:xzVPZvhi4RdSxrWbyPM2-Dqul-jPDOh2aH0tGHX5Clb85_9qT-plew>
    <xmx:xzVPZvC3xTKQeVkvzzFXvLzXn4jhnAaNtomYU8UiPITkhjgzIfEFyg>
    <xmx:xzVPZoKNl3Mq_e0lm2hMcHoRtqaCa7--UOtZP5YaM8vl7QIxl9Xl5g>
    <xmx:xzVPZuCdHwP5QKz1FIqzMyAOTPCow5mv7MKNLar8sFtmUeJx_wVe_A>
    <xmx:xzVPZk7VtIHg4KPms4ZmZBxlM90msJGFwSk6HXqd13-fX33bAXlkl_0j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 08:25:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9180a201 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 12:25:36 +0000 (UTC)
Date: Thu, 23 May 2024 14:25:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/20] config: clarify memory ownership in
 `git_config_pathname()`
Message-ID: <170276277217a3582f343dad9b429936682664f4.1716465556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2P45WWWtWsg0Nwxr"
Content-Disposition: inline
In-Reply-To: <cover.1716465556.git.ps@pks.im>


--2P45WWWtWsg0Nwxr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The out parameter of `git_config_pathname()` is a `const char **` even
though we transfer ownership of memory to the caller. This is quite
misleading and has led to many memory leaks all over the place. Adapt
the parameter to instead be `char **`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/blame.c        |  2 +-
 builtin/commit.c       |  2 +-
 builtin/config.c       |  2 +-
 builtin/log.c          |  2 +-
 builtin/receive-pack.c |  4 ++--
 config.c               | 10 +++++-----
 config.h               |  8 ++++----
 diff.c                 |  2 +-
 environment.c          |  6 +++---
 environment.h          |  6 +++---
 fetch-pack.c           |  4 ++--
 fsck.c                 |  4 ++--
 fsmonitor-settings.c   |  5 ++++-
 gpg-interface.c        |  4 +++-
 http.c                 | 12 ++++++------
 mailmap.c              |  2 +-
 mailmap.h              |  2 +-
 setup.c                |  6 +++---
 18 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 6bc7aa6085..838cd476be 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -718,7 +718,7 @@ static int git_blame_config(const char *var, const char=
 *value,
 		return 0;
 	}
 	if (!strcmp(var, "blame.ignorerevsfile")) {
-		const char *str;
+		char *str;
 		int ret;
=20
 		ret =3D git_config_pathname(&str, var, value);
diff --git a/builtin/commit.c b/builtin/commit.c
index 78bfae2164..1cc88e92bf 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -107,7 +107,7 @@ static enum {
 } commit_style;
=20
 static const char *logfile, *force_author;
-static const char *template_file;
+static char *template_file;
 /*
  * The _message variables are commit names from which to take
  * the commit message and/or authorship.
diff --git a/builtin/config.c b/builtin/config.c
index 80aa9d8a66..cc343f55ca 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -277,7 +277,7 @@ static int format_config(struct strbuf *buf, const char=
 *key_,
 			else
 				strbuf_addstr(buf, v ? "true" : "false");
 		} else if (type =3D=3D TYPE_PATH) {
-			const char *v;
+			char *v;
 			if (git_config_pathname(&v, key_, value_) < 0)
 				return -1;
 			strbuf_addstr(buf, v);
diff --git a/builtin/log.c b/builtin/log.c
index b17dd8b40a..a2f5845556 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -957,7 +957,7 @@ static int do_signoff;
 static enum auto_base_setting auto_base;
 static char *from;
 static const char *signature =3D git_version_string;
-static const char *signature_file;
+static char *signature_file;
 static enum cover_setting config_cover_letter;
 static const char *config_output_directory;
 static enum cover_from_description cover_from_description_mode =3D COVER_F=
ROM_MESSAGE;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index be8969a84a..56228ad314 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -168,13 +168,13 @@ static int receive_pack_config(const char *var, const=
 char *value,
 	}
=20
 	if (strcmp(var, "receive.fsck.skiplist") =3D=3D 0) {
-		const char *path;
+		char *path;
=20
 		if (git_config_pathname(&path, var, value))
 			return 1;
 		strbuf_addf(&fsck_msg_types, "%cskiplist=3D%s",
 			fsck_msg_types.len ? ',' : '=3D', path);
-		free((char *)path);
+		free(path);
 		return 0;
 	}
=20
diff --git a/config.c b/config.c
index d57996240b..fb56e11276 100644
--- a/config.c
+++ b/config.c
@@ -1346,7 +1346,7 @@ int git_config_string(const char **dest, const char *=
var, const char *value)
 	return 0;
 }
=20
-int git_config_pathname(const char **dest, const char *var, const char *va=
lue)
+int git_config_pathname(char **dest, const char *var, const char *value)
 {
 	if (!value)
 		return config_error_nonbool(var);
@@ -1597,7 +1597,7 @@ static int git_default_core_config(const char *var, c=
onst char *value,
 		return git_config_string(&askpass_program, var, value);
=20
 	if (!strcmp(var, "core.excludesfile")) {
-		free((char *)excludes_file);
+		free(excludes_file);
 		return git_config_pathname(&excludes_file, var, value);
 	}
=20
@@ -2494,7 +2494,7 @@ int git_configset_get_maybe_bool(struct config_set *s=
et, const char *key, int *d
 		return 1;
 }
=20
-int git_configset_get_pathname(struct config_set *set, const char *key, co=
nst char **dest)
+int git_configset_get_pathname(struct config_set *set, const char *key, ch=
ar **dest)
 {
 	const char *value;
 	if (!git_configset_get_value(set, key, &value, NULL))
@@ -2639,7 +2639,7 @@ int repo_config_get_maybe_bool(struct repository *rep=
o,
 }
=20
 int repo_config_get_pathname(struct repository *repo,
-			     const char *key, const char **dest)
+			     const char *key, char **dest)
 {
 	int ret;
 	git_config_check_init(repo);
@@ -2738,7 +2738,7 @@ int git_config_get_maybe_bool(const char *key, int *d=
est)
 	return repo_config_get_maybe_bool(the_repository, key, dest);
 }
=20
-int git_config_get_pathname(const char *key, const char **dest)
+int git_config_get_pathname(const char *key, char **dest)
 {
 	return repo_config_get_pathname(the_repository, key, dest);
 }
diff --git a/config.h b/config.h
index db8b608064..b3103bba94 100644
--- a/config.h
+++ b/config.h
@@ -286,7 +286,7 @@ int git_config_string(const char **, const char *, cons=
t char *);
  * Similar to `git_config_string`, but expands `~` or `~user` into the
  * user's home directory when found at the beginning of the path.
  */
-int git_config_pathname(const char **, const char *, const char *);
+int git_config_pathname(char **, const char *, const char *);
=20
 int git_config_expiry_date(timestamp_t *, const char *, const char *);
 int git_config_color(char *, const char *, const char *);
@@ -541,7 +541,7 @@ int git_configset_get_ulong(struct config_set *cs, cons=
t char *key, unsigned lon
 int git_configset_get_bool(struct config_set *cs, const char *key, int *de=
st);
 int git_configset_get_bool_or_int(struct config_set *cs, const char *key, =
int *is_bool, int *dest);
 int git_configset_get_maybe_bool(struct config_set *cs, const char *key, i=
nt *dest);
-int git_configset_get_pathname(struct config_set *cs, const char *key, con=
st char **dest);
+int git_configset_get_pathname(struct config_set *cs, const char *key, cha=
r **dest);
=20
 /* Functions for reading a repository's config */
 struct repository;
@@ -577,7 +577,7 @@ int repo_config_get_bool_or_int(struct repository *repo,
 int repo_config_get_maybe_bool(struct repository *repo,
 			       const char *key, int *dest);
 int repo_config_get_pathname(struct repository *repo,
-			     const char *key, const char **dest);
+			     const char *key, char **dest);
=20
 /*
  * Functions for reading protected config. By definition, protected
@@ -687,7 +687,7 @@ int git_config_get_maybe_bool(const char *key, int *des=
t);
  * Similar to `git_config_get_string`, but expands `~` or `~user` into
  * the user's home directory when found at the beginning of the path.
  */
-int git_config_get_pathname(const char *key, const char **dest);
+int git_config_get_pathname(const char *key, char **dest);
=20
 int git_config_get_index_threads(int *dest);
 int git_config_get_split_index(void);
diff --git a/diff.c b/diff.c
index ded9ac70df..902df9286a 100644
--- a/diff.c
+++ b/diff.c
@@ -58,7 +58,7 @@ static int diff_context_default =3D 3;
 static int diff_interhunk_context_default;
 static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
-static const char *diff_order_file_cfg;
+static char *diff_order_file_cfg;
 int diff_auto_refresh_index =3D 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
diff --git a/environment.c b/environment.c
index a73ba9c12c..279ea3fd5e 100644
--- a/environment.c
+++ b/environment.c
@@ -46,8 +46,8 @@ const char *git_commit_encoding;
 const char *git_log_output_encoding;
 char *apply_default_whitespace;
 char *apply_default_ignorewhitespace;
-const char *git_attributes_file;
-const char *git_hooks_path;
+char *git_attributes_file;
+char *git_hooks_path;
 int zlib_compression_level =3D Z_BEST_SPEED;
 int pack_compression_level =3D Z_DEFAULT_COMPRESSION;
 int fsync_object_files =3D -1;
@@ -60,7 +60,7 @@ size_t delta_base_cache_limit =3D 96 * 1024 * 1024;
 unsigned long big_file_threshold =3D 512 * 1024 * 1024;
 const char *editor_program;
 const char *askpass_program;
-const char *excludes_file;
+char *excludes_file;
 enum auto_crlf auto_crlf =3D AUTO_CRLF_FALSE;
 enum eol core_eol =3D EOL_UNSET;
 int global_conv_flags_eol =3D CONV_EOL_RNDTRP_WARN;
diff --git a/environment.h b/environment.h
index 0b2d457f07..be1b88ad6f 100644
--- a/environment.h
+++ b/environment.h
@@ -131,8 +131,8 @@ extern int warn_ambiguous_refs;
 extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
-extern const char *git_attributes_file;
-extern const char *git_hooks_path;
+extern char *git_attributes_file;
+extern char *git_hooks_path;
 extern int zlib_compression_level;
 extern int pack_compression_level;
 extern size_t packed_git_window_size;
@@ -229,7 +229,7 @@ extern const char *git_log_output_encoding;
=20
 extern const char *editor_program;
 extern const char *askpass_program;
-extern const char *excludes_file;
+extern char *excludes_file;
=20
 /*
  * Should we print an ellipsis after an abbreviated SHA-1 value
diff --git a/fetch-pack.c b/fetch-pack.c
index 8e8f3bba32..d80e9c92dd 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1865,13 +1865,13 @@ static int fetch_pack_config_cb(const char *var, co=
nst char *value,
 	const char *msg_id;
=20
 	if (strcmp(var, "fetch.fsck.skiplist") =3D=3D 0) {
-		const char *path;
+		char *path ;
=20
 		if (git_config_pathname(&path, var, value))
 			return 1;
 		strbuf_addf(&fsck_msg_types, "%cskiplist=3D%s",
 			fsck_msg_types.len ? ',' : '=3D', path);
-		free((char *)path);
+		free(path);
 		return 0;
 	}
=20
diff --git a/fsck.c b/fsck.c
index 8ef962199f..7dff41413e 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1330,13 +1330,13 @@ int git_fsck_config(const char *var, const char *va=
lue,
 	const char *msg_id;
=20
 	if (strcmp(var, "fsck.skiplist") =3D=3D 0) {
-		const char *path;
+		char *path;
 		struct strbuf sb =3D STRBUF_INIT;
=20
 		if (git_config_pathname(&path, var, value))
 			return 1;
 		strbuf_addf(&sb, "skiplist=3D%s", path);
-		free((char *)path);
+		free(path);
 		fsck_set_msg_types(options, sb.buf);
 		strbuf_release(&sb);
 		return 0;
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index a6a9e6bc19..e818583420 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -103,6 +103,7 @@ static struct fsmonitor_settings *alloc_settings(void)
 static void lookup_fsmonitor_settings(struct repository *r)
 {
 	const char *const_str;
+	char *to_free =3D NULL;
 	int bool_value;
=20
 	if (r->settings.fsmonitor)
@@ -129,8 +130,9 @@ static void lookup_fsmonitor_settings(struct repository=
 *r)
 		break;
=20
 	case -1: /* config value set to an arbitrary string */
-		if (repo_config_get_pathname(r, "core.fsmonitor", &const_str))
+		if (repo_config_get_pathname(r, "core.fsmonitor", &to_free))
 			return; /* should not happen */
+		const_str =3D to_free;
 		break;
=20
 	default: /* should not happen */
@@ -141,6 +143,7 @@ static void lookup_fsmonitor_settings(struct repository=
 *r)
 		fsm_settings__set_hook(r, const_str);
 	else
 		fsm_settings__set_disabled(r);
+	free(to_free);
 }
=20
 enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
diff --git a/gpg-interface.c b/gpg-interface.c
index 1ff94266d2..2b50ed0fa0 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -27,7 +27,9 @@ static void gpg_interface_lazy_init(void)
 }
=20
 static char *configured_signing_key;
-static const char *ssh_default_key_command, *ssh_allowed_signers, *ssh_rev=
ocation_file;
+static const char *ssh_default_key_command;
+static char *ssh_allowed_signers;
+static char *ssh_revocation_file;
 static enum signature_trust_level configured_min_trust_level =3D TRUST_UND=
EFINED;
=20
 struct gpg_format {
diff --git a/http.c b/http.c
index db2e2f1d39..fa3ea87451 100644
--- a/http.c
+++ b/http.c
@@ -64,7 +64,7 @@ static char *ssl_key_type;
 static char *ssl_capath;
 static char *curl_no_proxy;
 #ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
-static const char *ssl_pinnedkey;
+static char *ssl_pinnedkey;
 #endif
 static char *ssl_cainfo;
 static long curl_low_speed_limit =3D -1;
@@ -108,7 +108,7 @@ static struct {
=20
 static struct credential proxy_auth =3D CREDENTIAL_INIT;
 static const char *curl_proxyuserpwd;
-static const char *curl_cookie_file;
+static char *curl_cookie_file;
 static int curl_save_cookies;
 struct credential http_auth =3D CREDENTIAL_INIT;
 static int http_proactive_auth;
@@ -381,17 +381,17 @@ static int http_options(const char *var, const char *=
value,
 	if (!strcmp("http.sslversion", var))
 		return git_config_string(&ssl_version, var, value);
 	if (!strcmp("http.sslcert", var))
-		return git_config_pathname((const char **)&ssl_cert, var, value);
+		return git_config_pathname(&ssl_cert, var, value);
 	if (!strcmp("http.sslcerttype", var))
 		return git_config_string((const char **)&ssl_cert_type, var, value);
 	if (!strcmp("http.sslkey", var))
-		return git_config_pathname((const char **)&ssl_key, var, value);
+		return git_config_pathname(&ssl_key, var, value);
 	if (!strcmp("http.sslkeytype", var))
 		return git_config_string((const char **)&ssl_key_type, var, value);
 	if (!strcmp("http.sslcapath", var))
-		return git_config_pathname((const char **)&ssl_capath, var, value);
+		return git_config_pathname(&ssl_capath, var, value);
 	if (!strcmp("http.sslcainfo", var))
-		return git_config_pathname((const char **)&ssl_cainfo, var, value);
+		return git_config_pathname(&ssl_cainfo, var, value);
 	if (!strcmp("http.sslcertpasswordprotected", var)) {
 		ssl_cert_password_required =3D git_config_bool(var, value);
 		return 0;
diff --git a/mailmap.c b/mailmap.c
index 3d6a5e9400..044466b043 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -6,7 +6,7 @@
 #include "object-store-ll.h"
 #include "setup.h"
=20
-const char *git_mailmap_file;
+char *git_mailmap_file;
 const char *git_mailmap_blob;
=20
 struct mailmap_info {
diff --git a/mailmap.h b/mailmap.h
index 0f8fd2c586..429a760945 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -3,7 +3,7 @@
=20
 struct string_list;
=20
-extern const char *git_mailmap_file;
+extern char *git_mailmap_file;
 extern const char *git_mailmap_blob;
=20
 int read_mailmap(struct string_list *map);
diff --git a/setup.c b/setup.c
index 9247cded6a..59ff3a19eb 100644
--- a/setup.c
+++ b/setup.c
@@ -1177,13 +1177,13 @@ static int safe_directory_cb(const char *key, const=
 char *value,
 	} else if (!strcmp(value, "*")) {
 		data->is_safe =3D 1;
 	} else {
-		const char *interpolated =3D NULL;
+		char *interpolated =3D NULL;
=20
 		if (!git_config_pathname(&interpolated, key, value) &&
 		    !fspathcmp(data->path, interpolated ? interpolated : value))
 			data->is_safe =3D 1;
=20
-		free((char *)interpolated);
+		free(interpolated);
 	}
=20
 	return 0;
@@ -1822,7 +1822,7 @@ static int template_dir_cb(const char *key, const cha=
r *value,
 		char *path =3D NULL;
=20
 		FREE_AND_NULL(data->path);
-		if (!git_config_pathname((const char **)&path, key, value))
+		if (!git_config_pathname(&path, key, value))
 			data->path =3D path ? path : xstrdup(value);
 	}
=20
--=20
2.45.1.216.g4365c6fcf9.dirty


--2P45WWWtWsg0Nwxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZPNcMACgkQVbJhu7ck
PpRmRA/+NyID1FE3PYlm+toEECNEDwE5L3UygnW1Abpvths/cIvxcnJZ6s3ZiKUe
BwE842ajhgyhSXRbqSxytTpYhc49bbo7Wm2ev3ylAsvp4/2Z1/QkuBEl6VVCuDmU
likiG1U5TJZ391DYfP3TNats3/LXAQ+CysrpWqWI797qvzk4da/ynQTgMHt5ONoz
LO7EXJ+3RYVkBOgmNiPi7M050gvA0wDbAAnKRyAcRreC6uYZGLjkGGtpZnKT9bG2
AQS91l7useiSYXo77T6Asbc4UWkpv3ljy4Ij0AAFiXcGIFrbE3yfCv2D53KQSVWn
kOO25kHnkRJ6VuCO4qGPXUawa75S6jnsS9VwyrmulmE3+Os6/UmIo+WnniOAT6au
6zUkotXLenuCDwbyWYRYW3E5IFLnxMnrXh8OMGgisjPUAn42UILy/vDolGgbN1f7
ER3AHx5MQY0nP8REb4KTCpI99adPDBAd2ypWgfD38hqw6sD7VlBbALblkx3Qrj5b
lXm+km6eAK2MfCxBUPDgc6AelT150LWfk9EsnBR3wr49HBcJFhLrjJY3si6dgdAG
wnGyQ3nNhXcBgVzCpmTM8jeV8DVp0uDCeTnEPmkMKJatS6s3F/RXTibUNwjPjGtZ
kNFl/jjRE5+dOfwPC821r35IUdhfmrBLXjVxaoSZew6Bh91/NkY=
=dU1M
-----END PGP SIGNATURE-----

--2P45WWWtWsg0Nwxr--
