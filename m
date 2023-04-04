Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F93C76188
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjDDBXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjDDBXC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:23:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813CC30C8
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:48 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so15566372wmq.3
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571368;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+OVZHfXVuJWHaPuWG/8+nuax0OVUjrTdUBXAYrL9vA=;
        b=lLw7CXmAygV9jN7W7qll1ygQ0AswnwEVmc6KW1e/mY2ru24uyq262u3wAmiheDQ4VL
         CU4rGcpIUWnAeR2J/slSfgxTGB6AIs4hThOV0unn7+kvAUw/CAtxD7yekkF/6QZGDTJZ
         HJSB1++MnN1wstb1PTLtd63EotCMpHWajxtcQx2oZUfC6Z9sacodhSoKla3CQU3avO0o
         NWM5K/prVPQGAhjZhCxvtZwDK1L09tu5VOAgcI6Wkfr5wyGNhv8GnqZZ6f2VWPTNTlYK
         9UsKjq5PJCxhXt8XeKb4pw9eAI5xGLezNaMiynrVU81UyWrFcxIfWF5ZCwg8oCEiPK6G
         uYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571368;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+OVZHfXVuJWHaPuWG/8+nuax0OVUjrTdUBXAYrL9vA=;
        b=nZ/do7uIiMKBVKwyP+5WqD2HiYSOURNtfNGGfZBWakRyuSf96to9o1PRWzGGmq9tXj
         ZB8Gdyf+LYQDB8gnt5v1jOlqhiN8MgMdtD7KldVjweH6gdFXTYpwnItrYWxVZ2wwZlEs
         T6+Yfwz25EUGMBu8XtrSOW78iewpb55BYMYbDWJXHuzhsa4wMxEqfCEzSeWVre62s4GB
         qfLr81Jp1qX1mFGdGQYPH0vUxHNp0hqR9edqqoD92r0G5n7GUAMWGo512JUTvSY8e5IQ
         GYND+jB1grnqv3hH35HUt1kSvyc+nEy9/OXCXtJL094QuG04RJSz8sVEUKx+L8KJK45N
         vjJg==
X-Gm-Message-State: AAQBX9czXdfNx1FqekSxDbvRZWlg22WCSZS8HXEONxRR86FAAUj/tSPn
        K3RqeW3gvsPiwIncxaQjDRuNtr46GHA=
X-Google-Smtp-Source: AKy350bTAKSDBRbJa5kXdPdx/GhKJiwY6ke84P1gt0bt3n+LcAJd8FAU9+e/iFaX476hMsIfT/MxYw==
X-Received: by 2002:a7b:cbda:0:b0:3ed:8360:e54 with SMTP id n26-20020a7bcbda000000b003ed83600e54mr879737wmi.8.1680571367958;
        Mon, 03 Apr 2023 18:22:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05600c524b00b003ebff290a52sm20837003wmb.28.2023.04.03.18.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:47 -0700 (PDT)
Message-Id: <23e0a81e788e5d2080cffeb63796b1fca7185f6d.1680571352.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
        <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:24 +0000
Subject: [PATCH v2 20/24] cache.h: remove unnecessary includes
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

cache.h did not need any of these headers, and nothing that depended
upon cache.h needed them either.  Simply expunge these includes.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/cache.h b/cache.h
index 21fd520b045..16b5fc9fa31 100644
--- a/cache.h
+++ b/cache.h
@@ -4,14 +4,10 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
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

