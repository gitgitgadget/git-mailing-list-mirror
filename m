Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA6AC7EE2A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjERUD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjERUDp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:03:45 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446A410CE
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f415a90215so23973005e9.0
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440213; x=1687032213;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hAcre4hDTlXyBs6MvUd69XuKLHZYFrtgmb/kHN5ck0=;
        b=LcgOyZCQFxmcb552xCwOu7ds9gyhzLsoTnoh4uTm8AuLUKVuD5uFkUl+bi4TYJtqXF
         1wQLcqtIb92uMfzwlRcT971pWJfzHyT7qyrqOvBpwENYGNSeJ6UwCBfPKIV5gRunZN8a
         BpQC82P+lBKxJYS2MfkdVMDdQWrI/xKk1p1NCAS2sRL5E6cAyefOsmiAXWndA9LKodmP
         zKKE18GSpljq763nNTfLlu6i31CCS8MT2seZ3cs0fmtOGS4ijy1VJo6fHb07zE8U7WZs
         p8bzB7vCZ9ps7ytIv3VYswUsj/3pbd69fZjfg+GysQskti1BEj8qEoXuidUjeyMzbSYO
         iiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440213; x=1687032213;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hAcre4hDTlXyBs6MvUd69XuKLHZYFrtgmb/kHN5ck0=;
        b=YWPBGJkQCdUGeGtkqNP4f4A6FDXwjJx56LCd+Obrd7V7QrVrHt9bJgyeM8+gb7PiZW
         0u2pUG8OYa+sOuOAb9WpiGRElhuUOc+CYixDSJ5NVW7SQSXmdJwyBSnKAFPJ8x4In1d5
         hxZ1J3xRzqypmoXBZ678MOLtGJheFcQstufV2ZMoM5GR5a8kjreTknmO22L8/6xKnQOO
         h6JAZCk/TiZxYwrceax31ZYkKgBkxZpGFwGFCe7bttBFOHUYBFD3HgcfpjP91cZODVs+
         9oMI8Bhx//HlPaDcOyUNR86ngjoO7XyIOeqPg7yMrhCeuqy3USJN9c4nUqrb3ZSyoLTE
         oatw==
X-Gm-Message-State: AC+VfDwqiXVGHgiMLX7R72tL3BKjnvBuNDGtcRoVHwkUXpSSeBqK6H5v
        T3hG8f/1TOQA+Ry4BdCv2qGBcSFht2E=
X-Google-Smtp-Source: ACHHUZ4lNNH+EKsHBIG8S7whEamYExD9LxApztzljTswj0IQiqzS/LRMppXTb675DmPs0tzE6H1fZQ==
X-Received: by 2002:a7b:c404:0:b0:3f5:146a:c79d with SMTP id k4-20020a7bc404000000b003f5146ac79dmr2302019wmi.15.1684440213405;
        Thu, 18 May 2023 13:03:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d4108000000b003064088a94fsm3100449wrp.16.2023.05.18.13.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:03:33 -0700 (PDT)
Message-Id: <f22cfe2d85067926543f86d21caa47a5626ec709.1684440206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 May 2023 20:03:15 +0000
Subject: [PATCH 10/20] t4002-diff-basic: modernize test format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Some tests still use the old format with four spaces indentation.
Standardize the tests to the new format with tab indentation.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t4002-diff-basic.sh | 243 +++++++++++++++++++++---------------------
 1 file changed, 121 insertions(+), 122 deletions(-)

diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index ea52e5b91b7..d524d4057dc 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -284,132 +284,131 @@ cmp_diff_files_output () {
     test_cmp "$1" .test-tmp
 }
 
-test_expect_success \
-    'diff-tree of known trees.' \
-    'git diff-tree $tree_O $tree_A >.test-a &&
-     cmp -s .test-a .test-plain-OA'
-
-test_expect_success \
-    'diff-tree of known trees.' \
-    'git diff-tree -r $tree_O $tree_A >.test-a &&
-     cmp -s .test-a .test-recursive-OA'
-
-test_expect_success \
-    'diff-tree of known trees.' \
-    'git diff-tree $tree_O $tree_B >.test-a &&
-     cmp -s .test-a .test-plain-OB'
-
-test_expect_success \
-    'diff-tree of known trees.' \
-    'git diff-tree -r $tree_O $tree_B >.test-a &&
-     cmp -s .test-a .test-recursive-OB'
-
-test_expect_success \
-    'diff-tree of known trees.' \
-    'git diff-tree $tree_A $tree_B >.test-a &&
-     cmp -s .test-a .test-plain-AB'
-
-test_expect_success \
-    'diff-tree of known trees.' \
-    'git diff-tree -r $tree_A $tree_B >.test-a &&
-     cmp -s .test-a .test-recursive-AB'
-
-test_expect_success \
-    'diff-tree --stdin of known trees.' \
-    'echo $tree_A $tree_B | git diff-tree --stdin > .test-a &&
-     echo $tree_A $tree_B > .test-plain-ABx &&
-     cat .test-plain-AB >> .test-plain-ABx &&
-     cmp -s .test-a .test-plain-ABx'
-
-test_expect_success \
-    'diff-tree --stdin of known trees.' \
-    'echo $tree_A $tree_B | git diff-tree -r --stdin > .test-a &&
-     echo $tree_A $tree_B > .test-recursive-ABx &&
-     cat .test-recursive-AB >> .test-recursive-ABx &&
-     cmp -s .test-a .test-recursive-ABx'
-
-test_expect_success \
-    'diff-cache O with A in cache' \
-    'git read-tree $tree_A &&
-     git diff-index --cached $tree_O >.test-a &&
-     cmp -s .test-a .test-recursive-OA'
-
-test_expect_success \
-    'diff-cache O with B in cache' \
-    'git read-tree $tree_B &&
-     git diff-index --cached $tree_O >.test-a &&
-     cmp -s .test-a .test-recursive-OB'
-
-test_expect_success \
-    'diff-cache A with B in cache' \
-    'git read-tree $tree_B &&
-     git diff-index --cached $tree_A >.test-a &&
-     cmp -s .test-a .test-recursive-AB'
-
-test_expect_success \
-    'diff-files with O in cache and A checked out' \
-    'rm -fr Z [A-Z][A-Z] &&
-     git read-tree $tree_A &&
-     git checkout-index -f -a &&
-     git read-tree --reset $tree_O &&
-     test_must_fail git update-index --refresh -q &&
-     git diff-files >.test-a &&
-     cmp_diff_files_output .test-a .test-recursive-OA'
-
-test_expect_success \
-    'diff-files with O in cache and B checked out' \
-    'rm -fr Z [A-Z][A-Z] &&
-     git read-tree $tree_B &&
-     git checkout-index -f -a &&
-     git read-tree --reset $tree_O &&
-     test_must_fail git update-index --refresh -q &&
-     git diff-files >.test-a &&
-     cmp_diff_files_output .test-a .test-recursive-OB'
-
-test_expect_success \
-    'diff-files with A in cache and B checked out' \
-    'rm -fr Z [A-Z][A-Z] &&
-     git read-tree $tree_B &&
-     git checkout-index -f -a &&
-     git read-tree --reset $tree_A &&
-     test_must_fail git update-index --refresh -q &&
-     git diff-files >.test-a &&
-     cmp_diff_files_output .test-a .test-recursive-AB'
+test_expect_success 'diff-tree of known trees.' '
+	git diff-tree $tree_O $tree_A >.test-a &&
+	cmp -s .test-a .test-plain-OA
+'
+
+test_expect_success 'diff-tree of known trees.' '
+	git diff-tree -r $tree_O $tree_A >.test-a &&
+	cmp -s .test-a .test-recursive-OA
+'
+
+test_expect_success 'diff-tree of known trees.' '
+	git diff-tree $tree_O $tree_B >.test-a &&
+	cmp -s .test-a .test-plain-OB
+'
+
+test_expect_success 'diff-tree of known trees.' '
+	git diff-tree -r $tree_O $tree_B >.test-a &&
+	cmp -s .test-a .test-recursive-OB
+'
+
+test_expect_success 'diff-tree of known trees.' '
+	git diff-tree $tree_A $tree_B >.test-a &&
+	cmp -s .test-a .test-plain-AB
+'
+
+test_expect_success 'diff-tree of known trees.' '
+	git diff-tree -r $tree_A $tree_B >.test-a &&
+	cmp -s .test-a .test-recursive-AB
+'
+
+test_expect_success 'diff-tree --stdin of known trees.' '
+	echo $tree_A $tree_B | git diff-tree --stdin > .test-a &&
+	echo $tree_A $tree_B > .test-plain-ABx &&
+	cat .test-plain-AB >> .test-plain-ABx &&
+	cmp -s .test-a .test-plain-ABx
+'
+
+test_expect_success 'diff-tree --stdin of known trees.' '
+	echo $tree_A $tree_B | git diff-tree -r --stdin > .test-a &&
+	echo $tree_A $tree_B > .test-recursive-ABx &&
+	cat .test-recursive-AB >> .test-recursive-ABx &&
+	cmp -s .test-a .test-recursive-ABx
+'
+
+test_expect_success 'diff-cache O with A in cache' '
+	git read-tree $tree_A &&
+	git diff-index --cached $tree_O >.test-a &&
+	cmp -s .test-a .test-recursive-OA
+'
+
+test_expect_success 'diff-cache O with B in cache' '
+	git read-tree $tree_B &&
+	git diff-index --cached $tree_O >.test-a &&
+	cmp -s .test-a .test-recursive-OB
+'
+
+test_expect_success 'diff-cache A with B in cache' '
+	git read-tree $tree_B &&
+	git diff-index --cached $tree_A >.test-a &&
+	cmp -s .test-a .test-recursive-AB
+'
+
+test_expect_success 'diff-files with O in cache and A checked out' '
+	rm -fr Z [A-Z][A-Z] &&
+	git read-tree $tree_A &&
+	git checkout-index -f -a &&
+	git read-tree --reset $tree_O &&
+	test_must_fail git update-index --refresh -q &&
+	git diff-files >.test-a &&
+	cmp_diff_files_output .test-a .test-recursive-OA
+'
+
+test_expect_success 'diff-files with O in cache and B checked out' '
+	rm -fr Z [A-Z][A-Z] &&
+	git read-tree $tree_B &&
+	git checkout-index -f -a &&
+	git read-tree --reset $tree_O &&
+	test_must_fail git update-index --refresh -q &&
+	git diff-files >.test-a &&
+	cmp_diff_files_output .test-a .test-recursive-OB
+'
+
+test_expect_success 'diff-files with A in cache and B checked out' '
+	rm -fr Z [A-Z][A-Z] &&
+	git read-tree $tree_B &&
+	git checkout-index -f -a &&
+	git read-tree --reset $tree_A &&
+	test_must_fail git update-index --refresh -q &&
+	git diff-files >.test-a &&
+	cmp_diff_files_output .test-a .test-recursive-AB
+'
 
 ################################################################
 # Now we have established the baseline, we do not have to
 # rely on individual object ID values that much.
 
-test_expect_success \
-    'diff-tree O A == diff-tree -R A O' \
-    'git diff-tree $tree_O $tree_A >.test-a &&
-    git diff-tree -R $tree_A $tree_O >.test-b &&
-    cmp -s .test-a .test-b'
-
-test_expect_success \
-    'diff-tree -r O A == diff-tree -r -R A O' \
-    'git diff-tree -r $tree_O $tree_A >.test-a &&
-    git diff-tree -r -R $tree_A $tree_O >.test-b &&
-    cmp -s .test-a .test-b'
-
-test_expect_success \
-    'diff-tree B A == diff-tree -R A B' \
-    'git diff-tree $tree_B $tree_A >.test-a &&
-    git diff-tree -R $tree_A $tree_B >.test-b &&
-    cmp -s .test-a .test-b'
-
-test_expect_success \
-    'diff-tree -r B A == diff-tree -r -R A B' \
-    'git diff-tree -r $tree_B $tree_A >.test-a &&
-    git diff-tree -r -R $tree_A $tree_B >.test-b &&
-    cmp -s .test-a .test-b'
-
-test_expect_success \
-    'diff can read from stdin' \
-    'test_must_fail git diff --no-index -- MN - < NN |
-        grep -v "^index" | sed "s#/-#/NN#" >.test-a &&
-    test_must_fail git diff --no-index -- MN NN |
-        grep -v "^index" >.test-b &&
-    test_cmp .test-a .test-b'
+test_expect_success 'diff-tree O A == diff-tree -R A O' '
+	git diff-tree $tree_O $tree_A >.test-a &&
+	git diff-tree -R $tree_A $tree_O >.test-b &&
+	cmp -s .test-a .test-b
+'
+
+test_expect_success 'diff-tree -r O A == diff-tree -r -R A O' '
+	git diff-tree -r $tree_O $tree_A >.test-a &&
+	git diff-tree -r -R $tree_A $tree_O >.test-b &&
+	cmp -s .test-a .test-b
+'
+
+test_expect_success 'diff-tree B A == diff-tree -R A B' '
+	git diff-tree $tree_B $tree_A >.test-a &&
+	git diff-tree -R $tree_A $tree_B >.test-b &&
+	cmp -s .test-a .test-b
+'
+
+test_expect_success 'diff-tree -r B A == diff-tree -r -R A B' '
+	git diff-tree -r $tree_B $tree_A >.test-a &&
+	git diff-tree -r -R $tree_A $tree_B >.test-b &&
+	cmp -s .test-a .test-b'
+
+test_expect_success'diff can read from stdin' '
+	test_must_fail git diff --no-index -- MN - < NN |
+		grep -v "^index" | sed "s#/-#/NN#" >.test-a &&
+	test_must_fail git diff --no-index -- MN NN |
+		grep -v "^index" >.test-b &&
+	test_cmp .test-a .test-b
+'
 
 test_done
-- 
gitgitgadget

