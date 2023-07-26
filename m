Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D35EC001DF
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 03:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjGZDFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 23:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjGZDFL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 23:05:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786431BD1
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 20:05:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3177163aa97so780088f8f.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 20:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690340704; x=1690945504;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUOGi/S8harMIkeMlwlGX4B7j1x/qNSxJP2y5l0vrds=;
        b=XnIgbLR+S22jjMncSse4OjVwy7sXvX/HprrKCbN78UjQl+FRb7IsUZ12NcuWY0+yzT
         88jG2Is40vdiftxXfi9VZIoPpOTBXnWt6CybLSOvvVpiuqtoR4XpCPe+EAgItvjdwkKX
         dfAOofnE5B7pAvsX2YWprsOZ/1vJLNCpy3R9VhVx5bHQ3i2XvcqtsCt6bJvC45VQ4Q+U
         y+CKB6ogrkp6V1DP6utpcSLwe+Ok7jcSGwPtiXM6RCFMn7GSDa2ERxMF/rErcKcb6ySU
         mFJgODxJQ7e8pKqdAio3eMKxaMX6N4QWZbXw1wkHP91QoW3sSWTkVY0UXvK0zknkTu2H
         2yPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690340704; x=1690945504;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUOGi/S8harMIkeMlwlGX4B7j1x/qNSxJP2y5l0vrds=;
        b=VjBzlIJ9b9eNAzUfc0P+shSvW5EBW/ffb4Wgd5m7ipE7uISM6BjEQhE+g+R016bBmu
         MJ6YbsS22eqX46FhttxsQjaIDMlxO9JZJQgGpg39Vi/U77Gm2JDFCFeftL5odtg9Ce+2
         tM86jkm/SQJLSvbM1n7irlQA6l73z2T02zeBsHdchQs5VP3T6MIRRyR7hi4puAKMXfU5
         pv6i5o46jdRUL1Szf7YWAKwkTQn4PQy+BoNsRYJOeAsdRYquuguHWNUCToShHm+Jp/X0
         6aicT+OZdF5JoVQXaNN2LNCdCIkPUaPffGV38gseUH2mlg6g714+UU7Ojs5dEgzyf5Re
         tumQ==
X-Gm-Message-State: ABy/qLZvFT5dCf/4GM1+CTPDO3x8Lp9wL4rH/POQnQ0iH/eVur+/BweB
        jgHghagw0A3LFXIqWEidaaCnggX7kYk=
X-Google-Smtp-Source: APBJJlGuiGLYVjcgzfR2xBdUKTGrI1gFKlEaGBZvzy7m1ShgUU4vNyWmzq+ZWg81kiZUkr8+KmgXnw==
X-Received: by 2002:adf:dec2:0:b0:314:2f5b:2ce with SMTP id i2-20020adfdec2000000b003142f5b02cemr461648wrn.12.1690340703564;
        Tue, 25 Jul 2023 20:05:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600011c700b00313fd294d6csm18204693wrx.7.2023.07.25.20.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 20:05:03 -0700 (PDT)
Message-ID: <08deed14d960b0b7de56a023a1da6ab5280e04bb.1690340701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com>
References: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
        <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jul 2023 03:04:57 +0000
Subject: [PATCH v3 1/5] SubmittingPatches: reword awkward phrasing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index b218e273570..b89678cedc3 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -3,8 +3,8 @@ Submitting Patches
 
 == Guidelines
 
-Here are some guidelines for people who want to contribute their code to this
-software. There is also a link:MyFirstContribution.html[step-by-step tutorial]
+Here are some guidelines for contributing back to this
+project. There is also a link:MyFirstContribution.html[step-by-step tutorial]
 available which covers many of these same guidelines.
 
 [[base-branch]]
-- 
gitgitgadget

