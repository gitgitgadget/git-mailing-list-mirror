Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2513C7EE26
	for <git@archiver.kernel.org>; Sat, 20 May 2023 16:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjETQOH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 12:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjETQOE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 12:14:04 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D238110A
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f4249b7badso43995465e9.3
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684599241; x=1687191241;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GM0Lv19xyG2XvaaboXrsO7tpXlI7lvy9yt+RUuSpEUA=;
        b=khVBNt/CaUeISOgjMQqCkvEvoiytUWMZkBltLpYaqWymN0hiSfb6nmjuYvANjo2ClD
         BUiady6/ywxgJMoQ7dcs4LpsP8FYfkDOv4XeNyx47nLUBXZxe0LbGD27p48ZEPS5a5v9
         ooKaLGlp+Chqn97e/yopzD+eF0mK2cgWuZKHpzuWl/B8Psqoma7EgVKCZIsEVoSQKmGG
         e97wldyR7vO031rBfliEi9SK9kFSgyUC5QmsgY4J1vwmQKRAVj8COwYo5IiP5h4+DNSN
         Q0pCYd2zdhHen0Bt05ZUZSYIdLS3pSi/ty4Bx7KrLV4dNQ/OECgypkZ7GGsNC7oXexOk
         DN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684599241; x=1687191241;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GM0Lv19xyG2XvaaboXrsO7tpXlI7lvy9yt+RUuSpEUA=;
        b=LR9kiEgeQ9+E4n0ffu0gWAQVWo+DQLup/m/mEV6bCtgpLEqFfmgyWl8Gv2AcRfdwQN
         1bxMfPMQbCDzHVUF3RvTDketoVhvQogvvfwc5kZuavcx9nH26UYmka9EsoDz7kd7eT5z
         f7aSlwZ3MAOGn4D8KV3PZiuNCeiHur3JHarc2PnAXYn5fcajd2cY6ni/YomMZ+J/Ndsv
         YQTZYS6ujeTih/s3mgGqV26lQNVrTCDo7vstay6Vt2jeDOnL7p+OkRdUtqy34S9JTIql
         MzDHnRFFGqH34qxfW+SQX/w3xPtqdEIlKe+sFjXk6oM08JXyz7Bx0/jXJk3UW1EDZTZ6
         MHiQ==
X-Gm-Message-State: AC+VfDy93JYgRCZlJtGyPmydV+ADC8fuV5SAk9MLWs1YmC4dtm4uqXLc
        VuL4scRwgWiHwoCJwCeITi+TmdBDqjQ=
X-Google-Smtp-Source: ACHHUZ7ws4HUcz3YyErBkI35jTHDW6pZmQ1EQe4Ijvv8KJAj3eAvJWKxwY6tn/RcJI7cvPlYCTjx/g==
X-Received: by 2002:a1c:4c16:0:b0:3f3:2b37:dd34 with SMTP id z22-20020a1c4c16000000b003f32b37dd34mr3567648wmf.9.1684599240767;
        Sat, 20 May 2023 09:14:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b003f09d7b6e20sm2709258wmc.2.2023.05.20.09.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 09:14:00 -0700 (PDT)
Message-Id: <e3e4bb56bcc3f8fd4ae211a3d48a8a2e4f373ad0.1684599239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>
References: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 May 2023 16:13:49 +0000
Subject: [PATCH 01/10] t7110-reset-merge: modernize test format
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
 t/t7110-reset-merge.sh | 314 ++++++++++++++++++++---------------------
 1 file changed, 157 insertions(+), 157 deletions(-)

diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index eb881be95b6..772480a345f 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -9,17 +9,17 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
-    printf "line %d\n" 1 2 3 >file1 &&
-    cat file1 >file2 &&
-    git add file1 file2 &&
-    test_tick &&
-    git commit -m "Initial commit" &&
-    git tag initial &&
-    echo line 4 >>file1 &&
-    cat file1 >file2 &&
-    test_tick &&
-    git commit -m "add line 4 to file1" file1 &&
-    git tag second
+	printf "line %d\n" 1 2 3 >file1 &&
+	cat file1 >file2 &&
+	git add file1 file2 &&
+	test_tick &&
+	git commit -m "Initial commit" &&
+	git tag initial &&
+	echo line 4 >>file1 &&
+	cat file1 >file2 &&
+	test_tick &&
+	git commit -m "add line 4 to file1" file1 &&
+	git tag second
 '
 
 # The next test will test the following:
@@ -29,19 +29,19 @@ test_expect_success setup '
 # file1:     C       C     C    D     --merge  D       D     D
 # file2:     C       D     D    D     --merge  C       D     D
 test_expect_success 'reset --merge is ok with changes in file it does not touch' '
-    git reset --merge HEAD^ &&
-    ! grep 4 file1 &&
-    grep 4 file2 &&
-    test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
-    test -z "$(git diff --cached)"
+	git reset --merge HEAD^ &&
+	! grep 4 file1 &&
+	grep 4 file2 &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
+	test -z "$(git diff --cached)"
 '
 
 test_expect_success 'reset --merge is ok when switching back' '
-    git reset --merge second &&
-    grep 4 file1 &&
-    grep 4 file2 &&
-    test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
-    test -z "$(git diff --cached)"
+	git reset --merge second &&
+	grep 4 file1 &&
+	grep 4 file2 &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
+	test -z "$(git diff --cached)"
 '
 
 # The next test will test the following:
@@ -51,21 +51,21 @@ test_expect_success 'reset --merge is ok when switching back' '
 # file1:     C       C     C    D     --keep   D       D     D
 # file2:     C       D     D    D     --keep   C       D     D
 test_expect_success 'reset --keep is ok with changes in file it does not touch' '
-    git reset --hard second &&
-    cat file1 >file2 &&
-    git reset --keep HEAD^ &&
-    ! grep 4 file1 &&
-    grep 4 file2 &&
-    test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
-    test -z "$(git diff --cached)"
+	git reset --hard second &&
+	cat file1 >file2 &&
+	git reset --keep HEAD^ &&
+	! grep 4 file1 &&
+	grep 4 file2 &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
+	test -z "$(git diff --cached)"
 '
 
 test_expect_success 'reset --keep is ok when switching back' '
-    git reset --keep second &&
-    grep 4 file1 &&
-    grep 4 file2 &&
-    test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
-    test -z "$(git diff --cached)"
+	git reset --keep second &&
+	grep 4 file1 &&
+	grep 4 file2 &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
+	test -z "$(git diff --cached)"
 '
 
 # The next test will test the following:
@@ -75,28 +75,28 @@ test_expect_success 'reset --keep is ok when switching back' '
 # file1:     B       B     C    D     --merge  D       D     D
 # file2:     C       D     D    D     --merge  C       D     D
 test_expect_success 'reset --merge discards changes added to index (1)' '
-    git reset --hard second &&
-    cat file1 >file2 &&
-    echo "line 5" >> file1 &&
-    git add file1 &&
-    git reset --merge HEAD^ &&
-    ! grep 4 file1 &&
-    ! grep 5 file1 &&
-    grep 4 file2 &&
-    test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
-    test -z "$(git diff --cached)"
+	git reset --hard second &&
+	cat file1 >file2 &&
+	echo "line 5" >> file1 &&
+	git add file1 &&
+	git reset --merge HEAD^ &&
+	! grep 4 file1 &&
+	! grep 5 file1 &&
+	grep 4 file2 &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
+	test -z "$(git diff --cached)"
 '
 
 test_expect_success 'reset --merge is ok again when switching back (1)' '
-    git reset --hard initial &&
-    echo "line 5" >> file2 &&
-    git add file2 &&
-    git reset --merge second &&
-    ! grep 4 file2 &&
-    ! grep 5 file1 &&
-    grep 4 file1 &&
-    test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
-    test -z "$(git diff --cached)"
+	git reset --hard initial &&
+	echo "line 5" >> file2 &&
+	git add file2 &&
+	git reset --merge second &&
+	! grep 4 file2 &&
+	! grep 5 file1 &&
+	grep 4 file1 &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
+	test -z "$(git diff --cached)"
 '
 
 # The next test will test the following:
@@ -105,10 +105,10 @@ test_expect_success 'reset --merge is ok again when switching back (1)' '
 #           ----------------------------------------------------
 # file1:     B       B     C    D     --keep   (disallowed)
 test_expect_success 'reset --keep fails with changes in index in files it touches' '
-    git reset --hard second &&
-    echo "line 5" >> file1 &&
-    git add file1 &&
-    test_must_fail git reset --keep HEAD^
+	git reset --hard second &&
+	echo "line 5" >> file1 &&
+	git add file1 &&
+	test_must_fail git reset --keep HEAD^
 '
 
 # The next test will test the following:
@@ -118,23 +118,23 @@ test_expect_success 'reset --keep fails with changes in index in files it touche
 # file1:     C       C     C    D     --merge  D       D     D
 # file2:     C       C     D    D     --merge  D       D     D
 test_expect_success 'reset --merge discards changes added to index (2)' '
-    git reset --hard second &&
-    echo "line 4" >> file2 &&
-    git add file2 &&
-    git reset --merge HEAD^ &&
-    ! grep 4 file2 &&
-    test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
-    test -z "$(git diff)" &&
-    test -z "$(git diff --cached)"
+	git reset --hard second &&
+	echo "line 4" >> file2 &&
+	git add file2 &&
+	git reset --merge HEAD^ &&
+	! grep 4 file2 &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
+	test -z "$(git diff)" &&
+	test -z "$(git diff --cached)"
 '
 
 test_expect_success 'reset --merge is ok again when switching back (2)' '
-    git reset --hard initial &&
-    git reset --merge second &&
-    ! grep 4 file2 &&
-    grep 4 file1 &&
-    test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
-    test -z "$(git diff --cached)"
+	git reset --hard initial &&
+	git reset --merge second &&
+	! grep 4 file2 &&
+	grep 4 file1 &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
+	test -z "$(git diff --cached)"
 '
 
 # The next test will test the following:
@@ -144,21 +144,21 @@ test_expect_success 'reset --merge is ok again when switching back (2)' '
 # file1:     C       C     C    D     --keep   D       D     D
 # file2:     C       C     D    D     --keep   C       D     D
 test_expect_success 'reset --keep keeps changes it does not touch' '
-    git reset --hard second &&
-    echo "line 4" >> file2 &&
-    git add file2 &&
-    git reset --keep HEAD^ &&
-    grep 4 file2 &&
-    test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
-    test -z "$(git diff --cached)"
+	git reset --hard second &&
+	echo "line 4" >> file2 &&
+	git add file2 &&
+	git reset --keep HEAD^ &&
+	grep 4 file2 &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
+	test -z "$(git diff --cached)"
 '
 
 test_expect_success 'reset --keep keeps changes when switching back' '
-    git reset --keep second &&
-    grep 4 file2 &&
-    grep 4 file1 &&
-    test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
-    test -z "$(git diff --cached)"
+	git reset --keep second &&
+	grep 4 file2 &&
+	grep 4 file1 &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
+	test -z "$(git diff --cached)"
 '
 
 # The next test will test the following:
@@ -167,14 +167,14 @@ test_expect_success 'reset --keep keeps changes when switching back' '
 #           ----------------------------------------------------
 # file1:     A       B     B    C     --merge  (disallowed)
 test_expect_success 'reset --merge fails with changes in file it touches' '
-    git reset --hard second &&
-    echo "line 5" >> file1 &&
-    test_tick &&
-    git commit -m "add line 5" file1 &&
-    sed -e "s/line 1/changed line 1/" <file1 >file3 &&
-    mv file3 file1 &&
-    test_must_fail git reset --merge HEAD^ 2>err.log &&
-    grep file1 err.log | grep "not uptodate"
+	git reset --hard second &&
+	echo "line 5" >> file1 &&
+	test_tick &&
+	git commit -m "add line 5" file1 &&
+	sed -e "s/line 1/changed line 1/" <file1 >file3 &&
+	mv file3 file1 &&
+	test_must_fail git reset --merge HEAD^ 2>err.log &&
+	grep file1 err.log | grep "not uptodate"
 '
 
 # The next test will test the following:
@@ -183,36 +183,36 @@ test_expect_success 'reset --merge fails with changes in file it touches' '
 #           ----------------------------------------------------
 # file1:     A       B     B    C     --keep   (disallowed)
 test_expect_success 'reset --keep fails with changes in file it touches' '
-    git reset --hard second &&
-    echo "line 5" >> file1 &&
-    test_tick &&
-    git commit -m "add line 5" file1 &&
-    sed -e "s/line 1/changed line 1/" <file1 >file3 &&
-    mv file3 file1 &&
-    test_must_fail git reset --keep HEAD^ 2>err.log &&
-    grep file1 err.log | grep "not uptodate"
+	git reset --hard second &&
+	echo "line 5" >> file1 &&
+	test_tick &&
+	git commit -m "add line 5" file1 &&
+	sed -e "s/line 1/changed line 1/" <file1 >file3 &&
+	mv file3 file1 &&
+	test_must_fail git reset --keep HEAD^ 2>err.log &&
+	grep file1 err.log | grep "not uptodate"
 '
 
 test_expect_success 'setup 3 different branches' '
-    git reset --hard second &&
-    git branch branch1 &&
-    git branch branch2 &&
-    git branch branch3 &&
-    git checkout branch1 &&
-    echo "line 5 in branch1" >> file1 &&
-    test_tick &&
-    git commit -a -m "change in branch1" &&
-    git checkout branch2 &&
-    echo "line 5 in branch2" >> file1 &&
-    test_tick &&
-    git commit -a -m "change in branch2" &&
-    git tag third &&
-    git checkout branch3 &&
-    echo a new file >file3 &&
-    rm -f file1 &&
-    git add file3 &&
-    test_tick &&
-    git commit -a -m "change in branch3"
+	git reset --hard second &&
+	git branch branch1 &&
+	git branch branch2 &&
+	git branch branch3 &&
+	git checkout branch1 &&
+	echo "line 5 in branch1" >> file1 &&
+	test_tick &&
+	git commit -a -m "change in branch1" &&
+	git checkout branch2 &&
+	echo "line 5 in branch2" >> file1 &&
+	test_tick &&
+	git commit -a -m "change in branch2" &&
+	git tag third &&
+	git checkout branch3 &&
+	echo a new file >file3 &&
+	rm -f file1 &&
+	git add file3 &&
+	test_tick &&
+	git commit -a -m "change in branch3"
 '
 
 # The next test will test the following:
@@ -221,12 +221,12 @@ test_expect_success 'setup 3 different branches' '
 #           ----------------------------------------------------
 # file1:     X       U     B    C     --merge  C       C     C
 test_expect_success '"reset --merge HEAD^" is ok with pending merge' '
-    git checkout third &&
-    test_must_fail git merge branch1 &&
-    git reset --merge HEAD^ &&
-    test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
-    test -z "$(git diff --cached)" &&
-    test -z "$(git diff)"
+	git checkout third &&
+	test_must_fail git merge branch1 &&
+	git reset --merge HEAD^ &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
+	test -z "$(git diff --cached)" &&
+	test -z "$(git diff)"
 '
 
 # The next test will test the following:
@@ -235,10 +235,10 @@ test_expect_success '"reset --merge HEAD^" is ok with pending merge' '
 #           ----------------------------------------------------
 # file1:     X       U     B    C     --keep   (disallowed)
 test_expect_success '"reset --keep HEAD^" fails with pending merge' '
-    git reset --hard third &&
-    test_must_fail git merge branch1 &&
-    test_must_fail git reset --keep HEAD^ 2>err.log &&
-    test_i18ngrep "middle of a merge" err.log
+	git reset --hard third &&
+	test_must_fail git merge branch1 &&
+	test_must_fail git reset --keep HEAD^ 2>err.log &&
+	test_i18ngrep "middle of a merge" err.log
 '
 
 # The next test will test the following:
@@ -247,12 +247,12 @@ test_expect_success '"reset --keep HEAD^" fails with pending merge' '
 #           ----------------------------------------------------
 # file1:     X       U     B    B     --merge  B       B     B
 test_expect_success '"reset --merge HEAD" is ok with pending merge' '
-    git reset --hard third &&
-    test_must_fail git merge branch1 &&
-    git reset --merge HEAD &&
-    test "$(git rev-parse HEAD)" = "$(git rev-parse third)" &&
-    test -z "$(git diff --cached)" &&
-    test -z "$(git diff)"
+	git reset --hard third &&
+	test_must_fail git merge branch1 &&
+	git reset --merge HEAD &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse third)" &&
+	test -z "$(git diff --cached)" &&
+	test -z "$(git diff)"
 '
 
 # The next test will test the following:
@@ -261,36 +261,36 @@ test_expect_success '"reset --merge HEAD" is ok with pending merge' '
 #           ----------------------------------------------------
 # file1:     X       U     B    B     --keep   (disallowed)
 test_expect_success '"reset --keep HEAD" fails with pending merge' '
-    git reset --hard third &&
-    test_must_fail git merge branch1 &&
-    test_must_fail git reset --keep HEAD 2>err.log &&
-    test_i18ngrep "middle of a merge" err.log
+	git reset --hard third &&
+	test_must_fail git merge branch1 &&
+	test_must_fail git reset --keep HEAD 2>err.log &&
+	test_i18ngrep "middle of a merge" err.log
 '
 
 test_expect_success '--merge is ok with added/deleted merge' '
-    git reset --hard third &&
-    rm -f file2 &&
-    test_must_fail git merge branch3 &&
-    ! test -f file2 &&
-    test -f file3 &&
-    git diff --exit-code file3 &&
-    git diff --exit-code branch3 file3 &&
-    git reset --merge HEAD &&
-    ! test -f file3 &&
-    ! test -f file2 &&
-    git diff --exit-code --cached
+	git reset --hard third &&
+	rm -f file2 &&
+	test_must_fail git merge branch3 &&
+	! test -f file2 &&
+	test -f file3 &&
+	git diff --exit-code file3 &&
+	git diff --exit-code branch3 file3 &&
+	git reset --merge HEAD &&
+	! test -f file3 &&
+	! test -f file2 &&
+	git diff --exit-code --cached
 '
 
 test_expect_success '--keep fails with added/deleted merge' '
-    git reset --hard third &&
-    rm -f file2 &&
-    test_must_fail git merge branch3 &&
-    ! test -f file2 &&
-    test -f file3 &&
-    git diff --exit-code file3 &&
-    git diff --exit-code branch3 file3 &&
-    test_must_fail git reset --keep HEAD 2>err.log &&
-    test_i18ngrep "middle of a merge" err.log
+	git reset --hard third &&
+	rm -f file2 &&
+	test_must_fail git merge branch3 &&
+	! test -f file2 &&
+	test -f file3 &&
+	git diff --exit-code file3 &&
+	git diff --exit-code branch3 file3 &&
+	test_must_fail git reset --keep HEAD 2>err.log &&
+	test_i18ngrep "middle of a merge" err.log
 '
 
 test_done
-- 
gitgitgadget

