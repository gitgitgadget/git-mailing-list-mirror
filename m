Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B100B33E348
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772994287; cv=none; b=lULlYxmaNC/nFeeCPUlqaGg+4uDCoWLwA2EnJ9ANZH1UrBJ8rZINd6JgDzvFA8fymZPDZqkpGhndKWI0G0Tt4zXT8NWcPrDk8iSkgFQcPehihxgdQGbJBQ0HIElwhSjg8OUmZn8C7SDZgetAky/m2gc6BSlbRWugN4jllk+lQ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772994287; c=relaxed/simple;
	bh=TlYp/c0Gvz85hnYQswaVYTcZtICMFHGlXO1Xj9je/5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHR74ZqfqOTV0ycCPvZ9DaLYMhqih4in+S/thaxnWJy+Nnxj+rPmDu5NhJIGaffhkUjRB70pa2+FeUjHFTGl46ubvcPxeccHz9DwwXRpRcga3pc7wTZrB+KgmxB01vZWfyNXtDsYrzSDM5EcU3y/k/aDHzuES6Es3MT/NkDbNGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiAMHg3s; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiAMHg3s"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-824c9da9928so6140523b3a.3
        for <git@vger.kernel.org>; Sun, 08 Mar 2026 11:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772994286; x=1773599086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFlY7Q9W4a/u1Q4BiqG9vKb6BZtM5DP9agDJRyrt/bQ=;
        b=NiAMHg3saUujp2/jUx3xBcW+LE3gxqKErguCGk7d46TwApamAeeDWM56r9mUF2afRc
         wJgRxch/rxECrxpNAL1JhjqssACDpwNDSKCCamUKGSqpU/HJQg7Mz7Ueo3azyWCSWK3D
         AJCb575fMvbZWEZK/uyQch3u5DAHPlk9P2gO6cerLrfCT6QSrmheQ40l3pIwuGhLwgz+
         1zelmORZglKblz6dpvFmkztDdPfOMvejPdnFMwHcOVz+TyAjLqNAnXg7ZL3zBqBrzo5n
         wT2Jb/5qhv+yd42JCQbNcN4V+VrMNaAoife1ImOv5AMsa/fqlvLCf2nE4XB5MMfv1pGG
         GyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772994286; x=1773599086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PFlY7Q9W4a/u1Q4BiqG9vKb6BZtM5DP9agDJRyrt/bQ=;
        b=OfLpNdTNE+GlTZ0auQOBsCG+YUrjR8AuGFZ1QcAdQyh9KKDDWRGj+v6fDIP4OYh48D
         LhPuDkAa7CtrIgxb0M8anWg6Ko3U72QcLRB9wPZx+k9j4XSc5ayFO+j4sV0enOZv/qAo
         DVsvbeHhY6E3paLSFOWgA0H08rTOU4qe+g2rUcDgoMRkFBxevL+CJzJaIT16wd+LWfw9
         3j5WbL2sib6ax1Lpn1hfPpbw3mRgs9um757FpaEB3jNZLiliBH9rIWBMOzA1JuUnPAUN
         dtKQnQq3kdsBG5UQYycNBa9mN6/FjexyoxinMY2zj/UxwXuSU8gmaqV+DEQLNJeGj2Fe
         y50Q==
X-Gm-Message-State: AOJu0Yx36iGrxVwxt11BJPo1KqbCtTan4Nfw9LoB6u4B/vJlaJObH0Vq
	h1TNItZvDj9RMYoCiiWcaHWzU4AYnBMkBXuNOQlQUl7T0PPHUADx/8CJzmJZBHp6
X-Gm-Gg: ATEYQzwR1/ZxCi8nOlPdMnN4WSOFBeUECDBRPaTWLYikQF+06n94XMHqX4W8IbFIp1t
	qp6mOl5Wpeie+2s/5/puBb157E20mHWuVKddA+EmvopzwC9uSgHZkJz+BHr3+0K/7GSlMWem0us
	XdK2rtqJEcMZUaI9xCsgiiXe8JvmM9DsRWDtP0QA37av1GcYzgVMcJF0L2sKkdJm8nqPYHhTHgX
	cMtPECUzei8Lbass3itVAcXEEGyKBuL+SwVNjaFSYvs/kJIuqIyJ8ux572DDEKL2m134orDQJJ/
	1SmSru4gdpfWFBV0iPh/y+UUIgDIDDsozRzM7P05iikGiOFXVgeMJPmF5a8x/sH7LnvcQq2ZNMS
	IOuEMoX4utzGl6Eeypme5pC2G0YOgKE/mThBpdD3jdf9d5NMIkBkghDWSi0kQ3wX89AQ+R3OK9m
	09GXKgwhGJx87G4orPE9cjVWX/fq+g15c=
X-Received: by 2002:a05:6a21:4846:b0:398:6ea8:21d2 with SMTP id adf61e73a8af0-3986ea82cb2mr4839445637.19.1772994285803;
        Sun, 08 Mar 2026 11:24:45 -0700 (PDT)
Received: from dorna-OEM.. ([103.152.144.28])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e199993sm6913827a12.34.2026.03.08.11.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 11:24:45 -0700 (PDT)
From: drona <dronarajgyawali@gmail.com>
To: git@vger.kernel.org
Cc: Dorna Raj Gyawali <dronarajgyawali@gmail.com>
Subject: [PATCH] Make 'trust_executable_bit' repository-scoped
Date: Mon,  9 Mar 2026 00:09:21 +0545
Message-ID: <20260308182424.31349-1-dronarajgyawali@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260301190017.53539-1-dronarajgyawali@gmail.com>
References: <20260301190017.53539-1-dronarajgyawali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dorna Raj Gyawali <dronarajgyawali@gmail.com>

- Moved 'trust_executable_bit' from a global variable to
  struct repo_settings.
- Updated all calls to ce_mode_from_stat() to pass the repository.
- Updated environment.c to set the repository's trust_executable_bit
  when reading core.filemode.
- Fixed apply.c, update-index.c, diff-lib.c, and read-cache.c to
  reference the_repository->settings.trust_executable_bit.
- Added prepare_repo_settings() call in diff-lib.c to ensure repo
  settings are loaded.

This change makes executable-bit handling repository-scoped and
prepares the code for multi-repo support.

Signed-off-by: Dorna Raj Gyawali <dronarajgyawali@gmail.com>
---
 apply.c       | 2 +-
 diff-lib.c    | 9 +++++----
 environment.c | 1 +
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/apply.c b/apply.c
index f9fd7b0030..1677ddca15 100644
--- a/apply.c
+++ b/apply.c
@@ -3838,7 +3838,7 @@ static int check_preimage(struct apply_state *state,
 		if (*ce && !(*ce)->ce_mode)
 			BUG("ce_mode == 0 for path '%s'", old_name);
 
-		if (the_repository->settings.trust_executable_bit  || !S_ISREG(st->st_mode))
+		if (the_repository->settings.trust_executable_bit || !S_ISREG(st->st_mode))
 			st_mode = ce_mode_from_stat(the_repository, *ce, st->st_mode);
 		else if (*ce)
 			st_mode = (*ce)->ce_mode;
diff --git a/diff-lib.c b/diff-lib.c
index 894358c8b0..276efef407 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -108,6 +108,7 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 
 void run_diff_files(struct rev_info *revs, unsigned int option)
 {
+	prepare_repo_settings(revs->repo);
 	int entries, i;
 	int diff_unmerged_stage = revs->max_count;
 	unsigned ce_option = ((option & DIFF_RACY_IS_MODIFIED)
@@ -160,7 +161,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 
 			changed = check_removed(ce, &st);
 			if (!changed)
-				wt_mode = ce_mode_from_stat(the_repository, ce, st.st_mode);
+				wt_mode = ce_mode_from_stat(revs->repo, ce, st.st_mode);
 			else {
 				if (changed < 0) {
 					perror(ce->name);
@@ -193,7 +194,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 					num_compare_stages++;
 					oidcpy(&dpath->parent[stage - 2].oid,
 					       &nce->oid);
-					dpath->parent[stage-2].mode = ce_mode_from_stat(the_repository,nce, mode);
+					dpath->parent[stage-2].mode = ce_mode_from_stat(revs->repo, nce, mode);
 					dpath->parent[stage-2].status =
 						DIFF_STATUS_MODIFIED;
 				}
@@ -262,7 +263,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 				continue;
 			} else if (revs->diffopt.ita_invisible_in_index &&
 				   ce_intent_to_add(ce)) {
-				newmode = ce_mode_from_stat(the_repository, ce, st.st_mode);
+				newmode = ce_mode_from_stat(revs->repo, ce, st.st_mode);
 				diff_addremove(&revs->diffopt, '+', newmode,
 					       null_oid(the_hash_algo), 0, ce->name, 0);
 				continue;
@@ -270,7 +271,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 
 			changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
 							    ce_option, &dirty_submodule);
-			newmode = ce_mode_from_stat(the_repository, ce, st.st_mode);
+			newmode = ce_mode_from_stat(revs->repo, ce, st.st_mode);
 		}
 
 		if (!changed && !dirty_submodule) {
diff --git a/environment.c b/environment.c
index 591683ce8c..9d12c5fa56 100644
--- a/environment.c
+++ b/environment.c
@@ -304,6 +304,7 @@ int git_default_core_config(const char *var, const char *value,
 
 	/* This needs a better name */
 	if (!strcmp(var, "core.filemode")) {
+		prepare_repo_settings(the_repository);
 		the_repository->settings.trust_executable_bit = git_config_bool(var, value);
 		return 0;
 	}
-- 
2.43.0

