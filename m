Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852B91DE88D
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270119; cv=none; b=H7PE361irBaRXbl79tfo0+YU8fFb7cS9iyKqHfTh3YGuBO1LaGhJBhcP8f04ukqkWePL5tVZi1rQ4bedXoL7WF2bdMU7w8aktNXvsrfLd8LtlGPcnOxW2sDCDLV6Fioc6AWDIlg1KvyyJFu0QBT1Wm4Juc9XvEGN4hOoYPyxES0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270119; c=relaxed/simple;
	bh=ZGBi6zmz94/KIX2/rj7sYLQbWHx3l/hmB4KOeZCa/6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkXtHbMASuB7j04l/fl+DUxLSfMj0cA/C0OIkOzI3pzp8cTwyZ7p/9txAG0THcP94tH5+qZk6DPYXxT+PDIBwH8rbgg5OPzt93slYue2DODa8i1/Qd+wFjozGKsOGqhhUEsstCg+HIe6OWJ42FDQ8Ox7qIFxXdEw0VKpV2wy2Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdSv3pn1; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdSv3pn1"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so2194605a12.1
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 02:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732270115; x=1732874915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsmUY+zYGc++3aDdKHLhdgz3wvb8VAJjQs8Ok+OhWTs=;
        b=OdSv3pn1r7f06fmbn5RFM49krFHI3WUnP8DxBoSsNgGCd0IBZTFgbCXHAv3SESV4+N
         zVpQqIhICzEIeUT3AJnNoZfTz1uVkllG5pcGOtiQJIdRxsxpff7S3FH9vB+EopFozadJ
         RMjsF8CerZiR63u4uJfiq6yT2LMqD3CMp01wRpzy3sFWlrOb2oBdpHydNsHryLlNbJWp
         QHcxsBV5CQODmfLEy30TLQiui+77lWqTTt6dCLF20hRjGeYpk0L3IfFeeBApYoBAhv9t
         xLPY0OtyWcAIAK64BygZRP6g4jswAfw0KMU+1BYrYLHqLGf8EuiWXLKevzqsCOvX1T/L
         B5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732270115; x=1732874915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsmUY+zYGc++3aDdKHLhdgz3wvb8VAJjQs8Ok+OhWTs=;
        b=Lp+bo3Pp/+IQKgjsb44OJvOSEeziaqphnVhj5O+aN+5U+za8F70U2wKHXfFvy4LXq0
         YLRNyb6cu2cSsk7Bx8LnM4oq7297rIy5rppTo7FclZaLo4uGQD2e1SPkOjgwTcI06zDX
         IlXpgz7W4CmF3aQHDwTkL0BBQvX/xSHFo5PjwtcroFt1jEf2rlGc9HVpknkHfguIMGOF
         MyPxnpaF0B3aRAr+pN5WXiJ/RZ9mAQOFiQVuJ9Db96be7pR455xkr/XyXJGZhGNGrxl9
         0248JX0BJdidib7HXTrSz+w+eVpGkATgXp76hUmfUsOOIVcBnLxNmJ+phKwUO8whFre7
         rArA==
X-Gm-Message-State: AOJu0YxjNgk0BASMKPedvRoFEgmzDdMTr0y7EnhBXljO+gcUcxYNGlB8
	OMfrRYO1QJ6yK3tk7iHZAj6Tf5P5fv3iyawETth4DJdc/vWaZ+F4oRGrdZJn
X-Gm-Gg: ASbGncuJmq5bPBr6h7JruMi44NCkQKvKT4IYErVvgwPdP7keVps/0mpGYsQCkw0rwTr
	1zAECU9DYysvKhEJqH7Hj+zswzBYFMhDfBZsL8tIgt9jtfgt/7PrZ8GKFn0H8RIkzOgGApbQKJ+
	dfSpS+qf7EQetrTzWdxa+cWxaU1Mj3FesvPuQ9EuI/9/pfW8O6c19KUfQqIZlCZHGDHAcwOf4eM
	sYGwvZCiP5Duik5mN4M/wdav2Agux8ou4A1JEWvoWVCrNi1tb0aVr7eEFZls0Q=
X-Google-Smtp-Source: AGHT+IH25yBhrO+wLshfzGzpOeaeyI/vVDWZ+gEqxO0F9iB5gYLdTlrA5E4ovXkKW0DQMdmtEf683w==
X-Received: by 2002:a05:6402:51cc:b0:5cf:ac4f:83c4 with SMTP id 4fb4d7f45d1cf-5d0205ddc38mr1393830a12.12.1732270114241;
        Fri, 22 Nov 2024 02:08:34 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3b0b50sm756849a12.30.2024.11.22.02.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 02:08:33 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net,
	gitster@pobox.com
Subject: [PATCH v8 02/10] packfile: use `repository` from `packed_git` directly
Date: Fri, 22 Nov 2024 11:08:21 +0100
Message-ID: <65c09858ceffb8a530ae66c6dd460200cd24c3ca.1732269840.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732269840.git.karthik.188@gmail.com>
References: <cover.1732269840.git.karthik.188@gmail.com>
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
index 6058eddf35..5bfa1e17c2 100644
--- a/packfile.c
+++ b/packfile.c
@@ -79,7 +79,7 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
 	size_t idx_size;
 	int fd = git_open(path), ret;
 	struct stat st;
-	const unsigned int hashsz = the_hash_algo->rawsz;
+	const unsigned int hashsz = p->repo->hash_algo->rawsz;
 
 	if (fd < 0)
 		return -1;
@@ -243,7 +243,7 @@ struct packed_git *parse_pack_index(struct repository *r, unsigned char *sha1,
 
 	memcpy(p->pack_name, path, alloc); /* includes NUL */
 	free(path);
-	hashcpy(p->hash, sha1, the_repository->hash_algo);
+	hashcpy(p->hash, sha1, p->repo->hash_algo);
 	if (check_packed_git_idx(idx_path, p)) {
 		free(p);
 		return NULL;
@@ -278,7 +278,7 @@ static int unuse_one_window(struct packed_git *current)
 
 	if (current)
 		scan_windows(current, &lru_p, &lru_w, &lru_l);
-	for (p = the_repository->objects->packed_git; p; p = p->next)
+	for (p = current->repo->objects->packed_git; p; p = p->next)
 		scan_windows(p, &lru_p, &lru_w, &lru_l);
 	if (lru_p) {
 		munmap(lru_w->base, lru_w->len);
@@ -540,7 +540,7 @@ static int open_packed_git_1(struct packed_git *p)
 	unsigned char hash[GIT_MAX_RAWSZ];
 	unsigned char *idx_hash;
 	ssize_t read_result;
-	const unsigned hashsz = the_hash_algo->rawsz;
+	const unsigned hashsz = p->repo->hash_algo->rawsz;
 
 	if (open_pack_index(p))
 		return error("packfile %s index unavailable", p->pack_name);
@@ -597,7 +597,7 @@ static int open_packed_git_1(struct packed_git *p)
 	if (read_result != hashsz)
 		return error("packfile %s signature is unavailable", p->pack_name);
 	idx_hash = ((unsigned char *)p->index_data) + p->index_size - hashsz * 2;
-	if (!hasheq(hash, idx_hash, the_repository->hash_algo))
+	if (!hasheq(hash, idx_hash, p->repo->hash_algo))
 		return error("packfile %s does not match index", p->pack_name);
 	return 0;
 }
@@ -637,7 +637,7 @@ unsigned char *use_pack(struct packed_git *p,
 	 */
 	if (!p->pack_size && p->pack_fd == -1 && open_packed_git(p))
 		die("packfile %s cannot be accessed", p->pack_name);
-	if (offset > (p->pack_size - the_hash_algo->rawsz))
+	if (offset > (p->pack_size - p->repo->hash_algo->rawsz))
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
+		oidread(&oid, base_info, p->repo->hash_algo);
 		base_offset = find_pack_entry_one(&oid, p);
-		*curpos += the_hash_algo->rawsz;
+		*curpos += p->repo->hash_algo->rawsz;
 	} else
 		die("I am totally screwed");
 	return base_offset;
@@ -1266,7 +1271,7 @@ static int get_delta_base_oid(struct packed_git *p,
 {
 	if (type == OBJ_REF_DELTA) {
 		unsigned char *base = use_pack(p, w_curs, curpos, NULL);
-		oidread(oid, base, the_repository->hash_algo);
+		oidread(oid, base, p->repo->hash_algo);
 		return 0;
 	} else if (type == OBJ_OFS_DELTA) {
 		uint32_t base_pos;
@@ -1608,7 +1613,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 				goto out;
 			}
 		} else
-			oidclr(oi->delta_base_oid, the_repository->hash_algo);
+			oidclr(oi->delta_base_oid, p->repo->hash_algo);
 	}
 
 	oi->whence = in_delta_base_cache(p, obj_offset) ? OI_DBCACHED :
@@ -1897,7 +1902,7 @@ int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32
 {
 	const unsigned char *index_fanout = p->index_data;
 	const unsigned char *index_lookup;
-	const unsigned int hashsz = the_hash_algo->rawsz;
+	const unsigned int hashsz = p->repo->hash_algo->rawsz;
 	int index_lookup_width;
 
 	if (!index_fanout)
@@ -1922,7 +1927,7 @@ int nth_packed_object_id(struct object_id *oid,
 			 uint32_t n)
 {
 	const unsigned char *index = p->index_data;
-	const unsigned int hashsz = the_hash_algo->rawsz;
+	const unsigned int hashsz = p->repo->hash_algo->rawsz;
 	if (!index) {
 		if (open_pack_index(p))
 			return -1;
@@ -1933,11 +1938,10 @@ int nth_packed_object_id(struct object_id *oid,
 	index += 4 * 256;
 	if (p->index_version == 1) {
 		oidread(oid, index + st_add(st_mult(hashsz + 4, n), 4),
-			the_repository->hash_algo);
+			p->repo->hash_algo);
 	} else {
 		index += 8;
-		oidread(oid, index + st_mult(hashsz, n),
-			the_repository->hash_algo);
+		oidread(oid, index + st_mult(hashsz, n), p->repo->hash_algo);
 	}
 	return 0;
 }
@@ -1959,7 +1963,7 @@ void check_pack_index_ptr(const struct packed_git *p, const void *vptr)
 off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
 {
 	const unsigned char *index = p->index_data;
-	const unsigned int hashsz = the_hash_algo->rawsz;
+	const unsigned int hashsz = p->repo->hash_algo->rawsz;
 	index += 4 * 256;
 	if (p->index_version == 1) {
 		return ntohl(*((uint32_t *)(index + st_mult(hashsz + 4, n))));
@@ -2159,7 +2163,7 @@ int for_each_object_in_pack(struct packed_git *p,
 	int r = 0;
 
 	if (flags & FOR_EACH_OBJECT_PACK_ORDER) {
-		if (load_pack_revindex(the_repository, p))
+		if (load_pack_revindex(p->repo, p))
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
+	obj = lookup_object(pack->repo, oid);
 	if (obj && obj->parsed) {
 		we_parsed_object = 0;
 	} else {
 		we_parsed_object = 1;
-		obj = parse_object(the_repository, oid);
+		obj = parse_object(pack->repo, oid);
 	}
 
 	if (!obj)
-- 
2.47.0

