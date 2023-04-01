Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EDDC76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjDAPLi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjDAPLC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:11:02 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE93525457
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l10-20020a05600c1d0a00b003f04bd3691eso689262wms.5
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361856;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nqxmhky+sI3H9OjxPibOKPMihIjWkWmM2cuW+L9mfqA=;
        b=f7UIbsZf2aUrBElnDWzMJsUPR78pDlfRZOm/Dn8D/abXkVzpfKlGFSfGIBB2nbe8Ar
         qmBW4h6jXnk2KTMNlCa2DCjUxohHYVGGLs6wdmnDNMGTqnPYMDGFOZtsQNgDNFDhzz46
         rIQN3VdqKCMY6iJuiK1UDhcLhNF0IRj12FgmNa6umivkjAOYUy0KmoneBDkbnshFTH8o
         9T8NrdQVRaFwTep3ULJg4jRH4Ky/akribxLzsDW/qZU2pw9fbrCk11PBQRwkqur0F61J
         weSWFKMQCGt4IQhu6d00C8rhgC0vSALb2H0YsCTZxXaU2iGUwP+1NU0cF3LxbvUqdkkF
         ww4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361856;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nqxmhky+sI3H9OjxPibOKPMihIjWkWmM2cuW+L9mfqA=;
        b=2zbhSBjXCKfjF1FIu/Ct/D7iixw0x4CcqgJveH/Q1SyqpgyR7HggVqaCarfoMiOWG8
         oigF0Lb30zO4awz+glwg3GgAS3wiljiHx32HycHspwtw4oCptqyG0YjV4OwTEH/tD1ql
         7a6RVC2NP82pGvrVgQgCRWbIfzro0DgW2fRoA9CEyZPAwPYX5OJMctXTJqveqngDstQD
         VJaDd9uSaJa+Ytj45kw7pBj3LiYgCpHrsYkEQOxcbwSEoD8QQ/g7JVoLlaBPpqP1D30O
         s6xYqOD5i8yqYSeTMG/KbxnIOWVm6eXntKBMBtRpdudfGAed1pu+PNyiskJl6rko//Ok
         HFUw==
X-Gm-Message-State: AO0yUKU9/6g85OCMvDxiXx3qROPevB+Hef/pAwIpIgyofxIkI3/auJl7
        zKzmBNf7aVy2M1RDR5PVEbygMcvlJ7s=
X-Google-Smtp-Source: AK7set96NreD4n2PFiuzct8iezuGeBgErlShd9x0ngsD7JHDLqYc6HsPyLczVyq1Wu9jBcfC7YInGg==
X-Received: by 2002:a7b:c44a:0:b0:3ef:8b0:dbb1 with SMTP id l10-20020a7bc44a000000b003ef08b0dbb1mr22601191wmi.7.1680361856073;
        Sat, 01 Apr 2023 08:10:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b003ee8a1bc220sm13917256wmq.1.2023.04.01.08.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:55 -0700 (PDT)
Message-Id: <50cbcacaad1f004ad9fc99e94a8a8bbc699cbc4d.1680361840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:36 +0000
Subject: [PATCH 23/24] chdir-notify, quote: replace cache.h include with
 path.h
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 chdir-notify.c | 3 ++-
 quote.c        | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/chdir-notify.c b/chdir-notify.c
index 8e38cd6f3ae..0d7bc046074 100644
--- a/chdir-notify.c
+++ b/chdir-notify.c
@@ -1,7 +1,8 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "chdir-notify.h"
 #include "list.h"
+#include "path.h"
 #include "strbuf.h"
 #include "trace.h"
 
diff --git a/quote.c b/quote.c
index 7ccb5a06cd1..43c739671ed 100644
--- a/quote.c
+++ b/quote.c
@@ -1,5 +1,6 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
+#include "path.h"
 #include "quote.h"
 #include "strbuf.h"
 #include "strvec.h"
-- 
gitgitgadget

