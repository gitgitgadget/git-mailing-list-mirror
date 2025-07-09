Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634D528DF1B
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059894; cv=none; b=ayB0RX7ZQVwaW7NfP2sC1RI6T+ILRQhxGSEJMKQvghwEZcLaoNPFme9K0MeJTQloOwz1zYL13DYxfmn5eCWReXLAUWkiPKkNbUHhzv9f9jtb5fF/bLGo1COLjfsHitP6YhE6rC5pZ1XvkckoNF5+FzqFNDYDhJuvCOTNNWxHKdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059894; c=relaxed/simple;
	bh=Ucm3CgcxF8XWcxtzaHq5Kq/gpPTPgY6KdgKN9R3U3y0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KlYFuT+R/r1jEaXMWRBF+zcf2Nd2kGAhKuT/YtJsBt+YYNYEdHMssVZpgUzVelE6jowPpNxbuUIwBz4j8i5VkNYTr3qWQZCnMDAs+J1SQt+zDH1GCmHxKFI31QA56TrwWwiwfa0sqinpOKru1eoMZ5fhcCTmI57QtOwC0q1j5Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F8WWgBue; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aiAVPW8I; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F8WWgBue";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aiAVPW8I"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CC67D1400360
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:18:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 09 Jul 2025 07:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752059891;
	 x=1752146291; bh=GxQvyY0aItFXLb8Q/mQvO2TBB1ce4UlsAszHIXzE9l8=; b=
	F8WWgBueEc6wc9UI8/tx320VFZtHk3RwRpVvc8jx0P3X6ytYiiFKUaSF2bvTec3c
	+68eeidpXWyVAlZXC/Hlkcaz/JqddBrBlsLyqd028f49fY00TvMM+kL6Iyw2pMmh
	fJ2khglIMAv8tEDAWK3jGY5Q5onxg18uBrmlmBNUEqCoikcR+p5Kf0g8vC0877Pq
	9IZSVH93LEtRaRP2CFvOjQ4vT3owknofilkiM22KGWas0C5fS9c093NtT+VQBdbS
	2I5YguI4lphaAvso4NvtwbfRMEeEjdPJ0zGa9uH6mn0MTGEZaksb4Vl2Ym54bukF
	m+1n9WvASU6h23RmpqHGEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752059891; x=
	1752146291; bh=GxQvyY0aItFXLb8Q/mQvO2TBB1ce4UlsAszHIXzE9l8=; b=a
	iAVPW8IwBAgVyLY6zijT9s/dcDAAy266EzxTgr6VPE/VrHQAtlvVgiQU5Fyf0CzC
	WSWpHz/tYbNuQVK31Tnkq9F5ZizKT0S8fJdhsSsXYH0jOiiwg64E8Oj28vy47Tkh
	g1MI8dTiVjyxdEX154TKeIO1F0JpzwYPMUDiKjm0PpA5SPQgczGAUmRxsXTJOTi4
	TRN6Yxbe7MLjHZN6vBY4G1r5d2IF51w2d584qGaKgkzB8cPhM2QNQTEzZqvLGvpP
	94B8nwV9T+wUFToteLZelKnWqf4w1P0eLsJgaPH/+PHRc0pgFkjRTAf+bbAZtGFX
	FheSHSSSuRxr8JRzv8GLA==
X-ME-Sender: <xms:809uaDRcWOnuzJgdEH2CzXTk4eDJq1qBeA1jCo6UVQoGeqZYMX75YQ>
    <xme:809uaGxliFFMWa0g79Oy5c1cYD8BvhkwJ4iTxXOwre9F__TDHgCwBVw0oOv2UFKNi
    aKEd87qDyD6dukMpA>
X-ME-Received: <xmr:809uaCO4N9KKeWXqqTbZWy216wQknmd1eLeTOAymzDjSOwRRWSubjHK-_ok-Xams1FW4yk1V3btExczk38axi1efeW8VO4-rn9637eIPQSW_Xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:809uaFPOkUyFOos-egQt1K_SwOSvKZmhPmA3E9uZfoWtlT2zTCgnJA>
    <xmx:809uaERYookO6h3Kfiz16aUiduGI8TXov1jsJIGTqgId_rRWvcygwA>
    <xmx:809uaHC2G9uFp8bfRnJRnZK7ezJafZG71Va-w6vS3KBJf2WSmuA4VQ>
    <xmx:809uaDjtiFjadUxIoHbmzY23npe1JiXL4IdrjR9TkMf22MrXukcsDw>
    <xmx:809uaAIuaQS9Gqx0OPJPbex1WlvjKiXpuhW83CYfJZWArjUHF5V5uN7h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 07:18:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id da0f16eb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 11:18:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 13:17:27 +0200
Subject: [PATCH 17/19] environment: move compression level into repo
 settings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pks-object-file-wo-the-repository-v1-17-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The compression level for loose objects and packfiles is tracked via a
couple of global variables. Refactor these so that the values for them
are tracked via repo settings, which allows us to drop this global
dependency.

Note that the refactoring is mostly straight-forward, except in
git-pack-objects(1). Here it is possible to change the compression level
via a command line option, and that option of course should override
whatever the user has configured. This creates the problem that we need
to be able to see whether the option has been given in the first place.

This is done by using `INT_MIN` as default value. Any value smaller than
-1 is an invalid compression level, so it's quite unlikely that any user
ever passed that sentinel value. And if they did we would have died
anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c  |  8 +++++---
 builtin/index-pack.c   |  3 ++-
 builtin/pack-objects.c | 21 ++++++++++++++-------
 bulk-checkin.c         |  3 ++-
 config.c               | 38 --------------------------------------
 diff.c                 |  3 ++-
 environment.c          |  3 ---
 environment.h          |  2 --
 http-push.c            |  3 ++-
 object-file.c          |  3 ++-
 repo-settings.c        | 38 ++++++++++++++++++++++++++++++++++++++
 repo-settings.h        |  2 ++
 12 files changed, 69 insertions(+), 58 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 89f57898b15..2733c6ed7fc 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -992,7 +992,8 @@ static int store_object(
 	} else
 		delta = NULL;
 
-	git_deflate_init(&s, pack_compression_level);
+	prepare_repo_settings(the_repository);
+	git_deflate_init(&s, the_repository->settings.pack_compression_level);
 	if (delta) {
 		s.next_in = delta;
 		s.avail_in = deltalen;
@@ -1019,7 +1020,7 @@ static int store_object(
 		if (delta) {
 			FREE_AND_NULL(delta);
 
-			git_deflate_init(&s, pack_compression_level);
+			git_deflate_init(&s, the_repository->settings.pack_compression_level);
 			s.next_in = (void *)dat->buf;
 			s.avail_in = dat->len;
 			s.avail_out = git_deflate_bound(&s, s.avail_in);
@@ -1120,7 +1121,8 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 
 	crc32_begin(pack_file);
 
-	git_deflate_init(&s, pack_compression_level);
+	prepare_repo_settings(the_repository);
+	git_deflate_init(&s, the_repository->settings.pack_compression_level);
 
 	hdrlen = encode_in_pack_object_header(out_buf, out_sz, OBJ_BLOB, len);
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index dabeb825a6c..d302bab9de9 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1420,7 +1420,8 @@ static int write_compressed(struct hashfile *f, void *in, unsigned int size)
 	int status;
 	unsigned char outbuf[4096];
 
-	git_deflate_init(&stream, zlib_compression_level);
+	prepare_repo_settings(the_repository);
+	git_deflate_init(&stream, the_repository->settings.zlib_compression_level);
 	stream.next_in = in;
 	stream.avail_in = size;
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7ff79d6b376..62096c1fe03 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -379,7 +379,8 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 	void *in, *out;
 	unsigned long maxsize;
 
-	git_deflate_init(&stream, pack_compression_level);
+	prepare_repo_settings(the_repository);
+	git_deflate_init(&stream, the_repository->settings.pack_compression_level);
 	maxsize = git_deflate_bound(&stream, size);
 
 	in = *pptr;
@@ -406,7 +407,8 @@ static unsigned long write_large_blob_data(struct git_istream *st, struct hashfi
 	unsigned char obuf[1024 * 16];
 	unsigned long olen = 0;
 
-	git_deflate_init(&stream, pack_compression_level);
+	prepare_repo_settings(the_repository);
+	git_deflate_init(&stream, the_repository->settings.pack_compression_level);
 
 	for (;;) {
 		ssize_t readlen;
@@ -4803,6 +4805,7 @@ int cmd_pack_objects(int argc,
 		     const char *prefix,
 		     struct repository *repo UNUSED)
 {
+	int compression_level = INT_MIN;
 	int use_internal_rev_list = 0;
 	int all_progress_implied = 0;
 	struct strvec rp = STRVEC_INIT;
@@ -4892,7 +4895,7 @@ int cmd_pack_objects(int argc,
 			 N_("ignore packs that have companion .keep file")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("ignore this pack")),
-		OPT_INTEGER(0, "compression", &pack_compression_level,
+		OPT_INTEGER(0, "compression", &compression_level,
 			    N_("pack compression level")),
 		OPT_BOOL(0, "keep-true-parents", &grafts_keep_true_parents,
 			 N_("do not hide commits by grafts")),
@@ -5046,10 +5049,14 @@ int cmd_pack_objects(int argc,
 
 	if (!reuse_object)
 		reuse_delta = 0;
-	if (pack_compression_level == -1)
-		pack_compression_level = Z_DEFAULT_COMPRESSION;
-	else if (pack_compression_level < 0 || pack_compression_level > Z_BEST_COMPRESSION)
-		die(_("bad pack compression level %d"), pack_compression_level);
+	if (compression_level != INT_MIN) {
+		if (compression_level == -1)
+			compression_level = Z_DEFAULT_COMPRESSION;
+		else if (compression_level < 0 || compression_level > Z_BEST_COMPRESSION)
+			die(_("bad pack compression level %d"), compression_level);
+		prepare_repo_settings(the_repository);
+		the_repository->settings.pack_compression_level = compression_level;
+	}
 
 	if (!delta_search_threads)	/* --threads=0 means autodetect */
 		delta_search_threads = online_cpus();
diff --git a/bulk-checkin.c b/bulk-checkin.c
index b2809ab0398..3ea181baf93 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -171,7 +171,8 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 	int write_object = (flags & INDEX_WRITE_OBJECT);
 	off_t offset = 0;
 
-	git_deflate_init(&s, pack_compression_level);
+	prepare_repo_settings(the_repository);
+	git_deflate_init(&s, the_repository->settings.pack_compression_level);
 
 	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_BLOB, size);
 	s.next_out = obuf + hdrlen;
diff --git a/config.c b/config.c
index 095a17bd429..b7d1fa90fbf 100644
--- a/config.c
+++ b/config.c
@@ -71,9 +71,6 @@ struct config_source {
 };
 #define CONFIG_SOURCE_INIT { 0 }
 
-static int pack_compression_seen;
-static int zlib_compression_seen;
-
 /*
  * Config that comes from trusted scopes, namely:
  * - CONFIG_SCOPE_SYSTEM (e.g. /etc/gitconfig)
@@ -1466,30 +1463,6 @@ static int git_default_core_config(const char *var, const char *value,
 	if (!strcmp(var, "core.disambiguate"))
 		return set_disambiguate_hint_config(var, value);
 
-	if (!strcmp(var, "core.loosecompression")) {
-		int level = git_config_int(var, value, ctx->kvi);
-		if (level == -1)
-			level = Z_DEFAULT_COMPRESSION;
-		else if (level < 0 || level > Z_BEST_COMPRESSION)
-			die(_("bad zlib compression level %d"), level);
-		zlib_compression_level = level;
-		zlib_compression_seen = 1;
-		return 0;
-	}
-
-	if (!strcmp(var, "core.compression")) {
-		int level = git_config_int(var, value, ctx->kvi);
-		if (level == -1)
-			level = Z_DEFAULT_COMPRESSION;
-		else if (level < 0 || level > Z_BEST_COMPRESSION)
-			die(_("bad zlib compression level %d"), level);
-		if (!zlib_compression_seen)
-			zlib_compression_level = level;
-		if (!pack_compression_seen)
-			pack_compression_level = level;
-		return 0;
-	}
-
 	if (!strcmp(var, "core.autocrlf")) {
 		if (value && !strcasecmp(value, "input")) {
 			auto_crlf = AUTO_CRLF_INPUT;
@@ -1802,17 +1775,6 @@ int git_default_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (!strcmp(var, "pack.compression")) {
-		int level = git_config_int(var, value, ctx->kvi);
-		if (level == -1)
-			level = Z_DEFAULT_COMPRESSION;
-		else if (level < 0 || level > Z_BEST_COMPRESSION)
-			die(_("bad pack compression level %d"), level);
-		pack_compression_level = level;
-		pack_compression_seen = 1;
-		return 0;
-	}
-
 	if (starts_with(var, "sparse."))
 		return git_default_sparse_config(var, value);
 
diff --git a/diff.c b/diff.c
index dca87e164fb..45c0bcd2bde 100644
--- a/diff.c
+++ b/diff.c
@@ -3307,7 +3307,8 @@ static unsigned char *deflate_it(char *data,
 	unsigned char *deflated;
 	git_zstream stream;
 
-	git_deflate_init(&stream, zlib_compression_level);
+	prepare_repo_settings(the_repository);
+	git_deflate_init(&stream, the_repository->settings.zlib_compression_level);
 	bound = git_deflate_bound(&stream, size);
 	deflated = xmalloc(bound);
 	stream.next_out = deflated;
diff --git a/environment.c b/environment.c
index 7bf0390a335..dbb186b56d0 100644
--- a/environment.c
+++ b/environment.c
@@ -16,7 +16,6 @@
 #include "convert.h"
 #include "environment.h"
 #include "gettext.h"
-#include "git-zlib.h"
 #include "repository.h"
 #include "config.h"
 #include "refs.h"
@@ -43,8 +42,6 @@ char *git_log_output_encoding;
 char *apply_default_whitespace;
 char *apply_default_ignorewhitespace;
 char *git_attributes_file;
-int zlib_compression_level = Z_BEST_SPEED;
-int pack_compression_level = Z_DEFAULT_COMPRESSION;
 int fsync_object_files = -1;
 int use_fsync = -1;
 enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
diff --git a/environment.h b/environment.h
index 9a3d05d414a..4245b58af6e 100644
--- a/environment.h
+++ b/environment.h
@@ -150,8 +150,6 @@ extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
 extern char *git_attributes_file;
-extern int zlib_compression_level;
-extern int pack_compression_level;
 extern unsigned long pack_size_limit_cfg;
 extern int max_allowed_tree_depth;
 
diff --git a/http-push.c b/http-push.c
index 91a5465afb1..77670774713 100644
--- a/http-push.c
+++ b/http-push.c
@@ -374,7 +374,8 @@ static void start_put(struct transfer_request *request)
 	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
 
 	/* Set it up */
-	git_deflate_init(&stream, zlib_compression_level);
+	prepare_repo_settings(the_repository);
+	git_deflate_init(&stream, the_repository->settings.zlib_compression_level);
 	size = git_deflate_bound(&stream, len + hdrlen);
 	strbuf_grow(&request->buffer.buf, size);
 	request->buffer.posn = 0;
diff --git a/object-file.c b/object-file.c
index 2bc36ab3ee8..0afd39dd346 100644
--- a/object-file.c
+++ b/object-file.c
@@ -769,7 +769,8 @@ static int start_loose_object_common(struct odb_source *source,
 	}
 
 	/*  Setup zlib stream for compression */
-	git_deflate_init(stream, zlib_compression_level);
+	prepare_repo_settings(source->odb->repo);
+	git_deflate_init(stream, source->odb->repo->settings.zlib_compression_level);
 	stream->next_out = buf;
 	stream->avail_out = buflen;
 	algo->init_fn(c);
diff --git a/repo-settings.c b/repo-settings.c
index 195c24e9c07..1d3626018a0 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -1,5 +1,7 @@
 #include "git-compat-util.h"
 #include "config.h"
+#include "git-zlib.h"
+#include "gettext.h"
 #include "repo-settings.h"
 #include "repository.h"
 #include "midx.h"
@@ -29,6 +31,8 @@ static void repo_cfg_ulong(struct repository *r, const char *key, unsigned long
 
 void prepare_repo_settings(struct repository *r)
 {
+	int pack_compression_seen = 0;
+	int zlib_compression_seen = 0;
 	int experimental;
 	int value;
 	const char *strval;
@@ -151,6 +155,40 @@ void prepare_repo_settings(struct repository *r)
 
 	if (!repo_config_get_ulong(r, "core.packedgitlimit", &ulongval))
 		r->settings.packed_git_limit = ulongval;
+
+	if (!repo_config_get_int(r, "core.loosecompression", &value)) {
+		if (value == -1)
+			value = Z_DEFAULT_COMPRESSION;
+		else if (value < 0 || value > Z_BEST_COMPRESSION)
+			die(_("bad zlib compression level %d"), value);
+		r->settings.zlib_compression_level = value;
+		zlib_compression_seen = 1;
+	}
+
+	if (!repo_config_get_int(r, "pack.compression", &value)) {
+		if (value == -1)
+			value = Z_DEFAULT_COMPRESSION;
+		else if (value < 0 || value > Z_BEST_COMPRESSION)
+			die(_("bad pack compression level %d"), value);
+		r->settings.pack_compression_level = value;
+		pack_compression_seen = 1;
+	}
+
+	if (!repo_config_get_int(r, "core.compression", &value)) {
+		if (value == -1)
+			value = Z_DEFAULT_COMPRESSION;
+		else if (value < 0 || value > Z_BEST_COMPRESSION)
+			die(_("bad zlib compression level %d"), value);
+		if (!zlib_compression_seen)
+			r->settings.zlib_compression_level = value;
+		if (!pack_compression_seen)
+			r->settings.pack_compression_level = value;
+	} else {
+		if (!zlib_compression_seen)
+			r->settings.zlib_compression_level = Z_BEST_SPEED;
+		if (!pack_compression_seen)
+			r->settings.pack_compression_level = Z_DEFAULT_COMPRESSION;
+	}
 }
 
 void repo_settings_clear(struct repository *r)
diff --git a/repo-settings.h b/repo-settings.h
index d4778855614..f60900317cf 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -36,6 +36,8 @@ struct repo_settings {
 	int pack_read_reverse_index;
 	int pack_use_bitmap_boundary_traversal;
 	int pack_use_multi_pack_reuse;
+	int pack_compression_level;
+	int zlib_compression_level;
 
 	int shared_repository;
 	int shared_repository_initialized;

-- 
2.50.1.327.g047016eb4a.dirty

