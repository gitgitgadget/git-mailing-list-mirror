Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1560C433E1
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 18:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8465C2078A
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 18:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJRRCvhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733236AbgFWSmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733170AbgFWSmc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 14:42:32 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2A7C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 11:42:32 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b5so10488666pfp.9
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 11:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qs1QyijAflaFjlKQK7+BThPuxsrXiovExGrXzCxOucM=;
        b=YJRRCvhXvTNLUlI0ub+bl4Zfi9eB5pB0eJNzAzOren+tN9VpXC7p/wTNzoKX1fZOTc
         dijGrWsCWg5cSsTlBBb5kgvjbo3Y2w8vl9j1MSkTajiVC1Mbyg5rkRGvJP/bkLVBZ1aG
         2bNCSZmQ0SGB0UTpMpaYgveQULI5gYzQGZ4uipwuPtZyZGtxJ/S3wMgBX5FoBYz4uBsk
         Sa8vFdwYIPm1AWh6idil8W6YMs+9m8D1ZkDLwB6kc5HgMF/U/gVNTcmb+1FRhDAzVR8M
         +4huPF6SJy38BCVvF4a2YwTjq4s2HQZCwLnHGdrJALNiM48wgfj6QAFCCUQjIa7P9Y49
         3L6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qs1QyijAflaFjlKQK7+BThPuxsrXiovExGrXzCxOucM=;
        b=VR7dwMhU/fIlThvvX/SmAJAtajURAubXG+TPSCnFJtVps3LuCfeRvVqgYrQifye2zy
         BWcpZILHmvIF10OBhprhVOv+CbgLUPrMOSS/sH0qlrnC09wUvi0oWX36t5hcxWwUZdrt
         5nm+1wnE7340D+1swnsKBgjXhd7x0MlWbgHyb438t9txeU+c1xoQqEJW9NFL+UYHwNgu
         zfON/csDEO9MDNYvzOKSHQXX1Zfzy8QidUDVutHLsNvvnhTr9ir9+Ih7KQ/pCCdv/Nqb
         y7jW67E5jQAS6ha1UnCMRpEZ+Me/i77Ie0vAx3rSN60NNsXv6ttM4F6FRTi8J3jcC8bY
         qcfQ==
X-Gm-Message-State: AOAM532Vfon1mny1zHotgLCjdq7n+RB4xVK73bNnVEtn4OdUTY0xEgZo
        ADMs5PDfntI+ZZ67vRtujLAx2Gv8
X-Google-Smtp-Source: ABdhPJxqitP7kBfHzD/K/t7Etfwl2ygkKOv6mQ07/P+JhEx/VuMTZYHgBC4LRS7JCN75UEb0xGTr9w==
X-Received: by 2002:a65:67d9:: with SMTP id b25mr18668719pgs.311.1592937751253;
        Tue, 23 Jun 2020 11:42:31 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id m10sm2974616pjs.27.2020.06.23.11.42.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2020 11:42:30 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2] commit-reach: avoid is_descendant_of() shim
Date:   Tue, 23 Jun 2020 11:42:22 -0700
Message-Id: <20200623184222.54201-1-carenas@gmail.com>
X-Mailer: git-send-email 2.27.0.288.g4b34aa94c7
In-Reply-To: <20200623081701.52607-1-carenas@gmail.com>
References: <20200623081701.52607-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

d91d6fbf26 (commit-reach: create repo_is_descendant_of(), 2020-06-17)
adds a repository aware version of is_descendant_of() and a backward
compatibility shim that is barely used.

Update all callers to directly use the new repo_is_descendant_of()
function instead; making the codebase simpler and pushing more
the_repository references higher up the stack.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/pull.c        |  3 ++-
 commit-reach.c        | 16 ++++++----------
 commit-reach.h        |  4 +++-
 t/helper/test-reach.c |  2 +-
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 8e6572d305..8159c5d7c9 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1025,7 +1025,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			commit_list_insert(head, &list);
 			merge_head = lookup_commit_reference(the_repository,
 							     &merge_heads.oid[0]);
-			if (is_descendant_of(merge_head, list)) {
+			if (repo_is_descendant_of(the_repository,
+						  merge_head, list)) {
 				/* we can fast-forward this without invoking rebase */
 				opt_ff = "--ff-only";
 				ran_ff = 1;
diff --git a/commit-reach.c b/commit-reach.c
index 1761217663..f846d30f22 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -283,9 +283,9 @@ struct commit_list *repo_get_merge_bases(struct repository *r,
 /*
  * Is "commit" a descendant of one of the elements on the "with_commit" list?
  */
-static int repo_is_descendant_of(struct repository *r,
-				 struct commit *commit,
-				 struct commit_list *with_commit)
+int repo_is_descendant_of(struct repository *r,
+			  struct commit *commit,
+			  struct commit_list *with_commit)
 {
 	if (!with_commit)
 		return 1;
@@ -310,11 +310,6 @@ static int repo_is_descendant_of(struct repository *r,
 	}
 }
 
-int is_descendant_of(struct commit *commit, struct commit_list *with_commit)
-{
-	return repo_is_descendant_of(the_repository, commit, with_commit);
-}
-
 /*
  * Is "commit" an ancestor of one of the "references"?
  */
@@ -433,7 +428,8 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 		return 0;
 
 	commit_list_insert(old_commit, &old_commit_list);
-	ret = is_descendant_of(new_commit, old_commit_list);
+	ret = repo_is_descendant_of(the_repository,
+				    new_commit, old_commit_list);
 	free_commit_list(old_commit_list);
 	return ret;
 }
@@ -554,7 +550,7 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
 {
 	if (filter->with_commit_tag_algo)
 		return contains_tag_algo(commit, list, cache) == CONTAINS_YES;
-	return is_descendant_of(commit, list);
+	return repo_is_descendant_of(the_repository, commit, list);
 }
 
 static int compare_commits_by_gen(const void *_a, const void *_b)
diff --git a/commit-reach.h b/commit-reach.h
index 99a43e8b64..b49ad71a31 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -27,7 +27,9 @@ struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
 
 struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 
-int is_descendant_of(struct commit *commit, struct commit_list *with_commit);
+int repo_is_descendant_of(struct repository *r,
+			  struct commit *commit,
+			  struct commit_list *with_commit);
 int repo_in_merge_bases(struct repository *r,
 			struct commit *commit,
 			struct commit *reference);
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index a0272178b7..1d640f4757 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -108,7 +108,7 @@ int cmd__reach(int ac, const char **av)
 	else if (!strcmp(av[1], "in_merge_bases"))
 		printf("%s(A,B):%d\n", av[1], in_merge_bases(A, B));
 	else if (!strcmp(av[1], "is_descendant_of"))
-		printf("%s(A,X):%d\n", av[1], is_descendant_of(A, X));
+		printf("%s(A,X):%d\n", av[1], repo_is_descendant_of(r, A, X));
 	else if (!strcmp(av[1], "get_merge_bases_many")) {
 		struct commit_list *list = get_merge_bases_many(A, X_nr, X_array);
 		printf("%s(A,X):\n", av[1]);

base-commit: 4b34aa94c75220f6f4cd334b08a3fb053128a32d
-- 
2.27.0.288.g4b34aa94c7

