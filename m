Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBE219D06E
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738328147; cv=none; b=glIGCi5hIZlNe2DibTjVCMU3rauyT9VGIRFnNYLzD0bT9O+0oHpSIS22YwawDmgC394bM15A+SAD/d1aHTLK5XApaIg5biTTVss5m0cKiLp7S2p8ipCZeoszKzteuNIIvb9tspFU2x80qYtJsmNQL7ULGhg0Mg4rG/hTl3kRzTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738328147; c=relaxed/simple;
	bh=aPdwgG/9LSc7wU6azsnmCHsoQ4oa/XNj3dOZ+ytGS/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WsqQlHg7CqZFTWd61pW02PJcwOfEv/+ZII5th8qLxErZFrgONO31F47wAC0+hWd2FG5xu9sr0i/VUka5/q0l9HhPyCXfyzylx0JIhzQF6lKOZqgTK5FC1AZ52XIRbNosWP5iyzwtanSZqlHhwTw7RPyo7MHkQwpOHUYSXgH1WBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bOqrLVDc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KBnoKKph; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bOqrLVDc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KBnoKKph"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id C7DBD13801DD;
	Fri, 31 Jan 2025 07:55:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 31 Jan 2025 07:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738328143;
	 x=1738414543; bh=TEornZQXwvz0J2oFI/PvXAICKRnuKW5ctX9i18ozfA4=; b=
	bOqrLVDc/o2aB8uU53K1Dsfhdjn46pGeZ+7I/OzUXZenKuy6eLWfrnL4LxCNFOMB
	Kqh+g3zX461h0e66RmcZJ62ZCcrH2C9yHD6ZBMni9GtVJ1r6/m5+g/D/dey45+qb
	HMpcDrLj2YJ0TuCd64r2w88Pc81kssxwpnGZyUn9D5p2Qahn439U4hRbT3A26Ykk
	oXlS2YOMYku2ecDAgacjJdeB2uyp4ymdpegmy41daGabcczl36zJItqPMzfvlBM9
	Qb6hKIhQ5tXCyUzm4RJJ3v4dkw7/YPXLCD1QVeW8UXBMf29gAaxcu/5kr/8aoNnY
	gwd9QPkcDMTmigZaCZE+3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738328143; x=
	1738414543; bh=TEornZQXwvz0J2oFI/PvXAICKRnuKW5ctX9i18ozfA4=; b=K
	BnoKKphrzfQQB+hagI5YJWnXwZdJknYhOyVw61A3afDUOfuCMirw+20PquX3fjUM
	RXFqXjJAjF8IzLis7BnQd96j0X9wWY0HnPCnmx085h+/DJbrdFuAJlhq/l2Ygtzy
	ScIal1d431V6FSZiPc6RFXYB6F2AiH5paVl5aQvOr8Q1RjJ745fBhehU8RsjmPxE
	G4by/dPg+5wkkCqJ5BdfLJE1vruCfUSBZjqXFR3CDXkEKGUvGeWKLPXiIB+9xyj+
	JHzypauF25CGRjMO6aoX4YzdGskqezXa/b/QK8qvF6YnLDq0rBCpBS25O3NtK8Rz
	oEccm8NA8E1pQVzJCoAXg==
X-ME-Sender: <xms:T8icZ_mNIazDiVqIW9cO3e9ZlmXMwWgxKRMgFDKNhO8h8-7kApLdzA>
    <xme:T8icZy1FWYd0TnoNdkepVjJubiWJhbDI_4e8-jGba5Cqu9gQ6L2fp_YlkFjVlDROZ
    xVmp8fpse-bNESgcA>
X-ME-Received: <xmr:T8icZ1o6BZhH3cCUkX9YhedqnmeB7fJlZRoaCxW66xS0gHMuNizYYkfu730bIjkeVmmKQfZttfQeV_pOv2FcDvaLcD9BeDliz_6A8lYh40oEiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:T8icZ3kggohg39rz_a2ugMhYdKIlHia_PMgJo46wDLa6mXjEGwYVvA>
    <xmx:T8icZ91NZCL-z8sJvpJf3ap6QQU9Os0LEX30BHreqOOSuvAnMMzFPw>
    <xmx:T8icZ2tRTLFQVM16EVAX5HcncLRWP3Kxgx5QYOagZSb5ELpcvvWh2g>
    <xmx:T8icZxVe5lljkUkLuBO9U45G1HzjYtcj2oq4zhs22lRMo75HMCBmWg>
    <xmx:T8icZ4S6G6SCqBbh2Bkg-zCloG-AnUHxhluULLtAOCLzz3fJvThDo9ci>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 07:55:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 481ed8d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jan 2025 12:55:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Jan 2025 13:55:29 +0100
Subject: [PATCH 2/4] hash: stop typedeffing the hash context
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-b4-pks-hash-context-direct-v1-2-67a6d3f49d6e@pks.im>
References: <20250131-b4-pks-hash-context-direct-v1-0-67a6d3f49d6e@pks.im>
In-Reply-To: <20250131-b4-pks-hash-context-direct-v1-0-67a6d3f49d6e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

We generally avoid using `typedef` in the Git codebase. One exception
though is the `git_hash_ctx`, likely because it used to be a union
rather than a struct until the preceding commit refactored it. But now
that it is a normal `struct` there isn't really a need for a typedef
anymore.

Drop the typedef and adapt all callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c      |  4 +--
 builtin/index-pack.c       |  6 ++---
 builtin/patch-id.c         |  2 +-
 builtin/receive-pack.c     |  2 +-
 builtin/unpack-objects.c   |  4 +--
 bulk-checkin.c             |  4 +--
 csum-file.c                |  2 +-
 csum-file.h                |  4 +--
 diff.c                     | 10 ++++----
 diff.h                     |  2 +-
 hash.h                     | 11 ++++----
 http-push.c                |  2 +-
 http.h                     |  2 +-
 object-file.c              | 62 +++++++++++++++++++++++-----------------------
 pack-check.c               |  2 +-
 pack-write.c               |  2 +-
 read-cache.c               | 12 ++++-----
 rerere.c                   |  4 +--
 t/helper/test-hash-speed.c |  4 +--
 t/helper/test-hash.c       |  2 +-
 t/unit-tests/u-hash.c      |  2 +-
 trace2/tr2_sid.c           |  2 +-
 22 files changed, 73 insertions(+), 74 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index ccdada1810..9862704c62 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -953,7 +953,7 @@ static int store_object(
 	unsigned char hdr[96];
 	struct object_id oid;
 	unsigned long hdrlen, deltalen;
-	git_hash_ctx c;
+	struct git_hash_ctx c;
 	git_zstream s;
 
 	hdrlen = format_object_header((char *)hdr, sizeof(hdr), type,
@@ -1095,7 +1095,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 	struct object_id oid;
 	unsigned long hdrlen;
 	off_t offset;
-	git_hash_ctx c;
+	struct git_hash_ctx c;
 	git_zstream s;
 	struct hashfile_checkpoint checkpoint;
 	int status = Z_OK;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 6ffbb7ce35..40e49868b1 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -151,7 +151,7 @@ static unsigned int input_offset, input_len;
 static off_t consumed_bytes;
 static off_t max_input_size;
 static unsigned deepest_delta;
-static git_hash_ctx input_ctx;
+static struct git_hash_ctx input_ctx;
 static uint32_t input_crc32;
 static int input_fd, output_fd;
 static const char *curr_pack;
@@ -475,7 +475,7 @@ static void *unpack_entry_data(off_t offset, unsigned long size,
 	int status;
 	git_zstream stream;
 	void *buf;
-	git_hash_ctx c;
+	struct git_hash_ctx c;
 	char hdr[32];
 	int hdrlen;
 
@@ -1248,7 +1248,7 @@ static void parse_pack_objects(unsigned char *hash)
 	struct ofs_delta_entry *ofs_delta = ofs_deltas;
 	struct object_id ref_delta_oid;
 	struct stat st;
-	git_hash_ctx tmp_ctx;
+	struct git_hash_ctx tmp_ctx;
 
 	if (verbose)
 		progress = start_progress(
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index f540d8daa7..923ff2bb77 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -70,7 +70,7 @@ static size_t get_one_patchid(struct object_id *next_oid, struct object_id *resu
 	int before = -1, after = -1;
 	int diff_is_binary = 0;
 	char pre_oid_str[GIT_MAX_HEXSZ + 1], post_oid_str[GIT_MAX_HEXSZ + 1];
-	git_hash_ctx ctx;
+	struct git_hash_ctx ctx;
 
 	the_hash_algo->init_fn(&ctx);
 	oidclr(result, the_repository->hash_algo);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0fb0266cfd..d2360c453c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -566,7 +566,7 @@ static void hmac_hash(unsigned char *out,
 	unsigned char k_ipad[GIT_MAX_BLKSZ];
 	unsigned char k_opad[GIT_MAX_BLKSZ];
 	int i;
-	git_hash_ctx ctx;
+	struct git_hash_ctx ctx;
 
 	/* RFC 2104 2. (1) */
 	memset(key, '\0', GIT_MAX_BLKSZ);
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index f6b9825fb0..d72885510c 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -28,7 +28,7 @@ static unsigned char buffer[4096];
 static unsigned int offset, len;
 static off_t consumed_bytes;
 static off_t max_input_size;
-static git_hash_ctx ctx;
+static struct git_hash_ctx ctx;
 static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 static struct progress *progress;
 
@@ -614,7 +614,7 @@ int cmd_unpack_objects(int argc,
 {
 	int i;
 	struct object_id oid;
-	git_hash_ctx tmp_ctx;
+	struct git_hash_ctx tmp_ctx;
 
 	disable_replace_refs();
 
diff --git a/bulk-checkin.c b/bulk-checkin.c
index f889fce734..db1958b525 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -161,7 +161,7 @@ static int already_written(struct bulk_checkin_packfile *state, struct object_id
  * with a new pack.
  */
 static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
-			       git_hash_ctx *ctx, off_t *already_hashed_to,
+			       struct git_hash_ctx *ctx, off_t *already_hashed_to,
 			       int fd, size_t size, const char *path,
 			       unsigned flags)
 {
@@ -258,7 +258,7 @@ static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
 				const char *path, unsigned flags)
 {
 	off_t seekback, already_hashed_to;
-	git_hash_ctx ctx;
+	struct git_hash_ctx ctx;
 	unsigned char obuf[16384];
 	unsigned header_len;
 	struct hashfile_checkpoint checkpoint;
diff --git a/csum-file.c b/csum-file.c
index 232121f415..3383515669 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -248,7 +248,7 @@ uint32_t crc32_end(struct hashfile *f)
 int hashfile_checksum_valid(const unsigned char *data, size_t total_len)
 {
 	unsigned char got[GIT_MAX_RAWSZ];
-	git_hash_ctx ctx;
+	struct git_hash_ctx ctx;
 	const struct git_hash_algo *algop = unsafe_hash_algo(the_hash_algo);
 	size_t data_len = total_len - algop->rawsz;
 
diff --git a/csum-file.h b/csum-file.h
index b7475f16c2..ffccbf0996 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -11,7 +11,7 @@ struct hashfile {
 	int fd;
 	int check_fd;
 	unsigned int offset;
-	git_hash_ctx ctx;
+	struct git_hash_ctx ctx;
 	off_t total;
 	struct progress *tp;
 	const char *name;
@@ -33,7 +33,7 @@ struct hashfile {
 /* Checkpoint */
 struct hashfile_checkpoint {
 	off_t offset;
-	git_hash_ctx ctx;
+	struct git_hash_ctx ctx;
 };
 
 void hashfile_checkpoint_init(struct hashfile *, struct hashfile_checkpoint *);
diff --git a/diff.c b/diff.c
index 0822ae4433..7f570ebdf9 100644
--- a/diff.c
+++ b/diff.c
@@ -6392,7 +6392,7 @@ static void diff_summary(struct diff_options *opt, struct diff_filepair *p)
 }
 
 struct patch_id_t {
-	git_hash_ctx *ctx;
+	struct git_hash_ctx *ctx;
 	int patchlen;
 };
 
@@ -6409,7 +6409,7 @@ static int remove_space(char *line, int len)
 	return dst - line;
 }
 
-void flush_one_hunk(struct object_id *result, git_hash_ctx *ctx)
+void flush_one_hunk(struct object_id *result, struct git_hash_ctx *ctx)
 {
 	unsigned char hash[GIT_MAX_RAWSZ];
 	unsigned short carry = 0;
@@ -6439,12 +6439,12 @@ static int patch_id_consume(void *priv, char *line, unsigned long len)
 	return 0;
 }
 
-static void patch_id_add_string(git_hash_ctx *ctx, const char *str)
+static void patch_id_add_string(struct git_hash_ctx *ctx, const char *str)
 {
 	the_hash_algo->update_fn(ctx, str, strlen(str));
 }
 
-static void patch_id_add_mode(git_hash_ctx *ctx, unsigned mode)
+static void patch_id_add_mode(struct git_hash_ctx *ctx, unsigned mode)
 {
 	/* large enough for 2^32 in octal */
 	char buf[12];
@@ -6457,7 +6457,7 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
-	git_hash_ctx ctx;
+	struct git_hash_ctx ctx;
 	struct patch_id_t data;
 
 	the_hash_algo->init_fn(&ctx);
diff --git a/diff.h b/diff.h
index 6e6007c17b..d56296dd21 100644
--- a/diff.h
+++ b/diff.h
@@ -644,7 +644,7 @@ void run_diff_index(struct rev_info *revs, unsigned int option);
 
 int do_diff_cache(const struct object_id *, struct diff_options *);
 int diff_flush_patch_id(struct diff_options *, struct object_id *, int);
-void flush_one_hunk(struct object_id *result, git_hash_ctx *ctx);
+void flush_one_hunk(struct object_id *result, struct git_hash_ctx *ctx);
 
 int diff_result_code(struct rev_info *);
 
diff --git a/hash.h b/hash.h
index 5b88d9b714..42b52c6dae 100644
--- a/hash.h
+++ b/hash.h
@@ -241,13 +241,12 @@ struct git_hash_ctx {
 		git_SHA256_CTX sha256;
 	} state;
 };
-typedef struct git_hash_ctx git_hash_ctx;
 
-typedef void (*git_hash_init_fn)(git_hash_ctx *ctx);
-typedef void (*git_hash_clone_fn)(git_hash_ctx *dst, const git_hash_ctx *src);
-typedef void (*git_hash_update_fn)(git_hash_ctx *ctx, const void *in, size_t len);
-typedef void (*git_hash_final_fn)(unsigned char *hash, git_hash_ctx *ctx);
-typedef void (*git_hash_final_oid_fn)(struct object_id *oid, git_hash_ctx *ctx);
+typedef void (*git_hash_init_fn)(struct git_hash_ctx *ctx);
+typedef void (*git_hash_clone_fn)(struct git_hash_ctx *dst, const struct git_hash_ctx *src);
+typedef void (*git_hash_update_fn)(struct git_hash_ctx *ctx, const void *in, size_t len);
+typedef void (*git_hash_final_fn)(unsigned char *hash, struct git_hash_ctx *ctx);
+typedef void (*git_hash_final_oid_fn)(struct object_id *oid, struct git_hash_ctx *ctx);
 
 struct git_hash_algo {
 	/*
diff --git a/http-push.c b/http-push.c
index 43da1c7cd3..36867af2f8 100644
--- a/http-push.c
+++ b/http-push.c
@@ -760,7 +760,7 @@ static void handle_lockprop_ctx(struct xml_ctx *ctx, int tag_closed)
 static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
 {
 	struct remote_lock *lock = (struct remote_lock *)ctx->userData;
-	git_hash_ctx hash_ctx;
+	struct git_hash_ctx hash_ctx;
 	unsigned char lock_token_hash[GIT_MAX_RAWSZ];
 
 	if (tag_closed && ctx->cdata) {
diff --git a/http.h b/http.h
index 46e334c2c2..36202139f4 100644
--- a/http.h
+++ b/http.h
@@ -228,7 +228,7 @@ struct http_object_request {
 	long http_code;
 	struct object_id oid;
 	struct object_id real_oid;
-	git_hash_ctx c;
+	struct git_hash_ctx c;
 	git_zstream stream;
 	int zret;
 	int rename;
diff --git a/object-file.c b/object-file.c
index 7505aa6b60..154bcfce78 100644
--- a/object-file.c
+++ b/object-file.c
@@ -86,82 +86,82 @@ static const struct object_id null_oid_sha256 = {
 	.algo = GIT_HASH_SHA256,
 };
 
-static void git_hash_sha1_init(git_hash_ctx *ctx)
+static void git_hash_sha1_init(struct git_hash_ctx *ctx)
 {
 	git_SHA1_Init(&ctx->state.sha1);
 }
 
-static void git_hash_sha1_clone(git_hash_ctx *dst, const git_hash_ctx *src)
+static void git_hash_sha1_clone(struct git_hash_ctx *dst, const struct git_hash_ctx *src)
 {
 	git_SHA1_Clone(&dst->state.sha1, &src->state.sha1);
 }
 
-static void git_hash_sha1_update(git_hash_ctx *ctx, const void *data, size_t len)
+static void git_hash_sha1_update(struct git_hash_ctx *ctx, const void *data, size_t len)
 {
 	git_SHA1_Update(&ctx->state.sha1, data, len);
 }
 
-static void git_hash_sha1_final(unsigned char *hash, git_hash_ctx *ctx)
+static void git_hash_sha1_final(unsigned char *hash, struct git_hash_ctx *ctx)
 {
 	git_SHA1_Final(hash, &ctx->state.sha1);
 }
 
-static void git_hash_sha1_final_oid(struct object_id *oid, git_hash_ctx *ctx)
+static void git_hash_sha1_final_oid(struct object_id *oid, struct git_hash_ctx *ctx)
 {
 	git_SHA1_Final(oid->hash, &ctx->state.sha1);
 	memset(oid->hash + GIT_SHA1_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA1_RAWSZ);
 	oid->algo = GIT_HASH_SHA1;
 }
 
-static void git_hash_sha1_init_unsafe(git_hash_ctx *ctx)
+static void git_hash_sha1_init_unsafe(struct git_hash_ctx *ctx)
 {
 	git_SHA1_Init_unsafe(&ctx->state.sha1_unsafe);
 }
 
-static void git_hash_sha1_clone_unsafe(git_hash_ctx *dst, const git_hash_ctx *src)
+static void git_hash_sha1_clone_unsafe(struct git_hash_ctx *dst, const struct git_hash_ctx *src)
 {
 	git_SHA1_Clone_unsafe(&dst->state.sha1_unsafe, &src->state.sha1_unsafe);
 }
 
-static void git_hash_sha1_update_unsafe(git_hash_ctx *ctx, const void *data,
+static void git_hash_sha1_update_unsafe(struct git_hash_ctx *ctx, const void *data,
 				      size_t len)
 {
 	git_SHA1_Update_unsafe(&ctx->state.sha1_unsafe, data, len);
 }
 
-static void git_hash_sha1_final_unsafe(unsigned char *hash, git_hash_ctx *ctx)
+static void git_hash_sha1_final_unsafe(unsigned char *hash, struct git_hash_ctx *ctx)
 {
 	git_SHA1_Final_unsafe(hash, &ctx->state.sha1_unsafe);
 }
 
-static void git_hash_sha1_final_oid_unsafe(struct object_id *oid, git_hash_ctx *ctx)
+static void git_hash_sha1_final_oid_unsafe(struct object_id *oid, struct git_hash_ctx *ctx)
 {
 	git_SHA1_Final_unsafe(oid->hash, &ctx->state.sha1_unsafe);
 	memset(oid->hash + GIT_SHA1_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA1_RAWSZ);
 	oid->algo = GIT_HASH_SHA1;
 }
 
-static void git_hash_sha256_init(git_hash_ctx *ctx)
+static void git_hash_sha256_init(struct git_hash_ctx *ctx)
 {
 	git_SHA256_Init(&ctx->state.sha256);
 }
 
-static void git_hash_sha256_clone(git_hash_ctx *dst, const git_hash_ctx *src)
+static void git_hash_sha256_clone(struct git_hash_ctx *dst, const struct git_hash_ctx *src)
 {
 	git_SHA256_Clone(&dst->state.sha256, &src->state.sha256);
 }
 
-static void git_hash_sha256_update(git_hash_ctx *ctx, const void *data, size_t len)
+static void git_hash_sha256_update(struct git_hash_ctx *ctx, const void *data, size_t len)
 {
 	git_SHA256_Update(&ctx->state.sha256, data, len);
 }
 
-static void git_hash_sha256_final(unsigned char *hash, git_hash_ctx *ctx)
+static void git_hash_sha256_final(unsigned char *hash, struct git_hash_ctx *ctx)
 {
 	git_SHA256_Final(hash, &ctx->state.sha256);
 }
 
-static void git_hash_sha256_final_oid(struct object_id *oid, git_hash_ctx *ctx)
+static void git_hash_sha256_final_oid(struct object_id *oid, struct git_hash_ctx *ctx)
 {
 	git_SHA256_Final(oid->hash, &ctx->state.sha256);
 	/*
@@ -172,18 +172,18 @@ static void git_hash_sha256_final_oid(struct object_id *oid, git_hash_ctx *ctx)
 	oid->algo = GIT_HASH_SHA256;
 }
 
-static void git_hash_unknown_init(git_hash_ctx *ctx UNUSED)
+static void git_hash_unknown_init(struct git_hash_ctx *ctx UNUSED)
 {
 	BUG("trying to init unknown hash");
 }
 
-static void git_hash_unknown_clone(git_hash_ctx *dst UNUSED,
-				   const git_hash_ctx *src UNUSED)
+static void git_hash_unknown_clone(struct git_hash_ctx *dst UNUSED,
+				   const struct git_hash_ctx *src UNUSED)
 {
 	BUG("trying to clone unknown hash");
 }
 
-static void git_hash_unknown_update(git_hash_ctx *ctx UNUSED,
+static void git_hash_unknown_update(struct git_hash_ctx *ctx UNUSED,
 				    const void *data UNUSED,
 				    size_t len UNUSED)
 {
@@ -191,13 +191,13 @@ static void git_hash_unknown_update(git_hash_ctx *ctx UNUSED,
 }
 
 static void git_hash_unknown_final(unsigned char *hash UNUSED,
-				   git_hash_ctx *ctx UNUSED)
+				   struct git_hash_ctx *ctx UNUSED)
 {
 	BUG("trying to finalize unknown hash");
 }
 
 static void git_hash_unknown_final_oid(struct object_id *oid UNUSED,
-				       git_hash_ctx *ctx UNUSED)
+				       struct git_hash_ctx *ctx UNUSED)
 {
 	BUG("trying to finalize unknown hash");
 }
@@ -1180,7 +1180,7 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
 	unsigned long size;
 	enum object_type obj_type;
 	struct git_istream *st;
-	git_hash_ctx c;
+	struct git_hash_ctx c;
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
 
@@ -1945,7 +1945,7 @@ void *read_object_with_reference(struct repository *r,
 	}
 }
 
-static void hash_object_body(const struct git_hash_algo *algo, git_hash_ctx *c,
+static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_ctx *c,
 			     const void *buf, unsigned long len,
 			     struct object_id *oid,
 			     char *hdr, int *hdrlen)
@@ -1961,7 +1961,7 @@ static void write_object_file_prepare(const struct git_hash_algo *algo,
 				      enum object_type type, struct object_id *oid,
 				      char *hdr, int *hdrlen)
 {
-	git_hash_ctx c;
+	struct git_hash_ctx c;
 
 	/* Generate the header */
 	*hdrlen = format_object_header(hdr, *hdrlen, type, len);
@@ -1975,7 +1975,7 @@ static void write_object_file_prepare_literally(const struct git_hash_algo *algo
 				      const char *type, struct object_id *oid,
 				      char *hdr, int *hdrlen)
 {
-	git_hash_ctx c;
+	struct git_hash_ctx c;
 
 	*hdrlen = format_object_header_literally(hdr, *hdrlen, type, len);
 	hash_object_body(algo, &c, buf, len, oid, hdr, hdrlen);
@@ -2206,7 +2206,7 @@ static int start_loose_object_common(struct strbuf *tmp_file,
 				     const char *filename, unsigned flags,
 				     git_zstream *stream,
 				     unsigned char *buf, size_t buflen,
-				     git_hash_ctx *c, git_hash_ctx *compat_c,
+				     struct git_hash_ctx *c, struct git_hash_ctx *compat_c,
 				     char *hdr, int hdrlen)
 {
 	struct repository *repo = the_repository;
@@ -2251,7 +2251,7 @@ static int start_loose_object_common(struct strbuf *tmp_file,
  * Common steps for the inner git_deflate() loop for writing loose
  * objects. Returns what git_deflate() returns.
  */
-static int write_loose_object_common(git_hash_ctx *c, git_hash_ctx *compat_c,
+static int write_loose_object_common(struct git_hash_ctx *c, struct git_hash_ctx *compat_c,
 				     git_zstream *stream, const int flush,
 				     unsigned char *in0, const int fd,
 				     unsigned char *compressed,
@@ -2280,7 +2280,7 @@ static int write_loose_object_common(git_hash_ctx *c, git_hash_ctx *compat_c,
  * - End the compression of zlib stream.
  * - Get the calculated oid to "oid".
  */
-static int end_loose_object_common(git_hash_ctx *c, git_hash_ctx *compat_c,
+static int end_loose_object_common(struct git_hash_ctx *c, struct git_hash_ctx *compat_c,
 				   git_zstream *stream, struct object_id *oid,
 				   struct object_id *compat_oid)
 {
@@ -2306,7 +2306,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	int fd, ret;
 	unsigned char compressed[4096];
 	git_zstream stream;
-	git_hash_ctx c;
+	struct git_hash_ctx c;
 	struct object_id parano_oid;
 	static struct strbuf tmp_file = STRBUF_INIT;
 	static struct strbuf filename = STRBUF_INIT;
@@ -2386,7 +2386,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 	int fd, ret, err = 0, flush = 0;
 	unsigned char compressed[4096];
 	git_zstream stream;
-	git_hash_ctx c, compat_c;
+	struct git_hash_ctx c, compat_c;
 	struct strbuf tmp_file = STRBUF_INIT;
 	struct strbuf filename = STRBUF_INIT;
 	int dirlen;
@@ -3046,7 +3046,7 @@ static int check_stream_oid(git_zstream *stream,
 			    const char *path,
 			    const struct object_id *expected_oid)
 {
-	git_hash_ctx c;
+	struct git_hash_ctx c;
 	struct object_id real_oid;
 	unsigned char buf[4096];
 	unsigned long total_read;
diff --git a/pack-check.c b/pack-check.c
index 8d9f6da7ce..f20209fccb 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -58,7 +58,7 @@ static int verify_packfile(struct repository *r,
 {
 	off_t index_size = p->index_size;
 	const unsigned char *index_base = p->index_data;
-	git_hash_ctx ctx;
+	struct git_hash_ctx ctx;
 	unsigned char hash[GIT_MAX_RAWSZ], *pack_sig;
 	off_t offset = 0, pack_sig_ofs = 0;
 	uint32_t nr_objects, i;
diff --git a/pack-write.c b/pack-write.c
index 98a8c0e785..9004d1d095 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -388,7 +388,7 @@ void fixup_pack_header_footer(int pack_fd,
 			 off_t partial_pack_offset)
 {
 	int aligned_sz, buf_sz = 8 * 1024;
-	git_hash_ctx old_hash_ctx, new_hash_ctx;
+	struct git_hash_ctx old_hash_ctx, new_hash_ctx;
 	struct pack_header hdr;
 	char *buf;
 	ssize_t read_result;
diff --git a/read-cache.c b/read-cache.c
index d54be2c172..5e765d9af5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1717,7 +1717,7 @@ int verify_ce_order;
 
 static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 {
-	git_hash_ctx c;
+	struct git_hash_ctx c;
 	unsigned char hash[GIT_MAX_RAWSZ];
 	int hdr_version;
 	unsigned char *start, *end;
@@ -2002,7 +2002,7 @@ static struct index_entry_offset_table *read_ieot_extension(const char *mmap, si
 static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_table *ieot);
 
 static size_t read_eoie_extension(const char *mmap, size_t mmap_size);
-static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, size_t offset);
+static void write_eoie_extension(struct strbuf *sb, struct git_hash_ctx *eoie_context, size_t offset);
 
 struct load_index_extensions
 {
@@ -2566,7 +2566,7 @@ int repo_index_has_changes(struct repository *repo,
 }
 
 static int write_index_ext_header(struct hashfile *f,
-				  git_hash_ctx *eoie_f,
+				  struct git_hash_ctx *eoie_f,
 				  unsigned int ext,
 				  unsigned int sz)
 {
@@ -2831,7 +2831,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 {
 	uint64_t start = getnanotime();
 	struct hashfile *f;
-	git_hash_ctx *eoie_c = NULL;
+	struct git_hash_ctx *eoie_c = NULL;
 	struct cache_header hdr;
 	int i, err = 0, removed, extended, hdr_version;
 	struct cache_entry **cache = istate->cache;
@@ -3579,7 +3579,7 @@ static size_t read_eoie_extension(const char *mmap, size_t mmap_size)
 	uint32_t extsize;
 	size_t offset, src_offset;
 	unsigned char hash[GIT_MAX_RAWSZ];
-	git_hash_ctx c;
+	struct git_hash_ctx c;
 
 	/* ensure we have an index big enough to contain an EOIE extension */
 	if (mmap_size < sizeof(struct cache_header) + EOIE_SIZE_WITH_HEADER + the_hash_algo->rawsz)
@@ -3650,7 +3650,7 @@ static size_t read_eoie_extension(const char *mmap, size_t mmap_size)
 	return offset;
 }
 
-static void write_eoie_extension(struct strbuf *sb, git_hash_ctx *eoie_context, size_t offset)
+static void write_eoie_extension(struct strbuf *sb, struct git_hash_ctx *eoie_context, size_t offset)
 {
 	uint32_t buffer;
 	unsigned char hash[GIT_MAX_RAWSZ];
diff --git a/rerere.c b/rerere.c
index e7fa6426b3..5ff9624b57 100644
--- a/rerere.c
+++ b/rerere.c
@@ -358,7 +358,7 @@ static void rerere_strbuf_putconflict(struct strbuf *buf, int ch, size_t size)
 }
 
 static int handle_conflict(struct strbuf *out, struct rerere_io *io,
-			   int marker_size, git_hash_ctx *ctx)
+			   int marker_size, struct git_hash_ctx *ctx)
 {
 	enum {
 		RR_SIDE_1 = 0, RR_SIDE_2, RR_ORIGINAL
@@ -432,7 +432,7 @@ static int handle_conflict(struct strbuf *out, struct rerere_io *io,
  */
 static int handle_path(unsigned char *hash, struct rerere_io *io, int marker_size)
 {
-	git_hash_ctx ctx;
+	struct git_hash_ctx ctx;
 	struct strbuf buf = STRBUF_INIT, out = STRBUF_INIT;
 	int has_conflicts = 0;
 	if (hash)
diff --git a/t/helper/test-hash-speed.c b/t/helper/test-hash-speed.c
index 80df1aae66..803f41c89d 100644
--- a/t/helper/test-hash-speed.c
+++ b/t/helper/test-hash-speed.c
@@ -3,7 +3,7 @@
 
 #define NUM_SECONDS 3
 
-static inline void compute_hash(const struct git_hash_algo *algo, git_hash_ctx *ctx, uint8_t *final, const void *p, size_t len)
+static inline void compute_hash(const struct git_hash_algo *algo, struct git_hash_ctx *ctx, uint8_t *final, const void *p, size_t len)
 {
 	algo->init_fn(ctx);
 	algo->update_fn(ctx, p, len);
@@ -12,7 +12,7 @@ static inline void compute_hash(const struct git_hash_algo *algo, git_hash_ctx *
 
 int cmd__hash_speed(int ac, const char **av)
 {
-	git_hash_ctx ctx;
+	struct git_hash_ctx ctx;
 	unsigned char hash[GIT_MAX_RAWSZ];
 	clock_t initial, start, end;
 	unsigned bufsizes[] = { 64, 256, 1024, 8192, 16384 };
diff --git a/t/helper/test-hash.c b/t/helper/test-hash.c
index aa82638c62..f9a3db487a 100644
--- a/t/helper/test-hash.c
+++ b/t/helper/test-hash.c
@@ -3,7 +3,7 @@
 
 int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
 {
-	git_hash_ctx ctx;
+	struct git_hash_ctx ctx;
 	unsigned char hash[GIT_MAX_HEXSZ];
 	unsigned bufsz = 8192;
 	int binary = 0;
diff --git a/t/unit-tests/u-hash.c b/t/unit-tests/u-hash.c
index a0320efe4b..05204e7b6c 100644
--- a/t/unit-tests/u-hash.c
+++ b/t/unit-tests/u-hash.c
@@ -8,7 +8,7 @@ static void check_hash_data(const void *data, size_t data_length,
 	cl_assert(data != NULL);
 
 	for (size_t i = 1; i < ARRAY_SIZE(hash_algos); i++) {
-		git_hash_ctx ctx;
+		struct git_hash_ctx ctx;
 		unsigned char hash[GIT_MAX_HEXSZ];
 		const struct git_hash_algo *algop = &hash_algos[i];
 
diff --git a/trace2/tr2_sid.c b/trace2/tr2_sid.c
index 09c4ef0d17..c42696ef52 100644
--- a/trace2/tr2_sid.c
+++ b/trace2/tr2_sid.c
@@ -32,7 +32,7 @@ static void tr2_sid_append_my_sid_component(void)
 {
 	const struct git_hash_algo *algo = &hash_algos[GIT_HASH_SHA1];
 	struct tr2_tbuf tb_now;
-	git_hash_ctx ctx;
+	struct git_hash_ctx ctx;
 	pid_t pid = getpid();
 	unsigned char hash[GIT_MAX_RAWSZ + 1];
 	char hex[GIT_MAX_HEXSZ + 1];

-- 
2.48.1.502.g6dc24dfdaf.dirty

