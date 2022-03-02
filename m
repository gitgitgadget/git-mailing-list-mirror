Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E6EC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243836AbiCBR2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239047AbiCBR2a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:28:30 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A090DFC1
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:27:33 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so3266112wmj.2
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FNIF0q7ZDCVLWp1BceXWEHZ0G2K3UnMz0jLwN3DsKzI=;
        b=Y0xJR9VFLIpHkZonYVARttoac4NDh47Ky5ZoFX3FGMAxv1f4rQgI46F5OvOpMXmqJe
         PL5/fSBPBe/BCAUdp3PinnvuWKYlX/EZ7O4b2BVZIKAcFyTYByqkKHQGo9YBmceC2G/P
         bldd4NaWD8tXXcvwS4/4UJiMs8JnioZXMKB+xMpg2XocWuafiDZbsO/RnBHAR8xd77wF
         JC4ZcoyQAWD5Cx8PNGCG5yAaxBBXUYH4qo5zZfKb58uqdeKAazS/PGkhSnKpvHEHORMt
         TN4/K4xBVRrmAuqbLDzXhwZjzR1XrfJKoUpBAB5eP89O6zqerpP2PwyCvuMs2ZyJvxjO
         RS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FNIF0q7ZDCVLWp1BceXWEHZ0G2K3UnMz0jLwN3DsKzI=;
        b=no5Z7WGq0CRhYj05FJ3RM/vw6FliHWWJ6TRBCEeErYM/i11j1lbMArAyQ26SXXuNwK
         ENURocP2Y/RYPth3AonVEQSb+s9ztnU5mGB2rTblENk+xP8zQQp0+0vbIncaVABLtJwX
         foWIMmG6NjBHeQNRfmAz3/NCchAjuyg3607UEIqX2TIxeZT6OeQZzgfYBByQQ2nTicXs
         LKtIP66G0ZKEOa/5Tuk7SnIsExLjwDQ28ugwJUyUMeAoM4BZPx0OSzHL+cZt2JBzjWw0
         SnOWXpEPU3LFC0vu19Xz9zx10u7jbSbqA3Pwuiqylt1Yqafssi0SH8yhYAFfto4YX3ip
         ZuaQ==
X-Gm-Message-State: AOAM531f1Gwz1HVbq6QALXItXtI6QSB3+3wr9Qwdm6y70gXD53KmNpGf
        cES0Uv7e0W1WNxA+llDgqlElczJE4lY+GQ==
X-Google-Smtp-Source: ABdhPJx1AdaCofr5l6UqQpdXKV6pynpjc0r5Jk5ekZzfQ8PTF64anWXq5lrUwtNBfP/AqNAFH1sZkg==
X-Received: by 2002:a1c:acc6:0:b0:380:e35f:ff1f with SMTP id v189-20020a1cacc6000000b00380e35fff1fmr715723wme.52.1646242051857;
        Wed, 02 Mar 2022 09:27:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm2537377wrr.88.2022.03.02.09.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:27:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/15] tests: use "test_stdout_line_count", not "test $(git [...] | wc -l)"
Date:   Wed,  2 Mar 2022 18:27:11 +0100
Message-Id: <patch-02.15-e1105b029d6-20220302T171755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1226.g8b497615d32
In-Reply-To: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the test_stdout_line_count helper added in
cdff1bb5a3d (test-lib-functions: introduce test_stdout_line_count,
2021-07-04) so that we'll spot if git itself dies, segfaults etc in
these expressions.

Because we didn't distinguish these failure conditions before I'd
mistakenly marked these tests as passing under SANITIZE=leak in
dd9cede9136 (leak tests: mark some rev-list tests as passing with
SANITIZE=leak, 2021-10-31).

While we're at it let's re-indent these lines to match our usual
style, as we're having to change all of them anyway.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6005-rev-list-count.sh | 43 +++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/t/t6005-rev-list-count.sh b/t/t6005-rev-list-count.sh
index 86542c650e2..e960049f647 100755
--- a/t/t6005-rev-list-count.sh
+++ b/t/t6005-rev-list-count.sh
@@ -2,7 +2,6 @@
 
 test_description='git rev-list --max-count and --skip test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
@@ -14,39 +13,39 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'no options' '
-    test $(git rev-list HEAD | wc -l) = 5
+	test_stdout_line_count = 5 git rev-list HEAD
 '
 
 test_expect_success '--max-count' '
-    test $(git rev-list HEAD --max-count=0 | wc -l) = 0 &&
-    test $(git rev-list HEAD --max-count=3 | wc -l) = 3 &&
-    test $(git rev-list HEAD --max-count=5 | wc -l) = 5 &&
-    test $(git rev-list HEAD --max-count=10 | wc -l) = 5
+	test_stdout_line_count = 0 git rev-list HEAD --max-count=0 &&
+	test_stdout_line_count = 3 git rev-list HEAD --max-count=3 &&
+	test_stdout_line_count = 5 git rev-list HEAD --max-count=5 &&
+	test_stdout_line_count = 5 git rev-list HEAD --max-count=10
 '
 
 test_expect_success '--max-count all forms' '
-    test $(git rev-list HEAD --max-count=1 | wc -l) = 1 &&
-    test $(git rev-list HEAD -1 | wc -l) = 1 &&
-    test $(git rev-list HEAD -n1 | wc -l) = 1 &&
-    test $(git rev-list HEAD -n 1 | wc -l) = 1
+	test_stdout_line_count = 1 git rev-list HEAD --max-count=1 &&
+	test_stdout_line_count = 1 git rev-list HEAD -1 &&
+	test_stdout_line_count = 1 git rev-list HEAD -n1 &&
+	test_stdout_line_count = 1 git rev-list HEAD -n 1
 '
 
 test_expect_success '--skip' '
-    test $(git rev-list HEAD --skip=0 | wc -l) = 5 &&
-    test $(git rev-list HEAD --skip=3 | wc -l) = 2 &&
-    test $(git rev-list HEAD --skip=5 | wc -l) = 0 &&
-    test $(git rev-list HEAD --skip=10 | wc -l) = 0
+	test_stdout_line_count = 5 git rev-list HEAD --skip=0 &&
+	test_stdout_line_count = 2 git rev-list HEAD --skip=3 &&
+	test_stdout_line_count = 0 git rev-list HEAD --skip=5 &&
+	test_stdout_line_count = 0 git rev-list HEAD --skip=10
 '
 
 test_expect_success '--skip --max-count' '
-    test $(git rev-list HEAD --skip=0 --max-count=0 | wc -l) = 0 &&
-    test $(git rev-list HEAD --skip=0 --max-count=10 | wc -l) = 5 &&
-    test $(git rev-list HEAD --skip=3 --max-count=0 | wc -l) = 0 &&
-    test $(git rev-list HEAD --skip=3 --max-count=1 | wc -l) = 1 &&
-    test $(git rev-list HEAD --skip=3 --max-count=2 | wc -l) = 2 &&
-    test $(git rev-list HEAD --skip=3 --max-count=10 | wc -l) = 2 &&
-    test $(git rev-list HEAD --skip=5 --max-count=10 | wc -l) = 0 &&
-    test $(git rev-list HEAD --skip=10 --max-count=10 | wc -l) = 0
+	test_stdout_line_count = 0 git rev-list HEAD --skip=0 --max-count=0 &&
+	test_stdout_line_count = 5 git rev-list HEAD --skip=0 --max-count=10 &&
+	test_stdout_line_count = 0 git rev-list HEAD --skip=3 --max-count=0 &&
+	test_stdout_line_count = 1 git rev-list HEAD --skip=3 --max-count=1 &&
+	test_stdout_line_count = 2 git rev-list HEAD --skip=3 --max-count=2 &&
+	test_stdout_line_count = 2 git rev-list HEAD --skip=3 --max-count=10 &&
+	test_stdout_line_count = 0 git rev-list HEAD --skip=5 --max-count=10 &&
+	test_stdout_line_count = 0 git rev-list HEAD --skip=10 --max-count=10
 '
 
 test_done
-- 
2.35.1.1226.g8b497615d32

