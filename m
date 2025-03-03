Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9681F1538
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991662; cv=none; b=u9/8mllgq81QyMwJptMlrmV70gS2FzHl8PQ68cw4by3FcnF35X1fViu0am/EQ+gEtCtBknGafGGYixzKEl2LKGoYpzHxci6FUMG3bEGQfBUGmJAVeZ2pWN8k2phBagRXdbbQoQbnVtaJIsEa2/ZHgEUp+JrS3YjeEsys5i1Be0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991662; c=relaxed/simple;
	bh=A5bDkLEosBP4Wo3Mm3mS+Rs2L3PGZNV0Q5xYG7iSN4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=huUP3rEUA+K3WZ3TR3vT1mt9YkDgdT6LT4GNfFkoWyLMhWu3sQYBHf0yn8tKdVsR6c6Lq0COH4DAxNVmppl/WjicF9joYiJV/NUaKjlodbdexsFq/RR5dlMJHANt6iR9NwWoQySIgm1EHD7Byc+7hY1BfDE6PU9EmfNhAgO7SY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A+mqY1Tm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6HRa+Kdu; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A+mqY1Tm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6HRa+Kdu"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C50392540126
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 03:47:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 03 Mar 2025 03:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740991657;
	 x=1741078057; bh=zzV/9x/+cEiOaM1sJxn8LQI9r2/0h3cFDIrWtdsiSu8=; b=
	A+mqY1TmxbxH7Fm7h/5TlEUf658NigHdLtgp/CFk7g+gILPj4pk4RGLpcLn+nNQb
	sZN8MRzz6jK6cwPmSpS2lkJM/mA8f4Kog5ZRWHiFR4EauId2Fd2nq0ZU1kmoAwpN
	oME2M/G9FZiZt62Wmvuo8YJ1k+VCw/2LpnsN41D7fUtTj4w98qeOK60F2FWg8vyV
	aNEx6CWu01R48Y0ckcrReQE5WQ8PvTDkXn97xkq1/ODDYOzpAzyOe+Zi2OxyRD5B
	uvrrptE2y2hN55yulUuLIR1807bOdsNVGSKUC7AAUIVpCc20nPVHBBITE3a0CAlq
	fSWj5Z8lM1fTRdSZzd8TsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740991657; x=
	1741078057; bh=zzV/9x/+cEiOaM1sJxn8LQI9r2/0h3cFDIrWtdsiSu8=; b=6
	HRa+KduTc0ZfxFlC4CMRsgnDOPdyc4LBDVljOEOMOviet8wpzwkZyk+oSzwOOmZ9
	blUklqwG8vhHYpLz1AuuU7IpQDmrjq7W3QU8w7AC27eoxi0Yefg0VrnYWvIAblIq
	HLDFxSeD2Jajf2tOCOPxVffui48NsmO9GqIGmGOo1ihOHjEG0GZ3mXpHZrK8iSAg
	cwLwXj1CJmEm/uUnS3tXrcY3vKRbUTEQoam2xVoNCLQlb/Qf8Ou/42bsvZ7EsOMF
	zP09YI5IYtrpFY/4+2EK4vIzf3hxsovflZePDZebx47Df13kEepx3zeAW9azQh6x
	N5xXKmmZjTAfEoGkMPuLw==
X-ME-Sender: <xms:qWzFZxX8JIdMY_tNaxq393XjqU14DimH_htsJpvJHwV4YykwOjm7dA>
    <xme:qWzFZxlPjKYkcMmen0zYJtz1FEBxlSvBUVISHTDRnVy27EA6oMY6vv2VeQkPCQYCH
    J3g6TGomQpyUtm1bw>
X-ME-Received: <xmr:qWzFZ9Z7OomXmtDysy0QwZj_IAkyqfxd5lbDmPkTpRyT_fJPeZVXOrx2dmauF0Owus66cEm2oRG2Uddl_xaR6DIPu1tree4NiWY37VkgT9ytW7sC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qWzFZ0VqVPvpVE_kZJn7xKW-1Mskv3_-ofJYrTuyvr7Il-d4IR598Q>
    <xmx:qWzFZ7kBS-SwlgSphNyqrMx-a66UCOWfx10rhDIUoqb80ysanv75CA>
    <xmx:qWzFZxeO7hzdDVPHo-Cr2x3d7XFEU46X21vvMnHH6NmAZ2_jsHkNxA>
    <xmx:qWzFZ1G7DAcZwHqFiXGypc3XnFb3-ncAfN0uu6g9QY_JA1wN6Q8Ing>
    <xmx:qWzFZzuZMiYvUjtfo9hY2jSE299Ktov0RexDpSJ-KFH_9Iisw5kdYfjh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Mar 2025 03:47:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 59f2f054 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Mar 2025 08:47:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Mar 2025 09:47:30 +0100
Subject: [PATCH 01/12] csum-file: stop depending on `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-b4-pks-objects-without-the-repository-v1-1-c5dd43f2476e@pks.im>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

There are multiple sites in "csum-file.c" where we use the global
`the_repository` variable, either explicitly or implicitly by using
`the_hash_algo`.

Refactor the code to stop using `the_repository` by adapting functions
to receive required data as parameters. Adapt callsites accordingly by
either using `the_repository->hash_algo`, or by using a context-provided
hash algorithm in case the subsystem already got rid of its dependency
on `the_repository`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c  |  2 +-
 builtin/index-pack.c   |  2 +-
 builtin/pack-objects.c |  3 ++-
 commit-graph.c         |  9 ++++++---
 csum-file.c            | 28 ++++++++++++++++------------
 csum-file.h            | 12 ++++++++----
 midx-write.c           |  6 ++++--
 midx.c                 |  3 ++-
 pack-bitmap-write.c    |  2 +-
 pack-bitmap.c          |  9 +++++----
 pack-check.c           |  2 +-
 pack-revindex.c        |  3 ++-
 pack-write.c           | 12 ++++++------
 read-cache.c           |  2 +-
 14 files changed, 56 insertions(+), 39 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 397a6f46ad8..86e6e754816 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -770,7 +770,7 @@ static void start_packfile(void)
 	p->pack_fd = pack_fd;
 	p->do_not_close = 1;
 	p->repo = the_repository;
-	pack_file = hashfd(pack_fd, p->pack_name);
+	pack_file = hashfd(the_repository->hash_algo, pack_fd, p->pack_name);
 
 	pack_data = p;
 	pack_size = write_pack_header(pack_file, 0);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 52cc97d52cb..3eb5af20950 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1381,7 +1381,7 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 		REALLOC_ARRAY(objects, nr_objects + nr_unresolved + 1);
 		memset(objects + nr_objects + 1, 0,
 		       nr_unresolved * sizeof(*objects));
-		f = hashfd(output_fd, curr_pack);
+		f = hashfd(the_repository->hash_algo, output_fd, curr_pack);
 		fix_unresolved_deltas(f);
 		strbuf_addf(&msg, Q_("completed with %d local object",
 				     "completed with %d local objects",
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 58a9b161262..8e282f2a980 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1311,7 +1311,8 @@ static void write_pack_file(void)
 		char *pack_tmp_name = NULL;
 
 		if (pack_to_stdout)
-			f = hashfd_throughput(1, "<stdout>", progress_state);
+			f = hashfd_throughput(the_repository->hash_algo, 1,
+					      "<stdout>", progress_state);
 		else
 			f = create_tmp_packfile(&pack_tmp_name);
 
diff --git a/commit-graph.c b/commit-graph.c
index 1021ccb983d..8286d5dda24 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2090,11 +2090,13 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			return -1;
 		}
 
-		f = hashfd(get_tempfile_fd(graph_layer), get_tempfile_path(graph_layer));
+		f = hashfd(the_repository->hash_algo,
+			   get_tempfile_fd(graph_layer), get_tempfile_path(graph_layer));
 	} else {
 		hold_lock_file_for_update_mode(&lk, ctx->graph_name,
 					       LOCK_DIE_ON_ERROR, 0444);
-		f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
+		f = hashfd(the_repository->hash_algo,
+			   get_lock_file_fd(&lk), get_lock_file_path(&lk));
 	}
 
 	cf = init_chunkfile(f);
@@ -2716,7 +2718,8 @@ static void graph_report(const char *fmt, ...)
 
 static int commit_graph_checksum_valid(struct commit_graph *g)
 {
-	return hashfile_checksum_valid(g->data, g->data_len);
+	return hashfile_checksum_valid(the_repository->hash_algo,
+				       g->data, g->data_len);
 }
 
 static int verify_one_commit_graph(struct repository *r,
diff --git a/csum-file.c b/csum-file.c
index b58c183a4f0..6e21e3cac8a 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -8,8 +8,6 @@
  * able to verify hasn't been messed with afterwards.
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "csum-file.h"
 #include "git-zlib.h"
@@ -148,21 +146,23 @@ void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
 	}
 }
 
-struct hashfile *hashfd_check(const char *name)
+struct hashfile *hashfd_check(const struct git_hash_algo *algop,
+			      const char *name)
 {
 	int sink, check;
 	struct hashfile *f;
 
 	sink = xopen("/dev/null", O_WRONLY);
 	check = xopen(name, O_RDONLY);
-	f = hashfd(sink, name);
+	f = hashfd(algop, sink, name);
 	f->check_fd = check;
 	f->check_buffer = xmalloc(f->buffer_len);
 
 	return f;
 }
 
-static struct hashfile *hashfd_internal(int fd, const char *name,
+static struct hashfile *hashfd_internal(const struct git_hash_algo *algop,
+					int fd, const char *name,
 					struct progress *tp,
 					size_t buffer_len)
 {
@@ -176,7 +176,7 @@ static struct hashfile *hashfd_internal(int fd, const char *name,
 	f->do_crc = 0;
 	f->skip_hash = 0;
 
-	f->algop = unsafe_hash_algo(the_hash_algo);
+	f->algop = unsafe_hash_algo(algop);
 	f->algop->init_fn(&f->ctx);
 
 	f->buffer_len = buffer_len;
@@ -186,17 +186,19 @@ static struct hashfile *hashfd_internal(int fd, const char *name,
 	return f;
 }
 
-struct hashfile *hashfd(int fd, const char *name)
+struct hashfile *hashfd(const struct git_hash_algo *algop,
+			int fd, const char *name)
 {
 	/*
 	 * Since we are not going to use a progress meter to
 	 * measure the rate of data passing through this hashfile,
 	 * use a larger buffer size to reduce fsync() calls.
 	 */
-	return hashfd_internal(fd, name, NULL, 128 * 1024);
+	return hashfd_internal(algop, fd, name, NULL, 128 * 1024);
 }
 
-struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp)
+struct hashfile *hashfd_throughput(const struct git_hash_algo *algop,
+				   int fd, const char *name, struct progress *tp)
 {
 	/*
 	 * Since we are expecting to report progress of the
@@ -204,7 +206,7 @@ struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp
 	 * size so the progress indicators arrive at a more
 	 * frequent rate.
 	 */
-	return hashfd_internal(fd, name, tp, 8 * 1024);
+	return hashfd_internal(algop, fd, name, tp, 8 * 1024);
 }
 
 void hashfile_checkpoint_init(struct hashfile *f,
@@ -246,13 +248,15 @@ uint32_t crc32_end(struct hashfile *f)
 	return f->crc32;
 }
 
-int hashfile_checksum_valid(const unsigned char *data, size_t total_len)
+int hashfile_checksum_valid(const struct git_hash_algo *algop,
+			    const unsigned char *data, size_t total_len)
 {
 	unsigned char got[GIT_MAX_RAWSZ];
 	struct git_hash_ctx ctx;
-	const struct git_hash_algo *algop = unsafe_hash_algo(the_hash_algo);
 	size_t data_len = total_len - algop->rawsz;
 
+	algop = unsafe_hash_algo(algop);
+
 	if (total_len < algop->rawsz)
 		return 0; /* say "too short"? */
 
diff --git a/csum-file.h b/csum-file.h
index ffccbf09966..07ae11024af 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -45,9 +45,12 @@ int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint *);
 #define CSUM_FSYNC		2
 #define CSUM_HASH_IN_STREAM	4
 
-struct hashfile *hashfd(int fd, const char *name);
-struct hashfile *hashfd_check(const char *name);
-struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp);
+struct hashfile *hashfd(const struct git_hash_algo *algop,
+			int fd, const char *name);
+struct hashfile *hashfd_check(const struct git_hash_algo *algop,
+			      const char *name);
+struct hashfile *hashfd_throughput(const struct git_hash_algo *algop,
+				   int fd, const char *name, struct progress *tp);
 
 /*
  * Free the hashfile without flushing its contents to disk. This only
@@ -66,7 +69,8 @@ void crc32_begin(struct hashfile *);
 uint32_t crc32_end(struct hashfile *);
 
 /* Verify checksum validity while reading. Returns non-zero on success. */
-int hashfile_checksum_valid(const unsigned char *data, size_t len);
+int hashfile_checksum_valid(const struct git_hash_algo *algop,
+			    const unsigned char *data, size_t len);
 
 /*
  * Returns the total number of bytes fed to the hashfile so far (including ones
diff --git a/midx-write.c b/midx-write.c
index 48d6558253e..26d9d8bb148 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1342,10 +1342,12 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			return -1;
 		}
 
-		f = hashfd(get_tempfile_fd(incr), get_tempfile_path(incr));
+		f = hashfd(r->hash_algo, get_tempfile_fd(incr),
+			   get_tempfile_path(incr));
 	} else {
 		hold_lock_file_for_update(&lk, midx_name.buf, LOCK_DIE_ON_ERROR);
-		f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
+		f = hashfd(r->hash_algo, get_lock_file_fd(&lk),
+			   get_lock_file_path(&lk));
 	}
 
 	cf = init_chunkfile(f);
diff --git a/midx.c b/midx.c
index d91088efb87..807fdf72f7b 100644
--- a/midx.c
+++ b/midx.c
@@ -747,7 +747,8 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
 
 int midx_checksum_valid(struct multi_pack_index *m)
 {
-	return hashfile_checksum_valid(m->data, m->data_len);
+	return hashfile_checksum_valid(m->repo->hash_algo,
+				       m->data, m->data_len);
 }
 
 struct clear_midx_data {
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 34e86d49947..50e5c491ccb 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1030,7 +1030,7 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 	if (writer->pseudo_merges_nr)
 		options |= BITMAP_OPT_PSEUDO_MERGES;
 
-	f = hashfd(fd, tmp_file.buf);
+	f = hashfd(the_repository->hash_algo, fd, tmp_file.buf);
 
 	memcpy(header.magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE));
 	header.version = htons(default_version);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 6406953d322..f0e2c000252 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -3024,7 +3024,8 @@ int bitmap_is_preferred_refname(struct repository *r, const char *refname)
 	return 0;
 }
 
-static int verify_bitmap_file(const char *name)
+static int verify_bitmap_file(const struct git_hash_algo *algop,
+			      const char *name)
 {
 	struct stat st;
 	unsigned char *data;
@@ -3040,7 +3041,7 @@ static int verify_bitmap_file(const char *name)
 
 	data = xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
-	if (!hashfile_checksum_valid(data, st.st_size))
+	if (!hashfile_checksum_valid(algop, data, st.st_size))
 		res = error(_("bitmap file '%s' has invalid checksum"),
 			    name);
 
@@ -3055,14 +3056,14 @@ int verify_bitmap_files(struct repository *r)
 	for (struct multi_pack_index *m = get_multi_pack_index(r);
 	     m; m = m->next) {
 		char *midx_bitmap_name = midx_bitmap_filename(m);
-		res |= verify_bitmap_file(midx_bitmap_name);
+		res |= verify_bitmap_file(r->hash_algo, midx_bitmap_name);
 		free(midx_bitmap_name);
 	}
 
 	for (struct packed_git *p = get_all_packs(r);
 	     p; p = p->next) {
 		char *pack_bitmap_name = pack_bitmap_filename(p);
-		res |= verify_bitmap_file(pack_bitmap_name);
+		res |= verify_bitmap_file(r->hash_algo, pack_bitmap_name);
 		free(pack_bitmap_name);
 	}
 
diff --git a/pack-check.c b/pack-check.c
index d0aeb5ec412..6bcadc1e679 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -180,7 +180,7 @@ int verify_pack_index(struct packed_git *p)
 		return error("packfile %s index not opened", p->pack_name);
 
 	/* Verify SHA1 sum of the index file */
-	if (!hashfile_checksum_valid(p->index_data, p->index_size))
+	if (!hashfile_checksum_valid(the_repository->hash_algo, p->index_data, p->index_size))
 		err = error("Packfile index for %s hash mismatch",
 			    p->pack_name);
 	return err;
diff --git a/pack-revindex.c b/pack-revindex.c
index d3832478d99..78139e3d7f5 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -322,7 +322,8 @@ int verify_pack_revindex(struct packed_git *p)
 	if (!p->revindex_map || !p->revindex_data)
 		return res;
 
-	if (!hashfile_checksum_valid((const unsigned char *)p->revindex_map, p->revindex_size)) {
+	if (!hashfile_checksum_valid(the_repository->hash_algo,
+				     (const unsigned char *)p->revindex_map, p->revindex_size)) {
 		error(_("invalid checksum"));
 		res = -1;
 	}
diff --git a/pack-write.c b/pack-write.c
index 823e40b42f2..5eb89f44cf4 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -82,7 +82,7 @@ const char *write_idx_file(const struct git_hash_algo *hash_algo,
 
 	if (opts->flags & WRITE_IDX_VERIFY) {
 		assert(index_name);
-		f = hashfd_check(index_name);
+		f = hashfd_check(the_repository->hash_algo, index_name);
 	} else {
 		if (!index_name) {
 			struct strbuf tmp_file = STRBUF_INIT;
@@ -92,7 +92,7 @@ const char *write_idx_file(const struct git_hash_algo *hash_algo,
 			unlink(index_name);
 			fd = xopen(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
 		}
-		f = hashfd(fd, index_name);
+		f = hashfd(the_repository->hash_algo, fd, index_name);
 	}
 
 	/* if last object's offset is >= 2^31 we should use index V2 */
@@ -268,7 +268,7 @@ char *write_rev_file_order(const struct git_hash_algo *hash_algo,
 			fd = xopen(rev_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
 			path = xstrdup(rev_name);
 		}
-		f = hashfd(fd, path);
+		f = hashfd(the_repository->hash_algo, fd, path);
 	} else if (flags & WRITE_REV_VERIFY) {
 		struct stat statbuf;
 		if (stat(rev_name, &statbuf)) {
@@ -278,7 +278,7 @@ char *write_rev_file_order(const struct git_hash_algo *hash_algo,
 			} else
 				die_errno(_("could not stat: %s"), rev_name);
 		}
-		f = hashfd_check(rev_name);
+		f = hashfd_check(the_repository->hash_algo, rev_name);
 		path = xstrdup(rev_name);
 	} else {
 		return NULL;
@@ -346,7 +346,7 @@ static char *write_mtimes_file(const struct git_hash_algo *hash_algo,
 
 	fd = odb_mkstemp(&tmp_file, "pack/tmp_mtimes_XXXXXX");
 	mtimes_name = strbuf_detach(&tmp_file, NULL);
-	f = hashfd(fd, mtimes_name);
+	f = hashfd(the_repository->hash_algo, fd, mtimes_name);
 
 	write_mtimes_header(hash_algo, f);
 	write_mtimes_objects(f, to_pack, objects, nr_objects);
@@ -534,7 +534,7 @@ struct hashfile *create_tmp_packfile(char **pack_tmp_name)
 
 	fd = odb_mkstemp(&tmpname, "pack/tmp_pack_XXXXXX");
 	*pack_tmp_name = strbuf_detach(&tmpname, NULL);
-	return hashfd(fd, *pack_tmp_name);
+	return hashfd(the_repository->hash_algo, fd, *pack_tmp_name);
 }
 
 static void rename_tmp_packfile(struct strbuf *name_prefix, const char *source,
diff --git a/read-cache.c b/read-cache.c
index e678c13e8f1..a012cb22368 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2848,7 +2848,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	struct strbuf sb = STRBUF_INIT;
 	int nr, nr_threads, ret;
 
-	f = hashfd(tempfile->fd, tempfile->filename.buf);
+	f = hashfd(the_repository->hash_algo, tempfile->fd, tempfile->filename.buf);
 
 	prepare_repo_settings(r);
 	f->skip_hash = r->settings.index_skip_hash;

-- 
2.49.0.rc0.375.gae4b89d849.dirty

