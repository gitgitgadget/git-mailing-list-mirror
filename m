Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52713C77B7C
	for <git@archiver.kernel.org>; Sun,  7 May 2023 03:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjEGDre (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 23:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjEGDrG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 23:47:06 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2F218FD3
        for <git@vger.kernel.org>; Sat,  6 May 2023 20:46:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-305f0491e62so3090929f8f.3
        for <git@vger.kernel.org>; Sat, 06 May 2023 20:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683431168; x=1686023168;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMWriJ0OuNHjnco3Nszsts4hpG5trxYTLvyUTcR/EWs=;
        b=R0eP77g38/k8Y9MYs3bWezRJ5AC33Nc/p5cdfzoY/uIAwjI88wJ42sDZS1e9WC5+YJ
         rEEd+A9iVl3Ai5VFJZ1n39kkFnkyYkDTocofmx1gFxX58og/ASwhm5G9QC3vflKHqY27
         OKHwH8bxYtiCGeVgohcWDUvK5bOXwAR0xuJLibGdnZ7Yp22CzNNnhOxiS4/h5u7hl/AM
         Fl2ojAL4jsAOb3OxZt/1FXt9An7dLLkwzWhh2TYBqoPLKjHgsHS2oCrivmi5jGwCKxVT
         Y9cE/JS7rgvj5nlFwhZu1V4s418KdZ9CoT15plwfJaB3MAU2M9wX8jSA+0TeaeolHrmw
         Au6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683431168; x=1686023168;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMWriJ0OuNHjnco3Nszsts4hpG5trxYTLvyUTcR/EWs=;
        b=MN7uaChymzhQlI0piL3HLb1FApceFpXilO5MB3FxwboAcf9JHbcJw/2CMaLoJchO7g
         T03Ao0COZ24o16NrrQxDSlX207Vg7MZO+wSzh4X6YTybMbgUZfh1KIGyaAiWFW71orwl
         FVP08OhYjcCZOD1xh3NX9vuJuJKwHuvnvk7gfAJF/uPlk8Jqm+F5TTqadUEguZkX+UGW
         MRx5zgk03WDg+b315XgZVGsThtoUVUoLh6peAF9uBiNFxlo5yo9uZyMsMKsqCQS/aCKe
         /a5I8ypB7hlKGUruMNRkYEtWbewsf3KQiXSITZvLgYZr2ASbvWt04Qh4ycbJi++9kWLz
         uuIg==
X-Gm-Message-State: AC+VfDwNqp3PFbeKJYzfynzQxwlpz1TUspMn0ki8O9F7EfcJmzGSPLy6
        QBKSSRAEvI0Hk2n6wfGTPlIYiCQw6rY=
X-Google-Smtp-Source: ACHHUZ4WC6vdzyr5mA8sIaElIA0ARqYz27kqaivB6flLCh8Dnp8EF/zTIEsIC0bOSM5/roBmTqtMzA==
X-Received: by 2002:a5d:68ce:0:b0:307:88ff:ea26 with SMTP id p14-20020a5d68ce000000b0030788ffea26mr2033570wrw.25.1683431168170;
        Sat, 06 May 2023 20:46:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b2-20020a5d4d82000000b003078681a1e8sm3966378wru.54.2023.05.06.20.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 20:46:08 -0700 (PDT)
Message-Id: <5e6ecb0256dd3fc7b3a00b2e1a179bf42f5108a9.1683431153.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 May 2023 03:45:45 +0000
Subject: [PATCH 20/24] list-objects-filter-options.h: remove unneccessary
 include
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 list-objects-filter-options.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index f6206125868..55fab8563d2 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -3,7 +3,6 @@
 
 #include "gettext.h"
 #include "object.h"
-#include "string-list.h"
 #include "strbuf.h"
 
 struct option;
-- 
gitgitgadget

