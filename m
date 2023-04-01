Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF52C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjDAPLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjDAPKy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:10:54 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED0C20C1E
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q19so22118507wrc.5
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361849;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoMJ9cVwb/ZvflFcl5pAhOAsWQBn3D0Pm7GwOWGmO2I=;
        b=XHyL6J6i1GXy49IVRQwxFMqeH32wJ2VWadWMxqm59S01H6ORKS6A0/ytqjP3oZj9C1
         IcmKB3jSQv3DGQHM6tgSPg06Vznq2B/43PyuU/4EsGMTXmXeOuAiiYxZszTF54GZCC6h
         yKzJrnQed7EZbW6EwGdvlDtbghhiG5eLCfwKZadt6ryR9csUjaCGO17ZupSXVbEGoek9
         ztN+7LfwVAVr+Ysx6m4TEnAclfqqe07y0FE/eoc777Y+eef/gePRZxTRNOdkvGJFG+Gd
         60Tv29/H4rbNi3pIyq88rwsrvQuP8Lnt+x+6enadFaLQzKugxPIGRirFcglklrcjnMvB
         hphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361849;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoMJ9cVwb/ZvflFcl5pAhOAsWQBn3D0Pm7GwOWGmO2I=;
        b=id3KXmXX3KV9Z6lQ9ObzqejRGX8Q8m+QVcW8Yuo8xz0HE13Dakp+Fru8VwfsGlNKx2
         Y3FmhUZPHljK9Sdv2QkghnOoqOLPyWWYO92ToBVoORBXKPzGpfadvxAuZhZudPK55yN6
         NpZEgtatWggyUrWEnc9SlT2ZUUQ2Gb4SWdCWPCk3roPbrwShC2v9p0u6YSKCbNkprXtU
         zDm/QqD0YLKS+HEzz4apV6yQ4IFLoOGngKldG5ry8EaqLiyH12QVsh6DVDCZzGc1gUah
         jT6a+uebCKs686IPrJ3AR4u8CpZWJce8t2Ls1a+9bguXpDiIXnpFaESjBFlXaHO6GWba
         ihCg==
X-Gm-Message-State: AAQBX9feD9T9LV0g0m9rWeWgnsWip0qZB2PH2HsBXE7efLwfK2cKLWJv
        HlbSRc+4CQwqSFEqgoA3N0uNN3C9dJs=
X-Google-Smtp-Source: AKy350bAb5S3gmYWnAqqNDIyZoX01l6suYehSLniSKK7d0Cnu3LSovvGgBm9Ukdep5/BEw288ODUEA==
X-Received: by 2002:a5d:58c9:0:b0:2cf:ea5d:f5fe with SMTP id o9-20020a5d58c9000000b002cfea5df5femr25386629wrf.36.1680361848871;
        Sat, 01 Apr 2023 08:10:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g4-20020adffc84000000b002d8566128e5sm5098157wrr.25.2023.04.01.08.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:48 -0700 (PDT)
Message-Id: <7c969dc801dc4ccfed43bf50e8306114b2a6d357.1680361840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:24 +0000
Subject: [PATCH 11/24] treewide: remove cache.h inclusion due to git-zlib
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

This actually only affects http-backend.c, but the git-zlib changes
are going to be instrumental in pulling out an object-file.h which
will help with several more files.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 http-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http-backend.c b/http-backend.c
index d41b3b9e1e7..ac146d85c54 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
 #include "environment.h"
-- 
gitgitgadget

