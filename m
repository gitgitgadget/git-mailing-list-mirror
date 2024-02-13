Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF37522071
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813716; cv=none; b=suKQkSjMiHO6l1ZXPhVQ+QeJe+CM2ZnQmw4QRBEUdikd8KHhXd9b1bzBko9UmSAN8p5RQxDICqi/LcSeItW1z+2BXBBTMyh70nAjH2YeX+hiA4EGe3BBm/ZnZAscWWbJTob0CxTqkecIXa9Vczsq33tB+9v9Iwkx2sDEd0I0R/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813716; c=relaxed/simple;
	bh=1KMvi2u+wtKRUxMi6ylYlRTHEtPQKJNb/eUNynG1EH4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=o+A0+8FWazOgbWJ1a2hT1+lKwX8Y5awq0fiEa3JkdN7eg8vWY3AzAHV8FybVjLTHG+OFImBm8k063ksMP2Xb7SMKXFZ9YDZRcXXif+zDzz8HcZU8jNRWA0nCeCwF4WiwFpFZp2ewFL3rfgKHaVz8nN4Gy6W9NnJiuUzehRDsWp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fG70TKsl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fG70TKsl"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33cda3dfa06so167214f8f.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 00:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707813712; x=1708418512; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+crd7Yhc5AhyCTc0OphfUGDRElIJF2+ZsCa/m/BWkmI=;
        b=fG70TKslfhgijKw82nwf1NQl+RvPVnzTVq508t+dWYzBNKU5PMsVn2mT+gjoviBjHw
         /PJYc5xHrGZnJb2A6dlUees/L2iqHnSKw+RaHwkYnqEwg5vgEF/bqN1tEuNJCWKtKoBg
         RBIAam9FEcKj0+CWfGlT4et1bkHy4OzGjnQTvkPlLM8Qtc83CtT8aRt3Cpi0fd9/gl4V
         R+5Y3hnJpMJeaeBnTt9wMCgWJRys/6N4pNEVaDhQ0HKv29C1gBPmCMcU7Q2YsSOL6cLP
         aZFEfBBt6Yd4WEwyBFQyJLydzOHFxC0MH0W1p7kUoLHJCl/S0PSmW36a171Q3uM6SWoh
         KZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707813712; x=1708418512;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+crd7Yhc5AhyCTc0OphfUGDRElIJF2+ZsCa/m/BWkmI=;
        b=d+ng6jj56H1zODddazzXUT/Mq8+3ttwBzVMrQ/V1N+g5X0kyiSMsclFbVmBInMLTIs
         87vkF5ukOHSAv1lhsbuNm+Fy2QhvGrB0CHVfViY5H5DgOdPM9CK4EH075aFuw9GfFIrL
         EijipjnSYGzbmWMVFV48g1d9xWohy5Og7WeFHwYZK8uKWwVM0L2t0I0cjAVigRjm/hPf
         7BMi+HeOWIFi86AmDRpB0pv+3C7EsKxHrtMCbQj1gMHKOlLj1H5ydwebPMc7m8nJR2Bu
         nDDko0Nr03RpcLD3ZbLvkOOTcTxoUjXwlkhgfUrKTKmRJbkaSsuD7N8pCnC8IaRN43uN
         buEA==
X-Gm-Message-State: AOJu0YyauBHYTr2n58vCAv/cVUboV4iFL53lL0a8aKi2+1niBGHe8b2H
	lJKXEQRYi9wwEyCta+NtOw1CtSGSTfPhuxNmZTduW/CLBzV2/sMcpyp2JKU6
X-Google-Smtp-Source: AGHT+IE2GnC+nhBPZPYOXL2S8XWM2zSQ2YzlhgVmyHDeq1J9oTr2g/6PVRY45RgqOchg/TblwXuIVA==
X-Received: by 2002:a5d:47ce:0:b0:33b:684f:4926 with SMTP id o14-20020a5d47ce000000b0033b684f4926mr8011968wrc.63.1707813712426;
        Tue, 13 Feb 2024 00:41:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d5229000000b0033ae7d768b2sm8913173wra.117.2024.02.13.00.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 00:41:52 -0800 (PST)
Message-ID: <8395c3efbc3c34d732347f743a0263707ec454bf.1707813709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 13 Feb 2024 08:41:39 +0000
Subject: [PATCH 03/12] Prepare `repo_in_merge_bases_many()` to optionally
 expect missing commits
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

Currently this function treats unrelated commit histories the same way
as commit histories with missing commit objects.

Typically, missing commit objects constitute a corrupt repository,
though, and should be reported as such. The next commits will make it
so, but there is one exception: In `git fetch --update-shallow` we
_expect_ commit objects to be missing, and we do want to treat the
now-incomplete commit histories as unrelated.

To allow for that, let's introduce an additional parameter that is
passed to `repo_in_merge_bases_many()` to trigger this behavior, and use
it in the two callers in `shallow.c`.

This does not change behavior in this commit, but prepares in an
easy-to-review way for the upcoming changes that will make the merge
base logic more stringent with regards to missing commit objects.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit-reach.c        | 9 +++++----
 commit-reach.h        | 3 ++-
 remote.c              | 2 +-
 shallow.c             | 5 +++--
 t/helper/test-reach.c | 2 +-
 5 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index dab32eb470d..248a0f2b39d 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -467,7 +467,7 @@ int repo_is_descendant_of(struct repository *r,
 
 			other = with_commit->item;
 			with_commit = with_commit->next;
-			ret = repo_in_merge_bases_many(r, other, 1, &commit);
+			ret = repo_in_merge_bases_many(r, other, 1, &commit, 0);
 			if (ret)
 				return ret;
 		}
@@ -479,17 +479,18 @@ int repo_is_descendant_of(struct repository *r,
  * Is "commit" an ancestor of one of the "references"?
  */
 int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
-			     int nr_reference, struct commit **reference)
+			     int nr_reference, struct commit **reference,
+			     int ignore_missing_commits)
 {
 	struct commit_list *bases;
 	int ret = 0, i;
 	timestamp_t generation, max_generation = GENERATION_NUMBER_ZERO;
 
 	if (repo_parse_commit(r, commit))
-		return -1;
+		return ignore_missing_commits ? 0 : -1;
 	for (i = 0; i < nr_reference; i++) {
 		if (repo_parse_commit(r, reference[i]))
-			return -1;
+			return ignore_missing_commits ? 0 : -1;
 
 		generation = commit_graph_generation(reference[i]);
 		if (generation > max_generation)
diff --git a/commit-reach.h b/commit-reach.h
index 35c4da49481..68f81549a44 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -30,7 +30,8 @@ int repo_in_merge_bases(struct repository *r,
 			struct commit *reference);
 int repo_in_merge_bases_many(struct repository *r,
 			     struct commit *commit,
-			     int nr_reference, struct commit **reference);
+			     int nr_reference, struct commit **reference,
+			     int ignore_missing_commits);
 
 /*
  * Takes a list of commits and returns a new list where those
diff --git a/remote.c b/remote.c
index abb24822beb..763c80f4a7d 100644
--- a/remote.c
+++ b/remote.c
@@ -2675,7 +2675,7 @@ static int is_reachable_in_reflog(const char *local, const struct ref *remote)
 		if (MERGE_BASES_BATCH_SIZE < size)
 			size = MERGE_BASES_BATCH_SIZE;
 
-		if ((ret = repo_in_merge_bases_many(the_repository, commit, size, chunk)))
+		if ((ret = repo_in_merge_bases_many(the_repository, commit, size, chunk, 0)))
 			break;
 	}
 
diff --git a/shallow.c b/shallow.c
index cf4b95114b7..f71496f35c3 100644
--- a/shallow.c
+++ b/shallow.c
@@ -797,7 +797,7 @@ static void post_assign_shallow(struct shallow_info *info,
 		for (j = 0; j < bitmap_nr; j++)
 			if (bitmap[0][j]) {
 				/* Step 7, reachability test at commit level */
-				int ret = repo_in_merge_bases_many(the_repository, c, ca.nr, ca.commits);
+				int ret = repo_in_merge_bases_many(the_repository, c, ca.nr, ca.commits, 1);
 				if (ret < 0)
 					exit(128);
 				if (!ret) {
@@ -832,7 +832,8 @@ int delayed_reachability_test(struct shallow_info *si, int c)
 		si->reachable[c] = repo_in_merge_bases_many(the_repository,
 							    commit,
 							    si->nr_commits,
-							    si->commits);
+							    si->commits,
+							    1);
 		if (si->reachable[c] < 0)
 			exit(128);
 		si->need_reachability_test[c] = 0;
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 3e173399a00..aa816e168ea 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -113,7 +113,7 @@ int cmd__reach(int ac, const char **av)
 		       repo_in_merge_bases(the_repository, A, B));
 	else if (!strcmp(av[1], "in_merge_bases_many"))
 		printf("%s(A,X):%d\n", av[1],
-		       repo_in_merge_bases_many(the_repository, A, X_nr, X_array));
+		       repo_in_merge_bases_many(the_repository, A, X_nr, X_array, 0));
 	else if (!strcmp(av[1], "is_descendant_of"))
 		printf("%s(A,X):%d\n", av[1], repo_is_descendant_of(r, A, X));
 	else if (!strcmp(av[1], "get_merge_bases_many")) {
-- 
gitgitgadget

