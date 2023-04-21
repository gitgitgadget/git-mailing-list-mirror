Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755CFC77B76
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 19:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjDUTNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 15:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbjDUTNa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 15:13:30 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243D81FFB
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:27 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f17e584462so21345285e9.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 12:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682104405; x=1684696405;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+g+cseGWF0n6yWo2TnbosWxiSzW8KXbJjRoZoq3BCE=;
        b=sclxW8axBwIB0Oip4dDaQy3CzRMvXuqlJ9PXddUgM9tW1q38GwEDEShSFji02aRp5m
         MeHhD+kYXwBDSMXUJzo4MY+0V2Xs0k0yfMDn7nzIaIRS8tW0zCGlaPUn3mm8IFOyHTIB
         RCsST+mDWGsqpE9+O5iitduC3iHIsBoe5IZUal0W56QFLmypxArj13ZZgWTe8vH75yWa
         39NNbdwK/OTioRmf/kk4Kw5QwQg3xpQKi/S0efzfaLaeXV0Rq/vAxmun2DpmHZPN8djE
         Pr1wIrkXmIkPwzp/kNent7nSyGBM0INc8jn1lIjsAa3VEjjsq818nJ28Xg5ceUKQ5x+5
         0LUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104405; x=1684696405;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+g+cseGWF0n6yWo2TnbosWxiSzW8KXbJjRoZoq3BCE=;
        b=HkK5LE3X30s4Oo7mnQ8djHVVvfEl5k9HNO2rADZ6GOHvPZv/es6/wMui4+XxsRg6jU
         DH1TC9ATROETuDh/N7aAuD4FGzT/SutSCsr2OX9m0Rnng+PnLKGnCePIpjHhUEhY7aQ0
         0qbhbsGwDtUUrtuZv8Knndccd2dS61y+zYiAkP0rHM0cm4/j7F/yN4rs470a6jqmRs/Z
         Wi8Qj7+Jskk2ymOZxxcdHqDwvFrr66W99rlEHWztKgX2eD9YW7zUQvJ2w0nNO4g74WVx
         Sa2egL1rcP9uXO74UYCpyibNOpwL9fJU1IPeJfFX88E4+HVJOAMwvzSFFhar0mX+zf8u
         3OQA==
X-Gm-Message-State: AAQBX9eyIEzcwFK+SezBptdoT3tQHLOpoAf5+BAHCCxyJJUtablvi6T8
        4dYu3TkPkqI26tHCoOHcVygXZvuMVm0=
X-Google-Smtp-Source: AKy350aUz0KCYPh0uN1LJimceCJBlEPHDKqwkxWYeQy/k2TnZm6tUhvbWZvGniax78XI8fsJUUBIKg==
X-Received: by 2002:a7b:c003:0:b0:3f1:885f:2e52 with SMTP id c3-20020a7bc003000000b003f1885f2e52mr2571398wmb.16.1682104404664;
        Fri, 21 Apr 2023 12:13:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8-20020a7bc048000000b003f1952a4bdesm1764569wmc.26.2023.04.21.12.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:13:24 -0700 (PDT)
Message-Id: <e0f43eafa07ae39bd6966309977cf36bc2f5131e.1682104399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Apr 2023 19:13:11 +0000
Subject: [PATCH 07/14] urlmatch.h: use config_fn_t type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

These are actually used as config callbacks, so use the typedef-ed type
and make future refactors easier.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 urlmatch.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/urlmatch.h b/urlmatch.h
index 9f40b00bfb8..bee374a642c 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -2,6 +2,7 @@
 #define URL_MATCH_H
 
 #include "string-list.h"
+#include "config.h"
 
 struct url_info {
 	/* normalized url on success, must be freed, otherwise NULL */
@@ -48,8 +49,8 @@ struct urlmatch_config {
 	const char *key;
 
 	void *cb;
-	int (*collect_fn)(const char *var, const char *value, void *cb);
-	int (*cascade_fn)(const char *var, const char *value, void *cb);
+	config_fn_t collect_fn;
+	config_fn_t cascade_fn;
 	/*
 	 * Compare the two matches, the one just discovered and the existing
 	 * best match and return a negative value if the found item is to be
-- 
gitgitgadget

