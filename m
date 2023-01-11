Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67168C5479D
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 22:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238467AbjAKWON (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 17:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbjAKWNV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 17:13:21 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BDD3FA29
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:13:21 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so15370837wmb.2
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCY5CaeVsGFH4YCKVAhrjSkUdtoSk2eEGMnVuvUbaAA=;
        b=R5y09UCJHcjk6pz2cshPi/ed6fzcg9J3Rurdxbmg0vQOa48zIWkPPgf0KeSSFLXLdW
         atoNnHLs4t5RDw0KDyhOb2ycYh0JqIxC0DdFkK4/tqfzmCMI8pAvVLbQXIx6t3Az84jU
         mkEqkfaT2LeTyg9wwZGDfTDQ69tVMoFMJHVQuoGWtUMfDv5yQaNkaiUCCrCDVoVOZsLw
         9vOZ1/FDmfHIurllIbLuOiM+oFwXFO5XcfMdYXmM/0P7TH4zQeJqrfJLH8vwLou49B/x
         2RI7ODz14WX2gUhP4QvjwXHDD6KQFLXIeHKtW0ZLUjAY9JSC3A2s5SXFSrLIIQogjBxd
         4WOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCY5CaeVsGFH4YCKVAhrjSkUdtoSk2eEGMnVuvUbaAA=;
        b=5TEaUm2iHCfJNNPiQWOpwUX74Jm0PtUUbpTzXhIOl90P+HH80eWVUgxaTquOjz0ad+
         KC24yceSJ2KSQI2tU/9dwpYlxzjtnWmC60JI1HVYC7avkwWVy4zQ8XtFYV3HqCAimZYO
         iGowVByHkALYFSSId/BZ4tg+vgY9zrOnv4c0+7FZ/fhTYwXnc4UZkVG9t0YmVW8Z5+dB
         IEdIzCxvUgRP7zRd4/QqvjL7WO5GfsT8HANwrWeeNAo35Wm/CLMh7uGzPLqY1TfopC6m
         CdY8Ops6JcVi5/B1G0wmJN7UDvs9GWJZe+6f1tZN0VEd6JWO3l3zLJjwmEYW3HVHkfU5
         wIHA==
X-Gm-Message-State: AFqh2kqGtI1CYPX1DqBb2PNduvVOCCNlJYehawfsHndTiiyTm2LUIphi
        +fguatsSfc4/kVyPLcbacM24jqvvYMw=
X-Google-Smtp-Source: AMrXdXsZJPsXiD58pMxlIZnUtBY2RP9i2QR793FIYDAtiLZN/Wk4RCR/ciTlNyVowV6vHPKQDnuNqw==
X-Received: by 2002:a05:600c:5008:b0:3cf:6f4d:c25d with SMTP id n8-20020a05600c500800b003cf6f4dc25dmr53353727wmr.21.1673475199362;
        Wed, 11 Jan 2023 14:13:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c3b1100b003cfbbd54178sm7469043wms.2.2023.01.11.14.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 14:13:18 -0800 (PST)
Message-Id: <9c4d25945dda0c5b5a16f0007dfb0575c59facf7.1673475190.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
        <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Jan 2023 22:13:07 +0000
Subject: [PATCH v5 07/10] http: replace unsafe size_t multiplication with
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
        Matthew John Cheetham <mjcheetham@github.com>,
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

