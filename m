Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB8DC27C76
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 22:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjATWJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 17:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjATWJE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 17:09:04 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A4AA7301
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:09:02 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r9so6012718wrw.4
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 14:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCY5CaeVsGFH4YCKVAhrjSkUdtoSk2eEGMnVuvUbaAA=;
        b=B4UrI/jMnX84i7g4eryKywwkDLkJMrPZYak1NfGTP3hfkYd34pdAgsPAy896MEqFfw
         8KtsKyip9fHSwTSR7P+sOwxFZVIw3yK2wlGH/2DF7vpRn8ZaUkZmCT5HV6ckSbBzUE3N
         fbtFU3qfSP5HWooolw6LbAIOrtI6piUJBInCY8b2Td9gNqsACdJ1KY9Bpuw2iN3pDl+U
         HWF3+fYQ73QvjE8RUoxP9dpbuebwFr/ZO5OlcI3Hu2hMD0p/RNUVWYNMZXFcTExUTEQH
         GaeysZ2hQLr6mfp9mYqsCATpAr2i0zQovSEOjj7H30XVjXhzjlNwsmLrEQJLMl3XAwrH
         3cMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCY5CaeVsGFH4YCKVAhrjSkUdtoSk2eEGMnVuvUbaAA=;
        b=sHkpQT4TXzvxQkzE39uD7IyqiIo+KMqmIznZSoh8xNet7BzZEOJVIXjoBXJeJhxVSN
         d2VzhuGXV+J2+1sTUpgr5XpwIqeXdn/plNz9KEKhl7Ll/Lq6N5DLpPaUWNdyW+Wk87xx
         k6r6b9/HMuyFQprGUzks4zdhYt0pW8lcwZGALF5NmKJV6b9UtNjbXkqEY1W+P8z3t5lL
         MwFoNwr4bdlordrlfdQgHcHMlFV2mzNAImW0udefVv06gUwV7CxgMY4/Al+KzHi5zaqq
         VlvOfPlXS1UM4vEY2JTKcjQv9iqLu+z9M4l5RucfVVTw48GGV/AjelB8QY++XMV1Bbvm
         g4Yw==
X-Gm-Message-State: AFqh2krE+DPTNqQJ7/HnttdPGPf1jqAU6O8hV5Ye+K6ecXOmCPuXTx7Z
        ApN9VN+mVbKJARBgZcQusG2yUpJQ39s=
X-Google-Smtp-Source: AMrXdXs2yC5jIyathdyeNSnJXScAXAxHZamk1hVs0EFb68Nu5SJFSr7amaNdyvr5q5BV/zCyqzueOw==
X-Received: by 2002:a05:6000:384:b0:2bd:c83a:6e3 with SMTP id u4-20020a056000038400b002bdc83a06e3mr10087528wrf.7.1674252540907;
        Fri, 20 Jan 2023 14:09:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w5-20020adfcd05000000b002bdc914a139sm28332160wrm.108.2023.01.20.14.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 14:09:00 -0800 (PST)
Message-Id: <4b1635b3f6968f8d755bdf6bc4ec7af77aefd315.1674252531.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
        <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Jan 2023 22:08:48 +0000
Subject: [PATCH v7 10/12] http: replace unsafe size_t multiplication with
 st_mult
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Matthew John Cheetham <mjcheetham@outlook.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Replace direct multiplication of two size_t parameters in curl response
stream handling callback functions with `st_mult` to guard against
overflows.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 http.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 8a5ba3f4776..a2a80318bb2 100644
--- a/http.c
+++ b/http.c
@@ -146,7 +146,7 @@ static int http_schannel_use_ssl_cainfo;
 
 size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
-	size_t size = eltsize * nmemb;
+	size_t size = st_mult(eltsize, nmemb);
 	struct buffer *buffer = buffer_;
 
 	if (size > buffer->buf.len - buffer->posn)
@@ -176,7 +176,7 @@ curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp)
 
 size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 {
-	size_t size = eltsize * nmemb;
+	size_t size = st_mult(eltsize, nmemb);
 	struct strbuf *buffer = buffer_;
 
 	strbuf_add(buffer, ptr, size);
-- 
gitgitgadget

