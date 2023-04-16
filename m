Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123B8C77B70
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjDPDDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjDPDDd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:03:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83DB2720
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so19416201wmb.3
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614210; x=1684206210;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iyn6nKlQw9yGWcfidM3+jxNkwrI+OV5y+tjEV6icvb4=;
        b=EFqlHyK7jBODpjycWbJuWubcT92a0803pu8gNEdPWElj3MZvzpclzAnNzGgRG7maP1
         rJmHyflUnhWLpfzGrRMfpucihrcFTumHnBsWfL6leieYljF0pB3EeeOsXosoXkqYbYNd
         +ynj46x/hBSjWXaJAfWHM1n/1bRGCtzAZogrJq3hLmr9xNKGaLuePsFbpVudh6R5boZM
         xeMyDASZd+1tf+FI3cpuemPT6ZbtQp1BJERM3bozNrIdZWEeT2jLVHW6mCWTPgtkmlzR
         W0PtVNenL1vWlVST6VtdHFpLoy9G4I2oIAdqLaBXW9rbxXEocjjuqlJC+MIF6VrfHH45
         N+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614210; x=1684206210;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iyn6nKlQw9yGWcfidM3+jxNkwrI+OV5y+tjEV6icvb4=;
        b=irOIysZUrceHsSorrvS/rIxr2YEvlHd6xPbLmQKugiedSA1YbTKM5N2rNMY8SliEIi
         Oqu9ah0S76z4s8C7Wu+sbXsHIyokNbiDtGFQCQ7toZWCDNq3bv087MJbG2U8jdJPF/T6
         ZSOUYK+6nWkUwUbnW6/nsIsRxjyTB7JCJfOfbB+SrDUENsMXEPNHuGwIJwOdo5pVwG5M
         xhske07GvSnjhyGN49AwLffmLeyKrgE127/+DYMh/6FhFZN2d9016e2EWDNarHOFB5Zm
         8b73HyxkELN1Lv6m67GuGWSGjDOlc/KwcZWxA4HiBrORpmK2cng0/htZyufagbjYZ/ob
         cMJw==
X-Gm-Message-State: AAQBX9cy41hJ7GNrIjH3MUw4QgYhdWXFWOtZU7yqOcFuQQlBhwRuC62f
        68gUOqaFVUF/6YPg2KhAmYrC/I95LG0=
X-Google-Smtp-Source: AKy350ZiBHScwAGDaw6y8DbnT8O6FOQbzsY2Tg/Y0IETtN9lN0QYUYdI1CfNJNJHbfGN8bL01wbSeg==
X-Received: by 2002:a05:600c:4688:b0:3f1:65d4:30f7 with SMTP id p8-20020a05600c468800b003f165d430f7mr2743030wmo.10.1681614210223;
        Sat, 15 Apr 2023 20:03:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d4e51000000b002f01e181c4asm7056392wrt.5.2023.04.15.20.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:29 -0700 (PDT)
Message-Id: <003548de707f57cb9908b6dfbdf42954f668ee43.1681614206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:05 +0000
Subject: [PATCH 03/23] protocol.h: move definition of DEFAULT_GIT_PORT from
 cache.h
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
 cache.h    | 21 ---------------------
 daemon.c   |  1 +
 protocol.h | 21 +++++++++++++++++++++
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/cache.h b/cache.h
index e225964b3ea..ffec289dc5d 100644
--- a/cache.h
+++ b/cache.h
@@ -39,27 +39,6 @@
 #define S_DIFFTREE_IFXMIN_NEQ	0x80000000
 
 
-/*
- * Intensive research over the course of many years has shown that
- * port 9418 is totally unused by anything else. Or
- *
- *	Your search - "port 9418" - did not match any documents.
- *
- * as www.google.com puts it.
- *
- * This port has been properly assigned for git use by IANA:
- * git (Assigned-9418) [I06-050728-0001].
- *
- *	git  9418/tcp   git pack transfer service
- *	git  9418/udp   git pack transfer service
- *
- * with Linus Torvalds <torvalds@osdl.org> as the point of
- * contact. September 2005.
- *
- * See http://www.iana.org/assignments/port-numbers
- */
-#define DEFAULT_GIT_PORT 9418
-
 /*
  * Basic data structures for the directory cache
  */
diff --git a/daemon.c b/daemon.c
index db8a31a6ea2..75c3c064574 100644
--- a/daemon.c
+++ b/daemon.c
@@ -4,6 +4,7 @@
 #include "config.h"
 #include "environment.h"
 #include "pkt-line.h"
+#include "protocol.h"
 #include "run-command.h"
 #include "setup.h"
 #include "strbuf.h"
diff --git a/protocol.h b/protocol.h
index cef1a4a01c7..de66bf80f84 100644
--- a/protocol.h
+++ b/protocol.h
@@ -1,6 +1,27 @@
 #ifndef PROTOCOL_H
 #define PROTOCOL_H
 
+/*
+ * Intensive research over the course of many years has shown that
+ * port 9418 is totally unused by anything else. Or
+ *
+ *	Your search - "port 9418" - did not match any documents.
+ *
+ * as www.google.com puts it.
+ *
+ * This port has been properly assigned for git use by IANA:
+ * git (Assigned-9418) [I06-050728-0001].
+ *
+ *	git  9418/tcp   git pack transfer service
+ *	git  9418/udp   git pack transfer service
+ *
+ * with Linus Torvalds <torvalds@osdl.org> as the point of
+ * contact. September 2005.
+ *
+ * See http://www.iana.org/assignments/port-numbers
+ */
+#define DEFAULT_GIT_PORT 9418
+
 enum protocol_version {
 	protocol_unknown_version = -1,
 	protocol_v0 = 0,
-- 
gitgitgadget

