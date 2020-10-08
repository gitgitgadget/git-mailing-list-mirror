Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4356DC4363C
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 05:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F31222087D
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 05:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="magyrG7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgJHFs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 01:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgJHFs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 01:48:26 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CF4C061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 22:48:26 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s19so2225840plp.3
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 22:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rSDQFwwU9U0XPnizLMK7RwRZdstZGhgKUdKQUokSiLU=;
        b=magyrG7/4gkpkeHur7Hwz1fOAzH6iK+yLq3jnSFKX1g1lSk4c7f0f7gCbY0+1LBF20
         pX+g5dTNSTckeMzF2mH2y2RiuzTmxx1JQIprHKl0EvAMwaGuWOYC8yYaD35IClL9c28H
         /jNAbMrs2VqZkWv3h1LTm/mCaRClkbF0qcxHGdbOZC6pWl7ymK1TsJfbiq1Qudby7vgz
         NjQBPk4fDJy3c6KxSX95GGFEVpxfFJ7tIqeGB1eiwRvn/77CInZ+QVZewXrvjEDVqOTk
         fQSNGQU543yLKPmNkzwcxtOyzvLLqJX2W7FQXrCjw1jDvbkYOhXap5IwtWwoWVz6kATT
         kP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rSDQFwwU9U0XPnizLMK7RwRZdstZGhgKUdKQUokSiLU=;
        b=AoILRMKkc7E934nbH/g0OVgik6gMGpref21D5O3w7K0MdEpi+d7ZcnpEUSdLhCWJN9
         taB2NQru8TZoCV0VgdB3a/pBNyD3RSh0LQOlSUX31Ed7zkKx1dERxw+m/mRduVfEts5+
         nxtmlHfwv+sV08YjBDxLWc1mbTr1ycBSEHFEG/6Pi7ZKTG0OSJMd70ZqUftTc+d9I/2P
         FeA3tuvWP184rvuFnvDqYPrP+/Qb3q3ueLnmZUxOncQaYsvp/7+3ZPiiFRsPRFu4NKog
         dUdwBbilKh291AB3l+5VdzrU3WhwH49D3lHU5WY/Nl9XNuVxE60+NAdacWj0fAsg3Si6
         SjlQ==
X-Gm-Message-State: AOAM530w/c+SPpz4vkiE6bQUa7InQkj9nc5Ws3yJPufTyIduXtU73Fbc
        EDRdK3PThoz2tMMqBtzCqQDK0LzX+Qo=
X-Google-Smtp-Source: ABdhPJx8oJry2vA7IBbid4ZlATTON3DdBm1OysqsEL07sd8Kw/sfYD34X2xDTrynXA0bmFdT+njh1g==
X-Received: by 2002:a17:902:ac8c:b029:d3:7f4a:70db with SMTP id h12-20020a170902ac8cb02900d37f4a70dbmr6091741plr.71.1602136105648;
        Wed, 07 Oct 2020 22:48:25 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id g4sm5706169pgg.75.2020.10.07.22.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 22:48:25 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/2] Documentation/config/checkout: replace sq with backticks
Date:   Wed,  7 Oct 2020 22:48:14 -0700
Message-Id: <f08d3f796a806b5ec20f12cc85683b2c2e99b1a8.1602136063.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.942.g77c4c6094c
In-Reply-To: <cover.1602136063.git.liu.denton@gmail.com>
References: <cover.1602047333.git.liu.denton@gmail.com> <cover.1602136063.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The modern style for Git documentation is to use backticks to quote
any command-line documenation so that it is typeset in monospace.
Replace all single quotes with backticks to conform to this.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/checkout.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
index 6b646813ab..e3684a5459 100644
--- a/Documentation/config/checkout.txt
+++ b/Documentation/config/checkout.txt
@@ -1,18 +1,18 @@
 checkout.defaultRemote::
-	When you run 'git checkout <something>'
-	or 'git switch <something>' and only have one
+	When you run `git checkout <something>`
+	or `git switch <something>` and only have one
 	remote, it may implicitly fall back on checking out and
-	tracking e.g. 'origin/<something>'. This stops working as soon
-	as you have more than one remote with a '<something>'
+	tracking e.g. `origin/<something>`. This stops working as soon
+	as you have more than one remote with a `<something>`
 	reference. This setting allows for setting the name of a
 	preferred remote that should always win when it comes to
 	disambiguation. The typical use-case is to set this to
 	`origin`.
 +
 Currently this is used by linkgit:git-switch[1] and
-linkgit:git-checkout[1] when 'git checkout <something>'
-or 'git switch <something>'
-will checkout the '<something>' branch on another remote,
-and by linkgit:git-worktree[1] when 'git worktree add' refers to a
+linkgit:git-checkout[1] when `git checkout <something>`
+or `git switch <something>`
+will checkout the `<something>` branch on another remote,
+and by linkgit:git-worktree[1] when `git worktree add` refers to a
 remote branch. This setting might be used for other checkout-like
 commands or functionality in the future.
-- 
2.28.0.942.g77c4c6094c

