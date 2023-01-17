Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6C5C38159
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 22:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjAQWlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 17:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjAQWk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 17:40:58 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484AB59564
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 13:54:11 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j17so4827067wms.0
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 13:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fu8rPrfv+pdmpASLR+JXdeBAVPXprVgYAQaZv1mhavs=;
        b=PHpKaQGHpBMMlHWw3H8fcjJspD4uY627V3zJlB8BqmnuwOdSV90x0oAcH7HaZijroC
         g+OPXdnzoH/BXc7hqZJxNh0XtVj4AKpovFjDyoLWd87uA8QPbWliUfdtMkgNKNXn2z3w
         Gm8aUVcvtdGIjC5F6i4J39wHUbMwOmn1BXZAm6BK70Ye2GM0UqFl4MERVXCxx7XBI4Xc
         zZAPDve+LBMPBjPId/+dEouxGxQhDLk5sl0O5cwoX/m8Xh2qi58pASZDe3AzfrwrPnvf
         OlKopIc5Ue8v7zKL+b3txF6wHDu0uvgtP/Y3A7SY2dkdiS22ortcCKrWHyKu1kWyVLWs
         R0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fu8rPrfv+pdmpASLR+JXdeBAVPXprVgYAQaZv1mhavs=;
        b=D0QDm3mBe3rgDKThxcxHKT4/nstPgVgkczfJkyz6n5cEqj8RFCYT2OcR3CeAeoTFNp
         4FMxeHBpZZBfViCJdRDiiDC4F6VFrvt4kavgyGdkhAACFASzZv9+N/EQx1dJAjq5y+dK
         Mcc4+X4ULtumvL8EckkiXc/Lce0wSZWc+Dqw8yE/YiB5sU9AUWq1O6Vwvt0rmMRC3eP+
         fvwatgTTindO4lW8DapLtBHN5e6UWhDbUT9DktJZLbGX7uzJ1XTYVjDmQcnEzheraUFw
         YQEUOtX5UrA9lDX5iAZvYEDPx2F3ZpPxDoV+EnEMBGfwZEactkPdYTh4XlaUDayTsoUy
         4mKA==
X-Gm-Message-State: AFqh2kq/Dwfi145aaf8lw77tY5vmaIpHGJyCW2gDO6fl8RtnVnXQDJ4v
        C47HLQdvwlzJuE3Ryuc9XZWLLBUvKwY=
X-Google-Smtp-Source: AMrXdXv8DuGKubYDDG5oJrflESNtiun5UrjYdzblmOJvmM0EqoAHbxtGFR/5i3pXCSCPBW29ENAMGw==
X-Received: by 2002:a05:600c:4e94:b0:3db:bc5:b2ae with SMTP id f20-20020a05600c4e9400b003db0bc5b2aemr2729217wmq.41.1673992449603;
        Tue, 17 Jan 2023 13:54:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2-20020a05600c220200b003d9a86a13bfsm51050wml.28.2023.01.17.13.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 13:54:09 -0800 (PST)
Message-Id: <pull.1437.v2.git.git.1673992448371.gitgitgadget@gmail.com>
In-Reply-To: <pull.1437.git.git.1673990756466.gitgitgadget@gmail.com>
References: <pull.1437.git.git.1673990756466.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Jan 2023 21:54:08 +0000
Subject: [PATCH v2] fsm-listen-darwin: combine bit operations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    fsm-listen-darwin: combine bit operations
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1437%2FAtariDreams%2Fdarwin-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1437/AtariDreams/darwin-v2
Pull-Request: https://github.com/git/git/pull/1437

Range-diff vs v1:

 1:  a98654c7507 ! 1:  9943d52654f fsm-listen-daarwin: combine bit operations
     @@ Metadata
      Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
     -    fsm-listen-daarwin: combine bit operations
     +    fsm-listen-darwin: combine bit operations
      
          Signed-off-by: Seija Kijin <doremylover123@gmail.com>
      


 compat/fsmonitor/fsm-listen-darwin.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 97a55a6f0a4..fccdd21d858 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -129,9 +129,9 @@ static int ef_is_root_renamed(const FSEventStreamEventFlags ef)
 
 static int ef_is_dropped(const FSEventStreamEventFlags ef)
 {
-	return (ef & kFSEventStreamEventFlagMustScanSubDirs ||
-		ef & kFSEventStreamEventFlagKernelDropped ||
-		ef & kFSEventStreamEventFlagUserDropped);
+	return (ef & (kFSEventStreamEventFlagMustScanSubDirs |
+		      kFSEventStreamEventFlagKernelDropped |
+		      kFSEventStreamEventFlagUserDropped));
 }
 
 /*

base-commit: a7caae2729742fc80147bca1c02ae848cb55921a
-- 
gitgitgadget
