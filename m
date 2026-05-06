Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79573B7751
	for <git@vger.kernel.org>; Wed,  6 May 2026 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778107417; cv=none; b=FygL0SJ/f+bWEpD7G+Y7GlxrP68cmruFGrgjInyCVVPuI6WGaxuubkQm2Fl/MntIMj2v9z/Xl9Z4XtPt9H+x7Zh9Mtpqh76dZvRX/mNLSKxwd3wjNFPTSXZUTMtr+SNegf+D+3PjJRILLqI12S0ImiNoyADrTqZi8++2ropxxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778107417; c=relaxed/simple;
	bh=PO1WkobNUJw2pPygLsKFI7SYnCygj48LA1Oeg7s0DT4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=F0g8MdwPptHJEVfk7UFoKoPQJNcVzqjoM8V8/5y7pr1sLUQCw73HYnelEIlomfYkk5G93xk3PG138XsjopL9cZfWNph1VQUDbAwBcE5gaoKV5Astt9nTwyvXewO2f+h0NRvFiXIEfEhp1wwIp93UU9ZXS1Bi2cKqmcrclDBBi4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qx5DB0Fc; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qx5DB0Fc"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c8ccc7755so460425c88.0
        for <git@vger.kernel.org>; Wed, 06 May 2026 15:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778107410; x=1778712210; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84+HlvGMGgtaM2x7Nivg4hwEb9dZ5IXZkJhvCLYlGYE=;
        b=qx5DB0FcWqviBDUKO9KvFXkrxG8caU+DeoCTCPWzVSj7Uy5xq/hFu083xnWFLcrAK/
         wFDSpVCBPo/FF6E51hynlSUvfqx3CD/wKjCBN6jFbdkK4Mrxg91zHRj0tH9vkmYHK3EY
         9zflfreB9jFKVLbLX2Enykx4dwQjIZ+1b8J25sFlt26nEPsBrdB7F7lNKS4pcYNA14nI
         +TOQM712lW8Af3qjauearIW1pE5Rs9EjyEBvjqgk4AkhjvydC4SHigPlk4biofjdnmY/
         XSm50aGZk198w0ljFEZJAb9IvM6MiMSsPSdt358vSf/wwJCkhmlYnxwGpZH9CkVQIGCf
         LrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778107410; x=1778712210;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=84+HlvGMGgtaM2x7Nivg4hwEb9dZ5IXZkJhvCLYlGYE=;
        b=ZnMvf++7T9OTicgxm7TqDdl3CTsqu+LyChLAdoosIFpDOMKGjd1OWJBAATXT+ygkxu
         negwv01RJn/SVwKepIEgvQl6buSgIb+HgIbMWWtqQf6mItR+KJq777piki91NNk08ld1
         J2mQa2ivioMDsUeWcYP3Dq9WdwQ2OJFrXcV+q1Z9DMLMPivLDusmiN7m8QrrGxakhnDc
         +V/JmM+3jwnaOqKq0qxlrb7XJEVf7Thr65PxtjyCJI6Uqi0FUClVq901xtTvrp+Kzzih
         eEqTGqY8LALcOQ+4R5P3O62v3MjwoY/kzc6r/zYx+78xc7726vbPdo+lMdXvaMyhKJOw
         Plxg==
X-Gm-Message-State: AOJu0YwOnTLJ3f/7WBPB2kbbPjDiyKxBbkfzNK5MN07rEeXRM1+bxBoh
	u13WrsvSzqcPpKlFMcS6RRfmYUh+IfInT5M/wJU2/mqxRPj6RO2ZWzdNwuthmw==
X-Gm-Gg: AeBDietUxrfqkNBiM8ZYfkOJV0OGPasfGINlcytG1cFgy4PucqxHwq77PhyNwnxJHKf
	QTPz3sqMv5g+QLfNXRxr4kzc2RWC7F6NHewvdAMLjS7ttM8A+2TGObkzku5O3uk1nN9xPQTArth
	Cx4ZSM/KOaTy0CNFX0Bzzhc4p+xpuqMBvOTsW5hSY8W4VLEXNl0kMV9Kyc8jdewJWPMTeIBhwtP
	ZZY/Kye35kTSaPpMc8BHDSGmHrmBcO9RHS8qQy9RRaxC4LzxM1YQR3mq+mtMtvpKB0+QhXmXOtE
	0FfawuQR3hpXjMsxDhAd8VIllzalD7xFCtU2H+JYdmBUp7RvWTUtCp0sNLY5hrZvu2RFhxTs4Lf
	+nW5TeC82qUjF7yn3IV5AtDWmmxdKLUdyMh0KL3fbYrKX6BCZ4koEBwhZl7/2wskNlLXhDlgqtW
	eGLJI3TvR96wrZ+Bzv0yCU+B8u4voAgIM8kQ76CyplNGyNB2eU
X-Received: by 2002:a05:7022:221a:b0:130:6c8f:5aae with SMTP id a92af1059eb24-131851d7d20mr3303414c88.14.1778107409445;
        Wed, 06 May 2026 15:43:29 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.225.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1321e00e146sm3486938c88.0.2026.05.06.15.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 15:43:28 -0700 (PDT)
Message-Id: <2f3d696104f7f634e2ca3bb51d57d5c57ffb0bbd.1778107405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2106.git.1778107405.gitgitgadget@gmail.com>
References: <pull.2106.git.1778107405.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 06 May 2026 22:43:21 +0000
Subject: [PATCH/RFC 2/5] replay: short-circuit merge replay when parent and
 base trees are unchanged
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
Cc: Elijah Newren <newren@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

For the common `git history reword` case the rewrite changes only
commit messages, so every commit on the line being replayed has the
same tree as before. When such a rewrite reaches a 2-parent merge
whose rewritten parents AND merge bases all carry the same trees as
the originals, the inner auto-merge of the rewritten parents (N) is
tree-equal to the inner auto-merge of the original parents (R), and
the outer 3-way merge with R as the merge base, the original merge
tree as side 1 and N as side 2 yields the original tree as result.

Detect this in `pick_merge_commit()` before doing any merge work and
write the new merge commit directly with the original tree and the
rewritten parents. This saves two recursive merges and one
non-recursive merge per merge commit on the rewrite path, which
dominates the cost of `git history reword` across histories with
many merges.

The merge-base trees must be checked too, in order. Tree-same
parents over a tree-different base could still produce a different
auto-merge (a conflict region that did not exist before, or vice
versa), and the original resolution would be inappropriate to apply.

To avoid recomputing the merge bases when the fast path does not
apply, both pairs are computed up front and the slow path that
follows reuses them.

Assisted-by: Claude Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 replay.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/replay.c b/replay.c
index 3dbce095f9..5dfdef1447 100644
--- a/replay.c
+++ b/replay.c
@@ -396,6 +396,64 @@ static struct commit *pick_merge_commit(struct repository *repo,
 	replayed_par1 = mapped_commit(replayed_commits, parent1, parent1);
 	replayed_par2 = mapped_commit(replayed_commits, parent2, parent2);
 
+	/*
+	 * Compute both pairs of merge bases up front. The fast path below
+	 * needs them for the tree-equality check, and the slow path that
+	 * follows reuses them to avoid recomputing.
+	 */
+	if (repo_get_merge_bases(repo, parent1, parent2, &parent_bases) < 0 ||
+	    repo_get_merge_bases(repo, replayed_par1, replayed_par2,
+				 &replayed_bases) < 0) {
+		result->clean = -1;
+		goto out;
+	}
+
+	/*
+	 * Fast path: when both rewritten parents carry the same trees as
+	 * the originals AND every merge base does too (in order), the
+	 * auto-merges R and N would be tree-equal (their inputs match
+	 * content-wise), so the outer 3-way merge trivially yields the
+	 * original merge's tree. Skip the inner merges and write the new
+	 * merge commit directly.
+	 *
+	 * This is the common case for `git history reword`, which only
+	 * changes commit messages and so leaves every tree on the line
+	 * being replayed unchanged. The merge-base trees must be checked
+	 * too: tree-same parents over a tree-different base could still
+	 * produce a different auto-merge (a conflict region that did not
+	 * exist before, or vice versa), and the original resolution would
+	 * be inappropriate.
+	 */
+	if (oideq(&repo_get_commit_tree(repo, parent1)->object.oid,
+		  &repo_get_commit_tree(repo, replayed_par1)->object.oid) &&
+	    oideq(&repo_get_commit_tree(repo, parent2)->object.oid,
+		  &repo_get_commit_tree(repo, replayed_par2)->object.oid)) {
+		struct commit_list *bo, *bn;
+		int bases_match = 1;
+
+		for (bo = parent_bases, bn = replayed_bases;
+		     bo && bn;
+		     bo = bo->next, bn = bn->next) {
+			if (!oideq(&repo_get_commit_tree(repo, bo->item)->object.oid,
+				   &repo_get_commit_tree(repo, bn->item)->object.oid)) {
+				bases_match = 0;
+				break;
+			}
+		}
+		if (bo || bn)
+			bases_match = 0;
+
+		if (bases_match) {
+			pickme_tree = repo_get_commit_tree(repo, pickme);
+			parents = NULL;
+			commit_list_insert(replayed_par2, &parents);
+			commit_list_insert(replayed_par1, &parents);
+			picked = create_commit(repo, pickme_tree, pickme,
+					       parents, REPLAY_MODE_PICK);
+			goto out;
+		}
+	}
+
 	/*
 	 * R: auto-remerge of the original parents.
 	 *
@@ -408,10 +466,6 @@ static struct commit *pick_merge_commit(struct repository *repo,
 	remerge_opt.show_rename_progress = 0;
 	remerge_opt.branch1 = "ours";
 	remerge_opt.branch2 = "theirs";
-	if (repo_get_merge_bases(repo, parent1, parent2, &parent_bases) < 0) {
-		result->clean = -1;
-		goto out;
-	}
 	merge_incore_recursive(&remerge_opt, parent_bases,
 			       parent1, parent2, &remerge_res);
 	parent_bases = NULL; /* consumed by merge_incore_recursive */
@@ -425,11 +479,6 @@ static struct commit *pick_merge_commit(struct repository *repo,
 	new_merge_opt.show_rename_progress = 0;
 	new_merge_opt.branch1 = "ours";
 	new_merge_opt.branch2 = "theirs";
-	if (repo_get_merge_bases(repo, replayed_par1, replayed_par2,
-				 &replayed_bases) < 0) {
-		result->clean = -1;
-		goto out;
-	}
 	merge_incore_recursive(&new_merge_opt, replayed_bases,
 			       replayed_par1, replayed_par2, &new_merge_res);
 	replayed_bases = NULL; /* consumed by merge_incore_recursive */
-- 
gitgitgadget

