Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21571C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 06:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiGUGv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 02:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiGUGvx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 02:51:53 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D28342ADA
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:51:52 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v5so502580wmj.0
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YlD+1cF2W6YAC1TF8qxd2/lm+nSauRSxGyMf5TpkcvI=;
        b=QFKHLKvWiRcVTJ82CyPyOaJ65Y8hYQeVkWdznrrHK/EiP1P3DhUbRhnWrqfvOlpsdC
         E7TcZjJNO8Czlj7p+nUYO8wymqVzy7OdiE+S0woEHSaRhYyevqmZldJkQqBBT5px8j+i
         I/XBO+T/kK2R6lkIt2Gq7td+EvjpG4hxlwulDLbm2n0vO/TF5UcL69+sP6wUgn/xdnLB
         pAhW/ZCRHIolMMO43of8Qrw8oIkPmt7fNI6vhZ+UNw0ECjS1G9cfBGmZEaZEugbZosva
         o54sIPHOj06FFQ4Dq3bTVVc7gyvqBO7iNgvB7t0Wci9rWJgh0BJQ+6EQHGjFrN6qEbVW
         XTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YlD+1cF2W6YAC1TF8qxd2/lm+nSauRSxGyMf5TpkcvI=;
        b=EiQaafxAperhdR2xFbx3lbGVb+IQ8VWivj6IyUnPHM/S4HFpGb6rlBeej54s6sm9Kh
         wf8dOZyLncEsxsbpuPX/GvA0l0G6RtEOb5mdmAMSyCSioIMuX7wapWCpzofUo3fjth5W
         epyE8ka11RoMg/UljXKD9YLMJRjTDstK2NsMRtAY/LDzlAy2uZQZ6ViYbSiqkCSVcxFU
         l6L+ZMiB//HaUASXUKDDlOk13KUAIgK+aKmHLd3w/PLCBZlX/pfCC6GMC4aToy8eiR0T
         XezVJAW0a76HTIUHho6dB7KtgYj5UVxWYNG+aEF7FvdLYAOlh9QQ5oBlyqK+jaGE4y1I
         Tucg==
X-Gm-Message-State: AJIora/8qApZBr+GuT9VxoBbs+gnJN9hgJinvcDC/zMe0w2QZNGQ0oVH
        86PgWVMNj58bcHISqQgNzUNJYE4BvTd4aw==
X-Google-Smtp-Source: AGRyM1sCFBIeUyTbNj6m4LXZB9zr2iEz4uxDXpw/5kkfhA0OUEKQGVNvmj4JwTeHv2vIV2zl+eXKXw==
X-Received: by 2002:a05:600c:4eca:b0:3a1:9a2a:e373 with SMTP id g10-20020a05600c4eca00b003a19a2ae373mr7093980wmq.153.1658386310453;
        Wed, 20 Jul 2022 23:51:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n124-20020a1c2782000000b003a2c67aa6c0sm1006746wmn.23.2022.07.20.23.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:51:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/6] t/lib-patch-mode.sh: fix ignored "git" exit codes
Date:   Thu, 21 Jul 2022 08:51:39 +0200
Message-Id: <patch-2.6-85c6ab40e91-20220721T064349Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
In-Reply-To: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix code added in b319ef70a94 (Add a small patch-mode testing library,
2009-08-13) to use &&-chaining and test_cmp instead of interpolating
"git" commands in a "test" statement.

This fixes cases where we'd have e.g. missed memory leaks under
SANITIZE=leak, this code doesn't leak now as far as I can tell, but I
discovered it while looking at leaks in related code.

The "cat _head >expect" here is redundant, we could simply give
"_head" to "test_cmp", but let's be consistent in using the "expect"
and "actual" names for clarity.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-patch-mode.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/t/lib-patch-mode.sh b/t/lib-patch-mode.sh
index cfd76bf987b..887554933c2 100644
--- a/t/lib-patch-mode.sh
+++ b/t/lib-patch-mode.sh
@@ -29,8 +29,13 @@ set_and_save_state () {
 
 # verify_state <path> <expected-worktree-content> <expected-index-content>
 verify_state () {
-	test "$(cat "$1")" = "$2" &&
-	test "$(git show :"$1")" = "$3"
+	echo "$2" >expect &&
+	cat "$1" >actual &&
+	test_cmp expect actual &&
+
+	echo "$3" >expect
+	git show :"$1" >actual &&
+	test_cmp expect actual
 }
 
 # verify_saved_state <path>
@@ -46,5 +51,7 @@ save_head () {
 }
 
 verify_saved_head () {
-	test "$(cat _head)" = "$(git rev-parse HEAD)"
+	cat _head >expect &&
+	git rev-parse HEAD >actual &&
+	test_cmp expect actual
 }
-- 
2.37.1.1095.g64a1e8362fd

