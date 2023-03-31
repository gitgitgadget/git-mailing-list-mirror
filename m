Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A131C6FD18
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 10:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjCaKQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 06:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjCaKP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 06:15:56 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9D520612
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 03:11:46 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so13516849wms.1
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 03:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680257504;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=okSfJuwpTy0GGYM2wO3rhJNOEha/gK0oRKa61tk//+E=;
        b=PD/kbsmk0c9AEHGXzQz0GknR3hvsk59Xx+dus3WpnyNX0X2lxG26NG8WtK1EvE9ZL3
         6FivUwZK45oKvqGVdpt0tga4oQNWnm5wjt27i/i5ASaqf1l+ILCNqGEw4S8d9YgctFs+
         VzPUt+YWELMOLA75s0hTuswkhJBhu6KjUu2C7LTwGkGWNF+ThNP8IRCeYl0q0+8a1yC1
         rSRV6MoCeOJqFavpHZjxhQFd3l05WAWW462U4+1vEY3qWi/Mq9xHARWKGhe+xqekS4ph
         16qN+2aAl/t21Qyec4SxZfXuZ1xHVSpux095leAbu95FfG4aJiHLDPRCOM0mqk65LiN6
         gIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680257504;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okSfJuwpTy0GGYM2wO3rhJNOEha/gK0oRKa61tk//+E=;
        b=kfgHatIy2lTDFyRgptuIBgbAAhseysBOmfT3iL+6W6EnrSNhamPlltqF7s3V94GC+k
         G4gjLzZTiBanFpLdgrpJlgBa9udNVwnj1ca7RFOH7bXdf7nZ3vivnvDFX7LZUllLPP0h
         wItubNnn7+nHt4cCD1V5KSNRo7YazihMKymf/uc+qPYb4DbwVGneNCgBBXP+DQELksHF
         HoIK/eXL9P9+BgE919bON7vlAcXmaNXmWu3lz0BSxhCCNFbrmQyLqeRj5Mm9yKBCmS/X
         EDAT3KXu+EsVoijxUWHTLNoVvkio0SwWLdagR3XlZt0BoH+j+RdBlbfVRmC/s1p1mEHw
         fNvg==
X-Gm-Message-State: AO0yUKUJFldJ/+zTgtZ+ozRGQ0SmXyikfX7Jtqn5PqbNDmLhMaS3j6B1
        1nDCIZtKdYyGdVI17oOZCKaLCM1eTI8=
X-Google-Smtp-Source: AK7set+8bXKgSV4ho/szXP3eUoaRWE/zeJf5XCen6a5BHDgZY+unvDapnaVVJXKBSffp46QmXlJlyA==
X-Received: by 2002:a7b:c5d4:0:b0:3ed:8079:27d7 with SMTP id n20-20020a7bc5d4000000b003ed807927d7mr19353326wmk.40.1680257504363;
        Fri, 31 Mar 2023 03:11:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q11-20020a5d574b000000b002c54c92e125sm1796244wrw.46.2023.03.31.03.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 03:11:44 -0700 (PDT)
Message-Id: <pull.1484.git.git.1680257503697.gitgitgadget@gmail.com>
From:   "ryicoh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Mar 2023 10:11:43 +0000
Subject: [PATCH] doc: add that '-' is the same as '@{-1}'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ryicoh <ryicoh@gmail.com>, ryicoh <ryicoh@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ryicoh <ryicoh@gmail.com>

Signed-off-by: ryicoh <ryicoh@gmail.com>
---
    doc: add that '-' is the same as '@{-1}'
    
    Now, the document of '-' is written only git-switch.txt.
    
    https://github.com/git/git/blob/6369acd968d02899973a9a853c48029b92cea401/Documentation/git-switch.txt#L51
    
    I want same one in revisions.txt.
    
    Thank you.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1484%2Fryicoh%2Fdoc-hyphen-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1484/ryicoh/doc-hyphen-v1
Pull-Request: https://github.com/git/git/pull/1484

 Documentation/revisions.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 9aa58052bc7..9e7ea2cf71e 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -94,7 +94,8 @@ some output processing may assume ref names in UTF-8.
 
 '@{-<n>}', e.g. '@{-1}'::
   The construct '@{-<n>}' means the <n>th branch/commit checked out
-  before the current one.
+  before the current one. You may also specify - which is synonymous
+  to @{-1}.
 
 '[<branchname>]@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
   A branch B may be set up to build on top of a branch X (configured with

base-commit: 6369acd968d02899973a9a853c48029b92cea401
-- 
gitgitgadget
