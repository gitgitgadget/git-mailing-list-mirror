Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28C4C433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 21:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB9B661053
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 21:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhKBVdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 17:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbhKBVd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 17:33:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010FEC061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 14:30:54 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b184-20020a1c1bc1000000b0033140bf8dd5so368921wmb.5
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 14:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qK3GXWF4UnQreLNCI6x6NZVoWEDu+NpG/tLx3DDiLqU=;
        b=oGZG3ZInQGInrmsxZJjudqp2BvuH43I9l2ISEFm6lpPcSoBhDjcq3DAwnEfIM6w4+x
         MqR5IZVZvcOW/LdjxnX9mrPg87dh54unRpbvCo2K60K+NwpCqQc0Yk68tKWBXfZB/Tno
         HzvtW2W+EaMQZ23kqy37J4Duxb2Uk4KcGud0b8Z7w8BkoEMqxbnt38adYbF2hSFXcavv
         zxxHMxzMDCU52g5UDnfDpmPbwmxWWp9/p6p1/ia5x8xe7wKdH7JtmQQGyFU0ECyIJPsU
         5uMii5Y6Hx0g7TBnVi+NUz9iLA7lNFw6qwl5cvFDbmFYMHZqaC5p9XuQ6Bv72YK4dSB3
         4cGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qK3GXWF4UnQreLNCI6x6NZVoWEDu+NpG/tLx3DDiLqU=;
        b=Jc0Qb+Byu9sDIE6rzbHh1Ik+klN+Af+2vFos6MU8upWJE5TSPp9BpvCP1shPfx4ROm
         SoB/SWc/KZUYTDLRDQCAvaY6oa8p1YsHs1DiHw2fy3O2BSY37Vbd3DNnvR2HuUvDjqMl
         Hx7+1m8IW+EaFPuCaewT4XYPWUeDIu7b8CMHb05EnRx9aQ7YaEVUkcYYA33UJb/CHwJA
         sQNqwNjGBS51IXaXrdmkcfK1oNyKTq48WlOyd3LdjewEf4rTCCPTqHQw9Pp5dmknSGpX
         vlDAM/cCU6iF+4JsdtNRAbDffGN4C3FI/0CxzQoTr7qPCpNgTLhjsrpa8Y+6LmreTtT8
         WtgA==
X-Gm-Message-State: AOAM5313weqB4uNT1RtDwJe+XPADx4yTyXWnTzz6a4/b4UBsu7eSxlee
        VeKTq1iScetRPwU4HhG6F+rSoFcMymc=
X-Google-Smtp-Source: ABdhPJyip5FxIp0Db28h9kUGieB5LO3EoGSDkiMIMNeYxtMA0/NHrdpoeFBXgPI04XzVMgICOJ7fyQ==
X-Received: by 2002:a05:600c:1c87:: with SMTP id k7mr10291840wms.103.1635888652489;
        Tue, 02 Nov 2021 14:30:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k187sm3959547wme.0.2021.11.02.14.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 14:30:51 -0700 (PDT)
Message-Id: <pull.1123.v2.git.git.1635888651183.gitgitgadget@gmail.com>
In-Reply-To: <pull.1123.git.git.1635883844710.gitgitgadget@gmail.com>
References: <pull.1123.git.git.1635883844710.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Nov 2021 21:30:51 +0000
Subject: [PATCH v2] rebase -i: fix rewording with
 --committer-date-is-author-date
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonas Kittner <jonas.kittner@ruhr-uni-bochum.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

baf8ec8d3a (rebase -r: don't write .git/MERGE_MSG when
fast-forwarding, 2021-08-20) stopped reading the author script in
run_git_commit() when rewording a commit. This is normally safe
because "git commit --amend" preserves the authorship. However if the
user passes "--committer-date-is-author-date" then we need to read the
author date from the author script when rewording. Fix this regression
by tightening the check for when it is safe to skip reading the author
script.

Reported-by: Jonas Kittner <jonas.kittner@ruhr-uni-bochum.de>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    rebase -i: fix rewording with --committer-date-is-author-date
    
    This regression was introduced in the current cycle and is present in
    v2.34.0-rc0, v2.33.1 and maint
    
    Thanks to Jonas for reporting it and Peff for bisecting

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1123%2Fphillipwood%2Fwip%2Frebase-committer-date-is-author-date-fix-reword-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1123/phillipwood/wip/rebase-committer-date-is-author-date-fix-reword-v2
Pull-Request: https://github.com/git/git/pull/1123

Range-diff vs v1:

 1:  fb88c58d2fb ! 1:  6565c02ba89 rebase -i: fix rewording with --committer-date-is-author-date
     @@ Commit message
          by tightening the check for when it is safe to skip reading the author
          script.
      
     +    Reported-by: Jonas Kittner <jonas.kittner@ruhr-uni-bochum.de>
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## sequencer.c ##


 sequencer.c                    |  4 +++-
 t/t3436-rebase-more-options.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index cd2aabf1f76..ea96837cde3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -997,7 +997,9 @@ static int run_git_commit(const char *defmsg,
 
 	cmd.git_cmd = 1;
 
-	if (is_rebase_i(opts) && !(!defmsg && (flags & AMEND_MSG)) &&
+	if (is_rebase_i(opts) &&
+	    ((opts->committer_date_is_author_date && !opts->ignore_date) ||
+	     !(!defmsg && (flags & AMEND_MSG))) &&
 	    read_env_script(&cmd.env_array)) {
 		const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index 4d106642ba7..94671d3c465 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -82,6 +82,20 @@ test_expect_success '--committer-date-is-author-date works with merge backend' '
 	test_ctime_is_atime -1
 '
 
+test_expect_success '--committer-date-is-author-date works when rewording' '
+	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_MESSAGE=edited \
+			FAKE_LINES="reword 1" \
+			git rebase -i --committer-date-is-author-date HEAD^
+	) &&
+	test_write_lines edited "" >expect &&
+	git log --format="%B" -1 >actual &&
+	test_cmp expect actual &&
+	test_ctime_is_atime -1
+'
+
 test_expect_success '--committer-date-is-author-date works with rebase -r' '
 	git checkout side &&
 	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
@@ -155,6 +169,21 @@ test_expect_success '--reset-author-date with --committer-date-is-author-date wo
 	test_atime_is_ignored -2
 '
 
+test_expect_success 'reset-author-date with --committer-date-is-author-date works when rewording' '
+	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_MESSAGE=edited \
+			FAKE_LINES="reword 1" \
+			git rebase -i --committer-date-is-author-date \
+				--reset-author-date HEAD^
+	) &&
+	test_write_lines edited "" >expect &&
+	git log --format="%B" -1 >actual &&
+	test_cmp expect actual &&
+	test_atime_is_ignored -1
+'
+
 test_expect_success '--reset-author-date --committer-date-is-author-date works when forking merge' '
 	GIT_SEQUENCE_EDITOR="echo \"merge -C $(git rev-parse HEAD) commit3\">" \
 		PATH="./test-bin:$PATH" git rebase -i --strategy=test \

base-commit: 0cddd84c9f3e9c3d793ec93034ef679335f35e49
-- 
gitgitgadget
