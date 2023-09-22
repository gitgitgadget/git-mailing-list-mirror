Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA0ECD4F49
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 10:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjIVKmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 06:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbjIVKmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 06:42:16 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1363199
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 03:42:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4053cf48670so6858115e9.0
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 03:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695379327; x=1695984127; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amM5ZmU4e/Qfy3wJiY762+J/so0DCBtN3K1c5nj86F4=;
        b=OHwfwk0PGbR94CKjcxvhhR5ribdDtLoSOdFrqPPVTiJs4Y2NjwDU6kkQLgqP+hDqaH
         Wrs+H2i2Cbt4HfxywUiwDe7KBBzNpPom53acpb0WDpvSRZBt3JRvwokydIXGle6MShvG
         ZvIt61o5P6Vkj0Phfn1X9KgjDSlSlTqF/g49X8YFCTMkyDNag4no6BwizUyfTS5/4osu
         H3RgOZBQBKh2ExnNj//4bSZ1t9jSYAxeWNAJYX/AS11avT6xniga3rdv8SakQG5UFH0F
         19qzxHqUGwuYvPVQTkCel5w7glEtHnjiS10k8bXNHdr5NUPyOol4UMrpRpHB9Z/j/ur/
         aMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695379327; x=1695984127;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amM5ZmU4e/Qfy3wJiY762+J/so0DCBtN3K1c5nj86F4=;
        b=fM582DzSYSnkQSN0by7iz7cRJNg1PzwzO8PcVrJ8F9/WpthJdHii56KSD0+pZrS1UM
         nPt8tjWEBkac5pcuqCeC75PIn+Ir1497Xn+WEdO/Gg/RTeDntOTKMFoZtmNjGqq2czey
         qgvkdRDoHJ5m9zkdqtvqYjNbHVKiZzIUE+YgGDfsR4MFRJC84xniNioeUmQ6/xaAf7Nr
         spSiCso7TLHn6+7GO4SPLcyEhmrhWQf/LjcVZLElz8bo03nRgRxFlQDqRfCxhJiri+mz
         KNqGV64md1KT5FTQ6raB0aFaBpmUZbsSqtvzCTcy5bXXTOpuFUuZ936M8nlQi54RJXr6
         AVrw==
X-Gm-Message-State: AOJu0Yy+YWOzIl0yPKy+XFdIiq6EKU2WP3n4ZZwd1phIy0+Ir0ZWbyhH
        uxFK7Bh1lFQv/peLrGvdZ8gol6Nnc3M=
X-Google-Smtp-Source: AGHT+IEgRHCRn4Q+7xHVUM1CwKfhC++Ax9CVOxY+Z73Wj0iAVZhoTm5dildvVn2pmWmiScR/L4J88A==
X-Received: by 2002:a7b:c5ca:0:b0:404:fc52:a3c6 with SMTP id n10-20020a7bc5ca000000b00404fc52a3c6mr7805968wmk.25.1695379327018;
        Fri, 22 Sep 2023 03:42:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c230e00b00402f7b50517sm4364608wmo.40.2023.09.22.03.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 03:42:06 -0700 (PDT)
Message-ID: <6c1c82862814f40a408231cb249fb4b653276b52.1695379323.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 10:42:00 +0000
Subject: [PATCH 3/6] coverity: allow overriding the Coverity project
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

By default, the builds are submitted to the `git` project at
https://scan.coverity.com/projects/git.

The Git for Windows project would like to use this workflow, too,
though, and needs the builds to be submitted to the `git-for-windows`
Coverity project.

To that end, allow configuring the Coverity project name via the
repository variable, you guessed it, `COVERITY_PROJECT`. The default if
that variable is not configured or has an empty value is still `git`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/coverity.yml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
index e8d0be52702..8aac00bb20f 100644
--- a/.github/workflows/coverity.yml
+++ b/.github/workflows/coverity.yml
@@ -11,6 +11,9 @@ name: Coverity
 # `COVERITY_SCAN_EMAIL` and `COVERITY_SCAN_TOKEN`. The former specifies the
 # email to which the Coverity reports should be sent and the latter can be
 # obtained from the Project Settings tab of the Coverity project).
+#
+# By default, the builds are submitted to the Coverity project `git`. To override this,
+# set the repository variable `COVERITY_PROJECT`.
 
 on:
   push:
@@ -20,7 +23,7 @@ jobs:
     if: contains(fromJSON(vars.ENABLE_COVERITY_SCAN_FOR_BRANCHES || '[""]'), github.ref_name)
     runs-on: ubuntu-latest
     env:
-      COVERITY_PROJECT: git
+      COVERITY_PROJECT: ${{ vars.COVERITY_PROJECT || 'git' }}
       COVERITY_LANGUAGE: cxx
       COVERITY_PLATFORM: linux64
     steps:
-- 
gitgitgadget

