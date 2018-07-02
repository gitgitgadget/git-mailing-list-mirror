Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BF211F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752916AbeGBAZI (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:25:08 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42408 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbeGBAY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:24:57 -0400
Received: by mail-io0-f196.google.com with SMTP id r24-v6so13225988ioh.9
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4r9bxVYU/xeyXIJW0QY1PuObXJ2VE2GPcgY8EfWDj0A=;
        b=Ea3v9YHph++U3RIrDrs2wc54PTguWz+QfhH0Y6mNmcG9z1kcGj7KgfvQChJF49mSup
         mnsNd1NOKiz3QjJQfPAkqz51zvIVzg6ExcKXYv5KdEjg9iVo+3FVAQpVKfzLNciMr4wV
         v4DJdeK7mbWyD2iHJJXr1mdgF23MgVGooTHg/OqWOucrUgq0/BL4DRJ/f+krHifasdBB
         EQq7lidoI126tlF9ez3JHOGg2nGs6C5XpQQjFuhNycjt0ouvpIkLNdTC4UGzdr1MZRiL
         JAxwzKUFmZr5V+SAQdwhP8syYk+WYIjBepdbeBxaC0U7vz3U1SfL5jdFDmv0DbSSfElf
         JX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=4r9bxVYU/xeyXIJW0QY1PuObXJ2VE2GPcgY8EfWDj0A=;
        b=B990rbWFRvEDK5zpVl6qY8IzmNbvv/6dGvr3AXbPuGv3+w/5XLJvjyIWOq81tNuZVL
         MH6/MLQ8zQ+vRR/dDuQG/YtoZAkVqqpFLYnO9v+O7D+OwaP7gTg7Rd5jHEnB6yA+dddM
         C6Iluzk3W5hu7H1mRb9dakzGpZltuxKbFIAvCkWqrUHyGDzQwWyXwdbzuw83rH6buMdh
         H+ZYxB718tVElkSB+B43iChZQswq3epVtw36c1K20XgHDEGCw4SqEU2tTx+Dyv3ETXdm
         7G0qzDAaqpkFvk6JmLOuUmOyo7G0/TjIYnuLQJbwdQLV6p21q6GKQpmmvmr3jkTDQDa8
         eMKw==
X-Gm-Message-State: APt69E0ry/EDDr9hJBBwfvo+okxreKQuqtnkqGJKhH44VES9z8NHGDGV
        ELRO5/D8yoSlR/Hh51c/eCcDtg==
X-Google-Smtp-Source: AAOMgpfwGQ5cMw3ykWWD3ubr4eKSIbsqpopn2Y0B3EsCiVkzK0VsoVaPbVZTRcwrVXAHUxebjtU/xA==
X-Received: by 2002:a6b:5a0a:: with SMTP id o10-v6mr19417006iob.244.1530491096669;
        Sun, 01 Jul 2018 17:24:56 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.24.55
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:24:56 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 08/25] t5505: modernize and simplify hard-to-digest test
Date:   Sun,  1 Jul 2018 20:23:48 -0400
Message-Id: <20180702002405.3042-9-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test uses a subshell within a subshell but is formatted in such a
way as to suggests that the inner subshell is a sibling rather than a
child, which makes it difficult to digest the test's structure and
intent.

Worse, the inner subshell performs cleanup of actions from earlier in
the test, however, a failure between the initial actions and the cleanup
will prevent the cleanup from taking place.

Fix these problems by modernizing and simplifying the test and by using
test_when_finished() for the cleanup action.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t5505-remote.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index a6c0178f3a..3552b51b4c 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -348,17 +348,13 @@ URL: $(pwd)/one
 EOF
 
 test_expect_success 'prune --dry-run' '
-	(
-		cd one &&
-		git branch -m side2 side) &&
+	git -C one branch -m side2 side &&
+	test_when_finished "git -C one branch -m side side2" &&
 	(
 		cd test &&
 		git remote prune --dry-run origin >output &&
 		git rev-parse refs/remotes/origin/side2 &&
 		test_must_fail git rev-parse refs/remotes/origin/side &&
-	(
-		cd ../one &&
-		git branch -m side side2) &&
 		test_i18ncmp expect output
 	)
 '
-- 
2.18.0.203.gfac676dfb9

