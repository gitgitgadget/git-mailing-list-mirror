Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EEDC2095E
	for <e@80x24.org>; Fri, 24 Mar 2017 08:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754290AbdCXI2I (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 04:28:08 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33129 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbdCXI1y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 04:27:54 -0400
Received: by mail-pf0-f196.google.com with SMTP id p189so1486349pfp.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 01:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m/TbxjxMvr5L/dntDZOOCTTmnFB0A+qrbmzkjfi34Hc=;
        b=uIMlIUqKV1iU1+tjoOawktAVAReUIeYPnCMHBJ5T9RxLMQ0JDR3j2P8dVoxH1gfkQ+
         V4l6Qqtql2Kys7WEWuiKTZwajfjLfQMWW+70JCJc3PpDFFYvOlHzvduXMNsS/XZ8COB7
         1PhB4KpHemYodAgNG2uEjziMyMHgaB2wxMd3M53xR3PD0kNgGltWhwnOxbrX0ZVVE48D
         Bw5mBdJIOSOc21bUpltYuDwCrMJNqRW4dCgHBMEz3efV/tWdnBitoOo7fjJBe2OsIRH7
         bwcQ7J5EibPp2D3mWmtMVzHhe/RpsAXU7ekGz6tr1KlEnIk5TyUVi1oBlHa+ry/IV5ns
         Ke4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m/TbxjxMvr5L/dntDZOOCTTmnFB0A+qrbmzkjfi34Hc=;
        b=eM0k57uS7SNU7kJmayihMxb9cnHD3ttuWUM7h1UUwwQEH/qyvhzrCfE1ucMLquyRHq
         fE8rH7CkLtnuEmDZLnTXsMM/XovuOvHsHiuBklT40OdpcOQGS+o/l5LHWSQyYJVnSisq
         Lh5WsrnQcaIhPKd1K2v5p+xRJllv1RnzrkSBkyvoAR+OZXCc/dmBZ3PqkK1RbURMrDLr
         vCyLy/0WoOr7mWgFqh1E6AzkdJ1WzrL+PSMmccsZQ2ZNif+aL3BG/RuyEmg5xIyBl3Hd
         I52UopcL7Etu3A+7i5XbG19fD2uuPfuwAGOlMWtA6U+cWC2HbFshXE+h4yxgKgmJ+Rso
         Uhug==
X-Gm-Message-State: AFeK/H2B2BDxnf4dK+P1308pyBINLJi8OoRVRRIHev+m/vHu+uJjZ0mXTrcGfmwTCxVwSA==
X-Received: by 10.99.185.91 with SMTP id v27mr7618135pgo.65.1490344073231;
        Fri, 24 Mar 2017 01:27:53 -0700 (PDT)
Received: from localhost.localdomain ([47.11.0.254])
        by smtp.gmail.com with ESMTPSA id t70sm2917018pfe.64.2017.03.24.01.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 01:27:52 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     christian.couder@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jdl@jdl.com,
        pc44800@gmail.com
Subject: [GSoC][PATCH v4] t2027: avoid using pipes
Date:   Fri, 24 Mar 2017 13:57:36 +0530
Message-Id: <20170324082736.10301-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CAP8UFD3xOMbXgH5JATS7-cK_d0YA7Mvkk-ZpLh8sn-KYNm3wxg@mail.gmail.com>
References: <CAP8UFD3xOMbXgH5JATS7-cK_d0YA7Mvkk-ZpLh8sn-KYNm3wxg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Prathamesh <pc44800@gmail.com>

Whenever a git command is present in the upstream of a pipe, its failure
gets masked by piping and hence it should be avoided for testing the
upstream git command. By writing out the output of the git command to
a file, we can test the exit codes of both commands as a failure exit
code in any command will stop the && chain.

Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---

Hi, I am Prathamesh Chavan. This is my microproject which I have attempted 
for Google Summer of Code for 2017.
Also in this new version of patch I have changed sendemail.name configuration
of the .gitconfig file with my full name and changed the description of commit
message as asked.

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

