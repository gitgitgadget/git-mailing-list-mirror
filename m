Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6BA14885E
	for <git@vger.kernel.org>; Thu, 23 May 2024 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467170; cv=none; b=HXkEzBtdvWdS+YJik220+hOihU3hrm6GerJjjKWWoeV4n/2saNsO52y648M9w2UXy9+sKaO1s4SrIfxCG9wyjfePe/eNH6sks3AyghKpAFNHctuexmtsMYoCEINO4UQx2qFBWVs5xTv2hI1YYpXBlhjSQZXToJZzUqR5n1a66VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467170; c=relaxed/simple;
	bh=nx0RpLN/mN96xy1yOfQUK/Du603hJ5BDCjyOoSOW8eI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBO5quUyr392bfUwraMn9dgA5MRV3KM0ok5zcw1VCQ/j/92+r20DIjGNWwf5mNlOxLHGOb5Jwzn+cwupg+ycfyVPnW35FbOWDcpu8kAdg+58g3Jl390tNRK3wgr5EiYOmc4Tl5B20WI/TW792yfzDWFf1tPU+KowpFCqi5F0Zxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HcyXRMtm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WQwfG5Hl; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HcyXRMtm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WQwfG5Hl"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 692A11C00144
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:26:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 23 May 2024 08:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716467167; x=1716553567; bh=eulOP8eEuI
	KjJCuXOi3AlqMBOAT8XE1TAFUCiaHGsbQ=; b=HcyXRMtmYOqVSLT/RrfprmVNn7
	pOsUNeoaN/o8wIyB2BrDZBAfHgAwccLY8sJpL4EIVIXF1+6uO8zb1K/dpaXcsXcy
	jjue5LdLHPDPIwsKlqWtaX04s6y3b3uh1FIFiNYIdZIj1Jof/Z/ZQPQi4azxDhCh
	d+jf6mPN/cIs/ABwZ/CE8+KtnAfHI9ggyFyKia8t5YzM/TIyqrxI9YsLhGcd9iyp
	WYcTIx0R/s/nHy7R1TmNiqZP/jp31CLRN2w1FxnQYhI88X5cr7ZB07Jc+6k8gJfH
	vfA1NxTf0zpWx4hh610JueafL4UHZaQwh8+j4vGqZaAI5/5J1E8vvbn4ad+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716467167; x=1716553567; bh=eulOP8eEuIKjJCuXOi3AlqMBOAT8
	XE1TAFUCiaHGsbQ=; b=WQwfG5HlHE0MKGPqbUlk/kiuRJghWiW/0UEfudeI1cIz
	UzBEw2Nu5vrxjNssGeqK9SmmH3YATLR3ZobNltLwEH3QHvdaA/FFjhQ8/fPpipO/
	hrHX86bdd29MSnURjvFPxUvksR7FZ3izYahy2YIhoiomFV8IpS4+r+wz2+2dVUk9
	TUVzY38IMoV6BTlewFVMqUYeGsqOQKDJ7DDDs0oqOHNlp1iL/oEDbE6BCnWiaTq2
	r176Q9YycS6gNW1o3TYsS26oXM5EyCob2mbkD720wthILgf57FEtGmzlf1KeewrD
	vc+0X/beuDuadEhnQzS00OeIY/BWh9R5Qe/hcul+/A==
X-ME-Sender: <xms:3jVPZiu_cQRWWkHM5RuNApIu4oVj5MWkGjtUz8UItOYgfQ61UUXiHw>
    <xme:3jVPZncjyePm_QqZBK6MNPuR8DwStrfCzGp6WRYOOkBJO7Z3rIm6UB88ZsAb_hZ-C
    bFce_awoTIDZ5q5RA>
X-ME-Received: <xmr:3jVPZtxblY22nkcdYEYXHHwRKAhzTdK0ytJb5isU0zq2beFLaHxDY23KbpT2J1GDoX6Nyeil14urIAtCzJbypIYGWUlPw6F7g0vbBBNzNmjFBPLiSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:3jVPZtMw0zSQzUBLZbWqAJ8Uu-MXIyNU__6rBxaug6yKK1ke0kT14w>
    <xmx:3jVPZi8gkXS9_cFuy9-2a7FHIc5VflLJJzhNUBNSZUqwF6S71gFn_A>
    <xmx:3jVPZlWK7_L9vWcUQGQEPSRZhbnhpB-rYFRFAwImqwmg1Hw2SpRqbw>
    <xmx:3jVPZrfVP1VgnpT41Ewxql9IZtu_tFlJoehC6mCOrKLkT8X4Xr-OZg>
    <xmx:3zVPZoljYjEiC_Z2I7j8BuuP-jvM6RNi5MXZGcEbUEjWQQ0LWYYrUd0U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 08:26:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5f537cbd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 12:26:00 +0000 (UTC)
Date: Thu, 23 May 2024 14:26:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 11/20] config: clarify memory ownership in
 `git_config_string()`
Message-ID: <a857637e612e30d742689ffb95bee07184bff32f.1716465556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SWj1ELKPi7SrZTC3"
Content-Disposition: inline
In-Reply-To: <cover.1716465556.git.ps@pks.im>


--SWj1ELKPi7SrZTC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The out parameter of `git_config_string()` is a `const char **` even
though we transfer ownership of memory to the caller. This is quite
misleading and has led to many memory leaks all over the place. Adapt
the parameter to instead be `char **`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 alias.c                |  2 +-
 attr.c                 |  2 +-
 attr.h                 |  2 +-
 builtin/commit.c       |  2 +-
 builtin/log.c          | 12 ++++++------
 builtin/merge.c        |  4 ++--
 builtin/rebase.c       |  2 +-
 builtin/receive-pack.c |  2 +-
 builtin/repack.c       |  8 ++++----
 config.c               |  4 ++--
 config.h               |  2 +-
 convert.c              |  6 +++---
 delta-islands.c        |  2 +-
 diff.c                 |  8 ++++----
 environment.c          |  8 ++++----
 environment.h          |  8 ++++----
 gpg-interface.c        |  4 ++--
 http.c                 | 24 ++++++++++++------------
 imap-send.c            | 12 ++++++------
 mailmap.c              |  2 +-
 mailmap.h              |  2 +-
 merge-ll.c             |  6 +++---
 pager.c                |  2 +-
 pretty.c               | 14 +++++++++-----
 promisor-remote.h      |  2 +-
 remote.c               | 20 ++++++++++----------
 remote.h               |  8 ++++----
 sequencer.c            |  2 +-
 upload-pack.c          |  2 +-
 userdiff.h             | 12 ++++++------
 30 files changed, 95 insertions(+), 91 deletions(-)

diff --git a/alias.c b/alias.c
index 5a238f2e30..269892c356 100644
--- a/alias.c
+++ b/alias.c
@@ -22,7 +22,7 @@ static int config_alias_cb(const char *key, const char *v=
alue,
=20
 	if (data->alias) {
 		if (!strcasecmp(p, data->alias))
-			return git_config_string((const char **)&data->v,
+			return git_config_string(&data->v,
 						 key, value);
 	} else if (data->list) {
 		string_list_append(data->list, p);
diff --git a/attr.c b/attr.c
index 33473bdce0..5607db2bbe 100644
--- a/attr.c
+++ b/attr.c
@@ -25,7 +25,7 @@
 #include "tree-walk.h"
 #include "object-name.h"
=20
-const char *git_attr_tree;
+char *git_attr_tree;
=20
 const char git_attr__true[] =3D "(builtin)true";
 const char git_attr__false[] =3D "\0(builtin)false";
diff --git a/attr.h b/attr.h
index 127998ae01..e7cc318b0c 100644
--- a/attr.h
+++ b/attr.h
@@ -236,6 +236,6 @@ const char *git_attr_global_file(void);
 /* Return whether the system gitattributes file is enabled and should be u=
sed. */
 int git_attr_system_is_enabled(void);
=20
-extern const char *git_attr_tree;
+extern char *git_attr_tree;
=20
 #endif /* ATTR_H */
diff --git a/builtin/commit.c b/builtin/commit.c
index 1cc88e92bf..f53e7e86ff 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -133,7 +133,7 @@ static struct strvec trailer_args =3D STRVEC_INIT;
  * is specified explicitly.
  */
 static enum commit_msg_cleanup_mode cleanup_mode;
-static const char *cleanup_arg;
+static char *cleanup_arg;
=20
 static enum commit_whence whence;
 static int use_editor =3D 1, include_status =3D 1;
diff --git a/builtin/log.c b/builtin/log.c
index 890bf0c425..517d7982f1 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -582,11 +582,11 @@ static int git_log_config(const char *var, const char=
 *value,
=20
 	if (!strcmp(var, "format.pretty")) {
 		FREE_AND_NULL(cfg->fmt_pretty);
-		return git_config_string((const char **) &cfg->fmt_pretty, var, value);
+		return git_config_string(&cfg->fmt_pretty, var, value);
 	}
 	if (!strcmp(var, "format.subjectprefix")) {
 		FREE_AND_NULL(cfg->fmt_patch_subject_prefix);
-		return git_config_string((const char **) &cfg->fmt_patch_subject_prefix,=
 var, value);
+		return git_config_string(&cfg->fmt_patch_subject_prefix, var, value);
 	}
 	if (!strcmp(var, "format.filenamemaxlength")) {
 		cfg->fmt_patch_name_max =3D git_config_int(var, value, ctx->kvi);
@@ -602,7 +602,7 @@ static int git_log_config(const char *var, const char *=
value,
 	}
 	if (!strcmp(var, "log.date")) {
 		FREE_AND_NULL(cfg->default_date_mode);
-		return git_config_string((const char **) &cfg->default_date_mode, var, v=
alue);
+		return git_config_string(&cfg->default_date_mode, var, value);
 	}
 	if (!strcmp(var, "log.decorate")) {
 		cfg->decoration_style =3D parse_decoration_style(value);
@@ -1076,7 +1076,7 @@ static int git_format_config(const char *var, const c=
har *value,
 	}
 	if (!strcmp(var, "format.suffix")) {
 		FREE_AND_NULL(cfg->fmt_patch_suffix);
-		return git_config_string((const char **) &cfg->fmt_patch_suffix, var, va=
lue);
+		return git_config_string(&cfg->fmt_patch_suffix, var, value);
 	}
 	if (!strcmp(var, "format.to")) {
 		if (!value)
@@ -1133,7 +1133,7 @@ static int git_format_config(const char *var, const c=
har *value,
 	}
 	if (!strcmp(var, "format.signature")) {
 		FREE_AND_NULL(cfg->signature);
-		return git_config_string((const char **) &cfg->signature, var, value);
+		return git_config_string(&cfg->signature, var, value);
 	}
 	if (!strcmp(var, "format.signaturefile")) {
 		FREE_AND_NULL(cfg->signature_file);
@@ -1149,7 +1149,7 @@ static int git_format_config(const char *var, const c=
har *value,
 	}
 	if (!strcmp(var, "format.outputdirectory")) {
 		FREE_AND_NULL(cfg->config_output_directory);
-		return git_config_string((const char **) &cfg->config_output_directory, =
var, value);
+		return git_config_string(&cfg->config_output_directory, var, value);
 	}
 	if (!strcmp(var, "format.useautobase")) {
 		if (value && !strcasecmp(value, "whenAble")) {
diff --git a/builtin/merge.c b/builtin/merge.c
index e4bd65eeba..daed2d4e1e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -100,7 +100,7 @@ static struct strategy all_strategy[] =3D {
 	{ "subtree",    NO_FAST_FORWARD | NO_TRIVIAL },
 };
=20
-static const char *pull_twohead, *pull_octopus;
+static char *pull_twohead, *pull_octopus;
=20
 enum ff_type {
 	FF_NO,
@@ -110,7 +110,7 @@ enum ff_type {
=20
 static enum ff_type fast_forward =3D FF_ALLOW;
=20
-static const char *cleanup_arg;
+static char *cleanup_arg;
 static enum commit_msg_cleanup_mode cleanup_mode;
=20
 static int option_parse_message(const struct option *opt,
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0466d9414a..14d4f0a5e6 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -83,7 +83,7 @@ static const char *action_names[] =3D {
 struct rebase_options {
 	enum rebase_type type;
 	enum empty_type empty;
-	const char *default_backend;
+	char *default_backend;
 	const char *state_dir;
 	struct commit *upstream;
 	const char *upstream_name;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 56228ad314..01c1f04ece 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -88,7 +88,7 @@ static struct strbuf push_cert =3D STRBUF_INIT;
 static struct object_id push_cert_oid;
 static struct signature_check sigcheck;
 static const char *push_cert_nonce;
-static const char *cert_nonce_seed;
+static char *cert_nonce_seed;
 static struct strvec hidden_refs =3D STRVEC_INIT;
=20
 static const char *NONCE_UNSOLICITED =3D "UNSOLICITED";
diff --git a/builtin/repack.c b/builtin/repack.c
index 43491a4cbf..e40dceaada 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -48,10 +48,10 @@ static const char incremental_bitmap_conflict_error[] =
=3D N_(
 );
=20
 struct pack_objects_args {
-	const char *window;
-	const char *window_memory;
-	const char *depth;
-	const char *threads;
+	char *window;
+	char *window_memory;
+	char *depth;
+	char *threads;
 	unsigned long max_pack_size;
 	int no_reuse_delta;
 	int no_reuse_object;
diff --git a/config.c b/config.c
index f9101045ee..a025cfafe0 100644
--- a/config.c
+++ b/config.c
@@ -1338,7 +1338,7 @@ int git_config_bool(const char *name, const char *val=
ue)
 	return v;
 }
=20
-int git_config_string(const char **dest, const char *var, const char *valu=
e)
+int git_config_string(char **dest, const char *var, const char *value)
 {
 	if (!value)
 		return config_error_nonbool(var);
@@ -2418,7 +2418,7 @@ int git_configset_get_string(struct config_set *set, =
const char *key, char **des
 {
 	const char *value;
 	if (!git_configset_get_value(set, key, &value, NULL))
-		return git_config_string((const char **)dest, key, value);
+		return git_config_string(dest, key, value);
 	else
 		return 1;
 }
diff --git a/config.h b/config.h
index b3103bba94..2d2e22ed64 100644
--- a/config.h
+++ b/config.h
@@ -280,7 +280,7 @@ int git_config_bool(const char *, const char *);
  * Allocates and copies the value string into the `dest` parameter; if no
  * string is given, prints an error message and returns -1.
  */
-int git_config_string(const char **, const char *, const char *);
+int git_config_string(char **, const char *, const char *);
=20
 /**
  * Similar to `git_config_string`, but expands `~` or `~user` into the
diff --git a/convert.c b/convert.c
index 03c3c528f9..f2b9f01354 100644
--- a/convert.c
+++ b/convert.c
@@ -981,9 +981,9 @@ int async_query_available_blobs(const char *cmd, struct=
 string_list *available_p
 static struct convert_driver {
 	const char *name;
 	struct convert_driver *next;
-	const char *smudge;
-	const char *clean;
-	const char *process;
+	char *smudge;
+	char *clean;
+	char *process;
 	int required;
 } *user_convert, **user_convert_tail;
=20
diff --git a/delta-islands.c b/delta-islands.c
index 4ac3c10551..89d51b72e3 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -313,7 +313,7 @@ struct island_load_data {
 	size_t nr;
 	size_t alloc;
 };
-static const char *core_island_name;
+static char *core_island_name;
=20
 static void free_config_regexes(struct island_load_data *ild)
 {
diff --git a/diff.c b/diff.c
index 679ef472f4..e70301df76 100644
--- a/diff.c
+++ b/diff.c
@@ -56,8 +56,8 @@ static int diff_color_moved_default;
 static int diff_color_moved_ws_default;
 static int diff_context_default =3D 3;
 static int diff_interhunk_context_default;
-static const char *diff_word_regex_cfg;
-static const char *external_diff_cmd_cfg;
+static char *diff_word_regex_cfg;
+static char *external_diff_cmd_cfg;
 static char *diff_order_file_cfg;
 int diff_auto_refresh_index =3D 1;
 static int diff_mnemonic_prefix;
@@ -412,11 +412,11 @@ int git_diff_ui_config(const char *var, const char *v=
alue,
 	}
 	if (!strcmp(var, "diff.srcprefix")) {
 		FREE_AND_NULL(diff_src_prefix);
-		return git_config_string((const char **) &diff_src_prefix, var, value);
+		return git_config_string(&diff_src_prefix, var, value);
 	}
 	if (!strcmp(var, "diff.dstprefix")) {
 		FREE_AND_NULL(diff_dst_prefix);
-		return git_config_string((const char **) &diff_dst_prefix, var, value);
+		return git_config_string(&diff_dst_prefix, var, value);
 	}
 	if (!strcmp(var, "diff.relative")) {
 		diff_relative =3D git_config_bool(var, value);
diff --git a/environment.c b/environment.c
index ab6956559e..701d515135 100644
--- a/environment.c
+++ b/environment.c
@@ -42,8 +42,8 @@ int is_bare_repository_cfg =3D -1; /* unspecified */
 int warn_ambiguous_refs =3D 1;
 int warn_on_object_refname_ambiguity =3D 1;
 int repository_format_precious_objects;
-const char *git_commit_encoding;
-const char *git_log_output_encoding;
+char *git_commit_encoding;
+char *git_log_output_encoding;
 char *apply_default_whitespace;
 char *apply_default_ignorewhitespace;
 char *git_attributes_file;
@@ -58,8 +58,8 @@ size_t packed_git_window_size =3D DEFAULT_PACKED_GIT_WIND=
OW_SIZE;
 size_t packed_git_limit =3D DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit =3D 96 * 1024 * 1024;
 unsigned long big_file_threshold =3D 512 * 1024 * 1024;
-const char *editor_program;
-const char *askpass_program;
+char *editor_program;
+char *askpass_program;
 char *excludes_file;
 enum auto_crlf auto_crlf =3D AUTO_CRLF_FALSE;
 enum eol core_eol =3D EOL_UNSET;
diff --git a/environment.h b/environment.h
index be1b88ad6f..e9f01d4d11 100644
--- a/environment.h
+++ b/environment.h
@@ -224,11 +224,11 @@ int odb_pack_keep(const char *name);
 const char *get_log_output_encoding(void);
 const char *get_commit_output_encoding(void);
=20
-extern const char *git_commit_encoding;
-extern const char *git_log_output_encoding;
+extern char *git_commit_encoding;
+extern char *git_log_output_encoding;
=20
-extern const char *editor_program;
-extern const char *askpass_program;
+extern char *editor_program;
+extern char *askpass_program;
 extern char *excludes_file;
=20
 /*
diff --git a/gpg-interface.c b/gpg-interface.c
index 2b50ed0fa0..5193223714 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -27,14 +27,14 @@ static void gpg_interface_lazy_init(void)
 }
=20
 static char *configured_signing_key;
-static const char *ssh_default_key_command;
+static char *ssh_default_key_command;
 static char *ssh_allowed_signers;
 static char *ssh_revocation_file;
 static enum signature_trust_level configured_min_trust_level =3D TRUST_UND=
EFINED;
=20
 struct gpg_format {
 	const char *name;
-	const char *program;
+	char *program;
 	const char **verify_args;
 	const char **sigs;
 	int (*verify_signed_buffer)(struct signature_check *sigc,
diff --git a/http.c b/http.c
index fa3ea87451..67cc47d28f 100644
--- a/http.c
+++ b/http.c
@@ -38,11 +38,11 @@ char curl_errorstr[CURL_ERROR_SIZE];
=20
 static int curl_ssl_verify =3D -1;
 static int curl_ssl_try;
-static const char *curl_http_version =3D NULL;
+static char *curl_http_version;
 static char *ssl_cert;
 static char *ssl_cert_type;
-static const char *ssl_cipherlist;
-static const char *ssl_version;
+static char *ssl_cipherlist;
+static char *ssl_version;
 static struct {
 	const char *name;
 	long ssl_version;
@@ -95,7 +95,7 @@ static struct {
 	 */
 };
 #ifdef CURLGSSAPI_DELEGATION_FLAG
-static const char *curl_deleg;
+static char *curl_deleg;
 static struct {
 	const char *name;
 	long curl_deleg_param;
@@ -383,11 +383,11 @@ static int http_options(const char *var, const char *=
value,
 	if (!strcmp("http.sslcert", var))
 		return git_config_pathname(&ssl_cert, var, value);
 	if (!strcmp("http.sslcerttype", var))
-		return git_config_string((const char **)&ssl_cert_type, var, value);
+		return git_config_string(&ssl_cert_type, var, value);
 	if (!strcmp("http.sslkey", var))
 		return git_config_pathname(&ssl_key, var, value);
 	if (!strcmp("http.sslkeytype", var))
-		return git_config_string((const char **)&ssl_key_type, var, value);
+		return git_config_string(&ssl_key_type, var, value);
 	if (!strcmp("http.sslcapath", var))
 		return git_config_pathname(&ssl_capath, var, value);
 	if (!strcmp("http.sslcainfo", var))
@@ -440,19 +440,19 @@ static int http_options(const char *var, const char *=
value,
 		return 0;
 	}
 	if (!strcmp("http.proxy", var))
-		return git_config_string((const char **)&curl_http_proxy, var, value);
+		return git_config_string(&curl_http_proxy, var, value);
=20
 	if (!strcmp("http.proxyauthmethod", var))
-		return git_config_string((const char **)&http_proxy_authmethod, var, val=
ue);
+		return git_config_string(&http_proxy_authmethod, var, value);
=20
 	if (!strcmp("http.proxysslcert", var))
-		return git_config_string((const char **)&http_proxy_ssl_cert, var, value=
);
+		return git_config_string(&http_proxy_ssl_cert, var, value);
=20
 	if (!strcmp("http.proxysslkey", var))
-		return git_config_string((const char **)&http_proxy_ssl_key, var, value);
+		return git_config_string(&http_proxy_ssl_key, var, value);
=20
 	if (!strcmp("http.proxysslcainfo", var))
-		return git_config_string((const char **)&http_proxy_ssl_ca_info, var, va=
lue);
+		return git_config_string(&http_proxy_ssl_ca_info, var, value);
=20
 	if (!strcmp("http.proxysslcertpasswordprotected", var)) {
 		proxy_ssl_cert_password_required =3D git_config_bool(var, value);
@@ -476,7 +476,7 @@ static int http_options(const char *var, const char *va=
lue,
 	}
=20
 	if (!strcmp("http.useragent", var))
-		return git_config_string((const char **)&user_agent, var, value);
+		return git_config_string(&user_agent, var, value);
=20
 	if (!strcmp("http.emptyauth", var)) {
 		if (value && !strcmp("auto", value))
diff --git a/imap-send.c b/imap-send.c
index c0130d0e02..a5d1510180 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -70,16 +70,16 @@ static char *next_arg(char **);
=20
 struct imap_server_conf {
 	const char *name;
-	const char *tunnel;
-	const char *host;
+	char *tunnel;
+	char *host;
 	int port;
-	const char *folder;
-	const char *user;
-	const char *pass;
+	char *folder;
+	char *user;
+	char *pass;
 	int use_ssl;
 	int ssl_verify;
 	int use_html;
-	const char *auth_method;
+	char *auth_method;
 };
=20
 static struct imap_server_conf server =3D {
diff --git a/mailmap.c b/mailmap.c
index 044466b043..b2efe29b3d 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -7,7 +7,7 @@
 #include "setup.h"
=20
 char *git_mailmap_file;
-const char *git_mailmap_blob;
+char *git_mailmap_blob;
=20
 struct mailmap_info {
 	char *name;
diff --git a/mailmap.h b/mailmap.h
index 429a760945..cbda9bc5e0 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -4,7 +4,7 @@
 struct string_list;
=20
 extern char *git_mailmap_file;
-extern const char *git_mailmap_blob;
+extern char *git_mailmap_blob;
=20
 int read_mailmap(struct string_list *map);
 void clear_mailmap(struct string_list *map);
diff --git a/merge-ll.c b/merge-ll.c
index bf1077ae09..e29b15fa4a 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -27,9 +27,9 @@ typedef enum ll_merge_result (*ll_merge_fn)(const struct =
ll_merge_driver *,
=20
 struct ll_merge_driver {
 	const char *name;
-	const char *description;
+	char *description;
 	ll_merge_fn fn;
-	const char *recursive;
+	char *recursive;
 	struct ll_merge_driver *next;
 	char *cmdline;
 };
@@ -268,7 +268,7 @@ static enum ll_merge_result ll_ext_merge(const struct l=
l_merge_driver *fn,
  * merge.default and merge.driver configuration items
  */
 static struct ll_merge_driver *ll_user_merge, **ll_user_merge_tail;
-static const char *default_ll_merge;
+static char *default_ll_merge;
=20
 static int read_merge_config(const char *var, const char *value,
 			     const struct config_context *ctx UNUSED,
diff --git a/pager.c b/pager.c
index b8822a9381..e9e121db69 100644
--- a/pager.c
+++ b/pager.c
@@ -13,7 +13,7 @@ int pager_use_color =3D 1;
 #endif
=20
 static struct child_process pager_process;
-static const char *pager_program;
+static char *pager_program;
=20
 /* Is the value coming back from term_columns() just a guess? */
 static int term_columns_guessed;
diff --git a/pretty.c b/pretty.c
index 7ead078998..22a81506b7 100644
--- a/pretty.c
+++ b/pretty.c
@@ -62,7 +62,7 @@ static int git_pretty_formats_config(const char *var, con=
st char *value,
 {
 	struct cmt_fmt_map *commit_format =3D NULL;
 	const char *name;
-	const char *fmt;
+	char *fmt;
 	int i;
=20
 	if (!skip_prefix(var, "pretty.", &name))
@@ -93,13 +93,17 @@ static int git_pretty_formats_config(const char *var, c=
onst char *value,
 	if (git_config_string(&fmt, var, value))
 		return -1;
=20
-	if (skip_prefix(fmt, "format:", &fmt))
+	if (skip_prefix(fmt, "format:", &commit_format->user_format)) {
 		commit_format->is_tformat =3D 0;
-	else if (skip_prefix(fmt, "tformat:", &fmt) || strchr(fmt, '%'))
+	} else if (skip_prefix(fmt, "tformat:", &commit_format->user_format)) {
 		commit_format->is_tformat =3D 1;
-	else
+	} else if (strchr(fmt, '%')) {
+		commit_format->is_tformat =3D 1;
+		commit_format->user_format =3D fmt;
+	} else {
 		commit_format->is_alias =3D 1;
-	commit_format->user_format =3D fmt;
+		commit_format->user_format =3D fmt;
+	}
=20
 	return 0;
 }
diff --git a/promisor-remote.h b/promisor-remote.h
index 2cb9eda9ea..88cb599c39 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -13,7 +13,7 @@ struct object_id;
  */
 struct promisor_remote {
 	struct promisor_remote *next;
-	const char *partial_clone_filter;
+	char *partial_clone_filter;
 	const char name[FLEX_ARRAY];
 };
=20
diff --git a/remote.c b/remote.c
index ec8c158e60..d319f28757 100644
--- a/remote.c
+++ b/remote.c
@@ -428,29 +428,29 @@ static int handle_config(const char *key, const char =
*value,
 	else if (!strcmp(subkey, "prunetags"))
 		remote->prune_tags =3D git_config_bool(key, value);
 	else if (!strcmp(subkey, "url")) {
-		const char *v;
+		char *v;
 		if (git_config_string(&v, key, value))
 			return -1;
 		add_url(remote, v);
 	} else if (!strcmp(subkey, "pushurl")) {
-		const char *v;
+		char *v;
 		if (git_config_string(&v, key, value))
 			return -1;
 		add_pushurl(remote, v);
 	} else if (!strcmp(subkey, "push")) {
-		const char *v;
+		char *v;
 		if (git_config_string(&v, key, value))
 			return -1;
 		refspec_append(&remote->push, v);
-		free((char *)v);
+		free(v);
 	} else if (!strcmp(subkey, "fetch")) {
-		const char *v;
+		char *v;
 		if (git_config_string(&v, key, value))
 			return -1;
 		refspec_append(&remote->fetch, v);
-		free((char *)v);
+		free(v);
 	} else if (!strcmp(subkey, "receivepack")) {
-		const char *v;
+		char *v;
 		if (git_config_string(&v, key, value))
 			return -1;
 		if (!remote->receivepack)
@@ -458,7 +458,7 @@ static int handle_config(const char *key, const char *v=
alue,
 		else
 			error(_("more than one receivepack given, using the first"));
 	} else if (!strcmp(subkey, "uploadpack")) {
-		const char *v;
+		char *v;
 		if (git_config_string(&v, key, value))
 			return -1;
 		if (!remote->uploadpack)
@@ -471,10 +471,10 @@ static int handle_config(const char *key, const char =
*value,
 		else if (!strcmp(value, "--tags"))
 			remote->fetch_tags =3D 2;
 	} else if (!strcmp(subkey, "proxy")) {
-		return git_config_string((const char **)&remote->http_proxy,
+		return git_config_string(&remote->http_proxy,
 					 key, value);
 	} else if (!strcmp(subkey, "proxyauthmethod")) {
-		return git_config_string((const char **)&remote->http_proxy_authmethod,
+		return git_config_string(&remote->http_proxy_authmethod,
 					 key, value);
 	} else if (!strcmp(subkey, "vcs")) {
 		return git_config_string(&remote->foreign_vcs, key, value);
diff --git a/remote.h b/remote.h
index dfd4837e60..e8c6655e42 100644
--- a/remote.h
+++ b/remote.h
@@ -46,7 +46,7 @@ struct remote_state {
 	struct hashmap branches_hash;
=20
 	struct branch *current_branch;
-	const char *pushremote_name;
+	char *pushremote_name;
=20
 	struct rewrites rewrites;
 	struct rewrites rewrites_push;
@@ -65,7 +65,7 @@ struct remote {
=20
 	int origin, configured_in_repo;
=20
-	const char *foreign_vcs;
+	char *foreign_vcs;
=20
 	/* An array of all of the url_nr URLs configured for the remote */
 	const char **url;
@@ -309,9 +309,9 @@ struct branch {
 	const char *refname;
=20
 	/* The name of the remote listed in the configuration. */
-	const char *remote_name;
+	char *remote_name;
=20
-	const char *pushremote_name;
+	char *pushremote_name;
=20
 	/* An array of the "merge" lines in the configuration. */
 	const char **merge_name;
diff --git a/sequencer.c b/sequencer.c
index dbd60d79b9..3c81ef9ca5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -306,7 +306,7 @@ static int git_sequencer_config(const char *k, const ch=
ar *v,
 	}
=20
 	if (!opts->default_strategy && !strcmp(k, "pull.twohead")) {
-		int ret =3D git_config_string((const char**)&opts->default_strategy, k, =
v);
+		int ret =3D git_config_string(&opts->default_strategy, k, v);
 		if (ret =3D=3D 0) {
 			/*
 			 * pull.twohead is allowed to be multi-valued; we only
diff --git a/upload-pack.c b/upload-pack.c
index 8fbd138515..5801eb2639 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -94,7 +94,7 @@ struct upload_pack_data {
=20
 	struct packet_writer writer;
=20
-	const char *pack_objects_hook;
+	char *pack_objects_hook;
=20
 	unsigned stateless_rpc : 1;				/* v0 only */
 	unsigned no_done : 1;					/* v0 only */
diff --git a/userdiff.h b/userdiff.h
index d726804c3e..cc8e5abfef 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -7,19 +7,19 @@ struct index_state;
 struct repository;
=20
 struct userdiff_funcname {
-	const char *pattern;
+	char *pattern;
 	int cflags;
 };
=20
 struct userdiff_driver {
 	const char *name;
-	const char *external;
-	const char *algorithm;
+	char *external;
+	char *algorithm;
 	int binary;
 	struct userdiff_funcname funcname;
-	const char *word_regex;
-	const char *word_regex_multi_byte;
-	const char *textconv;
+	char *word_regex;
+	char *word_regex_multi_byte;
+	char *textconv;
 	struct notes_cache *textconv_cache;
 	int textconv_want_cache;
 };
--=20
2.45.1.216.g4365c6fcf9.dirty


--SWj1ELKPi7SrZTC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZPNdsACgkQVbJhu7ck
PpS9kw/9HJFBvnQ4+lM2KrAzeX4FJ2aVC4573lAK874RnrD34UtIWdfwTG+JgJIo
6aFarWe6oRBB2qI0bG27rF0Xb/eBj/7Lc7XgBvFzsAbXXIgE+gag/J3Q3tlsUoVM
aH9NM+Ki96yu6Ndzth3tTEXe0UBgiwcrxy8YWTGwqEQji07TP/M7pNNNIuy+nApu
QpL6yJV2MYhbRRRFtB08MG7Y+H/cRMpvuY32f7sug+kgsQGqekcJur7F4mA359Nr
t9MbNooWoK7mLsFCMRynMnS8uDeEZ1AYr5GFSroPHqBcNQ9uSnxC2J+vqoZ4Ep1W
Bb6hcuDUaG126776RH9ZZylEQI4ghmrNDOM6HAkisdKlOEFiiyEd/PXfgc6PfXIf
5lmp0oLsdIcltTXig8g2Gqjb7I19gyXGq+XO+uuNbFGnq1GXZLSCfpqmXjfNG58L
WqYO9aUR3OXlo9df2NHFHyDI1CCTLxHoOVHplTkx+0JUI0v2vLtI2pCauyAXFZ9P
FYJaHiPe4IPST1xsubNSyoXFzO0E4+mVoG3g3IV9xFYjjiFj9yq3o4MIHUq6vhzw
FmVFEqd7JY03ymDejr0N1EmqATaq+gR65UWjCKHMmSBL01KidB+DCGCE7buDuA7B
462T9heoRNM1GBMnemBxk0FLSsy+mMcW7Yy3VsUMSWB8KOOkj14=
=J1Cd
-----END PGP SIGNATURE-----

--SWj1ELKPi7SrZTC3--
