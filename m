Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4281B7FE
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813717; cv=none; b=TEasSFO+t8Vhfw8HYElQAqqIjj0S4VFNcXu8lGIG0Rh8j4YneGxZ9QqDwwexLTZIt0lIbbp+7Nyqe5XXcNwUr2EQDJlmSZ4maST8HoxlhmIBY4aMS/OmsArAfFYyNAjBLRtC5HL/dDsofPEdq3ubDGk6smWGfPQL0woTM06icsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813717; c=relaxed/simple;
	bh=GrslJf7zwznCr+lViYLeubzBI8nd61LlCqp9zotvxW4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=T5TnYmSrenzZqRTU4OQMHv/J+UfhRTxmx0c0AjBTQmzqUmLCYUkD6Rk4lZsysxS0eBhBAlQZmhNUCkRmpJQSY/9JMe5MbnmSnOPODURwsND5iHIerRGfY7MuCAamiqNX1tv0FpzufI4VSRd38+dXNoWn04hOhQILPU5D2XQTpbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxjKCWpo; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxjKCWpo"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d1094b5568so3728971fa.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 00:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707813714; x=1708418514; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHXU9fzIVpwa+u3LyYtpp8MZzdGNheEGwQSj8lXLfYg=;
        b=hxjKCWpoWx3y6QSjHENc8fL2gCnpU/QW52SHM8KkZKlhwfXKdkUMHK5X/KfqeihrSN
         I8QyaiUBnS82bu47IOLngWZ33JE/GrCYnkOeHkZsj5dTPyN2ihslJQ8PfTaMU/cf0MDD
         kYdZsHmRsKk6CKq0FVwFEuW75AwDgRjNr979/2srHol1fUNEhZrTxGeLIhsj8kisR0OS
         IBHn0PyTReekb+wMswitjYqDQefCUc9+wDexUgbdfJ6FxKv/imrQm262iHgGGhwP29P2
         fUn4fPJZZ4WBcC1fiiTpyHZnVlCFIdojRatWsb/ikNpOvt6Nr7eOk79f1s6/o72U4eBx
         4/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707813714; x=1708418514;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHXU9fzIVpwa+u3LyYtpp8MZzdGNheEGwQSj8lXLfYg=;
        b=v2vepoWktEQ30UZPediWSL0KOHD+41+QQdFy5S6j3vVkauZjO53dbNKcA3zicRbAMH
         7E/reLcHxxvH0PpVsh6E7mN2DpeprWjLdXRxeTqyOUhzA/Fqxx0CI0uQdRbgSoWsQQTz
         QZbtFAKaUdByyFnDVeJ+v+KK3Cd0n0xLUgq2cnrgcjbUCzjTzZ3jlPS6MY8PsmlKqGlG
         g80JcJK5E+j/INpOjb7FUleCwPPed5niFkZhfRS4Ry21JhFCxO5MvB5jYMVbcp0nFIVh
         z0NtT5HSTswExr3Nb+gwNJusK1WoBToTuwOS56dP4esNBFEU7YLpVlYcV/MKd4Zzg/ot
         3fuA==
X-Gm-Message-State: AOJu0YwuqZQ2zKsbkNLRd3s/3msnCCFy+wPAWmj1XgvcqlogFpWG0MQB
	NbPrfUruzOzhxE+CpfIRA3c6uexHxPtXSbqSq/0xLM7jAJt54fCoFLqmrnOq
X-Google-Smtp-Source: AGHT+IElKY0oVsHmLZRxTd1HPRX77xFUobasrBz7JB+Y0RhFUy+ImEFa6ry0Fpv4TptVC+y+xegfuA==
X-Received: by 2002:a2e:a0c3:0:b0:2d0:5f2e:5b35 with SMTP id f3-20020a2ea0c3000000b002d05f2e5b35mr6475207ljm.30.1707813713588;
        Tue, 13 Feb 2024 00:41:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bj8-20020a0560001e0800b0033b3ca3a255sm8920997wrb.19.2024.02.13.00.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 00:41:52 -0800 (PST)
Message-ID: <7477b18adebe4eca721a0f2fa73ec5bdec389d36.1707813709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 08:41:40 +0000
Subject: [PATCH 04/12] Prepare `paint_down_to_common()` for handling shallow
 commits
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

When `git fetch --update-shallow` needs to test for commit ancestry, it
can naturally run into a missing object (e.g. if it is a parent of a
shallow commit). To accommodate, the merge base logic will need to be
able to handle this situation gracefully.

Currently, that logic pretends that a missing parent commit is
equivalent to a a missing parent commit, and for the purpose of
`--update-shallow` that is exactly what we need it to do.

Therefore, let's introduce a flag to indicate when that is precisely the
logic we want.

We need a flag, and cannot rely on `is_repository_shallow()` to indicate
that situation, because that function would return 0: There may not
actually be a `shallow` file, as demonstrated e.g. by t5537.10 ("add new
shallow root with receive.updateshallow on") and t5538.4 ("add new
shallow root with receive.updateshallow on").

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit-reach.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 248a0f2b39d..1d1d8c989de 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -53,7 +53,8 @@ static int queue_has_nonstale(struct prio_queue *queue)
 static struct commit_list *paint_down_to_common(struct repository *r,
 						struct commit *one, int n,
 						struct commit **twos,
-						timestamp_t min_generation)
+						timestamp_t min_generation,
+						int ignore_missing_commits)
 {
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	struct commit_list *result = NULL;
@@ -106,6 +107,13 @@ static struct commit_list *paint_down_to_common(struct repository *r,
 			if ((p->object.flags & flags) == flags)
 				continue;
 			if (repo_parse_commit(r, p)) {
+				/*
+				 * At this stage, we know that the commit is
+				 * missing: `repo_parse_commit()` uses
+				 * `OBJECT_INFO_DIE_IF_CORRUPT` and therefore
+				 * corrupt commits would already have been
+				 * dispatched with a `die()`.
+				 */
 				free_commit_list(result);
 				return NULL;
 			}
@@ -142,7 +150,7 @@ static struct commit_list *merge_bases_many(struct repository *r,
 			return NULL;
 	}
 
-	list = paint_down_to_common(r, one, n, twos, 0);
+	list = paint_down_to_common(r, one, n, twos, 0, 0);
 
 	while (list) {
 		struct commit *commit = pop_commit(&list);
@@ -213,7 +221,7 @@ static int remove_redundant_no_gen(struct repository *r,
 				min_generation = curr_generation;
 		}
 		common = paint_down_to_common(r, array[i], filled,
-					      work, min_generation);
+					      work, min_generation, 0);
 		if (array[i]->object.flags & PARENT2)
 			redundant[i] = 1;
 		for (j = 0; j < filled; j++)
@@ -503,7 +511,7 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 
 	bases = paint_down_to_common(r, commit,
 				     nr_reference, reference,
-				     generation);
+				     generation, ignore_missing_commits);
 	if (commit->object.flags & PARENT2)
 		ret = 1;
 	clear_commit_marks(commit, all_flags);
-- 
gitgitgadget

