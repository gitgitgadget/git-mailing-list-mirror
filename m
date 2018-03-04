Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9E441F404
	for <e@80x24.org>; Sun,  4 Mar 2018 05:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751427AbeCDF1a (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 00:27:30 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:43795 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbeCDF13 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 00:27:29 -0500
Received: by mail-io0-f194.google.com with SMTP id l12so14636903ioc.10
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 21:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bc1Y5DQHmpnqbfyghQY/ZXS7VaW8CTcvD13sXDEEp14=;
        b=siFR2IhkQLSx3K+/KoKeJgjQVniIes0NKs2InY4kmRvrbLHdfIvYUt3KY9eEo1sT7c
         1IqlC7IUTzuIjqR9uprW+Hx+5q8nUXrZpEtpj8VMhaYBXSUmu1CDFPBdtJDIzlpMxAN7
         deyNIT+9c7UnMmzG9PKYRR/UqpywKMpVLi7LsOKwvYSs4jflytWa/7a1H472oCJE+g3E
         lCP1CVq34SQqm0t37/735yA6yhRYz8L7eVWM6HtzDFvMr70UC8uFYIFx19MupqbU6BwH
         gXtAymy4UrzqdoJ0GNH/56V1TDKwpLXsd5v7JPSpTfwbIL4g2Ch5u5hJ+eGkO05rHCJb
         4C8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Bc1Y5DQHmpnqbfyghQY/ZXS7VaW8CTcvD13sXDEEp14=;
        b=a2ecBYBDCxjJJDXJf1Pmc2NSKHF4Fke0peIUNKF90GpNzzUptiWwx8ORsYy8LeoFOk
         v+454BPGiv1wqlEOCSEDuqBqF79wXG4G+iAPo7CLiIY6H7lUfbXdsB0j3hqPNticXBIl
         tyl6Ua+l3ejyPVqzWv1ZQnkS5t/OeaKUUB/ziL7rh0Ur982NwkuLk+dxgxXsVpfw/xus
         03T6pAHf9gDVXWysrlxU+p7gD4JINSBSPFAeTHTJlClS6zKXfjefM/DHOTstvJV7VM1X
         mIqldfqEQb+hus3PNR1sxBb7+ssX418eP01jmMMlmEibaHpM8rU4Ia3bdM5O1e2M/FC4
         G0vQ==
X-Gm-Message-State: AElRT7GbOr9xC8RqCfbDylB1uOYNR89kytHBKHShoD07UNlcY0t6DWfw
        /M2MqPZOOVqdLDXZmsQy4bfafA==
X-Google-Smtp-Source: AG47ELvd/DzlVIieMTjd2wl/m11lbsLL1+HAuvBuvHn92k0k4o2BpYjxN6wDP83oaTHs8UuxG+GF2Q==
X-Received: by 10.107.178.70 with SMTP id b67mr13205076iof.55.1520141249000;
        Sat, 03 Mar 2018 21:27:29 -0800 (PST)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id 62sm6106033iow.35.2018.03.03.21.27.27
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 03 Mar 2018 21:27:28 -0800 (PST)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] t2028: fix minor error and issues in newly-added "worktree move" tests
Date:   Sun,  4 Mar 2018 00:26:47 -0500
Message-Id: <20180304052647.26614-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.16.2.660.g709887971b
In-Reply-To: <20180212094940.23834-1-pclouds@gmail.com>
References: <20180212094940.23834-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recently-added "git worktree move" tests include a minor error and a few
small issues. Specifically:

* checking non-existence of wrong file ("source" instead of
  "destination")

* unneeded redirect (">empty")

* unused variable ("toplevel")

* restoring a worktree location by means of a separate test somewhat
  distant from the test which moved it rather than using
  test_when_finished() to restore it in a self-contained fashion

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This patch is built atop nd/worktree-move-reboot in 'next'.

I didn't get around to doing a proper review of nd/worktree-move-reboot
v2 [1] until after it had graduated to 'next'. Although v2 fixed all the
issues identified in my review of v1 [2], it introduced a few minor
issues of its own. This patch addresses those issues.

[1]: https://public-inbox.org/git/20180212094940.23834-1-pclouds@gmail.com/
[2]: https://public-inbox.org/git/20180124095357.19645-1-pclouds@gmail.com/

 t/t2028-worktree-move.sh | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index 082368d8c6..d70d13dabe 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -75,7 +75,7 @@ test_expect_success 'move worktree' '
 	git worktree move source destination &&
 	test_path_is_missing source &&
 	git worktree list --porcelain | grep "^worktree.*/destination" &&
-	! git worktree list --porcelain | grep "^worktree.*/source" >empty &&
+	! git worktree list --porcelain | grep "^worktree.*/source" &&
 	git -C destination log --format=%s >actual2 &&
 	echo init >expected2 &&
 	test_cmp expected2 actual2
@@ -86,10 +86,10 @@ test_expect_success 'move main worktree' '
 '
 
 test_expect_success 'move worktree to another dir' '
-	toplevel="$(pwd)" &&
 	mkdir some-dir &&
 	git worktree move destination some-dir &&
-	test_path_is_missing source &&
+	test_when_finished "git worktree move some-dir/destination destination" &&
+	test_path_is_missing destination &&
 	git worktree list --porcelain | grep "^worktree.*/some-dir/destination" &&
 	git -C some-dir/destination log --format=%s >actual2 &&
 	echo init >expected2 &&
@@ -100,10 +100,6 @@ test_expect_success 'remove main worktree' '
 	test_must_fail git worktree remove .
 '
 
-test_expect_success 'move some-dir/destination back' '
-	git worktree move some-dir/destination destination
-'
-
 test_expect_success 'remove locked worktree' '
 	git worktree lock destination &&
 	test_when_finished "git worktree unlock destination" &&
-- 
2.16.2.660.g709887971b

