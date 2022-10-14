Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F27C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 08:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJNI5R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 04:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJNI45 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 04:56:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4230514EC4F
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:56:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so4930653wmr.2
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mdgqviqxc9y6T4fAO6kDqLLief+c5Jt3pudwn3+YNc=;
        b=fwvzrjtWM9jJgU0+ifwV9jFoWkqwVhgqWYgAeAfRqhEAp1uirznYBZRBFxUAJ6OOjJ
         f3J0AZTZPyM0ICsj3/DD0E/5HiqA8E7JK9PSbge1gBLWEDEfkDj0PIrMWxVf5oEZj4e0
         9pYrQYLdDsotSGwhvmCJvy2YWxiPIbmOv53gaYx34u1ouHXrXB3Hf4PzNs61oaKHx06i
         U6xpH1NWCwXfoBqXktDL6LsHuvbItTXbU2H0mlCm3FCUFfkbfSgbUnYjiJlpS9+EW80x
         P54gbdDHhsPDb7i6+xCmYnrwXA/SEKPFrZmaC8pkPgSBiLVYQK/Bj7PuHsVATUTEJmlP
         naRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mdgqviqxc9y6T4fAO6kDqLLief+c5Jt3pudwn3+YNc=;
        b=s60aIm72ztQFP4hxBgH/P6e+MsbR+rNcHMTgZgQOP5XK/zxwj/zmXdg8hk4oRSuxeT
         63dea67FuwbOfOxZxzgM1ZdIxQjh75xZ+3xXDXr/rLImrKWtni4XnLHnOxLRZmC884Fq
         JL10jr7LQWzqC+Rc1VczPSZmkx5Y5T5S0dSeFYhW3bdw/Y40ApVGyWGarSKTMzSFEKFk
         sHkjlH3xCAwJwpneq7xY/egBzokv7BCdt5beAYRPcz7znD4aTrLPsPbKEW+fJC/0FQmZ
         7NQeIdHZpdPf9DXz4RKTbpU+cQKccZA7aFmXeCPlhP03Cy3uGlc5J1pzH+CYqDo+ANv5
         8jtA==
X-Gm-Message-State: ACrzQf3+Du460gMVOeaXU7B1TqD6J2/vK67MBEDKKZxJ9mD4F1NheKSK
        0juj7/jUdvaohzY6nrlKZ8TE4ay7SwA=
X-Google-Smtp-Source: AMsMyM4ToscI0ENOKDabr6IWTJiigYcOkVOOEbj6XpUlmKKXVolxGxHJ+SDgTfUxOu9rm/UeHXP+CA==
X-Received: by 2002:a05:600c:3506:b0:3b4:c086:fa37 with SMTP id h6-20020a05600c350600b003b4c086fa37mr9981330wmq.165.1665737810233;
        Fri, 14 Oct 2022 01:56:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d44c9000000b00228d7078c4esm1475967wrr.4.2022.10.14.01.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:56:49 -0700 (PDT)
Message-Id: <6e07cfd56917db16a281e06118cce312eb39a488.1665737804.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
References: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
        <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 08:56:41 +0000
Subject: [PATCH v3 4/7] patch-id: fix patch-id for mode changes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>, Jerry Zhang <Jerry@skydio.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jerry Zhang <Jerry@skydio.com>

Currently patch-id as used in rebase and cherry-pick does not account
for file modes if the file is modified. One consequence of this is
that if you have a local patch that changes modes, but upstream
has applied an outdated version of the patch that doesn't include
that mode change, "git rebase" will drop your local version of the
patch along with your mode changes. It also means that internal
patch-id doesn't produce the same output as the builtin, which does
account for mode changes due to them being part of diff output.

Fix by adding mode to the patch-id if it has changed, in the same
format that would be produced by diff, so that it is compatible
with builtin patch-id.

Signed-off-by: Jerry Zhang <Jerry@skydio.com>
---
 diff.c                     |  5 +++++
 t/t3419-rebase-patch-id.sh | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 199b63dbcc3..0e336c48560 100644
--- a/diff.c
+++ b/diff.c
@@ -6256,6 +6256,11 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 		} else if (p->two->mode == 0) {
 			patch_id_add_string(&ctx, "deletedfilemode");
 			patch_id_add_mode(&ctx, p->one->mode);
+		} else if (p->one->mode != p->two->mode) {
+			patch_id_add_string(&ctx, "oldmode");
+			patch_id_add_mode(&ctx, p->one->mode);
+			patch_id_add_string(&ctx, "newmode");
+			patch_id_add_mode(&ctx, p->two->mode);
 		}
 
 		if (diff_header_only) {
diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index d24e55aac8d..7181f176b81 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -48,7 +48,17 @@ test_expect_success 'setup: 500 lines' '
 	git branch -f squashed main &&
 	git checkout -q -f squashed &&
 	git reset -q --soft HEAD~2 &&
-	git commit -q -m squashed
+	git commit -q -m squashed &&
+
+	git branch -f mode main &&
+	git checkout -q -f mode &&
+	test_chmod +x file &&
+	git commit -q -a --amend &&
+
+	git branch -f modeother other &&
+	git checkout -q -f modeother &&
+	test_chmod +x file &&
+	git commit -q -a --amend
 '
 
 test_expect_success 'detect upstream patch' '
@@ -71,6 +81,13 @@ test_expect_success 'detect upstream patch binary' '
 	test_when_finished "rm .gitattributes"
 '
 
+test_expect_success 'detect upstream patch modechange' '
+	git checkout -q modeother^{} &&
+	git rebase mode &&
+	git rev-list mode...HEAD~ >revs &&
+	test_must_be_empty revs
+'
+
 test_expect_success 'do not drop patch' '
 	git checkout -q other^{} &&
 	test_must_fail git rebase squashed &&
@@ -85,4 +102,16 @@ test_expect_success 'do not drop patch binary' '
 	test_when_finished "rm .gitattributes"
 '
 
+test_expect_success 'do not drop patch modechange' '
+	git checkout -q modeother^{} &&
+	git rebase other &&
+	cat >expected <<-\EOF &&
+	diff --git a/file b/file
+	old mode 100644
+	new mode 100755
+	EOF
+	git diff HEAD~ >modediff &&
+	test_cmp expected modediff
+'
+
 test_done
-- 
gitgitgadget

