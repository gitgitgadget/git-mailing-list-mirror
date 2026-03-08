Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10722262FFC
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 18:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772994873; cv=none; b=tq28r2OC9VMpcZFVxgLnKmTGE3rgkUVkufGjxnVBCIX8LkJNKhK7vU4ERfq1KGds7KL66Jak1Yad72jgRVDZzhh5/HfdFn56wG/GQK09Lc/dFcd/Zhpz02nIAUWFOtYlZXUkwYJ4BHKpYw1D9qxOdTO3qq/bOHRKaCfnJcxL/vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772994873; c=relaxed/simple;
	bh=TlYp/c0Gvz85hnYQswaVYTcZtICMFHGlXO1Xj9je/5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M95ptHIwTbXfeWVSB/06pk16daRopgMinFRm+ka9dKst80s0KAvDA10N8Dx9GSqcLGHYeFnJf9I30BPBLVhL6OE/OOQlJdHe/nYiaLmne4pxpHvgUwMM8kpKq87rRg2lBPE4oU5LpyzPHDNWLrm3UrIc0EDvrYq4YhLwmuHA7aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVePX9L6; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVePX9L6"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so9738043a91.1
        for <git@vger.kernel.org>; Sun, 08 Mar 2026 11:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772994871; x=1773599671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFlY7Q9W4a/u1Q4BiqG9vKb6BZtM5DP9agDJRyrt/bQ=;
        b=SVePX9L6+faBxoF5BhTaPMv8+2zMrM+qRWVfqpRq9Et7iBHbpn7yjARYuv4Z6llNFV
         idWhrgnrv9R9gSgfBCUQvEWMGT7OwQuW+zCxf28LddVi3lg8iNceZwiGdGzIA2qQsDVK
         ovFZ6fF0ufV8e+zkIhnI+r78UdHuHyZ3L7rMAX+xSJOVTmDzDh95jp+nUgLjjFjZdMSt
         8L2a28f6bpfjBKCW0eDIp6C+mqShCOpYVZwzyeCzwp3093bvv9BFLHPdtyIIAujOrrfq
         teVLBpgoBq7MMfXZWHpsUVaY18NQnYKcjgb/1F0hzuxwU5Wu3l+NOCg3MlHvCEWpU/FA
         J23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772994871; x=1773599671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PFlY7Q9W4a/u1Q4BiqG9vKb6BZtM5DP9agDJRyrt/bQ=;
        b=LKO93D/XHk7I7cwgQkhpxOfPwcBohBbAsG2oT+1l6oQ+JRERYKAi6DyZtxQvNjhM78
         Y+oSmOfIgsb74Oy8L+0WndQ+4XiEC36uJ0y6kd0GxD4EcqO+dYkUkRJhEahVa4LqWzva
         9xbd7cZ+KIhxwBZLdTcokBrLm1X4I1tZniHVvslai+i2Y/NLDjsbOh3Bozhd4rWaEnoV
         NcjHf2E7R24OjJLIl4nyzCADJ+XVYfRLqjFzM+08nXe7k5yLPmzW3SgqEpbIfOqJyKjx
         45ANFnAxQqvTaB76Ntnfn4jS89FPgVxgPY1VtkGRikN64lLOOGPl6YoPH16UPrTLCLEk
         n+3Q==
X-Gm-Message-State: AOJu0YxRs4iCW4Rd375PwsEYforGrt3JoLfdImFCFG+z/x4rcw5Zj9gB
	CdPDHsSo/tYvnzr4TorAHQ9ehNumr3QqW9KP3r139yDxmrQy8HSmspQqKb2dDY96
X-Gm-Gg: ATEYQzzxIOErkl0lnpqn97HF6B5z6THSd6S8pdRsoKTwOrdO5Shduf8eoR23QHQKw6C
	AGb6EEFNq/sg0cJJ2H3Jr/RPcV22Evr+4kbfcLFXDH9e3Xb0OfvIhl9zuFuyvmF//vGEfTemm9n
	XV+ETkBOijuuK3MXOuuaxLA3GdYtaBhUJ8lqA7Gd8j4pBlcEN5NNOvvP/kDOIghQMjL+6WsKLrj
	/rkntDcYHzwiP36DeMqOuHQdt1zhe0+DmU86YsNCwmu60zDzHWkO1pcQi5vx/FfRXTIaYZP+HNK
	XVwlv/nUkTE78ERH1R3KcEtzWzZgrPz5T1cBcZP8Xu8vrdjNpB0cLZgA4e0ova9OtSRGpe3aKxf
	Z85Jug2FYFL1TIJtgeTALJ0DB6DHNJfjzhLNM230ape6FraERwystV9YaXUeJt2KlycI4IB/63o
	WPdkm8RPTPgTs2PSjX+makLNUuFlro5eA=
X-Received: by 2002:a17:90a:e7ca:b0:359:8e1c:53e with SMTP id 98e67ed59e1d1-359be34a6demr7628454a91.31.1772994871190;
        Sun, 08 Mar 2026 11:34:31 -0700 (PDT)
Received: from dorna-OEM.. ([103.152.144.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2d392basm14885554a91.3.2026.03.08.11.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 11:34:30 -0700 (PDT)
From: drona <dronarajgyawali@gmail.com>
To: git@vger.kernel.org
Cc: 24f40e5a-a5fd-49ec-86e7-921b44e4abd9@gmail.com,
	Dorna Raj Gyawali <dronarajgyawali@gmail.com>
Subject: [PATCH] [PATCH v2] Make 'trust_executable_bit' repository-scoped
Date: Mon,  9 Mar 2026 00:19:21 +0545
Message-ID: <20260308183421.31700-1-dronarajgyawali@gmail.com>
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

