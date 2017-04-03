Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 153BB1FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 21:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbdDCVgf (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 17:36:35 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36217 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751990AbdDCVge (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 17:36:34 -0400
Received: by mail-pg0-f67.google.com with SMTP id 81so32475481pgh.3
        for <git@vger.kernel.org>; Mon, 03 Apr 2017 14:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MVZbeLXYWZGPOop0CTC+5clQexLIP7xvSgp5iJ19dk0=;
        b=Y6Hj9S2iIoWTs0W7zwcG24DVoa/UeSQtuiXfc/pUdsV/pCBQpCtcf2bUaS7ucSJFQ3
         SxNItTs6MYxzJNlDc1fz26XQFuvCo0Teo4ZKiLsTWt5K6+9frwgkHl/rWRFokEjEqO2i
         Rtlgzs9KGFofOff5EjpfUKaEFZS89fxOiyCSoMJC8RtImZp3GO6U4HNIPcy8+v+whStr
         2IOYcx2fDRjVi+ybzpUW9wMHzpDWC4270A08kMuPlb6ewzfPfYAqgepO5L+5/mlG42WH
         UZ4Ke2xCtyd3hiVpNeH0xA9DSlRfVlSxsnUf0UBa3vWUvhh+LVCNeae4jQGHEjJzMQEI
         Gwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MVZbeLXYWZGPOop0CTC+5clQexLIP7xvSgp5iJ19dk0=;
        b=pAlip9bbs47aoiGX0ni5LIBknG8Tkcxdsso/gKFJ4UOw3lOFa8yNWgSwnlSHDf+NKk
         z8jB4xibpsgHDypCcqWC5xmFAu1broGLGQgfo486o9XKYSaWUr9AtUjcRdro1Fx2M/id
         2H6vmrdX16eh85M92++ocTQUC+u53r9dzaDvAeFSEKJ+AHynVxnTwIcZhcho95CHKeKW
         mGLfhwoJGUOr6Twygd037DzWC9ydtkToF7zQllUgZqd5WThvriLMfjvioLzqcPJonjVk
         fB1w3ZUly/2SIMwigq4OXy+dfTtIcEpWTvMtoPfG3XLbXAhKcWU9rvAE3/j+OFzHOn8k
         ZUOw==
X-Gm-Message-State: AFeK/H3ouSWQ3Mq+XM/8eKUY0UuU7o5f6eHY8bJkkdwnTIgW1Up+mlvGL8xCJHZUtmFwcA==
X-Received: by 10.98.31.24 with SMTP id f24mr18099748pff.98.1491255393437;
        Mon, 03 Apr 2017 14:36:33 -0700 (PDT)
Received: from localhost.localdomain ([47.11.14.58])
        by smtp.gmail.com with ESMTPSA id e63sm27624276pfg.40.2017.04.03.14.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Apr 2017 14:36:32 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     sbeller@google.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        jdl@jdl.com, pc44800@gmail.com
Subject: [GSoC][PATCH v5] t2027: avoid using pipes
Date:   Tue,  4 Apr 2017 03:05:57 +0530
Message-Id: <20170403213557.27724-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CAGZ79kbmriQoJgjF0-Kv1QzU2NWn=2EGN10CbNTKYO4zCBMFaA@mail.gmail.com>
References: <CAGZ79kbmriQoJgjF0-Kv1QzU2NWn=2EGN10CbNTKYO4zCBMFaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whenever a git command is present in the upstream of a pipe, its failure
gets masked by piping. Hence we should avoid it for testing the
upstream git command. By writing out the output of the git command to
a file, we can test the exit codes of both the commands as a failure exit
code in any command is able to stop the && chain.

Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---

In this new version of the patch, I resolved the grammar mistakes
from the commit message. Thanks for pointing it out.

 t/t2027-worktree-list.sh | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
index 848da5f36..720063bf0 100755
--- a/t/t2027-worktree-list.sh
+++ b/t/t2027-worktree-list.sh
@@ -20,7 +20,7 @@ test_expect_success 'rev-parse --git-common-dir on main worktree' '
 
 test_expect_success 'rev-parse --git-path objects linked worktree' '
 	echo "$(git rev-parse --show-toplevel)/.git/objects" >expect &&
-	test_when_finished "rm -rf linked-tree && git worktree prune" &&
+	test_when_finished "rm -rf linked-tree actual expect && git worktree prune" &&
 	git worktree add --detach linked-tree master &&
 	git -C linked-tree rev-parse --git-path objects >actual &&
 	test_cmp expect actual
@@ -28,19 +28,21 @@ test_expect_success 'rev-parse --git-path objects linked worktree' '
 
 test_expect_success '"list" all worktrees from main' '
 	echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
-	test_when_finished "rm -rf here && git worktree prune" &&
+	test_when_finished "rm -rf here out actual expect && git worktree prune" &&
 	git worktree add --detach here master &&
 	echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git worktree list | sed "s/  */ /g" >actual &&
+	git worktree list >out &&
+	sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success '"list" all worktrees from linked' '
 	echo "$(git rev-parse --show-toplevel) $(git rev-parse --short HEAD) [$(git symbolic-ref --short HEAD)]" >expect &&
-	test_when_finished "rm -rf here && git worktree prune" &&
+	test_when_finished "rm -rf here out actual expect && git worktree prune" &&
 	git worktree add --detach here master &&
 	echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git -C here worktree list | sed "s/  */ /g" >actual &&
+	git -C here worktree list >out &&
+	sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
@@ -49,7 +51,7 @@ test_expect_success '"list" all worktrees --porcelain' '
 	echo "HEAD $(git rev-parse HEAD)" >>expect &&
 	echo "branch $(git symbolic-ref HEAD)" >>expect &&
 	echo >>expect &&
-	test_when_finished "rm -rf here && git worktree prune" &&
+	test_when_finished "rm -rf here actual expect && git worktree prune" &&
 	git worktree add --detach here master &&
 	echo "worktree $(git -C here rev-parse --show-toplevel)" >>expect &&
 	echo "HEAD $(git rev-parse HEAD)" >>expect &&
@@ -69,16 +71,17 @@ test_expect_success 'bare repo setup' '
 '
 
 test_expect_success '"list" all worktrees from bare main' '
-	test_when_finished "rm -rf there && git -C bare1 worktree prune" &&
+	test_when_finished "rm -rf there out actual expect && git -C bare1 worktree prune" &&
 	git -C bare1 worktree add --detach ../there master &&
 	echo "$(pwd)/bare1 (bare)" >expect &&
 	echo "$(git -C there rev-parse --show-toplevel) $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git -C bare1 worktree list | sed "s/  */ /g" >actual &&
+	git -C bare1 worktree list >out &&
+	sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success '"list" all worktrees --porcelain from bare main' '
-	test_when_finished "rm -rf there && git -C bare1 worktree prune" &&
+	test_when_finished "rm -rf there actual expect && git -C bare1 worktree prune" &&
 	git -C bare1 worktree add --detach ../there master &&
 	echo "worktree $(pwd)/bare1" >expect &&
 	echo "bare" >>expect &&
@@ -92,11 +95,12 @@ test_expect_success '"list" all worktrees --porcelain from bare main' '
 '
 
 test_expect_success '"list" all worktrees from linked with a bare main' '
-	test_when_finished "rm -rf there && git -C bare1 worktree prune" &&
+	test_when_finished "rm -rf there out actual expect && git -C bare1 worktree prune" &&
 	git -C bare1 worktree add --detach ../there master &&
 	echo "$(pwd)/bare1 (bare)" >expect &&
 	echo "$(git -C there rev-parse --show-toplevel) $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git -C there worktree list | sed "s/  */ /g" >actual &&
+	git -C there worktree list >out &&
+	sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
@@ -118,9 +122,11 @@ test_expect_success 'broken main worktree still at the top' '
 		cd linked &&
 		echo "worktree $(pwd)" >expected &&
 		echo "ref: .broken" >../.git/HEAD &&
-		git worktree list --porcelain | head -n 3 >actual &&
+		git worktree list --porcelain >out &&
+		head -n 3 out >actual &&
 		test_cmp ../expected actual &&
-		git worktree list | head -n 1 >actual.2 &&
+		git worktree list >out &&
+		head -n 1 out >actual.2 &&
 		grep -F "(error)" actual.2
 	)
 '
@@ -134,7 +140,8 @@ test_expect_success 'linked worktrees are sorted' '
 		test_commit new &&
 		git worktree add ../first &&
 		git worktree add ../second &&
-		git worktree list --porcelain | grep ^worktree >actual
+		git worktree list --porcelain >out &&
+		grep ^worktree out >actual
 	) &&
 	cat >expected <<-EOF &&
 	worktree $(pwd)/sorted/main
-- 
2.11.0

