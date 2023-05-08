Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37018C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 17:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbjEHQ77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 12:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbjEHQ7w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 12:59:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E10659E2
        for <git@vger.kernel.org>; Mon,  8 May 2023 09:59:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a25f6aa0eso9115458276.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 09:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683565189; x=1686157189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mWG/+S0pEkG9Rcz9k61ni3HDuVyEZnHiCAyEi7lI+0Q=;
        b=UNTOGk+yiueZ0RsSvzmqrw/CqjE2FBjhrYBvG+T/RiK0gauWTNnCemPgcvFYXn4B+d
         P9j8dRkqyK5lYenO5UwSvl2g9uHAVGbukhQhl5FJYD2CSAS4rpzftAYl+hoFuB+VKkQd
         OCLXzREqSkwlpUAj7KiZzqTasfsnUnT7lBBHW5blLNLxi9YWlEGL5YN7O7v8A4cTBzBk
         QqXytE/0obvxspQIwwjNLL7SKqSeDD3eAzZr7M6NLvzA1n6jdkb+SEGvjCmB8NlnrE30
         Fou/oip8zD96402VXsznlSavwGsf69PlY7Sk1FxFwFHkHKSQ4fkTi6Rq+E1MLwJTQ41v
         fUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683565189; x=1686157189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mWG/+S0pEkG9Rcz9k61ni3HDuVyEZnHiCAyEi7lI+0Q=;
        b=eFZUll2Y6DHNukjaDfLFxS0mGbkzcp0Q5I1EfwiCPZ9qyb7rhkLS8svak1F6IIVM1D
         Kb3GWoe8QIaB6HAxNtaLVPw9Nzdk8BMi1o7FawZ/oB1eq1hTB6ls0XOf/m9NlWo2S4KQ
         NNt7tlOuqnJylehXx5jifdLoidusCvMomCAowoK6Z1xPzLzFXFNPR6m6c8h2dtyAFuVE
         uBarvYPS3fnkAg4eOCiwkJjRwJsLEE19hJun0WK9KwldzgfWe7QsjbELkaVh+zPzRjfg
         lv9PoBRJgpSkmnZ8iTLCrESMNECIIXbnPXfJbD07OqXu0RJzGBRgtJdT5QhJvykqlOd1
         bCLw==
X-Gm-Message-State: AC+VfDyZs5djB5Tun5osljbvITQStNRgu3dFyybhD5UstHgQA2z354Dk
        d2f4H9Vl/vcmT1HP2gApXqIL6p+kbHXjlKuhR77awR04Ye8w/iclI8Sk8/J8TQN4E28hYhyo8ui
        Ddb59CUyfpgbPEYq7nIcxtScET9HhgESiODvsWmBGvCZtaI7JYKqtWfoKy2MuEW03kA==
X-Google-Smtp-Source: ACHHUZ6HpI0mWb7nz2agd//yTYH5OP7MqZrWl7rr8arWTkx/5UmLjWRQgnsbUoqNdbV3yUXgSkiNBrNFBdhYsfs=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:1bd4:0:b0:997:c919:4484 with SMTP id
 b203-20020a251bd4000000b00997c9194484mr4745571ybb.6.1683565189650; Mon, 08
 May 2023 09:59:49 -0700 (PDT)
Date:   Mon,  8 May 2023 16:59:07 +0000
In-Reply-To: <20230508165728.525603-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230508165728.525603-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230508165908.526247-6-calvinwan@google.com>
Subject: [PATCH v4 6/7] strbuf: clarify dependency
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

refs.h was once needed but is no longer so as of 6bab74e7fb8 ("strbuf:
move strbuf_branchname to sha1_name.c", 2010-11-06). strbuf.h was
included thru refs.h, so removing refs.h requires strbuf.h to be added
back.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 strbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 178d75f250..d5978fee4e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -3,7 +3,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "refs.h"
+#include "strbuf.h"
 #include "string-list.h"
 #include "utf8.h"
 #include "date.h"
-- 
2.40.1.521.gf1e218fcd8-goog

