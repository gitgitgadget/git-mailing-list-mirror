Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88957C433F5
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 00:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiCRAfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 20:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiCRAfc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 20:35:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6AE2467E4
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 17:34:14 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n35so2439764wms.5
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 17:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wV3xZtmIvvBa/VB6409dWLHOKAVs1cwppO2sKYXA+jE=;
        b=evtzrGhhXrVvfdLriNEiqKmeIV8XqRnpZIQ4lQQ5irw5QKjz8//a/WQ7lEGeYea8Ce
         Ucr4A/rNxK3wO30ZJ6bK1SNyMVSmKaouWkI8MGiA5AJlzUb7u1R617m1K/V3xGaYXLOl
         R2p3oEIK7kX4fm4AU2mVYwpBe5JtCHVCPENJD8JpERcDEMYl3ciDPXWqBenBGo+pPaO/
         0OvuOrTGG951ofSVK87wtFnc5gAm2556mp5NeTY0osIp/AHsFeGseg4l59v3xH8rU672
         bN4xPoT7musf8qSY+ChCO5MZ+SAVLRf4RSXbyawCEfdGD04x1AjMvlskEwYoWfc4b3j3
         gRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wV3xZtmIvvBa/VB6409dWLHOKAVs1cwppO2sKYXA+jE=;
        b=FGepsCaez1NCwP2Vyd9yHsLhOxQAhWvPIio+BUe9MUmV80040v8GfCxzeXbs3eb1Qa
         t6pR2pqBm13AdhE647HvKl9dhOjAD6KYAlGzPHeeOMYef/WN53ha8hQkid/e16SvBkVO
         1IafbUT5vZ10q4i6TuZDFhmy2p2DS56n64XvA+9dmlXtKZyXgym4r7DiJlN/tWIdlBbE
         av2MPR/8WgSBkiCXMBUG8WHqFmxHEFFaq7E7ADCYw6IV2PUyDYbRBNqyC/sElB3IVnTc
         F+QS10jftaHauc6b9+H6nZs14bK1zDkcbkMb0ZIOHDhEqTxbwCqiH+hbs9eTG41fwlUe
         pA1g==
X-Gm-Message-State: AOAM530BA5IMzU2Kbk3VTilSdGmspG+Mtk4uP4iWNWy8gclgJjCxQ+IC
        W7RAyQ9fxlEgnbzUHQYtABDfHPtW1q754Q==
X-Google-Smtp-Source: ABdhPJz0w0LKQR0E6VRyKs33tgWMIA9OSm3qK91Dc54/+B2JIOTNRLgOG20DCuvQCLjkVDy9db/lJA==
X-Received: by 2002:a1c:f70a:0:b0:37c:533d:d296 with SMTP id v10-20020a1cf70a000000b0037c533dd296mr6066763wmh.147.1647563652244;
        Thu, 17 Mar 2022 17:34:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l4-20020adff484000000b00203dde8d82bsm5096548wro.88.2022.03.17.17.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 17:34:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/7] tests: allow test_* in "test_must_fail_acceptable" for "test_todo"
Date:   Fri, 18 Mar 2022 01:33:58 +0100
Message-Id: <patch-3.7-ce64e5a5268-20220318T002951Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1436.g756b814e59f
In-Reply-To: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert tests added in [1] and [2] to use "test_expect_todo" to more
specifically mark the failure condition, rather then the blank check
for failure given by "test_expect_failure".

For [1] there isn't an easy way to fit the "echo world" and "test_cmp"
into a "test_todo", and in any case we might not have that output once
we fix the bug noted in [1].

For [2] we'd need add "test_with_config" (which invokes both "git" and
"test-tool" to the list in "test_must_fail_acceptable", but adding a
file-specific function to "test-lib-functions.sh" would be a bit odd.

Let's instead expand the restrictive list added in
6a67c759489 (test-lib-functions: restrict test_must_fail usage,
2020-07-07). As shown in the commits that preceded it the list came
about because we wanted to exclude the likes of "cvs" and "p4" from
"test_might_fail".

It's a fair bet that if we use it with a test_* function that that
function is being appropriately used with it (i.e. invokes one of or
own programs). It's possible that without an exhaustive list we'll get
it wrong, but I also don't think it's worth it to maintain that
exhaustive list. Let's just allow all test_* names instead.

1. 90a6464b4ad (rerere: make sure it works even in a workdir attached
   to a young repository, 2011-03-10
2. 751d3b9415f (t1309: document cases where we would want early config
   not to die(), 2017-03-13)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1021-rerere-in-workdir.sh |  9 +++++----
 t/t1309-early-config.sh      | 14 ++++++++++----
 t/test-lib-functions.sh      |  2 +-
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/t/t1021-rerere-in-workdir.sh b/t/t1021-rerere-in-workdir.sh
index 0b892894eb9..e4f4b9124c3 100755
--- a/t/t1021-rerere-in-workdir.sh
+++ b/t/t1021-rerere-in-workdir.sh
@@ -41,7 +41,7 @@ test_expect_success SYMLINKS 'rerere in workdir' '
 # For the purpose of helping contrib/workdir/git-new-workdir users, we do not
 # have to support relative symlinks, but it might be nicer to make this work
 # with a relative symbolic link someday.
-test_expect_failure SYMLINKS 'rerere in workdir (relative)' '
+test_expect_todo SYMLINKS 'rerere in workdir (relative)' '
 	rm -rf .git/rr-cache &&
 	"$SHELL_PATH" "$TEST_DIRECTORY/../contrib/workdir/git-new-workdir" . krow &&
 	(
@@ -49,9 +49,10 @@ test_expect_failure SYMLINKS 'rerere in workdir (relative)' '
 		rm -f .git/rr-cache &&
 		ln -s ../.git/rr-cache .git/rr-cache &&
 		test_must_fail git merge side &&
-		git rerere status >actual &&
-		echo world >expect &&
-		test_cmp expect actual
+		test_todo \
+			--want "git" \
+			--expect "test_must_fail git" \
+			 -- rerere status
 	)
 '
 
diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index 537435b90ae..fedbdac621a 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -81,13 +81,19 @@ test_expect_success 'ignore .git/ with incompatible repository version' '
 	test_i18ngrep "warning:.* Expected git repo version <= [1-9]" err
 '
 
-test_expect_failure 'ignore .git/ with invalid repository version' '
-	test_with_config "[core]repositoryformatversion = invalid"
+test_expect_todo 'ignore .git/ with invalid repository version' '
+	test_todo \
+		--want test_with_config \
+		--expect "test_must_fail test_with_config" \
+		-- "[core]repositoryformatversion = invalid"
 '
 
 
-test_expect_failure 'ignore .git/ with invalid config' '
-	test_with_config "["
+test_expect_todo 'ignore .git/ with invalid config' '
+	test_todo \
+		--want test_with_config \
+		--expect "test_must_fail test_with_config" \
+		-- "["
 '
 
 test_expect_success 'early config and onbranch' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 53335393b9b..64b9580f2bc 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1127,7 +1127,7 @@ test_must_fail_acceptable () {
 	fi
 
 	case "$1" in
-	git|__git*|test-tool|test_terminal)
+	git|__git*|test-tool|test_*)
 		return 0
 		;;
 	*)
-- 
2.35.1.1436.g756b814e59f

