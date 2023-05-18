Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B940C77B73
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjERUET (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjERUDw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:03:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EC010FE
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3094871953bso883738f8f.0
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440217; x=1687032217;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMpnjhFcqPYC4U7jxJ8zzzEv2kPfKjnO405BMGeoM1c=;
        b=lrTTv5tC0RiQWyHpzfyhM6v1SkDOAe/gvQH42I+7GUl+FxxS0j54d3X4k6DUfhYYiH
         QR/rvJNkQVFEq1qCx6449hJubWOZoaSuPDv5aVvTWQiYmINHjmFdsaeNsLGk0+mVtmEd
         687GYHDGbt5FZfZH7G98YknNWUAAeTe53jrAO/LdYiJps1V4qLhl5JlT6/JnDAkh7THr
         6BPmJGGcm5cMWRmV2vwqLV8Jdd5pBkBk/vXEO/aIgpwWrqAtrc4ZnESf22vv8qDubluf
         SKPhWWiwT61EmVRjxKAoCyDW31wAzOf2IeEkRr6fm0HNjOe8hwvx0iZU0fJ32cmCT4hq
         rsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440217; x=1687032217;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMpnjhFcqPYC4U7jxJ8zzzEv2kPfKjnO405BMGeoM1c=;
        b=Bl30vCHrOREqUgZJwmwdL4nVAaTTRQ/4ewSw+Ln6FHu3fD+tLVyeZIJiJNLR4nEmu+
         vheCDSYp4lSP6sshZE1qjBW4nkK0vRey31gwiKzxuXlezz7Q25ncYbY3jF5XRg3w1wx5
         ZBgmuiCD2281WTJGKrImmY83c1vd1Qx/PMymnrWZLByR77cGRjGUTTBheaLvpfenM5bJ
         uDHtfR+DAGZ08B7F72ReKD8QlH/Nweq0BcO1/W5YvimPgWkJBVvm/t6RmIlumm5vwZyq
         V28rL36qWCXsW6Qvgvlj+0TL4qG7mLl/HgXomjqZqB9ygf14Uk7BOTs6scJdnoWPCg7d
         ZmKw==
X-Gm-Message-State: AC+VfDwEPy3ZXYpcxAN07kPe2/SqX2c1xrO0x5/HgGZwK5IelYlmymdX
        epZHp1Qhx3pAdqFhWBnI+g9a9PiK510=
X-Google-Smtp-Source: ACHHUZ4Ynw7uw4HnKdpEkx33BQe4rWi5oyvbJFZNAV63uuaucu94cgMtYMWGxI5JzBPjUSCDkBI2Ng==
X-Received: by 2002:adf:eb0a:0:b0:306:3711:11d7 with SMTP id s10-20020adfeb0a000000b00306371111d7mr2480136wrn.48.1684440217351;
        Thu, 18 May 2023 13:03:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16-20020a5d4bd0000000b0030642f5da27sm3095527wrt.37.2023.05.18.13.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:03:36 -0700 (PDT)
Message-Id: <6325c8f48c4fd36cc509d4a20e5eb4d6377547b0.1684440206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 May 2023 20:03:21 +0000
Subject: [PATCH 16/20] t5301-sliding-window: modernize test format
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
 t/t5301-sliding-window.sh | 100 +++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/t/t5301-sliding-window.sh b/t/t5301-sliding-window.sh
index 3ccaaeb3977..226490d60df 100755
--- a/t/t5301-sliding-window.sh
+++ b/t/t5301-sliding-window.sh
@@ -8,55 +8,55 @@ test_description='mmap sliding window tests'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-test_expect_success \
-    'setup' \
-    'rm -f .git/index* &&
-     for i in a b c
-     do
-         echo $i >$i &&
-	 test-tool genrandom "$i" 32768 >>$i &&
-         git update-index --add $i || return 1
-     done &&
-     echo d >d && cat c >>d && git update-index --add d &&
-     tree=$(git write-tree) &&
-     commit1=$(git commit-tree $tree </dev/null) &&
-     git update-ref HEAD $commit1 &&
-     git repack -a -d &&
-     test "$(git count-objects)" = "0 objects, 0 kilobytes" &&
-     pack1=$(ls .git/objects/pack/*.pack) &&
-     test -f "$pack1"'
-
-test_expect_success \
-    'verify-pack -v, defaults' \
-    'git verify-pack -v "$pack1"'
-
-test_expect_success \
-    'verify-pack -v, packedGitWindowSize == 1 page' \
-    'git config core.packedGitWindowSize 512 &&
-     git verify-pack -v "$pack1"'
-
-test_expect_success \
-    'verify-pack -v, packedGit{WindowSize,Limit} == 1 page' \
-    'git config core.packedGitWindowSize 512 &&
-     git config core.packedGitLimit 512 &&
-     git verify-pack -v "$pack1"'
-
-test_expect_success \
-    'repack -a -d, packedGit{WindowSize,Limit} == 1 page' \
-    'git config core.packedGitWindowSize 512 &&
-     git config core.packedGitLimit 512 &&
-     commit2=$(git commit-tree $tree -p $commit1 </dev/null) &&
-     git update-ref HEAD $commit2 &&
-     git repack -a -d &&
-     test "$(git count-objects)" = "0 objects, 0 kilobytes" &&
-     pack2=$(ls .git/objects/pack/*.pack) &&
-     test -f "$pack2" &&
-     test "$pack1" \!= "$pack2"'
-
-test_expect_success \
-    'verify-pack -v, defaults' \
-    'git config --unset core.packedGitWindowSize &&
-     git config --unset core.packedGitLimit &&
-     git verify-pack -v "$pack2"'
+test_expect_success 'setup' '
+	rm -f .git/index* &&
+	for i in a b c
+	do
+	echo $i >$i &&
+	test-tool genrandom "$i" 32768 >>$i &&
+	git update-index --add $i || return 1
+	done &&
+	echo d >d && cat c >>d && git update-index --add d &&
+	tree=$(git write-tree) &&
+	commit1=$(git commit-tree $tree </dev/null) &&
+	git update-ref HEAD $commit1 &&
+	git repack -a -d &&
+	test "$(git count-objects)" = "0 objects, 0 kilobytes" &&
+	pack1=$(ls .git/objects/pack/*.pack) &&
+	test -f "$pack1"
+'
+
+test_expect_success 'verify-pack -v, defaults' '
+	git verify-pack -v "$pack1"
+'
+
+test_expect_success 'verify-pack -v, packedGitWindowSize == 1 page' '
+	git config core.packedGitWindowSize 512 &&
+	git verify-pack -v "$pack1"
+'
+
+test_expect_success 'verify-pack -v, packedGit{WindowSize,Limit} == 1 page' '
+	git config core.packedGitWindowSize 512 &&
+	git config core.packedGitLimit 512 &&
+	git verify-pack -v "$pack1"
+'
+
+test_expect_success 'repack -a -d, packedGit{WindowSize,Limit} == 1 page' '
+	git config core.packedGitWindowSize 512 &&
+	git config core.packedGitLimit 512 &&
+	commit2=$(git commit-tree $tree -p $commit1 </dev/null) &&
+	git update-ref HEAD $commit2 &&
+	git repack -a -d &&
+	test "$(git count-objects)" = "0 objects, 0 kilobytes" &&
+	pack2=$(ls .git/objects/pack/*.pack) &&
+	test -f "$pack2" &&
+	test "$pack1" \!= "$pack2"
+'
+
+test_expect_success 'verify-pack -v, defaults' '
+	git config --unset core.packedGitWindowSize &&
+	git config --unset core.packedGitLimit &&
+	git verify-pack -v "$pack2"
+'
 
 test_done
-- 
gitgitgadget

