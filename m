Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF04C636D7
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 08:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjBWIG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 03:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjBWIF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 03:05:59 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F644AFE1
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:36 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t13so9842136wrv.13
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpBTRBD8Xz1Ta6W/i62HzAk3HPHLbKTtxp5fZopM4eU=;
        b=C8hIclw0JAqIDmUq0wmXLz6c6FMtbjcnNIDRtcs0aynrmQZrd45T3FtHdYECt7/f+M
         SAbDDd4VkOgkNbBCiD+wYZU1RlRLcu4gfcDwFHlw5Rhnyr66RB/7DuSZVBIg8urMv37V
         irmh0GqEWqsEpk9GWFutvML9fK/Hj6qk3PB4Tbo7IhfBuYT6F95TjYHPDDqRImzSCFCr
         LTgKnsEYreluy4VgFc/FDkpbNnjYAxw9TDgf5HbQu3U0BqnKr8H+YPEDgUOtNpNbp+6R
         NZ2FDmB29rcnoGQfHq218lX68L6y/JPp5rKqUS9vz7k8KniOshGchKz2kSnR8euLoiVn
         DB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpBTRBD8Xz1Ta6W/i62HzAk3HPHLbKTtxp5fZopM4eU=;
        b=Zd5Zb5a2xMUhUKPKmSBUXLovivNvJ0KC2kRZ+aYufwmzSd78ZprUCabr2NTzgG2+Kl
         dnCu+PTeSauvsk9ExCMp5EspzC9IPUUCHAiB0FfRsPcsbCk31cXG66Ntm83DKrS5d5T1
         GTMxjvwGcglahnpRGojKaJtkp1MLvcu3T7PsQ612chfy0Igd3KnlkC4VYAWJkHA2OjM9
         BINpvMICmhVKoRSvqBodBptcRNZ2kAqptpxKNJYiX0Z3wKK2j+wFBKldx3ZU9q1LGPFm
         cZaDKe7SZ4qLbugDszDaV7lsD3GEeJAJfZe23BI4MP9VQkVfDrVKbtKz/eTpzqqJNfwc
         LBmQ==
X-Gm-Message-State: AO0yUKUcrEDr3iiAU07arkzaqh1CcTYycdl2baY41NweEN90JldJORfG
        aJBTFGfgXgaEAAfmuEz0h6DKK7egcA0=
X-Google-Smtp-Source: AK7set9otiAJfLGyi/kzwTYZJbczdclHmmULDOPPZfnGyCEUkwgEAi07rUb0Lw2lQSSXXJZjU1uv4A==
X-Received: by 2002:a05:6000:61e:b0:2c5:5916:e902 with SMTP id bn30-20020a056000061e00b002c55916e902mr10266884wrb.17.1677139534634;
        Thu, 23 Feb 2023 00:05:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j29-20020a05600c1c1d00b003e204fdb160sm4817970wms.3.2023.02.23.00.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 00:05:34 -0800 (PST)
Message-Id: <2931a0a8c78edefde1b0b0335c6739e8ee98773e.1677139522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 08:05:20 +0000
Subject: [PATCH 15/16] Remove unnecessary includes of builtin.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff-no-index.c   | 1 -
 merge-recursive.c | 1 -
 send-pack.c       | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 05fafd0019b..a3cf358baf0 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -13,7 +13,6 @@
 #include "diffcore.h"
 #include "revision.h"
 #include "log-tree.h"
-#include "builtin.h"
 #include "parse-options.h"
 #include "string-list.h"
 #include "dir.h"
diff --git a/merge-recursive.c b/merge-recursive.c
index ae469f8cc81..29911d98701 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -10,7 +10,6 @@
 #include "alloc.h"
 #include "attr.h"
 #include "blob.h"
-#include "builtin.h"
 #include "cache-tree.h"
 #include "commit.h"
 #include "commit-reach.h"
diff --git a/send-pack.c b/send-pack.c
index f2e19838c9c..0b5157c726a 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -1,4 +1,4 @@
-#include "builtin.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "commit.h"
 #include "refs.h"
-- 
gitgitgadget

