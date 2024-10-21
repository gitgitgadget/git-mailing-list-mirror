Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FC81E5737
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504698; cv=none; b=S+ZhHKs8t6Sj2ybKd1tavIz5hdP94kzjKE/44jOtcdq9/1HuKW9XPfnaRfXxxaWh0oJYYkPk3wu0Z0Vu3z8sZm16++t+4OrzNY//PDFGElBZ3TDuAFkWVW7EokONOUn0x9l5dKxFydqkd/x3lkahkAiMQ6taegUO4K9JVnaPsN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504698; c=relaxed/simple;
	bh=Bs0+qo+KoS4vWqvR13l8NYDd7KZrGwVeOUrElY/iXiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9rAgavHTYfYtW+vqPNPmz76Dxe+XQLoGh/nBffEQbt4/gt5Ph/a0VJ5PbK6U8rqUbFUHRnz7BJxdSYHLsPYfIazVUEFzJVdjurGAl94+sV1sWvhEaFZmmgl8nGm7qNqJNORH34pAbHZblMRUmeS9KGx/LV6Hyhg+lyrC/oKqhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuYr8l0l; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuYr8l0l"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99ebb390a5so980340166b.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 02:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504695; x=1730109495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMKFW4Slqtz/NTS5T7IDn73l4pmvI7vfqICtqFz1xbw=;
        b=CuYr8l0l1nIwmdIeBDzN9lwtyfqoW7HR8j82kjJjEhRRhRy2ipf4CyXua9xK+CQBqC
         XlZ+/VM4/TkX4zqBHeo6OefRnVOkoc4pQfuwL/EMNe0y2vBVvrmxAuqoJjaV+hsE6iCV
         WlfgcHjs0tAAyCpN7ve1/M2aJNI9ufjwkjHsWOlquuuYYYqLEcRcWadpiR/OWrVO/Tal
         zsxD5B/5KoTY71SDRO2VQtkJoX7IqOfp+ZHuWV/Ws0u4gret2/DZ/ZTV6o8+I679uGXS
         FRcLQdjz/PjBxaeDkIBpoC1nGw1QrSDdrjf3eq7fyvhkVzdGsCc8DblG9cKqjEe4Dr9B
         ZX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504695; x=1730109495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMKFW4Slqtz/NTS5T7IDn73l4pmvI7vfqICtqFz1xbw=;
        b=sYesBvOSTAinjX/5H9fEdf0hWrwkgdMw1hcPbO/xDfvGVYpCmhXrwPhIJf/QvCytoo
         UjyvafD5h8F0uKHi+DIzlAi/Z9MJJOeKuQo+gXasp/jEPI8Mm9tXlLSMlfyzdyTHdGFo
         zyrCp/m7wKeRgzZyKspQTorco5ys9gRffZaHJAsT7xday6GAb+frbyhcVDyYUEDJW3Gg
         vBOrbK8a3wA0pOxyzXNXIpYgDG2oEmyju1P43wDOjwAwmwhzRjZpMbZLd44X4MVrEnY2
         bO33EhdFUa4rUr84tAFBycilDnj0XB9MCUc/nV94KAJaagcBIwYUh7/kGqImESuRL+dU
         hSPw==
X-Gm-Message-State: AOJu0YzvXgxmny+fNiVgBq0744i+whAGDF4QQAYGB/JRZI3hA81i159m
	8xLdqLx7dglS1wZ1Zu8U6C4gc7GH4nanrlfbnCqyFCNFw6KmVa9sNhRhTQB8
X-Google-Smtp-Source: AGHT+IER7OfEUr6HZLcKbKTWgko37VuaxTxXK88Y1wT5KLHx68hkXLFY9aVpauksAlr2XV3Ht6TxIA==
X-Received: by 2002:a17:907:6ea9:b0:a99:f777:c6ef with SMTP id a640c23a62f3a-a9a6a3eb453mr1166810866b.3.1729504694325;
        Mon, 21 Oct 2024 02:58:14 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d631dsm187122266b.17.2024.10.21.02.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:58:13 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 10/20] packfile: pass down repository to `find_pack_entry_one`
Date: Mon, 21 Oct 2024 11:57:53 +0200
Message-ID: <7d580c72ce97a822bacb082fa05b1e7e41bfc011.1729504641.git.karthik.188@gmail.com>
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

The function `find_pack_entry_one` currently relies on the global
variable `the_repository`. To eliminate global variable usage in
`packfile.c`, we should progressively shift the dependency on
the_repository to higher layers. Let's remove its usage from this
function and any related ones.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fast-import.c     |  4 ++--
 builtin/pack-objects.c    |  4 ++--
 connected.c               |  5 +++--
 http-push.c               |  5 +++--
 http-walker.c             |  2 +-
 midx.c                    |  2 +-
 pack-bitmap.c             |  6 ++++--
 packfile.c                | 15 ++++++++-------
 packfile.h                |  6 ++++--
 t/helper/test-find-pack.c |  2 +-
 10 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 51d1cc0deb..a6743db85c 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -966,7 +966,7 @@ static int store_object(
 	if (e->idx.offset) {
 		duplicate_count_by_type[type]++;
 		return 1;
-	} else if (find_sha1_pack(oid.hash,
+	} else if (find_sha1_pack(the_repository, oid.hash,
 				  get_all_packs(the_repository))) {
 		e->type = type;
 		e->pack_id = MAX_PACK_ID;
@@ -1167,7 +1167,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		duplicate_count_by_type[OBJ_BLOB]++;
 		truncate_pack(&checkpoint);
 
-	} else if (find_sha1_pack(oid.hash,
+	} else if (find_sha1_pack(the_repository, oid.hash,
 				  get_all_packs(the_repository))) {
 		e->type = OBJ_BLOB;
 		e->pack_id = MAX_PACK_ID;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index adf55d892f..d41259a423 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1558,7 +1558,7 @@ static int want_object_in_pack_one(struct packed_git *p,
 	if (p == *found_pack)
 		offset = *found_offset;
 	else
-		offset = find_pack_entry_one(oid->hash, p);
+		offset = find_pack_entry_one(the_repository, oid->hash, p);
 
 	if (offset) {
 		if (!*found_pack) {
@@ -3986,7 +3986,7 @@ static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
 	while (p) {
 		if ((!p->pack_local || p->pack_keep ||
 				p->pack_keep_in_core) &&
-			find_pack_entry_one(oid->hash, p)) {
+			find_pack_entry_one(the_repository, oid->hash, p)) {
 			last_found = p;
 			return 1;
 		}
diff --git a/connected.c b/connected.c
index 235890efd0..00b7de34c6 100644
--- a/connected.c
+++ b/connected.c
@@ -78,7 +78,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 			for (p = get_all_packs(the_repository); p; p = p->next) {
 				if (!p->pack_promisor)
 					continue;
-				if (find_pack_entry_one(oid->hash, p))
+				if (find_pack_entry_one(the_repository, oid->hash, p))
 					goto promisor_pack_found;
 			}
 			/*
@@ -144,7 +144,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		 * are sure the ref is good and not sending it to
 		 * rev-list for verification.
 		 */
-		if (new_pack && find_pack_entry_one(oid->hash, new_pack))
+		if (new_pack && find_pack_entry_one(the_repository, oid->hash,
+						    new_pack))
 			continue;
 
 		if (fprintf(rev_list_in, "%s\n", oid_to_hex(oid)) < 0)
diff --git a/http-push.c b/http-push.c
index aad89f2eab..cb6cf1696e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -309,7 +309,8 @@ static void start_fetch_packed(struct transfer_request *request)
 	struct transfer_request *check_request = request_queue_head;
 	struct http_pack_request *preq;
 
-	target = find_sha1_pack(request->obj->oid.hash, repo->packs);
+	target = find_sha1_pack(the_repository, request->obj->oid.hash,
+				repo->packs);
 	if (!target) {
 		fprintf(stderr, "Unable to fetch %s, will not be able to update server info refs\n", oid_to_hex(&request->obj->oid));
 		repo->can_update_info_refs = 0;
@@ -681,7 +682,7 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
 		get_remote_object_list(obj->oid.hash[0]);
 	if (obj->flags & (REMOTE | PUSHING))
 		return 0;
-	target = find_sha1_pack(obj->oid.hash, repo->packs);
+	target = find_sha1_pack(the_repository, obj->oid.hash, repo->packs);
 	if (target) {
 		obj->flags |= REMOTE;
 		return 0;
diff --git a/http-walker.c b/http-walker.c
index fb2d86d5e7..0a11ed6ecf 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -431,7 +431,7 @@ static int http_fetch_pack(struct walker *walker, struct alt_base *repo, unsigne
 
 	if (fetch_indices(walker, repo))
 		return -1;
-	target = find_sha1_pack(sha1, repo->packs);
+	target = find_sha1_pack(the_repository, sha1, repo->packs);
 	if (!target)
 		return -1;
 	close_pack_index(target);
diff --git a/midx.c b/midx.c
index 94609456a2..c76df95d6d 100644
--- a/midx.c
+++ b/midx.c
@@ -973,7 +973,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 		}
 
 		m_offset = e.offset;
-		p_offset = find_pack_entry_one(oid.hash, e.p);
+		p_offset = find_pack_entry_one(r, oid.hash, e.p);
 
 		if (m_offset != p_offset)
 			midx_report(_("incorrect object offset for oid[%d] = %s: %"PRIx64" != %"PRIx64),
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 96716c785b..b699875555 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -935,7 +935,8 @@ static inline int bitmap_position_packfile(struct bitmap_index *bitmap_git,
 					   const struct object_id *oid)
 {
 	uint32_t pos;
-	off_t offset = find_pack_entry_one(oid->hash, bitmap_git->pack);
+	off_t offset = find_pack_entry_one(the_repository, oid->hash,
+					   bitmap_git->pack);
 	if (!offset)
 		return -1;
 
@@ -1609,7 +1610,8 @@ static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
 			if (bsearch_midx(&object->oid, bitmap_git->midx, NULL))
 				return 1;
 		} else {
-			if (find_pack_entry_one(object->oid.hash, bitmap_git->pack) > 0)
+			if (find_pack_entry_one(the_repository, object->oid.hash,
+						bitmap_git->pack) > 0)
 				return 1;
 		}
 	}
diff --git a/packfile.c b/packfile.c
index 92c919d628..bf70fd60a8 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1240,7 +1240,7 @@ off_t get_delta_base(struct repository *repo, struct packed_git *p,
 		*curpos += used;
 	} else if (type == OBJ_REF_DELTA) {
 		/* The base entry _must_ be in the same pack */
-		base_offset = find_pack_entry_one(base_info, p);
+		base_offset = find_pack_entry_one(repo, base_info, p);
 		*curpos += repo->hash_algo->rawsz;
 	} else
 		die("I am totally screwed");
@@ -1975,8 +1975,8 @@ off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 	}
 }
 
-off_t find_pack_entry_one(const unsigned char *sha1,
-				  struct packed_git *p)
+off_t find_pack_entry_one(struct repository *repo, const unsigned char *sha1,
+			  struct packed_git *p)
 {
 	const unsigned char *index = p->index_data;
 	struct object_id oid;
@@ -1987,7 +1987,7 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 			return 0;
 	}
 
-	hashcpy(oid.hash, sha1, the_repository->hash_algo);
+	hashcpy(oid.hash, sha1, repo->hash_algo);
 	if (bsearch_pack(&oid, p, &result))
 		return nth_packed_object_offset(p, result);
 	return 0;
@@ -2014,13 +2014,14 @@ int is_pack_valid(struct repository *repo, struct packed_git *p)
 	return !open_packed_git(repo, p);
 }
 
-struct packed_git *find_sha1_pack(const unsigned char *sha1,
+struct packed_git *find_sha1_pack(struct repository *repo,
+				  const unsigned char *sha1,
 				  struct packed_git *packs)
 {
 	struct packed_git *p;
 
 	for (p = packs; p; p = p->next) {
-		if (find_pack_entry_one(sha1, p))
+		if (find_pack_entry_one(repo, sha1, p))
 			return p;
 	}
 	return NULL;
@@ -2037,7 +2038,7 @@ static int fill_pack_entry(const struct object_id *oid,
 	    oidset_contains(&p->bad_objects, oid))
 		return 0;
 
-	offset = find_pack_entry_one(oid->hash, p);
+	offset = find_pack_entry_one(the_repository, oid->hash, p);
 	if (!offset)
 		return 0;
 
diff --git a/packfile.h b/packfile.h
index f744af6e9b..983d6df385 100644
--- a/packfile.h
+++ b/packfile.h
@@ -87,7 +87,8 @@ struct packed_git *get_all_packs(struct repository *r);
  */
 unsigned long repo_approximate_object_count(struct repository *r);
 
-struct packed_git *find_sha1_pack(const unsigned char *sha1,
+struct packed_git *find_sha1_pack(struct repository *repo,
+				  const unsigned char *sha1,
 				  struct packed_git *packs);
 
 void pack_report(void);
@@ -163,7 +164,8 @@ off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
  * If the object named sha1 is present in the specified packfile,
  * return its offset within the packfile; otherwise, return 0.
  */
-off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
+off_t find_pack_entry_one(struct repository *repo, const unsigned char *sha1,
+			  struct packed_git *);
 
 int is_pack_valid(struct repository *repo, struct packed_git *);
 void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object_type *, unsigned long *);
diff --git a/t/helper/test-find-pack.c b/t/helper/test-find-pack.c
index 14b2b0c12c..c5cdea98f6 100644
--- a/t/helper/test-find-pack.c
+++ b/t/helper/test-find-pack.c
@@ -40,7 +40,7 @@ int cmd__find_pack(int argc, const char **argv)
 		die("cannot parse %s as an object name", argv[0]);
 
 	for (p = get_all_packs(the_repository); p; p = p->next)
-		if (find_pack_entry_one(oid.hash, p)) {
+		if (find_pack_entry_one(the_repository, oid.hash, p)) {
 			printf("%s\n", p->pack_name);
 			actual_count++;
 		}
-- 
2.47.0

