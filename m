Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC5681F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 18:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfKMSzi (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 13:55:38 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38457 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfKMSzh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 13:55:37 -0500
Received: by mail-lf1-f65.google.com with SMTP id q28so2844762lfa.5
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 10:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oFkNEa4pNa7eAB6hNALCb6aGKLvenVhnUwjur3NX6EA=;
        b=MznuhTSAmyR7KQbMGErXDqDzDAQv65vmIcQ+gvvhlniCP3rrbw+Sot+XflZi5X05aG
         b7ucstpYpSumCq2eSAh5xkXBRgNdoB7LG6/4ps/uUTVHV0IfP515N1OD+AcGzF32o8V/
         /yFVP7fVTJozkiotg8nmroLNM6w8N+OW/DZR/6l2XbVMue2R8NyKbSdRAJuJxE0E3xlZ
         oMeFUNBMUOahVcyltbwetuQ9OJNP6DtnIxCjZ94jOYw4nP3PXJe3irGftcvvXsRyGylQ
         jXQVDo/YpXhYT1q8AMjMfLT93waclnwW1txU+u7Te4Y1LBd+kW/OtNwJya/N0+wCk+Vk
         5Otw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFkNEa4pNa7eAB6hNALCb6aGKLvenVhnUwjur3NX6EA=;
        b=t1QQzRSkY13gzfw6xVcEktHmhlVPZ0Ib5nRwtqlNiIt7WU+PF+8/yjnfNnClD4PafL
         rG8q9OTwhOfBklXUvcczZrR037D8YVfRSC6grp1Qy8+rSNh3lubxxbFeUcdvTO+nOGI8
         pcRh/U0VPnfgLpMgnciHDAc/drzi+jZg+HH/17ocYASkt8hnyzRPTjDPf9LJ1txDy+7m
         QTd+8Cl0Eo1oJQAlkaLPPdcxxlZY2FCtvixgodWQxByjz4jAM58l+j6rpka2iBvjyziE
         9tVReNCTZelwdWJ8rpBAFv4ovjl8/aNLnURNVIr0Y0SBLKwsPtHXo91y8xgXnljqebrq
         jdeg==
X-Gm-Message-State: APjAAAUHBfavXYVUKKtpJg1E6LOq7hICsZ9bFd9bAcEMbPA+9iFLmvuM
        cF9ussjdZ2W4nxCRPaEMcpZ7Zxm2
X-Google-Smtp-Source: APXvYqyYL8tBWTdmjd4MF11Ui5fcz0y9yYmmTZ9zs506tAR5RlBjEQNULZMXtEQ8mj3vQVQADdx0Kg==
X-Received: by 2002:a19:4318:: with SMTP id q24mr3738702lfa.12.1573671335108;
        Wed, 13 Nov 2019 10:55:35 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id c24sm1422765lfm.20.2019.11.13.10.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 10:55:34 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/8] config: make `git_parse_maybe_bool_text()` public
Date:   Wed, 13 Nov 2019 19:55:00 +0100
Message-Id: <ff9bddbbb31361c372ed7b5942fe8e83a68ac415.1573670565.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1573670565.git.martin.agren@gmail.com>
References: <cover.1573670565.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We will soon use it from outside config.c.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 config.c | 2 +-
 config.h | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index e7052b3977..318711f7a7 100644
--- a/config.c
+++ b/config.c
@@ -1047,7 +1047,7 @@ ssize_t git_config_ssize_t(const char *name, const char *value)
 	return ret;
 }
 
-static int git_parse_maybe_bool_text(const char *value)
+int git_parse_maybe_bool_text(const char *value)
 {
 	if (!value)
 		return 1;
diff --git a/config.h b/config.h
index f0ed464004..343f24c408 100644
--- a/config.h
+++ b/config.h
@@ -95,6 +95,13 @@ int config_with_options(config_fn_t fn, void *,
 int git_parse_ssize_t(const char *, ssize_t *);
 int git_parse_ulong(const char *, unsigned long *);
 int git_parse_maybe_bool(const char *);
+
+/**
+ * Same as `git_parse_maybe_bool`, except that it does not handle
+ * integer values, i.e., those cause this function to return -1.
+ */
+int git_parse_maybe_bool_text(const char *);
+
 int git_config_int(const char *, const char *);
 int64_t git_config_int64(const char *, const char *);
 unsigned long git_config_ulong(const char *, const char *);
-- 
2.24.0

