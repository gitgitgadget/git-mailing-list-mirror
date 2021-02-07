Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413ACC433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03CC864D9E
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 18:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBGSUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 13:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhBGSUP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 13:20:15 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA2CC06178C
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 10:19:32 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u11so6598791plg.13
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 10:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cPF7JN9EXFHoXUAgjyQ8SEXELSTyAI2x2DbPyESxQcM=;
        b=RR5mxdpG0W5W3laov3WNVOYKNMAu7cPLwHMA8J8rtnJH4lGcrH33H8MYgA85Onb6DQ
         Jnu5JH5nKKJ4ttlVHru4KRKs6ExDhTB6qQcpePb0fNmKMzUV9Tbh4gZOolSzWHYzrI/C
         pORmzjG4Wdjjl2ZfPZri+rrJhx3DF3jDnD7i+oWV67AMaZdWBem2LIErEhqFmFOApfWE
         g23jHdiRRJnzPS4yx885TU2qRJYaM1lWK0bjlBfqjnu2imhGB33O1WaiX2pBLV6pKO0l
         a3uIeZDiCVyGgnO9vBYetKyewJOPagT0yOWTI9iKhA6DmFQS0BS0y8zjQcQtLRLiT6ob
         fKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cPF7JN9EXFHoXUAgjyQ8SEXELSTyAI2x2DbPyESxQcM=;
        b=hzAywYzSDHKR8WFq7LTNe32NZVpDh+Bx6YQ6G1D9jNavU4yOgFTGGGhEN4pzAuJyme
         9JyFxB00gKNzbn9tW5j+9DTq977XuVlTVZarfgItb3cvzv592J8nd0aNw9bVKTm5uUwr
         nNVWk6vGH/KNHsDGQ9/KsgHlMDk4fvzD8FBqFksIUo33Vde69pkymfMf1ER6/lZGQo3C
         Naj7QjszfqeYfvKavTMN+Itk8bR+d7+H9+qpgjW6a8jbt3GW1zg32CCpfnlg4xNax3rO
         +qpnoVBe7hRPWIUNoJK8GfLOwsSc1JXSo/OsEOOt5AWXn0Bj8aRJG2oclyXBGP7SxGWV
         bwCg==
X-Gm-Message-State: AOAM533z7rV025XVuipY0DI1tsMLf2kb4X/KzsL/nupsfH1rInEEJxQS
        aMpoO39kAbIx1VDvpUasDa1+4LWgxq71Yg==
X-Google-Smtp-Source: ABdhPJwCETCUEKgFwUDpgtmysGpT2Trk53alR+kxVc80F0iP6B5xvmKTboZC/Oz2xJ/gg7qv3Vp0sQ==
X-Received: by 2002:a17:90a:d3d5:: with SMTP id d21mr13012308pjw.228.1612721972400;
        Sun, 07 Feb 2021 10:19:32 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2e07:af0b:4438:7fbe:1d1f:8bc])
        by smtp.googlemail.com with ESMTPSA id n7sm16375194pfn.141.2021.02.07.10.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 10:19:32 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 7/7] doc/rebase -i: fix typo in the documentation of 'fixup' command
Date:   Sun,  7 Feb 2021 23:44:40 +0530
Message-Id: <20210207181439.1178-8-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 Documentation/git-rebase.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index a6903419c4..8bfa5a9272 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -894,7 +894,7 @@ is used.  In that case the suggested commit message is only the message
 of the "fixup -c" commit, and an editor is opened allowing you to edit
 the message.  The contents (patch) of the "fixup -c" commit are still
 incorporated into the folded commit. If there is more than one "fixup -c"
-commit, the message from the last last one is used.  You can also use
+commit, the message from the final one is used.  You can also use
 "fixup -C" to get the same behavior as "fixup -c" except without opening
 an editor.
 
-- 
2.29.0.rc1

