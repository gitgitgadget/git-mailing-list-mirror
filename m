Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F4CC7EE23
	for <git@archiver.kernel.org>; Sun, 28 May 2023 10:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjE1KAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 May 2023 06:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjE1KAG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2023 06:00:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4399BD
        for <git@vger.kernel.org>; Sun, 28 May 2023 03:00:03 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f60e730bf2so24150585e9.1
        for <git@vger.kernel.org>; Sun, 28 May 2023 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685268002; x=1687860002;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ga91TgXQskb0xKsbBYUg+HuUPTcqBsMbLLxxjxpz/8=;
        b=ZX+T9wesbhjAg9tJF+oAh4H4hpSj2xm6vePk2HMaftAZeWrS3NrQc3HXfnunNP3kEE
         E+/lvQDhip+PiaKyh6xOJ62+qAN/5gw5rc1nctLrXj/31C2eKeYbxMZIXfRAzpZ021du
         UwLNonIS4wl4rOxNiBpgXzOXVSrRUwy5ssKc1NVN80x0gjf3BrKxMP2DPqwsNZJQgT9k
         ESkhpI5X2Ad+Up5ESXHcECEG6HVYHQYrd8UDzxvyrsYlNb8ko9FwUtSOTyDI/iqvhhSU
         GWwpwvo1Vkp706bNgBzfu0TppCYjMuF1+oWPiy94o/Es6hCAKs/dDRSJjwSctdgsuXVK
         tNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685268002; x=1687860002;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ga91TgXQskb0xKsbBYUg+HuUPTcqBsMbLLxxjxpz/8=;
        b=fUu84RcCIAqcCCYbKZvW/UD1y/Bc0uO8A6Ocz56qqxOf4R37/vZx7bDmimCTSmvlw8
         pAvXa5dPCf6gfmbvX/5Sl8QWY6gfwaVSlNwg93OLWxAwDILpG9N0w3wF2MUpjBc8Dgi5
         QFA4Ul5mabpWYo8cUYDFbkCIMzt24gIF1sbaERiBL0cozza5YVrqzP6FsZINHRIzAU/S
         IWdvvakMEkJmQpEGnlNgzfS2RqB6hGAoEy3thse4yP20AE1dusaZ6z/hRHWsGpqMQ0ri
         O4QInRwCJ7pCJbngMgBYoggtvg7+dQ0/uHVz6vlvuAqzbFWU3yKMFITBEGAc3bbafdEd
         fphw==
X-Gm-Message-State: AC+VfDxDKQD97va/jzwHamjWdJUPSyO8gZOCMVxs5RB0H61S3Voi2OwV
        YhTyZFiGfMI4eWavmrsPcey6mSD3rU4=
X-Google-Smtp-Source: ACHHUZ7cTjoXhEU7pgcK2wP2yEuXEKz0Mm6Wwyw3TWLCUDFg5rD4FexWnjWDP0d9CDq2VeTrsqjm1A==
X-Received: by 2002:a7b:c055:0:b0:3f5:1980:ad3b with SMTP id u21-20020a7bc055000000b003f51980ad3bmr6818203wmc.5.1685268001883;
        Sun, 28 May 2023 03:00:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x4-20020a05600c21c400b003f0aefcc457sm14371298wmj.45.2023.05.28.03.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 03:00:01 -0700 (PDT)
Message-Id: <8ad60943c6670a041e854f574aae98f8ddb38c70.1685267999.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1257.v3.git.1685267999.gitgitgadget@gmail.com>
References: <pull.1257.v2.git.1655655027.gitgitgadget@gmail.com>
        <pull.1257.v3.git.1685267999.gitgitgadget@gmail.com>
From:   "Junio C Hamano via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 May 2023 09:59:57 +0000
Subject: [PATCH v3 1/3] t4142: test "git apply" with core.ignorecase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4142-apply-icase.sh | 128 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100755 t/t4142-apply-icase.sh

diff --git a/t/t4142-apply-icase.sh b/t/t4142-apply-icase.sh
new file mode 100755
index 00000000000..17eb023a437
--- /dev/null
+++ b/t/t4142-apply-icase.sh
@@ -0,0 +1,128 @@
+#!/bin/sh
+
+test_description='git apply with core.ignorecase'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+       # initial commit has file0 only
+       test_commit "initial" file0 "initial commit with file0" initial &&
+
+       # current commit has file1 as well
+       test_commit "current" file1 "initial content of file1" current &&
+       file0blob=$(git rev-parse :file0) &&
+       file1blob=$(git rev-parse :file1) &&
+
+       # prepare sample patches
+       # file0 is modified
+       echo modification to file0 >file0 &&
+       git add file0 &&
+       modifiedfile0blob=$(git rev-parse :file0) &&
+
+       # file1 is removed and then ...
+       git rm --cached file1 &&
+       # ... identical copies are placed at File1 and file2
+       git update-index --add --cacheinfo 100644,$file1blob,file2 &&
+       git update-index --add --cacheinfo 100644,$file1blob,File1 &&
+
+       # then various patches to do basic things
+       git diff HEAD^ HEAD -- file1 >creation-patch &&
+       git diff HEAD HEAD^ -- file1 >deletion-patch &&
+       git diff --cached HEAD -- file1 file2 >rename-file1-to-file2-patch &&
+       git diff --cached HEAD -- file1 File1 >rename-file1-to-File1-patch &&
+       git diff --cached HEAD -- file0 >modify-file0-patch
+'
+
+# Basic creation, deletion, modification and renaming.
+test_expect_success 'creation and deletion' '
+       # start at "initial" with file0 only
+       git reset --hard initial &&
+
+       # add file1
+       git -c core.ignorecase=false apply --cached creation-patch &&
+       test_cmp_rev :file1 "$file1blob" &&
+
+       # remove file1
+       git -c core.ignorecase=false apply --cached deletion-patch &&
+       test_must_fail git rev-parse --verify :file1 &&
+
+       # do the same with ignorecase
+       git -c core.ignorecase=true apply --cached creation-patch &&
+       test_cmp_rev :file1 "$file1blob" &&
+       git -c core.ignorecase=true apply --cached deletion-patch &&
+       test_must_fail git rev-parse --verify :file1
+'
+
+test_expect_success 'modificaiton' '
+       # start at "initial" with file0 only
+       git reset --hard initial &&
+
+       # modify file0
+       git -c core.ignorecase=false apply --cached modify-file0-patch &&
+       test_cmp_rev :file0 "$modifiedfile0blob" &&
+       git -c core.ignorecase=false apply --cached -R modify-file0-patch &&
+       test_cmp_rev :file0 "$file0blob" &&
+
+       # do the same with ignorecase
+       git -c core.ignorecase=true apply --cached modify-file0-patch &&
+       test_cmp_rev :file0 "$modifiedfile0blob" &&
+       git -c core.ignorecase=true apply --cached -R modify-file0-patch &&
+       test_cmp_rev :file0 "$file0blob"
+'
+
+test_expect_success 'rename file1 to file2' '
+       # start from file0 and file1
+       git reset --hard current &&
+
+       # rename file1 to file2
+       git -c core.ignorecase=false apply --cached rename-file1-to-file2-patch &&
+       test_must_fail git rev-parse --verify :file1 &&
+       test_cmp_rev :file2 "$file1blob" &&
+       git -c core.ignorecase=false apply --cached -R rename-file1-to-file2-patch &&
+       test_must_fail git rev-parse --verify :file2 &&
+       test_cmp_rev :file1 "$file1blob" &&
+
+       # do the same with ignorecase
+       git -c core.ignorecase=true apply --cached rename-file1-to-file2-patch &&
+       test_must_fail git rev-parse --verify :file1 &&
+       test_cmp_rev :file2 "$file1blob" &&
+       git -c core.ignorecase=true apply --cached -R rename-file1-to-file2-patch &&
+       test_must_fail git rev-parse --verify :file2 &&
+       test_cmp_rev :file1 "$file1blob"
+'
+
+test_expect_success 'rename file1 to file2' '
+       # start from file0 and file1
+       git reset --hard current &&
+
+       # rename file1 to File1
+       git -c core.ignorecase=false apply --cached rename-file1-to-File1-patch &&
+       test_must_fail git rev-parse --verify :file1 &&
+       test_cmp_rev :File1 "$file1blob" &&
+       git -c core.ignorecase=false apply --cached -R rename-file1-to-File1-patch &&
+       test_must_fail git rev-parse --verify :File1 &&
+       test_cmp_rev :file1 "$file1blob" &&
+
+       # do the same with ignorecase
+       git -c core.ignorecase=true apply --cached rename-file1-to-File1-patch &&
+       test_must_fail git rev-parse --verify :file1 &&
+       test_cmp_rev :File1 "$file1blob" &&
+       git -c core.ignorecase=true apply --cached -R rename-file1-to-File1-patch &&
+       test_must_fail git rev-parse --verify :File1 &&
+       test_cmp_rev :file1 "$file1blob"
+'
+
+# We may want to add tests with working tree here, without "--cached" and
+# with and without "--index" here.  For example, should modify-file0-patch
+# apply cleanly if we have File0 with $file0blob in the index and the working
+# tree if core.icase is set?
+
+test_expect_success CASE_INSENSITIVE_FS 'a test only for icase fs' '
+       : sample
+'
+
+test_expect_success !CASE_INSENSITIVE_FS 'a test only for !icase fs' '
+       : sample
+'
+
+test_done
-- 
gitgitgadget

