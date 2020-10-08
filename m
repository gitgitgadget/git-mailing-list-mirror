Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC83C43467
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 07:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6357021927
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 07:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvf1tJHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgJHHjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 03:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbgJHHja (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 03:39:30 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2C3C061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 00:39:30 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d23so2347704pll.7
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 00:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TZbtnHUjQL92kRjIQPaPYiVZAYq+9GqBEtY0QRlamg4=;
        b=bvf1tJHfVIs+PFKwN8g4twUjuRtSfg6glNAqP+tRas4zxj664EUeAVomICRvI+L/49
         qzTtDVa++n8FAk80DF6hxeRcqkYWVcou7/3H+eIudl8Hb3oldC1E2ET8e7dtwq5Qdd2M
         2jvOEVtKSj2PrG/d7sH/FjUBfV6CSr/fDr1cS6LzL9ACgGaytoOM7wxYUXpq1Mj2qa2y
         HMzXLp0gsN3wOI62K8fkyjRZ4c60R3fR4F0n/LrNedMpGTzMA6HcXYFZ/SYVrzIyXyBg
         Q3QlzPh8hcCMEhwnSQhUaOSj9DQUJcSW1dweh4lPUb9FmkN31QoIqB6Bz/K0+lH91n25
         nVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TZbtnHUjQL92kRjIQPaPYiVZAYq+9GqBEtY0QRlamg4=;
        b=WEvfjkqfvPAYRA2ItpFbhrBew+TDKGepj2wV80l2q8YPoLIiRuIBDkv3TntvJhD/v2
         aKy5QvNibsAqGWYQWGfsQk0CRnBZ+qX17hj0WBCJn+e52qGKQUThM+hJNnAlz0SDaeEW
         zr5N47tS+yKFw4qd3+aU5kbcxW8lp9zqmiPeuU7neR1AEe1JiUCdTJZli0ZdRftt3x8U
         3QUT5TAu7SQ0MrRmvJ7x+I4WjS1hCtMDsSDl1tCkurJAZ190Yyd0LeqPpZzMCmQsfYHj
         T33CGcvHymz6pIriqQf9bgI1a4f5YATcX7tEgcwofra0vq8wT5Zej/z0gB4uL0x7o/IQ
         R3+g==
X-Gm-Message-State: AOAM532c+Z2O9Dxen8exgNLTNvCaEXd+6SfC0tKx67vyPuKzA0MLV+1B
        d3RH4b53vTDRNgKJm79NIZF0fKnKBfk=
X-Google-Smtp-Source: ABdhPJxvd0Ts6cqeOvAIXhQ5Sxygc9mXAtG3dGvefQC9cf2hwJjMB/iFlDCnhVtjCnYwCF34l1ViQg==
X-Received: by 2002:a17:902:b901:b029:d2:8abd:f640 with SMTP id bf1-20020a170902b901b02900d28abdf640mr5995692plb.30.1602142769469;
        Thu, 08 Oct 2020 00:39:29 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id q5sm5926553pgh.16.2020.10.08.00.39.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:39:28 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] Makefile: ASCII-sort += lists
Date:   Thu,  8 Oct 2020 00:39:26 -0700
Message-Id: <f0f1ef1f677133eabd1bce00c6cdbbcc6477f00b.1602142738.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.29.0.rc0.261.g7178c9af9c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 805d9eaf5e (Makefile: ASCII-sort += lists, 2020-03-21), the += lists
in the Makefile were sorted into ASCII order. Since then, more out of
order elements have been introduced. Resort these lists back into ASCII
order.

This patch is best viewed with `--color-moved`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 5311b1d2c4..95571ee3fc 100644
--- a/Makefile
+++ b/Makefile
@@ -820,8 +820,8 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 
-GENERATED_H += config-list.h
 GENERATED_H += command-list.h
+GENERATED_H += config-list.h
 
 LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
 	$(FIND) . \
@@ -998,9 +998,9 @@ LIB_OBJS += sigchain.o
 LIB_OBJS += split-index.o
 LIB_OBJS += stable-qsort.o
 LIB_OBJS += strbuf.o
-LIB_OBJS += strvec.o
 LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
+LIB_OBJS += strvec.o
 LIB_OBJS += sub-process.o
 LIB_OBJS += submodule-config.o
 LIB_OBJS += submodule.o
@@ -1066,15 +1066,15 @@ BUILTIN_OBJS += builtin/checkout-index.o
 BUILTIN_OBJS += builtin/checkout.o
 BUILTIN_OBJS += builtin/clean.o
 BUILTIN_OBJS += builtin/clone.o
-BUILTIN_OBJS += builtin/credential-cache.o
-BUILTIN_OBJS += builtin/credential-cache--daemon.o
-BUILTIN_OBJS += builtin/credential-store.o
 BUILTIN_OBJS += builtin/column.o
 BUILTIN_OBJS += builtin/commit-graph.o
 BUILTIN_OBJS += builtin/commit-tree.o
 BUILTIN_OBJS += builtin/commit.o
 BUILTIN_OBJS += builtin/config.o
 BUILTIN_OBJS += builtin/count-objects.o
+BUILTIN_OBJS += builtin/credential-cache--daemon.o
+BUILTIN_OBJS += builtin/credential-cache.o
+BUILTIN_OBJS += builtin/credential-store.o
 BUILTIN_OBJS += builtin/credential.o
 BUILTIN_OBJS += builtin/describe.o
 BUILTIN_OBJS += builtin/diff-files.o
-- 
2.29.0.rc0.261.g7178c9af9c

