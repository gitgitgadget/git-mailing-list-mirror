Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB0C33344C
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772995088; cv=none; b=FxNd1mhd+3PYJJubslTxJAdaOmkzOTCbcsDIT8mmC8xp1i/j5LWl+Hg9kkxz+lxdoeLimRIW2I747yVLZxaPPyVYHkkvTqbBjcXaXJFNwYmZSjgQcPHNSci8ZmpcVb87bRq7VdOYgN/Rru1ZnUYzfU/k65ktD7/ovGzMOuWUR3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772995088; c=relaxed/simple;
	bh=TlYp/c0Gvz85hnYQswaVYTcZtICMFHGlXO1Xj9je/5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JI6ue5O3pyekjTsayzFFJo9TWc8lMJKRE7ux96eEvlzOZz1Ghbj/1YKvswq6ElMtwLaIyj6D5MHKdFZ3HpnVmVcU9Zo651BKTry/yyzLQqy0BcF6XdksJUMCd0gvR69FbTMJCoSp4oj+P89l0Xlv93vwuUN+Xhx/9RGKR0kH0QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpbqGeYg; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpbqGeYg"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-358ed696623so4505814a91.0
        for <git@vger.kernel.org>; Sun, 08 Mar 2026 11:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772995086; x=1773599886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFlY7Q9W4a/u1Q4BiqG9vKb6BZtM5DP9agDJRyrt/bQ=;
        b=UpbqGeYgDBlux/aj4GcduIYhF/Ty5pimvuoAOw3CEUQWtqUBEbEdi7Z+7yXLHH2H7t
         F3U0YacfU9imA/rUC1+fOV9t8Xy32Hw8+xadMvmSv//BmQdwDOhz7XNgAM1CNCDy9WXj
         /pN1wwX9siB/LHdm0DVxik0BTng+U/l9woLTtWVI0iF/DihN2G8YVVIeHreWsE/miF/w
         Bguwfq/EHhAjPLNRmdRFmWqFmdgX5VMYPXTjAXUi16spczOLutamtAJYDhmXQ2EjDl/T
         0TwERs/h47Y3ejIOEuvp/wq9rbyinAvw/qcIKjwer15/IbaW1VKKlewKpks7yv8kCoQz
         cwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772995086; x=1773599886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PFlY7Q9W4a/u1Q4BiqG9vKb6BZtM5DP9agDJRyrt/bQ=;
        b=cyyOvkCaNCOk3v70GoLqCmyAqzWuxLznf2Joey97WHZqV1HC77nrZYyPOQUzct3sYZ
         swszYRW9yX1vekEMpT8syFSCxHqJ2eLtV6sZKpYKF1HqKPUXdGAYbmLexQE1SWrY3a/H
         WsFgGF+qsykXm9dg71HNlvYwlF3rjR3p4Um0MSnDffBCqT2ecbD595BH3AapfXfRt3Q6
         I+oiAV/tPmY25alnjeUgDbzkU93Pu/OMaRDEi4ju8hizK7L1gF/HCZ6obkFpWDyxMaXO
         P91k3Andm38P4/BjANzeXfR7kxgpTsR+jr/6aoa2xjBpL7a06qUBmAaufaFmVSqHeJR2
         Nezg==
X-Gm-Message-State: AOJu0YxhccdP5gsDE4cKNMnTX5/ExtjZmFPqwioWCUkEjh4cumjc0D+j
	D2qQ6nAR5ojB7wAe5JAMjb38zgbfLrT8pq37uwbrrTGW81U2rdPC+nIjcKRZdaNC
X-Gm-Gg: ATEYQzx/+qx9+/lrQN6J9SEkgJziZWVMkwNNSYDq1ZV+U3jY/Rjvygz0f7ybh1atE62
	nJt2MLLDJXQZD7S/WnKJmTSKyt73cviH1g96Bk5dP9xTdh6ctwRlQ9PLb4/lBXpxiM/38ZZFbmV
	B3GAT2/HnjmZ3zYW7zbRmq2xqg5J5qpJ4rBEezkmz8jfU9QSa3lOUiEdqdOmnT8jWIgsm5wcUaf
	HNcQOKBWc+mtXFBBiEJL/ekjQjkufXNh2ExdB0VOkPTR96Hr8u2ssvpUZ30Nz3S0eAEvAgOLDvs
	caWd8194vqmCmGkJoH6u5QLMBr/OAwWqO06NcwStrfEV2XTTiriBw6QPcKYcK4JsA2nEQ+Sk1vc
	rHnrZpJirt858mC4pZPP/6jimNfmvU6MDuPaDNNwPf8IfO2Q8NUo6XQbzDUHwf76rP8efUBMzxx
	iFiadUhjOyhvJSRzsO2r9j1h6wXoMgq3v/lpblq26M8A==
X-Received: by 2002:a17:903:11c4:b0:2ae:47f9:de12 with SMTP id d9443c01a7336-2ae8251b8famr92042175ad.46.1772995086136;
        Sun, 08 Mar 2026 11:38:06 -0700 (PDT)
Received: from dorna-OEM.. ([103.152.144.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f74e7bsm86000495ad.46.2026.03.08.11.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 11:38:05 -0700 (PDT)
From: drona <dronarajgyawali@gmail.com>
To: git@vger.kernel.org
Cc: 24f40e5a-a5fd-49ec-86e7-921b44e4abd9@gmail.com,
	Dorna Raj Gyawali <dronarajgyawali@gmail.com>
Subject: [PATCH v2] Make 'trust_executable_bit' repository-scoped
Date: Mon,  9 Mar 2026 00:22:56 +0545
Message-ID: <20260308183756.31860-1-dronarajgyawali@gmail.com>
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

