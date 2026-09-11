Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F8B3C1404
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 05:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789105933; cv=none; b=McPFOLe9WSpBWP6U9KPCXnJ1QimS4izPTLukWflrF6uQaFU11VDtXf9THWPWJqr72ma4PxgxNXOn6ExOryimNgnmT1I7stjg6htFxE3PkpfKJuyRJ74vZgNIhHcVuJwTtoNVxNTCIuf6ryRIenNIWGH93+pAzzBn2tAX15UOneM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789105933; c=relaxed/simple;
	bh=iItYoMqFPs46YW3b+52M3lt7H4oCdbRYpYFtEami2Fk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VtFjDUY6QtfoEML1XjguNAVAE1rZlR6zS5DQqRISaAfSAA/M3Me4J9Y12j/+OPoz5fcVH9IckGYPrO9EYM+DGJcIhWDi747s/HvGOOwpPcP/aXYiXEwnvt8NYVokiWvEXJ/gSjg30Cb9QGPRKp1tXVB7Cp8mEAsbwtAom/6rThs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jhlulHlS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hKlHHbDp; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jhlulHlS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hKlHHbDp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6AD6DEC06E0;
	Fri, 11 Sep 2026 01:52:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 11 Sep 2026 01:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789105927;
	 x=1789192327; bh=mt+/qIQJIq7BWFb+c+vm/C6VzR0555Ed9bwQWwKdpqg=; b=
	jhlulHlSu15qaW7wPRAK2ce1oPHX6n+qwqdSPWySwoEizAF3oJIOe/w75/o4w8Is
	u3eax792QtRRFogkUMmUgXaX+aNNTSy2rmp6CHJItDnJs3jLZ/EH0U7qg1LTKv5O
	hO9UNh2EWwoUJ2KeMzvYnbfc8D3WfRK9bVjgmEyF+MZlanCkl+4LhV0gUnJUrkPZ
	hBtbgKzjU2Z28Ix11bqNN2qUnTTppmiuGS5uyqN8maQYiIiikcgyBDHqb6v0kd1/
	e+zNqaCltecLIUXRNv/+ssWFv8NCyMaE7hAaECKMQG7ZVgZHTiVBOlMsKWeKNlru
	vVEee9pc9Xgs3Pi5B71AIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789105927; x=
	1789192327; bh=mt+/qIQJIq7BWFb+c+vm/C6VzR0555Ed9bwQWwKdpqg=; b=h
	KlHHbDp95iIAs2fMLBzYt8fW+8yl09RSRXgQjUmGiLw690AYxg6D1zZIQD+KcH9R
	UNBST9OjSPXh8bDN77VgM9P6YkSU/SedYQndAJ6UgBC3smNfwFULAtgedBVMIl21
	P9tG66UDM/nSQBuaUuZTi+jEXugyXijTgN+LM6X9TvaFIsjUvvftI0dC0H9b30nC
	NdEF7Ki5CKHYuj7DLFWWU/gIjnv74Y8zprYvIDS5ZGy3jtr0+X7+9Ie7vAqLpwrd
	uWoVjx/Qb2RfJW0gcOUI/UL5rXD8FYZxDZmiC4FljstKPpAak3emkSF2GsAA4qCi
	PSBGc6zQ/buh88D7vRAZQ==
X-ME-Sender: <xms:B5ejahcdzaAhJ7tUmgZAG9Ic1PjoLSuctMIc8ihH5LysV3DhmHAS4w>
    <xme:B5ejamoEfjRb4Pbmq8GZMCmcVrgvXS2gK-MKqovWalK9P8S3hU2aikjyz0MtTR___
    uKDtU2U4aoos0kFfH-4rVG4ZuPS2t40uZFenLdf8S7c7jlQbzCtWG0>
X-ME-Received: <xmr:B5ejan4l1cO7MT3nHvhSyVzSE6y8U-8d9gvAOvbF2A4uNtKStI6iqTVQVCH4Nojy80TlGA>
X-ME-Proxy-Cause: dmFkZTF/5VLZWxN1li1PLNxu4R8NHlST+cwRfiV+TRmfTOf1tjMu51Ms2Kl+4kwwErDkji
    Ex04gZa9FrmtYRh/uSx8X9o2PoZUuwaVmUxBYUaIse/9NbJsyJol2seGGgxJMopEn60rDS
    x/YIvcFYbEuA5awhTibhv/9nXajrUV8j3AzsUm/QyFfhx5wheMlJEVJ0e5kxL77qgE1m86
    SZFlZ/s8Ag2zw7omC55T7b6OA0JhJd/K3A7gCUe0DRCX/Pe3MuwLFCWnWyEBKVM312f6vO
    7aau/PmCHYJzWUJxGQywvozn+/vWhbUTrJmu1Abwfwvz/zJ5XYTgzmsSEha1ht+dgRz2Zc
    XXh9f5W368XYyfBFGwIUdh5ICA8Po6hZ+XbKXE9wk2FclWzTZi+JdSv5BANDUN6TFNGIQV
    sdk/zS4wbQCHAUn4xTj1EilB6uq80JAr7CXJGu8BoEpTAl1/2oLW9EBTFDSW6Nc5UmoR9S
    rRiHkHndi0qcv9XoZ8aunDXutgM/Rand7OdkMa7vvdF9R/pJ1kduovLLu5fEmcV6kVem+3
    GY2Uv0TxID5bot4p20AbS0pJg8q0g3mjJfmVyizl2MIpz3p697AxeOkzzeqyMc4mzzyfHT
    ECPcA7DnfiHQVlq9s+tMRclBXI1uJ+R/V/UM64e2O4rnD8w8UtTHqsONdLew
X-ME-Proxy: <xmx:B5ejakquYp5HzLvbhGJMsEpTV7AvAgRphoqmzTnSp95T8oQVmSrvtw>
    <xmx:B5ejahgtNFsflU2M3epQv021sdBtECp3TFmIKzXjag6lv7EuyPaU9g>
    <xmx:B5ejamJEbCI3NGUTC9TjVjrDBYVLRT6rVM7iLBourQtnmezImYsw-w>
    <xmx:B5ejapAztGF3WIFdEb6itVnXZRecGnGlH5fWED3tJIcGfroz_q7E9Q>
    <xmx:B5ejaiqXC_Q3S4YU3FygUVmfZsueLRGb1hJjyXBXso9UhGoN9noZaPWj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 01:52:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b93f62c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 05:52:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 07:51:50 +0200
Subject: [PATCH v3 07/13] odb: remove infrastructure to register submodule
 sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-registering-in-memory-sources-v3-7-447e6882ed14@pks.im>
References: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
In-Reply-To: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
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
2.55.0.1074.ge7621b4bad.dirty

