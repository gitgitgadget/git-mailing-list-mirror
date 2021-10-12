Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7609FC433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 608466101D
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbhJLN7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbhJLN64 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:58:56 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A0EC061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:56:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e3so33608834wrc.11
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wQhcbaSvWff1uMQtWebXvFrlJBrhC4YgnumYCexbcG0=;
        b=jQ7Q+erwr/kNkPl5lzgHy1Bfs/ubMsy8dyhpxIqQ2HpZErYZvcZFKgecOe3gevCMI9
         pri4KXY6+5m+VkpuCL4cv+DI1/Z+uN1NrcHr72Y6m1dF+nLYPdhkpDDkjz8aWdJQV3TY
         gnhVFK3ChVI1hVNUFbYUo3AGx+LqwUKPjmHYpaTL3lZT/QXixFEKQiXTt0qj+mgIWdiX
         v+ysgSVoYI+yomh32OF+mCfRMpWf+Akz2vxtu4RiyJKqfZYheOcYmjoeHsl2SSjf57lr
         +CCGpbGGRdm6FoQZSt/sY9ToVhYZzO18hoaAnw/tfVv/fQ7ErSMUDnpjL+J1ipuB2KaV
         tk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wQhcbaSvWff1uMQtWebXvFrlJBrhC4YgnumYCexbcG0=;
        b=WAkkuBWpbwYTf9LeyasOBstvuIR4H0Ortoc9MguJueYRd4jhRftjfDIjpZbNQOm4m1
         xPi4Yl2iDHy4Pz5NYrU1o1QiuHzWFDs/MJ6sG3ho2QSyy+8KUFj3WLVA+QyXe1bDpc0x
         nYGhUZi7CfNCFO57CECo5MKC8qUF+vRgpuRGCHbwVwbF3rC0hYVv7DiqSOT8WUYfqVlo
         /P2jx1UJECsiZjTHCQPOLjtX9ACZ5G/41K8/iaqSx9KP5UR+6ftbs4l7q2aQ6KZlGYqs
         /ifZj4YAxA/s7FWiEJAMaXxNYnLSvWe4qfXgzqdyQtc5HAdD6AA6/NVuxbnJB1CsPZO4
         bDog==
X-Gm-Message-State: AOAM5303W6atDsnRfKkxlGZWYMGBl7Itcpr7q/1om0iSwB3ihvyhlBHT
        DBUvWd32t5ip7dKbr67s/TQTEQ4DtuABjw==
X-Google-Smtp-Source: ABdhPJy3DRo3gN1tIyxvArgRFz+E7AfHY5qmC66+jxoMaOgHo0mnEm4ICo6NJPcfkwvqd9196bBluA==
X-Received: by 2002:a05:6000:186a:: with SMTP id d10mr20863046wri.279.1634047012493;
        Tue, 12 Oct 2021 06:56:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm4031950wmp.1.2021.10.12.06.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:56:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/9] leak tests: mark all checkout-index tests as passing with SANITIZE=leak
Date:   Tue, 12 Oct 2021 15:56:41 +0200
Message-Id: <patch-v2-5.9-39a0199d5c6-20211012T135343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-v2-0.9-00000000000-20211012T135343Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211012T135343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark some tests that match "*{checkout,switch}*" as passing when git
is compiled with SANITIZE=leak. They'll now be listed as running under
the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks"
CI target).

Unfortunately almost all of those tests fail when compiled with
SANITIZE=leak, these only pass because they run "checkout-index", not
the main "checkout" command.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t2002-checkout-cache-u.sh             | 1 +
 t/t2003-checkout-cache-mkdir.sh         | 1 +
 t/t2004-checkout-cache-temp.sh          | 1 +
 t/t2005-checkout-index-symlinks.sh      | 1 +
 t/t2081-parallel-checkout-collisions.sh | 1 +
 5 files changed, 5 insertions(+)

diff --git a/t/t2002-checkout-cache-u.sh b/t/t2002-checkout-cache-u.sh
index 70361c806e1..fc95cf90485 100755
--- a/t/t2002-checkout-cache-u.sh
+++ b/t/t2002-checkout-cache-u.sh
@@ -8,6 +8,7 @@ test_description='git checkout-index -u test.
 With -u flag, git checkout-index internally runs the equivalent of
 git update-index --refresh on the checked out entry.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success \
diff --git a/t/t2003-checkout-cache-mkdir.sh b/t/t2003-checkout-cache-mkdir.sh
index ff163cf6750..f0fd441d810 100755
--- a/t/t2003-checkout-cache-mkdir.sh
+++ b/t/t2003-checkout-cache-mkdir.sh
@@ -10,6 +10,7 @@ also verifies that such leading path may contain symlinks, unlike
 the GIT controlled paths.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2004-checkout-cache-temp.sh b/t/t2004-checkout-cache-temp.sh
index a9352b08a8b..9bb503a9757 100755
--- a/t/t2004-checkout-cache-temp.sh
+++ b/t/t2004-checkout-cache-temp.sh
@@ -8,6 +8,7 @@ test_description='git checkout-index --temp test.
 With --temp flag, git checkout-index writes to temporary merge files
 rather than the tracked path.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2005-checkout-index-symlinks.sh b/t/t2005-checkout-index-symlinks.sh
index 9fa56104743..112682a45a1 100755
--- a/t/t2005-checkout-index-symlinks.sh
+++ b/t/t2005-checkout-index-symlinks.sh
@@ -8,6 +8,7 @@ test_description='git checkout-index on filesystem w/o symlinks test.
 This tests that git checkout-index creates a symbolic link as a plain
 file if core.symlinks is false.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success \
diff --git a/t/t2081-parallel-checkout-collisions.sh b/t/t2081-parallel-checkout-collisions.sh
index f6fcfc0c1e4..6acdb89d12b 100755
--- a/t/t2081-parallel-checkout-collisions.sh
+++ b/t/t2081-parallel-checkout-collisions.sh
@@ -11,6 +11,7 @@ The tests in this file exercise parallel checkout's collision detection code in
 both these mechanics.
 "
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-parallel-checkout.sh"
 
-- 
2.33.0.1567.g7b23ce7ed9e

