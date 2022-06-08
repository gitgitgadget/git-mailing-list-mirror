Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D24C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 20:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbiFHUJO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 16:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiFHUJI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 16:09:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284F248321
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 13:09:07 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id s1so6622742wra.9
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 13:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R3V855V+ISCUa1svxDwCezUG4lO07M4yYlLGx6Lk2ow=;
        b=E9aD1TUJUuMPpDTs+ygdaA1VVf5oyJSnQM5r3v70d4udF5aMwsk1yMGWdz4bXakgPM
         aUNjFyhOOqn4vgyLZgZaB7vWIf2UXAtSDxHlC3yWkU9qa+iRHYz05ugsAKhQQbouOWmt
         WmDngVipB1yZHZQdOAVhGG5bbh3PVILoTwsaRugfvVuMR69SjFN1SY5yQqKuitxO4cQt
         xGyPZcv1d7RMjYlfHwUwAUO1nT6tsd78jBDoiZMsD2b09pqnBYSAOOISwtE0IzBOKGhX
         n5A32L5KKvGwI4HsWzxFLj0DY//uy9v6n7sWNemji34x5Xg9+rX/CGiTVLnyndQqZy70
         1J+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R3V855V+ISCUa1svxDwCezUG4lO07M4yYlLGx6Lk2ow=;
        b=1Rz3VDUXwPzgiLdXEZZlYUg2ujzbRT7R0+CHIf/u0+E+AhEnWHBPJZQfmU/sNLOJcJ
         qUw7tdhXM9cTEwx8+vev/dDFxMoCj1wpmESYrZ9eP1sK+ZK/i7+FbHdZ1GsaVNyCh0YA
         8b50ikBbywC+spBD7GnPmjsFxmPXguOZp+QVJVOd3Cz2Z9iGG5ZUxTiwx6WVHiMYMkDz
         4qK8h0brWAst9Ytj27LU6C/999v3WxnlNI1/rv2glDDsYu20A7hA0cgPKekWFkmBPGRb
         Za2rNsoL1k96Tzn0Jp8BtThQCJiKl32nE5cYgO0QCMH8BdVXasH9Hnd2VJqG9XwJXgeQ
         Q1Ew==
X-Gm-Message-State: AOAM530c6O4SiRHqVx3uYaWrTn0UDyxJ1OITWu8B0zGTUS8PpnQrRymc
        ArmmmST2DPGnmKwfEwslpPo6JbRHXramR89k
X-Google-Smtp-Source: ABdhPJyPiZbBEvOtPkBbno19GWzSDSLyMN0ca91gezHOi8Yh5t+3xN1HZ7BOxOaJ1+ZDVTtFlT5pJQ==
X-Received: by 2002:adf:b358:0:b0:216:508c:e0bf with SMTP id k24-20020adfb358000000b00216508ce0bfmr23516102wrd.204.1654718945386;
        Wed, 08 Jun 2022 13:09:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d6547000000b0021020517639sm22880091wrv.102.2022.06.08.13.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 13:09:04 -0700 (PDT)
Message-Id: <dbb7eae390c90d4b710f48d8875bd7db0409aea3.1654718942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Jun 2022 20:08:59 +0000
Subject: [PATCH 1/4] branch: add branch_checked_out() helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The validate_new_branchname() method contains a check to see if a branch
is checked out in any non-bare worktree. This is intended to prevent a
force push that will mess up an existing checkout. This helper is not
suitable to performing just that check, because the method will die()
when the branch is checked out instead of returning an error code.

Create a new branch_checked_out() helper that performs the most basic
form of this check. To ensure we can call branch_checked_out() in a loop
with good performance, do a single preparation step that iterates over
all worktrees and stores their current HEAD branches in a strmap. The
branch_checked_out() helper can then discover these branches using a
hash lookup.

This helper is currently missing some key functionality. Namely: it
doesn't look for active rebases or bisects which mean that the branch is
"checked out" even though HEAD doesn't point to that ref. This
functionality will be added in a coming change.

We could use branch_checked_out() in validate_new_branchname(), but this
missing functionality would be a regression. However, we have no tests
that cover this case!

Add a new test script that will be expanded with these cross-worktree
ref updates. The current tests would still pass if we refactored
validate_new_branchname() to use this version of branch_checked_out().
The next change will fix that functionality and add the proper test
coverage.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 branch.c                  | 42 +++++++++++++++++++++++++++++++++++++++
 branch.h                  |  8 ++++++++
 t/t2407-worktree-heads.sh | 24 ++++++++++++++++++++++
 3 files changed, 74 insertions(+)
 create mode 100755 t/t2407-worktree-heads.sh

diff --git a/branch.c b/branch.c
index 2d6569b0c62..061a11f3415 100644
--- a/branch.c
+++ b/branch.c
@@ -10,6 +10,7 @@
 #include "worktree.h"
 #include "submodule-config.h"
 #include "run-command.h"
+#include "strmap.h"
 
 struct tracking {
 	struct refspec_item spec;
@@ -369,6 +370,47 @@ int validate_branchname(const char *name, struct strbuf *ref)
 	return ref_exists(ref->buf);
 }
 
+static int initialized_checked_out_branches;
+static struct strmap current_checked_out_branches = STRMAP_INIT;
+
+static void prepare_checked_out_branches(void)
+{
+	int i = 0;
+	struct worktree **worktrees;
+
+	if (initialized_checked_out_branches)
+		return;
+	initialized_checked_out_branches = 1;
+
+	worktrees = get_worktrees();
+
+	while (worktrees[i]) {
+		struct worktree *wt = worktrees[i++];
+
+		if (wt->is_bare)
+			continue;
+
+		if (wt->head_ref)
+			strmap_put(&current_checked_out_branches,
+				   wt->head_ref,
+				   xstrdup(wt->path));
+	}
+
+	free_worktrees(worktrees);
+}
+
+int branch_checked_out(const char *refname, char **path)
+{
+	const char *path_in_set;
+	prepare_checked_out_branches();
+
+	path_in_set = strmap_get(&current_checked_out_branches, refname);
+	if (path_in_set && path)
+		*path = xstrdup(path_in_set);
+
+	return !!path_in_set;
+}
+
 /*
  * Check if a branch 'name' can be created as a new branch; die otherwise.
  * 'force' can be used when it is OK for the named branch already exists.
diff --git a/branch.h b/branch.h
index 560b6b96a8f..5ea93d217b1 100644
--- a/branch.h
+++ b/branch.h
@@ -101,6 +101,14 @@ void create_branches_recursively(struct repository *r, const char *name,
 				 const char *tracking_name, int force,
 				 int reflog, int quiet, enum branch_track track,
 				 int dry_run);
+
+/*
+ * Returns true if the branch at 'refname' is checked out at any
+ * non-bare worktree. The path of the worktree is stored in the
+ * given 'path', if provided.
+ */
+int branch_checked_out(const char *refname, char **path);
+
 /*
  * Check if 'name' can be a valid name for a branch; die otherwise.
  * Return 1 if the named branch already exists; return 0 otherwise.
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
new file mode 100755
index 00000000000..dd905dc1a5c
--- /dev/null
+++ b/t/t2407-worktree-heads.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+test_description='test operations trying to overwrite refs at worktree HEAD'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	for i in 1 2 3 4
+	do
+		test_commit $i &&
+		git branch wt-$i &&
+		git worktree add wt-$i wt-$i || return 1
+	done
+'
+
+test_expect_success 'refuse to overwrite: checked out in worktree' '
+	for i in 1 2 3 4
+	do
+		test_must_fail git branch -f wt-$i HEAD 2>err
+		grep "cannot force update the branch" err || return 1
+	done
+'
+
+test_done
-- 
gitgitgadget

