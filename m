Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31426C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242634AbiCGMu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242614AbiCGMun (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:50:43 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567044F9DD
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:49:41 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q14so7535000wrc.4
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkfQdYEIPYyJ3e2z0sSzbymyioHcNIlPaAmgdxlLimI=;
        b=q5nMT67pniFydYbBKGYkqcdV+oENU17YoNin/yLzdyu+uq50W+CCrcQjFKadabKrlB
         PkAA0l3ktoZGUBG/v+kEwTM5Nf599vWgpyx1FOmN7Y79ymHE3GqcLk6X6/v9A1R++18t
         Ub39hxLJlrd7FkKiuU40K6CxR60aYuE4wBzMSacsObyLCbTcrGBtkkSVbeSpS5fDpZpy
         GZHu60exxNhJ98D322cOhFq6RvDK8VwhpvAn+1784BYlWscCDFpbcH5YoJNLGO00iYda
         jGanFgkw3/PtZ0nC8UVF7S9nNrYus9m3Zag0v/yN/RbW+pV2+g3S+EfP4vsuvj8Y4pyz
         tzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkfQdYEIPYyJ3e2z0sSzbymyioHcNIlPaAmgdxlLimI=;
        b=zSPmQaX2Qi2G5ppi7mZajPovZa+NkLtTH5bHwfgy7OviQOVaMnWn6eyMxiOb0cm0IU
         JWCRF0ADTl967lu4avnVUq5U478QMzcQa/49EyGSyiuNGy4qbI5YNYYUPv356lV4X7NF
         DhPfbPBTUDwIeTrVw8Qtw7CCdONo/eVdPWXtQLMTd/le/LLjf/QejZGz/aYg+J9vvVVG
         p1q22IlgIh2ugYaJaA5fV/6X8JpoqsobG1zeW/av/3Gy6RJ1j3sdYzV0HUaqM4k9e4OL
         S7nnRMoZByiLE96UbPFhBhprMyXKcwMalhxcrIs9ZjL6Ijn3k1ZtwNC8FMQIZlicLcxX
         6hjA==
X-Gm-Message-State: AOAM531RVIsp691A35bbgwCQQPgUSymKGCAhzjkFBxkVrgB0DkGCm3no
        fc2mF62u6Lfc/rI9ZLY736QE49F5qHc0+g==
X-Google-Smtp-Source: ABdhPJxMNhoZMCPOGsqmygwnH+4zEz4tnwJ6fnzgeiYOGMQbnju9OxU6NP0Lkkjs1hFsPq8mZf+9SA==
X-Received: by 2002:adf:d238:0:b0:1f0:6105:520a with SMTP id k24-20020adfd238000000b001f06105520amr7907933wrh.531.1646657379407;
        Mon, 07 Mar 2022 04:49:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b0038100e2a1adsm12729091wmc.47.2022.03.07.04.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:49:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 14/15] checkout tests: don't ignore "git <cmd>" exit code
Date:   Mon,  7 Mar 2022 13:49:05 +0100
Message-Id: <patch-v2-14.15-22b81d7f93a-20220307T124817Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a fragile pattern introduced in 696acf45f96 (checkout:
implement "-" abbreviation, add docs and tests, 2009-01-17) to check
the exit code of both "git symbolic-ref" and "git rev-parse".

Without this change this test will become flaky e.g. under
SANITIZE=leak if some (but not all) memory leaks revealed by these
commands are fixed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t2012-checkout-last.sh | 51 +++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
index 42601d5a310..1f6c4ed0428 100755
--- a/t/t2012-checkout-last.sh
+++ b/t/t2012-checkout-last.sh
@@ -21,14 +21,20 @@ test_expect_success 'first branch switch' '
 	git checkout other
 '
 
+test_cmp_symbolic_HEAD_ref () {
+	echo refs/heads/"$1" >expect &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect actual
+}
+
 test_expect_success '"checkout -" switches back' '
 	git checkout - &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/main"
+	test_cmp_symbolic_HEAD_ref main
 '
 
 test_expect_success '"checkout -" switches forth' '
 	git checkout - &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/other"
+	test_cmp_symbolic_HEAD_ref other
 '
 
 test_expect_success 'detach HEAD' '
@@ -37,12 +43,16 @@ test_expect_success 'detach HEAD' '
 
 test_expect_success '"checkout -" attaches again' '
 	git checkout - &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/other"
+	test_cmp_symbolic_HEAD_ref other
 '
 
 test_expect_success '"checkout -" detaches again' '
 	git checkout - &&
-	test "z$(git rev-parse HEAD)" = "z$(git rev-parse other)" &&
+
+	git rev-parse other >expect &&
+	git rev-parse HEAD >actual &&
+	test_cmp expect actual &&
+
 	test_must_fail git symbolic-ref HEAD
 '
 
@@ -63,31 +73,31 @@ more_switches () {
 test_expect_success 'switch to the last' '
 	more_switches &&
 	git checkout @{-1} &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/branch2"
+	test_cmp_symbolic_HEAD_ref branch2
 '
 
 test_expect_success 'switch to second from the last' '
 	more_switches &&
 	git checkout @{-2} &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/branch3"
+	test_cmp_symbolic_HEAD_ref branch3
 '
 
 test_expect_success 'switch to third from the last' '
 	more_switches &&
 	git checkout @{-3} &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/branch4"
+	test_cmp_symbolic_HEAD_ref branch4
 '
 
 test_expect_success 'switch to fourth from the last' '
 	more_switches &&
 	git checkout @{-4} &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/branch5"
+	test_cmp_symbolic_HEAD_ref branch5
 '
 
 test_expect_success 'switch to twelfth from the last' '
 	more_switches &&
 	git checkout @{-12} &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/branch13"
+	test_cmp_symbolic_HEAD_ref branch13
 '
 
 test_expect_success 'merge base test setup' '
@@ -98,19 +108,28 @@ test_expect_success 'merge base test setup' '
 test_expect_success 'another...main' '
 	git checkout another &&
 	git checkout another...main &&
-	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify main^)"
+
+	git rev-parse --verify main^ >expect &&
+	git rev-parse --verify HEAD >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '...main' '
 	git checkout another &&
 	git checkout ...main &&
-	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify main^)"
+
+	git rev-parse --verify main^ >expect &&
+	git rev-parse --verify HEAD >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'main...' '
 	git checkout another &&
 	git checkout main... &&
-	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify main^)"
+
+	git rev-parse --verify main^ >expect &&
+	git rev-parse --verify HEAD >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '"checkout -" works after a rebase A' '
@@ -118,7 +137,7 @@ test_expect_success '"checkout -" works after a rebase A' '
 	git checkout other &&
 	git rebase main &&
 	git checkout - &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/main"
+	test_cmp_symbolic_HEAD_ref main
 '
 
 test_expect_success '"checkout -" works after a rebase A B' '
@@ -127,7 +146,7 @@ test_expect_success '"checkout -" works after a rebase A B' '
 	git checkout other &&
 	git rebase main moodle &&
 	git checkout - &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/main"
+	test_cmp_symbolic_HEAD_ref main
 '
 
 test_expect_success '"checkout -" works after a rebase -i A' '
@@ -135,7 +154,7 @@ test_expect_success '"checkout -" works after a rebase -i A' '
 	git checkout other &&
 	git rebase -i main &&
 	git checkout - &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/main"
+	test_cmp_symbolic_HEAD_ref main
 '
 
 test_expect_success '"checkout -" works after a rebase -i A B' '
@@ -144,7 +163,7 @@ test_expect_success '"checkout -" works after a rebase -i A B' '
 	git checkout other &&
 	git rebase main foodle &&
 	git checkout - &&
-	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/main"
+	test_cmp_symbolic_HEAD_ref main
 '
 
 test_done
-- 
2.35.1.1242.gfeba0eae32b

