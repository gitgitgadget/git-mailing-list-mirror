Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8B71F8AF2
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737105690; cv=none; b=oOr3C9YoUeRA4Y36zz8aRw2MFFokX7iTJ/IZRH0EV4UvvveBi4rhXhzdecmiVOPLNs+dH0x4JpjrkH+1fwyOUaEiVyDrLdq/qiaKH+23ciHe+PhMdr0oP+P/+dCZwOEBfFEqEfougKob/7eQcfMxQ+AYAhWWmvPRWrWEktdtnqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737105690; c=relaxed/simple;
	bh=9kFuITbRumnH74PKHjusgQ2qdn/hfbWNmYOxuSJK3rk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MjMaTO/zGr2c9lWejvMzyagrSjQxewqKyMQ5L2mnlUhPIBEQ91/aK0Xe0xbPvHVr1dt9+XQpFqr9YorRcec8JM6rPnm30Vwg08hmTK5hnaM1fbeE0i3YMvuuuWzDtoXK8lE2iHWOXi3HIvy36XMfNCYJS3dk51uP1bs8+OTjBik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7GS7hRg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7GS7hRg"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2166f1e589cso46007865ad.3
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 01:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737105687; x=1737710487; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bR9d6T1dx5zEkdi028Rb0GF0JUAz7X1++LakO3DyP6U=;
        b=g7GS7hRgl8eBRHmST8y1hKb2MmV8Fp2OAEfzacz1YSkj5VtgedHOlM2RPgrXr5ICI0
         ec3HhNi3tTyYWyNb7Tr489OIWyRgLuAtlMpf30NUDb8NsSB0eeLvUlpxw9eYrCU91gZ5
         liwVQfDhRpitC/Fw3JSuTh7OAMBGwmw6TSiT7deF34byYnvXg75nNniJNVqmmTV6DQoi
         4rmeQ/yZ8PGJYAHzcD7/qocu/9gIvgspljnEVQQt/Nl11sNVVZUku+ReyPH/dSy536rb
         5DxbxNQyRVO77rn2Jq31d6rG1Y5B4T6dV7t9g/9zSOyeRZg3GCWunGXra/6McB7mhDH/
         rqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737105687; x=1737710487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bR9d6T1dx5zEkdi028Rb0GF0JUAz7X1++LakO3DyP6U=;
        b=uH6rhzyJKL+pVYPBDfkfjltSI7xfkPFm08Kr+U8Um3xd6N5L2A0GI+bsrEqnJFdRFE
         aMeo1Wo7gvEpxZRXaMzctV41L/7heyZIe9TU92I0bkP7Oo0neUzIRRi7QLF8ejwErpMk
         v52Jz5yLOhbje0JScrLiT64YuZS1l+shups21skREZ0yZb8qGYfb4QkskwE4Qtz9o45R
         1FG/NgB26kMHjPUCxv46hJfsg4V4vO4Ldz+m99vF9974V7K+Y+X/MeBIu0Kra5FAS6Cf
         xRci1AJL0leb2RCLHJkZKBkkG0LzqZoEiOXAeXnYMpGZ3sow7pbPCruEXKzv8/BAb5iv
         CYfw==
X-Gm-Message-State: AOJu0YyGsqDB2Zb2uiGUTiq6mKbS59WGJ/2lciPz7WCuctW7JH7bc2mj
	VoscsFeZN+nyHrJ8w1ablctTeFYo/c1O34NfOKxAhjqKn6SUhVzKs/fK+IyE
X-Gm-Gg: ASbGncv5QEgFFDI1CDnIcNPhRr3kYzi8dCgDiLPjverL5gt4L5PhYBwrnRKDBbZ3qi3
	bV9WhZZX1BNrxyAGmRhZpM233KrgFbqjcIUZWcSXTR6CyQzE9BzEXepBLURzGSa+zdU7tDTHJsq
	a6UI/J+gWYVrGimKzXQa550s8ueMHxHsWQYyxYC6b5Q0lmps4pFYTRE0tXnCcA6aBvIGpXyCkCr
	Y4oZbiP2taGbcyzEL8CceXhYJnoqBBiX3M77UDmWzaORmXnXR0BuXu2tNI=
X-Google-Smtp-Source: AGHT+IGOg4yPgkc1kqWDnhijnwohTIsnV16NY6BMWLJAgNUbb1jCbZfSAQXOoshPnu36D+BkDMeVcA==
X-Received: by 2002:a17:902:e746:b0:215:97c5:52b4 with SMTP id d9443c01a7336-21c35631dd4mr28015285ad.39.1737105687386;
        Fri, 17 Jan 2025 01:21:27 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3e088bsm11714065ad.173.2025.01.17.01.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:21:26 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 17 Jan 2025 10:20:51 +0100
Subject: [PATCH v2 4/5] pack-write: pass hash_algo to `write_rev_file()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-kn-the-repo-cleanup-v2-4-a7fdc19688f5@gmail.com>
References: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
In-Reply-To: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5990; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=9kFuITbRumnH74PKHjusgQ2qdn/hfbWNmYOxuSJK3rk=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeKIQedJyEX4XZdBK49kKXe7e12qImI/Vl5+
 yvGvLsI23/HkokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJniiEHAAoJED7VnySO
 Rox/Mw0L/iS7FV1W9gijNbJz5Bin2tUCqRLHdB91driahVgaNUbGny8avWqj/hwMWCSoX3PmdUY
 zj7Q5WeyfZuEWvJHmHka8iFIkzZMMTgUi9SJM9RoOv+mwluHeBFdM4D4XxLY6Ch9g/k6s3KmIw9
 83PogEcxUXiIPeDbuO8Q+snabyQFLEFivRF5OHsilsiQTUj1oGor5R3ohtGJigYbhFIwSYBBCJc
 BhXnBuEk5nd6PbWxTg5EciJvDylvm+n0uJE1VodUQ3JdoV38sk1kvJn8hkATRamnL7yUVDSrQaa
 8XrutL+eXJg2DXaxJDa/8bXvmASyVwUnYJ0oGIxOLvd8xSqGDqoetHQxMK+4GGbjz0Nb2b8Bm9t
 GS90t7Kf9gMe1nm2j7nQz9hqNd8RVtJTgCCexO4RyeGhZ2unJxuzTgUmH53QC1dCGJjCbG2TTEi
 twLzva7/Cj3++eiHta/O9nu/aBX81Mv6ILjvTiMkD2WoW4OhfAElBOA6b6x7pbRmn7ev8NLzAR5
 3s=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `write_rev_file()` function uses the global `the_hash_algo` variable
to access the repository's hash function. To avoid global variable
usage, let's pass the hash function from the layers above. Also modify
children functions `write_rev_file_order()` and `write_rev_header()` to
accept 'the_hash_algo'.

Altough the layers above could have access to the hash function
internally, simply pass in `the_hash_algo`. This avoids any
compatibility issues and bubbles up global variable usage to upper
layers which can be eventually resolved.

However, in `midx-write.c`, since all usage of global variables is
removed, don't reintroduce them and instead use the `repo` available in
the context.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/index-pack.c |  6 +++---
 midx-write.c         |  4 ++--
 pack-write.c         | 21 ++++++++++++---------
 pack.h               | 14 ++++++++++++--
 4 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d73699653a2227f8ecfee2c0f51cd680093ac764..e803cb2444633f937fafc841848dae85341475f1 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -2099,9 +2099,9 @@ int cmd_index_pack(int argc,
 	curr_index = write_idx_file(the_hash_algo, index_name, idx_objects,
 				    nr_objects, &opts, pack_hash);
 	if (rev_index)
-		curr_rev_index = write_rev_file(rev_index_name, idx_objects,
-						nr_objects, pack_hash,
-						opts.flags);
+		curr_rev_index = write_rev_file(the_hash_algo, rev_index_name,
+						idx_objects, nr_objects,
+						pack_hash, opts.flags);
 	free(idx_objects);
 
 	if (!verify)
diff --git a/midx-write.c b/midx-write.c
index b3827b936bdb1df12c73fb7d9b98ff65fc875cc3..61b59d557d3ba46a39db74c62393545cabf50f2c 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -658,8 +658,8 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
 	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex_algop(midx_hash,
 								    ctx->repo->hash_algo));
 
-	tmp_file = write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
-					midx_hash, WRITE_REV);
+	tmp_file = write_rev_file_order(ctx->repo->hash_algo, NULL, ctx->pack_order,
+					ctx->entries_nr, midx_hash, WRITE_REV);
 
 	if (finalize_object_file(tmp_file, buf.buf))
 		die(_("cannot store reverse index file"));
diff --git a/pack-write.c b/pack-write.c
index f344e78a9ec20cea9812a5eaffc72ae0b7e7424d..09ecbcdb069cc9b0383295798ceb49cbdc632b64 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -194,11 +194,12 @@ static int pack_order_cmp(const void *va, const void *vb, void *ctx)
 	return 0;
 }
 
-static void write_rev_header(struct hashfile *f)
+static void write_rev_header(const struct git_hash_algo *hash_algo,
+			     struct hashfile *f)
 {
 	hashwrite_be32(f, RIDX_SIGNATURE);
 	hashwrite_be32(f, RIDX_VERSION);
-	hashwrite_be32(f, oid_version(the_hash_algo));
+	hashwrite_be32(f, oid_version(hash_algo));
 }
 
 static void write_rev_index_positions(struct hashfile *f,
@@ -215,7 +216,8 @@ static void write_rev_trailer(struct hashfile *f, const unsigned char *hash)
 	hashwrite(f, hash, the_hash_algo->rawsz);
 }
 
-char *write_rev_file(const char *rev_name,
+char *write_rev_file(const struct git_hash_algo *hash_algo,
+		     const char *rev_name,
 		     struct pack_idx_entry **objects,
 		     uint32_t nr_objects,
 		     const unsigned char *hash,
@@ -233,15 +235,16 @@ char *write_rev_file(const char *rev_name,
 		pack_order[i] = i;
 	QSORT_S(pack_order, nr_objects, pack_order_cmp, objects);
 
-	ret = write_rev_file_order(rev_name, pack_order, nr_objects, hash,
-				   flags);
+	ret = write_rev_file_order(hash_algo, rev_name, pack_order, nr_objects,
+				   hash, flags);
 
 	free(pack_order);
 
 	return ret;
 }
 
-char *write_rev_file_order(const char *rev_name,
+char *write_rev_file_order(const struct git_hash_algo *hash_algo,
+			   const char *rev_name,
 			   uint32_t *pack_order,
 			   uint32_t nr_objects,
 			   const unsigned char *hash,
@@ -280,7 +283,7 @@ char *write_rev_file_order(const char *rev_name,
 		return NULL;
 	}
 
-	write_rev_header(f);
+	write_rev_header(hash_algo, f);
 
 	write_rev_index_positions(f, pack_order, nr_objects);
 	write_rev_trailer(f, hash);
@@ -568,8 +571,8 @@ void stage_tmp_packfiles(const struct git_hash_algo *hash_algo,
 	if (adjust_shared_perm(*idx_tmp_name))
 		die_errno("unable to make temporary index file readable");
 
-	rev_tmp_name = write_rev_file(NULL, written_list, nr_written, hash,
-				      pack_idx_opts->flags);
+	rev_tmp_name = write_rev_file(hash_algo, NULL, written_list, nr_written,
+				      hash, pack_idx_opts->flags);
 
 	if (pack_idx_opts->flags & WRITE_MTIMES) {
 		mtimes_tmp_name = write_mtimes_file(to_pack, written_list,
diff --git a/pack.h b/pack.h
index c650fdbe2dcde8055ad0efe55646338cd0f81df5..8a84ea475cda902936ee0b6091c5b4d462606be8 100644
--- a/pack.h
+++ b/pack.h
@@ -105,8 +105,18 @@ struct ref;
 
 void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought);
 
-char *write_rev_file(const char *rev_name, struct pack_idx_entry **objects, uint32_t nr_objects, const unsigned char *hash, unsigned flags);
-char *write_rev_file_order(const char *rev_name, uint32_t *pack_order, uint32_t nr_objects, const unsigned char *hash, unsigned flags);
+char *write_rev_file(const struct git_hash_algo *hash_algo,
+		     const char *rev_name,
+		     struct pack_idx_entry **objects,
+		     uint32_t nr_objects,
+		     const unsigned char *hash,
+		     unsigned flags);
+char *write_rev_file_order(const struct git_hash_algo *hash_algo,
+			   const char *rev_name,
+			   uint32_t *pack_order,
+			   uint32_t nr_objects,
+			   const unsigned char *hash,
+			   unsigned flags);
 
 /*
  * The "hdr" output buffer should be at least this big, which will handle sizes

-- 
2.47.0

