Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506EAC77B7F
	for <git@archiver.kernel.org>; Tue, 16 May 2023 06:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjEPGgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 02:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjEPGew (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 02:34:52 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBA34691
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:35 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f4ec041fc3so34270085e9.1
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684218873; x=1686810873;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMWriJ0OuNHjnco3Nszsts4hpG5trxYTLvyUTcR/EWs=;
        b=mOjzyUU3L9qrHZAtQ3NCUep0inV+HNPViIxjdes7u15WQ4z/OmZKeyotvoOrp+7KDW
         EeKZVTSL7g/dvGU2lRupOT2UDN2vpmVcv1/uEZ4yis9JNSwZI4c8bC4tJlel5TlGaYah
         HikbdTGuwnicwnDa/vYTQ+xZJFeXeD6WsNj4V/Bybs8+QRQ/heWl2ELQQ8FJgR0BWEur
         kAt04wtBjf3w5e7UCHThcKEzIYB6BTNvythJbETywPNme2oaTz/W4zCvmB5cMRNiUGcQ
         leYyDFXbJcFgyHQDHrhWGYGNCvzu9Kpxu/h0ooQw/bWfN9FPrjL06QBGOeSAQzcht0Dw
         zoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218873; x=1686810873;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMWriJ0OuNHjnco3Nszsts4hpG5trxYTLvyUTcR/EWs=;
        b=hQ3xkhVXs6vKS+yoNAQ9fPFBV7ZQ7YJKU+0CRo4XO7xbcapWXeese1gp6FDvYjgtu+
         w3IrWXe3eFOmxZJXQGEgmJL6GSyPhsEdWo+9RJsChciP0ITz0S9DjGeozQ8vwnwy1TSk
         HXczMeqegPdBm52UynsGTGMAy9ZTzE8EmJEFtuqOdM7UjBO/4fVODLur/l6FI6xt6025
         sB2gjIgrPgZQRBCyREmQ1u8xpzaVC4YGyNDKJ95SFkJ2A8wLgwK1MCILQtu2osiY5EJv
         TW0VBEiWKCpXERpNKi4leI1lSFpcB3wIg6ZYbIwZLQJTwUw4uzWmor06pmmF1bkPmRbW
         z7jA==
X-Gm-Message-State: AC+VfDxzQIgYpDwXaFZew4wEstyDwAA+5n5XmdAi4OX0x9SxqXC+z+rc
        RvztfnsfOriYBfP1bfUhcwpbHGL79h0=
X-Google-Smtp-Source: ACHHUZ5RrWT6M/cr0X6GhgyY51EOeOoUfFBYVt7A7HbKaychqLtlrYTHdogyc6WqQUpnPS4NB76rPg==
X-Received: by 2002:a05:600c:2904:b0:3f4:2c21:b52c with SMTP id i4-20020a05600c290400b003f42c21b52cmr17199694wmd.39.1684218873553;
        Mon, 15 May 2023 23:34:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q4-20020a7bce84000000b003f420667807sm1169166wmj.11.2023.05.15.23.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:34:33 -0700 (PDT)
Message-Id: <b9231a414f231cd072dd81b9e0fa9c74941af8d7.1684218852.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
References: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
        <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 May 2023 06:34:01 +0000
Subject: [PATCH v3 21/28] list-objects-filter-options.h: remove unneccessary
 include
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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

