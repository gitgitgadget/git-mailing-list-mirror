Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FA8B1F516
	for <e@80x24.org>; Sun,  1 Jul 2018 04:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeGAELd (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 00:11:33 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39267 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbeGAELa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 00:11:30 -0400
Received: by mail-oi0-f67.google.com with SMTP id d189-v6so3157720oib.6
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 21:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yb8iEc3ixEpRZlW4Ia7wDAArD9HbUPuph1GVc/233hE=;
        b=jDIJXp3hkjWF6kO8vV4nBdNFFcuBQdQWtCBf3OvP/nS7MqHMw69uhPt/786oreJQl+
         LDJLMkjdunP0BuDkx+mKFgFsUeUA5NgiRG33Qbj1P0Blpav6anlu1amTWW0DTpMstlUC
         JwANzX+79e7L9jfWlPdLpRgwO4VELg3YxRbGr09RMaI3/3eMkFojDr7iEJEBYTin0KlY
         dkGp1TDELl9v0IxIgXzhcEAManCMH/B6EsfeQPFfCYonmuNWmQW9gDiPbSK78SQzYRXq
         doRMSjbf9l4M4KaAcCO5fMfu3h9p14wCrRlAdnu0229E59iZ3pBfi0WNbJhbZJneZ98l
         dN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yb8iEc3ixEpRZlW4Ia7wDAArD9HbUPuph1GVc/233hE=;
        b=mw4XlC6x3Rn2jgN63BYx7XHu9RUkEbUAWquBNmc5fF3qEPxxpoZmHrB61kuFyMHr71
         iqvpZdJY/Grx9vsZfrxq2UD8r8VkCSz24Cagc3wIPAFYPiHXBjPj5ADLRYhvBWBQ7wdT
         4jBs/ctjT7+Gh177PsdAW4IOQBp0bZbjiglY99/mGINRd3tXGRqADxgjzNCEZAnpBp7a
         gbvvTRI04I/Srs56jX3nuS2B1jWByl0ZxpKkuaOTjf3JxkK4fnCnCEIay8DFP0dSK/09
         FICAq3vwzL3fgaAL3SxjooaAymtcVKR+K47X+tJOIqTssGOGwVmDrUjrTe+HoF3nmSrN
         wgIw==
X-Gm-Message-State: APt69E2huOoPPt0whIOX/GIjUF2k2V0uonqwBtBMJbxztopBQ95EHG7l
        OzDHt9y3P0EKeY5j4NakrIJqzg==
X-Google-Smtp-Source: AAOMgpeSccRCFpj7Jj4izw/YpVjBrastoKSKyR8TKLgrTSS0WDwndMAA9thhhmiTm1zgyUpYCpPUSQ==
X-Received: by 2002:aca:d7c2:: with SMTP id o185-v6mr11625439oig.55.1530418289695;
        Sat, 30 Jun 2018 21:11:29 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id m3-v6sm6222677oif.26.2018.06.30.21.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 21:11:29 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/6] t6036: add a failed conflict detection case with symlink modify/modify
Date:   Sat, 30 Jun 2018 21:11:17 -0700
Message-Id: <20180701041122.8753-2-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.130.gd703bbb5d
In-Reply-To: <20180701041122.8753-1-newren@gmail.com>
References: <20180701041122.8753-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh | 67 +++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index b5621303d..4a94fa5ba 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -805,4 +805,71 @@ test_expect_success 'virtual merge base handles rename/rename(1to2)/add-dest' '
 	)
 '
 
+#
+# criss-cross with modify/modify on a symlink:
+#
+#      B   D
+#      o---o
+#     / \ / \
+#  A o   X   ? F
+#     \ / \ /
+#      o---o
+#      C   E
+#
+#   Commit A: simple simlink fickle->lagoon
+#   Commit B: redirect fickle->disneyland
+#   Commit C: redirect fickle->home
+#   Commit D: merge B&C, resolving in favor of B
+#   Commit E: merge B&C, resolving in favor of C
+#
+# This is an obvious modify/modify conflict for the symlink 'fickle'.  Can
+# git detect it?
+
+test_expect_success 'setup symlink modify/modify' '
+	test_create_repo symlink-modify-modify &&
+	(
+		cd symlink-modify-modify &&
+
+		test_ln_s_add lagoon fickle &&
+		git commit -m A &&
+		git tag A &&
+
+		git checkout -b B A &&
+		git rm fickle &&
+		test_ln_s_add disneyland fickle &&
+		git commit -m B &&
+
+		git checkout -b C A &&
+		git rm fickle &&
+		test_ln_s_add home fickle &&
+		git add fickle &&
+		git commit -m C &&
+
+		git checkout -q B^0 &&
+		git merge -s ours -m D C^0 &&
+		git tag D &&
+
+		git checkout -q C^0 &&
+		git merge -s ours -m E B^0 &&
+		git tag E
+	)
+'
+
+test_expect_failure 'check symlink modify/modify' '
+	(
+		cd symlink-modify-modify &&
+
+		git checkout D^0 &&
+
+		test_must_fail git merge -s recursive E^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 3 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out
+	)
+'
+
 test_done
-- 
2.18.0.130.gd703bbb5d

