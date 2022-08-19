Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F359AC32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 06:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346694AbiHSG5s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 02:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346705AbiHSG5m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 02:57:42 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10EADEB7E
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 23:57:41 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a4so4116361wrq.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 23:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=k+YQm5R+vJvxkKiLzppssk3yy/WO9EqnSCIb1jR/2KU=;
        b=RFYyLFygqYgU+fGpWx5gOcgGHq7/dINMCV4pgfgkmAPfTCql8GpapvD5V4utnnBOWH
         LIJtZsc/aIassjHkUznesgnq34+kKXYF5IqUFORWc7D8BjAjLhMWWnB41cFwIJ3U/mRl
         5FKFgq/ruXEgJ0/xz31R9NaB8MJzlJvfzd3qRSGYPnpPGdz1YPLgbg9C3L7Rw7GCiqf/
         5rkqs+FKjdxVnRT561idxe/MseAfixQfWGKiJbSBxlqvp19zdXvaPGyn5EDgsAYh1V9Q
         Gqv1/UINBfPSSPsK1Ntmq9b100RVw4Npye2OfInseQh67o3YzuXqU+ZNEGM0WSc5yOMj
         ZO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=k+YQm5R+vJvxkKiLzppssk3yy/WO9EqnSCIb1jR/2KU=;
        b=n6YLBPfO/9j47v/VvYLQugneKsIVXwtrjRANFy8CynkJhIhH7Z81oZG30OvAYoyPz4
         vH2J35v5RdLGD3DBMfBq3t3SBw09P0dIUUFkPzihdk7A3kgg8eA379JPzMKnw31WtxCC
         koSxanygax9+mvpOagjQQfLu4+5ReDjO/aHBnU5mAtWhRDa7GUzhDMaLHRGyeWKQyEGk
         WwNxtbYKvLS2RPb4WfHPQkVFMMo3Z/1HJHwqUPeMDPdDiSV91Y9R5M6hfh6IpG6G8Yfi
         caj/dVN55X7KcGN2lMjBnMLkDoSN8cxHorzUCPgU6jmuwwY6HRrtKDeRB2GI81TtRYNa
         jSyA==
X-Gm-Message-State: ACgBeo2aGdcOmMNo4X6ToXdpzvdU/mx/srTjofCcwD9n0ZcV8rDc/efW
        7gizjZgRKbYqVRfyHCzkasAks1OW1J4=
X-Google-Smtp-Source: AA6agR6giIA0c2GTLdXqjM79dzhIK071RHVTrsPcdi7jOUySGNi+862QcN9USIndneHKMXxwK8dcSw==
X-Received: by 2002:a5d:47c4:0:b0:21f:e92:7ba1 with SMTP id o4-20020a5d47c4000000b0021f0e927ba1mr3242531wrc.408.1660892259867;
        Thu, 18 Aug 2022 23:57:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2-20020a1cc902000000b003a5f783abb8sm7461083wmb.30.2022.08.18.23.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:57:39 -0700 (PDT)
Message-Id: <3aa390f3007f7f15e780bc9b36159846104be32e.1660892256.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1327.git.1660892256.gitgitgadget@gmail.com>
References: <pull.1327.git.1660892256.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Aug 2022 06:57:35 +0000
Subject: [PATCH 2/3] merge-tree: show the original file names in the conflict
 output
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When showing the conflict output in an `ls-files -u`-style form, it
makes sense to show conflicted files' names in the form that they were
written on disk (for example, in case of a file/directory conflict, we
would have written the file under a different name by appending a
`~<branch>` suffix).

However, when the intention is to perform a worktree-less merge, this
makes less sense, and causes more confusion than is necessary. Let's
show the original file names instead.

This patch also fixes a bug where the output of conflicts involving a
rename did not always show the correct file name for the respective
stages.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/merge-tree.c             |  2 +-
 merge-ort.c                      |  2 +-
 merge-ort.h                      |  1 +
 t/t4301-merge-tree-write-tree.sh | 18 +++++++++---------
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index ae5782917b9..8cd9ce399aa 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -454,8 +454,8 @@ static int real_merge(struct merge_tree_options *o,
 
 		merge_get_conflicted_files(&result, &conflicted_files);
 		for (i = 0; i < conflicted_files.nr; i++) {
-			const char *name = conflicted_files.items[i].string;
 			struct stage_info *c = conflicted_files.items[i].util;
+			const char *name = c->path;
 			if (!o->name_only)
 				printf("%06o %s %d\t",
 				       c->mode, oid_to_hex(&c->oid), c->stage);
diff --git a/merge-ort.c b/merge-ort.c
index 211f6823e1d..ed72d2e338e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4488,7 +4488,7 @@ void merge_get_conflicted_files(struct merge_result *result,
 			if (!(ci->filemask & (1ul << i)))
 				continue;
 
-			si = xmalloc(sizeof(*si));
+			FLEX_ALLOC_STR(si, path, ci->pathnames[i]);
 			si->stage = i+1;
 			si->mode = ci->stages[i].mode;
 			oidcpy(&si->oid, &ci->stages[i].oid);
diff --git a/merge-ort.h b/merge-ort.h
index a994c9a5fcd..595031fbab9 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -94,6 +94,7 @@ struct stage_info {
 	struct object_id oid;
 	int mode;
 	int stage;
+	const char path[FLEX_ARRAY];
 };
 
 /*
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index e0ef9724b2b..e08452a8531 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -125,7 +125,7 @@ test_expect_success 'test conflict notices and such' '
 	cat <<-EOF >expect &&
 	HASH
 	greeting
-	whatever~side1
+	whatever
 
 	Auto-merging greeting
 	CONFLICT (content): Merge conflict in greeting
@@ -153,7 +153,7 @@ test_expect_success 'Just the conflicted files without the messages' '
 	test_expect_code 1 git merge-tree --write-tree --no-messages --name-only side1 side2 >out &&
 	anonymize_hash out >actual &&
 
-	test_write_lines HASH greeting whatever~side1 >expect &&
+	test_write_lines HASH greeting whatever >expect &&
 
 	test_cmp expect actual
 '
@@ -168,14 +168,14 @@ test_expect_success 'Check conflicted oids and modes without messages' '
 	100644 HASH 1Qgreeting
 	100644 HASH 2Qgreeting
 	100644 HASH 3Qgreeting
-	100644 HASH 1Qwhatever~side1
-	100644 HASH 2Qwhatever~side1
+	100644 HASH 1Qwhatever
+	100644 HASH 2Qwhatever
 	EOF
 
 	test_cmp expect actual &&
 
 	# Check the actual hashes against the `ls-files -u` output too
-	tail -n +2 out | sed -e s/side1/HEAD/ >actual &&
+	tail -n +2 out | sed -e s/whatever/whatever~HEAD/ >actual &&
 	test_cmp conflicted-file-info actual
 '
 
@@ -200,11 +200,11 @@ test_expect_success 'NUL terminated conflicted file "lines"' '
 	100644 HASH 1Qgreeting
 	100644 HASH 2Qgreeting
 	100644 HASH 3Qgreeting
-	100644 HASH 1Qwhatever~tweak1
-	100644 HASH 2Qwhatever~tweak1
-	100644 HASH 1QΑυτά μου φαίνονται κινέζικα
+	100644 HASH 1Qwhatever
+	100644 HASH 2Qwhatever
+	100644 HASH 1Qnumbers
 	100644 HASH 2QΑυτά μου φαίνονται κινέζικα
-	100644 HASH 3QΑυτά μου φαίνονται κινέζικα
+	100644 HASH 3Qnumbers
 
 	EOF
 
-- 
gitgitgadget

