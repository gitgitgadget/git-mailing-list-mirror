Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312191B971
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813717; cv=none; b=DIG/kcopUwQ0R+pHXgxqamt1tzJg/xoKWxaqq33pO1uh7rpe0pTgPAGZHgufbXvrfh/PpmhI0H1ksxmAw+wdtrMMxs1Onx+olheXY4C2KJ+nyTkeZTD3nsey3kdEJvgt6UXNdij03w80crnYymMBwZpsqkWav6clMFh8MI8zYFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813717; c=relaxed/simple;
	bh=T4wW6Y17tbP4C1Ce/RItUq+t2VELXKk1LuDe+jotUkw=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=C+5PiBioAMCQND7Tz5SL5XG4eQwTrUD1tP/0TX4N46dzFaqjyQsJgvfNvDx7wT+sOFStN+Ue4rF6wFOohkwestoJRWDaylsUcG2dwtVPIgUu4LGqIxyxPGPHXyyC+4BJy99vp3PVMFLTqLJKr2DTBSEAmZmMM/zhtIOcifozLbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTwvghYi; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTwvghYi"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33b2960ff60so2885025f8f.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 00:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707813714; x=1708418514; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8T6cpIjJ3ZlgRyQ8CNL6hcHKBuljhhivRQn7Yl+KJwk=;
        b=KTwvghYiujryK8DBu+pxYWuTVUm3v+7NZjPgDhKJ254hmW4NLxYgCkQbPNrmHH2Pwv
         Tu/rQmV91iEUf1mAmVU1OvI8hE+ZtqaKv82qST7n6LwgOKaFMXJ96Ww2opcCTL7YGtrZ
         QrojiE9T47M5SRNq9E4XEhat7z29QVYRRm5+AvW19wIjbWu4eYrft2WqGK1tBCLwOwiu
         BmcA0RafS587rjMtStfxOc+rJ6/HPlHG/A/W0o6XMNNUok3ztr3mfD0EJ8z6KEmexi1P
         t4rAv+PLUjxWG7AsnC/jg/HDc7yroGCOR8PU4F6Ca9ZyCJRQ+4bSGiQ7pbzh2vrFyOW1
         wcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707813714; x=1708418514;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8T6cpIjJ3ZlgRyQ8CNL6hcHKBuljhhivRQn7Yl+KJwk=;
        b=WTUM23fCvOrPpBOa1q1xFbhDW2wjZLn0NZbS3vhVYosI9Lt6KPJnz3GwcrH3Kqx4zz
         RkCWuLfXyxXzxyEFHi8o7rjdl0MnMJ2GZPhmegKz2pnq2EHsv+YEZCpirk8vmrmT4b3C
         HTZ+CDvbfHjda3lQyo1sauYmd5GRBVI62lRA7zN689qovCzHyJqvytzc9caoDWp6Zvdn
         X6mEd+X4HV20tRB875mMiF1WhDcUYNzujg89hu/F2mJM+UV2eUmztzXHnymJAW0JMndw
         0q9oiKaz2AoCrRTHGStuxVvEXf3uzFs9ilk3MZa0FHhPluYjEcQH23DEPGTrSnDFwvp8
         BsLw==
X-Gm-Message-State: AOJu0YzDjbBvlSUsYK92kR18ZzE5aKPjRqclHERr0cFrLN370azJlZ+Y
	uAStz82FZQy94uNkPgD/rBe0xUMaq7/PJb7FBaabHB6A+B7/DIohYb5/uiRn
X-Google-Smtp-Source: AGHT+IE4zTvpJ20u8eH24HvS1hzPR0ylcmwx3Cl5yenFL/dX3q8ZNp/5w0kULSDmUisy6LI/uqrRYw==
X-Received: by 2002:a05:6000:114a:b0:33a:f503:30b3 with SMTP id d10-20020a056000114a00b0033af50330b3mr1293850wrx.24.1707813714121;
        Tue, 13 Feb 2024 00:41:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q17-20020a5d61d1000000b0033940016d6esm8858362wrv.93.2024.02.13.00.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 00:41:53 -0800 (PST)
Message-ID: <f8aedb89f1ca5973a6565dc57af7b6c658b0b44f.1707813709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 08:41:41 +0000
Subject: [PATCH 05/12] commit-reach: start reporting errors in
 `paint_down_to_common()`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

If a commit cannot be parsed, it is currently ignored when looking for
merge bases. That's undesirable as the operation can pretend success in
a corrupt repository, even though the command should fail with an error
message.

Let's start at the bottom of the stack by teaching the
`paint_down_to_common()` function to return an `int`: if negative, it
indicates fatal error, if 0 success.

This requires a couple of callers to be adjusted accordingly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit-reach.c | 56 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 1d1d8c989de..dafe117036b 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -50,14 +50,14 @@ static int queue_has_nonstale(struct prio_queue *queue)
 }
 
 /* all input commits in one and twos[] must have been parsed! */
-static struct commit_list *paint_down_to_common(struct repository *r,
-						struct commit *one, int n,
-						struct commit **twos,
-						timestamp_t min_generation,
-						int ignore_missing_commits)
+static int paint_down_to_common(struct repository *r,
+				struct commit *one, int n,
+				struct commit **twos,
+				timestamp_t min_generation,
+				int ignore_missing_commits,
+				struct commit_list **result)
 {
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
-	struct commit_list *result = NULL;
 	int i;
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 
@@ -66,8 +66,8 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 
 	one->object.flags |= PARENT1;
 	if (!n) {
-		commit_list_append(one, &result);
-		return result;
+		commit_list_append(one, result);
+		return 0;
 	}
 	prio_queue_put(&queue, one);
 
@@ -95,7 +95,7 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 		if (flags == (PARENT1 | PARENT2)) {
 			if (!(commit->object.flags & RESULT)) {
 				commit->object.flags |= RESULT;
-				commit_list_insert_by_date(commit, &result);
+				commit_list_insert_by_date(commit, result);
 			}
 			/* Mark parents of a found merge stale */
 			flags |= STALE;
@@ -114,8 +114,11 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 				 * corrupt commits would already have been
 				 * dispatched with a `die()`.
 				 */
-				free_commit_list(result);
-				return NULL;
+				free_commit_list(*result);
+				if (ignore_missing_commits)
+					return 0;
+				return error(_("could not parse commit %s"),
+					     oid_to_hex(&p->object.oid));
 			}
 			p->object.flags |= flags;
 			prio_queue_put(&queue, p);
@@ -123,7 +126,7 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 	}
 
 	clear_prio_queue(&queue);
-	return result;
+	return 0;
 }
 
 static struct commit_list *merge_bases_many(struct repository *r,
@@ -150,7 +153,8 @@ static struct commit_list *merge_bases_many(struct repository *r,
 			return NULL;
 	}
 
-	list = paint_down_to_common(r, one, n, twos, 0, 0);
+	if (paint_down_to_common(r, one, n, twos, 0, 0, &list) < 0)
+		return NULL;
 
 	while (list) {
 		struct commit *commit = pop_commit(&list);
@@ -204,7 +208,7 @@ static int remove_redundant_no_gen(struct repository *r,
 	for (i = 0; i < cnt; i++)
 		repo_parse_commit(r, array[i]);
 	for (i = 0; i < cnt; i++) {
-		struct commit_list *common;
+		struct commit_list *common = NULL;
 		timestamp_t min_generation = commit_graph_generation(array[i]);
 
 		if (redundant[i])
@@ -220,8 +224,9 @@ static int remove_redundant_no_gen(struct repository *r,
 			if (curr_generation < min_generation)
 				min_generation = curr_generation;
 		}
-		common = paint_down_to_common(r, array[i], filled,
-					      work, min_generation, 0);
+		if (paint_down_to_common(r, array[i], filled,
+					 work, min_generation, 0, &common))
+			return -1;
 		if (array[i]->object.flags & PARENT2)
 			redundant[i] = 1;
 		for (j = 0; j < filled; j++)
@@ -421,6 +426,10 @@ static struct commit_list *get_merge_bases_many_0(struct repository *r,
 	clear_commit_marks_many(n, twos, all_flags);
 
 	cnt = remove_redundant(r, rslt, cnt);
+	if (cnt < 0) {
+		free(rslt);
+		return NULL;
+	}
 	result = NULL;
 	for (i = 0; i < cnt; i++)
 		commit_list_insert_by_date(rslt[i], &result);
@@ -490,7 +499,7 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 			     int nr_reference, struct commit **reference,
 			     int ignore_missing_commits)
 {
-	struct commit_list *bases;
+	struct commit_list *bases = NULL;
 	int ret = 0, i;
 	timestamp_t generation, max_generation = GENERATION_NUMBER_ZERO;
 
@@ -509,10 +518,11 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 	if (generation > max_generation)
 		return ret;
 
-	bases = paint_down_to_common(r, commit,
-				     nr_reference, reference,
-				     generation, ignore_missing_commits);
-	if (commit->object.flags & PARENT2)
+	if (paint_down_to_common(r, commit,
+				 nr_reference, reference,
+				 generation, ignore_missing_commits, &bases))
+		ret = -1;
+	else if (commit->object.flags & PARENT2)
 		ret = 1;
 	clear_commit_marks(commit, all_flags);
 	clear_commit_marks_many(nr_reference, reference, all_flags);
@@ -565,6 +575,10 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 		}
 	}
 	num_head = remove_redundant(the_repository, array, num_head);
+	if (num_head < 0) {
+		free(array);
+		return NULL;
+	}
 	for (i = 0; i < num_head; i++)
 		tail = &commit_list_insert(array[i], tail)->next;
 	free(array);
-- 
gitgitgadget

