Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F5BC83F29
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 06:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343572AbjHaGPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 02:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245635AbjHaGPm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 02:15:42 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DC5CDD
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 23:15:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-401d10e3e54so3876735e9.2
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 23:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693462538; x=1694067338; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPUNwTpoGT9m/YFejKsp7W7P/TOk3usDGQALMcYRJwg=;
        b=EXOFAtP8vt5of9FWhhtsmIJtMFcojdo8c1wXPDEriFgzWS4wp+bIGYsdcYs50JQTfh
         4jF9BpvyRHWgY4jbMGZQegKGlRYJzPFo09eW1uhYeoXB3i1qFperyMSzHi2pMYsQ/0ks
         fRVUesp614zucxXKdARqCPr/RXUkbEQ5q3NVD94GVDlYln0OybFvpF6v9QLyB0HpX1GR
         rEQ8y1FzZXOltO1iqJ6U+c6fc5UiUI5iAv8kPXtvSIE1p6mg9XOtLdRwCcIX3hiqthGd
         69ol2hZJoUzV/FhwJl4nFvR7agB0cfqxlmtvSMSnYFBmJuI+4FgkANXFqySpF2bPnf/D
         D4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693462538; x=1694067338;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPUNwTpoGT9m/YFejKsp7W7P/TOk3usDGQALMcYRJwg=;
        b=JQj9xgRWhGkNQxTfi0WEVO/+Jq73enBH/Id9V6nJrUJ6JAlDX6oNCxVFkLIxBEcNyo
         dhpvDuKhGm53a77tIl1++dL4eUgf2lNYJlgai8WGF/pS/S8sZhSgKxpxWNwGMRNSNKS2
         7GFJuHhaZ6b5weFab4c0Sazyh1yBLLBqxKBiG6SU+x6QMhyHLYGqoDvxNS2XxmAmt9Tt
         eCP4XU+DHsOGWfMv4KJLeX7Lr5NNhrcUN0gDCio3GHNHOpBMipAgJcgXDz3Y+c4KTEPA
         71hLDerLumYI9XK2mh3WrO0ASKdPcF3vewPo6AJ4vRN7SYB5iKYBb/hdxrMWvGIzUgS9
         X/Hw==
X-Gm-Message-State: AOJu0YxYUw98o7WsKH3vJBo641zGl8IyEvhYWI5yLkVV8WTrfsKYdhXO
        ZMvhKB0xOhZHeOgWOC8M6DkpvJC9tL0=
X-Google-Smtp-Source: AGHT+IGZEB1d6EnVMk1Dy7q20CPUQL8wTfoCzmm3vy/JSp6LfX6WZTyMmUZeL9/9wtNsMx7RKe/tow==
X-Received: by 2002:adf:e443:0:b0:319:7b66:7803 with SMTP id t3-20020adfe443000000b003197b667803mr3421466wrm.55.1693462537937;
        Wed, 30 Aug 2023 23:15:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j4-20020a5d5644000000b003143b14848dsm996650wrw.102.2023.08.30.23.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 23:15:37 -0700 (PDT)
Message-ID: <fb03f5aa6e59bd191b2c3d9a6446828cc3130fa5.1693462532.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
References: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 31 Aug 2023 06:15:32 +0000
Subject: [PATCH 4/4] artifacts-tar: when including `.dll` files, don't forget
 the unit-tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As of recent, Git also builds executables in `t/unit-tests/`. For
technical reasons, when building with CMake and Visual C, the
dependencies (".dll files") need to be copied there, too, otherwise
running the executable will fail "due to missing dependencies".

The CMake definition already contains the directives to copy those
`.dll` files, but we also need to adjust the `artifacts-tar` rule in
the `Makefile` accordingly to let the `vs-test` job in the CI runs
pass successfully.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 4016da6e39c..d95a7b19b50 100644
--- a/Makefile
+++ b/Makefile
@@ -3596,7 +3596,7 @@ rpm::
 .PHONY: rpm
 
 ifneq ($(INCLUDE_DLLS_IN_ARTIFACTS),)
-OTHER_PROGRAMS += $(shell echo *.dll t/helper/*.dll)
+OTHER_PROGRAMS += $(shell echo *.dll t/helper/*.dll t/unit-tests/*.dll)
 endif
 
 artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
-- 
gitgitgadget
