Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8BE1B14F0
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899883; cv=none; b=ebywRND+IuPtWusfLTk3PfDskOYr5ldx9FMd8ZtUsRZSBMhagSGpZWKNQOCu1a1ZtHoPBYfV1Ae83IRqqf0BWhc0LLNN2Mml/6lHDKhemsjMHif6K+ew9GLVjvOY2o/WiJl33iAzOmoaxUEBK/EoxKcsP0jif2nbJKy0GQCDeUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899883; c=relaxed/simple;
	bh=i1PM/Hf85bQSJIJGyLj6DGXx0mEXkW4barRLG4ILABY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DIULqL6aFMjul4s/Briy1cb/RctHPnYv9mFrKXGMwgzaDycD7Ws189C/KQzNgqnJTkGZJHWrVea3zzDYIinga9zgPWs+T+8ivtQzmKpChGEbCnwARPdf1LnnPO9mhycF7+0UI5Hmuun3HCOFfEbz4a7FO3DikLLrnNLf7MsrxNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWCPpN29; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWCPpN29"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-421b9068274so10769025e9.1
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718899880; x=1719504680; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r27ULTCEwvFugeoXKm1llVa/zbQIYdQH1k6MV9PCSo0=;
        b=YWCPpN29zZOZR5l6XjfHwVA2DBzMph4/nl9cjMd08DGEHlFwTo8Su6BKG6J3un/Ivo
         iOxGY4FwPWc6x6SPCgIQ9FaHD3TBKAMa5FperRR5ZMUCWWMCxgAsLOsQunX4vDuTj2+f
         kMQPFeMEXw3ff6TL4ESrOHgeSNqmsIFF8Shd3yxpBd6aNV0HymAX3nIGdwqr6yvTlVSN
         wfRTof9GTLKmF4W3zILTgKP5pWRHvmaPKHpSmhpqrUe7VtWjcX3Pqol8i+c/7RxUHoAZ
         /G7OWNNOYc7XKHaaxTkMah/tIwYmnvpjdIel7fs31huc27LS5PytVVOVtJxLJ+NzDQS8
         C2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718899880; x=1719504680;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r27ULTCEwvFugeoXKm1llVa/zbQIYdQH1k6MV9PCSo0=;
        b=igG6n738uwWMISW3T0qLXDP+rOrUvnw8VH8tEw2tSee+nhq5tDFHS0XHHzP3oRTwjG
         rVBvIKwAXizW9gOgrf2NHkJ0VIYzk5NyktKsTDbqDEo2s0xZRxm7VlKMbyTu7HbFAU0J
         GHHw7uIC0ktvq3cdPFIit8HbgA6x9P0Lb7p/xNoxxsolCDDgwnu0KJWSnDTZbz1vdwKM
         7pRUHc6YUvmfBRi4DYyw1GgEMGTriHnqq1baYkaxlsWgFofUwzDYxWS6QBHY0lqxRvFO
         9GwWDwwjKOdUbTl1nRxwa3lzaxD4SRbgDs4Z2A0BFvBLpSldnVZ6bZ3rytAPrap71j11
         Js4A==
X-Gm-Message-State: AOJu0Yx+tr2FNFmLDMVZiTSdpn8ViSXIWDDX8A8+fSLmc6lMxz75u8sy
	OTT8rw2Ug5lNPQkn2ufxy5jgPSy/rAGQIJAs7d5v7qNx+0FLYy8DJmHx/Q==
X-Google-Smtp-Source: AGHT+IFjtxR+5O4wQHseuPR1IEF+bD8JJZm5Ce4FJmZ8lxSrP+7LZqA6za6OjTf5dBzfRpBxL0+Rzw==
X-Received: by 2002:a05:600c:257:b0:421:8028:a507 with SMTP id 5b1f17b1804b1-424751842f1mr40971895e9.18.1718899879672;
        Thu, 20 Jun 2024 09:11:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad2c1sm20072261f8f.51.2024.06.20.09.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 09:11:19 -0700 (PDT)
Message-Id: <ddd8a9a90cea10be47eba4775bb90f01a9b80443.1718899877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Jun 2024 16:11:13 +0000
Subject: [PATCH 1/5] sparse-index: refactor skip worktree retry logic
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    newren@gmail.com,
    anh@canva.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The clear_skip_worktree_from_present_files() method was introduced in
af6a51875a (repo_read_index: clear SKIP_WORKTREE bit from files present
in worktree, 2022-01-14) to help cases where the sparse index is enabled
but some paths outside of the sparse-checkout cone also exist on disk.
This operation can be slow as it needs to check path existence in a way
that is not stored in the collapsed index, so caching was introduced in
d79d299352 (Accelerate clear_skip_worktree_from_present_files() by
caching, 2022-01-14).

If users are having trouble with the performance of this operation and
don't care about paths outside of the sparse-checkout cone, they can
disable them using the sparse.expectFilesOutsideOfPatterns config option
introduced in ecc7c8841d (repo_read_index: add config to expect files
outside sparse patterns, 2022-02-25).

Even with that caching, it was noticed that this could take a long time
to execute. 89aaab11a3 (index: add trace2 region for clear skip
worktree, 2022-11-03) introduced trace2 regions to measure this time.
Further, the way the loop repeats itself was slightly confusing and
prone to breakage, so a BUG() statement was added in 8c7abdc596 (index:
raise a bug if the index is materialised more than once, 2022-11-03) to
be sure that the second run of the loop does not hit any sparse trees.

One thing that can be confusing about the current setup is that the
trace2 regions nest and it is not clear that a second loop is running
after the index is expanded. Here is an example of what the regions look
like in a typical case:

| region_enter | ... | label:clear_skip_worktree_from_present_files
| region_enter | ... | ..label:update
| region_leave | ... | ..label:update
| region_enter | ... | ..label:ensure_full_index
| region_enter | ... | ....label:update
| region_leave | ... | ....label:update
| region_leave | ... | ..label:ensure_full_index
| data         | ... | ..sparse_path_count:1
| data         | ... | ..sparse_path_count_full:269538
| region_leave | ... | label:clear_skip_worktree_from_present_files

One thing that is particularly difficult to understand about these
regions is that most of the time is spent between the close of the
ensure_full_index region and the reporting of the end data. This is
because of the restart of the loop being within the same region as the
first iteration of the loop.

This change refactors the method into two separate methods that are
traced separately. This will be more important later when we change
other features of the methods, but for now the only functional change is
the difference in the structure of the trace regions.

After this change, the same telemetry section is split into three
distinct chunks:

| region_enter | ... | label:clear_skip_worktree_from_present_files_sparse
| data         | ... | ..sparse_path_count:1
| region_leave | ... | label:clear_skip_worktree_from_present_files_sparse
| region_enter | ... | label:update
| region_leave | ... | label:update
| region_enter | ... | label:ensure_full_index
| region_enter | ... | ..label:update
| region_leave | ... | ..label:update
| region_leave | ... | label:ensure_full_index
| region_enter | ... | label:clear_skip_worktree_from_present_files_full
| data         | ... | ..full_path_count:269538
| region_leave | ... | label:clear_skip_worktree_from_present_files_full

Here, we see the sparse loop terminating early with its first sparse
path being a sparse directory containing a file. Then, that loop's
region terminates before ensure_full_index begins (in this case, the
cache-tree must also be computed). Then, _after_ the index is expanded,
the full loop begins with its own region.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 sparse-index.c | 77 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 24 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index e48e40cae71..e0457c87fff 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -486,49 +486,78 @@ static int path_found(const char *path, const char **dirname, size_t *dir_len,
 	return 0;
 }
 
-void clear_skip_worktree_from_present_files(struct index_state *istate)
+static int clear_skip_worktree_from_present_files_sparse(struct index_state *istate)
 {
 	const char *last_dirname = NULL;
 	size_t dir_len = 0;
 	int dir_found = 1;
 
-	int i;
-	int path_count[2] = {0, 0};
-	int restarted = 0;
+	int path_count = 0;
+	int to_restart = 0;
 
-	if (!core_apply_sparse_checkout ||
-	    sparse_expect_files_outside_of_patterns)
-		return;
-
-	trace2_region_enter("index", "clear_skip_worktree_from_present_files",
+	trace2_region_enter("index", "clear_skip_worktree_from_present_files_sparse",
 			    istate->repo);
-restart:
-	for (i = 0; i < istate->cache_nr; i++) {
+	for (int i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 
 		if (ce_skip_worktree(ce)) {
-			path_count[restarted]++;
+			path_count++;
 			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
 				if (S_ISSPARSEDIR(ce->ce_mode)) {
-					if (restarted)
-						BUG("ensure-full-index did not fully flatten?");
-					ensure_full_index(istate);
-					restarted = 1;
-					goto restart;
+					to_restart = 1;
+					break;
 				}
 				ce->ce_flags &= ~CE_SKIP_WORKTREE;
 			}
 		}
 	}
 
-	if (path_count[0])
-		trace2_data_intmax("index", istate->repo,
-				   "sparse_path_count", path_count[0]);
-	if (restarted)
-		trace2_data_intmax("index", istate->repo,
-				   "sparse_path_count_full", path_count[1]);
-	trace2_region_leave("index", "clear_skip_worktree_from_present_files",
+	trace2_data_intmax("index", istate->repo,
+			   "sparse_path_count", path_count);
+	trace2_region_leave("index", "clear_skip_worktree_from_present_files_sparse",
+			    istate->repo);
+	return to_restart;
+}
+
+static void clear_skip_worktree_from_present_files_full(struct index_state *istate)
+{
+	const char *last_dirname = NULL;
+	size_t dir_len = 0;
+	int dir_found = 1;
+
+	int path_count = 0;
+
+	trace2_region_enter("index", "clear_skip_worktree_from_present_files_full",
 			    istate->repo);
+	for (int i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
+
+		if (S_ISSPARSEDIR(ce->ce_mode))
+			BUG("ensure-full-index did not fully flatten?");
+
+		if (ce_skip_worktree(ce)) {
+			path_count++;
+			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found))
+				ce->ce_flags &= ~CE_SKIP_WORKTREE;
+		}
+	}
+
+	trace2_data_intmax("index", istate->repo,
+			   "full_path_count", path_count);
+	trace2_region_leave("index", "clear_skip_worktree_from_present_files_full",
+			    istate->repo);
+}
+
+void clear_skip_worktree_from_present_files(struct index_state *istate)
+{
+	if (!core_apply_sparse_checkout ||
+	    sparse_expect_files_outside_of_patterns)
+		return;
+
+	if (clear_skip_worktree_from_present_files_sparse(istate)) {
+		ensure_full_index(istate);
+		clear_skip_worktree_from_present_files_full(istate);
+	}
 }
 
 /*
-- 
gitgitgadget

