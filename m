Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E0E7202F8
	for <e@80x24.org>; Fri, 10 Mar 2017 08:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755276AbdCJIiE (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 03:38:04 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35324 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755240AbdCJIiD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 03:38:03 -0500
Received: by mail-pf0-f196.google.com with SMTP id 67so10072534pfg.2
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 00:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E8yT9XavRDX4Hn9Bx0t3B82XF01DP1ZoWCrQqC7lxcM=;
        b=S0oFDqzBuaTNp2szZQvZV5P2Sx9rqJ6bxvHLnk5PX1vs14NQLlIrzpWcj9C7Fd4DmP
         QP3pN0POt2blB2BYOBcOiVim6JVjKQQ9rYKnz5PVTO5kRs39JaeEI0F4X5AA2HWw71S0
         nbnCdsb+Xebfw3CFxajkb/JwK4QJCMxom6qL5tR68Esj5Vp4j2xRoE4jZ5+8RP9GWKeb
         8Ht3zNhx+XThMWmGsu0a+pcVgD9yzLopX9c0sZIVs/RPTJhOdz5cwmwN1Rn4M/kEYQqA
         /+CPfbVwGVo0KBjtRV6r4X9MS+AP6UOeNpxqRq41URT/kHzjOlHKP/mNiP4JeLyV2UEK
         7NjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E8yT9XavRDX4Hn9Bx0t3B82XF01DP1ZoWCrQqC7lxcM=;
        b=oWxxQU8Zu09eyA2fJkGbtlZaHgQqbplGOXC1pMpcU2AuLmYvP54cnYs/1dIQ7vHOjy
         F/TC5h6G95ve75AsuO33EK/IB4ZuWSsBR6ghc2PclehDYHaCWJmBGMb4kc+vB7b/F8+X
         NOtcFwV/8xGZzlr37ssTn8SHZtTyVfz7VYUMutQwBjclLrQVwidfs+JgERiunxO5AB//
         aOvijfC9u2wIxSlPvoaktx6P/5NiDgixBP4VMVItbY+NQ5ZPBVhUhUV4XDq3Opc7A6ux
         fUCrBW31DIqiQ56ZEarXd9vaGAaEAJaxl3idYwOt0nmaPhfXmGzJruOzqPCZlxM8JrVz
         JEag==
X-Gm-Message-State: AMke39k0kYjpY5cw0Iv3Xz/iYoMgdrjxUC28Grkrx2phkB+Q001XUPvtG6L/+cD6AHBpQg==
X-Received: by 10.84.197.3 with SMTP id m3mr23432067pld.89.1489135082561;
        Fri, 10 Mar 2017 00:38:02 -0800 (PST)
Received: from localhost.localdomain ([47.11.9.211])
        by smtp.gmail.com with ESMTPSA id a16sm17106317pgd.62.2017.03.10.00.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Mar 2017 00:38:01 -0800 (PST)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     christian.couder@gmail.com
Cc:     git@vger.kernel.org, jdl@jdl.com, pc44800@gmail.com
Subject: [Patch v2] t2027: avoid using pipes
Date:   Fri, 10 Mar 2017 14:06:11 +0530
Message-Id: <20170310083611.7374-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CAP8UFD1xQnR8aWVRqu1_k2qhEcR2fOdyHT51aUyq9EdFg7f7Xw@mail.gmail.com>
References: <CAP8UFD1xQnR8aWVRqu1_k2qhEcR2fOdyHT51aUyq9EdFg7f7Xw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Prathamesh <pc44800@gmail.com>

Whenever a git command is present in the upstream of a pipe, its failure
gets masked by piping and hence it should be avoided for testing the
upstream git command. By writing out the output of the git command to
a file, we can test the exit codes of both the commands as a failure exit
code in any command is able to stop the && chain.

Signed-off-by: Prathamesh <pc44800@gmail.com>
---
New version of patch updated to include suggested change of add the git
command which was above the grep command on a new line. Also some more
changes similar to the above change were made.
Another reason for a newer version in to improvise the previous mistake
of not including the patch version, as well as getting more familiar with
the submitting patch process.


 t/t2027-worktree-list.sh | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
index 848da5f36..a3e77fee5 100755
--- a/t/t2027-worktree-list.sh
+++ b/t/t2027-worktree-list.sh
@@ -31,7 +31,8 @@ test_expect_success '"list" all worktrees from main' '
 	test_when_finished "rm -rf here && git worktree prune" &&
 	git worktree add --detach here master &&
 	echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git worktree list | sed "s/  */ /g" >actual &&
+	git worktree list >out &&
+	sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
@@ -40,7 +41,8 @@ test_expect_success '"list" all worktrees from linked' '
 	test_when_finished "rm -rf here && git worktree prune" &&
 	git worktree add --detach here master &&
 	echo "$(git -C here rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git -C here worktree list | sed "s/  */ /g" >actual &&
+	git -C here worktree list >out &&
+	sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
@@ -73,7 +75,8 @@ test_expect_success '"list" all worktrees from bare main' '
 	git -C bare1 worktree add --detach ../there master &&
 	echo "$(pwd)/bare1 (bare)" >expect &&
 	echo "$(git -C there rev-parse --show-toplevel) $(git -C there rev-parse --short HEAD) (detached HEAD)" >>expect &&
-	git -C bare1 worktree list | sed "s/  */ /g" >actual &&
+	git -C bare1 worktree list >out &&
+	sed "s/  */ /g" <out >actual &&
 	test_cmp expect actual
 '
 
@@ -96,7 +99,8 @@ test_expect_success '"list" all worktrees from linked with a bare main' '
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

