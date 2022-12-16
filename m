Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72356C4167B
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 15:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiLPPbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 10:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLPPb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 10:31:26 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2986C120AB
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 07:31:25 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h11so2815737wrw.13
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 07:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FotZg4yy9XlqAjPVJNxC5xwRpcqkYAtK4Jr/uCnQRcg=;
        b=HerZJeDeCHLjXt15M5Cm+vN3rQtiOdr0af1hNY/tyrxysY4qPJLOd4MhCorIuYcNJ6
         X+nNFoCYkxCysp96St1Slp8rS8iOtWt+yZvLNnO5wuZHD1Fi2u/3CIUWctc+ZqsT95Zj
         t52AY8JB4TqO3hi75s0Djp1PniM7aSVeKB0zyqk1E2tgVK8qMmvLtKgIJRrwq4ylpuqY
         uQC2vEhh4i69cGGXFJHbY+eizrITSdVNp7yB9Y9rzPqsNXcQQMmdJGqUAdP7VzZrJ5nP
         QM4XjcEwrddb2frjIsJF3qWW6/gtiKDpYQub3SrB8EBVSEUeEKR4Zw+DuDr/X6bX8tpd
         3fBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FotZg4yy9XlqAjPVJNxC5xwRpcqkYAtK4Jr/uCnQRcg=;
        b=yivoUJiZ7iHqhTisg8eD3nu0REcIZMz9MlQJ7lvUz5rxvRiv1s2duRXqlhmQbePYZY
         sf//gPr/zzyZQip+q9ZXT1TcEsSR4kkryLFbEec/rmTcxQt3zsI7cKSjm2xo84CYmeTH
         WRWHevCVb6A0QYHskhfV9ubIB+4UkwunhjtlGN7XBXYAMZhF+jsCQ/1hJ61VSqiYMCYQ
         toOllLbFSMV75Six+ZIjxY9aN8aSkfZDOgLKtyXd8hkrCin+ndQ4ELPpWqO3LD6LUBmw
         pBPuN0cekulh6E5YUkyv+bx1JBp4GadkVN0M8wqyTlwXfrYF9JNTidv4GsznOMk9jbZR
         VnGg==
X-Gm-Message-State: ANoB5pnn/41JE5jjszOfGuTIE5+NrBZfx7JbXJ8GfYWkzOJFGgddGtUl
        CH/OqP7HQ8mVuO8COrtMJyvn8CUQhyA=
X-Google-Smtp-Source: AA0mqf7HgRyFkz35y6QMRl23s3Gn3WaW8xmjxgrT5kqEn21wyy2Lz2m7rwjV5p8m5ma76YTb0pka0g==
X-Received: by 2002:adf:d0ca:0:b0:243:2077:8d55 with SMTP id z10-20020adfd0ca000000b0024320778d55mr22052272wrh.26.1671204683317;
        Fri, 16 Dec 2022 07:31:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bo28-20020a056000069c00b002415dd45320sm2567511wrb.112.2022.12.16.07.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:31:22 -0800 (PST)
Message-Id: <27fbe52e748e3a1d637b514d467cc4ec433fbda3.1671204678.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
References: <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
        <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Dec 2022 15:31:17 +0000
Subject: [PATCH v4 3/4] test-lib-functions: add helper for trailing hash
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, avarab@gmail.com,
        newren@gmail.com, Jacob Keller <jacob.keller@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

It can be helpful to check that a file format with a trailing hash has a
specific hash in the final bytes of a written file. This is made more
apparent by recent changes that allow skipping the hash algorithm and
writing a null hash at the end of the file instead.

Add a new test_trailing_hash helper and use it in t1600 to verify that
index.skipHash=true really does skip the hash computation, since
'git fsck' does not actually verify the hash.

Keep the 'git fsck' call to ensure that any potential future change to
check the index hash does not cause an error in this case.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t1600-index.sh        | 3 +++
 t/test-lib-functions.sh | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 45feb0fc5d8..55914bc3506 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -68,6 +68,9 @@ test_expect_success 'out of bounds index.version issues warning' '
 test_expect_success 'index.skipHash config option' '
 	rm -f .git/index &&
 	git -c index.skipHash=true add a &&
+	test_trailing_hash .git/index >hash &&
+	echo $(test_oid zero) >expect &&
+	test_cmp expect hash &&
 	git fsck
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 796093a7b32..60308843f8f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1875,3 +1875,11 @@ test_cmp_config_output () {
 	sort config-actual >sorted-actual &&
 	test_cmp sorted-expect sorted-actual
 }
+
+# Given a filename, extract its trailing hash as a hex string
+test_trailing_hash () {
+	local file="$1" &&
+	tail -c $(test_oid rawsz) "$file" |
+		test-tool hexdump |
+		sed "s/ //g"
+}
-- 
gitgitgadget

