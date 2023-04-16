Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755CBC77B71
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjDPDEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjDPDDv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:03:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A0F269E
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-2eed43bfa4bso653353f8f.2
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614216; x=1684206216;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjrl8Oed5rjHg5PtrqFWFgcxhLHnyHcgNOXFVIVvWtE=;
        b=Rj54CQ+r5nkjDY7M7qhkDDvY3ILxiwleDB1JyLp3sH2Suj6lqs3T22LkMlb5mXd4Mk
         +gwKfQPUNooBUaQ83LLbFDY+8hg3Zh+7DvhWSOGu1G07nf/6peyqWIVGDn2mokCOTzdW
         NpqB75yMV68OAmHAaB1XFjW6aFh0zjLWyrb2xlgEanqNUCgVipYI7mYiL36uGc2KEL5t
         E45JTE64aVFYpD8/qDzKAnoYd0iJO7zQLB04ndl2SEdZACoPcsqTverkWZDBaW9FuqLK
         mrIMj3asiTDjsFV33mvugjo6hQcSvRqMgxFF0JSrozhzHv7VPNjVfQ9NRPe3RvEVm6Eq
         z33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614216; x=1684206216;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjrl8Oed5rjHg5PtrqFWFgcxhLHnyHcgNOXFVIVvWtE=;
        b=UcWtn6Al0lyA7/Ijwfr9tz4GUQAAUcKdMpSdBq6IcfKB07rUioH7MNmLnB42m+UBMw
         XWK6iqTuEHHZiXN40t5RSqekENYgLC9O6Y6MX5DDnMZicffaqP2zfmlhofPrDdQxT1zy
         uDA/fKETyPh6deO4SDfnc6jZ4ys2i1O5knQBdApoGOaU8FfDVlQS48JdFd9x1Hya/VDi
         OTV5HDAAYzCUOKeJl0vIWzY7I7ptvap6gDhdoLLZ+efwSUr0XhW/rrZ62a7yIeXaioa9
         95EKC8SxVZ3FwVVePPw4YaBv6VxHp25Q/aS0cNT5QjKe7U6qgSrSiNMckdiUDTDTFjKT
         W7kQ==
X-Gm-Message-State: AAQBX9cYJ+dK2EIkBpLCNHF7TmxOMPXZLBd6VEZhRezn4CWsbTx15p22
        8mv0t+D2PZfUlRBatYN6/TJgqJzB9iU=
X-Google-Smtp-Source: AKy350YJp4RPiQo4vI0etNJ3c5q3u921VumrzeYO7LC3/94/NnTBVK44uW9SvWiGtr0XVyK5Hu7TiA==
X-Received: by 2002:a5d:63c3:0:b0:2f9:61b5:7796 with SMTP id c3-20020a5d63c3000000b002f961b57796mr779401wrw.29.1681614215900;
        Sat, 15 Apr 2023 20:03:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6-20020a056000118600b002f0057f6fd8sm7026305wrx.13.2023.04.15.20.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:35 -0700 (PDT)
Message-Id: <4c951a53737efec1f4da866a80955b4c34f5e5f4.1681614206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:14 +0000
Subject: [PATCH 12/23] dir.h: move DTYPE defines from cache.h
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
 cache.h | 14 --------------
 dir.h   | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/cache.h b/cache.h
index 6955745cccd..ad741e70bc2 100644
--- a/cache.h
+++ b/cache.h
@@ -10,20 +10,6 @@
 #include "object.h"
 #include "statinfo.h"
 
-#if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
-#define DTYPE(de)	((de)->d_type)
-#else
-#undef DT_UNKNOWN
-#undef DT_DIR
-#undef DT_REG
-#undef DT_LNK
-#define DT_UNKNOWN	0
-#define DT_DIR		1
-#define DT_REG		2
-#define DT_LNK		3
-#define DTYPE(de)	DT_UNKNOWN
-#endif
-
 /*
  * Some mode bits are also used internally for computations.
  *
diff --git a/dir.h b/dir.h
index 3d6c87387e9..79b85a01ee4 100644
--- a/dir.h
+++ b/dir.h
@@ -640,4 +640,19 @@ static inline int starts_with_dot_dot_slash_native(const char *const path)
 
 	return path_match_flags(path, what | PATH_MATCH_NATIVE);
 }
+
+#if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
+#define DTYPE(de)	((de)->d_type)
+#else
+#undef DT_UNKNOWN
+#undef DT_DIR
+#undef DT_REG
+#undef DT_LNK
+#define DT_UNKNOWN	0
+#define DT_DIR		1
+#define DT_REG		2
+#define DT_LNK		3
+#define DTYPE(de)	DT_UNKNOWN
+#endif
+
 #endif
-- 
gitgitgadget

