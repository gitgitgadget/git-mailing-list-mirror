Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8041E7C0F
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504704; cv=none; b=JzD6QvJViJY0Uc9sOpB/l/eGxlni2qoeUNSUbdlX6L0iGU7/qug3WFnjXphhCmwsxovq/5d6xGp9k3pRKnoV9vBNVmMYFfC8JB8RUjKnBex4qXWti/nHr5z/iikIau+f3Cs91CsyxaSN9Vb6tBOJF39UEQOQfXKZSBugx5eF6iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504704; c=relaxed/simple;
	bh=KhCX0GczazViNfbUy49HHxNBcC2NMjXVntKCV00SW6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSD4OopFRue5Kn//Lu/yEEPl/c++41Qi+mEwyacSdDI8zneJhCdaIWLZqWuS5ywD8JY5HGm0RHpftmdBAz0cqW/p+bdr5T5e5Okm8BtU/L0xiF2/wHc4XGl90S7wi/WYNByY1En8E098z77alOWLD0+Xmj9901CNg1p6+ZYxT0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxNh8Wfn; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxNh8Wfn"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a628b68a7so539874866b.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504700; x=1730109500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mq7BBr6N06celAmlSLi8Us45icUaYjmWxIT6FLOCszk=;
        b=IxNh8WfntwvKMSLbwLA/RhN6G9tkkN2gjr+F4NfaWmXjGKLDyyZMUeS/FkYPYc/dsL
         Sv1MnSHd7GW5/msg/0GrqLn1TnRYJxUJ3shJ8KAcvFsWsb6Pz0INdoRIYTOHy1G2fyde
         o/vHKW1YxgDAwzeExTvIweN/aGa+u3SyG3BeZzn97Ozm/GEDUl2Anw4Oq6jSMa3E1KeG
         E+EBLzz39VGnoOLoUC+QTgBl0+r/BmOGjxNTgdBfA+8lzSL62YG204lFjHWKmncCX+w2
         8WoAN3n3prsK3lbV4bUXPSAMiqCBbll0YRQzq4GYXZ/wwBH+U0xAycwY01hImSFzNJB9
         vc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504700; x=1730109500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mq7BBr6N06celAmlSLi8Us45icUaYjmWxIT6FLOCszk=;
        b=eThqgqvRRkS6OdENrABCm3Rkbuiwp3n00mWARBXb6SCx5Zuo84EVAANFYfqJZ7N9LJ
         59prbExnGdmJRdFs1I+DFysKtyANuLsg3sVIfBv6kxJEcvd/4XqFWX0xlLnZa0uwb+gk
         Ov/6JS/2lRa3lS3mM6hIfrNBWk9sWVZBdn30DAsoZ60E77CRwMn/9QdIt90cZsfpl7VD
         Tx+ygJD33OEXbUFv+yIlfbY+076O3fGRfH5kx6Sun/1reLC9GbdPnGdaESgf7YreAK9k
         xH+Mq05AuAzs3KITq8dlS4jQkdRc/t6rEiSdNClGok1GaSv8yGQuBYo00FKuj3neDgW+
         LTQw==
X-Gm-Message-State: AOJu0YyyXhw2GXhIzZtTcNkfxn09QVwEzozqQnaGC4PJ8IdZgWfqFnR4
	76ZbSD4HuBS6YAkvvFf65ni2m4Hchzfn5yyPYWYmB0DnD6QhbmPJ62jakLC5
X-Google-Smtp-Source: AGHT+IFiLMMvh8dQnEz83sl0Yc0tk1AwSQbf8vwLWOy9eZmjoC+9IynDR8vvn3MIoVpA36uYG3L9Bw==
X-Received: by 2002:a17:907:6e89:b0:a8a:8cdb:83a7 with SMTP id a640c23a62f3a-a9a69ca05b0mr1130165566b.54.1729504700119;
        Mon, 21 Oct 2024 02:58:20 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d631dsm187122266b.17.2024.10.21.02.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:58:19 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 18/20] packfile: pass down repository to `nth_packed_object_offset`
Date: Mon, 21 Oct 2024 11:58:01 +0200
Message-ID: <973e8a560d48343e07a02bab88b31bfb5d3e903a.1729504641.git.karthik.188@gmail.com>
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

The function `nth_packed_object_offset` currently relies on the global
variable `the_repository`. To eliminate global variable usage in
`packfile.c`, we should progressively shift the dependency on
the_repository to higher layers. Let's remove its usage from this
function and any related ones.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/cat-file.c     | 4 ++--
 builtin/pack-objects.c | 6 +++---
 commit-graph.c         | 2 +-
 midx-write.c           | 2 +-
 pack-check.c           | 2 +-
 pack-revindex.c        | 3 ++-
 packfile.c             | 8 +++++---
 packfile.h             | 4 +++-
 reachable.c            | 3 ++-
 9 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index e5d774b097..8aab7481b6 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -632,14 +632,14 @@ static int batch_unordered_loose(const struct object_id *oid,
 	return batch_unordered_object(oid, NULL, 0, data);
 }
 
-static int batch_unordered_packed(struct repository *repo UNUSED,
+static int batch_unordered_packed(struct repository *repo,
 				  const struct object_id *oid,
 				  struct packed_git *pack,
 				  uint32_t pos,
 				  void *data)
 {
 	return batch_unordered_object(oid, pack,
-				      nth_packed_object_offset(pack, pos),
+				      nth_packed_object_offset(repo, pack, pos),
 				      data);
 }
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ffbd48c60c..8ab51eab8d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3361,7 +3361,7 @@ static int git_pack_config(const char *k, const char *v,
 static int stdin_packs_found_nr;
 static int stdin_packs_hints_nr;
 
-static int add_object_entry_from_pack(struct repository *repo UNUSED,
+static int add_object_entry_from_pack(struct repository *repo,
 				      const struct object_id *oid,
 				      struct packed_git *p,
 				      uint32_t pos,
@@ -3375,7 +3375,7 @@ static int add_object_entry_from_pack(struct repository *repo UNUSED,
 	if (have_duplicate_entry(oid, 0))
 		return 0;
 
-	ofs = nth_packed_object_offset(p, pos);
+	ofs = nth_packed_object_offset(repo, p, pos);
 	if (!want_object_in_pack(oid, 0, &p, &ofs))
 		return 0;
 
@@ -3919,7 +3919,7 @@ static int add_object_in_unpacked_pack(struct repository *repo,
 		} else {
 			mtime = pack->mtime;
 		}
-		offset = nth_packed_object_offset(pack, pos);
+		offset = nth_packed_object_offset(repo, pack, pos);
 
 		add_cruft_object_entry(oid, OBJ_NONE, pack, offset,
 				       NULL, mtime);
diff --git a/commit-graph.c b/commit-graph.c
index 35e4e9d99d..24aae68195 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1495,7 +1495,7 @@ static int add_packed_commits(struct repository *repo UNUSED,
 {
 	struct write_commit_graph_context *ctx = (struct write_commit_graph_context*)data;
 	enum object_type type;
-	off_t offset = nth_packed_object_offset(pack, pos);
+	off_t offset = nth_packed_object_offset(ctx->r, pack, pos);
 	struct object_info oi = OBJECT_INFO_INIT;
 
 	if (ctx->progress)
diff --git a/midx-write.c b/midx-write.c
index 2b7c50d25c..69aada253f 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -233,7 +233,7 @@ static void fill_pack_entry(uint32_t pack_int_id,
 	entry->pack_int_id = pack_int_id;
 	entry->pack_mtime = p->mtime;
 
-	entry->offset = nth_packed_object_offset(p, cur_object);
+	entry->offset = nth_packed_object_offset(the_repository, p, cur_object);
 	entry->preferred = !!preferred;
 }
 
diff --git a/pack-check.c b/pack-check.c
index d93cf3f224..01562267a4 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -98,7 +98,7 @@ static int verify_packfile(struct repository *r,
 	entries[nr_objects].offset = pack_sig_ofs;
 	/* first sort entries by pack offset, since unpacking them is more efficient that way */
 	for (i = 0; i < nr_objects; i++) {
-		entries[i].offset = nth_packed_object_offset(p, i);
+		entries[i].offset = nth_packed_object_offset(r, p, i);
 		entries[i].nr = i;
 	}
 	QSORT(entries, nr_objects, compare_entries);
diff --git a/pack-revindex.c b/pack-revindex.c
index c14ef971da..03d8c39c94 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -466,7 +466,8 @@ off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos)
 	else if (pos == p->num_objects)
 		return p->pack_size - the_hash_algo->rawsz;
 	else
-		return nth_packed_object_offset(p, pack_pos_to_index(p, pos));
+		return nth_packed_object_offset(the_repository, p,
+						pack_pos_to_index(p, pos));
 }
 
 uint32_t pack_pos_to_midx(struct multi_pack_index *m, uint32_t pos)
diff --git a/packfile.c b/packfile.c
index e06931154f..1415df38e9 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1964,10 +1964,12 @@ void check_pack_index_ptr(const struct packed_git *p, const void *vptr)
 		    p->pack_name);
 }
 
-off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
+off_t nth_packed_object_offset(struct repository *repo,
+			       const struct packed_git *p,
+			       uint32_t n)
 {
 	const unsigned char *index = p->index_data;
-	const unsigned int hashsz = the_hash_algo->rawsz;
+	const unsigned int hashsz = repo->hash_algo->rawsz;
 	index += 4 * 256;
 	if (p->index_version == 1) {
 		return ntohl(*((uint32_t *)(index + st_mult(hashsz + 4, n))));
@@ -1998,7 +2000,7 @@ off_t find_pack_entry_one(struct repository *repo, const unsigned char *sha1,
 
 	hashcpy(oid.hash, sha1, repo->hash_algo);
 	if (bsearch_pack(repo, &oid, p, &result))
-		return nth_packed_object_offset(p, result);
+		return nth_packed_object_offset(repo, p, result);
 	return 0;
 }
 
diff --git a/packfile.h b/packfile.h
index d145959480..9184560f0e 100644
--- a/packfile.h
+++ b/packfile.h
@@ -160,7 +160,9 @@ int nth_packed_object_id(struct repository *repo, struct object_id *,
  * Return the offset of the nth object within the specified packfile.
  * The index must already be opened.
  */
-off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
+off_t nth_packed_object_offset(struct repository *repo,
+			       const struct packed_git *,
+			       uint32_t n);
 
 /*
  * If the object named sha1 is present in the specified packfile,
diff --git a/reachable.c b/reachable.c
index 833013e7a3..e347e2d6ca 100644
--- a/reachable.c
+++ b/reachable.c
@@ -295,7 +295,8 @@ static int add_recent_packed(struct repository *repo,
 			die(_("could not load cruft pack .mtimes"));
 		mtime = nth_packed_mtime(p, pos);
 	}
-	add_recent_object(oid, p, nth_packed_object_offset(p, pos), mtime, data);
+	add_recent_object(oid, p, nth_packed_object_offset(repo, p, pos), mtime,
+			  data);
 	return 0;
 }
 
-- 
2.47.0

