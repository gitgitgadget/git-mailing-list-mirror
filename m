Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89677C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 07:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240101AbjELHFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 03:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240105AbjELHFB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 03:05:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEE9100C1
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3078aa0b152so4688450f8f.3
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683875093; x=1686467093;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMWriJ0OuNHjnco3Nszsts4hpG5trxYTLvyUTcR/EWs=;
        b=KIZd8NH2klsPLWcJP9iIHUPTDw/+ifuRST+DRYng4EyIIvIDNtM1gLtpL3X1k5FOJ+
         /KOBZEevmJhtVI0DcsDgow3uW/Q7gY8tyX8C9dXw6erzoAbrAM7pMr7yDdKwaeWux1iP
         edTLGvfT+fHhOPIsOfvUyqtuzanM0agN8oV6Wa+MsP25X9uIBYcGUJ3uIMnnKhtUYpHJ
         6Wkoy6Ijkx4tODGe+ho6sVpsZY3odcTyOH7pK4lkkOK0uGPevpJE5u7ek6Qs8M3dMjLL
         rdq7V/xID1aZHjSGBV7SI0p5VOZHAofKL7jJTYdPIN0QfiyQntZBU6hC+eFU0jvYAFTj
         sI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875093; x=1686467093;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMWriJ0OuNHjnco3Nszsts4hpG5trxYTLvyUTcR/EWs=;
        b=WPmMk5CpGm92vP9St+vYMMGSXqLyaxC8Pyk5/xPJtWG/i37xFKRF/+ukcEKIrc0k4v
         Ag+EvQvsvVnKDivL++/oKu0aS6vXfwDSa9OPV1traThjEMUyFasD8svsQb/h9SnXuGJj
         XwV8+cXBNk3fSEaHlO+T9rCqB5JPUjkaMlCWcb/LifhUdSaqVLfXRgfIwOBkmuwyXJ90
         b29E17tazaSzhGzjWhWWuRbpiFSp3MUziGAbv8JHXlHuL1/cwuPAIBAwQS+GWzdNR02Y
         x1QK+Ukoy0r7PvGZwBCNLS3OcuWNIvdRMr0IWIxhDT0RJLNmi37/DDslGuMica+w826n
         Cu6Q==
X-Gm-Message-State: AC+VfDwjTpnV+1DdZSrOvb9AnfZbCLKIR8obiiclQhPq2qdQWZMtLceU
        iaMS5Bcp5oCw0iS1j7sBjCPM3L3Wn+M=
X-Google-Smtp-Source: ACHHUZ7wMhKOL+vR3ftRpIZIdB3MwLRUoHGSfXCj9fy41GGzx4+/Bz1JITYLgWsINFQMSShOzcRQ7A==
X-Received: by 2002:adf:f142:0:b0:306:3435:f85c with SMTP id y2-20020adff142000000b003063435f85cmr15974582wro.30.1683875093245;
        Fri, 12 May 2023 00:04:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k9-20020adfe8c9000000b0030642f5da27sm22404271wrn.37.2023.05.12.00.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:04:53 -0700 (PDT)
Message-Id: <b8f302184fafd68b501af8ddbb5e2b9ac62efa3f.1683875072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
        <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 07:04:22 +0000
Subject: [PATCH v2 21/27] list-objects-filter-options.h: remove unneccessary
 include
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
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

