Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB9847CC97
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260991; cv=none; b=MPGnd3/KFntvrHm/x+I/L2jEDO9qehE0ezgCcsmaFF5rrhKrVzgaHnQNroLzIKrEmArHmIYEGlWScdni9kaowpUCAlbbVKcMfEFGbaBmvFOY7q4nP4AznM16v7p+J6aoWLKZNvRGsnjoWC6AERHqtsnxD8p3/i58lgjvG8dZFZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260991; c=relaxed/simple;
	bh=RIqLVBkeeyTtgu2eMcoud/ISO9lq9vnccaqM4fI+wpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bx34i2f6beya0/+WNFsyBn5NDn1REdM+ImN3ZAGTafHAHP/yrrcEpxIM/6P61Egkke3UtmW1jaRlqjzYD6MAGlKIyXpT5GfVQ1NyqED+mkQ/2tOSoGerDdNaqPzEM8eNXHJ/LddpVMEaWDp1vUU0hzKQVerGwSq0qav7IW8VgKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M6GGfALK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jIz9Xmh9; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M6GGfALK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jIz9Xmh9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0FFA5140004E
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 07:09:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 01 Sep 2026 07:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788260989;
	 x=1788347389; bh=ajrMtw8j4R53XYKIE+8BGi1AxRELjmiF+gb/wyQ5LIw=; b=
	M6GGfALKRMSQF2OpXtPioTVZTCjWHWhKiuuP+EpzGRtilxawv1FrukFcba4uBceW
	ja0LnIO8rpPxAC2H8eztQNc+kYMxLJsbclY0scHDc7qxzujoYK2m8q/L64n8eITv
	bquTzJP+EzQhqoYiM9NHjKlj+4r2T2L7LZPPz1wuXecxVHFKlWhzCpobzhJnuvHz
	XB75BrzIY92VfHh1R9OGY7YjneqbESvayR5Bb6ZTK5pgJ3ILqMSHxbnZ98e+gvt8
	u3N1RQtcTPYgOc4zsNd0HTmSp6X8cxYYBVcNV23VbDTRyUA/G5GQZGWFpOdZAEVl
	MCM8Wo5dJbcjL9dyi87lag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788260989; x=
	1788347389; bh=ajrMtw8j4R53XYKIE+8BGi1AxRELjmiF+gb/wyQ5LIw=; b=j
	Iz9Xmh9LYPyjPqulIrkegVOMAXkIqk/Ua7DZifsrarjuIH9pFLGU6QBJ5rprChR0
	ecOC3bOV2xDXLK/lR3+8eoHlDhH9Kd6K37PEKAhvRTPyGx66oNJUCYuonDKclNzT
	PveSHwm4bUEnm3vyF1Q3lK35vaiuiQGLwO0ceHEiDtZcc425rzhYoXLr6SEYprJR
	Lgwo9WybIcbRbDrdbi+YFa6q0Y0x4LJChDDTr9Y6h4pfX/yD85tlXKjuNe3CQLxz
	GFGVAq5HHekqeCpK5pjqKY5tbN5t9r66TGiiSPDUYPgGwzYbpxR62fPfxcqsNBxs
	x+08DXtMjB/RYCQI1NS2w==
X-ME-Sender: <xms:fLKWariSWeqFib_ViREXEhUBPook7-rOWLOqaDLZpiA2puoLol_TWA>
    <xme:fLKWau_cNLqfPFDxsujiCjyFg8yi-lCN2VIzyvJiOTsKCLgaKaeEEuJwXO93Ked9B
    e_21-TA5BQPXW8BnsMWfbNOftnY4ClbXtAA9wcTSphP_QUFh1zp1A>
X-ME-Received: <xmr:fLKWags3dzGjG5zR22aBluIHCBRw7Nzl7vXVZbiI7-M4WNca_aGtHA>
X-ME-Proxy-Cause: dmFkZTGkwAxdD3rfUrEN+Zrml2ZOe3GlKEB8iLKVrBKaiZHxGwvIv5VuWz2Ym2XRZ6WG68
    X8B4CErn+WGUoj8xkMlDafNSIL8R++ncZ/BkYo+9LSjWcNiOd/wKVagO0zk8Wy8D4hwSHa
    6r3/+lbOAcajyrrP3cx40NutZ94zNfpwXu11m1jJ56e1KTGJELUAYyb3kCdo6TvqrMeH1T
    r2C/qu7V4Ni7HQhWiQJWEDv0H/4x5qUAyuf+ct1axIeQrKgYw/Usvtg1+BZrZKiXuOFfxh
    XiBb/5MSpVsLfY3iA9qGT34FuwQFfcaCw+S2g8Y8smfYRw55SQddZygbhU5Wjf5vnhJrTn
    NavKANnNivbj6VqGpqsOa50UMXveXIEo9pFP8jLWUJcc+obiN09XRe9mrqmSG7Bi1pzp7+
    TFVoZJ67ugenqSCat9jKxeV+F8rnoIe7fWJ2Z9U047x1Yl9hmyEKRUJVPCS48VM6v4nHWp
    5YaBRPL2N7jf2QlGr0trZqmjrY8WvbBi5d9JWxC2IaSBEmbTfPKHRasLmupiOC/ehUL/3M
    yJr0JrIYl3ycmJwi4Kskv7z3utQpVsdSeAdsmP6D77P387ilqEeuDdh+1p+4BazE7SxcfY
    R8GSc0FaT6amDuuzyQg4ekE0hOL43fJPnvqpU3FnxjykgsDR1FafOATWtt7w
X-ME-Proxy: <xmx:fLKWatbSz9tRCiG2Er4lDR4KG2ReZgnUj8j8Emxhx7vpAkbTBvudhQ>
    <xmx:fbKWaor-VeFX1cT8nFjDsoqolZcZ0VPGSKVi-j9k2L03EdpW1NAeBg>
    <xmx:fbKWaq9JMEkFUqWb4R4Yygj6rvx1cT-F-ctuR1GhDu98k03MnR3FNA>
    <xmx:fbKWav-iFUqRJbMFi8ek0xuZN6JLpjFmDINoKWLJn9XwkAQI-sX8ag>
    <xmx:fbKWasiDVpoEk3t8Il24KA-7i9QX8rYrDr1WQAvToUxjvc3Aslq8vqRn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 1 Sep 2026 07:09:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 66b7fc11 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 1 Sep 2026 11:09:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Sep 2026 13:09:05 +0200
Subject: [PATCH 06/12] odb: remove infrastructure to register submodule
 sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-pks-odb-registering-in-memory-sources-v1-6-97a312d5fa25@pks.im>
References: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
In-Reply-To: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The preceding commits have removed the last two users of
`odb_add_submodule_source_by_path()`. The mechanism was only ever
meant as a transitional crutch while migrating submodule object
access away from "add the submodule ODB as an alternate of
the_repository" towards explicitly passing the submodule repository,
see a35e03dee0 (submodule: lazily add submodule ODBs as alternates,
2021-08-16). Remove it.

As GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB is now a no-op, remove its
documentation and the exports from the test suite, as well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c                                  | 36 ----------------------------------
 odb.h                                  | 14 -------------
 t/README                               |  7 -------
 t/t5526-fetch-submodules.sh            |  3 ---
 t/t5531-deep-submodule-push.sh         |  3 ---
 t/t5545-push-options.sh                |  3 ---
 t/t5572-pull-submodule.sh              |  3 ---
 t/t6437-submodule-merge.sh             |  3 ---
 t/t7418-submodule-sparse-gitmodules.sh |  3 ---
 t/t7814-grep-recurse-submodules.sh     |  3 ---
 10 files changed, 78 deletions(-)

diff --git a/odb.c b/odb.c
index 6d5943e5ea..2f8a70a90c 100644
--- a/odb.c
+++ b/odb.c
@@ -388,12 +388,6 @@ struct odb_source *odb_find_source_or_die(struct object_database *odb, const cha
 	return source;
 }
 
-void odb_add_submodule_source_by_path(struct object_database *odb,
-				      const char *path)
-{
-	string_list_insert(&odb->submodule_source_paths, path);
-}
-
 static void fill_alternate_refs_command(struct repository *repo,
 					struct child_process *cmd,
 					const char *repo_path)
@@ -549,23 +543,6 @@ void disable_obj_read_lock(void)
 	pthread_mutex_destroy(&obj_read_mutex);
 }
 
-static int register_all_submodule_sources(struct object_database *odb)
-{
-	int ret = odb->submodule_source_paths.nr;
-
-	for (size_t i = 0; i < odb->submodule_source_paths.nr; i++)
-		odb_add_to_alternates_memory(odb,
-					     odb->submodule_source_paths.items[i].string);
-	if (ret) {
-		string_list_clear(&odb->submodule_source_paths, 0);
-		trace2_data_intmax("submodule", odb->repo,
-				   "register_all_submodule_sources/registered", ret);
-		if (git_env_bool("GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB", 0))
-			BUG("register_all_submodule_sources() called");
-	}
-	return ret;
-}
-
 static enum odb_read_status do_oid_object_info_extended(struct object_database *odb,
 							const struct object_id *oid,
 							struct object_info *oi, unsigned flags)
@@ -614,16 +591,6 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 			}
 		}
 
-		/*
-		 * This might be an attempt at accessing a submodule object as
-		 * if it were in main object store (having called
-		 * `odb_add_submodule_source_by_path()` on that submodule's
-		 * ODB). If any such ODBs exist, register them and try again.
-		 */
-		if (register_all_submodule_sources(odb))
-			/* We added some alternates; retry */
-			continue;
-
 		/* Check if it is a missing object */
 		if (odb->repo->fetch_if_missing && repo_has_promisor_remote(odb->repo) &&
 		    !already_retried &&
@@ -1109,7 +1076,6 @@ struct object_database *odb_new(struct repository *repo,
 	CALLOC_ARRAY(o, 1);
 	o->repo = repo;
 	pthread_mutex_init(&o->replace_mutex, NULL);
-	string_list_init_dup(&o->submodule_source_paths);
 	hashmap_init(&o->source_by_path, odb_source_by_path_cmp, o, 0);
 	o->source_paths_icase = -1;
 
@@ -1166,8 +1132,6 @@ void odb_free(struct object_database *o)
 	odb_close(o);
 	odb_free_sources(o);
 
-	string_list_clear(&o->submodule_source_paths, 0);
-
 	free(o);
 }
 
diff --git a/odb.h b/odb.h
index 248ee9cdfa..54548efc55 100644
--- a/odb.h
+++ b/odb.h
@@ -89,12 +89,6 @@ struct object_database {
 	unsigned long object_count;
 	unsigned object_count_flags;
 	unsigned object_count_valid : 1;
-
-	/*
-	 * Submodule source paths that will be added as additional sources to
-	 * allow lookup of submodule objects via the main object database.
-	 */
-	struct string_list submodule_source_paths;
 };
 
 enum odb_new_flags {
@@ -224,14 +218,6 @@ void odb_restore_primary_source(struct object_database *odb,
 				struct odb_source *restore_source,
 				const char *old_path);
 
-/*
- * Call odb_add_submodule_source_by_path() to add the submodule at the given
- * path to a list. The object stores of all submodules in that list will be
- * added as additional sources in the object store when looking up objects.
- */
-void odb_add_submodule_source_by_path(struct object_database *odb,
-				      const char *path);
-
 /*
  * Iterate through all alternates of the database and execute the provided
  * callback function for each of them. Stop iterating once the callback
diff --git a/t/README b/t/README
index 9a9daaf2af..f831c5355b 100644
--- a/t/README
+++ b/t/README
@@ -462,13 +462,6 @@ GIT_TEST_CHECKOUT_WORKERS=<n> overrides the 'checkout.workers' setting
 to <n> and 'checkout.thresholdForParallelism' to 0, forcing the
 execution of the parallel-checkout code.
 
-GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=<boolean>, when true, makes
-registering submodule ODBs as alternates a fatal action. Support for
-this environment variable can be removed once the migration to
-explicitly providing repositories when accessing submodule objects is
-complete or needs to be abandoned for whatever reason (in which case the
-migrated codepaths still retain their performance benefits).
-
 GIT_TEST_REQUIRE_PREREQ=<list> allows specifying a space separated list of
 prereqs that are required to succeed. If a prereq in this list is triggered by
 a test and then fails then the whole test run will abort. This can help to make
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 7b3b7359da..37d7373b36 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -3,9 +3,6 @@
 
 test_description='Recursive "git fetch" for submodules'
 
-GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
-export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
-
 . ./test-lib.sh
 
 pwd=$(pwd)
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 7d239dd31f..73429ec6e3 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -5,9 +5,6 @@ test_description='test push with submodules'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
-export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
-
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index fb13549da7..239edd7d62 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -5,9 +5,6 @@ test_description='pushing to a repository using push options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
-export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
-
 . ./test-lib.sh
 
 mk_repo_pair () {
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index 42d14328b6..9969a3294e 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -2,9 +2,6 @@
 
 test_description='pull can handle submodules'
 
-GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
-export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
-
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index 107e13afbc..1546d5f773 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -5,9 +5,6 @@ test_description='merging with submodules'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
-export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
-
 . ./test-lib.sh
 
 #
diff --git a/t/t7418-submodule-sparse-gitmodules.sh b/t/t7418-submodule-sparse-gitmodules.sh
index dde11ecce8..cf94e30e78 100755
--- a/t/t7418-submodule-sparse-gitmodules.sh
+++ b/t/t7418-submodule-sparse-gitmodules.sh
@@ -12,9 +12,6 @@ The test setup uses a sparse checkout, however the same scenario can be set up
 also by committing .gitmodules and then just removing it from the filesystem.
 '
 
-GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
-export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
-
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index e1cf53dc9e..3d149d34c1 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -9,9 +9,6 @@ submodules.
 TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
-GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
-export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
-
 test_expect_success 'setup directory structure and submodule' '
 	echo "(1|2)d(3|4)" >a &&
 	mkdir b &&

-- 
2.55.0.979.g7e5102b832.dirty

