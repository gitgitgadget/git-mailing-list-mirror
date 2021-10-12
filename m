Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51183C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DBB5610C7
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbhJLN67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbhJLN6z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:58:55 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D38C06161C
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:56:53 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k7so67101079wrd.13
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n3xsfOYMyvjbcV00ySLzy9kgAOyjABhXLJUa+2Cip/E=;
        b=IX/RVT/fNOg7saKOMqpmuxO/sUSOSAmoUvTNUv8ZGFZVp4s4vTUI0LGHJWbPxDr3he
         KjVeErhiuG6nC2R4KmgtOjLJUnqr3FucWF0iaqMM/DKA5GouWbwn2liEOKkMyvkQ9cm+
         sTy6pLPnEYANx15MkV4pIBDCLEbs7nazlujynLz0bevfBQEjiSP/WGD3bIbm6XW/AGMa
         iotJPCkoW5eukl2EaKphyRBvQ9N/pBWVEru6SbKutZfAZf8VsYQJpYg0EwMQDs5TsMck
         iZq31MReudMLg2qiM60TbNuQc6+OJrPzQc5pUerKmeylHch+hPGbN2CiBEIQJWGpyArz
         /aJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n3xsfOYMyvjbcV00ySLzy9kgAOyjABhXLJUa+2Cip/E=;
        b=JctaGScqTRggigK0qEF0k0wbDhBdKvK2BVo64xcgIVrPro0qN/STU2S4VSqSWm/4pK
         lnJkQbqqPjlxvufmlONAU3lOY1ZtNZS3uTY3SC+JQ0+z+jsckessIKv5x9UeUf/ctmnj
         Qh0Fb1JUAadnYsyMh2MwZ5rbBfO/Fwa703xSuSORiDEw+GIvnIwpZkr0ziv6wNGLx88T
         l8HS7KoLxJ7oD0jkd5YK+R7MPPE/HOzEQs9iVS+WDK282dWgA1fM8/xkQ5MCcdFlm25y
         C3/uK+RO1BaY4psWFoxkQrS4/9DV9uu36ZQyou493gVYvkued9ZFhJ5fxfYEDpQAXB+u
         /11g==
X-Gm-Message-State: AOAM532OmI9h/xInGBd//1bFoviU0fhgoiOa8QscOUEJud3zb24PxzBK
        mbx3AZvN/hSJ9qxv/falEXuXHQ4pFVsNSQ==
X-Google-Smtp-Source: ABdhPJzF2fftKMo0xQma5VulQkWrRGEkQm/R7pYPQgq+yF1kKm+kXxt8H3SVrhO9sM2tatekmbDYrg==
X-Received: by 2002:adf:df8c:: with SMTP id z12mr27606316wrl.292.1634047011715;
        Tue, 12 Oct 2021 06:56:51 -0700 (PDT)
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
Subject: [PATCH v2 4/9] leak tests: mark all trace2 tests as passing with SANITIZE=leak
Date:   Tue, 12 Oct 2021 15:56:40 +0200
Message-Id: <patch-v2-4.9-df235c1dc68-20211012T135343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-v2-0.9-00000000000-20211012T135343Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211012T135343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark all tests that match "*trace2*" as passing when git is compiled
with SANITIZE=leak. They'll now be listed as running under the
"GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks" CI
target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0210-trace2-normal.sh | 2 ++
 t/t0211-trace2-perf.sh   | 2 ++
 t/t0212-trace2-event.sh  | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index 0cf3a63b75b..37c359bd5a2 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test trace2 facility (normal target)'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.
diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 6ee8ee3b672..22d0845544e 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test trace2 facility (perf target)'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.
diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
index 1529155cf01..6d3374ff773 100755
--- a/t/t0212-trace2-event.sh
+++ b/t/t0212-trace2-event.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test trace2 facility'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.
-- 
2.33.0.1567.g7b23ce7ed9e

