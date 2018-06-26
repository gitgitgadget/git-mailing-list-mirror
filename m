Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A6621F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeFZHd0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:33:26 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44527 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbeFZHaz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:30:55 -0400
Received: by mail-io0-f193.google.com with SMTP id g7-v6so14979374ioh.11
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7g2KIiL+1PSNf/l5WgcZpTFjSnv2pfuR1X15PeYFmmg=;
        b=CPOUN4TyQ90Yi+6CY3VbbL/9WYnmBBDhELQb2OAa5TJ53XMf4EXbED8RHRyH5MoG2O
         rDNPCaLT89LoWuHqnknSVWaR3vI90iAbB1/2WvUld0mCpDxxR3OrmCjxVrVcs7Y+8cTZ
         n4QvNKKfPs9x+Gr5V6T9I9fupkXHyNU6Mtvu0i47fodsUzWD7wzlPBsTCgiBdtxmrD2K
         tBzU9Wj5ynifbWHTIg0MZ8FAQVJBesXiJHlQeIgwpaoMPYmgIPTOQ8PIkG6dAzr8ndn6
         A2RnBkOt/xBlFCNeaNSkjFPin15n4xD159OYXgFNKU6OLIgHYdh7MIlHqRbeAGBdjks3
         K06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=7g2KIiL+1PSNf/l5WgcZpTFjSnv2pfuR1X15PeYFmmg=;
        b=QwVQy3z4AkI8ECYYEhZx6nmiDAhMo+QPDvxomzhgiwn5a1+Ihoj4/5aHpBa4OTIjiL
         Ll5qd87AgLvz7DoBH7gj78Pxww0Jl442ZQbjFjL9Sh09HrBv+BRO/F93Zw+RI88iV6pN
         x7GEGrd5/FORfD9xiCozQerpXZ0n23BN6GNbdM/Hd1w5jzclvAPTOfPD9ZKG3PF5a9pr
         SVy+ij4lLlwEtUfpKefKpx4AfKV6KW+14EREczKA6Pgf5CyrfSZqX+uFYoCFTBCVh+X2
         yd2qBL3yFaYzSOFTgJj3pYPSsqelCbiOAqgBZNbZcTzRmDrN1DxFURyVXlCYIYw/SAhe
         cYvg==
X-Gm-Message-State: APt69E30fcM3SMImNTOntd1FFX1aF3m18kmpytYjxOHU4yIUKXYQ/Ndc
        /ePmMg/iGgyRAcn1wNROsIs8tA==
X-Google-Smtp-Source: AAOMgpevdH+9izzMLAim6/crrYgfg+4jwwBsHwdBxG+eBVV55u+Fef0pw1C7FI3/j5YueGxvPETBlQ==
X-Received: by 2002:a6b:9b4c:: with SMTP id d73-v6mr313340ioe.106.1529998254367;
        Tue, 26 Jun 2018 00:30:54 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.30.53
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:30:53 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 05/29] t5505: modernize and simplify hard-to-digest test
Date:   Tue, 26 Jun 2018 03:29:37 -0400
Message-Id: <20180626073001.6555-6-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
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
2.18.0.419.gfe4b301394

