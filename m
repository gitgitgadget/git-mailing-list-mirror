Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5621F239B
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991663; cv=none; b=TEn8dGacBwTGhpO7kZMm0dzAAEKjohvXtQth+S3C9GuCSDR+KABZ8qWtoinBP+r60LBYviahbeLztQbW9CtMa4oiTqMaKevPEr9ECMjmiMwrv+f6pox1waxglTdXMYO0+LZcXvLtvyKm8N9SF5WKd0eRmicEA7ugcO4PIReShlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991663; c=relaxed/simple;
	bh=HFJRsFdCxgnVmspaATJ8XdY9YD1XVoVYtoAyjX4P8yc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVDjbUurxpAsDYp8tysVtQp1IoOGpJhZgYYQSfknBQ3M8PMh35ICMeeJaYQv7kJxlNAXlMIt8K5oSJfDm4m6y0yFWgr5Z7HbfzUI93JLVbgdXzP6ov182rt3F4YGKdB+c48Lcv/DGYDTYPcqk0relfhpcVzSE3Ph59UqfkZaqyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JGLxnstW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yxqiE0WV; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JGLxnstW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yxqiE0WV"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 0FD3E1140164
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 03:47:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 03 Mar 2025 03:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740991659;
	 x=1741078059; bh=MPLFNoIs3tTs0lZPUKf9tBSJyj/7ZbGI0i7iAlZOdPc=; b=
	JGLxnstW4MS3Dm1IhnnsYjJif7bd1abJJ+BJEpFJCLEOZGEn2dqokIemqEvwHe06
	TbiGYfCmRnFBF3aZiMFjuUQdUkh2ForQXuclrE4VrCdlxM5dZ28gunlXW5rs2jEW
	bWsptmZgZ+iTuuCLcov3Rf+R1ydqzmnRRpTZJ09nvuPrE+wi2AVx+s7IYe+njOV4
	L3h4WFeizK8njjn2rSRb/bVuUmxGk13jVLyXYqHtHbp5xS1Ym+Q7EmflxOwFKjDr
	ZEgQ+4qdPP5JTrH0016+QyCf7dVvgKu6Tb7Zl2p1faq8VzX71WIeMhpQQFVR52Eb
	4pn3OfXtCv3bXpkSdH+V6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740991659; x=
	1741078059; bh=MPLFNoIs3tTs0lZPUKf9tBSJyj/7ZbGI0i7iAlZOdPc=; b=y
	xqiE0WVQQSNCpG7cGjM9XCv+yTKnWoSQpKdrW466NEDlkFvKGXCLHyIoxnXmS2Rg
	LjRWkmbzay/dxwqKfsb3OWNsxa4VoikRdBKNYsrfCiK0gS+or9YX4rahUBVodxyR
	6IWpAL9c8HQs5QIpKe4ip37ZFIwvIRpU29V2Fw94q9HL55b3bB/oQAEcJuLywyyA
	nUzyo2SctbhjYEOCsoPMQB501Q1BnCx6X5QNa1O2wcWrMXblX8HY9UplX/FXVoGS
	1f29FiwfLGcKe4IF39gFk4h6qajMgR7qpQAVXbXmazBDmF6WXz1m8jiCOhVc2CzP
	8/y49T7yHM8mTFqgm5EJg==
X-ME-Sender: <xms:q2zFZ-_-L8JVZHvYm_semyv36DkeLBHM_sYUmZLZv0_FCXbzuUT5bg>
    <xme:q2zFZ-thxFsIqUh2XIFgxf8PN_sCiDsAC4eMci3KVpYXH5CX5wzaCWlcyPTworAtn
    vkQWgZpVSuHVqz2CA>
X-ME-Received: <xmr:q2zFZ0Arm4hJjYWbaQoPMZoxMDyibHrvMJ62R1VgXzohxxzlaiEHitDMeTeHC7sRpMZboEULUpHni3Q3yx2DmLdOYCLYt3oddfw77mODW8ZLjFzF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfvvgigthfqnhhlhi
    dqqdetfeejfedqtdegucdlhedtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthej
    redtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhsse
    hpkhhsrdhimheqnecuggftrfgrthhtvghrnhepjeefgfevleetfeefteegudeugeeikeek
    teffleeuiedtgefhteegkedvteetheevnecuffhomhgrihhnpehshhgrrhgvughrvghpoh
    hsihhtohhrhidrihhnthdpphgrtghkvggurdhishenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtth
    hopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:q2zFZ2dW0DZV6iUsM8ftq7zYtI78zUB34z-IoiLqJzpXTVt5RogOMw>
    <xmx:q2zFZzMYjbmgydCgyHcGcaYLPwnDTyix6OYHSseucW66MlvYt56FyQ>
    <xmx:q2zFZwm8u85ElDZZ_B1Hu9L7syiaBUiK7zShjwvQKrBTO3fT6-lh8A>
    <xmx:q2zFZ1u3yElqi7KRK0pzc9D6rC1-nQnHvTg9Q3o1MozD0Fwr7Wa2zg>
    <xmx:q2zFZ50nvwe8tobGDpqMKoVTT2heYxtdtQmoNdoVtN8-4vmyRUjcq0gz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Mar 2025 03:47:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ff793d5d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Mar 2025 08:47:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Mar 2025 09:47:33 +0100
Subject: [PATCH 04/12] environment: move access to "core.bigFileThreshold"
 into repo settings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-b4-pks-objects-without-the-repository-v1-4-c5dd43f2476e@pks.im>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The "core.bigFileThreshold" setting is stored in a global variable and
populated via `git_default_core_config()`. This may cause issues in
the case where one is handling multiple different repositories in a
single process with different values for that config key, as we may or
may not see the correct value in that case. Furthermore, global state
blocks our path towards libification.

Refactor the code so that we instead store the value in `struct
repo_settings`, where the value is computed as-needed and cached.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 archive.c                |  2 +-
 builtin/fast-import.c    |  4 ++--
 builtin/index-pack.c     |  6 ++++--
 builtin/pack-objects.c   |  6 ++++--
 builtin/unpack-objects.c |  3 ++-
 config.c                 |  5 -----
 diff.c                   |  6 ++++--
 environment.c            |  1 -
 environment.h            |  1 -
 object-file.c            |  6 ++++--
 pack-check.c             |  3 ++-
 repo-settings.c          | 20 ++++++++++++++++++++
 repo-settings.h          |  5 +++++
 streaming.c              |  3 ++-
 t/t1050-large.sh         |  3 ++-
 15 files changed, 52 insertions(+), 22 deletions(-)

diff --git a/archive.c b/archive.c
index 8be4e7ac8db..f4331aeb49e 100644
--- a/archive.c
+++ b/archive.c
@@ -216,7 +216,7 @@ static int write_archive_entry(const struct object_id *oid, const char *base,
 	/* Stream it? */
 	if (S_ISREG(mode) && !args->convert &&
 	    oid_object_info(args->repo, oid, &size) == OBJ_BLOB &&
-	    size > big_file_threshold)
+	    size > repo_settings_get_big_file_threshold(the_repository))
 		return write_entry(args, oid, path.buf, path.len, mode, NULL, size);
 
 	buffer = object_file_to_archive(args, path.buf, oid, mode, &type, &size);
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index e1758aa9514..ce52f78579d 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2021,7 +2021,7 @@ static void parse_and_store_blob(
 	static struct strbuf buf = STRBUF_INIT;
 	uintmax_t len;
 
-	if (parse_data(&buf, big_file_threshold, &len))
+	if (parse_data(&buf, repo_settings_get_big_file_threshold(the_repository), &len))
 		store_object(OBJ_BLOB, &buf, last, oidout, mark);
 	else {
 		if (last) {
@@ -3402,7 +3402,7 @@ static int parse_one_option(const char *option)
 		unsigned long v;
 		if (!git_parse_ulong(option, &v))
 			return 0;
-		big_file_threshold = v;
+		repo_settings_set_big_file_threshold(the_repository, v);
 	} else if (skip_prefix(option, "depth=", &option)) {
 		option_depth(option);
 	} else if (skip_prefix(option, "active-branches=", &option)) {
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index e4f2aa01ed5..4235215a1fd 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -485,7 +485,8 @@ static void *unpack_entry_data(off_t offset, unsigned long size,
 		git_hash_update(&c, hdr, hdrlen);
 	} else
 		oid = NULL;
-	if (type == OBJ_BLOB && size > big_file_threshold)
+	if (type == OBJ_BLOB &&
+	    size > repo_settings_get_big_file_threshold(the_repository))
 		buf = fixed_buf;
 	else
 		buf = xmallocz(size);
@@ -799,7 +800,8 @@ static int check_collison(struct object_entry *entry)
 	enum object_type type;
 	unsigned long size;
 
-	if (entry->size <= big_file_threshold || entry->type != OBJ_BLOB)
+	if (entry->size <= repo_settings_get_big_file_threshold(the_repository) ||
+	    entry->type != OBJ_BLOB)
 		return -1;
 
 	memset(&data, 0, sizeof(data));
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e05dfc4021e..eefc6c78096 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -499,7 +499,8 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 
 	if (!usable_delta) {
 		if (oe_type(entry) == OBJ_BLOB &&
-		    oe_size_greater_than(&to_pack, entry, big_file_threshold) &&
+		    oe_size_greater_than(&to_pack, entry,
+					 repo_settings_get_big_file_threshold(the_repository)) &&
 		    (st = open_istream(the_repository, &entry->idx.oid, &type,
 				       &size, NULL)) != NULL)
 			buf = NULL;
@@ -2454,7 +2455,8 @@ static void get_object_details(void)
 		struct object_entry *entry = sorted_by_offset[i];
 		check_object(entry, i);
 		if (entry->type_valid &&
-		    oe_size_greater_than(&to_pack, entry, big_file_threshold))
+		    oe_size_greater_than(&to_pack, entry,
+					 repo_settings_get_big_file_threshold(the_repository)))
 			entry->no_try_delta = 1;
 		display_progress(progress_state, i + 1);
 	}
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 8383bcf4049..e20c120913e 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -553,7 +553,8 @@ static void unpack_one(unsigned nr)
 
 	switch (type) {
 	case OBJ_BLOB:
-		if (!dry_run && size > big_file_threshold) {
+		if (!dry_run &&
+		    size > repo_settings_get_big_file_threshold(the_repository)) {
 			stream_blob(size, nr);
 			return;
 		}
diff --git a/config.c b/config.c
index dfd03b9421c..dc95608f749 100644
--- a/config.c
+++ b/config.c
@@ -1490,11 +1490,6 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (!strcmp(var, "core.bigfilethreshold")) {
-		big_file_threshold = git_config_ulong(var, value, ctx->kvi);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.autocrlf")) {
 		if (value && !strcasecmp(value, "input")) {
 			auto_crlf = AUTO_CRLF_INPUT;
diff --git a/diff.c b/diff.c
index c89c15d98e0..4f802b4251c 100644
--- a/diff.c
+++ b/diff.c
@@ -4193,7 +4193,8 @@ int diff_populate_filespec(struct repository *r,
 		 * is probably fine.
 		 */
 		if (check_binary &&
-		    s->size > big_file_threshold && s->is_binary == -1) {
+		    s->size > repo_settings_get_big_file_threshold(the_repository) &&
+		    s->is_binary == -1) {
 			s->is_binary = 1;
 			return 0;
 		}
@@ -4243,7 +4244,8 @@ int diff_populate_filespec(struct repository *r,
 		if (size_only || check_binary) {
 			if (size_only)
 				return 0;
-			if (s->size > big_file_threshold && s->is_binary == -1) {
+			if (s->size > repo_settings_get_big_file_threshold(the_repository) &&
+			    s->is_binary == -1) {
 				s->is_binary = 1;
 				return 0;
 			}
diff --git a/environment.c b/environment.c
index 9e4c7781be0..3c32367c28c 100644
--- a/environment.c
+++ b/environment.c
@@ -49,7 +49,6 @@ int fsync_object_files = -1;
 int use_fsync = -1;
 enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
 enum fsync_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
-unsigned long big_file_threshold = 512 * 1024 * 1024;
 char *editor_program;
 char *askpass_program;
 char *excludes_file;
diff --git a/environment.h b/environment.h
index 45e690f203f..91d854dcb08 100644
--- a/environment.h
+++ b/environment.h
@@ -154,7 +154,6 @@ extern int zlib_compression_level;
 extern int pack_compression_level;
 extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
-extern unsigned long big_file_threshold;
 extern unsigned long pack_size_limit_cfg;
 extern int max_allowed_tree_depth;
 
diff --git a/object-file.c b/object-file.c
index 726e41a0475..b3e0276b2a4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2803,7 +2803,8 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		ret = index_stream_convert_blob(istate, oid, fd, path, flags);
 	else if (!S_ISREG(st->st_mode))
 		ret = index_pipe(istate, oid, fd, type, path, flags);
-	else if (st->st_size <= big_file_threshold || type != OBJ_BLOB ||
+	else if (st->st_size <= repo_settings_get_big_file_threshold(the_repository) ||
+		 type != OBJ_BLOB ||
 		 (path && would_convert_to_git(istate, path)))
 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
 				 type, path, flags);
@@ -3137,7 +3138,8 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	if (*oi->typep == OBJ_BLOB && *size > big_file_threshold) {
+	if (*oi->typep == OBJ_BLOB &&
+	    *size > repo_settings_get_big_file_threshold(the_repository)) {
 		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)
 			goto out;
 	} else {
diff --git a/pack-check.c b/pack-check.c
index 6bcadc1e679..017dc740f7b 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -131,7 +131,8 @@ static int verify_packfile(struct repository *r,
 		type = unpack_object_header(p, w_curs, &curpos, &size);
 		unuse_pack(w_curs);
 
-		if (type == OBJ_BLOB && big_file_threshold <= size) {
+		if (type == OBJ_BLOB &&
+		    repo_settings_get_big_file_threshold(the_repository) <= size) {
 			/*
 			 * Let stream_object_signature() check it with
 			 * the streaming interface; no point slurping
diff --git a/repo-settings.c b/repo-settings.c
index 67e9cfd2e63..4129f8fb2b4 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -20,6 +20,13 @@ static void repo_cfg_int(struct repository *r, const char *key, int *dest,
 		*dest = def;
 }
 
+static void repo_cfg_ulong(struct repository *r, const char *key, unsigned long *dest,
+			   unsigned long def)
+{
+	if (repo_config_get_ulong(r, key, dest))
+		*dest = def;
+}
+
 void prepare_repo_settings(struct repository *r)
 {
 	int experimental;
@@ -151,6 +158,19 @@ void repo_settings_clear(struct repository *r)
 	r->settings = empty;
 }
 
+unsigned long repo_settings_get_big_file_threshold(struct repository *repo)
+{
+	if (!repo->settings.big_file_threshold)
+		repo_cfg_ulong(repo, "core.bigfilethreshold",
+			       &repo->settings.big_file_threshold, 512 * 1024 * 1024);
+	return repo->settings.big_file_threshold;
+}
+
+void repo_settings_set_big_file_threshold(struct repository *repo, unsigned long value)
+{
+	repo->settings.big_file_threshold = value;
+}
+
 enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo)
 {
 	const char *value;
diff --git a/repo-settings.h b/repo-settings.h
index ddc11967e01..2bf24b25973 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -64,6 +64,7 @@ struct repo_settings {
 	size_t delta_base_cache_limit;
 	size_t packed_git_window_size;
 	size_t packed_git_limit;
+	unsigned long big_file_threshold;
 
 	char *hooks_path;
 };
@@ -88,6 +89,10 @@ int repo_settings_get_warn_ambiguous_refs(struct repository *repo);
 /* Read the value for "core.hooksPath". */
 const char *repo_settings_get_hooks_path(struct repository *repo);
 
+/* Read and set the value for "core.bigFileThreshold". */
+unsigned long repo_settings_get_big_file_threshold(struct repository *repo);
+void repo_settings_set_big_file_threshold(struct repository *repo, unsigned long value);
+
 /* Read, set or reset the value for "core.sharedRepository". */
 int repo_settings_get_shared_repository(struct repository *repo);
 void repo_settings_set_shared_repository(struct repository *repo, int value);
diff --git a/streaming.c b/streaming.c
index 38839511afc..018b794d252 100644
--- a/streaming.c
+++ b/streaming.c
@@ -431,7 +431,8 @@ static int istream_source(struct git_istream *st,
 		st->open = open_istream_loose;
 		return 0;
 	case OI_PACKED:
-		if (!oi.u.packed.is_delta && big_file_threshold < size) {
+		if (!oi.u.packed.is_delta &&
+		    repo_settings_get_big_file_threshold(the_repository) < size) {
 			st->u.in_pack.pack = oi.u.packed.pack;
 			st->u.in_pack.pos = oi.u.packed.offset;
 			st->open = open_istream_pack_non_delta;
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index c71932b0242..5be273611ad 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -6,7 +6,8 @@ test_description='adding and checking out large blobs'
 . ./test-lib.sh
 
 test_expect_success 'core.bigFileThreshold must be non-negative' '
-	test_must_fail git -c core.bigFileThreshold=-1 rev-parse >out 2>err &&
+	: >input &&
+	test_must_fail git -c core.bigFileThreshold=-1 hash-object input >out 2>err &&
 	grep "bad numeric config value" err &&
 	test_must_be_empty out
 '

-- 
2.49.0.rc0.375.gae4b89d849.dirty

