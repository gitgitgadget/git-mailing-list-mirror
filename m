Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4ABC77B71
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjDPDEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjDPDEN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:04:13 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A10D3C15
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id gw13so12113876wmb.3
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614221; x=1684206221;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hA5UfHMctKekDPwKcFA+N+t+HiWPoN5Gn7rqJ+1psEM=;
        b=Xzel18txI/bU16G1xAKurS0AFVhgGtwdMu7t+dgYHE7WzmCvq8Yeel+BReSg52ePdk
         XcIEJ7vtxfxIZCbQqocblwnskMN4IpBJS8g5TxeSRsQc5ESr7736vkKyqrmMi+Ufzev/
         p/E8tw4DuFxQm8VPhouFdzvurj1nlA7oD2sOAFbLfFU5y++5MNFWtMnFwccORPyO1Rj9
         6r2omI/UxCNzagsINXlFsS1WS4dKCecGGWjRb3e10t6XeKyA4pfOtvwjALLlMEPTONqD
         +hv69vH+IXYtfHlpANu3wNN7Om0dGhjMmQj59bNMNUa6ShPHE3LShQRF+++iqxjjw7Ra
         YpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614221; x=1684206221;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hA5UfHMctKekDPwKcFA+N+t+HiWPoN5Gn7rqJ+1psEM=;
        b=FsxcGB0UsWSeZleVt5NbDQokiTLXsjtKRLjEDKDWOBPHhNn2BwOy3qQLuhZ2H3GpmY
         lYO1Jgjz0TI7dVlrWI/t5QYqG39O9UgFZ3iJiGpQmk9vHtXZKY8sMVo2LAgH74C755NO
         GpoK4FnFtAIEP1Tlc+GuSwJfCqk1tafb1Ix+2EHaZl8ys5Uq436RizPk+gMndcg+6N6o
         eLa2OXU3JExeANca5vK/8hi1h2ZO5lHFIASPkW73lUVWOLmNILz8UiIon9ato6Fn1+Ug
         hbLVuFIm/dIqyTHvqYVhtvb2aGxbExbm5ZPquFIKdmOnwLB3kpUyk80ROyleYnr9Ntpi
         wEAw==
X-Gm-Message-State: AAQBX9dW5T0tKUtDiKcn2vNkN9UOyZTt6rPpIWDb/3ElJtaEqGGuRNc8
        44W8hzwp9812InGO8i5eX2A4rMhQbpA=
X-Google-Smtp-Source: AKy350bY1WLKvMTJVWOOaplpz3GA6kYuRsBlFC/Uz3PpVCYg9y6/kEMaRcWZC+Uv29SfJ7gFC/A8Zg==
X-Received: by 2002:a7b:ca50:0:b0:3f1:661e:4686 with SMTP id m16-20020a7bca50000000b003f1661e4686mr2724904wml.7.1681614221325;
        Sat, 15 Apr 2023 20:03:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j4-20020a05600c1c0400b003ee8ab8d6cfsm11927275wms.21.2023.04.15.20.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:41 -0700 (PDT)
Message-Id: <1aa36d91b596522ba01d24b50149bb507e697958.1681614207.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:23 +0000
Subject: [PATCH 21/23] object-store.h: reduce unnecessary includes
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
 object-file.c      | 1 +
 object-name.c      | 1 +
 object-store.h     | 8 ++++----
 submodule-config.c | 1 +
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index 8e0df7360ae..921a717d8a5 100644
--- a/object-file.c
+++ b/object-file.c
@@ -38,6 +38,7 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "object-store.h"
+#include "oidtree.h"
 #include "promisor-remote.h"
 #include "setup.h"
 #include "submodule.h"
diff --git a/object-name.c b/object-name.c
index 5ccbe854b60..88d839f70bc 100644
--- a/object-name.c
+++ b/object-name.c
@@ -14,6 +14,7 @@
 #include "remote.h"
 #include "dir.h"
 #include "oid-array.h"
+#include "oidtree.h"
 #include "packfile.h"
 #include "pretty.h"
 #include "object-store.h"
diff --git a/object-store.h b/object-store.h
index f9d225783ae..23ea86d3702 100644
--- a/object-store.h
+++ b/object-store.h
@@ -2,16 +2,16 @@
 #define OBJECT_STORE_H
 
 #include "object.h"
-#include "oidmap.h"
 #include "list.h"
-#include "oid-array.h"
-#include "strbuf.h"
 #include "thread-utils.h"
 #include "khash.h"
 #include "dir.h"
-#include "oidtree.h"
 #include "oidset.h"
 
+struct oidmap;
+struct oidtree;
+struct strbuf;
+
 struct object_directory {
 	struct object_directory *next;
 
diff --git a/submodule-config.c b/submodule-config.c
index 7fc0812b644..58dfbde9ae5 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -12,6 +12,7 @@
 #include "object-name.h"
 #include "object-store.h"
 #include "parse-options.h"
+#include "thread-utils.h"
 #include "tree-walk.h"
 
 /*
-- 
gitgitgadget

