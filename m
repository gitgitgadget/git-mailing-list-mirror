Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9720CCA489
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 01:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbiGWBxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 21:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiGWBx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 21:53:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D92B7695B
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 18:53:27 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so3337668wmm.4
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 18:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4zhEC3zh7o47SI+pu5atHsxDoFrVxDahs1drKtbiMTc=;
        b=kdObeyy2Cj0KYaINJdBmOkAddaE8jqNbd26wUkChP+eaEpnoigazamGUcdL7QUTKBZ
         z3wqVtkFdkr+PAsXgiAMj2RLbwEG8oUGDYrOvw0lsyAMpC+v+biPKwyZQ317LxeBkPmw
         9Zc98SZzCuFYWviHXm2FTL8bCCyh2UB/5WcuN9WkQ2Erk7hbKmt/sAA5VSvkZ78Q2B8o
         7XB5WPa5HYb+FG/pg/jgsQ+iR4L/V/fy4JyVKIv8BP4SAivz91Z639H/Tyx/3xb+4V4X
         +6igXjyQTVKYMDifI9jXxqeWMXEWCFMRPVut9ZBJJr6+sF9QyvUUxg26lkujH1jdoOUa
         Q12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4zhEC3zh7o47SI+pu5atHsxDoFrVxDahs1drKtbiMTc=;
        b=w7FPX+hkpmPzSR/Sdaskg5pMiKUj+KHAbicIACXGk3Shl5JQKjjOwDNlLeRSyFHTf2
         c0PyRoA1mZvXIjm039WBZaleDdUK9eXDxUIQvwle6qVl0RGz1kdtOucXlqY5kaurTghq
         0jWrso4xp1/rfLEGzwDusOUKTocSdwwONYVGqo9rjCMrUwg/dR3QOaT16R66RvZjrLWC
         gb+bYiCJuEnLW9pstyaOTWTBc3UBE3ClO30POZidKvcG/eOWdG4nwnNhA/qCGgwLVKCI
         oi3LSDZvRAp8hX0rLM4flZ1YbI+MY+R+wNYjRrdp9DDkciFQWcPteRlQVlCS0IJBtCXn
         aVNw==
X-Gm-Message-State: AJIora+j5Bm1bIYHbyIQPBv6VJIZNlLruuEWDqPRDIpSJ9MzESEm/by+
        S4s+96D15U6gM4RLcsu/EEEnI9PVaok=
X-Google-Smtp-Source: AGRyM1vQPYIy8tb3KFy0BPpUg+Q4eSpuOQHOGNKjmDuvOYhe+VQb31JG+N+UOcVqJKvdHUq9YhbwxQ==
X-Received: by 2002:a05:600c:3caa:b0:3a0:18e4:781b with SMTP id bg42-20020a05600c3caa00b003a018e4781bmr1467045wmb.199.1658541205715;
        Fri, 22 Jul 2022 18:53:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6-20020adfe346000000b0021d7ad6b9fdsm5800963wrj.57.2022.07.22.18.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 18:53:25 -0700 (PDT)
Message-Id: <d39d647245562f9949d2a52290ef03182b3dd78a.1658541198.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com>
References: <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
        <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jul 2022 01:53:16 +0000
Subject: [PATCH v5 6/8] merge: make restore_state() restore staged state too
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There are multiple issues at play here:

  1) If `git merge` is invoked with staged changes, it should abort
     without doing any merging, and the user's working tree and index
     should be the same as before merge was invoked.
  2) Merge strategies are responsible for enforcing the index == HEAD
     requirement. (See 9822175d2b ("Ensure index matches head before
     invoking merge machinery, round N", 2019-08-17) for some history
     around this.)
  3) Merge strategies can bail saying they are not an appropriate
     handler for the merge in question (possibly allowing other
     strategies to be used instead).
  4) Merge strategies can make changes to the index and working tree,
     and have no expectation to clean up after themselves, *even* if
     they bail out and say they are not an appropriate handler for
     the merge in question.  (The `octopus` merge strategy does this,
     for example.)
  5) Because of (3) and (4), builtin/merge.c stashes state before
     trying merge strategies and restores it afterward.

Unfortunately, if users had staged changes before calling `git merge`,
builtin/merge.c could do the following:

   * stash the changes, in order to clean up after the strategies
   * try all the merge strategies in turn, each of which report they
     cannot function due to the index not matching HEAD
   * restore the changes via "git stash apply"

But that last step would have the net effect of unstaging the user's
changes.  Fix this by adding the "--index" option to "git stash apply".
While at it, also squelch the stash apply output; we already report
"Rewinding the tree to pristine..." and don't need a detailed `git
status` report afterwards.  Also while at it, switch to using strvec
so folks don't have to count the arguments to ensure we avoided an
off-by-one error, and so it's easier to add additional arguments to
the command.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c                          | 8 +++++---
 t/t6424-merge-unrelated-index-changes.sh | 7 ++++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 780b4b9100a..e0a3299e92e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -383,20 +383,22 @@ static void reset_hard(const struct object_id *oid, int verbose)
 static void restore_state(const struct object_id *head,
 			  const struct object_id *stash)
 {
-	const char *args[] = { "stash", "apply", NULL, NULL };
+	struct strvec args = STRVEC_INIT;
 
 	if (is_null_oid(stash))
 		return;
 
 	reset_hard(head, 1);
 
-	args[2] = oid_to_hex(stash);
+	strvec_pushl(&args, "stash", "apply", "--index", "--quiet", NULL);
+	strvec_push(&args, oid_to_hex(stash));
 
 	/*
 	 * It is OK to ignore error here, for example when there was
 	 * nothing to restore.
 	 */
-	run_command_v_opt(args, RUN_GIT_CMD);
+	run_command_v_opt(args.v, RUN_GIT_CMD);
+	strvec_clear(&args);
 
 	refresh_cache(REFRESH_QUIET);
 }
diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index 2c83210f9fd..a61f20c22fe 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -292,6 +292,7 @@ test_expect_success 'with multiple strategies, recursive or ort failure do not e
 
 	test_seq 0 10 >a &&
 	git add a &&
+	git rev-parse :a >expect &&
 
 	sane_unset GIT_TEST_MERGE_ALGORITHM &&
 	test_must_fail git merge -s recursive -s ort -s octopus C^0 >output 2>&1 &&
@@ -299,7 +300,11 @@ test_expect_success 'with multiple strategies, recursive or ort failure do not e
 	grep "Trying merge strategy recursive..." output &&
 	grep "Trying merge strategy ort..." output &&
 	grep "Trying merge strategy octopus..." output &&
-	grep "No merge strategy handled the merge." output
+	grep "No merge strategy handled the merge." output &&
+
+	# Changes to "a" should remain staged
+	git rev-parse :a >actual &&
+	test_cmp expect actual
 '
 
 test_done
-- 
gitgitgadget

