Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEFBC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20797207FD
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjqFPJzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLIQKM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:10:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34823 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIQKK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 11:10:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id c20so14084059wmb.0
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 08:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TfdVMVQJfprx0PnKlAxqLnM0P66R/GPubmf8+9bHXKw=;
        b=BjqFPJzjuCS1N1TsraXt9M2X6kTF+leODTw+RYVGkgY0W1z+oKtrQCfzSxpohSumFA
         tmAsIc5z4iuhHGeswzpP+OJfd6OAKiqjeW9F9su680lTWpJqx0jo7z5ei0QwBrXY3nEG
         FnRCHLXGkOFv7zS14EL24ux/Zq3EIiksTkyxv3bs29JUyDcsZ7Wmajoymuz71/6KOf+7
         jM43ylj/XBPzj/c90S9Sag1qarx2M54SfoZsRJMML4a8dLCb+4RhlRzPG8xnpT6kJf/V
         8jis2BYUnDR5cSJ27fcxgaDV80VSdvltpV5FL43HKhdgnLdL0RtOFxbEym1OZ1MfLRa+
         YegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TfdVMVQJfprx0PnKlAxqLnM0P66R/GPubmf8+9bHXKw=;
        b=Ttz7W3g0d7DOqoJj5llrXfkDtUyC7jHMby3plL79LyAfgHYJy+qxeVk5A0Bfrsl0Fa
         XSogE9aKIClnNDxKTEoK2dMhvucQNAuGpGcO8S4TvFZafSW8Kk1Sh/E2Pj9tFMjWQ1q5
         UjQ7zKSkaRgi8RhSy2cN8LAe5MXVonMP2p2G0Q8JFWD4yo3k4ZzEB8KlKsENSci8t4hY
         vJ9mKASrbt6i7x5VxaBB6TkU0AOhXXmQTednfOR7GRpX3XuYhoJeIhRkmlyCXUFuAVO+
         uGRqsOq8AHBeF+aY+7IVkCLPyepeSVd6UZZCRjzlaUz3fR7bQWSGSxk4IzBKfqZPWL/v
         VJJA==
X-Gm-Message-State: APjAAAWvSI4DPHHK5latRKoTYICEpmAIXEYkoDgDo/T8KchvFt7RSqHy
        F1wH3kPmbZR5vG0UaFO51UdBkI9R
X-Google-Smtp-Source: APXvYqyW33wANoQWgiIbCEz/krNHQIV6zvaX9MKJKq9U6wzzp2XEmVpWrLNBsWA8JTKsGrMf4jc2TA==
X-Received: by 2002:a1c:8055:: with SMTP id b82mr25776899wmd.127.1575907808470;
        Mon, 09 Dec 2019 08:10:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f5sm235260wmh.12.2019.12.09.08.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 08:10:08 -0800 (PST)
Message-Id: <efc16962ee2595db50bf051fc84632b8c70036b3.1575907804.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
        <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 16:10:00 +0000
Subject: [PATCH v2 4/8] t3030-merge-recursive.sh: disable fsmonitor when
 tweaking GIT_WORK_TREE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The fsmonitor feature allows an external tool such as watchman to
monitor the working directory. The direct test
t7619-status-fsmonitor.sh provides some coverage, but it would be
better to run the entire test suite with watchman enabled. This
would provide more confidence that the feature is working as
intended.

Worktrees use a ".git" _file_ instead of a folder to point to
the base repo's .git directory and the proper worktree HEAD. The
fsmonitor hook tries to create a JSON file inside the ".git" folder
which violates the expectation here. It would be better to properly
find a safe folder for storing this JSON file.

This is also a problem when a test script uses GIT_WORK_TREE.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1510-repo-setup.sh      | 1 +
 t/t2400-worktree-add.sh    | 2 ++
 t/t3030-merge-recursive.sh | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 9974457f56..28dce0c26f 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -775,6 +775,7 @@ test_expect_success '#29: setup' '
 	setup_repo 29 non-existent gitfile true &&
 	mkdir -p 29/sub/sub 29/wt/sub &&
 	(
+		GIT_TEST_FSMONITOR="" &&
 		cd 29 &&
 		GIT_WORK_TREE="$here/29" &&
 		export GIT_WORK_TREE &&
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index e819ba741e..d4d3cbae0f 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -1,5 +1,7 @@
 #!/bin/sh
 
+GIT_TEST_FSMONITOR=""
+
 test_description='test git worktree add'
 
 . ./test-lib.sh
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index ff641b348a..62f645d639 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -520,6 +520,7 @@ test_expect_success 'reset and bind merge' '
 
 test_expect_success 'merge-recursive w/ empty work tree - ours has rename' '
 	(
+		GIT_TEST_FSMONITOR="" &&
 		GIT_WORK_TREE="$PWD/ours-has-rename-work" &&
 		export GIT_WORK_TREE &&
 		GIT_INDEX_FILE="$PWD/ours-has-rename-index" &&
@@ -545,6 +546,7 @@ test_expect_success 'merge-recursive w/ empty work tree - ours has rename' '
 
 test_expect_success 'merge-recursive w/ empty work tree - theirs has rename' '
 	(
+		GIT_TEST_FSMONITOR="" &&
 		GIT_WORK_TREE="$PWD/theirs-has-rename-work" &&
 		export GIT_WORK_TREE &&
 		GIT_INDEX_FILE="$PWD/theirs-has-rename-index" &&
-- 
gitgitgadget

