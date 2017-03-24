Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB9161FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 12:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935779AbdCXMFc (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 08:05:32 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34423 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934762AbdCXMFa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 08:05:30 -0400
Received: by mail-pf0-f194.google.com with SMTP id o126so81393pfb.1
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 05:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mriIHhl39cJ5rJOhFp55qMTTZnDR0VrxPo0b7Sj2MiA=;
        b=uim4dG2Pr+XjiLkTKgtjUhCYzOfXCMs2NFVphQIdWPgZclJEnHSpOP5f+Q2AXL8eLI
         YY4Vamf2jEGL03B+rXl5PP91+yhHNcvGCI/sW+UHJ/tXPyOj5lMqbJrpmTLAvtzFO71Y
         0JjevkfJKl1SY5LV6Q2IJ6NyitrDPKhVfhMvcpe7KGOGHHfEARkGKEwyvFH1Lst8LGIf
         HrHdKR9Vb1/H4nmGpWYIIko/J/m1oeh6qB7KuD4E91mnSkEHtDiE17PX1MaLh6QDdPXd
         k4lVVUvXiMi9KHX+tmcHLu9B65i6T8CDuU2jTMGkhmNngr8lA11R27dy6RHmnYsaMcQF
         JG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mriIHhl39cJ5rJOhFp55qMTTZnDR0VrxPo0b7Sj2MiA=;
        b=s5WHWvBYDc2ugoJmELueQpwe0zfJlKVmxqiAoNC/aiY7aP1fh4tWNjjx1Wh5qYKfbE
         HMUlCS52YTgUe9Qqt4G3t0gtst8Jk+prh7v9ZeGt0jTpymBsPzwGSl7yOzjfsYMQGC/Z
         6rgDRS2GjFjUoyKxIOEnb/gsQ/B43eGGT1dP5ZP9sNRIsuJ+/Ok/KPWu4R42voVqO2oD
         qPyGQpbjiUgo/Abq7cGeptQxwBpIIm0+BSs6FqECDsGHXGgx+0LMF1Ozy5XRVjAfjXEj
         7KyggCzdNWdR2tAoLEJunb9q605gx4VA1d2pk02Bwe8/xF4MPe/HRivuyprvM49yG8GX
         QvlQ==
X-Gm-Message-State: AFeK/H2ZsSN3cgTGnEbJYWwo6eoqDjTCFuaGXO4TdUNA0pdxy1UkoOruM/Xmx8HskDy5GQ==
X-Received: by 10.99.122.78 with SMTP id j14mr8578254pgn.52.1490357129060;
        Fri, 24 Mar 2017 05:05:29 -0700 (PDT)
Received: from localhost.localdomain ([47.11.0.98])
        by smtp.gmail.com with ESMTPSA id u198sm4413318pgb.45.2017.03.24.05.04.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 05:05:28 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     christian.couder@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jdl@jdl.com,
        pc44800@gmail.com
Subject: [GSoC][PATCH v4] t2027: avoid using pipes
Date:   Fri, 24 Mar 2017 17:34:33 +0530
Message-Id: <20170324120433.2890-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CAP8UFD3xOMbXgH5JATS7-cK_d0YA7Mvkk-ZpLh8sn-KYNm3wxg@mail.gmail.com>
References: <CAP8UFD3xOMbXgH5JATS7-cK_d0YA7Mvkk-ZpLh8sn-KYNm3wxg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whenever a git command is present in the upstream of a pipe, its failure
gets masked by piping and hence it should be avoided for testing the
upstream git command. By writing out the output of the git command to
a file, we can test the exit codes of both the commands as a failure exit
code in any command is able to stop the && chain.

Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---

Hi, I am Prathamesh Chavan. This is my microproject which I have attempted 
for Google Summer of Code for 2017.
Also in this new version of patch I have changed sendemail.name configuration
of the .gitconfig file with my full name and changed the description of
commit message as asked.

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

