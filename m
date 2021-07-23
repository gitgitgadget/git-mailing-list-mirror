Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A1DC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A69CB60F22
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhGWSMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 14:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWSL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 14:11:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E760C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 11:52:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f3-20020a25cf030000b029055a2303fc2dso3220248ybg.11
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ak4xjKdzud/nPKaeRqCeyYTaqMC/OJqasefRKpzBQDc=;
        b=lKIoLHkVViGrVLX1Jy+gT/biyHrDfWnfKFNkXwbUrVv1i/WJTv0o1tWHRc4WfeH+6z
         C/jJGFd8j+dMmzxDw59A21lEM7mRiZcFwYfAOrgv/CEskTYdER2LYdUpbyqjvEKywSFf
         YO9TFvifhJ+LKI4Kg7L8i9/XE+nZfimGL0spY8fJmkpNXKdXH5g/eDab1DIy6n2FDhGP
         mSkTH15vlyJG/24cWuj187IzKYj4VvudlV023OIqQpI8LHfVAZ0JAsKrbFLlNZPpiwv2
         w3+KZQwDrsOctBdVLnr/QTNLZt+bjMfdxOqP2kyZFSrtdxOAnrbRlzITQw71XtGELwzH
         VHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ak4xjKdzud/nPKaeRqCeyYTaqMC/OJqasefRKpzBQDc=;
        b=jZdNbNspK9o1JmLnZdW7eEoT5mte6nlscN+o1CEjPMhoQ4HRxgwrW18rADgCgSgsgP
         Slh7K8FYArgRDzStHrVk5QkmEtX3KqC4qbVoaAPtQL/MIkxNtNLFuJx1dHdLSRgXa6tw
         sNyuKG6iYzlcJDQ5QSt20M1uvgLk8H942zF2SJXz1fjGJ4vsAib83h4CHL64PVMfV8hs
         IeG3LstkvdyXmcvK0kws6WZ2lsnKCidiIbtbO4gWocoFkT1wsn0TBPOzqJAVQsuLYo8a
         HO2Sd2+CJYZ2UEsWGHCEp1aB8OBmBDltIOvDGKzoGkh1l+7BoRG0/tKUMA8j6vuHQagk
         2oVg==
X-Gm-Message-State: AOAM532mTNNLr3Pt98FSij84tmj7YhTqhBL6Uf5kCTa2YZEuvkEYtZmn
        kKYOW9BwHsm0bKCJCJxuYaDm/Bk6lHIiHpImIhd2TJbIsdmZl/FFCAoq4muVRyE/QUk0uSifDKB
        koPYDaKjPPwgVyPbHG9w5EN7o3nM5Lr5E4e/p5AWZJTq7BQ7Nqq25dcN6hZJ4YikM1CVyR4vh6J
        LA
X-Google-Smtp-Source: ABdhPJygWHAlSkaSbpMbopEmKqm0Q1h1BqF6HE/+NcJjxatCOD6lOAc/6TtU32EMyhW0NG3C/I4yv8czGKcYvfllc9cJ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:49c2:: with SMTP id
 w185mr6475047yba.294.1627066351431; Fri, 23 Jul 2021 11:52:31 -0700 (PDT)
Date:   Fri, 23 Jul 2021 11:52:23 -0700
In-Reply-To: <cover.1627066238.git.jonathantanmy@google.com>
Message-Id: <f4881b7455b9d33c8a53a91eda7fbdfc5d11382c.1627066238.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1627066238.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH 2/2] cache-tree: prefetch in partial clone read-tree
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git read-tree" checks the existence of the blobs referenced by the
given tree, but does not bulk prefetch them. Add a bulk prefetch.

The lack of prefetch here was noticed at $DAYJOB during a merge
involving some specific commits, but I couldn't find a minimal merge
that didn't also trigger the prefetch in check_updates() in
unpack-trees.c (and in all these cases, the lack of prefetch in
cache-tree.c didn't matter because all the relevant blobs would have
already been prefetched by then). This is why I used read-tree here to
exercise this code path.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache-tree.c                       | 11 ++++++++--
 t/t1022-read-tree-partial-clone.sh | 33 ++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)
 create mode 100755 t/t1022-read-tree-partial-clone.sh

diff --git a/cache-tree.c b/cache-tree.c
index 45e58666af..9ba2c7c6b2 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -237,6 +237,11 @@ int cache_tree_fully_valid(struct cache_tree *it)
 	return 1;
 }
 
+static int must_check_existence(const struct cache_entry *ce)
+{
+	return !(has_promisor_remote() && ce_skip_worktree(ce));
+}
+
 static int update_one(struct cache_tree *it,
 		      struct cache_entry **cache,
 		      int entries,
@@ -378,8 +383,7 @@ static int update_one(struct cache_tree *it,
 		}
 
 		ce_missing_ok = mode == S_IFGITLINK || missing_ok ||
-			(has_promisor_remote() &&
-			 ce_skip_worktree(ce));
+			!must_check_existence(ce);
 		if (is_null_oid(oid) ||
 		    (!ce_missing_ok && !has_object_file(oid))) {
 			strbuf_release(&buffer);
@@ -466,6 +470,9 @@ int cache_tree_update(struct index_state *istate, int flags)
 	if (!istate->cache_tree)
 		istate->cache_tree = cache_tree();
 
+	if (!(flags & WRITE_TREE_MISSING_OK) && has_promisor_remote())
+		prefetch_cache_entries(istate, must_check_existence);
+
 	trace_performance_enter();
 	trace2_region_enter("cache_tree", "update", the_repository);
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
diff --git a/t/t1022-read-tree-partial-clone.sh b/t/t1022-read-tree-partial-clone.sh
new file mode 100755
index 0000000000..a763e27c7d
--- /dev/null
+++ b/t/t1022-read-tree-partial-clone.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+test_description='git read-tree in partial clones'
+
+TEST_NO_CREATE_REPO=1
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'read-tree in partial clone prefetches in one batch' '
+	test_when_finished "rm -rf server client trace" &&
+
+	git init server &&
+	echo foo >server/one &&
+	echo bar >server/two &&
+	git -C server add one two &&
+	git -C server commit -m "initial commit" &&
+	TREE=$(git -C server rev-parse HEAD^{tree}) &&
+
+	git -C server config uploadpack.allowfilter 1 &&
+	git -C server config uploadpack.allowanysha1inwant 1 &&
+	git clone --bare --filter=blob:none "file://$(pwd)/server" client &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client read-tree $TREE &&
+
+	# "done" marks the end of negotiation (once per fetch). Expect that
+	# only one fetch occurs.
+	grep "fetch> done" trace >donelines &&
+	test_line_count = 1 donelines
+'
+
+test_done
-- 
2.32.0.432.gabb21c7263-goog

