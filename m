Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC7CEB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 19:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjFTToC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjFTToB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 15:44:01 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05AD1726
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31114b46d62so5235637f8f.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 12:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687290239; x=1689882239;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+g+cseGWF0n6yWo2TnbosWxiSzW8KXbJjRoZoq3BCE=;
        b=BHGeEjjYcf/1jkOsDM1mh7DXZ9WWToQ0cRZXeM8A9zvczwaqsBVQoTQICi1ATOae/C
         hjAZXU9OBcWZopr0D+69f8szJAQne7o2OKBvYeD2wFuTIMihkaFCO4nm80xWKea/Rukp
         5XCvqK4FXE6hhx3nx1FnGs1WlGddkMP6wnqnTPZ0XKeA8Tsbp75miv/4bHQuFycs8Nn2
         ScUQ1t5SNjSW2MVAl1Oth5vofwgmyu6bTwQqH4a9PJEI1xDe+bK0vN2J4q3oKnc6rZpI
         zlRhdYs7ULQsTIYDW9oAH7nMmBmOOQ3eizNue3Q0YWW4/8H2lY1h21v8pqLHcq+h+I6Y
         UVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290239; x=1689882239;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+g+cseGWF0n6yWo2TnbosWxiSzW8KXbJjRoZoq3BCE=;
        b=RGNUtoEwdA+qZQkr2yOvBkKmyaYO8QCOwlQnydFr+moPSMUSc5xf7SNTuBFBJsiD+l
         yO06QqncC3rhK09bAF719kuQtK6L/RFudrYwRfGOB2vw91sVgFQaL8gcc6L+iNeL/wf4
         Pn9CBmVNH9zmfsbIFxkf51XPkswmXhETuh1f/UeDY7LOhIfj6KVQzY8nNclqPtgQlSBg
         UGK9qNXsivWFJJVlVOgBKW6bEraHjb6dtuM/WcdYR+KjIfERZ3JFbHZXeQuBsOrH2hO4
         s7gr+/IRBZF3T89E2IDvhgfXII2XixX63kDenYHXQ3nGbKKiqup9bJtMKqKA5id6WNEM
         mueg==
X-Gm-Message-State: AC+VfDxxvFRH8RNrGwJHH7jUA9xO1V3t7LYYZubxtu/QGfaTeodLi1z2
        5cbbUXp3jegGZHRLiltKKMn1FB+8qp0=
X-Google-Smtp-Source: ACHHUZ5v+zRc2AzPYgV/UDaV4Ww9V1idSbe9S1T6v4s4s2UMUmEbWmXOC72ecHHPICgjyFUYfFal0A==
X-Received: by 2002:adf:e6d2:0:b0:311:1d4a:33e6 with SMTP id y18-20020adfe6d2000000b003111d4a33e6mr12237886wrm.48.1687290238619;
        Tue, 20 Jun 2023 12:43:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18-20020adfdc52000000b003113b3bc9d7sm2621456wrj.32.2023.06.20.12.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:43:58 -0700 (PDT)
Message-Id: <1aeffcb13956988dfb7b925f89bbe9c8503cb143.1687290232.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
References: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
        <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jun 2023 19:43:41 +0000
Subject: [PATCH v3 02/12] urlmatch.h: use config_fn_t type
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
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

