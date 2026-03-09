Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6122C11D5
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076343; cv=none; b=UifZUSjtYVl+200CyEO3QaRN21ky0CcrsEFSSHeQCMiFSyhWJTAls0XUwFH5Tc3AmN/CbQ89DwLl/P9d2v+gqW84wX+jU5W/YBspa23VYLYXwK4zklx4TVYCpcZYS2NwMEpHmEyAwv9nLNgj3axN1JjdJx3DcDGqlXFoStSlhOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076343; c=relaxed/simple;
	bh=c8vVaIOw0o3QO3mBw9ty044bwvmr9HfYGnj+smW3bzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oRj9NpwHAUx8ZZacigxNWDulLEvmWyGkaSOVu6c8iGtEh3xQyyFbm/J70PKo2b7uwXVvMFCnWEYcUZ3rv8cMyS2bx9GSglYDQqmyrmN54B8rG/yr6ZQ+L9ftByduEyNAsn0LFnFam7ZNzfVHwiDbkjEs+gvw5uInDgVF066zhoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8S4Ct4n; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8S4Ct4n"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c7382731edfso3552752a12.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 10:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773076341; x=1773681141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xSGw4L6fy7wKSstvWyEhCpu+RiRLU68qMlZ1ZiSLWeE=;
        b=h8S4Ct4n8zoTg3JLWeTx7psWk4ueidy1njQfI12OKY3vVULAYRFaRXvqi5vDv1mCg7
         mrt1LDOkfmBXjbdbsu3T4B8OS2EWCPNYDiuTeaJZ2lkK5CewNO4HVE2q5+xGevy44iH/
         QiC57wvlIvdd2R205ukn7681xG8ho2LnY9dRNjswbuOlrwbL/EQ/HN0bVb208ndSI+fL
         UbJ1S32CIJk9mmFuqAS7hnz279HlzCQgHXMEiSi7dJDigaB3TrOghKsDnjnx6PZIOGyB
         Y4aSgY42CEPMMiWWny5BXAaz4atCDecCYGlEqwBh1awnYU0doMW6KsZJoDNwARLDKJbN
         t1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773076341; x=1773681141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSGw4L6fy7wKSstvWyEhCpu+RiRLU68qMlZ1ZiSLWeE=;
        b=mqNika1uuqPoW6Nt6gUdvO2H9ZO64mN6VHSJcwcm15LKxBDXJPuPI9ID5yayPHvNmm
         psQ39JUBsEM6c9OaLX34339tORZj3qW8FtW73sBa2PEt0Zv63omwfTxC73vXCP0HH2mN
         SSbGGpOeGMz79AdqOn6mH+YUEmf7Zv6ND2oUtY4d6Gs+DOJGo4fxEzIS/X3/zHbn0W0y
         iX3BLCXttGZVrqEoRq22YF5/ZqSYiX792JfVfcsPpuqm4OuJ34bMAdCVUQt4tRA9q4yy
         0F4Y+rNhJ9feEYDja5yIjA14P6KYHcuQTC5l5hyefbswdnzWfz5oInMoVOT63gbKXqjz
         Psgw==
X-Gm-Message-State: AOJu0YxbGfrBKlPPXfUz/pD3G4Nkg5OREeqWeYrX80CAHSQ5dQU2uvFj
	yPNy9TsPaq10WLj2gTBqgfe9WHSLzpuo60N1cxhV1qIlbdbBSRcYk8XLa7KuuWNq
X-Gm-Gg: ATEYQzwUZqvL/ZgS0093l9sW/pJhZv7MlCioyfENn8rOnW6QDJqLfgtGVsqrs0jAW5k
	JVMGLG7QSG7GS6KCRkydZBXlgGwqi/xaUCUCJOfL8GDPMB0Zo4tKPhf0yCKXNm2qZbjcB320Yzo
	mIfpptqnYfTHD4FO7RY017sk8aZko3nmEJ2lrWpurpzT4m32hVjv23101zSNauJdQD6+MS4Vd+d
	jvYzFfhtTwqWXbNITz6pjvCCW3FPUsPTqq14QvYxaHPEOgzD83pv3qHQyZG91Of2affaC8MUbfI
	61alxH5k0QO1+TcEpVWjRN5LoVIKKghjt/JmUut5EJCSJaVsR7ImX7crvZbXMmJ3fM2l46UG31J
	w0W4dUBl9iuQP0tiNuzUU73FWIw9rFerK8eUhJHUrMn8pzTlBRzhtfDoVT5ks7VWbvEMrD/1lMu
	Biht6zT9j40u98Kf4RayuN6UYF8ug9EA==
X-Received: by 2002:a17:902:ea02:b0:2ae:7ed6:46e3 with SMTP id d9443c01a7336-2ae824441d8mr118321585ad.27.1773076341461;
        Mon, 09 Mar 2026 10:12:21 -0700 (PDT)
Received: from dorna-OEM.. ([111.119.49.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e584aesm118469805ad.3.2026.03.09.10.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 10:12:21 -0700 (PDT)
From: drona <dronarajgyawali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Dorna Raj Gyawali <dronarajgyawali@gmail.com>
Subject: [PATCH 2/3] repo-settings: move trust_executable_bit to repo_settings
Date: Mon,  9 Mar 2026 22:57:15 +0545
Message-ID: <20260309171216.13339-1-dronarajgyawali@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dorna Raj Gyawali <dronarajgyawali@gmail.com>

Move trust_executable_bit from a global variable in environment.c
into struct repo_settings so it becomes repository-scoped.

v3:
- Use revs->repo instead of the_repository in diff-lib.c
- Add prepare_repo_settings() before accessing repo settings
- Minor formatting fixes
- Include recent one-line change in <filename>

Signed-off-by: Dorna Raj Gyawali <dronarajgyawali@gmail.com>
---
 apply.c         | 2 +-
 diff-lib.c      | 9 +++++----
 environment.c   | 1 +
 repo-settings.h | 4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

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
diff --git a/repo-settings.h b/repo-settings.h
index a12e763f4f..4ec9fe3280 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -48,10 +48,10 @@ struct repo_settings {
 	 * replace_refs_enabled() for more details.
 	 */
 	int read_replace_refs;
-	
+
 	/* Whether to trust executable bit on filesystem (core.filemode) */
 	int trust_executable_bit;
-	
+
 	struct fsmonitor_settings *fsmonitor; /* lazily loaded */
 
 	int index_version;
-- 
2.43.0

