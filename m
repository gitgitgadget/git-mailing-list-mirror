Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717B5C77B7A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 14:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjFBO3n (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 10:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbjFBO3e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 10:29:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A438D1BD
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 07:29:24 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f6d7abe934so20013745e9.2
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 07:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685716163; x=1688308163;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ColFtS4Vc2k3Dog1b2cb4PT/WdHuSz6zUxu5fGs5Z+I=;
        b=Rcu0uK/aZCftwk1Jhvnq2a17tXFM3gmKyw5cv7DS/WAOaDeowrpOVieb7q/Ds8Z1/f
         IyanpBWLajbMab9Y5sIJxVvhWJgcRqNV3JSgJ3giRLlJyBDVEEWqu4ppFH5ElCfBxIKW
         3cfjzXKu2Ldm9eovqBD2ykdMtPA02E42MBB9YlpesdHJtMO2QTZSMO9v7DnU3xu2KhyT
         UomMwlti4BJH44bc9o1dXKU+ZeJzOjU4KOP20Gqen+O5TYohvQGzkrszjZVg5oC6jVdm
         4mW5sLgiXaNgSykOFSoVgSgtmKytBOqxo5qOQVlOGEndVDJH7MZzni/pILae3J9qA4qS
         X+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685716163; x=1688308163;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ColFtS4Vc2k3Dog1b2cb4PT/WdHuSz6zUxu5fGs5Z+I=;
        b=Y3zAHKQlaSv8snCMhY3PeiTc4njUvCpi+0VATvFnrDyYDZ2O/Ldn0eDCIrdghYYm6q
         aRjvLYJFd/kjxKN6DgOIfU4v9Iccvo7lBH78lOAT6kWs9Q4wwNbacKit8jml0zcyrOBD
         Nsl8PL+ffyV9t+xoyGZUNiCOdjFUXzmfKphqSIXjgnFHWenoe6RDoZpHHlf1I4q8yTX2
         C+Jx01kZl+I8biomUJ04KURDmLCAArfmBFdLCo7yerrVccrA8JIsvmtE+PPjc9bDFvt6
         EeIjW/iwy0fpK7DOvRB0Qe4siO4G8SKwMKWsiBdYFBcmTA8bMcSmc3oThblbxNP3hfXL
         D/Og==
X-Gm-Message-State: AC+VfDw6I1EpqU4D147q2BZFK/Ybt5IA506Y0eCnBo07VHh/8VvoVN7M
        3JWA7Cxmt0go10y0LnhqhMtsKhkZkwM=
X-Google-Smtp-Source: ACHHUZ4xAoqxten2AzGVaOfsPwIDWjV+QG6QDscCxOQakAj57E52ghPbZvItyGt9M1FOFDCP3CUs9g==
X-Received: by 2002:a05:600c:da:b0:3f6:5cbf:a3a1 with SMTP id u26-20020a05600c00da00b003f65cbfa3a1mr2024911wmm.14.1685716162736;
        Fri, 02 Jun 2023 07:29:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c230800b003f6cf9afc25sm5771781wmo.40.2023.06.02.07.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:29:22 -0700 (PDT)
Message-Id: <4c7dbeb8c6dd6ab4c1903196967d5e0906a293c2.1685716158.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.v2.git.1685716157.gitgitgadget@gmail.com>
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
        <pull.1537.v2.git.1685716157.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Jun 2023 14:29:17 +0000
Subject: [PATCH v2 3/3] repository: create read_replace_refs setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, me@ttaylorr.com, newren@gmail.com,
        gitster@pobox.com, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'read_replace_refs' global specifies whether or not we should
respect the references of the form 'refs/replace/<oid>' to replace which
object we look up when asking for '<oid>'. This global has caused issues
when it is not initialized properly, such as in b6551feadfd (merge-tree:
load default git config, 2023-05-10).

To make this more robust, move its config-based initialization out of
git_default_config and into prepare_repo_settings(). This provides a
repository-scoped version of the 'read_replace_refs' global.

The global still has its purpose: it is disabled process-wide by the
GIT_NO_REPLACE_OBJECTS environment variable or by a call to
disable_replace_refs() in some specific Git commands.

Since we already encapsulated the use of the constant inside
replace_refs_enabled(), we can perform the initialization inside that
method, if necessary. This solves the problem of forgetting to check the
config, as we will check it before returning this value.

There is an interesting behavior change possible here: we now have a
repository-scoped understanding of this config value. Thus, if there was
a command that recurses into submodules and might follow replace refs,
then it would now respect the core.useReplaceRefs config value in each
repository.

'git grep --recurse-submodules' is such a command that recurses into
submodules in-process. We can demonstrate the granularity of this config
value via a test in t7814.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 config.c                           |  5 ----
 replace-object.c                   | 13 ++++++++--
 replace-object.h                   |  8 ------
 repo-settings.c                    |  1 +
 repository.h                       |  9 +++++++
 t/t7814-grep-recurse-submodules.sh | 40 ++++++++++++++++++++++++++++++
 6 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/config.c b/config.c
index 43b0d3fb573..d0ce902af39 100644
--- a/config.c
+++ b/config.c
@@ -1838,11 +1838,6 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (!strcmp(var, "core.usereplacerefs")) {
-		read_replace_refs = git_config_bool(var, value);
-		return 0;
-	}
-
 	/* Add other config variables here and to Documentation/config.txt. */
 	return platform_core_config(var, value, cb);
 }
diff --git a/replace-object.c b/replace-object.c
index cf91c3ba456..c599729a281 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -64,7 +64,7 @@ void prepare_replace_object(struct repository *r)
  * replacement object's name (replaced recursively, if necessary).
  * The return value is either oid or a pointer to a
  * permanently-allocated value.  This function always respects replace
- * references, regardless of the value of read_replace_refs.
+ * references, regardless of the value of r->settings.read_replace_refs.
  */
 const struct object_id *do_lookup_replace_object(struct repository *r,
 						 const struct object_id *oid)
@@ -94,5 +94,14 @@ void disable_replace_refs(void)
 
 int replace_refs_enabled(struct repository *r)
 {
-	return read_replace_refs;
+	if (!read_replace_refs)
+		return 0;
+
+	if (r->gitdir) {
+		prepare_repo_settings(r);
+		return r->settings.read_replace_refs;
+	}
+
+	/* repository has no objects or refs. */
+	return 0;
 }
diff --git a/replace-object.h b/replace-object.h
index b141075023e..8813a75b96e 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -5,14 +5,6 @@
 #include "repository.h"
 #include "object-store.h"
 
-/*
- * Do replace refs need to be checked this run?  This variable is
- * initialized to true unless --no-replace-object is used or
- * $GIT_NO_REPLACE_OBJECTS is set, but is set to false by some
- * commands that do not want replace references to be active.
- */
-extern int read_replace_refs;
-
 struct replace_object {
 	struct oidmap_entry original;
 	struct object_id replacement;
diff --git a/repo-settings.c b/repo-settings.c
index 7b566d729d0..525f69c0c77 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -67,6 +67,7 @@ void prepare_repo_settings(struct repository *r)
 	repo_cfg_bool(r, "pack.usebitmapboundarytraversal",
 		      &r->settings.pack_use_bitmap_boundary_traversal,
 		      r->settings.pack_use_bitmap_boundary_traversal);
+	repo_cfg_bool(r, "core.usereplacerefs", &r->settings.read_replace_refs, 1);
 
 	/*
 	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
diff --git a/repository.h b/repository.h
index c42f7ab6bdc..5315e0852e3 100644
--- a/repository.h
+++ b/repository.h
@@ -39,6 +39,15 @@ struct repo_settings {
 	int pack_read_reverse_index;
 	int pack_use_bitmap_boundary_traversal;
 
+	/*
+	 * Has this repository have core.useReplaceRefs=true (on by
+	 * default)? This provides a repository-scoped version of this
+	 * config, though it could be disabled process-wide via some Git
+	 * builtins or the --no-replace-objects option. See
+	 * replace_refs_enabled() for more details.
+	 */
+	int read_replace_refs;
+
 	struct fsmonitor_settings *fsmonitor; /* lazily loaded */
 
 	int index_version;
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 8143817b19e..d37c83b4640 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -594,4 +594,44 @@ test_expect_success 'grep partially-cloned submodule' '
 	)
 '
 
+test_expect_success 'check scope of core.useReplaceRefs' '
+	git init base &&
+	git init base/sub &&
+
+	echo A >base/a &&
+	echo B >base/b &&
+	echo C >base/sub/c &&
+	echo D >base/sub/d &&
+
+	git -C base/sub add c d &&
+	git -C base/sub commit -m "Add files" &&
+
+	git -C base submodule add ./sub &&
+	git -C base add a b sub &&
+	git -C base commit -m "Add files and submodule" &&
+
+	A=$(git -C base rev-parse HEAD:a) &&
+	B=$(git -C base rev-parse HEAD:b) &&
+	C=$(git -C base/sub rev-parse HEAD:c) &&
+	D=$(git -C base/sub rev-parse HEAD:d) &&
+
+	git -C base replace $A $B &&
+	git -C base/sub replace $C $D &&
+
+	test_must_fail git -C base grep --cached --recurse-submodules A &&
+	test_must_fail git -C base grep --cached --recurse-submodules C &&
+
+	git -C base config core.useReplaceRefs false &&
+	git -C base grep --recurse-submodules A &&
+	test_must_fail git -C base grep --cached --recurse-submodules C &&
+
+	git -C base/sub config core.useReplaceRefs false &&
+	git -C base grep --cached --recurse-submodules A &&
+	git -C base grep --cached --recurse-submodules C &&
+
+	git -C base config --unset core.useReplaceRefs &&
+	test_must_fail git -C base grep --cached --recurse-submodules A &&
+	git -C base grep --cached --recurse-submodules C
+'
+
 test_done
-- 
gitgitgadget
