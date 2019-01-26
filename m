Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB8841F453
	for <e@80x24.org>; Sat, 26 Jan 2019 10:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfAZKlR (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 05:41:17 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43119 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfAZKlR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 05:41:17 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2-v6so10413262lji.10
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 02:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/10eHrdN0yDgbcaXbPXnHwIguRNq2M475QgVAaJsXXw=;
        b=hDvuyazBthCkL4CMjZz7nHXYYcrzmJiEq+IF+lhsl3KrVzfZesNtiproso8BJ5Z1BI
         giKI2XJXcajiZI5gYLVG5GfkXKc/pIniGFd3QwslHJTtSSXj38Dw3m7Jejip4ZsUgr85
         MPwTWHZEcwIKiBLsZtLLYCg609T2xzAgdGU14Fo+ZDQZk+YHbahRuNpLxvYqWh15m4Nd
         nhtyjTndbtNSTYhcq1EpZp4Sjk8+9zudd1I0Xq5QQjIv3c37LNSzvLqAYKS8lFD3oL64
         9WheJLc0Oo4byf3Uqyl2cwXp1Z/ly7uzLSu2y3LHQQzuFdo7c1yla/Nm5rZOB1ViwPpf
         bmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/10eHrdN0yDgbcaXbPXnHwIguRNq2M475QgVAaJsXXw=;
        b=VADGx42D07t3/xYHWL9wNg8P3S20RtS7pC4HeRzxIyZgqgEfDEWvheRPly5N/MGfpK
         srXqIWzzHazsYIU1MvjWUsFXAvcbg2AFU+rD8GEWQYwTn9UXU3lAVRoXxv8lTQSvuzZE
         wmJsx6Ut/9bZP5/1sNP9nI5+N2VpEeRBLg1OGjq39/ixLLNr2ANY1mjitWojZiLhN5ZJ
         JtT8yR2ulzOdLaM9ypAe61+InqMrViKZrz2HfAKozOxW2aI3B51T6hTxuaFHQ9fUbQE8
         dO1CcahWkMQSkTSYXn9BMEnbdMMZpKpoNMnvyjuPYUPyN9lqzj4PVUnH1GJ9lcohlvwc
         arng==
X-Gm-Message-State: AJcUukeqfoRWxXAbDP45VHriwl+27wQ0dL/qQDgpKx6U39Ogh0UNs+5s
        MPLY783v8tpLTtNxIHgDguvUxRPUFYWcIj0dGM4oyHVa
X-Google-Smtp-Source: ALg8bN61AoN9y+wYOokawMlTgns1x626oZV6nLs4wzFzWDEzQpX1EunM4kRUvY2v8x0bz5pfzYxs3PvcsDv7g45HTF0=
X-Received: by 2002:a2e:81d3:: with SMTP id s19-v6mr10613693ljg.138.1548499274398;
 Sat, 26 Jan 2019 02:41:14 -0800 (PST)
MIME-Version: 1.0
From:   Sebastian Staudt <koraktor@gmail.com>
Date:   Sat, 26 Jan 2019 11:40:37 +0100
Message-ID: <CA+xP2Sax+thitfKv4hTtKTYPhfVXJxD_qoJxgkCyZFTzskP-Tw@mail.gmail.com>
Subject: [PATCH 2/2] Setup working tree in describe
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This ensures the given working tree is used for --dirty and --broken.

Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
---
 builtin/describe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index cc118448ee..ba1a0b199b 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -601,6 +601,8 @@ int cmd_describe(int argc, const char **argv,
const char *prefix)
     if (!hashmap_get_size(&names) && !always)
         die(_("No names found, cannot describe anything."));

+    setup_work_tree();
+
     if (argc == 0) {
         if (broken) {
             struct child_process cp = CHILD_PROCESS_INIT;
-- 
2.20.1
