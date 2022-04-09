Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73859C433EF
	for <git@archiver.kernel.org>; Sat,  9 Apr 2022 11:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241665AbiDILrn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Apr 2022 07:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241681AbiDILrl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Apr 2022 07:47:41 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50756151
        for <git@vger.kernel.org>; Sat,  9 Apr 2022 04:45:31 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id k13so4882523plk.12
        for <git@vger.kernel.org>; Sat, 09 Apr 2022 04:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zzrwKLq4zvMLxL99onuOLMqbb1vAO7uqzxJE3jxGpRk=;
        b=MZax7uz7ym+XzRJIKfD7/qEdAU7LePnuwf8JWlLtRRsqRwoyhTFZHX1vLPXVFPRPGC
         lVbsQhrwLM0LBdSQdCHPv035aw7erWk1vy/PqEbF6iHR0dyTS1lkfye/5M4JTzHAZHfn
         Uiuqw9EVejFQnXieTZg5ra7I8VlpabDxFWMCu4XW7We9C7HO4gJ8M8+Z7sFKXxl4Y/ab
         9f+DCiz+YolpOv5Js1Eh+vMNuZDGnViWOCVdUvfQ+0Y3tVmG2PARESVzLCVfn54wAdSi
         JDdx1eZZYBBY/yforZuOYdBXbrfViRw4WEQNepMmYnTKTtCehGeiQ3I2ejWj4HnKHBWE
         NZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zzrwKLq4zvMLxL99onuOLMqbb1vAO7uqzxJE3jxGpRk=;
        b=sfEs3wsSelPOsB4c0YOSb06bvF1rLjDTPNyEa3r1M5mMJLBpruTjAWfjsJH+bqXvjc
         Yn1AWpFYtrmzUoriwI8J7iS1IsK326k8/spPubbeEFojM0jXOp9VhuvO4iAA6oac93wv
         3rGhwxLiAP/RLFnZJuhcLwL8P11cIGUeQGBgYm9ZRGBU4uUkTUwy0hAJCYatM3C88qdP
         8tnsmLVC4fxb/IvfKjR+wv0f2SMkwNTlO3bMr06A4+Qgsrn7i83quxEClgiSjv4f9PA5
         kzhotpYiNHAQ1GUmHhbebZaGGNiU4YcclgZktIaxFX52GeuZC2JtKq2B9PsxrIK2NSIG
         5LOA==
X-Gm-Message-State: AOAM532bS9stl9os5eZsJtZU8jASKf1JkuEvCrrgH4G08eBSbUmKg6Cz
        NuEkdg/zB8w7eWPEObtAcCnq/zxT8Ha2F8YT
X-Google-Smtp-Source: ABdhPJwEOLZuRW97mWx21TYPZh1NjG5+InUYqzKEQEEzu45eSoGZfBEQkx7TTitoqhFVDe5Qgsb7Zg==
X-Received: by 2002:a17:90b:4b02:b0:1c7:1bc3:690b with SMTP id lx2-20020a17090b4b0200b001c71bc3690bmr26736832pjb.174.1649504730760;
        Sat, 09 Apr 2022 04:45:30 -0700 (PDT)
Received: from HB2.. ([2409:4043:610:cded:b187:7dac:77d7:3420])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b004faef351ebcsm28326099pfk.45.2022.04.09.04.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 04:45:30 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [GSoC] [PATCH] t1011: replace test -f with test_path_is_file
Date:   Sat,  9 Apr 2022 17:14:56 +0530
Message-Id: <20220409114458.23435-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use test_path_is_file() instead of 'test -f' for better debugging
information.
---
 t/t1011-read-tree-sparse-checkout.sh | 46 ++++++++++++++--------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index dd957be1b7..c0b97a622e 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -57,8 +57,8 @@ test_expect_success 'read-tree with .git/info/sparse-checkout but disabled' '
 	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt result &&
-	test -f init.t &&
-	test -f sub/added
+	test_path_is_file init.t &&
+	test_path_is_file sub/added
 '
 
 test_expect_success 'read-tree --no-sparse-checkout with empty .git/info/sparse-checkout and enabled' '
@@ -67,8 +67,8 @@ test_expect_success 'read-tree --no-sparse-checkout with empty .git/info/sparse-
 	read_tree_u_must_succeed --no-sparse-checkout -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt result &&
-	test -f init.t &&
-	test -f sub/added
+	test_path_is_file init.t &&
+	test_path_is_file sub/added
 '
 
 test_expect_success 'read-tree with empty .git/info/sparse-checkout' '
@@ -85,8 +85,8 @@ test_expect_success 'read-tree with empty .git/info/sparse-checkout' '
 	S subsub/added
 	EOF
 	test_cmp expected.swt result &&
-	! test -f init.t &&
-	! test -f sub/added
+	! test_path_is_file init.t &&
+	! test_path_is_file sub/added
 '
 
 test_expect_success 'match directories with trailing slash' '
@@ -101,8 +101,8 @@ test_expect_success 'match directories with trailing slash' '
 	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t > result &&
 	test_cmp expected.swt-noinit result &&
-	test ! -f init.t &&
-	test -f sub/added
+	! test_path_is_file init.t &&
+	test_path_is_file sub/added
 '
 
 test_expect_success 'match directories without trailing slash' '
@@ -110,8 +110,8 @@ test_expect_success 'match directories without trailing slash' '
 	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt-noinit result &&
-	test ! -f init.t &&
-	test -f sub/added
+	! test_path_is_file init.t &&
+	test_path_is_file sub/added
 '
 
 test_expect_success 'match directories with negated patterns' '
@@ -129,9 +129,9 @@ EOF
 	git read-tree -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt-negation result &&
-	test ! -f init.t &&
-	test ! -f sub/added &&
-	test -f sub/addedtoo
+	! test_path_is_file init.t &&
+	! test_path_is_file sub/added &&
+	test_path_is_file sub/addedtoo
 '
 
 test_expect_success 'match directories with negated patterns (2)' '
@@ -150,9 +150,9 @@ EOF
 	git read-tree -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt-negation2 result &&
-	test -f init.t &&
-	test -f sub/added &&
-	test ! -f sub/addedtoo
+	test_path_is_file init.t &&
+	test_path_is_file sub/added &&
+	! test_path_is_file sub/addedtoo
 '
 
 test_expect_success 'match directory pattern' '
@@ -160,8 +160,8 @@ test_expect_success 'match directory pattern' '
 	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt-noinit result &&
-	test ! -f init.t &&
-	test -f sub/added
+	! test_path_is_file init.t &&
+	test_path_is_file sub/added
 '
 
 test_expect_success 'checkout area changes' '
@@ -176,15 +176,15 @@ test_expect_success 'checkout area changes' '
 	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt-nosub result &&
-	test -f init.t &&
-	test ! -f sub/added
+	test_path_is_file init.t &&
+	! test_path_is_file sub/added
 '
 
 test_expect_success 'read-tree updates worktree, absent case' '
 	echo sub/added >.git/info/sparse-checkout &&
 	git checkout -f top &&
 	read_tree_u_must_succeed -m -u HEAD^ &&
-	test ! -f init.t
+	! test_path_is_file init.t
 '
 
 test_expect_success 'read-tree will not throw away dirty changes, non-sparse' '
@@ -229,7 +229,7 @@ test_expect_success 'read-tree adds to worktree, absent case' '
 	echo init.t >.git/info/sparse-checkout &&
 	git checkout -f removed &&
 	read_tree_u_must_succeed -u -m HEAD^ &&
-	test ! -f sub/added
+	! test_path_is_file sub/added
 '
 
 test_expect_success 'read-tree adds to worktree, dirty case' '
@@ -248,7 +248,7 @@ test_expect_success 'index removal and worktree narrowing at the same time' '
 	echo init.t >.git/info/sparse-checkout &&
 	git checkout removed &&
 	git ls-files sub/added >result &&
-	test ! -f sub/added &&
+	! test_path_is_file sub/added &&
 	test_must_be_empty result
 '
 
-- 
2.35.1

