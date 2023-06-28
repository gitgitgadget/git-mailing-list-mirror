Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00F3EB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 19:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjF1T0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 15:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjF1T0k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 15:26:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3201FF1
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 12:26:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-313f3cd6bb4so197113f8f.3
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 12:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687980397; x=1690572397;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+g+cseGWF0n6yWo2TnbosWxiSzW8KXbJjRoZoq3BCE=;
        b=VutcRO/HQWEBbYbWEt9w+14g5J8FqDS28HfG1320Cajjz5zpYIwzlTpuOUfUxIRCQn
         XC6Rj4C/BbZmktKzYf+uGpxLIM6bSbsbYcoCkEGvhjH16YGvSC6U7AUXVZwtPyliv7Mw
         TQ8MBkcZ8FaEhwcrcD5XsU6nd1ML7BhjzI50nURZ5KgBc3qOZ7VjiKXZH0UlKqLC2Rz+
         oDDulBpFOucqG0tmxiK6zYVkJIjlrQ48gkfsq9bAl3Otm3JkFWbJkI/s00eggJMY67de
         r9/4kwokqABGmqYtoD4U+P/7T6zxV76JE3Ae4nkTbjFUClredCK3SFYFW2hjWsscaOVs
         sD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687980397; x=1690572397;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+g+cseGWF0n6yWo2TnbosWxiSzW8KXbJjRoZoq3BCE=;
        b=fvTzUvP43wBJlZw07t0GKh7MoKGiCG8gCpQzXABje3eWf3b4GL8J/VWQekxRl3oozc
         4OIE/7JQtaUsx3CftJMIv9svL/8o+BQH+iMTzhGiIquEgiAbWKwQ+Smp8ID1T2tSN5wS
         xRahEGIdQxzltIeQEKjx0An2U6NtWGbvudUNuZ4OnooWQEjRXFN77xp+uw5GxqFK1HUx
         ZO6G++UPdrR82FdyLalufBWMFstsz9Ci38Xn8UKnBk5RAaAoc3ubhPzyrLfn7V+A2vrc
         hdTU/rzIWnD269CKZnT5yLt9aN/7jJdAyvpjXkBPTLZ6zCgbSYqMeoxBHvLQL9TQ8z7d
         fhXA==
X-Gm-Message-State: AC+VfDzbwpzJFkZ5XroNyNUELGjAK56/b9yUryf4KdTZqnGIerPHP3JJ
        ooIH1A4TVbblyulW7SINePdRBWM5LlY=
X-Google-Smtp-Source: ACHHUZ4xFWTcHViZ1rrSIHKFLpmhieoab97XPpjudKLLF05d4yb3Vi/IUBr+scvDc+hBjk6q4jMQlA==
X-Received: by 2002:adf:fc8c:0:b0:313:ff14:6de5 with SMTP id g12-20020adffc8c000000b00313ff146de5mr4433953wrr.55.1687980397531;
        Wed, 28 Jun 2023 12:26:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id da16-20020a056000197000b0031274a184d5sm14176569wrb.109.2023.06.28.12.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 12:26:37 -0700 (PDT)
Message-Id: <739c519ce625caa0fe5d0758b707ec2828c37ac3.1687980392.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v5.git.git.1687980390.gitgitgadget@gmail.com>
References: <pull.1497.v4.git.git.1687803083.gitgitgadget@gmail.com>
        <pull.1497.v5.git.git.1687980390.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Jun 2023 19:26:21 +0000
Subject: [PATCH v5 02/11] urlmatch.h: use config_fn_t type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Glen Choo <chooglen@google.com>,
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

