Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E8DC77B7F
	for <git@archiver.kernel.org>; Fri, 19 May 2023 04:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjESES3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 00:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjESESI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 00:18:08 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169B81702
        for <git@vger.kernel.org>; Thu, 18 May 2023 21:18:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f423521b10so18080025e9.0
        for <git@vger.kernel.org>; Thu, 18 May 2023 21:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684469879; x=1687061879;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZcciXW4bVnfpjmGETKlCSrBasg/mBXiWS+E+hIM5QU=;
        b=kAN1DVjA0DUW3jkq81IrQZKVLEmNsPHqDf7Y647MbF7b4KNjxUTawKwA4hVKz+01Og
         k2yaMbMi8MfTpzIs85v2ATVgwWNmkB3zKIQ5jtrEdvXFoLOQZlviJtzTxJlJQ55jKpNi
         DfMODc7N0Gp+wCvVK9a+TxuArGd62nnv71d2cZkPCe5uH/08sde8wmxDExseAO6UddAO
         5/5Qn/JVGrt+Aswh45iTmW78KX5U3Zixml3Nv2+DgSZ2yJUcPczfl2BfyZGExpWiFFQ7
         dLqCtUHiuTtHtU+iD4MV0aCYPtzMfFjC96jOt1LMzDcIPypsoTLP7mdGAcC40PQkrBvm
         ykfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684469879; x=1687061879;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZcciXW4bVnfpjmGETKlCSrBasg/mBXiWS+E+hIM5QU=;
        b=G4CmIkwd7rFf6x7rZrbrOVBMEORC8X5z8cGRgFn66EbtTkBtvgMg5O/d07jyiysV2+
         ir/kZW4dTafkSzt9UOkoy7Czb3Y1/59okiaTIWrEsZa36K43MoDXBrwqqSlSLVh90Yn8
         212MbbT39gHhng0h/tkl1hIfaVfGS1V7CLdYMkGBkwSqnIHKIaSKuWFzx9iGkRuO6bS0
         vtotuusTrMmLAeTh1w0TAu6/G89e6/m7NC+clModQqBzdgngy7U1WXL1NjM2Z19rg/3Q
         oDtgmOCZsL9BVJwi6ZvzoDRO8sa+tyZFYMFtIL6EKJSNE18OqdXXUnXCQuX0KJufthOb
         KNNw==
X-Gm-Message-State: AC+VfDwysvPcVOQT0VHOFHT62GK0yZuy5oLElB7bdTgHBRUHzjLVvhxX
        0t2czV5VA9oQ5AJVWPaFzWw7ngXo0SQ=
X-Google-Smtp-Source: ACHHUZ6mGPOYYaPgk/n+qnCujf7NfJTlrwypoUuOAwzvxmAToPEOGY0bOyTTUMkyLTHuOTBkVLq5QA==
X-Received: by 2002:a7b:cb96:0:b0:3f4:1a97:ab09 with SMTP id m22-20020a7bcb96000000b003f41a97ab09mr238710wmi.25.1684469879358;
        Thu, 18 May 2023 21:17:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a7-20020a05600c224700b003f4e8530696sm961782wmm.46.2023.05.18.21.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 21:17:58 -0700 (PDT)
Message-Id: <cfb5dd0e87ec70247102e6d966c5e61962221d22.1684469874.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1471.v4.git.git.1684469874.gitgitgadget@gmail.com>
References: <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
        <pull.1471.v4.git.git.1684469874.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 May 2023 04:17:53 +0000
Subject: [PATCH v4 5/6] ls-remote doc: explain what each example does
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Allred <allred.sean@gmail.com>

While it's good to have several examples to solidify the output pattern
and generally demonstrate how to use the command, most other EXAMPLES
sections (e.g., git-show-branch.txt, git-remote.txt) additionally
describe the problem/situation to which the example is applicable.

Follow this example in the ls-remote documentation.

Signed-off-by: Sean Allred <allred.sean@gmail.com>
---
 Documentation/git-ls-remote.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index aabc1a7b90b..c0b2facef48 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -99,13 +99,18 @@ OPTIONS
 EXAMPLES
 --------
 
+* List all references matching given patterns:
++
 ----
 $ git ls-remote http://www.kernel.org/pub/scm/git/git.git master seen rc
 5fe978a5381f1fbad26a80e682ddd2a401966740	refs/heads/master
 c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/seen
+----
 
-$ git remote add korg http://www.kernel.org/pub/scm/git/git.git
-$ git ls-remote --tags korg v\*
+* List only tags matching a given wildcard pattern:
++
+----
+$ git ls-remote --tags http://www.kernel.org/pub/scm/git/git.git v\*
 485a869c64a68cc5795dd99689797c5900f4716d	refs/tags/v2.39.2
 cbf04937d5b9fcf0a76c28f69e6294e9e3ecd7e6	refs/tags/v2.39.2^{}
 d4ca2e3147b409459955613c152220f4db848ee1	refs/tags/v2.40.0
-- 
gitgitgadget

