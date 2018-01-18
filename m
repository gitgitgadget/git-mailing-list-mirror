Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A42821FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 14:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756639AbeAROvO (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 09:51:14 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45701 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756624AbeAROvL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 09:51:11 -0500
Received: by mail-lf0-f65.google.com with SMTP id x196so6991791lfd.12
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 06:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=f9apXCOlCV5qT/u4pH0lVdktRN5bCPOC167+zbSLUkk=;
        b=fkZZsN+5stytJRu61v90+medoPa0E8LmRMX38l6BK8BIsa6Ti9dCgmimos3oHxQByM
         lbgJBALsomJKo+FUnWcbq9ZiHzHQfjrOqkqqRvPjxG/IPt7iHPAWiAKVqWteWkbVu7FM
         CwLCaKgnbQRL1DCA0LnCQI5k/irJ3/d8PHTYmF8aHiIrVBpP6XqzcKMjPnM6HAkO91Vv
         hxUXJWI7qiJRTfkSIZx57qHZpmluKOH7ryXNKWK2R0boq8anxOYg3rwnq88BLFM8tbkN
         24EKwQxr3/E/k+yAOZtKmnD15IjnLMoYsjhF6X9YhD9/ypTLBVtlcrJDSK3tbvYKXinj
         cxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=f9apXCOlCV5qT/u4pH0lVdktRN5bCPOC167+zbSLUkk=;
        b=CfyVQrbk9p8HYicjgvtXBZ8LtRHF2xXJP8f/6b5j/E/ZJKRRzFFOiG9+4ilXoiJgZM
         RFgi7ygmu0Xx8Zj+nmaPAoSWKg7NvSVqoA5jI4T3AWngJS7ElocvncdHTeRmcpqC9mRQ
         4W9Ymm4aCJG5+xMdQww26JqwALkj6mkCoyoZ0m9tByxhLJ1LZ7BKSAaNDF8GCNYkbH1K
         d0shZ4hDskTJgKNMj8+TEem6wpGihogeFdTFGpKUWsZ8Bmbb6hFUylSXr+Jet4qzMDT/
         b/Eo+CfRP6txrpTPJzjyKxqfEVLTTaN6aoWGrnkq5O53cAQ8QPJCI/6tRyRYkfpbZ17+
         7LyQ==
X-Gm-Message-State: AKwxytdelCNTS/eIIGrM+8zcrSk1QfR72pMimuriQK+KKLvfRsCQjPip
        X7+M6LF4s11WIfABhlv+tp60Pwd4hj4=
X-Google-Smtp-Source: ACJfBovsI8v5KagSyGS8xt47g7i8wxKUpgvab/B9pRmMSIuvn+IKJnoBVx3hxkiVYg8KbSKTCQa1rQ==
X-Received: by 10.25.42.197 with SMTP id q66mr16775639lfq.25.1516287070297;
        Thu, 18 Jan 2018 06:51:10 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id 23sm560988lju.28.2018.01.18.06.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jan 2018 06:51:09 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.ath.cx>
Subject: [PATCH 02/11] clang-format: adjust penalty for return type line break
Date:   Thu, 18 Jan 2018 15:50:54 +0100
Message-Id: <97071dd7f5132e333627eb2326a88af9dfd08930.1516282880.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516282880.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516282880.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The penalty of 5 makes clang-format very eager to put even short type
declarations (e.g. "extern int") into a separate line, even when
breaking parameters list is sufficient.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 .clang-format | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index 611ab4750b..12a89f95f9 100644
--- a/.clang-format
+++ b/.clang-format
@@ -163,7 +163,7 @@ PenaltyBreakComment: 10
 PenaltyBreakFirstLessLess: 0
 PenaltyBreakString: 10
 PenaltyExcessCharacter: 100
-PenaltyReturnTypeOnItsOwnLine: 5
+PenaltyReturnTypeOnItsOwnLine: 60
 
 # Don't sort #include's
 SortIncludes: false
-- 
2.14.3

