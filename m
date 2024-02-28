Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC90C36B0E
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113469; cv=none; b=JZ4AZsaG9VfocG/MEgq+922MX4I8fd0wLRPNtUV5p8uRflYuae3S7lNEWh/vLabPJQjAsSK5pjIPYm9LwXT2/tOCa1tbvHCVzBMXXUeaOiuHz+WTBbbbHDwm+bTt93lV4G+MzY2ucft/IuTyU3u2S/cK8xrFFCJpaHpdKQLvVjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113469; c=relaxed/simple;
	bh=51ySa4HRTmbfzAx+3m0FkYsYG9NeqXVV2Gt2Q7BiPDk=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iOohPwk9RCLnURbaRLdiTTII7JBVMRkWqlj+pC5NFDFO7Wn2HD1RJSIYKgEyxfooJl5xSEIRbXGmhZ0ei7jcxrm/x9ksgsMuaGtNSnfUoC1oq74MQ+jLN45K4saAze/LrQl5IHzkkLR+V3himy3NUU3AelTZ6rwyhlpghjFVqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4WgLdBV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4WgLdBV"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412a588c8b4so21014935e9.0
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 01:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709113466; x=1709718266; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkhpT+ucp6WzLyC55CcklHZz3GJAYR7x1HfXvhtUwr8=;
        b=D4WgLdBVqgQCH4OIJHLBiBg4TOT45CeVqp4WJR0Jh6m2PSYB/KQFozWKSl5R8uKl3w
         3SNBjoztBTDxFP2Eu/ZMo/VGA8dr6g4szko3cGdis5gKabz0OCjUO3tHB2hUUx5Zvm7P
         jp0TOTUEbuyZpBmmD+3lB2cXIAWpW6VxaykoHyn8Xmz/eaG8xofmRepmR3vHCdZslrs8
         b2VgFjjh1SbPkh6piOPK1NfM+GBtFkdTlFi2b1jQy/ZDC6kcsRSUvWh+cgG9lsMv7FMR
         8dJ20fZilacbSqHysDqJFy5gHFugh1hCuUhOCUJMUqJM8BsBhb27WtFUlEQHIectSgkr
         t2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709113466; x=1709718266;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkhpT+ucp6WzLyC55CcklHZz3GJAYR7x1HfXvhtUwr8=;
        b=LmTc3hzlQcXiReTv3X9HUyEnGnSftSjx0dvg/7XnPq+o5MsL3+Gg438i4PIOMOzVLb
         D9Di5uvrPZSwKkzVdKnlkWgZUs+yprI6NwAYNGvyL9iiBtOfeGui41eosgg3sr33Br+H
         hieHkPoYYtrBui1Hn6a+bcOI6/0NOqSuakecGejdB8Ingpkb1sWaYqi6kTgsd5LoBw2j
         E6u+96QVANjCD3MBOEso5wbej6+TYCwdcqSYZ5w4E2xc4/f9S0Cx4d+9NV+hpCRpq5X8
         IJnNFQdMPDA6wPdnI0TBbt7wPUsSjtnCDaU7yk9TG1FtQEI2TQ79yaeCrnZ5h2gyRMKf
         sRSQ==
X-Gm-Message-State: AOJu0YzkbbF8c3gxeTQju5HxMjAUedb1J+7Ii90eXiJV/ogdiOnzKg0Z
	S+tGFyHIApshVAEhyKiD4J0IwCcjTd3pq3at2c9GX9xhksGE4lOhX2mrvZMV
X-Google-Smtp-Source: AGHT+IH1vdXONk8zosf8Rmf9uQTNV2l67xPFkBlLQgvdT4mgklSm4k624zvBZ48MXqsyiNXg94Z+zw==
X-Received: by 2002:a5d:4fcf:0:b0:33d:2710:b424 with SMTP id h15-20020a5d4fcf000000b0033d2710b424mr8725966wrw.22.1709113465937;
        Wed, 28 Feb 2024 01:44:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q1-20020adffec1000000b0033cf80ad6f5sm13898814wrs.60.2024.02.28.01.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:44:25 -0800 (PST)
Message-ID: <b978b5d233a3ccc4f498f9e7d48fae0ce651db49.1709113458.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>
References: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
	<pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 28 Feb 2024 09:44:11 +0000
Subject: [PATCH v4 05/11] commit-reach(paint_down_to_common): start reporting
 errors
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Dirk Gouders <dirk@gouders.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
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
 commit-reach.c | 66 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 21 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 7112b10eeea..9ad5f9db4f7 100644
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
@@ -108,7 +108,8 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 				continue;
 			if (repo_parse_commit(r, p)) {
 				clear_prio_queue(&queue);
-				free_commit_list(result);
+				free_commit_list(*result);
+				*result = NULL;
 				/*
 				 * At this stage, we know that the commit is
 				 * missing: `repo_parse_commit()` uses
@@ -116,7 +117,10 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 				 * corrupt commits would already have been
 				 * dispatched with a `die()`.
 				 */
-				return NULL;
+				if (ignore_missing_commits)
+					return 0;
+				return error(_("could not parse commit %s"),
+					     oid_to_hex(&p->object.oid));
 			}
 			p->object.flags |= flags;
 			prio_queue_put(&queue, p);
@@ -124,7 +128,7 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 	}
 
 	clear_prio_queue(&queue);
-	return result;
+	return 0;
 }
 
 static struct commit_list *merge_bases_many(struct repository *r,
@@ -151,7 +155,10 @@ static struct commit_list *merge_bases_many(struct repository *r,
 			return NULL;
 	}
 
-	list = paint_down_to_common(r, one, n, twos, 0, 0);
+	if (paint_down_to_common(r, one, n, twos, 0, 0, &list)) {
+		free_commit_list(list);
+		return NULL;
+	}
 
 	while (list) {
 		struct commit *commit = pop_commit(&list);
@@ -205,7 +212,7 @@ static int remove_redundant_no_gen(struct repository *r,
 	for (i = 0; i < cnt; i++)
 		repo_parse_commit(r, array[i]);
 	for (i = 0; i < cnt; i++) {
-		struct commit_list *common;
+		struct commit_list *common = NULL;
 		timestamp_t min_generation = commit_graph_generation(array[i]);
 
 		if (redundant[i])
@@ -221,8 +228,16 @@ static int remove_redundant_no_gen(struct repository *r,
 			if (curr_generation < min_generation)
 				min_generation = curr_generation;
 		}
-		common = paint_down_to_common(r, array[i], filled,
-					      work, min_generation, 0);
+		if (paint_down_to_common(r, array[i], filled,
+					 work, min_generation, 0, &common)) {
+			clear_commit_marks(array[i], all_flags);
+			clear_commit_marks_many(filled, work, all_flags);
+			free_commit_list(common);
+			free(work);
+			free(redundant);
+			free(filled_index);
+			return -1;
+		}
 		if (array[i]->object.flags & PARENT2)
 			redundant[i] = 1;
 		for (j = 0; j < filled; j++)
@@ -422,6 +437,10 @@ static struct commit_list *get_merge_bases_many_0(struct repository *r,
 	clear_commit_marks_many(n, twos, all_flags);
 
 	cnt = remove_redundant(r, rslt, cnt);
+	if (cnt < 0) {
+		free(rslt);
+		return NULL;
+	}
 	result = NULL;
 	for (i = 0; i < cnt; i++)
 		commit_list_insert_by_date(rslt[i], &result);
@@ -491,7 +510,7 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 			     int nr_reference, struct commit **reference,
 			     int ignore_missing_commits)
 {
-	struct commit_list *bases;
+	struct commit_list *bases = NULL;
 	int ret = 0, i;
 	timestamp_t generation, max_generation = GENERATION_NUMBER_ZERO;
 
@@ -510,10 +529,11 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
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
@@ -566,6 +586,10 @@ struct commit_list *reduce_heads(struct commit_list *heads)
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

