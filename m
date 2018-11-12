Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 942E71F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 23:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeKMJVT (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 04:21:19 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36978 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeKMJVT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 04:21:19 -0500
Received: by mail-pg1-f195.google.com with SMTP id 80so4752780pge.4
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 15:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sTty7TtDzzU3aKCnqSFODwCSTj1JCcgiFDrry2wwdaw=;
        b=c+gx6qDyirbBO8ZdIfRNPNiUYnhFkkEJY2zRLwW3pNSRpWhC5pXaJkJpEHcJdqRp5G
         qXH522YweuMgfgIrmYMAIa/FFUUAS6VBoPnN6rIM9RaQ0A7XtmTHYuG1hSvNCANwewBo
         70ZkzdFWHqwHFn4yul2wNdlewj0nbwzJ8Om+Z2Q4ENXxf3U0/IcJXlf1n9zMD69JFSK/
         hwCiJYcvYo6TyMFSMGbOgxlG4ygsEJgPK1VQywYO89AyVusD8UWGJimBON0gtPYo95SE
         HFz0Bhmh1YwJHQLVN5U7j3fjYHWpUmLvKlWvOJ6zWgVem8OUCAm9W9Ielhvz+acz1bWf
         RNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sTty7TtDzzU3aKCnqSFODwCSTj1JCcgiFDrry2wwdaw=;
        b=U9pq3GuD1xMBOWlJO4Oxsp+rII64wXkVkktStz5VKCTwkSAdmUZFA1aZ3+Xw3aHis1
         OsPrkwZe77hPN1HUHTXj8iZz1QI82lfzIoK/gsA9fQzOY/Z2KLRHGmwZOTIwOKauj8YI
         FRxTFSbcYawsBaw+gan29UtcKj3sob6Y5Lr/7X2TqbXFHqhb1bmSeN1Gev05x/wzHcpf
         zS47XAs9xXe1H+JKNpJ7Dll0lElRkD/bLMRBQh0H148CHqq1csrkF9feVMH441n00Y5z
         1oyGYEsVmV7RW+VQIB4psZF7vA7Ok4PtLpGapDVxBlGPSaQ54su5kXZ+BvUk89DkDxA2
         xN/A==
X-Gm-Message-State: AGRZ1gIdap8djHtdDjZBVvmf2s+YeIYIXmdnW8hnBGewuNX+W9pGxq+e
        xWaG18TxMr3aM/dGT7OOaSr//wct
X-Google-Smtp-Source: AJdET5fltuLBcgBBfQBPfHckLPcKVbtvmSVszgCzSLvKETXC7ocOchsacO8qAILSAk2yzHNUsD63CQ==
X-Received: by 2002:a63:ff62:: with SMTP id s34mr2580538pgk.325.1542065157967;
        Mon, 12 Nov 2018 15:25:57 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id c12-v6sm7508793pfb.174.2018.11.12.15.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 15:25:57 -0800 (PST)
Date:   Mon, 12 Nov 2018 15:25:57 -0800 (PST)
X-Google-Original-Date: Mon, 12 Nov 2018 23:25:49 GMT
Message-Id: <efdd3736a96f90a4ab52acaf2e5efbe3435bcb89.1542065154.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.75.git.gitgitgadget@gmail.com>
References: <pull.75.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/5] rebase -r: demonstrate bug with conflicting merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When calling `merge` on a branch that has already been merged, that
`merge` is skipped quietly, but currently a MERGE_HEAD file is being
left behind and will then be grabbed by the next `pick` (that did
not want to create a *merge* commit).

Demonstrate this.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3430-rebase-merges.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index aa7bfc88ec..1f08a33687 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -396,4 +396,20 @@ test_expect_success 'with --autosquash and --exec' '
 	grep "G: +G" actual
 '
 
+test_expect_failure '--continue after resolving conflicts after a merge' '
+	git checkout -b already-has-g E &&
+	git cherry-pick E..G &&
+	test_commit H2 &&
+
+	git checkout -b conflicts-in-merge H &&
+	test_commit H2 H2.t conflicts H2-conflict &&
+	test_must_fail git rebase -r already-has-g &&
+	grep conflicts H2.t &&
+	echo resolved >H2.t &&
+	git add -u &&
+	git rebase --continue &&
+	test_must_fail git rev-parse --verify HEAD^2 &&
+	test_path_is_missing .git/MERGE_HEAD
+'
+
 test_done
-- 
gitgitgadget

