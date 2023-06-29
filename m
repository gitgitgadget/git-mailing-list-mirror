Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9B5EB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 18:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjF2Sw6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 14:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjF2Sw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 14:52:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7708FA2
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 11:52:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-262e81f6154so609017a91.2
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 11:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688064776; x=1690656776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VhegxwUN7qXtnxOjXyHOpbbKh1srwoiVKyYGpNoeKh4=;
        b=VAZON0Oi6yAJDynknR6Zxpf60VG3QcVxCIrT+v6esGDC3PWbAckyoqfITSsHRG76hx
         d+rtNQTd3ziRTHalOq3Q0yQCyESm1XCLAOrrXAds7+sjis56x5+gtOLtLEA2YpbEcUXz
         qXT096QAmv643LdaDB81XRI9uaBKd5Q3xUvBWaO6WFHhdyKbTtN+I1fnDydOmMrwoYIr
         IWDOTbr2U2SYEiiCutcQlAjqAzcrfuo1y+FJd+gFmACr8yFVjKdq2tE+/taZD3o+QOwn
         MTe9Q46B/iBbLHbrgVzOsbO8xkrlbrPPeBKR2GzFPo3YmvWKGKeF/+eajlwgmaN0ttSP
         iJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688064776; x=1690656776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhegxwUN7qXtnxOjXyHOpbbKh1srwoiVKyYGpNoeKh4=;
        b=MQZD2rbrLE1J/AOD79z9C0zVfRZbx//x+O22b1YuUTGcrBwQtYW3/JcCRaW8k5qhdq
         7cjv3sgzT8R9WE0FyXyS21Br+ff9uGzULMOXUceFVXHG5loFBsHDTxdFrBgAVPyMOrK2
         a2Bh7Rm+HCXtXHMkWZkkz+OS2S4HKxGuYfzH5vCkSpwLZvd4YQoUon5c4/oEwTX5DCIS
         UYRuGv1MMRSYXdbkXeG56i44VAdij7JCukDTRij8wHq7Nt+ECwvqq1+WpQBu2S+OViwg
         X+ZmIM2eV6cEmnIphPbiDzRmRQkSoVv0JX0/EfEfVTqJGIUCBSWFQApPCJbcEO4f4el0
         Exsg==
X-Gm-Message-State: ABy/qLay1TuKDzEEm3wnYsfg3XjjCZqBQE9Fv8MqlvQ0v6UCFARFPGHh
        s8uYjk5Sy6a2uHMmpP9fTmE=
X-Google-Smtp-Source: APBJJlHWrAwMfIqLmYAh+97VxIzn8QZt6L2iCfwpGkNaInbj/LUwwhvXakK2keOMrtQLyj/E1y8eKQ==
X-Received: by 2002:a17:90a:d484:b0:263:5333:ca26 with SMTP id s4-20020a17090ad48400b002635333ca26mr227349pju.29.1688064775772;
        Thu, 29 Jun 2023 11:52:55 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:6805:29d5:fcf4:4571:4cad:a8ff])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a1a1300b0023fcece8067sm10257366pjk.2.2023.06.29.11.52.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Jun 2023 11:52:55 -0700 (PDT)
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
To:     nasamuffin@google.com
Cc:     git@vger.kernel.org, Vinayak Dev <vinayakdev.sci@gmail.com>
Subject: [PATCH] docs: include "trace.h" in MyFirstObjectWalk.txt
Date:   Fri, 30 Jun 2023 00:22:38 +0530
Message-ID: <20230629185238.58961-1-vinayakdev.sci@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Documentation/MyFirstObjectWalk.txt, the function
trace_printf() is used to enable trace output.
However, the file "trace.h" is not included, which
produces an error when the code from the tutorial is
compiled, with the compiler complaining that the 
function is not defined before usage. Therefore, add
an include for "trace.h" in the tutorial.

Signed-off-by: Vinayak Dev <vinayakdev.sci@gmail.com>
---
 Documentation/MyFirstObjectWalk.txt | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index eee513e86f..c3a23eb100 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -41,6 +41,7 @@ Open up a new file `builtin/walken.c` and set up the command handler:
  */
 
 #include "builtin.h"
+#include "trace.h"
 
 int cmd_walken(int argc, const char **argv, const char *prefix)
 {
@@ -49,12 +50,13 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 }
 ----
 
-NOTE: `trace_printf()` differs from `printf()` in that it can be turned on or
-off at runtime. For the purposes of this tutorial, we will write `walken` as
-though it is intended for use as a "plumbing" command: that is, a command which
-is used primarily in scripts, rather than interactively by humans (a "porcelain"
-command). So we will send our debug output to `trace_printf()` instead. When
-running, enable trace output by setting the environment variable `GIT_TRACE`.
+NOTE: `trace_printf()`, defined in `trace.h`, differs from `printf()` in
+that it can be turned on or off at runtime. For the purposes of this
+tutorial, we will write `walken` as though it is intended for use as
+a "plumbing" command: that is, a command which is used primarily in
+scripts, rather than interactively by humans (a "porcelain" command).
+So we will send our debug output to `trace_printf()` instead.
+When running, enable trace output by setting the environment variable `GIT_TRACE`.
 
 Add usage text and `-h` handling, like all subcommands should consistently do
 (our test suite will notice and complain if you fail to do so).

base-commit: a9e066fa63149291a55f383cfa113d8bdbdaa6b3
-- 
2.41.0

