Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB3F2010E9
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724934; cv=none; b=WDDeA6ZVAX3+Sgc4IVP683MtVPqamskJFaRSW+guv0G6pjPRbTgo0PT3oJdktlsMPMI5RWm3PeRjLaVaHpMYZBDZDLpAc9ypr8SNAzAscJioOg+Xl0ichtIhR2a32myikCewbusfhgh/xmDafYtiNkP8DFHpIgSkuQnhrFJcSxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724934; c=relaxed/simple;
	bh=h3d1YN0mg+7WTli0tfJG7yX2+KjePRbpgfBA0Y8W0J4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kbUqrhlCRqgkPoKc3n3JaEYBUzgBhIGmP+mn4KpG3amcnZzddwU0PCqBfUKFWoWU3/MDZkkbfTxBqQE3B3GWF7XPrYYwN1vW84JhsUK3F4BxwfnKKbObQZQ/JiWwkN2Rhotf9D9a6cUMdJst/ij6Y+iPPpxEZ2e+uMoe6ajqWtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3QrJ0Z4; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3QrJ0Z4"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53de79c2be4so3632896e87.2
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 08:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732724930; x=1733329730; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qiaMpUjWKqbyruY9egEhMlrHVuLe+9iR5WEHcxqbbsk=;
        b=V3QrJ0Z4oadYxcoiDmsJRKs/WBwQFER4AkS901+1U1XABux1wPCUm2l9lpDtCFr4ie
         Zt9GPHl17ygkbt8uu+ZlEwgXffzqrxBfkXKR/ZheugUAe9fLYCuAUprFwSIAOVoXS05A
         GUCLnLHq+qhbSKr2BLsG/sg2/g47rh8TB/fE162si7zRMTVzdJ5AXqrGErucrWuXvA9+
         dMgAlvQZnpBGHyW7iz2XOsSkH05OJCt16m6Cv1rOJUAkiTu7sTFyCDcSIb+16y1JUscS
         lD59I9rFDItMy5ZWofSBswpbPIIZKozEMat4SiKLJsTLhcwIJu2x/WmONXyS7+IOxkYX
         K0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732724930; x=1733329730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiaMpUjWKqbyruY9egEhMlrHVuLe+9iR5WEHcxqbbsk=;
        b=j36gDkpST9nT0Tr+cC18Ai9jcEr93pQVSxHbhw+3U0O/qLU+YidXGsF8bjRTW2N6oi
         KYnMDTCSmVD8tDC37/aD2ha/l+ThMODdBO6KAUa3rBYTO0oSkWCisLbdgaalbYRqz/+O
         YJCx1he+QG1OLzGYJR2rJt49VPCFUC1G5nGuQ+mh3a9bPO6pvZ5PKvDFX13M3qNDpAST
         okf4eI6PkQ4hWtZGXSHtEbNvpCJ9yjOdqYcrzf0Mkzed9e6tejgsLKVOYoit5vMUtSsN
         GygjAR8VXg16QkObAjY8wG/p6resWXPRrwDtW+d4+3gOde1On5hXTqDVnygf5L3qLknn
         1XuQ==
X-Gm-Message-State: AOJu0YxRekvA7gOfoGjF8sQZl3su8rnY2fdojnwBx7dg7nmj/bfaUQjF
	fPOV3GslJb9UrZZyQA+tSwsFg9Ub39zrZAAWhuW9MzSFAKqXOH1t
X-Gm-Gg: ASbGnctc/vw/TcSM21qFlirT3mcFskLKa5uP5IO/KY1Q2HSm+T7cC0HRo8CNUtuCAW+
	VA3tthoRHJ0OsVc4f0nSj0aPxiBvBNXheiobi0AnbKya8kjUqn5oUl32tfB7H9bmIkGEf6p5X+8
	jLmJDMnZLuD3EcuZI6xzmAOkFIhgmeLJ1IQpZg3ubUQQyTn4KkDM49dMv+c5JF5s4Pon2KmqZt6
	4QnZmVb66gPrErkhxykTDuGQSYgmwVfnNtsun5hK2/qf+b0H8eRledlYweVgA==
X-Google-Smtp-Source: AGHT+IGRKP+2UTIdmxD0dnYlyCrtIpnQh7qAUY8IrINLyXoWKNg/99ezZmbs98+G8SO1QIATdmweIg==
X-Received: by 2002:a05:6512:b9c:b0:53d:ed62:e653 with SMTP id 2adb3069b0e04-53df00d102bmr2103987e87.15.1732724930175;
        Wed, 27 Nov 2024 08:28:50 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:825d:6a00:5640:4a6:5555:68ae])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa54e15c169sm420042366b.67.2024.11.27.08.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:28:49 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 27 Nov 2024 17:28:28 +0100
Subject: [PATCH v3 3/8] write-midx: add repository field to
 `write_midx_context`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-3-c5a99f85009b@gmail.com>
References: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
In-Reply-To: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, me@ttaylorr.com, 
 shejialuo@gmail.com, gitster@pobox.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6085; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=h3d1YN0mg+7WTli0tfJG7yX2+KjePRbpgfBA0Y8W0J4=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnR0i84GdtnzXEsdIRkUoVfVGEJd2uKz2noRYlZ
 03KltVqRFaJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ0dIvAAKCRA+1Z8kjkaM
 f7/+C/9cAOVFrh5mKDZA60065pevICIwJXTAXsqtp4uV0UVC1T5S3arZObygdKGm1/hGQ4atDoL
 J+dNOR+SrTXKqSz/8kOy5m2y06CT89oEXzlYTtvfIDL4hKoLKDIYqWKf50/BHUlUWqDrBoFCPfi
 p8XEVB6NaHYeSXNoWhrVN3v2HkGGeGOkU9Kj8SrtMgwJMWBJ8nscZ7/W0OB7ojwXT3HDPLQk3lZ
 Cqt1Van7g/uUyaRF+j8FXxzonLm0nVVgO4Oy2U7x+XmFzUL3yF0oI3gURJecPN2VTiPIW0S8K8r
 TWC+u+gOxFsfS7WIr7iQfEUj5YBP4picZh6UWCPqRXTc5ac9tYcNS5goau/hygg6o/4Ua+8IYAH
 1dnimUJg9JC967oawfgKKXl3CXfTTNf+QAdiXbgYI3cUfEbWGhhX+o/s1GALTH3RrI0I4u75iR8
 xeFNXNmLE+T72QXrZa0I1oKD1WjsJJH5kvsTQnNgBvg9ZFEYw0w5KxlO2ROxI92dElyj8=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The struct `write_midx_context` is used to pass context for creating
MIDX files. Add the repository field here to ensure that most functions
within `midx-write.c` have access to the field and can use that instead
of the global `the_repository` variable.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 midx-write.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 564438f616f59cd24edda956e4af0e0acf167138..1c355cdf8db4e9fed61a4aabf61a237ad26181ce 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -110,6 +110,8 @@ struct write_midx_context {
 	uint32_t num_multi_pack_indexes_before;
 
 	struct string_list *to_include;
+
+	struct repository *repo;
 };
 
 static int should_include_pack(const struct write_midx_context *ctx,
@@ -154,7 +156,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 			return;
 
 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
-		p = add_packed_git(the_repository, full_path, full_path_len, 0);
+		p = add_packed_git(ctx->repo, full_path, full_path_len, 0);
 		if (!p) {
 			warning(_("failed to add packfile '%s'"),
 				full_path);
@@ -480,7 +482,7 @@ static int write_midx_oid_lookup(struct hashfile *f,
 				 void *data)
 {
 	struct write_midx_context *ctx = data;
-	unsigned char hash_len = the_hash_algo->rawsz;
+	unsigned char hash_len = ctx->repo->hash_algo->rawsz;
 	struct pack_midx_entry *list = ctx->entries;
 	uint32_t i;
 
@@ -605,7 +607,7 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 	uint32_t *pack_order, base_objects = 0;
 	uint32_t i;
 
-	trace2_region_enter("midx", "midx_pack_order", the_repository);
+	trace2_region_enter("midx", "midx_pack_order", ctx->repo);
 
 	if (ctx->incremental && ctx->base_midx)
 		base_objects = ctx->base_midx->num_objects +
@@ -640,7 +642,7 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
 	}
 	free(data);
 
-	trace2_region_leave("midx", "midx_pack_order", the_repository);
+	trace2_region_leave("midx", "midx_pack_order", ctx->repo);
 
 	return pack_order;
 }
@@ -651,9 +653,10 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
 	struct strbuf buf = STRBUF_INIT;
 	char *tmp_file;
 
-	trace2_region_enter("midx", "write_midx_reverse_index", the_repository);
+	trace2_region_enter("midx", "write_midx_reverse_index", ctx->repo);
 
-	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex(midx_hash));
+	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex_algop(midx_hash,
+								    ctx->repo->hash_algo));
 
 	tmp_file = write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
 					midx_hash, WRITE_REV);
@@ -664,7 +667,7 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
 	strbuf_release(&buf);
 	free(tmp_file);
 
-	trace2_region_leave("midx", "write_midx_reverse_index", the_repository);
+	trace2_region_leave("midx", "write_midx_reverse_index", ctx->repo);
 }
 
 static void prepare_midx_packing_data(struct packing_data *pdata,
@@ -672,10 +675,10 @@ static void prepare_midx_packing_data(struct packing_data *pdata,
 {
 	uint32_t i;
 
-	trace2_region_enter("midx", "prepare_midx_packing_data", the_repository);
+	trace2_region_enter("midx", "prepare_midx_packing_data", ctx->repo);
 
 	memset(pdata, 0, sizeof(struct packing_data));
-	prepare_packing_data(the_repository, pdata);
+	prepare_packing_data(ctx->repo, pdata);
 
 	for (i = 0; i < ctx->entries_nr; i++) {
 		uint32_t pos = ctx->pack_order[i];
@@ -686,7 +689,7 @@ static void prepare_midx_packing_data(struct packing_data *pdata,
 			       ctx->info[ctx->pack_perm[from->pack_int_id]].p);
 	}
 
-	trace2_region_leave("midx", "prepare_midx_packing_data", the_repository);
+	trace2_region_leave("midx", "prepare_midx_packing_data", ctx->repo);
 }
 
 static int add_ref_to_pending(const char *refname, const char *referent UNUSED,
@@ -784,17 +787,16 @@ static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
 	struct rev_info revs;
 	struct bitmap_commit_cb cb = {0};
 
-	trace2_region_enter("midx", "find_commits_for_midx_bitmap",
-			    the_repository);
+	trace2_region_enter("midx", "find_commits_for_midx_bitmap", ctx->repo);
 
 	cb.ctx = ctx;
 
-	repo_init_revisions(the_repository, &revs, NULL);
+	repo_init_revisions(ctx->repo, &revs, NULL);
 	if (refs_snapshot) {
 		read_refs_snapshot(refs_snapshot, &revs);
 	} else {
 		setup_revisions(0, NULL, &revs, NULL);
-		refs_for_each_ref(get_main_ref_store(the_repository),
+		refs_for_each_ref(get_main_ref_store(ctx->repo),
 				  add_ref_to_pending, &revs);
 	}
 
@@ -822,8 +824,7 @@ static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
 
 	release_revisions(&revs);
 
-	trace2_region_leave("midx", "find_commits_for_midx_bitmap",
-			    the_repository);
+	trace2_region_leave("midx", "find_commits_for_midx_bitmap", ctx->repo);
 
 	return cb.commits;
 }
@@ -945,7 +946,7 @@ static int fill_packs_from_midx(struct write_midx_context *ctx,
 			 */
 			if (flags & MIDX_WRITE_REV_INDEX ||
 			    preferred_pack_name) {
-				if (prepare_midx_pack(the_repository, m,
+				if (prepare_midx_pack(ctx->repo, m,
 						      m->num_packs_in_base + i)) {
 					error(_("could not load pack"));
 					return 1;
@@ -1073,6 +1074,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 
 	trace2_region_enter("midx", "write_midx_internal", r);
 
+	ctx.repo = r;
 
 	ctx.incremental = !!(flags & MIDX_WRITE_INCREMENTAL);
 	if (ctx.incremental && (flags & MIDX_WRITE_BITMAP))
@@ -1469,7 +1471,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	}
 
 	if (ctx.m || ctx.base_midx)
-		close_object_store(the_repository->objects);
+		close_object_store(ctx.repo->objects);
 
 	if (commit_lock_file(&lk) < 0)
 		die_errno(_("could not write multi-pack-index"));

-- 
2.47.1

