Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF27BA3F
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 01:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749344868; cv=none; b=ZjVEK9y4C8Dr5DEWhHyATazpoh7uCkm/KZBK5wTjOKpQ7Ps5mPFYM7VHQqQUXgPMkwqV9F+DGpzeAFOOdLsObn+gCL8swF0AdFg4CHREhsg3CgPtQYw0aOmXXfC5p8LhNsE8PeMFhUHhQKNUTAfRbTNk7DPS0skUG4qIiM438Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749344868; c=relaxed/simple;
	bh=9kAZ5fbhFJ+0a9IKby9fhxCV7EDOoUiMxL1Txps/QNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkMNd+B3H3Qb+wWsLCqPIwtYKJNLBCWvNiliMu3JUNkdvT2+dC+XAA5J7CCTGIM4gCePVQCPg1DUYo1+iHAId0INi7STSITkLpValYAMxUypCvjn83MLv4WvA8s0hIEn0k8ZgPYb3yh060RR8aWKX5MaQakfg/MbgPZr4GGnJQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0Tqz4Z8; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0Tqz4Z8"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742af84818cso2331653b3a.1
        for <git@vger.kernel.org>; Sat, 07 Jun 2025 18:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749344866; x=1749949666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ct+x3ZpmHVtemRXF1xUDwaGUbtlQL4Ao6yIZHC9XfiM=;
        b=Y0Tqz4Z80M/TH9YWfhc1L1/Cn8ka4D0szMPJfblqplWnWaMKC/oLm0nL/fJeKoSTO2
         3FttAFr0o5eUBOYi9yQuF1FbAW8xDLkMKk5UCqIvYb9p/vrabzB/3pEB+xE1TEBmNX+I
         4f/1+t8MWiYfLEO1bKTI9/30KdBD+lHFrY620ZhUctiNWpPlEhcaL+Ml3p01jR/ZJ/aZ
         LBBNLlAo+FK6U8rtUIqR8RKdScscFYv6nzqqFsFxnToaT/zm1aBKSKRc5b0gVXFBVnqV
         svbH4EdTaRRdw9Y/mMVy8xMeekUlSlMk8vxf8xfhVlJ6urPmz3GLk+gpHVKXfooF2jcW
         wySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749344866; x=1749949666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ct+x3ZpmHVtemRXF1xUDwaGUbtlQL4Ao6yIZHC9XfiM=;
        b=Q4D63QS4GCP9byNg/EU8qNzMLAOXXs6yYxKYRg2tVZ72FbDDgEFSGEUy6mTHAPaqOY
         3xtpPIGA8HdbPIC5K/y1R5JkO5v1aLyBRW5XJhzogqLrRAnFMutxcWnn4pkmnbCWgH90
         rfKWcuZHChCqI76kEuOt9mH7r0xVreUwCaYO/cCzeZJ3tmdmepzc3tE3BJqDF0X1RNnE
         0jxCeQfa5E7MCtv9B2lM/r+5WtcidBpCpTMvfntrIhCLiS9e9j9NkYr6SX3RzHKFJSrV
         NarteaRW+J2MNnx25sBkVHydI9MDouKWUi1RcdHQxgkvz1FsJLIMxOOqT25y0tamzp9d
         hTIw==
X-Gm-Message-State: AOJu0YzWrSHfTg6GVsgfCfMIo0/FVg5ybuMIR/DfuFASDV/t3cc5pO3M
	UpZU8y4UtR4ekDZu4cxA03eVMNWrRlrczIjbovIzkB6lJHkx6Au1V8N4Ted7dM8M
X-Gm-Gg: ASbGncuWYB5O+65M9+ljMweKT/C88147oZLXf0ssnxm9ytg8nS9eIgwnKL2jQj6igq7
	7iC/t03xKLo0gkI5r0FN2NXa4z/AwhWvNYZCvMz2aGnwO6SUG89z47AbtQ5AJI9f7qdsYZD4Y2S
	2K6c+25wZbbwY3sZ+daAB13GHApe+e+klg0/637aC5RlBpjKK+KqjoECwqmJ+WGP/98Ta7ear6a
	A2wclpkUG9a7vgDZ7MV01bmvhAoqYAD9ECkbau5gHCzf9YnmQt/IiaJJTvrjiZ1ufXImI1Ydt6b
	+RQGSwiRXvXQ+HVUDtMtehvtfZWLTA3GRo40Fz/RzPGpXUSXH373oPbtCvpyBJFCGILC
X-Google-Smtp-Source: AGHT+IFTdiSUv8aCWfQ21lPBWStAPN02ezOZ+Og4jJa+1u9iRjaJMecvYN5PK+pLg6MRN0vhcReSkw==
X-Received: by 2002:a05:6a21:6481:b0:21f:5532:1e49 with SMTP id adf61e73a8af0-21f5532205dmr2501010637.35.1749344866171;
        Sat, 07 Jun 2025 18:07:46 -0700 (PDT)
Received: from thinku.localdomain ([2409:40c2:103a:88af:d97c:9fa4:c832:49bf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0836bdsm3451716b3a.93.2025.06.07.18.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 18:07:45 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: [GSOC PATCH 2/2] builtin/prune: stop depending on 'the_repository'
Date: Sun,  8 Jun 2025 06:36:35 +0530
Message-ID: <9b274efd7dfde90990ace66bfbe5f7e3b6ce30d1.1749343601.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749343601.git.ayu.chandekar@gmail.com>
References: <cover.1749343601.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor builtin/prune.c to remove the dependency on the global
'the_repository'. Replace all the occurrences of 'the_repository' with
repo and thus remove the definition '#define
USE_THE_REPOSITORY_VARIABLE'

Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 builtin/prune.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index dab3c19b6f..2c584a6e0e 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
@@ -64,7 +63,7 @@ static void perform_reachability_traversal(struct rev_info *revs)
 		return;
 
 	if (show_progress)
-		progress = start_delayed_progress(the_repository,
+		progress = start_delayed_progress(revs->repo,
 						  _("Checking connectivity"), 0);
 	mark_reachable_objects(revs, 1, expire, progress);
 	stop_progress(&progress);
@@ -78,7 +77,7 @@ static int is_object_reachable(const struct object_id *oid,
 
 	perform_reachability_traversal(revs);
 
-	obj = lookup_object(the_repository, oid);
+	obj = lookup_object(revs->repo, oid);
 	return obj && (obj->flags & SEEN);
 }
 
@@ -99,7 +98,7 @@ static int prune_object(const struct object_id *oid, const char *fullpath,
 	if (st.st_mtime > expire)
 		return 0;
 	if (show_only || verbose) {
-		enum object_type type = oid_object_info(the_repository, oid,
+		enum object_type type = oid_object_info(revs->repo, oid,
 							NULL);
 		printf("%s %s\n", oid_to_hex(oid),
 		       (type > 0) ? type_name(type) : "unknown");
@@ -154,7 +153,7 @@ static void remove_temporary_files(const char *path)
 int cmd_prune(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repo UNUSED)
+	      struct repository *repo)
 {
 	struct rev_info revs;
 	int exclude_promisor_objects = 0;
@@ -173,19 +172,19 @@ int cmd_prune(int argc,
 	expire = TIME_MAX;
 	save_commit_buffer = 0;
 	disable_replace_refs();
-	repo_init_revisions(the_repository, &revs, prefix);
+	repo_init_revisions(repo, &revs, prefix);
 
 	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
 
-	if (the_repository->repository_format_precious_objects)
+	if (repo->repository_format_precious_objects)
 		die(_("cannot prune in a precious-objects repo"));
 
 	while (argc--) {
 		struct object_id oid;
 		const char *name = *argv++;
 
-		if (!repo_get_oid(the_repository, name, &oid)) {
-			struct object *object = parse_object_or_die(the_repository, &oid,
+		if (!repo_get_oid(repo, name, &oid)) {
+			struct object *object = parse_object_or_die(repo, &oid,
 								    name);
 			add_pending_object(&revs, object, "");
 		}
@@ -200,16 +199,16 @@ int cmd_prune(int argc,
 		revs.exclude_promisor_objects = 1;
 	}
 
-	for_each_loose_file_in_objdir(repo_get_object_directory(the_repository),
+	for_each_loose_file_in_objdir(repo_get_object_directory(repo),
 				      prune_object, prune_cruft, prune_subdir, &revs);
 
 	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);
-	remove_temporary_files(repo_get_object_directory(the_repository));
-	s = mkpathdup("%s/pack", repo_get_object_directory(the_repository));
+	remove_temporary_files(repo_get_object_directory(repo));
+	s = mkpathdup("%s/pack", repo_get_object_directory(repo));
 	remove_temporary_files(s);
 	free(s);
 
-	if (is_repository_shallow(the_repository)) {
+	if (is_repository_shallow(repo)) {
 		perform_reachability_traversal(&revs);
 		prune_shallow(show_only ? PRUNE_SHOW_ONLY : 0);
 	}
-- 
2.49.0

