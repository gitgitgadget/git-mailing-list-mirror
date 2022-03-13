Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD993C433EF
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 20:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbiCMUPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 16:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiCMUPn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 16:15:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA2E41F87
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 13:14:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a8so29790392ejc.8
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 13:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EVYDedbsPLyuU4C9pndOMFGHXI1Jto8olMl0BSHlpbs=;
        b=RAd01dIhf/A4ouOs68Ncr9ItleHRZbav361EHvxMYMkQm11MMKtHg6zRO0URSmfmF5
         xVPXyjHOEdpAfFhle+MZoylmKCEBvDwklnlipN3P+xidecIv1FOuKo4yRaakncVaA+2i
         kKZyqHrbGJ6tMSjKz2PU/j7BIJi5QBdIGv/Ac9WLpmqvaiE6TtBRl2tlt8WUCatdG6+1
         ZdCfC8MQOI7btHXy70ff4s0GdENMvLofUXAO3jD6URgA+6ZU3BAvFUU/4NeKhGNmJGCt
         0Byfl5ttDB6zsc4N98M6QpW745MZA9ZIZOM4qYNX10tXTEwigrV7iIrMkPzZOtabAcaP
         Tz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EVYDedbsPLyuU4C9pndOMFGHXI1Jto8olMl0BSHlpbs=;
        b=aR5qOpYsKKIPolFawkGlQ/kZ/Eu3FNfc6LygWJYcvICIAuz1Ss0JqgzuH+FK46D6DQ
         0FDmLkqmLmsS3T7/KyuIQbbogPc8/zyRs/Q2kItnbZSR/QCXOcpVvXUGe1s60bIK/07e
         I1HnoGCDbalBzCyWgkS5Bxl6c5bgsoEKZk4g6+nRubFiz3CvRPXI7oF1akI0z/kHpOGU
         LzFxUsCfTJ4CH3eoCYA9IvGSn6UpMOZ5Mid1Y4Tt3sSPkFbQrKQrJxzXFrEIQFg0tZCQ
         4x2vcu9qVdjakSzwjoX9TCuf2H5VrnWzWxo4rU8zw7J+ei3VHnpYhlXT4fZbF+SxVG4V
         j0RQ==
X-Gm-Message-State: AOAM530iu95i6tRxVXgk4RLtkRl0YeslRcP9I8NBDKJnXar4NG0WL/oC
        uzIfI5hdAgGmONNwnVMhKiCD22UDzPA=
X-Google-Smtp-Source: ABdhPJyrmU4N7fUz/E14fYUlzxDtxM2dpAsO7oonYiwgb+THaQz+WpLRNoRmsKxdoXFG/4JHhwFhCA==
X-Received: by 2002:a17:907:e89:b0:6db:af1f:5e22 with SMTP id ho9-20020a1709070e8900b006dbaf1f5e22mr9481643ejc.649.1647202473569;
        Sun, 13 Mar 2022 13:14:33 -0700 (PDT)
Received: from fedora35.example.com ([151.27.250.86])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006b2511ea97dsm5875395ejc.42.2022.03.13.13.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 13:14:33 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 1/6] attr.c: delete duplicate include
Date:   Sun, 13 Mar 2022 20:14:29 +0000
Message-Id: <20220313201429.233240-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

dir.h is included more than once

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 attr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/attr.c b/attr.c
index 79adaa50ea..1626cade8b 100644
--- a/attr.c
+++ b/attr.c
@@ -14,7 +14,6 @@
 #include "utf8.h"
 #include "quote.h"
 #include "thread-utils.h"
-#include "dir.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
-- 
2.35.1

