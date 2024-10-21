Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFE71E47AD
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504693; cv=none; b=p1n5PLG0882fkIRkHmFMMqzYlarxb2pzGXTFWiia8jxWPc9XIirC00qeeTMB4+I/q+ak6IRX6RFPkeXx/Zlvp6ijRCfN7YSJe9+2LvEEdqsmfyx2uiXfpuLKG6BTgXTtZkwOW+sBLYYMDp4vlugKdA9Q4+W62wM5msBMAqkgkvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504693; c=relaxed/simple;
	bh=EnjNR1tosf08JiZbLg80/9eTtM6vYqHcN6uV8BNbIyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgrYPDS4cVZaLadCG4tBqE6Wcx2pNPotic+QyoPM9JTkzDLTOTWBCl3tO0sOXxjCuqjuhyQEKnKlNCWZreRpjY/1t2F3xpi/Xa9WkEBlJUS4WeO5qvB2h8BvTCGS3MFFpTnSIq+KTcMx7dth+oiiJFFtFA1V0XokO6/SdbSUS7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2q7K/T8; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2q7K/T8"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cb6b2b7127so1102947a12.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 02:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504689; x=1730109489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYA+vHFljuEdY7y55LgPB5czkdkxY4NEHWpgPQVq/KI=;
        b=i2q7K/T8u+dLztNdNADQXPVWmI2hEwZ0BnLWaxsZrSV6fg1sUpvEjLdkYnLDODPjy2
         k2psoeZfXuta1/rAMapPPHVSXW/GQWvfldFZntD4WFozDOCn33cG+k40Mhw1Uh8zmXCD
         4ddt+ZJpdrAeQt/U8KvM6FTTkkbxaVx545EmRUM5WiLkOdEFmJec0ClNMTyP3w9Fz4Yp
         CERc2cUissUZgh1CKf+fnQsufA+NN/etmFTxb9v47yDFsr3taQWwS6/MKlTohpf1oVcm
         1S82bJvfQW7rceIcDG2n6baAST+cG//PISd+OmCJYmogNJaOfbRFl/xjnt42iDLd/S5k
         b8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504689; x=1730109489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYA+vHFljuEdY7y55LgPB5czkdkxY4NEHWpgPQVq/KI=;
        b=koAmg1lkQTIYPMBdE0XviAyUigLXmUnvojqvkeZlGoBTk8zpMTpZ4AA1SNiQB5lG/D
         bRDRM+e5kUoIwVaBS4OO/w3iAb9ffI+Tav2N4nqAJr8G7cWFGFtK0QSBW7N8yuMfn8c7
         jiYykRMYkuS4aujRfH7nv3zDjV8f0DxWCH/Z8EStH3oY88HcMHYZM3x+9+69d/Auroq2
         01tTWv52JF08dGt/v0+ZadJ5eHIrUrst8QA5P6STLnm5tD7KM9jMxQKNsLQtaZXWdIoH
         h6eECNcmttyUNguhSMYl9Aij+SI8zc99CqVtpRCEqHx4sMNpa6V5ehZJE82A5OnVW2QR
         TQtA==
X-Gm-Message-State: AOJu0YwzaY1I10rojPq/TGWhMh5e49xm342SGRldHwvjk5XRf/4btjzB
	tH+RpTQfThZeDKbS+lr+pJp6oF/D0zqrqav8qSpk/pFDuj0bm5F5GiQXM+cF
X-Google-Smtp-Source: AGHT+IGUnrTTOk/pr509WGf2jMglKrfoSxj28/yU4x4zOCj6ZKC/h+mdbah89Tx7yo4qJwSApNlIsg==
X-Received: by 2002:a17:907:7ea3:b0:a9a:14fc:9868 with SMTP id a640c23a62f3a-a9a6996a599mr1351817966b.4.1729504689211;
        Mon, 21 Oct 2024 02:58:09 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d631dsm187122266b.17.2024.10.21.02.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:58:08 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 04/20] packfile: pass down repository to `add_packed_git`
Date: Mon, 21 Oct 2024 11:57:47 +0200
Message-ID: <d7d5d236921ac6da281620ed22e5fef307175473.1729504641.git.karthik.188@gmail.com>
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

The function `add_packed_git` currently relies on the global variable
`the_repository`. To eliminate global variable usage in `packfile.c`, we
should progressively shift the dependency on the_repository to higher
layers. Let's remove its usage from this function and any related ones.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fast-import.c  |  2 +-
 builtin/index-pack.c   |  6 ++++--
 builtin/pack-objects.c |  2 +-
 commit-graph.c         |  2 +-
 connected.c            |  2 +-
 midx-write.c           |  2 +-
 midx.c                 |  2 +-
 packfile.c             | 21 +++++++++++----------
 packfile.h             |  6 ++++--
 9 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 7ad950627c..51d1cc0deb 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -888,7 +888,7 @@ static void end_packfile(void)
 		idx_name = keep_pack(create_index());
 
 		/* Register the packfile with core git's machinery. */
-		new_p = add_packed_git(idx_name, strlen(idx_name), 1);
+		new_p = add_packed_git(the_repository, idx_name, strlen(idx_name), 1);
 		if (!new_p)
 			die("core git rejected index %s", idx_name);
 		all_packs[pack_id] = new_p;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 97afc69625..eaefb41761 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1552,7 +1552,8 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 
 	if (do_fsck_object) {
 		struct packed_git *p;
-		p = add_packed_git(final_index_name, strlen(final_index_name), 0);
+		p = add_packed_git(the_repository, final_index_name,
+				   strlen(final_index_name), 0);
 		if (p)
 			install_packed_git(the_repository, p);
 	}
@@ -1650,7 +1651,8 @@ static void read_v2_anomalous_offsets(struct packed_git *p,
 
 static void read_idx_option(struct pack_idx_option *opts, const char *pack_name)
 {
-	struct packed_git *p = add_packed_git(pack_name, strlen(pack_name), 1);
+	struct packed_git *p = add_packed_git(the_repository, pack_name,
+					      strlen(pack_name), 1);
 
 	if (!p)
 		die(_("Cannot open existing pack file '%s'"), pack_name);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ec321da8dc..26e3090c85 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2174,7 +2174,7 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 			 * object size from the delta header.
 			 */
 			delta_pos = entry->in_pack_offset + entry->in_pack_header_size;
-			canonical_size = get_size_from_delta(p, &w_curs, delta_pos);
+			canonical_size = get_size_from_delta(the_repository, p, &w_curs, delta_pos);
 			if (canonical_size == 0)
 				goto give_up;
 			SET_SIZE(entry, canonical_size);
diff --git a/commit-graph.c b/commit-graph.c
index 5bd89c0acd..1c333a9c52 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1914,7 +1914,7 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 		struct packed_git *p;
 		strbuf_setlen(&packname, dirlen);
 		strbuf_addstr(&packname, pack_indexes->items[i].string);
-		p = add_packed_git(packname.buf, packname.len, 1);
+		p = add_packed_git(the_repository, packname.buf, packname.len, 1);
 		if (!p) {
 			ret = error(_("error adding pack %s"), packname.buf);
 			goto cleanup;
diff --git a/connected.c b/connected.c
index 87cc4b57a1..235890efd0 100644
--- a/connected.c
+++ b/connected.c
@@ -54,7 +54,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		strbuf_add(&idx_file, transport->pack_lockfiles.items[0].string,
 			   base_len);
 		strbuf_addstr(&idx_file, ".idx");
-		new_pack = add_packed_git(idx_file.buf, idx_file.len, 1);
+		new_pack = add_packed_git(the_repository, idx_file.buf, idx_file.len, 1);
 		strbuf_release(&idx_file);
 	}
 
diff --git a/midx-write.c b/midx-write.c
index b3a5f6c516..c57726ef94 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -154,7 +154,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 			return;
 
 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
-		p = add_packed_git(full_path, full_path_len, 0);
+		p = add_packed_git(the_repository, full_path, full_path_len, 0);
 		if (!p) {
 			warning(_("failed to add packfile '%s'"),
 				full_path);
diff --git a/midx.c b/midx.c
index 4a05f74606..94609456a2 100644
--- a/midx.c
+++ b/midx.c
@@ -455,7 +455,7 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 	strbuf_addf(&pack_name, "%s/pack/%s", m->object_dir,
 		    m->pack_names[pack_int_id]);
 
-	p = add_packed_git(pack_name.buf, pack_name.len, m->local);
+	p = add_packed_git(r, pack_name.buf, pack_name.len, m->local);
 	strbuf_release(&pack_name);
 
 	if (!p)
diff --git a/packfile.c b/packfile.c
index 4588004223..f300119bb1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -706,7 +706,8 @@ void unuse_pack(struct pack_window **w_cursor)
 	}
 }
 
-struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
+struct packed_git *add_packed_git(struct repository *repo, const char *path,
+				  size_t path_len, int local)
 {
 	struct stat st;
 	size_t alloc;
@@ -751,9 +752,9 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 	p->pack_size = st.st_size;
 	p->pack_local = local;
 	p->mtime = st.st_mtime;
-	if (path_len < the_hash_algo->hexsz ||
-	    get_hash_hex(path + path_len - the_hash_algo->hexsz, p->hash))
-		hashclr(p->hash, the_repository->hash_algo);
+	if (path_len < repo->hash_algo->hexsz ||
+	    get_hash_hex(path + path_len - repo->hash_algo->hexsz, p->hash))
+		hashclr(p->hash, repo->hash_algo);
 	return p;
 }
 
@@ -880,7 +881,8 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 
 		/* Don't reopen a pack we already have. */
 		if (!hashmap_get(&data->r->objects->pack_map, &hent, pack_name)) {
-			p = add_packed_git(full_name, full_name_len, data->local);
+			p = add_packed_git(data->r, full_name, full_name_len,
+					   data->local);
 			if (p)
 				install_packed_git(data->r, p);
 		}
@@ -1113,9 +1115,8 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 	return used;
 }
 
-unsigned long get_size_from_delta(struct packed_git *p,
-				  struct pack_window **w_curs,
-				  off_t curpos)
+unsigned long get_size_from_delta(struct repository *repo, struct packed_git *p,
+				  struct pack_window **w_curs, off_t curpos)
 {
 	const unsigned char *data;
 	unsigned char delta_head[20], *in;
@@ -1128,7 +1129,7 @@ unsigned long get_size_from_delta(struct packed_git *p,
 
 	git_inflate_init(&stream);
 	do {
-		in = use_pack(the_repository, p, w_curs, curpos, &stream.avail_in);
+		in = use_pack(repo, p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
 		/*
 		 * Note: the window section returned by use_pack() must be
@@ -1559,7 +1560,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 				type = OBJ_BAD;
 				goto out;
 			}
-			*oi->sizep = get_size_from_delta(p, &w_curs, tmp_pos);
+			*oi->sizep = get_size_from_delta(r, p, &w_curs, tmp_pos);
 			if (*oi->sizep == 0) {
 				type = OBJ_BAD;
 				goto out;
diff --git a/packfile.h b/packfile.h
index b74d649c23..22d053a3af 100644
--- a/packfile.h
+++ b/packfile.h
@@ -117,7 +117,8 @@ void close_pack(struct packed_git *);
 void close_object_store(struct raw_object_store *o);
 void unuse_pack(struct pack_window **);
 void clear_delta_base_cache(void);
-struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
+struct packed_git *add_packed_git(struct repository *repo, const char *path,
+				  size_t path_len, int local);
 
 /*
  * Unlink the .pack and associated extension files.
@@ -166,7 +167,8 @@ off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
 int is_pack_valid(struct repository *repo, struct packed_git *);
 void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object_type *, unsigned long *);
 unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
-unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
+unsigned long get_size_from_delta(struct repository *repo, struct packed_git *,
+				  struct pack_window **, off_t);
 int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
 off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
 		     off_t *curpos, enum object_type type,
-- 
2.47.0

