Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8C7255F53
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554224; cv=none; b=IdZ+qPMMWu5ShAL89YBRL/z8Nlun7khG9v8NPoo8Dm/kTIxq8+8uRUnUQMeZGpm+iyIxrJe53X0kvOVseIhNIoF8Saiop2IqXRiGeUMmxfv84xBhC8NGsymTyeaKT3IwBGGvz1o8F1ko2owN+JeuVGBK1yWknadHKXkY247fXfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554224; c=relaxed/simple;
	bh=5F5oYUZr0OYG3GWgpKbMdq/BejqEcPvc5JERNElVz1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IIhE4uC6vdRBT+7EPkFobB8crO9qoGdTd75nW4ZLDBEDofWSJUbthV7sIbHzs7E9RrjMZWqhETamRjWoCgGmZpp/2DZQkHwX2OjlscfDy5Gt+ta+eyADgbzmRmcHOvfRxawlFtdqrblOBCXggXhPXoUKTRTPvqQrWGqVZNH7Qjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U53BrQ/C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lY2pkPDb; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U53BrQ/C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lY2pkPDb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C918EC0192;
	Thu,  7 Aug 2025 04:10:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 07 Aug 2025 04:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754554221;
	 x=1754640621; bh=OvJFugidrncufDwhhTx6mFgAxGwYxdYSE8mufCF9JOY=; b=
	U53BrQ/C4WnAelQpy9AaWPa39+GhAt0k3xgYbmz7/sKpHTEx/gupLvsDTuDAfKsK
	ZGM5CIhJp4YAWjjnHpxLZ5cLPRTaFPxhRz7dJfKht7I1MvUrF2PueKK2XXqRJPxG
	UTsJCQ0xDrt7YDJ2bIazEYIVmag99mxk90XcKi5aV608ei1ijKl3VIDaBP8o4Bcg
	bweqMWY/U1bun/kY/Ww5TbqAd+x3enwpZxwy/5dFV5Y8gFKBUvezWk93nQ7zrK+U
	mxG2AAMHp7xObUXQBi4ElMMrxzkP5PMGSd5sC/0TZV0sMcZsVcap64ldyFmjYMLQ
	idpLUv7TttOWSACU02vCqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754554221; x=
	1754640621; bh=OvJFugidrncufDwhhTx6mFgAxGwYxdYSE8mufCF9JOY=; b=l
	Y2pkPDbzJBvCnvGTbjpSpls1r9Khj4UeTtSSGwIcuFXDBVuk3gJwUjJ8FE6wPxj1
	bOFBgc/fZY1hYbzuT5gOUpx0kV3dhBGq0GcHxcb9jLvReYNKZveszbTnH7846lYu
	cREgfTBvpSycyvpPTAu/SHuPUFW0INpmIo0wWGJ8NhyEQVc18FlO6JQcnl35QAWd
	0axxtSHh/CMa2HgDrx6gLUqxY5CQFV1rrf48RU4rwWY2AaxTG36Foz2BkM3WNY1y
	ElRTUPjII9kuqzMLtTxV5+XBAihLDS8WjhijrX5RlBr0Y2csHLSgPIZOlJYidIv+
	J6m89SWgxDuulmUKzL/ig==
X-ME-Sender: <xms:bV-UaJyF8F2tZYnVL33X6iTgiybDqzJfY8fDRR9Iq-Yv1BDTs_vcsw>
    <xme:bV-UaMgTwb-q2rBi6KTz8hK10Vh9-tmhM_vlFRFuly_oyrvdfIqMnqqLZlBrmn2i0
    6aThzICF8lrk1GrvQ>
X-ME-Received: <xmr:bV-UaMyfJbK0YlDGBmdsuoHxZ-W5kiTJOpQH8x_1CoezUqCdXF2htPfQiqqOShVph6qoSigXn1PGMC8-OZMy0RkXWhem2v4BWUIupWe9Bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bV-UaHLNB0oN_1KEjzQS-5pkRjtXglAEMAtwQGCPMMe5sBoSXvhPGQ>
    <xmx:bV-UaLRmkNMg2YG-t_BKKpDoh4tgsl1LzbmcMUeWQ7YceiNSX7DPcw>
    <xmx:bV-UaHp8hATPbRs78S_tK-n3UBQM-vXDw_sbMB0mtLgFXVgl90dsKw>
    <xmx:bV-UaIpc5eNZdP6ExPF2g1MerwQIqVUqywTOZ8gmRLqSN7jnFbHvCw>
    <xmx:bV-UaBXCJltpVL-idk5OP6czJMtB2Z3uvdUlMklK3BvGUNow_xk6GZQB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 04:10:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 339f571c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 08:10:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 07 Aug 2025 10:09:56 +0200
Subject: [PATCH v2 6/9] midx: load multi-pack indices via their source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-b4-pks-midx-deduplicate-source-info-v2-6-bcffb8fc119c@pks.im>
References: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
In-Reply-To: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

To load a multi-pack index the caller is expected to pass both the
repository and the object directory where the multi-pack index is
located. While this works, this layout has a couple of downsides:

  - We need to pass in information reduntant with the owning source,
    namely its object directory and whether the source is local or not.

  - We don't have access to the source when loading the multi-pack
    index. If we had that access, we could store a pointer to the owning
    source in the MIDX and thus deduplicate some information.

  - Multi-pack indices are inherently specific to the object source and
    its format. With the goal of pluggable object backends in mind we
    will eventually want the backends to own the logic of reading and
    writing multi-pack indices. Making the logic work on top of object
    sources is a step into that direction.

Refactor loading of multi-pack indices accordingly.

This surfaces one small problem though: git-multi-pack-index(1) and our
MIDX test helper both know to read and write multi-pack-indices located
in a different object directory. This issue is addressed by adding the
user-provided object directory as an in-memory alternate.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/multi-pack-index.c  | 18 ++++++++++++--
 midx.c                      | 57 ++++++++++++++++++++-------------------------
 midx.h                      |  6 ++---
 t/helper/test-read-midx.c   | 25 ++++++++++++--------
 t/t5319-multi-pack-index.sh |  8 +++----
 5 files changed, 62 insertions(+), 52 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index aa25b06f9d..e4a9305af3 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -64,12 +64,20 @@ static int parse_object_dir(const struct option *opt, const char *arg,
 	char **value = opt->value;
 	free(*value);
 	if (unset)
-		*value = xstrdup(repo_get_object_directory(the_repository));
+		*value = xstrdup(the_repository->objects->sources->path);
 	else
 		*value = real_pathdup(arg, 1);
 	return 0;
 }
 
+static struct odb_source *handle_object_dir_option(struct repository *repo)
+{
+	struct odb_source *source = odb_find_source(repo->objects, opts.object_dir);
+	if (!source)
+		source = odb_add_to_alternates_memory(repo->objects, opts.object_dir);
+	return source;
+}
+
 static struct option common_opts[] = {
 	OPT_CALLBACK(0, "object-dir", &opts.object_dir,
 	  N_("directory"),
@@ -157,6 +165,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 	if (argc)
 		usage_with_options(builtin_multi_pack_index_write_usage,
 				   options);
+	handle_object_dir_option(repo);
 
 	FREE_AND_NULL(options);
 
@@ -193,6 +202,8 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv,
 			N_("force progress reporting"), MIDX_PROGRESS),
 		OPT_END(),
 	};
+	struct odb_source *source;
+
 	options = add_common_options(builtin_multi_pack_index_verify_options);
 
 	trace2_cmd_mode(argv[0]);
@@ -205,10 +216,11 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv,
 	if (argc)
 		usage_with_options(builtin_multi_pack_index_verify_usage,
 				   options);
+	source = handle_object_dir_option(the_repository);
 
 	FREE_AND_NULL(options);
 
-	return verify_midx_file(the_repository, opts.object_dir, opts.flags);
+	return verify_midx_file(source, opts.flags);
 }
 
 static int cmd_multi_pack_index_expire(int argc, const char **argv,
@@ -233,6 +245,7 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv,
 	if (argc)
 		usage_with_options(builtin_multi_pack_index_expire_usage,
 				   options);
+	handle_object_dir_option(the_repository);
 
 	FREE_AND_NULL(options);
 
@@ -265,6 +278,7 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv,
 	if (argc)
 		usage_with_options(builtin_multi_pack_index_repack_usage,
 				   options);
+	handle_object_dir_option(the_repository);
 
 	FREE_AND_NULL(options);
 
diff --git a/midx.c b/midx.c
index 8459dda8c9..831a7e9b5f 100644
--- a/midx.c
+++ b/midx.c
@@ -95,11 +95,10 @@ static int midx_read_object_offsets(const unsigned char *chunk_start,
 	return 0;
 }
 
-static struct multi_pack_index *load_multi_pack_index_one(struct repository *r,
-							  const char *object_dir,
-							  const char *midx_name,
-							  int local)
+static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *source,
+							  const char *midx_name)
 {
+	struct repository *r = source->odb->repo;
 	struct multi_pack_index *m = NULL;
 	int fd;
 	struct stat st;
@@ -129,10 +128,10 @@ static struct multi_pack_index *load_multi_pack_index_one(struct repository *r,
 	midx_map = xmmap(NULL, midx_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
 
-	FLEX_ALLOC_STR(m, object_dir, object_dir);
+	FLEX_ALLOC_STR(m, object_dir, source->path);
 	m->data = midx_map;
 	m->data_len = midx_size;
-	m->local = local;
+	m->local = source->local;
 	m->repo = r;
 
 	m->signature = get_be32(m->data);
@@ -297,19 +296,18 @@ static int add_midx_to_chain(struct multi_pack_index *midx,
 	return 1;
 }
 
-static struct multi_pack_index *load_midx_chain_fd_st(struct repository *r,
-						      const char *object_dir,
-						      int local,
+static struct multi_pack_index *load_midx_chain_fd_st(struct odb_source *source,
 						      int fd, struct stat *st,
 						      int *incomplete_chain)
 {
+	const struct git_hash_algo *hash_algo = source->odb->repo->hash_algo;
 	struct multi_pack_index *midx_chain = NULL;
 	struct strbuf buf = STRBUF_INIT;
 	int valid = 1;
 	uint32_t i, count;
 	FILE *fp = xfdopen(fd, "r");
 
-	count = st->st_size / (r->hash_algo->hexsz + 1);
+	count = st->st_size / (hash_algo->hexsz + 1);
 
 	for (i = 0; i < count; i++) {
 		struct multi_pack_index *m;
@@ -318,7 +316,7 @@ static struct multi_pack_index *load_midx_chain_fd_st(struct repository *r,
 		if (strbuf_getline_lf(&buf, fp) == EOF)
 			break;
 
-		if (get_oid_hex_algop(buf.buf, &layer, r->hash_algo)) {
+		if (get_oid_hex_algop(buf.buf, &layer, hash_algo)) {
 			warning(_("invalid multi-pack-index chain: line '%s' "
 				  "not a hash"),
 				buf.buf);
@@ -329,9 +327,9 @@ static struct multi_pack_index *load_midx_chain_fd_st(struct repository *r,
 		valid = 0;
 
 		strbuf_reset(&buf);
-		get_split_midx_filename_ext(r->hash_algo, &buf, object_dir,
+		get_split_midx_filename_ext(hash_algo, &buf, source->path,
 					    layer.hash, MIDX_EXT_MIDX);
-		m = load_multi_pack_index_one(r, object_dir, buf.buf, local);
+		m = load_multi_pack_index_one(source, buf.buf);
 
 		if (m) {
 			if (add_midx_to_chain(m, midx_chain)) {
@@ -354,40 +352,35 @@ static struct multi_pack_index *load_midx_chain_fd_st(struct repository *r,
 	return midx_chain;
 }
 
-static struct multi_pack_index *load_multi_pack_index_chain(struct repository *r,
-							    const char *object_dir,
-							    int local)
+static struct multi_pack_index *load_multi_pack_index_chain(struct odb_source *source)
 {
 	struct strbuf chain_file = STRBUF_INIT;
 	struct stat st;
 	int fd;
 	struct multi_pack_index *m = NULL;
 
-	get_midx_chain_filename(&chain_file, object_dir);
-	if (open_multi_pack_index_chain(r->hash_algo, chain_file.buf, &fd, &st)) {
+	get_midx_chain_filename(&chain_file, source->path);
+	if (open_multi_pack_index_chain(source->odb->repo->hash_algo, chain_file.buf, &fd, &st)) {
 		int incomplete;
 		/* ownership of fd is taken over by load function */
-		m = load_midx_chain_fd_st(r, object_dir, local, fd, &st,
-					  &incomplete);
+		m = load_midx_chain_fd_st(source, fd, &st, &incomplete);
 	}
 
 	strbuf_release(&chain_file);
 	return m;
 }
 
-struct multi_pack_index *load_multi_pack_index(struct repository *r,
-					       const char *object_dir,
-					       int local)
+struct multi_pack_index *load_multi_pack_index(struct odb_source *source)
 {
 	struct strbuf midx_name = STRBUF_INIT;
 	struct multi_pack_index *m;
 
-	get_midx_filename(r->hash_algo, &midx_name, object_dir);
+	get_midx_filename(source->odb->repo->hash_algo, &midx_name,
+			  source->path);
 
-	m = load_multi_pack_index_one(r, object_dir,
-				      midx_name.buf, local);
+	m = load_multi_pack_index_one(source, midx_name.buf);
 	if (!m)
-		m = load_multi_pack_index_chain(r, object_dir, local);
+		m = load_multi_pack_index_chain(source);
 
 	strbuf_release(&midx_name);
 
@@ -734,8 +727,7 @@ int prepare_multi_pack_index_one(struct odb_source *source)
 	if (source->midx)
 		return 1;
 
-	source->midx = load_multi_pack_index(r, source->path,
-					     source->local);
+	source->midx = load_multi_pack_index(source);
 
 	return !!source->midx;
 }
@@ -880,12 +872,13 @@ static int compare_pair_pos_vs_id(const void *_a, const void *_b)
 			display_progress(progress, _n); \
 	} while (0)
 
-int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags)
+int verify_midx_file(struct odb_source *source, unsigned flags)
 {
+	struct repository *r = source->odb->repo;
 	struct pair_pos_vs_id *pairs = NULL;
 	uint32_t i;
 	struct progress *progress = NULL;
-	struct multi_pack_index *m = load_multi_pack_index(r, object_dir, 1);
+	struct multi_pack_index *m = load_multi_pack_index(source);
 	struct multi_pack_index *curr;
 	verify_midx_error = 0;
 
@@ -894,7 +887,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 		struct stat sb;
 		struct strbuf filename = STRBUF_INIT;
 
-		get_midx_filename(r->hash_algo, &filename, object_dir);
+		get_midx_filename(r->hash_algo, &filename, source->path);
 
 		if (!stat(filename.buf, &sb)) {
 			error(_("multi-pack-index file exists, but failed to parse"));
diff --git a/midx.h b/midx.h
index f7e07083e1..970d043989 100644
--- a/midx.h
+++ b/midx.h
@@ -100,9 +100,7 @@ void get_split_midx_filename_ext(const struct git_hash_algo *hash_algo,
 				 struct strbuf *buf, const char *object_dir,
 				 const unsigned char *hash, const char *ext);
 
-struct multi_pack_index *load_multi_pack_index(struct repository *r,
-					       const char *object_dir,
-					       int local);
+struct multi_pack_index *load_multi_pack_index(struct odb_source *source);
 int prepare_midx_pack(struct multi_pack_index *m, uint32_t pack_int_id);
 struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
 				   uint32_t pack_int_id);
@@ -136,7 +134,7 @@ int write_midx_file_only(struct repository *r, const char *object_dir,
 			 const char *preferred_pack_name,
 			 const char *refs_snapshot, unsigned flags);
 void clear_midx_file(struct repository *r);
-int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags);
+int verify_midx_file(struct odb_source *source, unsigned flags);
 int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags);
 int midx_repack(struct repository *r, const char *object_dir, size_t batch_size, unsigned flags);
 
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index e430aa247c..bcb8ea7671 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -11,14 +11,24 @@
 #include "gettext.h"
 #include "pack-revindex.h"
 
+static struct multi_pack_index *setup_midx(const char *object_dir)
+{
+	struct odb_source *source;
+	setup_git_directory();
+	source = odb_find_source(the_repository->objects, object_dir);
+	if (!source)
+		source = odb_add_to_alternates_memory(the_repository->objects,
+						      object_dir);
+	return load_multi_pack_index(source);
+}
+
 static int read_midx_file(const char *object_dir, const char *checksum,
 			  int show_objects)
 {
 	uint32_t i;
 	struct multi_pack_index *m;
 
-	setup_git_directory();
-	m = load_multi_pack_index(the_repository, object_dir, 1);
+	m = setup_midx(object_dir);
 
 	if (!m)
 		return 1;
@@ -81,8 +91,7 @@ static int read_midx_checksum(const char *object_dir)
 {
 	struct multi_pack_index *m;
 
-	setup_git_directory();
-	m = load_multi_pack_index(the_repository, object_dir, 1);
+	m = setup_midx(object_dir);
 	if (!m)
 		return 1;
 	printf("%s\n", hash_to_hex(get_midx_checksum(m)));
@@ -96,9 +105,7 @@ static int read_midx_preferred_pack(const char *object_dir)
 	struct multi_pack_index *midx = NULL;
 	uint32_t preferred_pack;
 
-	setup_git_directory();
-
-	midx = load_multi_pack_index(the_repository, object_dir, 1);
+	midx = setup_midx(object_dir);
 	if (!midx)
 		return 1;
 
@@ -119,9 +126,7 @@ static int read_midx_bitmapped_packs(const char *object_dir)
 	struct bitmapped_pack pack;
 	uint32_t i;
 
-	setup_git_directory();
-
-	midx = load_multi_pack_index(the_repository, object_dir, 1);
+	midx = setup_midx(object_dir);
 	if (!midx)
 		return 1;
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index bd75dea950..4e5e882989 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -28,11 +28,11 @@ midx_read_expect () {
 		EOF
 		if test $NUM_PACKS -ge 1
 		then
-			ls $OBJECT_DIR/pack/ | grep idx | sort
+			ls "$OBJECT_DIR"/pack/ | grep idx | sort
 		fi &&
 		printf "object-dir: $OBJECT_DIR\n"
 	} >expect &&
-	test-tool read-midx $OBJECT_DIR >actual &&
+	test-tool read-midx "$OBJECT_DIR" >actual &&
 	test_cmp expect actual
 }
 
@@ -305,7 +305,7 @@ test_expect_success 'midx picks objects from preferred pack' '
 
 		ofs=$(git show-index <objects/pack/test-BC-$bc.idx | grep $b |
 			cut -d" " -f1) &&
-		printf "%s %s\tobjects/pack/test-BC-%s.pack\n" \
+		printf "%s %s\t./objects/pack/test-BC-%s.pack\n" \
 			"$b" "$ofs" "$bc" >expect &&
 		grep ^$b out >actual &&
 
@@ -639,7 +639,7 @@ test_expect_success 'force some 64-bit offsets with pack-objects' '
 		( cd ../objects64 && pwd ) >.git/objects/info/alternates &&
 		midx64=$(git multi-pack-index --object-dir=../objects64 write)
 	) &&
-	midx_read_expect 1 63 5 objects64 " large-offsets"
+	midx_read_expect 1 63 5 "$(pwd)/objects64" " large-offsets"
 '
 
 test_expect_success 'verify multi-pack-index with 64-bit offsets' '

-- 
2.51.0.rc0.215.g125493bb4a.dirty

