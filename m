Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DA2C74A5B
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 06:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCUG01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 02:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCUG0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 02:26:25 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C2B32E50
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id az3-20020a05600c600300b003ed2920d585so10441267wmb.2
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679379980;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZePoT6xG09hXO5Wyj2H7oPBnO1WvJOSTSfKLn1Yl8s=;
        b=ltzBlEFnw+PvcOaCgA1OuftHUCLvyXTfOy9zdXwSAgXAjTcgDa0NqBj/oygmX84bvO
         64ECe5zoeGoshbTxvkcsh/V3Hwi8HiMOMDOUWA4r7jje0rDwsKJ4h/PS3RHxD95erV3l
         RNtL23dNEUIa2oS5hAaqrmlgT0sPzP7SaEqEYD7kZJc21Sc86lGjMkysMsn553qSKtbc
         Yn/8uvE33ENYV3g6wapX6i8mwUEnELetLEMbbZcmmtflF99ieTrD+iEdUQXWqH7iqy+t
         iU0XMzzKZhQtpEO6H+tCejNLLfwA/VjczpE4h1PWydb+I/4YPCTUdShPZLbxOBUgv4hV
         IV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679379980;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZePoT6xG09hXO5Wyj2H7oPBnO1WvJOSTSfKLn1Yl8s=;
        b=dDUYMp3yItAsMYmoIHl7DLnc0LpjQS1wc4zacBuTQyb7kmbt6Rj2ApY3sUcgaMh5D9
         M51Hb17NZRUZ35hLy+abbLY+HmlenmKfKVRoknb0csG0T2pbzfKEpiJ6LuujWxWYY6lk
         LMFJKCJbVIZ2b/jXILsGQZJNdrFfyiVpq63g0Lmg9LMSHde3sBQ24Oe//DP7s2i6qGhB
         I5jwroOXifewNSUKCOtyYAEcAb+TPgyhMbm+41aXcKTUfWV9zrBOX5nhAQHSNhesq+Ms
         NhjOtQpsybKlWX8VjxiQ4y+PB27c8Oy82uuTqWBrw8K/t8hfawxmeKUEqnfnRnLKKeNn
         EcYA==
X-Gm-Message-State: AO0yUKUVB4U5WFo09tShRQqeZlonlS4NuY9YSsnXdPNuZ7rGUNLAe5f6
        dn+h7LXOmE/6alJsBCEjuFETy52DX/8=
X-Google-Smtp-Source: AK7set+F+nOFCaFVsM1HWogZOO+3SQFfkK407yXkjkv129q3P8U9WTYVvKaT1UDR3bEsYduOC9tEhA==
X-Received: by 2002:a7b:ce13:0:b0:3ed:8360:e54 with SMTP id m19-20020a7bce13000000b003ed83600e54mr1543477wmc.8.1679379980357;
        Mon, 20 Mar 2023 23:26:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x20-20020a1c7c14000000b003edc11c2ecbsm8374157wmc.4.2023.03.20.23.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 23:26:20 -0700 (PDT)
Message-Id: <644d305c6696e47a5a7e235ab11f69d368aca5f2.1679379971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
        <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Mar 2023 06:25:55 +0000
Subject: [PATCH v2 03/16] treewide: remove unnecessary inclusion of gettext.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Looking at things from the opposite angle of the last patch, we had a
few files that were including gettext.h and perhaps needed it at some
point in history, but no longer require it.  Remove the include.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 progress.c                          | 1 -
 t/helper/test-parse-pathspec-file.c | 1 -
 t/helper/test-progress.c            | 1 -
 t/helper/test-run-command.c         | 1 -
 4 files changed, 4 deletions(-)

diff --git a/progress.c b/progress.c
index 9b33a2df325..44c784d75f1 100644
--- a/progress.c
+++ b/progress.c
@@ -10,7 +10,6 @@
 
 #define GIT_TEST_PROGRESS_ONLY
 #include "cache.h"
-#include "gettext.h"
 #include "progress.h"
 #include "strbuf.h"
 #include "trace.h"
diff --git a/t/helper/test-parse-pathspec-file.c b/t/helper/test-parse-pathspec-file.c
index 71d2131fbad..89ecefd1cdb 100644
--- a/t/helper/test-parse-pathspec-file.c
+++ b/t/helper/test-parse-pathspec-file.c
@@ -1,7 +1,6 @@
 #include "test-tool.h"
 #include "parse-options.h"
 #include "pathspec.h"
-#include "gettext.h"
 
 int cmd__parse_pathspec_file(int argc, const char **argv)
 {
diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 6cc9735b601..66acb6a06c9 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -19,7 +19,6 @@
  */
 #define GIT_TEST_PROGRESS_ONLY
 #include "test-tool.h"
-#include "gettext.h"
 #include "parse-options.h"
 #include "progress.h"
 #include "strbuf.h"
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index b0d041ec5ff..c0ed8722c87 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -16,7 +16,6 @@
 #include "string-list.h"
 #include "thread-utils.h"
 #include "wildmatch.h"
-#include "gettext.h"
 
 static int number_callbacks;
 static int parallel_next(struct child_process *cp,
-- 
gitgitgadget

