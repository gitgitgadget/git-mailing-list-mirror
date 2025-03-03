Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5D21F193C
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991663; cv=none; b=fparFhB9Bc3yuZZ3ZqiKdj133FziCwezoETyPWPtSU8XQCSU/lo3qjL6WxCLBNGa545un7aTj00w37dfcVy5vJCC3TGQpJE1O4oEB0xHPuBuCn8V3c/NH1RyTWPOZG0LoKgWMhQ5PJ1hrN3LS+KWH4CiO4jSjW6oPYaoc4JHahU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991663; c=relaxed/simple;
	bh=4jFmu4kunQIKbbOlSCfBuPbma3c7MDJV7zPm6y1K9HQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sp6rgqHA8WHTT2PHliWr4ycPccBkce/+d3vT+J+U6fLqDMmjdsB8A/QIR1oR0fnsUNTnWeimXAN5bKc6qECqWm65sWQkruH4+ZT5VAwqrsRLpD7jpv7ftNHEirGLRQUGRkU24egsD8lkkbkQ5l711JeGJfzbXIqUV1ftXGbLrwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vve4TFCJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JGBcqbKj; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vve4TFCJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JGBcqbKj"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2F9CB2540147
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 03:47:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 03 Mar 2025 03:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740991659;
	 x=1741078059; bh=6oUWM8Oj5qm3lK+e3k3DtFr4J2IC2sQSmiFDY8IcOTY=; b=
	Vve4TFCJ93PZ34UQlD2goi89RsgLYlszGpNvjGBiqSOSJAbje1oSSqssK4kxYCrS
	Z5sC6r4aiVD/nhNLMIumK/9sVcre7AGrBnlr7G8RTAlw5e8WcBmGUWqZ4/MJq+rx
	sZBBJw1Kru79l7mT++iBn9bZ1Tvczs+abMbBGjhVOMoEaWTFAmr89ixIEgK6VL5x
	+ptHcZ2AQ1PAzJq13iFjH9mlGdn9ZK/m5OURjj0KGxjVZntzbviV0SXwSiGzGH0I
	c4oARVgJl/ujTNHTMk5reYe/tmKj/zzKrrXEALvAV9AO0MC76gz6TO/zIJUKgc8i
	BaCVaKHX2ZtqABTkXg/rXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740991659; x=
	1741078059; bh=6oUWM8Oj5qm3lK+e3k3DtFr4J2IC2sQSmiFDY8IcOTY=; b=J
	GBcqbKjUXLQ30RLU+3Yl6R2dh6hlsTiKmvLkiMF4QQP5ItwdoLpuZIyCT2eNJv0p
	QFkXjYoFNYxfb/V7KCO6LBnR620/UgUd93qdEdaCKpnJ6jk2nDg7XCcDWIDgTvIS
	J/wpzO64n8A3DiGZb/ZDbmq0ua7kTKFOghYWQEJRFaFgl8XVEf7T8w734tStGw2Y
	MQXe3lQCNB8DEQBnDFoC85qNR2H5fDXgBOSh3iKQ5XN0Fa/qjrXWxmDUc4hLIDP8
	esavx8KYRS2IWtTL9FQKpMDVebodKkZoyRseIoquf4RbUIleOCL6YyLYdkMUXrKF
	aBf+cDF0S0DzchmQM/cpw==
X-ME-Sender: <xms:qmzFZ__zWZJ4YkSiQEGWdj42lqqBl1Qz4PsJf5KTz6wPH8G54lw-jQ>
    <xme:qmzFZ7sZjnp-lGNtJAvXAFhofH7ePBTupVuVkwijUdDhVP5EFgSZk74sS97rSiBsE
    Xp-P-MemYvVKOBRPQ>
X-ME-Received: <xmr:qmzFZ9BOY7Ms3Idp9edgzTtY_2QW-wCp35kr6rxcxi7KOMGjyOJZ1hpCSbIJL8tocaKpRJvo1RZ8fp2WRHCXKgK6PLT3Qo0474Uy2jmjb1bTf-qH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qmzFZ7fauubK-YQ9t5rn0T4xYksyRHJYD7WCnN7U_a2A2edPlB4lbQ>
    <xmx:qmzFZ0NOB61FSUzzWf7rmBP3sh02MmtrHbdzy3gmvtmGjEv7RAcn4Q>
    <xmx:qmzFZ9kgF_2l9R5GSSSECOb9Ldjr85wCDoKO-MV8tZm7r1a3P4eyRQ>
    <xmx:qmzFZ-uDBXMKRGjKZdky1iV7gqADIT7gvTZL2e_wRoc2gzMpZeEf5A>
    <xmx:q2zFZ-3ltyxp_mmkR-7mnJ9Gi99b-CUrP5dQ8WB3jaO5ZwCOVeRuAHDa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Mar 2025 03:47:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 105b275a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Mar 2025 08:47:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Mar 2025 09:47:32 +0100
Subject: [PATCH 03/12] pack-write: stop depending on `the_repository` and
 `the_hash_algo`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-b4-pks-objects-without-the-repository-v1-3-c5dd43f2476e@pks.im>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

There are a couple of functions in "pack-write.c" that implicitly depend
on `the_repository` or `the_hash_algo`. Remove this dependency by
injecting the repository via a parameter and adapt callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c  |  2 +-
 builtin/index-pack.c   |  4 ++--
 builtin/pack-objects.c |  4 ++--
 bulk-checkin.c         |  4 ++--
 midx-write.c           |  2 +-
 pack-write.c           | 55 +++++++++++++++++++++++++-------------------------
 pack.h                 | 11 +++++-----
 7 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 86e6e754816..e1758aa9514 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -798,7 +798,7 @@ static const char *create_index(void)
 	if (c != last)
 		die("internal consistency error creating the index");
 
-	tmpfile = write_idx_file(the_hash_algo, NULL, idx, object_count,
+	tmpfile = write_idx_file(the_repository, NULL, idx, object_count,
 				 &pack_idx_opts, pack_data->hash);
 	free(idx);
 	return tmpfile;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b8bb0ac01de..e4f2aa01ed5 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -2088,10 +2088,10 @@ int cmd_index_pack(int argc,
 	ALLOC_ARRAY(idx_objects, nr_objects);
 	for (i = 0; i < nr_objects; i++)
 		idx_objects[i] = &objects[i].idx;
-	curr_index = write_idx_file(the_hash_algo, index_name, idx_objects,
+	curr_index = write_idx_file(the_repository, index_name, idx_objects,
 				    nr_objects, &opts, pack_hash);
 	if (rev_index)
-		curr_rev_index = write_rev_file(the_hash_algo, rev_index_name,
+		curr_rev_index = write_rev_file(the_repository, rev_index_name,
 						idx_objects, nr_objects,
 						pack_hash, opts.flags);
 	free(idx_objects);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c3adbc94504..e05dfc4021e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1314,7 +1314,7 @@ static void write_pack_file(void)
 			f = hashfd_throughput(the_repository->hash_algo, 1,
 					      "<stdout>", progress_state);
 		else
-			f = create_tmp_packfile(&pack_tmp_name);
+			f = create_tmp_packfile(the_repository, &pack_tmp_name);
 
 		offset = write_pack_header(f, nr_remaining);
 
@@ -1407,7 +1407,7 @@ static void write_pack_file(void)
 			if (cruft)
 				pack_idx_opts.flags |= WRITE_MTIMES;
 
-			stage_tmp_packfiles(the_hash_algo, &tmpname,
+			stage_tmp_packfiles(the_repository, &tmpname,
 					    pack_tmp_name, written_list,
 					    nr_written, &to_pack,
 					    &pack_idx_opts, hash,
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 20f2da67b93..23ac00ea0a6 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -44,7 +44,7 @@ static void finish_tmp_packfile(struct strbuf *basename,
 {
 	char *idx_tmp_name = NULL;
 
-	stage_tmp_packfiles(the_hash_algo, basename, pack_tmp_name,
+	stage_tmp_packfiles(the_repository, basename, pack_tmp_name,
 			    written_list, nr_written, NULL, pack_idx_opts, hash,
 			    &idx_tmp_name);
 	rename_tmp_packfile_idx(basename, &idx_tmp_name);
@@ -244,7 +244,7 @@ static void prepare_to_stream(struct bulk_checkin_packfile *state,
 	if (!(flags & HASH_WRITE_OBJECT) || state->f)
 		return;
 
-	state->f = create_tmp_packfile(&state->pack_tmp_name);
+	state->f = create_tmp_packfile(the_repository, &state->pack_tmp_name);
 	reset_pack_idx_option(&state->pack_idx_opts);
 
 	/* Pretend we are going to write only one object */
diff --git a/midx-write.c b/midx-write.c
index ac80a8298ed..a628ac24dcb 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -658,7 +658,7 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
 	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex_algop(midx_hash,
 								    ctx->repo->hash_algo));
 
-	tmp_file = write_rev_file_order(ctx->repo->hash_algo, NULL, ctx->pack_order,
+	tmp_file = write_rev_file_order(ctx->repo, NULL, ctx->pack_order,
 					ctx->entries_nr, midx_hash, WRITE_REV);
 
 	if (finalize_object_file(tmp_file, buf.buf))
diff --git a/pack-write.c b/pack-write.c
index 5eb89f44cf4..6b06315f80a 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
@@ -56,7 +54,7 @@ static int need_large_offset(off_t offset, const struct pack_idx_option *opts)
  * The *sha1 contains the pack content SHA1 hash.
  * The objects array passed in will be sorted by SHA1 on exit.
  */
-const char *write_idx_file(const struct git_hash_algo *hash_algo,
+const char *write_idx_file(struct repository *repo,
 			   const char *index_name, struct pack_idx_entry **objects,
 			   int nr_objects, const struct pack_idx_option *opts,
 			   const unsigned char *sha1)
@@ -82,7 +80,7 @@ const char *write_idx_file(const struct git_hash_algo *hash_algo,
 
 	if (opts->flags & WRITE_IDX_VERIFY) {
 		assert(index_name);
-		f = hashfd_check(the_repository->hash_algo, index_name);
+		f = hashfd_check(repo->hash_algo, index_name);
 	} else {
 		if (!index_name) {
 			struct strbuf tmp_file = STRBUF_INIT;
@@ -92,7 +90,7 @@ const char *write_idx_file(const struct git_hash_algo *hash_algo,
 			unlink(index_name);
 			fd = xopen(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
 		}
-		f = hashfd(the_repository->hash_algo, fd, index_name);
+		f = hashfd(repo->hash_algo, fd, index_name);
 	}
 
 	/* if last object's offset is >= 2^31 we should use index V2 */
@@ -131,7 +129,7 @@ const char *write_idx_file(const struct git_hash_algo *hash_algo,
 		struct pack_idx_entry *obj = *list++;
 		if (index_version < 2)
 			hashwrite_be32(f, obj->offset);
-		hashwrite(f, obj->oid.hash, hash_algo->rawsz);
+		hashwrite(f, obj->oid.hash, repo->hash_algo->rawsz);
 		if ((opts->flags & WRITE_IDX_STRICT) &&
 		    (i && oideq(&list[-2]->oid, &obj->oid)))
 			die("The same object %s appears twice in the pack",
@@ -173,7 +171,7 @@ const char *write_idx_file(const struct git_hash_algo *hash_algo,
 		}
 	}
 
-	hashwrite(f, sha1, hash_algo->rawsz);
+	hashwrite(f, sha1, repo->hash_algo->rawsz);
 	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
 			  CSUM_HASH_IN_STREAM | CSUM_CLOSE |
 			  ((opts->flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
@@ -217,7 +215,7 @@ static void write_rev_trailer(const struct git_hash_algo *hash_algo,
 	hashwrite(f, hash, hash_algo->rawsz);
 }
 
-char *write_rev_file(const struct git_hash_algo *hash_algo,
+char *write_rev_file(struct repository *repo,
 		     const char *rev_name,
 		     struct pack_idx_entry **objects,
 		     uint32_t nr_objects,
@@ -236,7 +234,7 @@ char *write_rev_file(const struct git_hash_algo *hash_algo,
 		pack_order[i] = i;
 	QSORT_S(pack_order, nr_objects, pack_order_cmp, objects);
 
-	ret = write_rev_file_order(hash_algo, rev_name, pack_order, nr_objects,
+	ret = write_rev_file_order(repo, rev_name, pack_order, nr_objects,
 				   hash, flags);
 
 	free(pack_order);
@@ -244,7 +242,7 @@ char *write_rev_file(const struct git_hash_algo *hash_algo,
 	return ret;
 }
 
-char *write_rev_file_order(const struct git_hash_algo *hash_algo,
+char *write_rev_file_order(struct repository *repo,
 			   const char *rev_name,
 			   uint32_t *pack_order,
 			   uint32_t nr_objects,
@@ -268,7 +266,7 @@ char *write_rev_file_order(const struct git_hash_algo *hash_algo,
 			fd = xopen(rev_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
 			path = xstrdup(rev_name);
 		}
-		f = hashfd(the_repository->hash_algo, fd, path);
+		f = hashfd(repo->hash_algo, fd, path);
 	} else if (flags & WRITE_REV_VERIFY) {
 		struct stat statbuf;
 		if (stat(rev_name, &statbuf)) {
@@ -278,18 +276,18 @@ char *write_rev_file_order(const struct git_hash_algo *hash_algo,
 			} else
 				die_errno(_("could not stat: %s"), rev_name);
 		}
-		f = hashfd_check(the_repository->hash_algo, rev_name);
+		f = hashfd_check(repo->hash_algo, rev_name);
 		path = xstrdup(rev_name);
 	} else {
 		return NULL;
 	}
 
-	write_rev_header(hash_algo, f);
+	write_rev_header(repo->hash_algo, f);
 
 	write_rev_index_positions(f, pack_order, nr_objects);
-	write_rev_trailer(hash_algo, f, hash);
+	write_rev_trailer(repo->hash_algo, f, hash);
 
-	if (adjust_shared_perm(the_repository, path) < 0)
+	if (adjust_shared_perm(repo, path) < 0)
 		die(_("failed to make %s readable"), path);
 
 	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
@@ -330,7 +328,7 @@ static void write_mtimes_trailer(const struct git_hash_algo *hash_algo,
 	hashwrite(f, hash, hash_algo->rawsz);
 }
 
-static char *write_mtimes_file(const struct git_hash_algo *hash_algo,
+static char *write_mtimes_file(struct repository *repo,
 			       struct packing_data *to_pack,
 			       struct pack_idx_entry **objects,
 			       uint32_t nr_objects,
@@ -346,13 +344,13 @@ static char *write_mtimes_file(const struct git_hash_algo *hash_algo,
 
 	fd = odb_mkstemp(&tmp_file, "pack/tmp_mtimes_XXXXXX");
 	mtimes_name = strbuf_detach(&tmp_file, NULL);
-	f = hashfd(the_repository->hash_algo, fd, mtimes_name);
+	f = hashfd(repo->hash_algo, fd, mtimes_name);
 
-	write_mtimes_header(hash_algo, f);
+	write_mtimes_header(repo->hash_algo, f);
 	write_mtimes_objects(f, to_pack, objects, nr_objects);
-	write_mtimes_trailer(hash_algo, f, hash);
+	write_mtimes_trailer(repo->hash_algo, f, hash);
 
-	if (adjust_shared_perm(the_repository, mtimes_name) < 0)
+	if (adjust_shared_perm(repo, mtimes_name) < 0)
 		die(_("failed to make %s readable"), mtimes_name);
 
 	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
@@ -527,14 +525,15 @@ int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
 	return n;
 }
 
-struct hashfile *create_tmp_packfile(char **pack_tmp_name)
+struct hashfile *create_tmp_packfile(struct repository *repo,
+				     char **pack_tmp_name)
 {
 	struct strbuf tmpname = STRBUF_INIT;
 	int fd;
 
 	fd = odb_mkstemp(&tmpname, "pack/tmp_pack_XXXXXX");
 	*pack_tmp_name = strbuf_detach(&tmpname, NULL);
-	return hashfd(the_repository->hash_algo, fd, *pack_tmp_name);
+	return hashfd(repo->hash_algo, fd, *pack_tmp_name);
 }
 
 static void rename_tmp_packfile(struct strbuf *name_prefix, const char *source,
@@ -555,7 +554,7 @@ void rename_tmp_packfile_idx(struct strbuf *name_buffer,
 	rename_tmp_packfile(name_buffer, *idx_tmp_name, "idx");
 }
 
-void stage_tmp_packfiles(const struct git_hash_algo *hash_algo,
+void stage_tmp_packfiles(struct repository *repo,
 			 struct strbuf *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
@@ -568,19 +567,19 @@ void stage_tmp_packfiles(const struct git_hash_algo *hash_algo,
 	char *rev_tmp_name = NULL;
 	char *mtimes_tmp_name = NULL;
 
-	if (adjust_shared_perm(the_repository, pack_tmp_name))
+	if (adjust_shared_perm(repo, pack_tmp_name))
 		die_errno("unable to make temporary pack file readable");
 
-	*idx_tmp_name = (char *)write_idx_file(hash_algo, NULL, written_list,
+	*idx_tmp_name = (char *)write_idx_file(repo, NULL, written_list,
 					       nr_written, pack_idx_opts, hash);
-	if (adjust_shared_perm(the_repository, *idx_tmp_name))
+	if (adjust_shared_perm(repo, *idx_tmp_name))
 		die_errno("unable to make temporary index file readable");
 
-	rev_tmp_name = write_rev_file(hash_algo, NULL, written_list, nr_written,
+	rev_tmp_name = write_rev_file(repo, NULL, written_list, nr_written,
 				      hash, pack_idx_opts->flags);
 
 	if (pack_idx_opts->flags & WRITE_MTIMES) {
-		mtimes_tmp_name = write_mtimes_file(hash_algo, to_pack,
+		mtimes_tmp_name = write_mtimes_file(repo, to_pack,
 						    written_list, nr_written,
 						    hash);
 	}
diff --git a/pack.h b/pack.h
index 9f1194ac13d..5d4393eaffe 100644
--- a/pack.h
+++ b/pack.h
@@ -87,7 +87,7 @@ struct progress;
 /* Note, the data argument could be NULL if object type is blob */
 typedef int (*verify_fn)(const struct object_id *, enum object_type, unsigned long, void*, int*);
 
-const char *write_idx_file(const struct git_hash_algo *hash_algo,
+const char *write_idx_file(struct repository *repo,
 			   const char *index_name,
 			   struct pack_idx_entry **objects,
 			   int nr_objects,
@@ -106,13 +106,13 @@ struct ref;
 
 void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought);
 
-char *write_rev_file(const struct git_hash_algo *hash_algo,
+char *write_rev_file(struct repository *repo,
 		     const char *rev_name,
 		     struct pack_idx_entry **objects,
 		     uint32_t nr_objects,
 		     const unsigned char *hash,
 		     unsigned flags);
-char *write_rev_file_order(const struct git_hash_algo *hash_algo,
+char *write_rev_file_order(struct repository *repo,
 			   const char *rev_name,
 			   uint32_t *pack_order,
 			   uint32_t nr_objects,
@@ -134,8 +134,9 @@ int read_pack_header(int fd, struct pack_header *);
 
 struct packing_data;
 
-struct hashfile *create_tmp_packfile(char **pack_tmp_name);
-void stage_tmp_packfiles(const struct git_hash_algo *hash_algo,
+struct hashfile *create_tmp_packfile(struct repository *repo,
+				     char **pack_tmp_name);
+void stage_tmp_packfiles(struct repository *repo,
 			 struct strbuf *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,

-- 
2.49.0.rc0.375.gae4b89d849.dirty

