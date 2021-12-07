Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400C9C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 17:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhLGRtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240170AbhLGRtE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 12:49:04 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE6AC061746
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 09:45:34 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 137so11452170wma.1
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 09:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GWnJo8DsA3QyYjaZ609A0ySo06L+a0P9CK9sPytuqy8=;
        b=nTP8+UhchTo3QQtxFsXRohtiap383Wa4RgZLBSrOuPPIX1UIlRdBTwsA7K/ENLTGuQ
         +DP9FXh7GmCOah0+SH2pwgPO/3F/mQPQFUZsp+PilmLAv3FXT+10rd7HrLVw4790uAJD
         TnATSJqORZNlnLvOIvT4mfKaglh9ANJTFfxp+cAcRwLwXWChSEuHxXZtpLeFsDDt5lZC
         ffNS1DdRDWpGBlyBTiNMFzU9WGgWhgPvF4ydlf3UPzbJcITtqhMFInwGbAA4RYplkBJa
         SC3iod/bl5R7fNbb5Ov6n2Cm2r1Ko3X2uN0YeSQ7yZSm8yRqGWbbEeRlzqQxnMad2ddv
         fysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GWnJo8DsA3QyYjaZ609A0ySo06L+a0P9CK9sPytuqy8=;
        b=kEsw0UDPTMcmrODZqyf3czvE9Jwq/L5q3IaA2YzsgLMun98cRQHf30Y/D78dmXmtRs
         0+ZOQ0Yv6KSatUUF8pZ31V/14mfCLE8PhiJCthgp1RqZH0oh3G91B9QTo4ygOuZxjO5M
         T/uAMQyuhVMxx0xvxlKtEEeLZoAGKwIVHs3eFbNxS+DXuh9fcRvuwINHqbmv/rNsk+OD
         0ZIGXz0G+V1liCbiJ4zH5Nnrfb7GBTW5el/jxcvYQY0QFJLTmccpFPN5TTiXlkiaCxf0
         6zKEp3PUAKpc/ZJ7JOiglBkHzxHGTwPyAF7FqlFA2mPOCWHdKhOQAGJj5u7QBodV12DB
         6W+A==
X-Gm-Message-State: AOAM5330eOJWSYJOWGHo+01pIRzfa4GhOODrv//vgxAPzXtbTcX8G1+2
        d2JCUIU5wFXUQ/2HIRtjGOzRdeY467A=
X-Google-Smtp-Source: ABdhPJybLwx2hb/faAddv4BA7DUDBHvu6gRNKGYb59iXGDu2gFTMBmZVnYJpRWtRQtN8VLe+rUNNZg==
X-Received: by 2002:a1c:8002:: with SMTP id b2mr8965938wmd.2.1638899132371;
        Tue, 07 Dec 2021 09:45:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j134sm297032wmj.3.2021.12.07.09.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 09:45:32 -0800 (PST)
Message-Id: <cd5d8d3607da67011c00b1c96a34a9ed30f541a8.1638899124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 17:45:23 +0000
Subject: [PATCH 09/10] reftable: drop stray printf in readwrite_test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/readwrite_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 5f6bcc2f775..7c40b9b77f3 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -597,7 +597,6 @@ static void test_write_key_order(void)
 	err = reftable_writer_add_ref(w, &refs[0]);
 	EXPECT_ERR(err);
 	err = reftable_writer_add_ref(w, &refs[1]);
-	printf("%d\n", err);
 	EXPECT(err == REFTABLE_API_ERROR);
 	reftable_writer_close(w);
 	reftable_writer_free(w);
-- 
gitgitgadget

