Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE566C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 18:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4076120659
	for <git@archiver.kernel.org>; Wed, 13 May 2020 18:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7+qMHw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390011AbgEMSFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 14:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732488AbgEMSFM (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 14:05:12 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEC5C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 11:05:11 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b6so132093qkh.11
        for <git@vger.kernel.org>; Wed, 13 May 2020 11:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RFan4SxK9IYM8JwqCj6zEhODFuYsjYeefwOc2HlU8gU=;
        b=b7+qMHw6lrUMKwaX8oOrCJ5tQzT4X1w1rkgWuv++lNPtiAqYF1tNg9AQgbtN5xApBI
         hgi8Qr6/F356Fki2cmdLwFB74VNlEIIkmlH/06YfFc709UZ/JfJzBVWSmQY2FeDqBME3
         XR6uo1lIMm1u8+9HmbTqHYQ26o9dDQRe9rH9lPGGymCvUKS3+Arr3wwIAiYX87e1VLtq
         30sMXIVccCfFf5sNR4fHikxwMCYmmz5VaiSnq+kjU2+6vHcy6EoIYkKgUWAgEUflK+mD
         5IWXqma+MHVbw0TBewTYEFh/yh8S0TbcI29DdbpOH6K8ZAclaQSLGT76HAhoidW0tb+k
         BOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RFan4SxK9IYM8JwqCj6zEhODFuYsjYeefwOc2HlU8gU=;
        b=E9wC3IUzzaQvC+bOd+WxoIEMDJFUlyYYMgUzduc9IvoQdCFC5GuWCJqPFrfbOziXUb
         BGsUijPRWyqYJ+5tFkg0ZT6ZswmctR3hBAVUhwKzRmM4nHKPzsG16DLhF2JbIv8BjPrt
         fdskME9HV/lOP+6F7SL73NgAHNUsnR5repUtxUSqMvvFstQOA1RtT8yVawKwlO49fNoM
         9CKmHnTlsdeMAHM0oS0EDyUiUdp3vNAMEWO32/O8xdXCEAeCAH9SrH4qzUmqXn7AQ1XS
         vrvQfLmN6RoqD3s3FC1PeNBDgjJr4UhoMPrJQZI1d3ig3DYhCgcUP5UmpDSWUREWVtnj
         /jlw==
X-Gm-Message-State: AOAM531i70rbKhyCXAyhKmwCJmHm0t44D4+bZO3jcaqmG70snn2khmTN
        TLvr7INSztW7UjLBUxNlh8N3tpuk
X-Google-Smtp-Source: ABdhPJwD3DVdBCqW7aHWCj2lnCNoL46x0dk9S4VTkUybRbrdnHcmpfDKKMJrBUIF1g8+F1AqZMsJmA==
X-Received: by 2002:a37:bd47:: with SMTP id n68mr911529qkf.379.1589393110522;
        Wed, 13 May 2020 11:05:10 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id z60sm301153qtc.30.2020.05.13.11.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 11:05:10 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 2/6] remote-curl: remove label indentation
Date:   Wed, 13 May 2020 14:04:54 -0400
Message-Id: <a2b28c0b28bb972f164ff0a9e48ae6b623a2a125.1589393036.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
In-Reply-To: <cover.1589393036.git.liu.denton@gmail.com>
References: <cover.1589393036.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the codebase, labels are aligned to the leftmost column. Remove the
space-indentation from `free_specs:` to conform to this.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 remote-curl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 6844708f38..da3e07184a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1276,7 +1276,7 @@ static void parse_push(struct strbuf *buf)
 	if (ret)
 		exit(128); /* error already reported */
 
- free_specs:
+free_specs:
 	argv_array_clear(&specs);
 }
 
-- 
2.26.2.706.g87896c9627

