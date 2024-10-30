Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BC01F12E0
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298766; cv=none; b=JEyuKMAL/FGOPTcsDw6QhSALe6sLHRkWQTuEq61Qe+Ir/QSmtJfDObEDic0YVJY8a6SQX94dZySKMZwCFP0EqfWGF0zZVWhBp+FZf9PkRMeM+MPIGLGd88memm9z/g2Tr5J8I/Mnx0RVXdeVE32rzX/ca8ag0DVzUo5TWQa1Rgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298766; c=relaxed/simple;
	bh=4j5v0/qOuYe3tPBU2206uQmF/XB9DdsYCdXzccDScfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rORkUl0Kdg4E7rTdCuhKC1feGC+smNC9AUo1Arofffmm9EHaFMyhEQOHtgUzjbOV8U9sdDG4+GmPswgNPj8d3lsS+l5INRqNZgt0eyKDVVL+upaS1Cg9J+vK6L1TuJhCxKR4Za5JnGdYw+SXAJTWC46/Ffk6c4NtL9rJJ+Pfwmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEEjH9e3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEEjH9e3"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a0472306cso929945366b.3
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 07:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730298762; x=1730903562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ux12k5OORMJfYiMEVP4VhzVGP41c2BNuBZKEmb0qzkA=;
        b=PEEjH9e3zRSSbwgydeXSHIX/A5UIHFtD1t6E9/dXCJDTA2eYvSa2lxDUMZ//8zUHms
         EFXEsSWkO1yO/ucUzuIofBIpJFWrV1j8GWdid6roB0duYLDiohHFyiDsZdTRdUwZppP6
         lpWZFw6QXNz24sshyyXjtxqniiDxOHePhGVSNpaGKvUz4TRjSdFRLdSAUGYF7j+fBnJ5
         i68Sa+JOLMlm78N+yZ0s1LN5yitPJeWDhEurvSdYToaLU1e8igDR6W13oCqWROUA/2Tk
         kYHje6G1m6m3+OK53xUoRFRHft4EWtfHAlo4oZ8WHPRvGpC4swUAVvVavY1mT7Amoz0j
         juCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298762; x=1730903562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ux12k5OORMJfYiMEVP4VhzVGP41c2BNuBZKEmb0qzkA=;
        b=OV9i+43r0x/8guzPUKJpNlnjV6HJ7x0IRz+P8Kl1XopOjNxrEaMldc5MyjApS9NxLq
         zI1r58/uZtc9/78MjT2OHL7Bl/ELKkrzsMKe/PoGK/FP8QOIc3pk+sJDxFHna+BOUieO
         Hhj0OHqj80ZKoH8DqwiCjBupGpld6EeQeTfut42sOhz/mvpiatQ05jvmM/jO/f83wAsN
         J8CwuH5GImPZK4Lsep4XhWl76JtKqnb3tvnNFbLGxyum9vgeC3FT7q6oyrYUqp6S8Nar
         oj0pKho2LU+uyi7ibYtdrn51QDxL97KTz2QqtRyvVYvQjX3qmoKO11g0uIV20Xtzs13L
         FafA==
X-Gm-Message-State: AOJu0YwMmryj2olU32BGyy9jm+387VqSQ7Vv15RJUBoaLfV4jaex91Kz
	wv6kC+zQL/s4YSKFf0KfgD4jLd5AjDMd25q6rBUA3bMU424jizcY
X-Google-Smtp-Source: AGHT+IGjN4Z/w3yARnFeDoyyFlDpdb0zHWoZ01TbzEmKBgoRF6jdZtB9Un3t1U7E7VlDU9IaifuQsg==
X-Received: by 2002:a17:907:3da4:b0:a99:f77f:b489 with SMTP id a640c23a62f3a-a9de619eb04mr1445263066b.43.1730298760044;
        Wed, 30 Oct 2024 07:32:40 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dfbc7d4sm576821066b.32.2024.10.30.07.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:32:39 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v3 2/9] packfile: use `repository` from `packed_git` directly
Date: Wed, 30 Oct 2024 15:32:27 +0100
Message-ID: <5350b4f9fb4eff5f0b24468cf3f8b29321b33c9d.1730297934.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730297934.git.karthik.188@gmail.com>
References: <cover.1730297934.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the previous commit, we introduced the `repository` structure inside
`packed_git`. This provides an alternative route instead of using the
global `the_repository` variable. Let's modify `packfile.c` now to use
this field wherever possible instead of relying on the global state.
There are still a few instances of `the_repository` usage in the file,
where there is no struct `packed_git` locally available, which will be
fixed in the following commits.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 packfile.c | 50 +++++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/packfile.c b/packfile.c
index 1423f23f57..ecb284fd98 100644
--- a/packfile.c
+++ b/packfile.c
@@ -79,7 +79,7 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 	size_t idx_size;
 	int fd = git_open(path), ret;
 	struct stat st;
-	const unsigned int hashsz = the_hash_algo->rawsz;
+	const unsigned int hashsz = p->r->hash_algo->rawsz;
 
 	if (fd < 0)
 		return -1;
@@ -243,7 +243,7 @@ struct packed_git *parse_pack_index(struct repository *r, unsigned char *sha1,
 
 	memcpy(p->pack_name, path, alloc); /* includes NUL */
 	free(path);
-	hashcpy(p->hash, sha1, the_repository->hash_algo);
+	hashcpy(p->hash, sha1, p->r->hash_algo);
 	if (check_packed_git_idx(idx_path, p)) {
 		free(p);
 		return NULL;
@@ -278,7 +278,7 @@ static int unuse_one_window(struct packed_git *current)
 
 	if (current)
 		scan_windows(current, &lru_p, &lru_w, &lru_l);
-	for (p = the_repository->objects->packed_git; p; p = p->next)
+	for (p = current->r->objects->packed_git; p; p = p->next)
 		scan_windows(p, &lru_p, &lru_w, &lru_l);
 	if (lru_p) {
 		munmap(lru_w->base, lru_w->len);
@@ -540,7 +540,7 @@ static int open_packed_git_1(struct packed_git *p)
 	unsigned char hash[GIT_MAX_RAWSZ];
 	unsigned char *idx_hash;
 	ssize_t read_result;
-	const unsigned hashsz = the_hash_algo->rawsz;
+	const unsigned hashsz = p->r->hash_algo->rawsz;
 
 	if (open_pack_index(p))
 		return error("packfile %s index unavailable", p->pack_name);
@@ -597,7 +597,7 @@ static int open_packed_git_1(struct packed_git *p)
 	if (read_result != hashsz)
 		return error("packfile %s signature is unavailable", p->pack_name);
 	idx_hash = ((unsigned char *)p->index_data) + p->index_size - hashsz * 2;
-	if (!hasheq(hash, idx_hash, the_repository->hash_algo))
+	if (!hasheq(hash, idx_hash, p->r->hash_algo))
 		return error("packfile %s does not match index", p->pack_name);
 	return 0;
 }
@@ -637,7 +637,7 @@ unsigned char *use_pack(struct packed_git *p,
 	 */
 	if (!p->pack_size && p->pack_fd == -1 && open_packed_git(p))
 		die("packfile %s cannot be accessed", p->pack_name);
-	if (offset > (p->pack_size - the_hash_algo->rawsz))
+	if (offset > (p->pack_size - p->r->hash_algo->rawsz))
 		die("offset beyond end of packfile (truncated pack?)");
 	if (offset < 0)
 		die(_("offset before end of packfile (broken .idx?)"));
@@ -711,6 +711,7 @@ struct packed_git *add_packed_git(struct repository *r, const char *path,
 	struct stat st;
 	size_t alloc;
 	struct packed_git *p;
+	struct object_id oid;
 
 	/*
 	 * Make sure a corresponding .pack file exists and that
@@ -751,9 +752,13 @@ struct packed_git *add_packed_git(struct repository *r, const char *path,
 	p->pack_size = st.st_size;
 	p->pack_local = local;
 	p->mtime = st.st_mtime;
-	if (path_len < the_hash_algo->hexsz ||
-	    get_hash_hex(path + path_len - the_hash_algo->hexsz, p->hash))
-		hashclr(p->hash, the_repository->hash_algo);
+	if (path_len < r->hash_algo->hexsz ||
+	    get_oid_hex_algop(path + path_len - r->hash_algo->hexsz, &oid,
+			      r->hash_algo))
+		hashclr(p->hash, r->hash_algo);
+	else
+		hashcpy(p->hash, oid.hash, r->hash_algo);
+
 	return p;
 }
 
@@ -1243,9 +1248,9 @@ off_t get_delta_base(struct packed_git *p,
 	} else if (type == OBJ_REF_DELTA) {
 		/* The base entry _must_ be in the same pack */
 		struct object_id oid;
-		oidread(&oid, base_info, the_repository->hash_algo);
+		oidread(&oid, base_info, p->r->hash_algo);
 		base_offset = find_pack_entry_one(&oid, p);
-		*curpos += the_hash_algo->rawsz;
+		*curpos += p->r->hash_algo->rawsz;
 	} else
 		die("I am totally screwed");
 	return base_offset;
@@ -1266,7 +1271,7 @@ static int get_delta_base_oid(struct packed_git *p,
 {
 	if (type == OBJ_REF_DELTA) {
 		unsigned char *base = use_pack(p, w_curs, curpos, NULL);
-		oidread(oid, base, the_repository->hash_algo);
+		oidread(oid, base, p->r->hash_algo);
 		return 0;
 	} else if (type == OBJ_OFS_DELTA) {
 		uint32_t base_pos;
@@ -1608,7 +1613,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 				goto out;
 			}
 		} else
-			oidclr(oi->delta_base_oid, the_repository->hash_algo);
+			oidclr(oi->delta_base_oid, p->r->hash_algo);
 	}
 
 	oi->whence = in_delta_base_cache(p, obj_offset) ? OI_DBCACHED :
@@ -1897,7 +1902,7 @@ int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32
 {
 	const unsigned char *index_fanout = p->index_data;
 	const unsigned char *index_lookup;
-	const unsigned int hashsz = the_hash_algo->rawsz;
+	const unsigned int hashsz = p->r->hash_algo->rawsz;
 	int index_lookup_width;
 
 	if (!index_fanout)
@@ -1922,7 +1927,7 @@ int nth_packed_object_id(struct object_id *oid,
 			 uint32_t n)
 {
 	const unsigned char *index = p->index_data;
-	const unsigned int hashsz = the_hash_algo->rawsz;
+	const unsigned int hashsz = p->r->hash_algo->rawsz;
 	if (!index) {
 		if (open_pack_index(p))
 			return -1;
@@ -1933,11 +1938,10 @@ int nth_packed_object_id(struct object_id *oid,
 	index += 4 * 256;
 	if (p->index_version == 1) {
 		oidread(oid, index + st_add(st_mult(hashsz + 4, n), 4),
-			the_repository->hash_algo);
+			p->r->hash_algo);
 	} else {
 		index += 8;
-		oidread(oid, index + st_mult(hashsz, n),
-			the_repository->hash_algo);
+		oidread(oid, index + st_mult(hashsz, n), p->r->hash_algo);
 	}
 	return 0;
 }
@@ -1959,7 +1963,7 @@ void check_pack_index_ptr(const struct packed_git *p, const void *vptr)
 off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 {
 	const unsigned char *index = p->index_data;
-	const unsigned int hashsz = the_hash_algo->rawsz;
+	const unsigned int hashsz = p->r->hash_algo->rawsz;
 	index += 4 * 256;
 	if (p->index_version == 1) {
 		return ntohl(*((uint32_t *)(index + st_mult(hashsz + 4, n))));
@@ -2159,7 +2163,7 @@ int for_each_object_in_pack(struct packed_git *p,
 	int r = 0;
 
 	if (flags & FOR_EACH_OBJECT_PACK_ORDER) {
-		if (load_pack_revindex(the_repository, p))
+		if (load_pack_revindex(p->r, p))
 			return -1;
 	}
 
@@ -2227,7 +2231,7 @@ int for_each_packed_object(each_packed_object_fn cb, void *data,
 }
 
 static int add_promisor_object(const struct object_id *oid,
-			       struct packed_git *pack UNUSED,
+			       struct packed_git *pack,
 			       uint32_t pos UNUSED,
 			       void *set_)
 {
@@ -2235,12 +2239,12 @@ static int add_promisor_object(const struct object_id *oid,
 	struct object *obj;
 	int we_parsed_object;
 
-	obj = lookup_object(the_repository, oid);
+	obj = lookup_object(pack->r, oid);
 	if (obj && obj->parsed) {
 		we_parsed_object = 0;
 	} else {
 		we_parsed_object = 1;
-		obj = parse_object(the_repository, oid);
+		obj = parse_object(pack->r, oid);
 	}
 
 	if (!obj)
-- 
2.47.0

