Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CBFC433FE
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2F66101D
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbhJLN66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbhJLN6y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:58:54 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A519FC061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:56:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u18so67429119wrg.5
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CQyPgn78SikiC/c9x47B4KZq+HUf4ufTdz7P4wDh3Pk=;
        b=VqlkL1gpsPYXNgAq+7xnfSP/peTmVY4igjxsihIIzaL/JjjwnxRPV//+GASvKX+2va
         jSwD3HEtKVptyIuxz251Q+zBh4K4ChLusTyXGTGPk2L2M+XdWuTAG739F3Ut7x7k9aaD
         btE16+gGK/pv29Ehj4cLQ9xW/6mYw41WQhct/Gww/3zLvkFuzp5aXiIyoM5YWDp6pEE0
         SseyBY8cuaJuqvLbILGM/K+bwrFHCLmZmJbWueaOOdcCuAqA+zNz8VKpzDiT+cJhItMc
         BNJxa+mJaduggxBbijy482ra17bNPCX9qk/96Y6KH/mtSDCkGCjxwOSXvzrvZOiJcGi7
         5KEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CQyPgn78SikiC/c9x47B4KZq+HUf4ufTdz7P4wDh3Pk=;
        b=KO4ynFE1KdIF1ha/C08BmgUHFaqWDAx5E3EkhiW1cUSt2B9I7MsduHEsYZOSxcCD2X
         1QGA6ZmnipG79egCbod0oMkX1yG3JWlp9Ic89MpxcZjhfD4YiwCDM91vNT2ilr3AatgP
         bOD/AMpvvPyiTEPIXwthl0Xj1pi5N9iqWz66E7f80cgLDSxr3wGM+qck80/1wH8/7fGI
         7WnY1cDaOkY0yUpcrpxQMAamlUfM5Sk6PxXzYAEnxC+PJ3PVjngv+MIANdEuB0/wWxQk
         aSRB0b3UC71C7e5+FcDfCm5ZlRgQMh/G5iLis72S8sXncO8wdGamJaYhJ2MhioGC487m
         iVDQ==
X-Gm-Message-State: AOAM533AzvNsObVbQwh//au7bbAk1BeYdSDsVM3LURxy929q9hk93UgO
        C/+blp01bBGlQXYYXDf+pYtzOpx38bTTRQ==
X-Google-Smtp-Source: ABdhPJwPMUYzZoIa42aLQwEgLVphmp/HMh5PtQG6Poo8wqud2yjrpeIBCIY9iWhliyy08DnTyE9JhQ==
X-Received: by 2002:adf:8b06:: with SMTP id n6mr32368935wra.5.1634047011020;
        Tue, 12 Oct 2021 06:56:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm4031950wmp.1.2021.10.12.06.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:56:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/9] leak tests: mark all ls-tree tests as passing with SANITIZE=leak
Date:   Tue, 12 Oct 2021 15:56:39 +0200
Message-Id: <patch-v2-3.9-dab4752680c-20211012T135343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-v2-0.9-00000000000-20211012T135343Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20211012T135343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark those tests that match "*ls-tree*" as passing when git is
compiled with SANITIZE=leak. They'll now be listed as running under
the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the "linux-leaks"
CI target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3100-ls-tree-restrict.sh  | 2 ++
 t/t3101-ls-tree-dirname.sh   | 2 ++
 t/t3102-ls-tree-wildcards.sh | 1 +
 t/t3103-ls-tree-misc.sh      | 1 +
 4 files changed, 6 insertions(+)

diff --git a/t/t3100-ls-tree-restrict.sh b/t/t3100-ls-tree-restrict.sh
index 18baf49a49c..436de44971e 100755
--- a/t/t3100-ls-tree-restrict.sh
+++ b/t/t3100-ls-tree-restrict.sh
@@ -16,6 +16,8 @@ This test runs git ls-tree with the following in a tree.
 The new path restriction code should do the right thing for path2 and
 path2/baz.  Also path0/ should snow nothing.
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success \
diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 12bf31022a8..05fde642259 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -19,6 +19,8 @@ This test runs git ls-tree with the following in a tree.
 Test the handling of multiple directories which have matching file
 entries.  Also test odd filename and missing entries handling.
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3102-ls-tree-wildcards.sh b/t/t3102-ls-tree-wildcards.sh
index 1e16c6b8ea6..3942db22900 100755
--- a/t/t3102-ls-tree-wildcards.sh
+++ b/t/t3102-ls-tree-wildcards.sh
@@ -2,6 +2,7 @@
 
 test_description='ls-tree with(out) globs'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
index 14520913afc..d18ba1bd84b 100755
--- a/t/t3103-ls-tree-misc.sh
+++ b/t/t3103-ls-tree-misc.sh
@@ -7,6 +7,7 @@ Miscellaneous tests for git ls-tree.
 
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.33.0.1567.g7b23ce7ed9e

