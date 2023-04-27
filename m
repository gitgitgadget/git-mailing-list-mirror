Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC04C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 22:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344221AbjD0WWf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 18:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343660AbjD0WW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 18:22:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F49C30EE
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 15:22:27 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f19a7f9424so66850065e9.2
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 15:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682634145; x=1685226145;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQjdAUQbBZ2dyO127HApmyrM90hBdBX7eLKH1Ns4a9c=;
        b=rf1oYXg20sx9BhG9eBZUeQywi6t/MtAN66w+gwUW9dbnTzCUYkhTk1trwVUKD00uE6
         meGojG4D4suYCiNix3a4xldAsSurmjaoehD1bX8wftH9p/6zg3+j2vIDcF+zAYkbuCdG
         z+SC6D2+INXyJAUHFrR1rsx/7sQThjIRiWBAYVi1GW6LiVlh/x+5KmDCEgQMBS1amNEO
         pCDc1/f/1XN7OLyXloDhWB7EDKFDqqDwYqmFvtkAQo6X0Vf+1r3q0WGuq8vWO3DpXALq
         lzL2uwXzCeUcAGuBj1YXNN77k6KztSx1Rzf5bx61eJ/gJjGS69iabTZ1xqSdUNf5CotS
         qfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682634145; x=1685226145;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQjdAUQbBZ2dyO127HApmyrM90hBdBX7eLKH1Ns4a9c=;
        b=LAi/t8XeAYUB6/88+JCjIyFfpMdDnyk1p93L6zDv30siE92oZ3XkK8aIOacwn5JJRK
         7X/zQxfBrmK0ddtSqt8g3dEj/sEciDn/a/j3Qxs6Naz5Ff8bXXdvOQx3Kwk//WHrVRd2
         WfM1lJdHNuU9MO2OTshHmKBnT2p+fBlJ7fqiEmS5tiA0bkb1kIJ3VAJ0BQzamqwpljR2
         PiLcMRnbXbY/MRtOjXMq1KDmNORI2ULGE6QLCF++ahH/LX7CVlxHde17ldpDgE8eWVyr
         WdHHDcSgajZd9q0ihkGO/I07L4YlooGMq+rFu2hu5vRymU2g14fMhQs7XBn4PHisFif8
         JrwA==
X-Gm-Message-State: AC+VfDxH5ip6KcDSre+Sf1uUCtR3E1XlmJpF23a5WyvlPrX4SDqLTPNw
        geMfCOvQXIbFWuPeEj403OpesB1wbu4=
X-Google-Smtp-Source: ACHHUZ458ltQMJgjrFlIRfRM5qRVPB4ouauhB06YBcpL6GuAIAGcNfJ1Toa0ZNiMNyB1hlMut17YHw==
X-Received: by 2002:a7b:c5d9:0:b0:3f1:8992:3618 with SMTP id n25-20020a7bc5d9000000b003f189923618mr2577735wmk.13.1682634145378;
        Thu, 27 Apr 2023 15:22:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a18-20020a056000101200b002e61e002943sm19528907wrx.116.2023.04.27.15.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 15:22:25 -0700 (PDT)
Message-Id: <4a8b8a2a6745e791e35296e34f530b5f40f51c27.1682634143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1495.v2.git.git.1682634143.gitgitgadget@gmail.com>
References: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
        <pull.1495.v2.git.git.1682634143.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Apr 2023 22:22:22 +0000
Subject: [PATCH v2 1/2] cocci: add headings to and reword README
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

- Drop "examples" since we actually use the patches.
- Drop sentences that could be headings instead

Signed-off-by: Glen Choo <chooglen@google.com>
---
 contrib/coccinelle/README | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/contrib/coccinelle/README b/contrib/coccinelle/README
index d1daa1f6263..9b28ba1c57a 100644
--- a/contrib/coccinelle/README
+++ b/contrib/coccinelle/README
@@ -1,7 +1,9 @@
-This directory provides examples of Coccinelle (http://coccinelle.lip6.fr/)
-semantic patches that might be useful to developers.
+= coccinelle
 
-There are two types of semantic patches:
+This directory provides Coccinelle (http://coccinelle.lip6.fr/) semantic patches
+that might be useful to developers.
+
+==  Types of semantic patches
 
  * Using the semantic transformation to check for bad patterns in the code;
    The target 'make coccicheck' is designed to check for these patterns and
@@ -42,7 +44,7 @@ There are two types of semantic patches:
    This allows to expose plans of pending large scale refactorings without
    impacting the bad pattern checks.
 
-Git-specific tips & things to know about how we run "spatch":
+== Git-specific tips & things to know about how we run "spatch":
 
  * The "make coccicheck" will piggy-back on
    "COMPUTE_HEADER_DEPENDENCIES". If you've built a given object file
-- 
gitgitgadget

