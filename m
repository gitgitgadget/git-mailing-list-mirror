Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E7BC761AF
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjDAPLb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjDAPK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:10:58 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241641D2C6
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:54 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso17162288wmb.0
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361852;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+g/Sly1PVYaV4QH/BxmGyrWtJFgO4Ex0geMsimjD2FA=;
        b=jYcL3TnMKazTlJqdW5knEf2GqNfEamTM1AJxuQR68QaY7dDw+hNgnOEKOOy0hx5CKI
         xQMnbRiFGJ2zmUBG5m2EKyg8EkMI66PFLMcMLzGdyiukr4SEQVeQGELE7TTaobPh++Yk
         fQl1NQvS3M6pi3ZlasMYVyZ01YCiN+C/bCQsI6hn4Q8oLZgCI37uZjMMwt029uxH6ciz
         Tq+sPv7dlhQKlCQKFyLLx+9PZJvfO+0NmwdZkw3XVlLzQcJT/F07Kb2kjkyZd/xngAB6
         rtIDZ7sXYcc5MJ19qhds9XHtniOjGC51Juy+FHfa3Q+6KP2o61n2idK78Ys5qaPGrqNd
         J6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361852;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+g/Sly1PVYaV4QH/BxmGyrWtJFgO4Ex0geMsimjD2FA=;
        b=m2hK4KZuR9nDtD042dm9nck/j2ZI0UR2EGowro0BNlqqKl0ij/JcoVyC3eypqOKmWF
         KOQkbpN47Xd1kIwO+tx7x/M48ad4VswntxdK4gutRomFGjf2legSa2q4q86FkKmvSA6D
         asAq0Sprk+3aHR3JMFxdbPBGgs57auc4UMAEHtcib95agL1rcu1pgnNKrDLMpc2NS0Q7
         N6Y+bpFUhNFqomP513q1VFAZfhYcRlTnKKqilVq4xXT9bqGZvyk4qqg9cgXT2dagtova
         gizcMR8Si+ZHf5dp8dtht2yM2NtrOVXugSE934s/oJrMzLXxwELIVhEgIrLyvQNzif5y
         XPIA==
X-Gm-Message-State: AAQBX9fGMVPL/64ef2msLvgVrXTwg1DBBzfJJRflNMjLDjRSZk0JEv3c
        S7Q9FWqsWG4hVazRbi70BX5q2QtG7oM=
X-Google-Smtp-Source: AKy350aTFwW5O+rw88AuZTFSwt9/C+c9JR2MCpylaZ6xU+NZL6osbHe9tw00if842emr9uG6ekwapA==
X-Received: by 2002:a7b:cd18:0:b0:3ef:6aa1:9284 with SMTP id f24-20020a7bcd18000000b003ef6aa19284mr17019222wmj.29.1680361851934;
        Sat, 01 Apr 2023 08:10:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05600c524b00b003ebff290a52sm13533843wmb.28.2023.04.01.08.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:51 -0700 (PDT)
Message-Id: <4b41942a24ee6845eb4f3055619c5cdb3667bd13.1680361840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:29 +0000
Subject: [PATCH 16/24] treewide: remove cache.h inclusion due to editor.h
 changes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This actually only affects sideband.c, but helps towards removing
cache.h inclusion in conjunction with some of the upcoming patches
that will be applied.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 sideband.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sideband.c b/sideband.c
index 25e2a185716..6cbfd391c47 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "color.h"
 #include "config.h"
 #include "editor.h"
-- 
gitgitgadget

