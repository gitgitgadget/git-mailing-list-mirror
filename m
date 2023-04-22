Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A683C6FD18
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 20:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjDVUSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjDVURv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 16:17:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11A21FDF
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-2f55ffdbaedso1815334f8f.2
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682194666; x=1684786666;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkh3h+0otRtSW4DljvrgG6353s+aSsn0CnyhephkYW4=;
        b=Yig/8OeRRuZHd6Toos3xGPkVBJdfTHnB9c+5MQfkkPnS1Ae01/Hf+0y6BFVYzterhg
         v1vtmKiUaKoCH1gDTzsH7U+C2ToHVdry11BYM24vlNaoufBmRrageIMyUeKyJwiCjD8w
         oEO7JZZGZtYHU2wqoug0uWX1S2CnJI8p41Z86skwwFaVOV0MkChOMPMJaB5NHys1VDBY
         Thu4ZsGYm9RX6TjsTgqVzpNv4QOu8hRkPdvRnLtFJFlVCdyCgu8H3n1qOfBIGZDkanuE
         MB3NLYcEusPVdLXpZuYzexJYfCUxF6NpBLB6xlzubfRqJJ9JBkazeSmhtFDbfOZo0vbi
         0eLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682194666; x=1684786666;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkh3h+0otRtSW4DljvrgG6353s+aSsn0CnyhephkYW4=;
        b=Byc7UitEWEUm6cHAgCHvFzxCspdF5+K1qJZytuJ4mhvUeTQCpEdvcZE3Tc8vHQ4BRF
         tNv92wWECmuBzWt1b+UMrSkkeWbjL1zx8aAVZBkxUi4WQv4FInS4DVkwKJipXRIFIRMB
         DWo+92NcAQbToGzqgEUXDTZgYsG89lREsI6LJyxH74f1S7tZtHqBpwR4IjIZDGjxkMeN
         4f7xVuqYJr+yoiJ4YsM8y3lRJAMyKGonKBODIororRRwHVjKZXEAr7ssOfTVENOPCz12
         8zCOZNwsxCvUwiCsG19QZ4l4FlvG/y4X01RswbYWfLNHRc6+7CMHXPGH3jc5NJj4tgEH
         8deA==
X-Gm-Message-State: AAQBX9cIoLJandCxvxA5vrmq+BxAU5lb67s2hDlrmXacSFDTxI97DmnK
        b1XBPN3NyggdhEu1rvcKstS7OAzZjpw=
X-Google-Smtp-Source: AKy350a1n40VwBtxyw/uP0Rmd94h18qW7+0/84BIbBqauPYP6aIL9+FwRm5E8uWCxc+UliF3N1sNSw==
X-Received: by 2002:adf:e2ce:0:b0:2ef:ae9e:b191 with SMTP id d14-20020adfe2ce000000b002efae9eb191mr5993861wrj.45.1682194666166;
        Sat, 22 Apr 2023 13:17:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4-20020adffa04000000b002fe96f0b3acsm7197463wrr.63.2023.04.22.13.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:17:45 -0700 (PDT)
Message-Id: <b459b60de89750d0226c7c4f1c7c28de249b475b.1682194652.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Apr 2023 20:17:24 +0000
Subject: [PATCH v2 17/22] cache.h: remove unnecessary headers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h                              | 2 --
 compat/fsmonitor/fsm-ipc-darwin.c    | 1 +
 compat/fsmonitor/fsm-listen-darwin.c | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 591c67b0595..bdedb87e83b 100644
--- a/cache.h
+++ b/cache.h
@@ -4,8 +4,6 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
 #include "hashmap.h"
-#include "gettext.h"
-#include "string-list.h"
 #include "pathspec.h"
 #include "object.h"
 #include "statinfo.h"
diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-darwin.c
index e62f093cc19..bc68dca0cae 100644
--- a/compat/fsmonitor/fsm-ipc-darwin.c
+++ b/compat/fsmonitor/fsm-ipc-darwin.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "gettext.h"
 #include "hex.h"
 #include "repository.h"
 #include "strbuf.h"
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 5eb6402ab82..18c0e3913dc 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -29,6 +29,7 @@
 #include "fsmonitor--daemon.h"
 #include "fsmonitor-path-utils.h"
 #include "gettext.h"
+#include "string-list.h"
 
 struct fsm_listen_data
 {
-- 
gitgitgadget

