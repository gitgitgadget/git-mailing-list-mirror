Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D040C43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 05:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbiGVFP6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 01:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiGVFPv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 01:15:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3045822BFD
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 22:15:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id f24-20020a1cc918000000b003a30178c022so4489424wmb.3
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 22:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xRjx3GHengqE4lF7ebtLjKNtoNDHdxoCL7MPpYxY6xg=;
        b=PhYRxlxhHRfoVQFBSfn9lnQBfmPysAvae6Bclo/Tn6lh6JDUMO0/0gL4/Teou5MN23
         fq9Udget5egDH0Euw4gnzEZCrzP/nByCGIztZFYBYptg0YpBNAsOXM5+CyIcYy8kq29O
         WqUiQDRAu6yVAikVGJNchCcQBKkeHay01gU5RsW71VDVqY4XxSyouAPOlOZlwpH9+EYA
         8nj9Q4btsbDs1Tp6bra3lpOvkjDLdVBIUn+Wrs6IorZ/W2IV3RpDebxMyqdtYrHtV7gO
         VVap+/moi9yqIIv71KgaR6io/2rRf3G5V77xdorIfMtUOM1uEOsviQtsR71YEC9cW6hu
         WOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xRjx3GHengqE4lF7ebtLjKNtoNDHdxoCL7MPpYxY6xg=;
        b=pig8dRG1yIAZwuGep9T++D8Brbah4BEm30IPf08snygV/V3WMj8y4WO180IysIW0qW
         TuHTkk/u2fEq8pl0sSs/HrGHSFUNaz/6UybOfejkzvXma4gcNnCphpF5wNFG9iU6JYPW
         jYW2zls1tA+rDLjk9/rqWH8DO75V6KbEDTriy7y9YzUMv0reTZPvSPubaiRAAThOIZba
         pSZBU9CbW3d96VfltedAbHQobOnzrOYAeldGW9Ii/VSRCTWXhSujnGDkJidk5rPiDpoF
         iigngu7LZnSFsNWTnf/whPn/zGMTLdw4kBNSMQGk8KGCSZwKQQScf5ZIW7EkCQbsm25e
         9PXw==
X-Gm-Message-State: AJIora/vRGQrzhdlhCSh4Wxc6jCPRwyKBoyPq1bDf4v3OpcjQ5AW1CT7
        KQg7htUmwhkM+tyffUV2jehHLVCUv00=
X-Google-Smtp-Source: AGRyM1v1rUkkt9o8H1t5dtewq2HM/Q2NjhkYJpWukKVJCEEZG6xpoC1CNESTtmfU6MtpbM4CUFNg4A==
X-Received: by 2002:a05:600c:1e04:b0:3a3:11ca:5c0c with SMTP id ay4-20020a05600c1e0400b003a311ca5c0cmr1019341wmb.31.1658466948463;
        Thu, 21 Jul 2022 22:15:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q184-20020a1c43c1000000b003a302fb9df7sm7359804wma.21.2022.07.21.22.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 22:15:48 -0700 (PDT)
Message-Id: <daf8d22416003b050cb6b7f4defbb6276ea4a278.1658466942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
References: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
        <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jul 2022 05:15:39 +0000
Subject: [PATCH v4 4/7] merge: fix save_state() to work when there are
 stat-dirty files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When there are stat-dirty files, but no files are modified,
`git stash create` exits with unsuccessful status.  This causes merge
to fail.  Copy some code from sequencer.c's create_autostash to refresh
the index first to avoid this problem.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c                          |  8 ++++++++
 t/t6424-merge-unrelated-index-changes.sh | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index dec7375bf2a..4170c30317e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -313,8 +313,16 @@ static int save_state(struct object_id *stash)
 	int len;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buffer = STRBUF_INIT;
+	struct lock_file lock_file = LOCK_INIT;
+	int fd;
 	int rc = -1;
 
+	fd = repo_hold_locked_index(the_repository, &lock_file, 0);
+	refresh_cache(REFRESH_QUIET);
+	if (0 <= fd)
+		repo_update_index_if_able(the_repository, &lock_file);
+	rollback_lock_file(&lock_file);
+
 	strvec_pushl(&cp.args, "stash", "create", NULL);
 	cp.out = -1;
 	cp.git_cmd = 1;
diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index 8b749e19083..3019d030e07 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -268,6 +268,17 @@ test_expect_success 'subtree' '
 	test_path_is_missing .git/MERGE_HEAD
 '
 
+test_expect_success 'avoid failure due to stat-dirty files' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	# Make "a" be stat-dirty
+	test-tool chmtime =+1 a &&
+
+	# stat-dirty file should not prevent stash creation in builtin/merge.c
+	git merge -s resolve -s recursive D^0
+'
+
 test_expect_success 'resolve && recursive && ort' '
 	git reset --hard &&
 	git checkout B^0 &&
-- 
gitgitgadget

