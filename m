Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32694CE7A94
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 11:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjIYLvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIYLvO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 07:51:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68982103
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:51:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31f737b8b69so5251344f8f.3
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695642665; x=1696247465; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9CAKxJ/+D445dVI3YYXX+qm/DxlOx8hlzwKEMuHP9w=;
        b=gTv0FYG2k4GPp9FjtSbthZrtJWjzzMS7oA6EVYPIGAC9drPVZUh7pB9+41fXcDpzYs
         JfZqzR13cCN+qEPOAh7tzqjHFgiCnD1wscFeJM3Navzs8n6AlPKSfMbJEoo+x3Epuj5L
         hCvR8ElWsravcjupchsYEsR3eWWqwZSZLTetLtZkzu8exGt5rlUeil+bMH7dGTpCePAQ
         T0X8tckGSzSZDP9tS7BF7lrtx6Oj3vqJIUHfRPqXahyFTAAHiqOZi29Lz9XqBPb/tlGR
         0GStRYSqSWXcH5Npf4KeUeLzPpucsnRkcngdYzwsflJIce0e2b/oi2ukzKx9XtyjY8hG
         fFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695642665; x=1696247465;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9CAKxJ/+D445dVI3YYXX+qm/DxlOx8hlzwKEMuHP9w=;
        b=Uh645qlhX3vsbZtGtlbRCv6MSuIToPScaOioG8He2g5RldlsHsSF9hwdZcbm9wBT9N
         L8Kc+WFoYO9nAM5h7emORStt25OVOqBbfO3OCrR9z7XdsU5jixQBIbcrou3JjojfyoYI
         6LbJeU9JwXoKcQYvT1c2OJay3V9H+MtD20kDho+K+jpid+/FDsiA2AhMwwYV1ltd1P7e
         NlWtpknRy1zO6WwTx2CrbvsV1up2L6R7P3wcjWVtPPv4gnFB8gJdca6agBpNk5lFl3DH
         VHrblhaqhh4V+AwOsYrTUZZNX4zViG/vwLBqSP75j82fPlOxs0OU7O3kNEx4F/eDLJan
         vOnw==
X-Gm-Message-State: AOJu0YwT8Q9TI/Q4bSEnuuObPMkliV9MiDRZG7BRAJEG2ucu0xz7R6o6
        Ac9RtmuXjxOd/R7TGnew9QowS7P2NL8=
X-Google-Smtp-Source: AGHT+IE9XF8l9mxrdZS/8cRXWYa1DlTw1FNTpsB/3aZfBQUHUihGUwOawuaT7rp4Ie1TnB3tv5lrFQ==
X-Received: by 2002:adf:e4ce:0:b0:321:6414:5869 with SMTP id v14-20020adfe4ce000000b0032164145869mr6787862wrm.58.1695642665637;
        Mon, 25 Sep 2023 04:51:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s13-20020a5d424d000000b0031f729d883asm11655219wrr.42.2023.09.25.04.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 04:51:05 -0700 (PDT)
Message-ID: <ea85e3512335b5cbf52a3bb2c37ff1c15c04a1a6.1695642662.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1588.v2.git.1695642662.gitgitgadget@gmail.com>
References: <pull.1588.git.1695379323.gitgitgadget@gmail.com>
        <pull.1588.v2.git.1695642662.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Sep 2023 11:50:59 +0000
Subject: [PATCH v2 3/6] coverity: allow overriding the Coverity project
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
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
index 4bc1572f040..55a3a8f5acf 100644
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

