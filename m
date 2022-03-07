Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A57C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242399AbiCGMot (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiCGMoq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:44:46 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4222B35265
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:43:52 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u10so21431680wra.9
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y5RF8bN+XuDMgafOjQTkGqfcM3L366A8S7OaM8r/IyM=;
        b=T9AjUob8O+XaNQ7/HvSJ9h/A7x+5XtMgPKp8yAr/lQSbNzViJPmFeUNul26G0saO8P
         6KFoo+I8LDDGI68wQIZlwt72iXwTUDT94bq0j3IpuApp48yXsitklVpl/ZVSEsRe+y4B
         jAooteuexJBWpsE29QhbKZaqwfsCWue3IimP73/8ImvShvC30xzs425M5E7ac4lw38Rn
         XrnOf6FJyXY1ME9ZafK7tL4agOij1ttovfmspyh4nMEKRvE3hOe1QeS1exYlznaADz7P
         ps9l5StuKuLkH86unVfHMjGnt76ZGvZCEHHTv6+tBG4KIDkeE6asp7pab74rHLahgLh6
         e6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y5RF8bN+XuDMgafOjQTkGqfcM3L366A8S7OaM8r/IyM=;
        b=u06cBbd+UXcz/rUT3jCKsyl1TGC2qEfc7jIWiGeJkyqm+28JgmoMXOL0m5zQ+kKWQd
         JrtQS6QeUkDfA/aU4G+iCWhlLFWBml12WgluGKr+qjgVOLK5sB4s+YjQNE8n9tDyNUR4
         eE/Ds4bU/M5Aq0CToGdodLxW5CaeTMafAXF1dcFOKkfC67gKwIe9G0wdIaqEdbjg3RsB
         m/OThRHfDZ+K4W9nQZwghcBr8PZ56Y7h5y0OxBXGCnMr0+A88qEHput/UrZhEC0dOQRk
         RymETmcwTsicRFzPR7ZbpLIwyayMlKFuMI1bWiFo7jXJuOO5UpfcdMQm0AL5PAvb6IKB
         SKrw==
X-Gm-Message-State: AOAM533hnGMtBQ7njmkWqWKi1YKoTvf1Islhu1IOE7VvNdYak0r8W/BA
        2ghJw9R3/cZCFYlIeJm7MB8SqyheNNDZ4A==
X-Google-Smtp-Source: ABdhPJwmMqfpOXDiJfQQYaI+2OmOYKtWT6yYvMvo18KdK2pr1VQVXMG6xw0aPRy2h5MIUb6IC1dfFQ==
X-Received: by 2002:a05:6000:15cb:b0:1f1:e26a:feae with SMTP id y11-20020a05600015cb00b001f1e26afeaemr7133375wry.295.1646657030576;
        Mon, 07 Mar 2022 04:43:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d5985000000b001f0122f63e1sm5974671wri.85.2022.03.07.04.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:43:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/10] tests: assume the hooks are disabled by default
Date:   Mon,  7 Mar 2022 13:43:34 +0100
Message-Id: <patch-v2-03.10-fc1a9d4d55b-20220307T123909Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop moving the .git/hooks directory out of the way, or creating it
during test setup. Instead assume that it will contain
harmless *.sample files.

That we can assume that is discussed in point #4 of
f0d4d398e28 (test-lib: split up and deprecate test_create_repo(),
2021-05-10), those parts of this could and should have been done in
that change.

Removing the "mkdir -p" here will then validate that our templates are
being used, since we'd subsequently fail to create a hook in that
directory if it didn't exist. Subsequent commits will have those hooks
created by a "test_hook" wrapper, which will then being doing that
same validation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1416-ref-transaction-hooks.sh | 1 -
 t/t5516-fetch-push.sh            | 3 +--
 t/t7519-status-fsmonitor.sh      | 2 --
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 4e1e84a91f3..d21dd5e5df0 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -8,7 +8,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 test_expect_success setup '
-	mkdir -p .git/hooks &&
 	test_commit PRE &&
 	PRE_OID=$(git rev-parse PRE) &&
 	test_commit POST &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 3137eb8d4d2..1a20e54adc1 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -28,8 +28,7 @@ mk_empty () {
 	(
 		cd "$repo_name" &&
 		git init &&
-		git config receive.denyCurrentBranch warn &&
-		mv .git/hooks .git/hooks-disabled
+		git config receive.denyCurrentBranch warn
 	)
 }
 
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index a6308acf006..63a0f609866 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -56,7 +56,6 @@ test_lazy_prereq UNTRACKED_CACHE '
 '
 
 test_expect_success 'setup' '
-	mkdir -p .git/hooks &&
 	: >tracked &&
 	: >modified &&
 	mkdir dir1 &&
@@ -322,7 +321,6 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 	test_create_repo dot-git &&
 	(
 		cd dot-git &&
-		mkdir -p .git/hooks &&
 		: >tracked &&
 		: >modified &&
 		mkdir dir1 &&
-- 
2.35.1.1242.gfeba0eae32b

