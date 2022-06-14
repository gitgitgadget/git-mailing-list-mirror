Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F689C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 19:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbiFNT1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 15:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbiFNT1j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 15:27:39 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1300C10548
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 12:27:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a15so12561472wrh.2
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 12:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n/FybgHynVZBfzJ0ZJ1MF3pZGUQ1LYk/5QHlUrASDcs=;
        b=N2M6iAqKmV37AyaoW5UL7xeAcoeOx58Tqz6voM01r3GJQd5yr7p0i/bBBMTVJpYTuR
         +7CDuZGGuhX0Ipfg+GlvtJAS/9WbhrNNcaZcTyry8kCv+d2frzFGOHdujkM7/ze0q44W
         lZqzvcImP7WzHa1Tt+ljlMmX71+NBxlCU1uLV5z14w+qhNm/fU8tbZQHZYiGLYEJoumS
         L4DBDdqvdMYPMEfxXmkFiPbW1f8QVCc1hdaAVs3W9Lfq2Yqk0dyJvkpNfrUhzamqBOdu
         HorQ3QQLcCZeiWXMLkR5je4w83Wy8uyhvp0d/HF60DTiYUFoAvbRQF2UfNbio30yb+bw
         0QMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=n/FybgHynVZBfzJ0ZJ1MF3pZGUQ1LYk/5QHlUrASDcs=;
        b=6XbkGopgR7X4AVVlsZv6/NYfcozAjmgtmSG2VkAluy32akcsbU9XgrTwhjSCvCldH3
         mOXNeFObvDi66IBUCwzyP1/UdJMdu69OlV9XoDpUDptH7YkaerqNQg1qA/FCV0A0IsQr
         u0SncRmWa1j5FqIMXedP8pd+zfcThjbNzX6w7keDKnLUb31Y1m8FZ3VpRLTYANnTOL6X
         gPisFcuu+uyHA5g+deYl7pEdjacf4n3LutxNDlv1OeOWrHjD/cre1waKvF0X/9bny3xz
         KGmMUz5xNFAG71mgks70Kn/1MfC1lLWIbg7PvqFDUb6yinIZ0J4rOWER9/xtDtoHWP8D
         ks6A==
X-Gm-Message-State: AJIora8tPGLO/bJcVZWx3vrKW8UC6GoWC0bqdGsKABEzN3p9xWi25hHS
        eDxl/xGwAMkjXG14SLDsOygopQTvkHkuPw==
X-Google-Smtp-Source: AGRyM1vXtOe/YGYwBpP2w2Az9F7LaxqPMSHGHgQJ2vslq8CqZef+Q/mEq7xaSIzU0meWjICqBTI+Dw==
X-Received: by 2002:a05:6000:1446:b0:218:5a5d:6cb5 with SMTP id v6-20020a056000144600b002185a5d6cb5mr6170426wrx.629.1655234856110;
        Tue, 14 Jun 2022 12:27:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v28-20020adfa1dc000000b0021576694d9dsm12896260wrv.97.2022.06.14.12.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:27:35 -0700 (PDT)
Message-Id: <bf701119edcebd6801dafc1ffa3856ea2fde584a.1655234853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1254.v2.git.1655234853.gitgitgadget@gmail.com>
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
        <pull.1254.v2.git.1655234853.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jun 2022 19:27:29 +0000
Subject: [PATCH v2 1/5] branch: add branch_checked_out() helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
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
 branch.c                  | 36 ++++++++++++++++++++++++++++++++++++
 branch.h                  |  7 +++++++
 t/t2407-worktree-heads.sh | 29 +++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100755 t/t2407-worktree-heads.sh

diff --git a/branch.c b/branch.c
index 2d6569b0c62..42ba60b7cb5 100644
--- a/branch.c
+++ b/branch.c
@@ -10,6 +10,7 @@
 #include "worktree.h"
 #include "submodule-config.h"
 #include "run-command.h"
+#include "strmap.h"
 
 struct tracking {
 	struct refspec_item spec;
@@ -369,6 +370,41 @@ int validate_branchname(const char *name, struct strbuf *ref)
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
+const char *branch_checked_out(const char *refname)
+{
+	prepare_checked_out_branches();
+	return strmap_get(&current_checked_out_branches, refname);
+}
+
 /*
  * Check if a branch 'name' can be created as a new branch; die otherwise.
  * 'force' can be used when it is OK for the named branch already exists.
diff --git a/branch.h b/branch.h
index 560b6b96a8f..ef56103c050 100644
--- a/branch.h
+++ b/branch.h
@@ -101,6 +101,13 @@ void create_branches_recursively(struct repository *r, const char *name,
 				 const char *tracking_name, int force,
 				 int reflog, int quiet, enum branch_track track,
 				 int dry_run);
+
+/*
+ * If the branch at 'refname' is currently checked out in a worktree,
+ * then return the path to that worktree.
+ */
+const char *branch_checked_out(const char *refname);
+
 /*
  * Check if 'name' can be a valid name for a branch; die otherwise.
  * Return 1 if the named branch already exists; return 0 otherwise.
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
new file mode 100755
index 00000000000..305ab46e38e
--- /dev/null
+++ b/t/t2407-worktree-heads.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+test_description='test operations trying to overwrite refs at worktree HEAD'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit init &&
+	git branch -f fake-1 &&
+	git branch -f fake-2 &&
+
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

