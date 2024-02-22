Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3241332B7
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608122; cv=none; b=Z+LnwpqR9FfBzYVvx823EIc2PC8/h63zZwAOIE3TDjbORuxYMNqHosv6Yqr5Feqq5fgR9PBWauBjSr5jpzv493/j+f20C1zAxylXU8Wf/x/tg4R3gLjJrwW6AaEdGrXXEwZwSDuFhvmGarMHSVg7aAt9pXfm+S4cu5kWMyNXoow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608122; c=relaxed/simple;
	bh=+pZqO4z9dzPxkYeO95GzM11oRgZZU6Hu7Qf1EyX5XlA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uupsG7qyn0qhq00CYVZu24HHCC+TQFPqSpzaeFA6x8Y6FsASpFKr474h16plAJUavFQ8ndM1fWfDgLe9zl6WKmZzvnDkSiFN+eEJYVU98aNZ3fPFlS+Si3t2OEMOR7XIPZwIywbOoOMAaUKAUZ9qVtEmsV14X9B//VRSHqx+KTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm8IIQXD; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm8IIQXD"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d25a7b02d6so19688551fa.2
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 05:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708608118; x=1709212918; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mN1V+1j8c+E3JD8Ld0NDPVa4IYGtQUvIiMGNp6/rDak=;
        b=jm8IIQXDD2a0hOiCjaXjQQCf6eQJQr3uHPAUQhy+J10jgAXE3WoKXtiYq+ajyckWLg
         TAyZA/cuND1evi2yQNwUORgAhYCmTHA5n1mQ2zdNi2sal5wNNQ/SNrFxBOyzHRBM/LcW
         RhgPPBTogGTj3wnEWHOTBt2LufZXmAllMbJTDdwdRbieaxU5fvYa3gG88WrxejOyTfCm
         m5eLDKEF16uLa9pwINAHAaH0Mn2hm8YEj3PtR8Xlk2pXJ6bIDxoClIqUMpcWQStCXJ4e
         lyCilkPZO7edY6bxNOZVt62AWtDiuxAOX2l467sISm4fiT3Ad8+gVz3N3Qw3nQNauwfo
         QK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708608118; x=1709212918;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mN1V+1j8c+E3JD8Ld0NDPVa4IYGtQUvIiMGNp6/rDak=;
        b=DVpckh93uzpPeV8hv6KZySAn/USor2TaCtqO26PSFAdlIgdKcRwlQGEGwrr35KVlDy
         CWHOZ+nouSeFgrOFCSB9+rld279xpHHgOv1CY982CjUdvZgv+w8R+CmAIshiE54gZcqr
         yc++1RYC2AuiTx9GEC0MvHTMGO0e9UvQ23IuLl0nDvUD8gOhJczxaLs5sIrwulVf+zTv
         68k21jEmElCoqrnO5TSYMT1Flna+a5FWfglfwjtRaD2HQkGpo9Ppb8IuaVzt5hAoVFBe
         9+ldmJ+iuZgN8GCh9jqIX/VAZsmt6rtpn3nSmtLXwLehveqFLVMn5wUequ4YVAbQUErh
         Ormg==
X-Gm-Message-State: AOJu0YwtfliJc9+dWyK7CKgUoaeWlKAlSFGJpU5J0DPVrDeeXFEyKHok
	46L0cQ1B4wJgsSw18aY/zv4xvgE60/EWH6/KE37sMDhgOZIqZtkdWWteYd6c
X-Google-Smtp-Source: AGHT+IGyXVMMk8BGtYydzQeOSqua8wiG+GoVUN1KOo+fflWBJjwBuGCMw0o/CWCac1hCNRn6kB2mLg==
X-Received: by 2002:a2e:87da:0:b0:2d2:4c4d:e208 with SMTP id v26-20020a2e87da000000b002d24c4de208mr4666057ljj.30.1708608118060;
        Thu, 22 Feb 2024 05:21:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id jv15-20020a05600c570f00b004125f34fd7csm6127408wmb.31.2024.02.22.05.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:21:56 -0800 (PST)
Message-ID: <ec3ebf0ed17fa38c51f0e6baeff79999c0a3f070.1708608110.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
	<pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 13:21:44 +0000
Subject: [PATCH v2 05/11] commit-reach: start reporting errors in
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
Cc: Patrick Steinhardt <ps@pks.im>,
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
index 7112b10eeea..9148a7dcbc0 100644
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
+	if (paint_down_to_common(r, one, n, twos, 0, 0, &list) < 0) {
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

