Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096BDC433DF
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 08:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2282222F
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 08:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMc2m64q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388997AbgJTId7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 04:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388893AbgJTId7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 04:33:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB50AC061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 01:33:57 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j7so1044721wrt.9
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 01:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=srQoS7obU/JW72CUDke1k3jm6D034+YmwD76ywTkNIU=;
        b=GMc2m64qESL4o9jc+Fu1cZAfN6JymcYVpuXdjpVGXxYd11iWZcnsLtClIiBtSnajIC
         R7xDrkbfzjrKawVqAkkBkxpumnAn6F5tT6lekpfwnqvOEKUIPjeOvXSuCl8d6e52+iRW
         Kqcc6DKpfoeMgb6RhmB2kD6K3CfA6zbZL96rKPWFtMKsZERSHzmd71eyuvt/XH6J4e63
         upmU2YuXWos6wrfiGAvgaq1doNUu4tfblztF7FBgT+qPV9erWSbPyOcO+VNVDdvBmmaE
         EomALZkaCseL4ZDqVDvJHY/KoLpJX8x6lSGHU2vnhKcWU6xE3ZsuqBhQ/E+WJLuENdrT
         +URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=srQoS7obU/JW72CUDke1k3jm6D034+YmwD76ywTkNIU=;
        b=sr29Dth48qAs3fokIfdC6r36NYA0P3kjWS1D29Ax8II2mph3pmQgw0inw0CiY3NMl4
         v8BaLo43ZFZ3HaRUeiiz7xzQ4DN07osAHtA0AjOK6SroTXgZR8omRh/4X8OMnNlD0I+b
         nU1ZFQ8oldRguUXO4aKmwLzrHg4+R8KCqDv+n1WTO+aHQOmR3N119BEt0Krdw7/IG3Ho
         dEPG1SKKXP3PNVfb2wan+YNzME7D1+RLSUm5dqUADhHZC8TaBbk5JEvrkMCIdOeA7AyU
         wzXvjdGCYInbrXjK29/o44TzFRY3yyhD6U1jeuO/Dj1/+E1AoqEr9nE5QrVfwsw/DBt0
         9Lug==
X-Gm-Message-State: AOAM533EDmqVfE62zZJ1L0d2WDHo32masb5aa+k44uPCLE4dKiCAhnfR
        fLIT1xwpcz/ScFjwvpWOOh4N665vlS0KCw==
X-Google-Smtp-Source: ABdhPJw/egjq0yMyZ3V+goYezSNhexQmos2UJVAT205IX5DkYifi/NpUmqT7rnK3DMOZWcAmEf3UUg==
X-Received: by 2002:adf:8b92:: with SMTP id o18mr2235060wra.54.1603182836305;
        Tue, 20 Oct 2020 01:33:56 -0700 (PDT)
Received: from ubuntu-N150ZU.home (2a01cb0505981f00bdf052a26d87e71e.ipv6.abo.wanadoo.fr. [2a01:cb05:598:1f00:bdf0:52a2:6d87:e71e])
        by smtp.gmail.com with ESMTPSA id d129sm543539wmd.5.2020.10.20.01.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 01:33:55 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] filter-branch doc: fix filter-repo typo
Date:   Tue, 20 Oct 2020 10:33:43 +0200
Message-Id: <20201020083343.24945-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.29.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The name of the tool is 'git-filter-repo' not
'git-repo-filter'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-filter-branch.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 40ba4aa3e6..62e482a95e 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -532,7 +532,7 @@ The https://github.com/newren/git-filter-repo/[git filter-repo] tool is
 an alternative to git-filter-branch which does not suffer from these
 performance problems or the safety problems (mentioned below). For those
 with existing tooling which relies upon git-filter-branch, 'git
-repo-filter' also provides
+filter-repo' also provides
 https://github.com/newren/git-filter-repo/blob/master/contrib/filter-repo-demos/filter-lamely[filter-lamely],
 a drop-in git-filter-branch replacement (with a few caveats).  While
 filter-lamely suffers from all the same safety issues as
-- 
2.29.0.rc1

