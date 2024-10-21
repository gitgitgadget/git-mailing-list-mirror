Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA371E571E
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504703; cv=none; b=fsWNxxiSATF2cTo5yD6e23rirsLVm5iOZoue+pOoT9wrLLGa80vDfvh/2ElKywbhwvhxCTGHwXvJhSSn6WzCNLqbKYc+tZe/X62CGHeHgP/aup70rihHDapTxSyhXXjmtxR8losJd2igfpOSUkwn5af1YGz59JSAQJycnJlXEWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504703; c=relaxed/simple;
	bh=MdLnNf8d3H0VU+1MdeJV/aZoETZLoPoAp0CRpB3B8a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzdoJnJY03Wk+VyFGIxcU4wxxDQXle9NHe410ZbEvw1aTkY8QLeMViQiu/ofkaJFUnMo94wZUEfh9w267JLvODVwu7QPKAnGOECgwchMfx1ULzQv12ujOn7t/8gvgAbTIihW6kidop3xH4X8rzDqdTU0rJHnQKGyeqD/M2oqHgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRtx9O4j; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRtx9O4j"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so9036965a12.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 02:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504699; x=1730109499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfDcN9DIPN8ZxKshBiYdfhJgX0RPtSzhdXjy9KGp/zU=;
        b=GRtx9O4jA0z3XqE28JcZa0OZhl1VZXm54uacI76M4Bvx5RUKxlixUrkCUn8ztXGZTs
         G6/FDEycbj+RTB/M44pzyXb6Etbf1S89yOlJVJVFKzvMxsJ9jgszocrBnBXMR8XWMW1g
         gKkyfRpbfABbCTTvYOKPlxp2t2HGtLK9eBeTOfbeq0ChFrnFUsc8QhAJg3C+bgwWdvZ3
         W/6FMS5xyQstnqWkk4f08EcAWZRXc7N1Dg2dqzp6kHlDDer1rO2dDhKe1o/4pMKTS0g+
         6AH63VWlQphyYlKt8OzXLJW3uPk+/dQv8GKE/bU2+ygtZpgXdMDmnuNdJsI2GAL+kakY
         wJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504699; x=1730109499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfDcN9DIPN8ZxKshBiYdfhJgX0RPtSzhdXjy9KGp/zU=;
        b=c0UsX3MW967Lo4SVuRmJGBBlTR0Y/Lcp+LFYXDMJlQmXzWlgumvzNTcfEXRW4v7dMG
         NtKm16dOyET1z+OlFcjG26kdW25sButw4PrD9BCo4s9eCXI3ngYTA0jGLjMFlUplEEWs
         kvXt7xB6yDQzJWtGe+n361vWhpaPeU8ridp7nwHS4jN9js6t9sDT32trifYbfeGjelrU
         K63a1Tk+6Eyk5bLACFNYfIOfWCOx8lZ6sIP+v9O5QLcjAxIwNVMtEnIgudX9IngPPhVD
         OuvHX2UsuOXWGhdJWm04+DC2CAYm/sDr3O8LVAZ2qRsQFhGBUFdbD4xrjUX4Mcue24Gh
         xosA==
X-Gm-Message-State: AOJu0YxNRNvQYMAJiP15QsIPnmIFQpJy3SH1kN1m6pPGgX4il/J0nsjv
	f6lDh4Ao7doPayZEX5IKdWTTyiOZGdy1agT/DlFnGXdf/qM/b/dZvUwvqwUT
X-Google-Smtp-Source: AGHT+IHDk/lmAm7aArqFYSfEFKkDcKHNcP5+EVV4d/ax6MU8NJeC3Fe9Pr5nw2VJ1TzVkA0JmCvSYw==
X-Received: by 2002:a17:907:1c87:b0:a99:f37c:f824 with SMTP id a640c23a62f3a-a9a4cc58c3dmr1452826566b.31.1729504698722;
        Mon, 21 Oct 2024 02:58:18 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d631dsm187122266b.17.2024.10.21.02.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:58:18 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 16/20] packfile: pass down repository to `open_pack_index`
Date: Mon, 21 Oct 2024 11:57:59 +0200
Message-ID: <37cbd46efdc14203366a9017dcafc90cf3a938de.1729504641.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729504640.git.karthik.188@gmail.com>
References: <cover.1729504640.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function `open_pack_index` currently relies on the global variable
`the_repository`. To eliminate global variable usage in `packfile.c`, we
should progressively shift the dependency on the_repository to higher
layers. Let's remove its usage from this function and any related ones.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/count-objects.c     |  2 +-
 builtin/fsck.c              |  2 +-
 builtin/index-pack.c        |  2 +-
 builtin/pack-objects.c      |  6 +++---
 builtin/pack-redundant.c    |  2 +-
 builtin/repack.c            |  2 +-
 commit-graph.c              |  2 +-
 midx-write.c                | 10 +++++-----
 midx.c                      |  2 +-
 object-name.c               |  4 ++--
 pack-check.c                |  2 +-
 pack-mtimes.c               |  4 ++--
 pack-mtimes.h               |  3 ++-
 pack-revindex.c             |  4 ++--
 packfile.c                  | 26 ++++++++++++++------------
 packfile.h                  |  5 +++--
 reachable.c                 |  2 +-
 t/helper/test-pack-mtimes.c |  2 +-
 18 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 1e89148ed7..b122b51fe1 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -131,7 +131,7 @@ int cmd_count_objects(int argc,
 		for (p = get_all_packs(the_repository); p; p = p->next) {
 			if (!p->pack_local)
 				continue;
-			if (open_pack_index(p))
+			if (open_pack_index(the_repository, p))
 				continue;
 			packed += p->num_objects;
 			size_pack += p->pack_size + p->index_size;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 0e4b7ec3af..86006e5bbc 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -988,7 +988,7 @@ int cmd_fsck(int argc,
 			if (show_progress) {
 				for (p = get_all_packs(the_repository); p;
 				     p = p->next) {
-					if (open_pack_index(p))
+					if (open_pack_index(the_repository, p))
 						continue;
 					total += p->num_objects;
 				}
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index eaefb41761..1898dc37a6 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1656,7 +1656,7 @@ static void read_idx_option(struct pack_idx_option *opts, const char *pack_name)
 
 	if (!p)
 		die(_("Cannot open existing pack file '%s'"), pack_name);
-	if (open_pack_index(p))
+	if (open_pack_index(the_repository, p))
 		die(_("Cannot open existing pack idx file for '%s'"), pack_name);
 
 	/* Read the attributes from the existing idx file */
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index bfe0197d12..ffbd48c60c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3902,7 +3902,7 @@ static void show_edge(struct commit *commit)
 	add_preferred_base(&commit->object.oid);
 }
 
-static int add_object_in_unpacked_pack(struct repository *repo UNUSED,
+static int add_object_in_unpacked_pack(struct repository *repo,
 				       const struct object_id *oid,
 				       struct packed_git *pack,
 				       uint32_t pos,
@@ -3913,7 +3913,7 @@ static int add_object_in_unpacked_pack(struct repository *repo UNUSED,
 		time_t mtime;
 
 		if (pack->is_cruft) {
-			if (load_pack_mtimes(pack) < 0)
+			if (load_pack_mtimes(repo, pack) < 0)
 				die(_("could not load cruft pack .mtimes"));
 			mtime = nth_packed_mtime(pack, pos);
 		} else {
@@ -4035,7 +4035,7 @@ static void loosen_unused_packed_objects(void)
 		if (!p->pack_local || p->pack_keep || p->pack_keep_in_core)
 			continue;
 
-		if (open_pack_index(p))
+		if (open_pack_index(the_repository, p))
 			die(_("cannot open pack index"));
 
 		for (i = 0; i < p->num_objects; i++) {
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 60f806e672..bc3c3e9c4e 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -545,7 +545,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 	l.pack = p;
 	llist_init(&l.remaining_objects);
 
-	if (open_pack_index(p))
+	if (open_pack_index(the_repository, p))
 		return NULL;
 
 	base = p->index_data;
diff --git a/builtin/repack.c b/builtin/repack.c
index de03a3ecfc..5f317ba224 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -461,7 +461,7 @@ struct pack_geometry {
 
 static uint32_t geometry_pack_weight(struct packed_git *p)
 {
-	if (open_pack_index(p))
+	if (open_pack_index(the_repository, p))
 		die(_("cannot open index for %s"), p->pack_name);
 	return p->num_objects;
 }
diff --git a/commit-graph.c b/commit-graph.c
index 96d55f8885..35e4e9d99d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1920,7 +1920,7 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 			ret = error(_("error adding pack %s"), packname.buf);
 			goto cleanup;
 		}
-		if (open_pack_index(p)) {
+		if (open_pack_index(the_repository, p)) {
 			ret = error(_("error opening index for %s"), packname.buf);
 			goto cleanup;
 		}
diff --git a/midx-write.c b/midx-write.c
index 4696b8326c..2b7c50d25c 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -161,7 +161,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 			return;
 		}
 
-		if (open_pack_index(p)) {
+		if (open_pack_index(the_repository, p)) {
 			warning(_("failed to open pack-index '%s'"),
 				full_path);
 			close_pack(p);
@@ -301,8 +301,8 @@ static void midx_fanout_add_pack_fanout(struct midx_fanout *fanout,
 	uint32_t cur_object;
 
 	if (cur_fanout)
-		start = get_pack_fanout(pack, cur_fanout - 1);
-	end = get_pack_fanout(pack, cur_fanout);
+		start = get_pack_fanout(the_repository, pack, cur_fanout - 1);
+	end = get_pack_fanout(the_repository, pack, cur_fanout);
 
 	for (cur_object = start; cur_object < end; cur_object++) {
 		midx_fanout_grow(fanout, fanout->nr + 1);
@@ -950,7 +950,7 @@ static int fill_packs_from_midx(struct write_midx_context *ctx,
 					return 1;
 				}
 
-				if (open_pack_index(m->packs[i]))
+				if (open_pack_index(the_repository, m->packs[i]))
 					die(_("could not open index for %s"),
 					    m->packs[i]->pack_name);
 			}
@@ -1612,7 +1612,7 @@ static int want_included_pack(struct repository *r,
 		return 0;
 	if (p->is_cruft)
 		return 0;
-	if (open_pack_index(p) || !p->num_objects)
+	if (open_pack_index(r, p) || !p->num_objects)
 		return 0;
 	return 1;
 }
diff --git a/midx.c b/midx.c
index c76df95d6d..edbd2008e3 100644
--- a/midx.c
+++ b/midx.c
@@ -966,7 +966,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 			continue;
 		}
 
-		if (open_pack_index(e.p)) {
+		if (open_pack_index(the_repository, e.p)) {
 			midx_report(_("failed to load pack-index for packfile %s"),
 				    e.p->pack_name);
 			break;
diff --git a/object-name.c b/object-name.c
index 43023884ef..368242133a 100644
--- a/object-name.c
+++ b/object-name.c
@@ -175,7 +175,7 @@ static void unique_in_pack(struct packed_git *p,
 	if (p->multi_pack_index)
 		return;
 
-	if (open_pack_index(p) || !p->num_objects)
+	if (open_pack_index(ds->repo, p) || !p->num_objects)
 		return;
 
 	num = p->num_objects;
@@ -761,7 +761,7 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
 	if (p->multi_pack_index)
 		return;
 
-	if (open_pack_index(p) || !p->num_objects)
+	if (open_pack_index(mad->repo, p) || !p->num_objects)
 		return;
 
 	num = p->num_objects;
diff --git a/pack-check.c b/pack-check.c
index a5551809c1..d93cf3f224 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -176,7 +176,7 @@ int verify_pack_index(struct packed_git *p)
 {
 	int err = 0;
 
-	if (open_pack_index(p))
+	if (open_pack_index(the_repository, p))
 		return error("packfile %s index not opened", p->pack_name);
 
 	/* Verify SHA1 sum of the index file */
diff --git a/pack-mtimes.c b/pack-mtimes.c
index cdf30b8d2b..a9fa8d55de 100644
--- a/pack-mtimes.c
+++ b/pack-mtimes.c
@@ -97,7 +97,7 @@ static int load_pack_mtimes_file(char *mtimes_file,
 	return ret;
 }
 
-int load_pack_mtimes(struct packed_git *p)
+int load_pack_mtimes(struct repository *repo, struct packed_git *p)
 {
 	char *mtimes_name = NULL;
 	int ret = 0;
@@ -107,7 +107,7 @@ int load_pack_mtimes(struct packed_git *p)
 	if (p->mtimes_map)
 		return ret; /* already loaded */
 
-	ret = open_pack_index(p);
+	ret = open_pack_index(repo, p);
 	if (ret < 0)
 		goto cleanup;
 
diff --git a/pack-mtimes.h b/pack-mtimes.h
index 107327cec0..22ab6a8481 100644
--- a/pack-mtimes.h
+++ b/pack-mtimes.h
@@ -5,12 +5,13 @@
 #define MTIMES_VERSION 1
 
 struct packed_git;
+struct repository;
 
 /*
  * Loads the .mtimes file corresponding to "p", if any, returning zero
  * on success.
  */
-int load_pack_mtimes(struct packed_git *p);
+int load_pack_mtimes(struct repository *repo, struct packed_git *p);
 
 /* Returns the mtime associated with the object at position "pos" (in
  * lexicographic/index order) in pack "p".
diff --git a/pack-revindex.c b/pack-revindex.c
index 22d3c23464..c14ef971da 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -178,7 +178,7 @@ static int create_pack_revindex_in_memory(struct packed_git *p)
 	if (git_env_bool(GIT_TEST_REV_INDEX_DIE_IN_MEMORY, 0))
 		die("dying as requested by '%s'",
 		    GIT_TEST_REV_INDEX_DIE_IN_MEMORY);
-	if (open_pack_index(p))
+	if (open_pack_index(the_repository, p))
 		return -1;
 	create_pack_revindex(p);
 	return 0;
@@ -274,7 +274,7 @@ int load_pack_revindex_from_disk(struct packed_git *p)
 {
 	char *revindex_name;
 	int ret;
-	if (open_pack_index(p))
+	if (open_pack_index(the_repository, p))
 		return -1;
 
 	revindex_name = pack_revindex_filename(p);
diff --git a/packfile.c b/packfile.c
index 831d2c2c74..b0147231cb 100644
--- a/packfile.c
+++ b/packfile.c
@@ -84,13 +84,14 @@ void pack_report(void)
  * consistency checks, then record its information to p.  Return 0 on
  * success.
  */
-static int check_packed_git_idx(const char *path, struct packed_git *p)
+static int check_packed_git_idx(struct repository *repo, const char *path,
+				struct packed_git *p)
 {
 	void *idx_map;
 	size_t idx_size;
 	int fd = git_open(path), ret;
 	struct stat st;
-	const unsigned int hashsz = the_hash_algo->rawsz;
+	const unsigned int hashsz = repo->hash_algo->rawsz;
 
 	if (fd < 0)
 		return -1;
@@ -194,7 +195,7 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 	return 0;
 }
 
-int open_pack_index(struct packed_git *p)
+int open_pack_index(struct repository *repo, struct packed_git *p)
 {
 	char *idx_name;
 	size_t len;
@@ -206,17 +207,18 @@ int open_pack_index(struct packed_git *p)
 	if (!strip_suffix(p->pack_name, ".pack", &len))
 		BUG("pack_name does not end in .pack");
 	idx_name = xstrfmt("%.*s.idx", (int)len, p->pack_name);
-	ret = check_packed_git_idx(idx_name, p);
+	ret = check_packed_git_idx(repo, idx_name, p);
 	free(idx_name);
 	return ret;
 }
 
-uint32_t get_pack_fanout(struct packed_git *p, uint32_t value)
+uint32_t get_pack_fanout(struct repository *repo, struct packed_git *p,
+			 uint32_t value)
 {
 	const uint32_t *level1_ofs = p->index_data;
 
 	if (!level1_ofs) {
-		if (open_pack_index(p))
+		if (open_pack_index(repo, p))
 			return 0;
 		level1_ofs = p->index_data;
 	}
@@ -246,7 +248,7 @@ struct packed_git *parse_pack_index(struct repository *repo,
 
 	memcpy(p->pack_name, path, alloc); /* includes NUL */
 	hashcpy(p->hash, sha1, repo->hash_algo);
-	if (check_packed_git_idx(idx_path, p)) {
+	if (check_packed_git_idx(repo, idx_path, p)) {
 		free(p);
 		return NULL;
 	}
@@ -544,7 +546,7 @@ static int open_packed_git_1(struct repository *repo, struct packed_git *p)
 	ssize_t read_result;
 	const unsigned hashsz = the_hash_algo->rawsz;
 
-	if (open_pack_index(p))
+	if (open_pack_index(repo, p))
 		return error("packfile %s index unavailable", p->pack_name);
 
 	if (!pack_max_fds) {
@@ -951,7 +953,7 @@ unsigned long repo_approximate_object_count(struct repository *r)
 		for (m = get_multi_pack_index(r); m; m = m->next)
 			count += m->num_objects;
 		for (p = r->objects->packed_git; p; p = p->next) {
-			if (open_pack_index(p))
+			if (open_pack_index(r, p))
 				continue;
 			count += p->num_objects;
 		}
@@ -1923,7 +1925,7 @@ int nth_packed_object_id(struct repository *repo, struct object_id *oid,
 	const unsigned char *index = p->index_data;
 	const unsigned int hashsz = repo->hash_algo->rawsz;
 	if (!index) {
-		if (open_pack_index(p))
+		if (open_pack_index(repo, p))
 			return -1;
 		index = p->index_data;
 	}
@@ -1983,7 +1985,7 @@ off_t find_pack_entry_one(struct repository *repo, const unsigned char *sha1,
 	uint32_t result;
 
 	if (!index) {
-		if (open_pack_index(p))
+		if (open_pack_index(repo, p))
 			return 0;
 	}
 
@@ -2226,7 +2228,7 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 		if ((flags & FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
 		    p->pack_keep)
 			continue;
-		if (open_pack_index(p)) {
+		if (open_pack_index(repo, p)) {
 			pack_errors = 1;
 			continue;
 		}
diff --git a/packfile.h b/packfile.h
index afec4bbd74..98ec3616b4 100644
--- a/packfile.h
+++ b/packfile.h
@@ -97,7 +97,7 @@ void pack_report(void);
  * mmap the index file for the specified packfile (if it is not
  * already mmapped).  Return 0 on success.
  */
-int open_pack_index(struct packed_git *);
+int open_pack_index(struct repository *repo, struct packed_git *);
 
 /*
  * munmap the index file for the specified packfile (if it is
@@ -107,7 +107,8 @@ void close_pack_index(struct packed_git *);
 
 int close_pack_fd(struct packed_git *p);
 
-uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
+uint32_t get_pack_fanout(struct repository *repo, struct packed_git *p,
+			 uint32_t value);
 
 struct raw_object_store;
 
diff --git a/reachable.c b/reachable.c
index f8dc2731d6..833013e7a3 100644
--- a/reachable.c
+++ b/reachable.c
@@ -291,7 +291,7 @@ static int add_recent_packed(struct repository *repo,
 	if (obj && obj->flags & SEEN)
 		return 0;
 	if (p->is_cruft) {
-		if (load_pack_mtimes(p) < 0)
+		if (load_pack_mtimes(repo, p) < 0)
 			die(_("could not load cruft pack .mtimes"));
 		mtime = nth_packed_mtime(p, pos);
 	}
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
index ebd980b308..b1caeba097 100644
--- a/t/helper/test-pack-mtimes.c
+++ b/t/helper/test-pack-mtimes.c
@@ -11,7 +11,7 @@
 static void dump_mtimes(struct packed_git *p)
 {
 	uint32_t i;
-	if (load_pack_mtimes(p) < 0)
+	if (load_pack_mtimes(the_repository, p) < 0)
 		die("could not load pack .mtimes");
 
 	for (i = 0; i < p->num_objects; i++) {
-- 
2.47.0

