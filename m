Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9EDC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D28610E7
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhFGMh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:37:29 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:40925 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhFGMhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:37:25 -0400
Received: by mail-wr1-f46.google.com with SMTP id y7so12779024wrh.7
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 05:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aWHAF5+qY9QLeWxd+QVRUKURcvZl9MIay7iwE4iRI00=;
        b=EBHZ1trVBheRmkNeBgLfxPCzCUgqVXhfsHZkDVNTpPuWZun/pKOAc0lc3JOLKsOpAY
         Af90rBg05Ck/SQCkhnyqaB32igY/rtiVbC6kEeQ9jmY5fgKIqJheArm0dkNdeaEfc5DV
         Lw5ogExvurwE7HbdHCYzBkl08RMIxO+rfHdpyz/r1y/AVCcdaWfEYcdazE8Axxqbdi9g
         kpWMiBkVu4EPh0woR9mL+yhIQOUMobPoL0EG+NIdvq+t6ULF5OWwWQwoFamz/9VGYe9H
         zL7D6UvR8+FZfkNXFEVAX/yXRodPFx0rjIpDHhtQvx3tszbtO4irNzKxrge2YjwtK2Cu
         D0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aWHAF5+qY9QLeWxd+QVRUKURcvZl9MIay7iwE4iRI00=;
        b=IF7Fwoxpe5jPWxYMkw3dIcFVSF1/UwwUVeBipNyB4CykmHHygmGUN7ieavpWHt6nTd
         hbBzpm9wA9PgnEpkOdBA4Xjw47fq9RBaSW/40pGQDHGz0rqe3enXGumnfkm8A3PGHr9r
         INyee695cA6aoJ/T8HFISgau6w1Ry/wNslmEPk4+KhgFq9bzL9Kb5W5pmTZyyp4hmPwW
         saDvI1v9gI1Cug+DC19ZIohHsi7Dqb5ZTTvwmNxDJjwbDspWWmjMg8VOGcUikoc4QHoe
         vSGdl3+VaCwlWeGK17N4WyFN6rIoUdWAHaur/8UBIvq05O2Y2s+66W+YNMwFLkXwBxuA
         YI+A==
X-Gm-Message-State: AOAM533jWvrBreFpfJoaWKRGb/yfHNu07s6oCda9tFH7yspa+ubMviJR
        IawWP50YEbhmb3grcJB4MVD3EI8wR2o=
X-Google-Smtp-Source: ABdhPJxrk9OKt39Vv/kgzbKQPzUIWkvHVnHPrMAmr8HEqTBbPXtiIpt42WPo0uTEV+KE/Vyda06FKg==
X-Received: by 2002:adf:bc07:: with SMTP id s7mr17055184wrg.301.1623069256715;
        Mon, 07 Jun 2021 05:34:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18sm14194706wmj.13.2021.06.07.05.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 05:34:16 -0700 (PDT)
Message-Id: <f4dddac1859e145bef7194cfe9c0177dcc8b4043.1623069252.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
        <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 12:34:02 +0000
Subject: [PATCH v5 04/14] t1092: expand repository data shape
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As more features integrate with the sparse-index feature, more and more
special cases arise that require different data shapes within the tree
structure of the repository in order to demonstrate those cases.

Add several interesting special cases all at once instead of sprinkling
them across several commits. The interesting cases being added here are:

* Add sparse-directory entries on both sides of directories within the
  sparse-checkout definition.

* Add directories outside the sparse-checkout definition who have only
  one entry and are the first entry of a directory with multiple
  entries.

Later tests will take advantage of these shapes, but they also deepen
the tests that already exist.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 39 ++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index d55478a1902b..014a507d8b06 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -17,7 +17,7 @@ test_expect_success 'setup' '
 		echo "after folder1" >g &&
 		echo "after x" >z &&
 		mkdir folder1 folder2 deep x &&
-		mkdir deep/deeper1 deep/deeper2 &&
+		mkdir deep/deeper1 deep/deeper2 deep/before deep/later &&
 		mkdir deep/deeper1/deepest &&
 		echo "after deeper1" >deep/e &&
 		echo "after deepest" >deep/deeper1/e &&
@@ -25,10 +25,20 @@ test_expect_success 'setup' '
 		cp a folder2 &&
 		cp a x &&
 		cp a deep &&
+		cp a deep/before &&
 		cp a deep/deeper1 &&
 		cp a deep/deeper2 &&
+		cp a deep/later &&
 		cp a deep/deeper1/deepest &&
 		cp -r deep/deeper1/deepest deep/deeper2 &&
+		mkdir deep/deeper1/0 &&
+		mkdir deep/deeper1/0/0 &&
+		touch deep/deeper1/0/1 &&
+		touch deep/deeper1/0/0/0 &&
+		cp -r deep/deeper1/0 folder1 &&
+		cp -r deep/deeper1/0 folder2 &&
+		echo >>folder1/0/0/0 &&
+		echo >>folder2/0/1 &&
 		git add . &&
 		git commit -m "initial commit" &&
 		git checkout -b base &&
@@ -56,11 +66,17 @@ test_expect_success 'setup' '
 		mv folder1/a folder2/b &&
 		mv folder1/larger-content folder2/edited-content &&
 		echo >>folder2/edited-content &&
+		echo >>folder2/0/1 &&
+		echo stuff >>deep/deeper1/a &&
 		git add . &&
 		git commit -m "rename folder1/... to folder2/..." &&
 
 		git checkout -b rename-out-to-in rename-base &&
 		mv folder1/a deep/deeper1/b &&
+		echo more stuff >>deep/deeper1/a &&
+		rm folder2/0/1 &&
+		mkdir folder2/0/1 &&
+		echo >>folder2/0/1/1 &&
 		mv folder1/larger-content deep/deeper1/edited-content &&
 		echo >>deep/deeper1/edited-content &&
 		git add . &&
@@ -68,6 +84,9 @@ test_expect_success 'setup' '
 
 		git checkout -b rename-in-to-out rename-base &&
 		mv deep/deeper1/a folder1/b &&
+		echo >>folder2/0/1 &&
+		rm -rf folder1/0/0 &&
+		echo >>folder1/0/0 &&
 		mv deep/deeper1/larger-content folder1/edited-content &&
 		echo >>folder1/edited-content &&
 		git add . &&
@@ -262,13 +281,29 @@ test_expect_success 'diff --staged' '
 	test_all_match git diff --staged
 '
 
-test_expect_success 'diff with renames' '
+test_expect_success 'diff with renames and conflicts' '
 	init_repos &&
 
 	for branch in rename-out-to-out rename-out-to-in rename-in-to-out
 	do
 		test_all_match git checkout rename-base &&
 		test_all_match git checkout $branch -- .&&
+		test_all_match git status --porcelain=v2 &&
+		test_all_match git diff --staged --no-renames &&
+		test_all_match git diff --staged --find-renames || return 1
+	done
+'
+
+test_expect_success 'diff with directory/file conflicts' '
+	init_repos &&
+
+	for branch in rename-out-to-out rename-out-to-in rename-in-to-out
+	do
+		git -C full-checkout reset --hard &&
+		test_sparse_match git reset --hard &&
+		test_all_match git checkout $branch &&
+		test_all_match git checkout rename-base -- . &&
+		test_all_match git status --porcelain=v2 &&
 		test_all_match git diff --staged --no-renames &&
 		test_all_match git diff --staged --find-renames || return 1
 	done
-- 
gitgitgadget

