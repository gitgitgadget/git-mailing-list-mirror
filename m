Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C4F1D042D
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031184; cv=none; b=LgQ3bJehqGzSRYg3FaWtFULJ7c4wfwxjsrcxUya49vYcPeFuDkUaGE1DQReNhhopYTgeejHsjG84nJ5+JaFt1Bkr5/eWRK+51A9ICwgp2bbUZST+7/tDqsib6BYpdKjBw+76U2GdeLM+9CDkzFPwSED0JlExMHcxOFNbOriAASE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031184; c=relaxed/simple;
	bh=lQkwBZ3BUESBQ0IP0ctoA3UscK/gu30YNZWXDOpP2S0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=He1hEq5/x5W+hoTqzNXNrcMnrOUc8DqRnE+JqvBF6z2a7YFGUn93YRgD3ampYepBzal69sPfJO8o4+Vy+AqE8us1wwpGE5jkSid8A4cth5d41StGySCOP3S4WnU5uWt6ShZCKLq6w1nail8dXl8gsYoHXIj1u7X6Su12zE5+urc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwNkFiZq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwNkFiZq"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so9809185e9.3
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 07:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732031181; x=1732635981; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGnJJ5LpD9+Gdx/vWsZvUv4z5njsYrPhy3XbG3d5wcs=;
        b=LwNkFiZqeZQq4AiOJmsAJ2TiYS/WF4Pe5rOxBS1jPpUr11DZ4OGzTEWnP7AKzvRSqT
         BaS/IDBuku36Ph/nDyS2tgFGfxV7m8pYUy0Z000XAm3vpHEpNLJNtm19m2wu89Hmm5x2
         V3RPJBaT7wVzsHJ34f14H8d4COWm5j2Elp057vy9zyrcLGf/6Yf55L3FayF/2D+g3a+w
         tzMJ6I90qhhvwgoRhSpN1hndGD6aMaghHLnaePIJ6TuV9ike+ic36RxBmtQvfggSRr/3
         /TUPJlj0+Jg/HpipVsiDulV+EmMBK5IKXYrSIpa6bJwkNJ4fzyghOv4z68xsClk0Jhdb
         Yq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732031181; x=1732635981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGnJJ5LpD9+Gdx/vWsZvUv4z5njsYrPhy3XbG3d5wcs=;
        b=T7+qmjAXc6hbgAH2oZcAW68yGZpDTt279yxx+OaWCWYgx1eNwgpqYdhNr2Kk22LT3v
         Y1/tXQm520AaBT0aX/SeC0+OhMXuUMYPgFOnSdK2elXK0eLJw0GPIAar7HS8B6zVdeUZ
         LbkulzBgSqKTgtqSCUs1jSaW4QI1de26IggjNsXZVRVUvi63bMWS6k2dE+QSaeOPbtXz
         FC2Z7NXFDVS2wMzeI9eYpvibe9W38aPi6+usq+U/06s0IEbxbXMvLG8Wy64Aqm9mm5iZ
         ggQTuBBqUSJim6oI0nMjnz/ociGraXyvXqhjJhacvQSgBsbbJm2MGuzAXp9SO/8GjNVG
         pDCw==
X-Gm-Message-State: AOJu0YwVMt0NpJWWQOfg95FPmejlcgx/jkSs0VuTM21DttJF61xiqjPK
	78ee0fliQmz60495+vQdDtCkDnXsIVBBfuVGr6gKjZXwp73xwPytCfNla5Vf
X-Google-Smtp-Source: AGHT+IF+nv3kS94A8oBEXzi6sl0aYBNMrbQ3i+y4eLY3m4rmrLWEgSF1FcxOGD37JhrgG7IMuEQqmg==
X-Received: by 2002:a17:906:fd88:b0:a9a:55dd:bc23 with SMTP id a640c23a62f3a-aa4833f6558mr1419332966b.8.1732030621886;
        Tue, 19 Nov 2024 07:37:01 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df4e7bfsm661900566b.42.2024.11.19.07.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:37:01 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 19 Nov 2024 16:36:43 +0100
Subject: [PATCH v2 04/10] write-midx: add repository field to
 `write_midx_context`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-4-e2f607174efc@gmail.com>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
In-Reply-To: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, shejialuo@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6085; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=lQkwBZ3BUESBQ0IP0ctoA3UscK/gu30YNZWXDOpP2S0=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnPLCYqAv9cYhVWrwYPcg82/Xd20ina4iQQscpE
 xVkELHmsbSJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZzywmAAKCRA+1Z8kjkaM
 fz3ZDACMfhukitNfz6YP7DIjxjHQLqW/iXhWt+3dXTKZIexI2DOpu3NuTn3CB4XvtYO2vQ+z86j
 brwPXeI/nMDLjaA6FvgkFFFnhfGLIzNOEMuKdGMfJ+2l0USt44hXLqc2TO8bvcTlUWUD15FnOmA
 Z8+VsnZDOu07tcTVRwZRCDJhkm4kQ5c1lpnrXBbq7cNfiArIs8Ls9ezj0UVitCuMylP1ginG1J+
 9ExtWFw5vYByHNWtI8lbljL09rs6ceLyqlqgdZpAu42dx/EUkA3tK2DUSeBmmcgOrxq9S+MUqHl
 8PKpdn2SgFGASwBwVLt509wnAlpiwO6d9ky+Gc1uajD2lvgzPfnBfrv86IFIojLvAw5IkuJiPBz
 yYbaQRRbykel3DfPGIHzvwpmFjml2YLYJXj31sgI1OqMTH6Ngr/6PfYUwlmmjL/R/gHE5Zz8Jg9
 243f3I4TK7qJHoJSAuS0Yy/HcCAMyIm8Nl16Vn31aKpeAJNVW+ChwQ4N/1skngemhjDjw=
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
2.47.0

