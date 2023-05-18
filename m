Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E131FC77B7A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjERUDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjERUDg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:03:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565C6E7D
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3075e802738so2349472f8f.1
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440212; x=1687032212;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYDk7gMaphXLcme+IPJJ8gHr2EM4BNnBIx7KcexY0CM=;
        b=iV9UEynokFufhCkBAOVxlbQ24HRGMRlUr38u8c/zX+QTLHu5DOG9sDU+g3nEYI6zH9
         nqQ6med/TfT3YK5Yfeb/USd74JAZem0hXA+6nZbnYWVKb6a/hLUgYUWcSyMK2BfZ9AEt
         hhmMp6d1ON28NjSfFwdyYwL1qF5te4E0i+QrUpCar0N5XAzGf/pz4Uot+ZFxN+V9yHxM
         dYVIcTrN0g3G0gEDfxzbnW8Jm5uME9fM6QyIpxKXvsoeYXTwOJh3kgf2qUyvISIKip14
         iVbL5oy8xhd0PNzNHnGhZfLpD+3pPgjxMt6OrpEQ7oLpeJl2XP3h/BZk0UTuwahogQVU
         2rHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440212; x=1687032212;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYDk7gMaphXLcme+IPJJ8gHr2EM4BNnBIx7KcexY0CM=;
        b=dhYhNO/oPqss4oh8iDC8BIe7iBHKguw8QTksUB66uoWCFHBMnjb3GhSPIjxPCPUK9Q
         gQ+Fgn+YLLYs2JHUvZ1Z4HsXAyfOgosMkiZabbazcGkXSbXxGYyeeNTWeRaFxhUcedWK
         vx2W/ymfA8RicS7ovehPi4uGhQP2bvn53b/RcKdoPPIe2GRjdIrzpRkIqso6r0vhQtjT
         s3iRpRMBAFKDv48fjjnMoWYhvwHbzKQceUwqMqD4JlKW0CVSmNCrxfcw1OvmJtRoLj15
         xsoogDyxWUEGclHeeAfkwIPyoL8zxdAdxMYWCaw02DnqqQrk3wbQu7cwEU9AkB81xh1/
         cnGw==
X-Gm-Message-State: AC+VfDxylYGeHCVdXsnONtWl2pp53Rtg6J5Hz+lgkKrTYj2Xkh5tIij4
        kZ3d2iXhS6eyitwRPi2HyCbVqNPqgo0=
X-Google-Smtp-Source: ACHHUZ5ctz6rLIkvDH/joJhyGQKfTHHIpMM0t5xLc8LCCMqD729zVZJojwe6kaZ5xDvvy7YRiMJwcA==
X-Received: by 2002:a5d:5404:0:b0:306:342c:50c2 with SMTP id g4-20020a5d5404000000b00306342c50c2mr2786995wrv.53.1684440212530;
        Thu, 18 May 2023 13:03:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c20-20020a05600c0ad400b003f4e4b5713esm191580wmr.37.2023.05.18.13.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:03:32 -0700 (PDT)
Message-Id: <01330c096c861a35a04ad91c7aaf0b9061c1fa02.1684440205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 May 2023 20:03:13 +0000
Subject: [PATCH 08/20] t3700-add: modernize test format
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
 t/t3700-add.sh | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 82dd768944f..7623689da24 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -24,17 +24,17 @@ test_mode_in_index () {
 	esac
 }
 
-test_expect_success \
-    'Test of git add' \
-    'touch foo && git add foo'
+test_expect_success 'Test of git add' '
+	touch foo && git add foo
+'
 
-test_expect_success \
-    'Post-check that foo is in the index' \
-    'git ls-files foo | grep foo'
+test_expect_success 'Post-check that foo is in the index' '
+	git ls-files foo | grep foo
+'
 
-test_expect_success \
-    'Test that "git add -- -q" works' \
-    'touch -- -q && git add -- -q'
+test_expect_success 'Test that "git add -- -q" works' '
+	touch -- -q && git add -- -q
+'
 
 BATCH_CONFIGURATION='-c core.fsync=loose-object -c core.fsyncmethod=batch'
 
@@ -284,14 +284,14 @@ test_expect_success POSIXPERM,SANITY 'git add (add.ignore-errors = false)' '
 rm -f foo2
 
 test_expect_success POSIXPERM,SANITY '--no-ignore-errors overrides config' '
-       git config add.ignore-errors 1 &&
-       git reset --hard &&
-       date >foo1 &&
-       date >foo2 &&
-       chmod 0 foo2 &&
-       test_must_fail git add --verbose --no-ignore-errors . &&
-       ! ( git ls-files foo1 | grep foo1 ) &&
-       git config add.ignore-errors 0
+	git config add.ignore-errors 1 &&
+	git reset --hard &&
+	date >foo1 &&
+	date >foo2 &&
+	chmod 0 foo2 &&
+	test_must_fail git add --verbose --no-ignore-errors . &&
+	! ( git ls-files foo1 | grep foo1 ) &&
+	git config add.ignore-errors 0
 '
 rm -f foo2
 
-- 
gitgitgadget

