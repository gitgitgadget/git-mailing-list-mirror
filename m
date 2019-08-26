Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3711E1F4BB
	for <e@80x24.org>; Mon, 26 Aug 2019 23:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfHZXwh (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 19:52:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42922 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfHZXwf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 19:52:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id p3so11526273pgb.9
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 16:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPlETp5/d8Gj8typhNR2859u1IBUFPe+Nj8mkMOEurQ=;
        b=tFay6wAhKwQTLciT8wFT8uHHp/bkav84QrWrZpxDh7hmicjDp+neKLJfM55VELtcWk
         o9WL8JjgOxt9buAnALQmKRIzqPI7uo+BafFdAhi8DyW23vAWE4DVMo8Xc9Z7PoFkYOw5
         QR/1lESNBmh39CqP06traR8gEw0iJx6r9oGeV4Ytlb8VRxHvEKgrPOe0SjtsSrBc4uIs
         wpw6agTjotHQ18b7fGV8BRLMMZIpPBi4iVotWCj+VrYFfUpuym6BhZko0LOW43OdSGgq
         +LPv4RrZD953lA/BKIWCqXGUqONBsVC+8n76oi9Z+FD5gSY2UQCAVEVRH5kLJd3MWD4N
         op/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPlETp5/d8Gj8typhNR2859u1IBUFPe+Nj8mkMOEurQ=;
        b=BgXytBzSbWyRlrr8DqHc0jGWYm50Wz3+VKN0bDAjr9ywx7adGZ7IzCrJv+3Gi8To0f
         9EZTX0lZ59Eq5fCXzYCKp9QzthMGRqUN7xuUPEEkm+ytEhwUhfOQyMeTVEslaOD9yved
         iow/8ATCvog0l97K8fEX/GFhUUaSKf5MIi2AndzaertRJ62DoyQngkTjjHYzIGCuENww
         RBXqK1rVNH0gcWA/qitctwFV6LttWrneYW1pwzvp+RPyqxM7xP+hQqi+kuBD0+DxcUlE
         AJNQbeStFI/GDYb8irNH/WQ7eTUGtQvBg6pqqK3Ga39PHH2pLbsbtH3r26xwghsRoQ0u
         5XpQ==
X-Gm-Message-State: APjAAAVyaL1rJd8hzbz17qTDb3SyIRzZQ/O5X3zDmmuQoXuJhLrPvcam
        Gp1s6StPjNVQFZT4KESCfWWF6ekL
X-Google-Smtp-Source: APXvYqyqzkIfi8y+Q/Uvz//3t1Fg5/XYxaWGMWKstOrGF5QMOqofc/YZiX+UgthzKBgFJNa9LTeBHg==
X-Received: by 2002:a17:90a:2069:: with SMTP id n96mr22234794pjc.4.1566863554376;
        Mon, 26 Aug 2019 16:52:34 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id 21sm5939047pfb.96.2019.08.26.16.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Aug 2019 16:52:33 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 2/5] t3427: accelerate this test by using fast-export and fast-import
Date:   Mon, 26 Aug 2019 16:52:23 -0700
Message-Id: <20190826235226.15386-3-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.5.g775ebaa2a0
In-Reply-To: <20190826235226.15386-1-newren@gmail.com>
References: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com>
 <20190826235226.15386-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fast-export and fast-import can easily handle the simple rewrite that
was being done by filter-branch, and should be significantly faster on
systems with a slow fork.  Timings from before and after on two laptops
that I have access to (measured via `time ./t3427-rebase-subtree.sh`,
i.e. including everything in this test -- not just the filter-branch or
fast-export/fast-import pair):

   Linux:  4.305s -> 3.684s (~17% speedup)
   Mac:   10.128s -> 7.038s (~30% speedup)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3427-rebase-subtree.sh | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index d8640522a0..d05fcce5dc 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -42,7 +42,9 @@ test_expect_failure REBASE_P \
 	'Rebase -Xsubtree --preserve-merges --onto commit 4' '
 	reset_rebase &&
 	git checkout -b rebase-preserve-merges-4 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git fast-export --no-data HEAD -- files_subtree/ \
+		| sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" \
+		| git fast-import --force --quiet &&
 	git commit -m "Empty commit" --allow-empty &&
 	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
 	verbose test "$(commit_message HEAD~)" = "files_subtree/master4"
@@ -53,7 +55,9 @@ test_expect_failure REBASE_P \
 	'Rebase -Xsubtree --preserve-merges --onto commit 5' '
 	reset_rebase &&
 	git checkout -b rebase-preserve-merges-5 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git fast-export --no-data HEAD -- files_subtree/ \
+		| sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" \
+		| git fast-import --force --quiet &&
 	git commit -m "Empty commit" --allow-empty &&
 	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
 	verbose test "$(commit_message HEAD)" = "files_subtree/master5"
@@ -64,7 +68,9 @@ test_expect_failure REBASE_P \
 	'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 4' '
 	reset_rebase &&
 	git checkout -b rebase-keep-empty-4 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git fast-export --no-data HEAD -- files_subtree/ \
+		| sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" \
+		| git fast-import --force --quiet &&
 	git commit -m "Empty commit" --allow-empty &&
 	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
 	verbose test "$(commit_message HEAD~2)" = "files_subtree/master4"
@@ -75,7 +81,9 @@ test_expect_failure REBASE_P \
 	'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit 5' '
 	reset_rebase &&
 	git checkout -b rebase-keep-empty-5 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git fast-export --no-data HEAD -- files_subtree/ \
+		| sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" \
+		| git fast-import --force --quiet &&
 	git commit -m "Empty commit" --allow-empty &&
 	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
 	verbose test "$(commit_message HEAD~)" = "files_subtree/master5"
@@ -86,7 +94,9 @@ test_expect_failure REBASE_P \
 	'Rebase -Xsubtree --keep-empty --preserve-merges --onto empty commit' '
 	reset_rebase &&
 	git checkout -b rebase-keep-empty-empty master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git fast-export --no-data HEAD -- files_subtree/ \
+		| sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" \
+		| git fast-import --force --quiet &&
 	git commit -m "Empty commit" --allow-empty &&
 	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
 	verbose test "$(commit_message HEAD)" = "Empty commit"
@@ -96,7 +106,9 @@ test_expect_failure REBASE_P \
 test_expect_failure 'Rebase -Xsubtree --onto commit 4' '
 	reset_rebase &&
 	git checkout -b rebase-onto-4 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git fast-export --no-data HEAD -- files_subtree/ \
+		| sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" \
+		| git fast-import --force --quiet &&
 	git commit -m "Empty commit" --allow-empty &&
 	git rebase -Xsubtree=files_subtree --onto files-master master &&
 	verbose test "$(commit_message HEAD~2)" = "files_subtree/master4"
@@ -106,7 +118,9 @@ test_expect_failure 'Rebase -Xsubtree --onto commit 4' '
 test_expect_failure 'Rebase -Xsubtree --onto commit 5' '
 	reset_rebase &&
 	git checkout -b rebase-onto-5 master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git fast-export --no-data HEAD -- files_subtree/ \
+		| sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" \
+		| git fast-import --force --quiet &&
 	git commit -m "Empty commit" --allow-empty &&
 	git rebase -Xsubtree=files_subtree --onto files-master master &&
 	verbose test "$(commit_message HEAD~)" = "files_subtree/master5"
@@ -115,7 +129,9 @@ test_expect_failure 'Rebase -Xsubtree --onto commit 5' '
 test_expect_failure 'Rebase -Xsubtree --onto empty commit' '
 	reset_rebase &&
 	git checkout -b rebase-onto-empty master &&
-	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
+	git fast-export --no-data HEAD -- files_subtree/ \
+		| sed -e "s%\([0-9a-f]\{40\} \)files_subtree/%\1%" \
+		| git fast-import --force --quiet &&
 	git commit -m "Empty commit" --allow-empty &&
 	git rebase -Xsubtree=files_subtree --onto files-master master &&
 	verbose test "$(commit_message HEAD)" = "Empty commit"
-- 
2.23.0.5.g775ebaa2a0

