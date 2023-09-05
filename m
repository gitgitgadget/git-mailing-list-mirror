Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B910CA0FFD
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 15:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjIEP75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 11:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354518AbjIEMMw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 08:12:52 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D5412A
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 05:12:26 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68a529e1974so1401405b3a.3
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 05:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693915945; x=1694520745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o4REez0xpcO8Qotr3H2O8AOOCsAvKLWOyezsej6pW0M=;
        b=i4a+Vl4eWyYqNWA93yCm7bPZEvjEQc/1Re3s9J4ygQ7hAN4aHRnkogCovOnaA0a81A
         mTId9hlnJ+73pHgJitvJqo3yRYO9rJTstTIPEd89dK1DR2ITkSCGX/Nw9aXXXfQMJvB4
         U4bB7mdbGDGWLXW9gYPSZAeRz0GdRqlvMIiUBuoBwi97/8+2Wr1uNZMeEsUqo2YmIuxo
         1Xg3s7nd6zB1LGR/gytTYm7ArTslOP6Ebv8KJYmpf7LjohG1dFEITKuhLChrr1zA48LM
         uySgeSm03wqUWfp5ChK6fa5pTvhKbQx9jBk6OWWgHyxPG5f9hMJVV78TkM9Aw/CYSVTD
         aMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693915945; x=1694520745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4REez0xpcO8Qotr3H2O8AOOCsAvKLWOyezsej6pW0M=;
        b=WZOJ+WAwVOOTav/SuvtI2t74x4l4gqJsaDMVul0BB07YLXYseWwnpLsUd1PquaZxGm
         2cw2Bzl5NLYlvM4tDNVam+lY0GA8eblRpkXqQtYSAozXcD2xOGLmKIvvDRkiS2Zmy6lW
         a4Lf3E6NP1AP2eWXOllth6PsG03hsWnY5gg14YsPiibfYcrZ0cuq3HA1v17uyaMrH6Sc
         ZchrYMEQq2mrKHtV0nZL+G36Fd2csL2CgsYHuNvyHhf20HlP3zASh1Fzn+fV3FLZ5Q7n
         Pm9SjXAD7FM6GyFfLAgPt1083X/EqMXRs+WvVa3a/C/CDqidR7/PapxN0L5NTSQqBl4n
         g/Xw==
X-Gm-Message-State: AOJu0YxPZnZkx7p1HMit+ZzwxzVW1HCXSTnBqT4RAeXMhzpWzgQrAdF+
        Kd/aNUQ1J2xgjTr2+NbaAf3oZ32fj098N/yBZM0=
X-Google-Smtp-Source: AGHT+IGsQAmduNHRFnZdAZanZ6tvKo7Taj1jyh+DT0qODuVBcPc8dSCPJlkRJc7Uei1Kvx9toU9inA==
X-Received: by 2002:a05:6a21:4841:b0:148:1826:f834 with SMTP id au1-20020a056a21484100b001481826f834mr10306014pzc.54.1693915945182;
        Tue, 05 Sep 2023 05:12:25 -0700 (PDT)
Received: from C02FT0QBMD6V.usts.net ([2408:8000:b001:1:1f:58ff:f102:103])
        by smtp.gmail.com with ESMTPSA id jl4-20020a170903134400b001b9de4fb749sm9246422plb.20.2023.09.05.05.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 05:12:24 -0700 (PDT)
From:   Han Young <hanyang.tony@bytedance.com>
To:     git@vger.kernel.org
Cc:     Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH] show doc: redirect user to git log manual instead of git diff-tree
Date:   Tue,  5 Sep 2023 20:12:19 +0800
Message-Id: <20230905121219.69762-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While git show accepts options that apply to the git diff-tree command,
some options do not make sense in the context of git show.
The options of git show are handled using the machinery of git log.
The git log manual page is a better place to look into than git diff-tree
for options that are not in the git show manual page.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
---
 Documentation/git-show.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 2b1bc7288d..13f63f5210 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -26,7 +26,7 @@ with --name-only).
 
 For plain blobs, it shows the plain contents.
 
-The command takes options applicable to the 'git diff-tree' command to
+The command takes options applicable to the 'git log' command to
 control how the changes the commit introduces are shown.
 
 This manual page describes only the most frequently used options.
-- 
2.40.0

