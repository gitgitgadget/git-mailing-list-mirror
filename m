Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FEA15572B
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 12:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578613; cv=none; b=bEQJtqa876MIZnQzTIyz25eKxJGSnudc9/MrCqWcQPFp0x/gioGx7LX74EL2/gWC9pktB23bf4nIU+f3dHhYTJXbxegWvTlr76Z1sp9UwJcZiM+7KioAOy/65BrRHGL4yjRoHDDDo2Lgw/HwnMLAtBNtBw2cd42wntMMqSZ7xBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578613; c=relaxed/simple;
	bh=1+YfJ3KeIDNMytgJhgLc/jzlPo48qZI+007fZd8EAuE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XSCdILB5SbHLsnEJ3x+hIy9Hat8Us5BycujKzUPUOB6hjfYtJ7ma+ogywm6F2Epp4Z61b9XNYeaFKkF2JJyx+cbtvoLbGvlXxJxowEEO8XMfWOEgNksDk5dMsvHbp5KLtavk0Wn6hAaMPmixcMYDe6AaMAyPINadrAepYUwEkz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuKU5m4z; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuKU5m4z"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42565cdf99cso5761635e9.3
        for <git@vger.kernel.org>; Fri, 28 Jun 2024 05:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719578608; x=1720183408; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR8mOzRt4TH4V8VXf39UAZ4aSlUBCBjfZL+B2dW2tgw=;
        b=JuKU5m4zVsSRIE1tMFe5pN/00uTYtUk9leakxXrIxvaJp4Ms37Vl3KWgsuDdIYK7TF
         fGI8r8tjFGWNMlSbsscxxqedQ5SCgqNeL+XqZkD8GsVuW6Xe1wPedHlVul7+kpjTg7x4
         JOt02IAwtb7Az9RqpXZB3KCZD9zuZGDZMhXiAPVlrL2S10A4nNMnxB89KWcboxIxLbKk
         dKhZ4cfamuUWkVlWqccUUyPCYKq7IvK64UqoU0/CQ94CidU1fYUWQXsiInoWpE+6QTSJ
         3kOCZo4KZ/HZPftTDPVMcuAQzgIj1+bmPN+69bTsAMe+lgED+Y6mYkDrtD0yx6dERGSu
         kZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719578608; x=1720183408;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CR8mOzRt4TH4V8VXf39UAZ4aSlUBCBjfZL+B2dW2tgw=;
        b=BFmNsFskwwtrdPd98W+Z9LrtDk0YPgARmlGqRHp2PB5K3yR4DfE+GF9BuTDnBLEGXu
         sowcQ/uTQxzWrQ1zlRgn50nAyuOzqEVoQWI0weCsgQ1VEvhmBZro5yDPPVEQ5d7E21eX
         O16B9A7tvJGxoWc6yI+Rgh6p70HDpJT4SBB7eqQ8YS4Zj3/Dc5GAw7BUIvwGMN2aADu/
         atuYrRTLzvG+xOFpn655KNapoCiMysWqO/rQYxEAnAOQgqnjEyMv5yzt21tmk/KqbBHG
         zu3J0z2DXxT9PfGCaGmTVKQSyGW5pE8RkpgWJOWGp3kREPZrKiJEaea7P+IopFGky/Gm
         m8rQ==
X-Gm-Message-State: AOJu0YxT0FTlOCcwEwMjz2evvOwsn/0f+PLTAmVpw4ghH51i6iaTawVd
	WvVSk3ToLApK1qENcH47h9nuwhXHwaAn4Vc00gc0ZxV81eEQKYyfPtas2w==
X-Google-Smtp-Source: AGHT+IGUW21Yq3dC1x9y4W9MP9Z3EB2E/x4ghEmCgiBnzOVYBJ2GWrPZg4761E5+oBrO9UevwGZSyw==
X-Received: by 2002:a1c:7716:0:b0:425:64c5:5780 with SMTP id 5b1f17b1804b1-42564c55995mr44681205e9.1.1719578608268;
        Fri, 28 Jun 2024 05:43:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b065316sm33392575e9.26.2024.06.28.05.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 05:43:27 -0700 (PDT)
Message-Id: <0844cda94cffd76ea9e86a0837731cfb4dc7bf88.1719578605.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1754.v3.git.1719578605.gitgitgadget@gmail.com>
References: <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
	<pull.1754.v3.git.1719578605.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Jun 2024 12:43:21 +0000
Subject: [PATCH v3 1/5] sparse-checkout: refactor skip worktree retry logic
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
in worktree, 2022-01-14) to help cases where sparse-checkout is enabled
but some paths outside of the sparse-checkout also exist on disk.  This
operation can be slow as it needs to check path existence in a way not
stored in the index, so caching was introduced in d79d299352 (Accelerate
clear_skip_worktree_from_present_files() by caching, 2022-01-14).

This check is particularly confusing in the presence of a sparse index,
as a sparse tree entry corresponding to an existing directory must first
be expanded to a full index before examining the paths within. This is
currently implemented using a 'goto' and a boolean variable to ensure we
restart only once.

Even with that caching, it was noticed that this could take a long time
to execute. 89aaab11a3 (index: add trace2 region for clear skip
worktree, 2022-11-03) introduced trace2 regions to measure this time.
Further, the way the loop repeats itself was slightly confusing and
prone to breakage, so a BUG() statement was added in 8c7abdc596 (index:
raise a bug if the index is materialised more than once, 2022-11-03) to
be sure that the second run of the loop does not hit any sparse trees.

One thing that can be confusing about the current setup is that the
trace2 regions nest and it is not clear that a second loop is running
after a sparse index is expanded. Here is an example of what the regions
look like in a typical case:

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

