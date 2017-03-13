Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89E47201C2
	for <e@80x24.org>; Mon, 13 Mar 2017 06:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbdCMGhI (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 02:37:08 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35035 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbdCMGhG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 02:37:06 -0400
Received: by mail-pg0-f65.google.com with SMTP id g2so12655911pge.2
        for <git@vger.kernel.org>; Sun, 12 Mar 2017 23:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:to:cc:subject:date:in-reply-to:references;
        bh=sQjCm/MYpoCWBfdddwusfUG9rFhdhkV1ncBTIyw73Ek=;
        b=Eu6WcrLGRSJms4Oa+IZw6CHX93Zrqux/c0g1EMMshQaHXXVdmBStLtykqUNqSABM0i
         l0Xrb3lKeuN5a8IU9p6BihKhs9wtrEXQIiCkHA8Z8XPXHomd8vMz5obt68Vr+GW2jwhC
         TpBfQiccdfy9DmajxhWXxEPnMVHbZxWE3ABUsDFqgXN42cuZEGTS7rF24VavE6mnuZrp
         r8uAOMb+7RtJA8SmurOxQUFMuqHqntl+OvqRVkUNJMplqGWriNLa9EfIvJelqthCnmYi
         YJhV/xkYs5cPGCNqBgYsWhhPNW3sxzWmD6xcHEqRGwktLxfGc44HGyqN0dqCdD3/l50k
         SXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:subject:date:in-reply-to
         :references;
        bh=sQjCm/MYpoCWBfdddwusfUG9rFhdhkV1ncBTIyw73Ek=;
        b=ewKJsXzLc+C4a1LUdK9N6KdDsqsTAkTVaq4yT+iqmSkt+q/2fOdK3TIzn4Cm5dpkYc
         NEkfe3H1zZl8jHHeoL4wxBpYUZ5R4ofsV8AoijrGPvF4OALt5TffuUqKunKgnxqsPcmW
         KRIMIRAk2BLmfW+zoARy51YRvsNSDYciPX0HHPp9lCnovKLHLaq+y1buGtBAAtdNorGe
         EyEDsdRX14yBVABg0z6lX4Mgn/XHcGaaOI2OQrJZGYqSGKsQpmYpaJ81o5saMpHIIjAM
         0bxIDmaeGzHIbb/iMP/qw3HOH17SN+bdrZknAO6jfpt03pWik7rguoDnRvwpwlENEBiy
         Bqyw==
X-Gm-Message-State: AMke39kMfk2ZUVxo6aKN1gAkIicISZ+/4g7eQCIdn6as2c3dnSO6trFJwkjQxF1LbIv2ig==
X-Received: by 10.84.150.129 with SMTP id h1mr44871324plh.86.1489387025396;
        Sun, 12 Mar 2017 23:37:05 -0700 (PDT)
Received: from localhost.localdomain ([47.11.2.204])
        by smtp.gmail.com with ESMTPSA id u82sm31250551pfd.7.2017.03.12.23.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 12 Mar 2017 23:37:04 -0700 (PDT)
Message-ID: <58c63e10.5585620a.a224d.11cd@mx.google.com>
X-Google-Original-Message-ID: <20170313063648.9026-1-Prathamesh>
From:   pc44800@gmail.com
X-Google-Original-From: Prathamesh
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, jdl@jdl.com,
        Prathamesh <pc44800@gmail.com>
Subject: [PATCH v3] t2027: avoid using pipes
Date:   Mon, 13 Mar 2017 12:06:48 +0530
X-Mailer: git-send-email 2.11.0
In-Reply-To: <xmqqk27tub1g.fsf@gitster.mtv.corp.google.com>
References: <xmqqk27tub1g.fsf@gitster.mtv.corp.google.com>
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
Changed sendemail.name configuration of the .gitconfig file with a single
name, and also included the leftover files of each test to be removed by
test_when_finished if the test is passed successfully.

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

