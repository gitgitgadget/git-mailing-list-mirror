Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE24DC761AF
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjDDBXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjDDBXB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:23:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F1F2701
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:46 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j24so31188262wrd.0
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571366;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+g/Sly1PVYaV4QH/BxmGyrWtJFgO4Ex0geMsimjD2FA=;
        b=I87D5V+xkT2lYaHGITQMJ7bZzyHENJXC53kRblL6aIepLrn/l7xLdU68WWsXkMFzdJ
         SBsYx6zzIIElZvsgxeqyQmK20up1QQhLDZ0+xUN4lI8qr8El0nD8UhTmLtCtEASYPfrV
         v48N440E9x+cSDfrLAR2gWpqZ3bhA250Yc5vpzPCM+sSfyVS5yIM49zuejxMBNNCwLZj
         r6Eps4/DM8hN27dODAnhUqHzCNphCTDgN3rr0zlx1MBtJ8H6TR6O/wBCIOSCgkMHC6+j
         IxCR+hatED6Q1EO76D/iwTyeUgCm0QCMXP+EvIcB6UEVZ0vjeCDGqY9egQhiRlWInfiy
         Id+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571366;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+g/Sly1PVYaV4QH/BxmGyrWtJFgO4Ex0geMsimjD2FA=;
        b=mMUITkYREJv0yokPxGSp1SvixaxpBbkmg5Yny1cO5El4AwCYV2YBi63mmV7V1R03/m
         zHQzfgIlObcdmPq8MV8PYMd9e8q5mnrIVZeYogvcaC+1iJaMS+DqlUoa5U3KoxUykRxa
         Yv1wl8ur94CUrWc4Fy5RKzWWbTMFc351ln6e0dIHCQl+nM68BFfX63T4RpimxKT+cCwG
         YWleNwWgSShv3Z5diQhqoJ5xGFuiJ/t5yBDb6Vke2fK6UDEZh0XCOXy98rMAFxa6IGkm
         /Kuq9oSYTlhdWEE2EOFQ5XTsRTorn6H3ZsuNjZzZeGF0Kr15+Ft9ziaC8egAyG6NB+Tk
         hWaw==
X-Gm-Message-State: AAQBX9eVSHiA6LXPzle3el+Jr3WusI9nFEtb/s/g4gjjEKun9zSnF0/9
        S9Mk2rTtBUN/9il/rSElwV8E1o8apW8=
X-Google-Smtp-Source: AKy350bvr2bk1NQL0SIMDlb7rozoi1KE/w5dqOLpLFO9ui3ZuhaeZZYD7paPnTWQmGFbvcXGekNoEQ==
X-Received: by 2002:a5d:5703:0:b0:2cf:e023:5915 with SMTP id a3-20020a5d5703000000b002cfe0235915mr228304wrv.61.1680571366100;
        Mon, 03 Apr 2023 18:22:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16-20020adffcd0000000b002d5a8d8442asm10890666wrs.37.2023.04.03.18.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:45 -0700 (PDT)
Message-Id: <9550d976141c3c77e10e6f31f2453003c539f9c9.1680571352.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
        <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:21 +0000
Subject: [PATCH v2 17/24] treewide: remove cache.h inclusion due to editor.h
 changes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
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

