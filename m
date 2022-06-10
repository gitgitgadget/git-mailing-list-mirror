Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58792C433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 10:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344629AbiFJK50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 06:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348781AbiFJK5D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 06:57:03 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B5327936B
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 03:54:46 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v14so9747179wra.5
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 03:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E6bKO0VsQQCQlvKxYxRlprN8bVF9guaXMMN/6yBgq20=;
        b=da4VSliphGRTCrRB4nhb4f9wqi6CPOvCZ7kXMB6o7jXTGW9vY8WZO3Ay/dfDSumqKo
         fZoRPk+8OM/4EEIOLpT7Xvp3A3mUEaDrg5C/D4CY7tfBegtTyVwS2v9be25wSt2MUAbL
         kDpLMwxjz1KVx6J4xzIIRyspavb3kcWkILz+90x21PLzAeDiNtamjPV597GKFroNCen3
         +ReE3X4tsl4BrHa4zWGXKpntEY6Z7hcE3b87ygRkxSPn/BEWdQ+/2UtXG8xlK2PVpojN
         mNOWdlyiMzbOnsZgmoLGd03e7Xew5R+TCWHfcNWKTRX0CHD0vInXk6/NfXzWl6v0hqaN
         Y57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E6bKO0VsQQCQlvKxYxRlprN8bVF9guaXMMN/6yBgq20=;
        b=PvkAOjXznoUBJq+7EHpU4w0+uC9xVB57D2i2AONoAUomgCXDt9K8dh/md6PiNCqNIL
         xFb5XfmSHI0BqcEJD52xfgb6eHlWchV/JRiFtn9HZfYif+EIlOqHGOi16DCabi4/wYRg
         qXKTXhK8nGp+ycZxDpHDPsbmykVkI676R2AEBRKHGQLOzwC1yW8S8TWfpXmnWrBG0APK
         Kpv6KLAtPLdQrvqcTRK+yvR/0R/AjM5cnyLjcNSQpUvd9bVebugwPS1sC7eL5z2eCMpw
         YY7lMTvePYgxh66vOsUh3/o6rGHHr18vUd4uoDVZUMppFdGjmBZJ2Y408CKxc1ij3747
         hNmQ==
X-Gm-Message-State: AOAM532XPvpM/6D5xpxlWe5ckiGW05Ck/Vy/d5SS7JufeUd9R513D1BC
        StNhg4z2dJQrF8byxRqZFP8k6X7vPObjug==
X-Google-Smtp-Source: ABdhPJwVSHfBn0kEn2yyxMhyTkfJvdtlfBcJj7XesnonwWcx928PWsUJUv5HfsWP6kGHYuiSowEg3w==
X-Received: by 2002:adf:fb82:0:b0:219:af0c:489a with SMTP id a2-20020adffb82000000b00219af0c489amr9887020wrr.212.1654858484364;
        Fri, 10 Jun 2022 03:54:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h62-20020a1c2141000000b0039c151298b7sm2712976wmh.10.2022.06.10.03.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 03:54:43 -0700 (PDT)
Message-Id: <a1b9bd9af90df88b7ce14de60a9626d2a1f2d3e8.1654858481.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1246.v3.git.1654858481.gitgitgadget@gmail.com>
References: <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
        <pull.1246.v3.git.1654858481.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Jun 2022 10:54:39 +0000
Subject: [PATCH v3 1/3] bitmap-format.txt: feed the file to asciidoc to
 generate html
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Documentation/Makefile does not include bitmap-format.txt to generate
a html page using asciidoc.

Teach Documentation/Makefile to also generate a html page for
Documentation/technical/bitmap-format.txt file.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Documentation/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d3f043f50d2..8d405a14330 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -94,6 +94,7 @@ TECH_DOCS += MyFirstContribution
 TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
 TECH_DOCS += ToolsForGit
+TECH_DOCS += technical/bitmap-format
 TECH_DOCS += technical/bundle-format
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
-- 
gitgitgadget

