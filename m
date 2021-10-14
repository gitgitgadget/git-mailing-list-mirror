Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF2AC433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 17:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F8D61156
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 17:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhJNR2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 13:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhJNR2B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 13:28:01 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B412DC061753
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 10:25:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u8-20020a05600c440800b0030d90076dabso47854wmn.1
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 10:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fox/BpQ4csSYhffpTbOQDdeuG8XoSrrZp4I5oWpsy4M=;
        b=C0HdlEAXUP6engSteihFqnYBuOYBRpzkbXcc8nP9iNpomc+AO9M0VkySljgG32a8E9
         CMWfF22vJKujfIv9yXavZwiFz7Fy6y1hUMM92CKD3lrnpJ/9BcOVsam8llle7E9ABNq5
         THgUa6whVgHrbHf9jnkTpTt1EQc6cWs7ox8aYZQ5Dy6zGCs4K4pCTTM2+N7Bm3ssejj7
         oGLtcbvVCjEgP+rMhEmctdCqdJhWb2aLLKpGZ+8dBqRHIgwe9eEvgmvIEs9a+cC78TFo
         7N6/iIiUqUJqIXZsLnAYDfhDOMW5kZLlQtEH7BDCpHw2OhZBVPrlg28ar+8XVox9+AIU
         lJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Fox/BpQ4csSYhffpTbOQDdeuG8XoSrrZp4I5oWpsy4M=;
        b=XNAjRUJbr3olZQBd3JRmadZEQ1kroWPIImFmeG5QTBgwwuZlGEmphe/oKiWPRo6jyN
         XxoNqrAHzWmIRAp7tBRq5XW9bugqV9dGXf72qWYut8elGjhYlgZLODdyR2laLbV6tjx0
         5YN2wigBW/I4bEmhfjqclj3HeVgxGWldL4J/RAA+MrxwFlrFGfwFDGOSnxXA98eU7KGo
         yLiQvDsAgH+SJr9tU0qz8L9ILqHIUJFQLqLy5FhPZGBoCxlpjuEnmX1NJnGZhIL50fm7
         Q/sOA10sMqq+wl8i9aoM6J3aVxVvdqHTa6fp4EVrD+U/Duzu0++lAEqsp3xIlTB9atLg
         e1Kg==
X-Gm-Message-State: AOAM530tJq9eSAJrKOr587x3J5TWcLFmJe3PSRFWaWe38HhhLaLUJ+XB
        4oDjoSoVpVRtq74PhLU2Pxf5UYFbKeg=
X-Google-Smtp-Source: ABdhPJz7BN+t4BFcTUl9KY03/GgAD3Lqtd3RS0mgfhhbEEZOHO5nDafEvlcaE2X+4m20xk+LT9L9Ew==
X-Received: by 2002:a1c:4e0f:: with SMTP id g15mr21498332wmh.54.1634232355355;
        Thu, 14 Oct 2021 10:25:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d1sm3047486wrr.72.2021.10.14.10.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 10:25:55 -0700 (PDT)
Message-Id: <9a597233cf4127e97ac9f680f540c7c9a9304211.1634232353.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.git.1634232352.gitgitgadget@gmail.com>
References: <pull.1050.git.1634232352.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 14 Oct 2021 17:25:51 +0000
Subject: [PATCH 1/2] diff: enable and test the sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Enable the sparse index within the 'git diff' command. Its implementation
already safely integrates with the sparse index because it shares code with
the 'git status' and 'git checkout' commands that were already integrated.
The most interesting thing to do is to add tests that verify that 'git diff'
behaves correctly when the sparse index is enabled. These cases are:

1. The index is not expanded for 'diff' and 'diff --staged'
2. 'diff' and 'diff --staged' behave the same in full checkout, sparse
checkout, and sparse index repositories in the following partially-staged
scenarios (i.e. the index, HEAD, and working directory differ at a given
path):
    1. Path is within sparse-checkout cone
    2. Path is outside sparse-checkout cone
    3. A merge conflict exists for paths outside sparse-checkout cone

The `p2000` tests demonstrate a ~30% execution time reduction for 'git
diff' and a ~75% execution time reduction for 'git diff --staged' using a
sparse index:

Test                                      before  after
-------------------------------------------------------------
2000.30: git diff (full-v3)               0.37    0.36 -2.7%
2000.31: git diff (full-v4)               0.36    0.35 -2.8%
2000.32: git diff (sparse-v3)             0.46    0.30 -34.8%
2000.33: git diff (sparse-v4)             0.43    0.31 -27.9%
2000.34: git diff --staged (full-v3)      0.08    0.08 +0.0%
2000.35: git diff --staged (full-v4)      0.08    0.08 +0.0%
2000.36: git diff --staged (sparse-v3)    0.17    0.04 -76.5%
2000.37: git diff --staged (sparse-v4)    0.16    0.04 -75.0%

Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 builtin/diff.c                           |  3 ++
 t/perf/p2000-sparse-operations.sh        |  2 ++
 t/t1092-sparse-checkout-compatibility.sh | 42 ++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/builtin/diff.c b/builtin/diff.c
index dd8ce688ba7..cbf7b51c7c0 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -437,6 +437,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	prefix = setup_git_directory_gently(&nongit);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	if (!no_index) {
 		/*
 		 * Treat git diff with at least one path outside of the
diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index bfd332120c8..bff93f16e93 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -113,5 +113,7 @@ test_perf_on_all git checkout -f -
 test_perf_on_all git reset
 test_perf_on_all git reset --hard
 test_perf_on_all git reset -- does-not-exist
+test_perf_on_all git diff
+test_perf_on_all git diff --staged
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index f19c1b3e2eb..1070bff1a83 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -386,6 +386,43 @@ test_expect_success 'diff --staged' '
 	test_all_match git diff --staged
 '
 
+test_expect_success 'diff partially-staged' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	# Add file within cone
+	test_all_match git sparse-checkout set deep &&
+	run_on_all ../edit-contents deep/testfile &&
+	test_all_match git add deep/testfile &&
+	run_on_all ../edit-contents deep/testfile &&
+
+	test_all_match git diff &&
+	test_all_match git diff --staged &&
+
+	# Add file outside cone
+	test_all_match git reset --hard &&
+	run_on_all mkdir newdirectory &&
+	run_on_all ../edit-contents newdirectory/testfile &&
+	test_all_match git sparse-checkout set newdirectory &&
+	test_all_match git add newdirectory/testfile &&
+	run_on_all ../edit-contents newdirectory/testfile &&
+	test_all_match git sparse-checkout set &&
+
+	test_all_match git diff &&
+	test_all_match git diff --staged &&
+
+	# Merge conflict outside cone
+	test_all_match git reset --hard &&
+	test_all_match git checkout merge-left &&
+	test_all_match test_must_fail git merge merge-right &&
+
+	test_all_match git diff &&
+	test_all_match git diff --staged
+'
+
 # NEEDSWORK: sparse-checkout behaves differently from full-checkout when
 # running this test with 'df-conflict-2' after 'df-conflict-1'.
 test_expect_success 'diff with renames and conflicts' '
@@ -800,6 +837,11 @@ test_expect_success 'sparse-index is not expanded' '
 	# Wildcard identifies only full sparse directories, no index expansion
 	ensure_not_expanded reset deepest -- folder\* &&
 
+	echo a test change >>sparse-index/README.md &&
+	ensure_not_expanded diff &&
+	git -C sparse-index add README.md &&
+	ensure_not_expanded diff --staged &&
+
 	ensure_not_expanded checkout -f update-deep &&
 	test_config -C sparse-index pull.twohead ort &&
 	(
-- 
gitgitgadget

