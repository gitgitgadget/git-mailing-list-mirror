Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1210EC76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjDAPLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjDAPK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:10:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDA92443A
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso5540637wmo.0
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361853;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+RNOdWpR6+cEk5NvCVSKp2RUkJRzT1mejUgzzk7/x0=;
        b=UQ/TQ/JV3XQjn2p2ZP220rH53uAL0eouvNoK2SNgAoPxLi4WUcVEF49lMSarUU/h6Q
         BXy8vcR3mCsZj5gz3O5/bBaPvSvxh6ruvhJeWQ2JGITIBeFUrZBtx4qaECyIO3pPpH/4
         jNHQW0Rx0UhrV7zg6aV3dw1xADt/Ohj3GpNzqb7ZIcSz0D48ya1EZtrpgfVxs1HhunPM
         c9YCW840g6lcXOC22bCwdgAGkpEZammS7WXdwcSYozkS8R0p76xCJegUC1VRIVVMotN8
         q04KJLZhGw8uFTwqL4p2PyTUQUhkFGvttHXHC6Re6lLyBOnLruyDkMh67EosAEHeqItL
         GT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361853;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+RNOdWpR6+cEk5NvCVSKp2RUkJRzT1mejUgzzk7/x0=;
        b=h68G2J1KB+L5rMTUMiuGmPu9NkJRVumXeKoVGdMHqkns02j/+UOE/uz7Mp8Mf7m2jN
         wCyD6+htDtEDvH/rP1HRegK0YnlT0d4a7PjawHSAfk3jfg4wxKr8t/Bch4YeNgeExUSx
         jBDZxpEGn1bev0aTrvm1Ax/VTC9rfIuCU+ly0QXF2bjrmgC5GfQhXXQmm8OgmkrPjLyb
         yMo4WuUxnV5M4HzW5B8aDJAYhPF5PDjaPUkcwzrheEed53AdJZOMYAYCdX5FdTzAEoJA
         4hYpTGaI1xlF+SQjsrhE355SmOaMJJOv8qOFaJfPWTV+wvAn+sMDPOKBKvbW60fcel7m
         Jveg==
X-Gm-Message-State: AAQBX9ev19LTWRgUvxOzMDkU8Puh8NzPNotxvqUvGLcG/hsxO9V8iRAZ
        h1YuhP84iXkjBvpygiM34CVj4aDB8Uk=
X-Google-Smtp-Source: AKy350ZBo7owjSat7UWDpBwZa4wtaBdtcs1g87ZZTgJD6wyg6xUw4iHlUN8jgp5qZ3AvEzN9vm5EeA==
X-Received: by 2002:a05:600c:3791:b0:3f0:3d41:bda2 with SMTP id o17-20020a05600c379100b003f03d41bda2mr5712893wmr.39.1680361853801;
        Sat, 01 Apr 2023 08:10:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c740b000000b003eb596cbc54sm6436507wmc.0.2023.04.01.08.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:53 -0700 (PDT)
Message-Id: <c8f7559553f81bc2cd869e827d41de738ceccbae.1680361840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:32 +0000
Subject: [PATCH 19/24] cache.h: remove unnecessary includes
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

cache.h did not need any of these headers, and nothing that depended
upon cache.h needed them either.  Simply expunge these includes.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/cache.h b/cache.h
index b136b0c51ef..3c3e40b52e8 100644
--- a/cache.h
+++ b/cache.h
@@ -5,14 +5,10 @@
 #include "strbuf.h"
 #include "git-zlib.h"
 #include "hashmap.h"
-#include "list.h"
 #include "gettext.h"
 #include "string-list.h"
-#include "hash.h"
-#include "path.h"
 #include "pathspec.h"
 #include "object.h"
-#include "repository.h"
 #include "statinfo.h"
 
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
-- 
gitgitgadget

