Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E11DC33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 12:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28882082F
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 12:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+0tpZld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgAQMXd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 07:23:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40708 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgAQMXd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 07:23:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so22512625wrn.7
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 04:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=1yHwDi0rAPP0mV6pR42P/R00nzQIt6JVKVLqDGiwME0=;
        b=U+0tpZldBDWXGC+GGVlneMkBNmh1dW/zG24uxLnhcZA98EvPo3TRU9qXaOsPxdo06F
         Fav+UB3SsVbK3+2KhpfHVTCtIT8Lu5EuFWGsGlfoyiT/TV+1Ie8SDYKjOEUKj0laYxmm
         JcOuvpYFyimNIXZb7OIPHDf94t3qUTgoTbyP9I06G3szr8y0WD74DjoYay+RYPirfAQv
         VK+o96WI81BXfPUp8EcswNZw/1Vl8iYcDXt0O0Bkl5C1er5F3pnzOWOJynSGqcZ0eAgc
         dddajVvvsO5w4iRAj+zRiE5XefOYS82ZZllfNmQw9wdaoS7dpjvpblk1S+QD8NtQG2yj
         GoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1yHwDi0rAPP0mV6pR42P/R00nzQIt6JVKVLqDGiwME0=;
        b=cOFV5ZrB8ONMG0AuMbF/KqgBM1JqLoHm1MJ3jumYDJjEYNtgDwpBWgvuTJkt77Hwdc
         Homxl1iGTnDhjP8OvrFjLNDkSjLG2WhXIPe6JJoUvalxHPnnnFeHnVhOewlzXPihBQfF
         yGrgqYuc2MNuUr/yoCk3eRyVTwm7Pn23bI3dWPUfBv2Qpops/KKiPHb53nyCiFNgvAFU
         L9jK/RvxDhdAf6PuyD3nfQzju+IUBb7yuDAFegtz9j3JAHXXVOwVdwnnmb9cPB+xwqAj
         qQLlGuIEeZJ8JLk9PTua2VmYbIKofe/6CQPCN6EAMkVA5Z+hJuRl46KsbRCmP8BdKZxA
         ZHFQ==
X-Gm-Message-State: APjAAAWezoAWo+gI/x1x0UxpACF4o6fq7N0J3w4/6UgEoPyrO4V7hqZ/
        QECNnaVzE8J5KgMKvFhHicSvGdMT
X-Google-Smtp-Source: APXvYqxgYH7ielCadyaknInvlsTIKD88+6ehBWkFiexLxxof40ykRAcMV3MBHNwCNQPseXKSP6Rs0w==
X-Received: by 2002:a5d:6191:: with SMTP id j17mr2630411wru.427.1579263811419;
        Fri, 17 Jan 2020 04:23:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k7sm1054591wmi.19.2020.01.17.04.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 04:23:30 -0800 (PST)
Message-Id: <pull.523.git.1579263809.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Jan 2020 12:23:25 +0000
Subject: [PATCH 0/4] checkout/reset/read-tree: fix --recurse-submodules in linked worktree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes the behaviour of git checkout/reset/read-tree
--recurse-submodules when they are called in a linked worktree (created by 
git worktree add). 

Although submodules are cloned in $GIT_COMMON_DIR/worktrees/<name>/modules 
upon issuing git submodule update in the linked worktree, any invocation of 
git checkout/reset/read-tree --recurse-submodules that changes the state of
the submodule(s) will incorrectly operate on the repositories of the
submodules in the main worktree, i.e. the ones at $GIT_COMMON_DIR/modules/. 

The fourth patch fixes this behaviour by using get_git_dir() instead of 
git_common_dir() in submodule.c::submodule_move_head and 
submodule.c::submodule_unset_core_worktree to construct the path to the
submodule repository.

The first 3 patches are clean-up patches on t7410-submodule-checkout-to.sh
(renamed to t2405-worktree-submodule.sh) to bring it up to date.

Note: in the second test added in the fourth patch I used test_might_fail 
such that when the test is run on the current master, only the last test_cmp 
makes the test fail. If we want to be more strict I'll change that to :

diff --git a/t/t2405-worktree-submodule.sh b/t/t2405-worktree-submodule.sh
index eba17d9e35..31d156cce7 100755
--- a/t/t2405-worktree-submodule.sh
+++ b/t/t2405-worktree-submodule.sh
@@ -70,9 +70,9 @@ test_expect_success 'checkout --recurse-submodules uses $GIT_DIR for submodules
 test_expect_success 'core.worktree is removed in $GIT_DIR/modules/<name>/config, not in $GIT_COMMON_DIR/modules/<name>/config' '
     git -C main/sub config --get core.worktree > expect &&
     git -C checkout-recurse checkout --recurse-submodules first &&
-    test_might_fail git -C main/.git/worktrees/checkout-recurse/modules/sub config --get core.worktree > linked-config &&
+    test_expect_code 1 git -C main/.git/worktrees/checkout-recurse/modules/sub config --get core.worktree > linked-config &&
     test_must_be_empty linked-config &&
-    test_might_fail git -C main/sub config --get core.worktree > actual &&
+    git -C main/sub config --get core.worktree > actual &&
     test_cmp expect actual
 '

Cc:Max Kirillov max@max630.net [max@max630.net] Brandon Williams 
bwilliams.eng@gmail.com [bwilliams.eng@gmail.com] Jonathan Tan 
jonathantanmy@google.com [jonathantanmy@google.com] Stefan Beller 
stefanbeller@gmail.com [stefanbeller@gmail.com] Nguyễn Thái Ngọc Duy 
pclouds@gmail.com [pclouds@gmail.com]

Philippe Blain (4):
  t7410: rename to t2405-worktree-submodule.sh
  t2405: use git -C and test_commit -C instead of subshells
  t2405: clarify test descriptions and simplify test
  submodule.c: use get_git_dir() instead of get_git_common_dir()

 submodule.c                      |  6 +--
 t/t2405-worktree-submodule.sh    | 79 ++++++++++++++++++++++++++++++++
 t/t7410-submodule-checkout-to.sh | 77 -------------------------------
 3 files changed, 82 insertions(+), 80 deletions(-)
 create mode 100755 t/t2405-worktree-submodule.sh
 delete mode 100755 t/t7410-submodule-checkout-to.sh


base-commit: b4615e40a8125477e18490d868f7b65954372b43
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-523%2Fphil-blain%2Fcheckout-recurse-in-linked-worktree-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-523/phil-blain/checkout-recurse-in-linked-worktree-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/523
-- 
gitgitgadget
