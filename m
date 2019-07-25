Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF74A1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 10:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389951AbfGYKQd (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 06:16:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41663 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389934AbfGYKQc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 06:16:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so22528826pff.8
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 03:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qmOdBYtr2dTz71XnFumyHgBktx1sgLDFQuGwjf0xq9w=;
        b=PDZM6V3k+yzqLbeSXzFD9CXCnod1BUgCCWkvw7QO4SbGku0I05QMhporoLnuxtffK/
         wjICv0150UylJdqt5v9WvIoxioLvvcAhqdWxaD2BOyaPSzqpWQ4zwoc7e/6RkaYQZysB
         9nHylCDrlHy1r6J5VqftPQHvv2rllPCBjyrmW2cIoD5UV/fLMqwDxoyBmWAZITp1SpmN
         v1/g+3oe7wO6GFkT57L803D9WlC1EDRh93AnMP+XSE7Ol17JPXiik0T0J9NWGLwbuEuK
         r3s44oNxJj8Y3WvXTCS3USpCxn5IM0dP2VkeucuJvXskpxNeJx6esx6WaBn5Rk557bJp
         LbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qmOdBYtr2dTz71XnFumyHgBktx1sgLDFQuGwjf0xq9w=;
        b=bsA3Huxo1+iAy35cAZ63HYzdn0UOPSBFXWn6f+qjv1eI1uNNYNFPqnMnCUP9+hBTIh
         DI8v5tAXBqm0BVZ2ILGf9hjTrRboICYaArQMCIFPnsRsl0H4Yx+wwPyerPKzCPi9sFnD
         OD4SM3opAnd+LrGu9OjSs4HOuUerjPjJ4kbh9GYkmo+tKaUPy6Xy3b1ViAQoVnA8Z1Va
         ej/Fg0ATmEJ/vV5PNeUS16yhEO7c0wl4u3w/kqvK4gLVV5OgZY3Y5bWa/jYSk1AqZAhH
         xn3pJeUTgRSUvKyBVbr3uYd/NSur1kxySePb82OJVsa917OF4GFRiSAGFJUttlviCXl3
         vDaQ==
X-Gm-Message-State: APjAAAVM7jIDpy75GNxbUPvLSSu7Zx+N6R2tuHX0UO6IdrJDMRwIEnlh
        nbXuDgA/aHO3DGR6Ee9sOLQe2rqMp7w=
X-Google-Smtp-Source: APXvYqzVpltOgpyFcQIs2CFh0cbOuwoeIno+ikC8aYkji7Dy/5tiufKhXY/t3y/kTeGc531+qOs94g==
X-Received: by 2002:a17:90a:601:: with SMTP id j1mr90285191pjj.96.1564049791080;
        Thu, 25 Jul 2019 03:16:31 -0700 (PDT)
Received: from centos7.localdomain ([154.48.254.150])
        by smtp.gmail.com with ESMTPSA id a128sm54161644pfb.185.2019.07.25.03.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 03:16:30 -0700 (PDT)
From:   simon gao <simon29rock@gmail.com>
To:     git@vger.kernel.org
Cc:     simon gao <simon29rock@gmail.com>
Subject: [PATCH] stop it from failing silently when git apply patch and show err info
Date:   Thu, 25 Jul 2019 06:16:22 -0400
Message-Id: <1564049782-68817-1-git-send-email-simon29rock@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: simon gao <simon29rock@gmail.com>
---
 apply.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/apply.c b/apply.c
index 4992eca..f66a6ff 100644
--- a/apply.c
+++ b/apply.c
@@ -2094,6 +2094,7 @@ static int use_patch(struct apply_state *state, struct patch *p)
 	if (state->prefix && *state->prefix) {
 		const char *rest;
 		if (!skip_prefix(pathname, state->prefix, &rest) || !*rest)
+            error(_("%s doesn't contain the prefix(%s)"), pathname, state->prefix);
 			return 0;
 	}
 
-- 
1.8.3.1

