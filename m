Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4158EC433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 10:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB8E206D4
	for <git@archiver.kernel.org>; Tue, 19 May 2020 10:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCTbFZTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgESKyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 06:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgESKyN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 06:54:13 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772F1C061A0C
        for <git@vger.kernel.org>; Tue, 19 May 2020 03:54:12 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 190so14349318qki.1
        for <git@vger.kernel.org>; Tue, 19 May 2020 03:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hxclQLbBSUal7Gbbwbp5s1iq2t0j8ZwEi3scAMADpQc=;
        b=UCTbFZTNr/KeWnaMtBYPzBcv5kAh2e4QTfREajiHyfDk4LSJE7zIWNWD0bRHf7q6bV
         rbzMO+5gh6iuu66Z0kL0Pw54uWPLOM13vluv+vZdcKRkGMmyMQaX2skKRxCeNOq44Jub
         IhxZxXh/2j9jSp8cr9kL3sUUHE0wlAjv4amL/GCw1VBLop74GO1c84PtZtkvFnCSk+gu
         FP4eQuh2Y0B3R4iv70yXbWn7VKNPwBpFQsqm91H5TnRKxY4aTs8uRE0w9Fx5jjk5+gu9
         heBLV7S4l33VByBLJtRyhJX/1m0m3sUHHmahbMtFLbTEl+9LGciW4Ag2uj3l1YgW0EZ6
         6dCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hxclQLbBSUal7Gbbwbp5s1iq2t0j8ZwEi3scAMADpQc=;
        b=l8fycAAgtx8idMSnCIf3+GyEuEIgODHU8D1OgLbb2PmeevA83te5X8Kh+kb4nV3ZNe
         87+6xx9+05k4U0Y0TlJB1G8sXuhbm0JkU79SnqRuOYQfoaooKSA1vwc2Sr+NJNtoDP/k
         o9md6sqi0bIS6AWdsQwJyFJGjXL2rjYZizlo881Ur+YpHaeU404bA4R3DSfwWFEiAU9n
         w0XUVmlWPZbuL0xOzxgS1EykQMm+BcNowFda3LzmUAYRuW8DANj7nWwH7RFck2nnDJQ4
         ESimfP0MzPHm0VkewU4P/CkKKjlQUKwxNwDc1lCTYpU75De0oPKtbZNywZxPQ8SVc1Ix
         PSzA==
X-Gm-Message-State: AOAM5317SycxwUptSdE5di4KTZB2Zq4iyLxLxSkmrFnOc4UOpMJyjldo
        1iE2BzutALSLNJZ9P0of2OKStRZC
X-Google-Smtp-Source: ABdhPJxCFep8oBlfw4YVXWUiBox8V7caJW/y6ZBAO1REtE/OelIIN211IMq7HDlt6RJKaQfu2Fyhuw==
X-Received: by 2002:a05:620a:1479:: with SMTP id j25mr21164725qkl.110.1589885651386;
        Tue, 19 May 2020 03:54:11 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id c63sm10177775qkf.131.2020.05.19.03.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 03:54:10 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/7] remote-curl: fix typo
Date:   Tue, 19 May 2020 06:53:54 -0400
Message-Id: <b390875f87dbf5f3f48909ce40f5a5749b32f5d4.1589885479.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
In-Reply-To: <cover.1589885479.git.liu.denton@gmail.com>
References: <cover.1589816718.git.liu.denton@gmail.com> <cover.1589885479.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 remote-curl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 1c9aa3d0ab..6844708f38 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -643,7 +643,7 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 			return 0;
 		}
 		/*
-		 * If avail is non-zerp, the line length for the flush still
+		 * If avail is non-zero, the line length for the flush still
 		 * hasn't been fully sent. Proceed with sending the line
 		 * length.
 		 */
-- 
2.26.2.706.g87896c9627

