Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA0EC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 19:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhLITXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 14:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhLITXU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 14:23:20 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2638BC061B38
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 11:19:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so4908860wmc.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 11:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=50ZVm0fBHao6jbOshnVgMpsEyJYv61B3CHXtciUtTDc=;
        b=fY7rceX3WcGlEsz5sU8RylPP7uiZC5R5va9AUNrmte7p2OazbS/bQW5JZjq3YvAQZ1
         h7laTsJRLDFztfkrHZBjCvIHYX989BOCxtRDSe/gVngkqFJNWYjQRfbqbyPHSOGpQRy8
         eY4NzdUuVQm3MRcJy+QSaKXni9yEdAd0SwZG/R6K9rSOYAiV0np5irdvf7eIW+s6gulj
         T7GRF1PoY/yK2ZV1c8B82MqPfVBchdljhJyjha/Iuri4mCdUglqYS5HQrTxJc9L6xc1Y
         h1w2HbHe2qkVta3r7wXIEJXR0Ti4Y0heNhDNK1AC6h2a/47NS5AhzWhZXmbiRgjd1y1i
         X7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=50ZVm0fBHao6jbOshnVgMpsEyJYv61B3CHXtciUtTDc=;
        b=BcbW0uVj0thA9duhn7uo1NTyG+ldJFl1VZy1z5YfvhXBOfNGNELofaE8pWHrHJh/Ma
         vQkSdu79AuBzXCYcdrpKhQQqFu+83hAYqc+wVR+UXnYT3fytULPyJ/oFwunrvLZlwO5S
         oZgyK3xArIrenDk9kxRZS0uRJSjCfyboIIHfWkX6kIx7uOneWuyV0dqzF3ZyxM3kPal6
         eHkmxu1Jvc+Oh+z46Pp1BduXHTDD5F4ZCDfjpUVjMl2pgMlWl/stNrbKiECXAbCAO42b
         mqPxbDpxUlzjvgUvpRiO/zd2f/17xAEnNZ69BQFNXtYf4GwLOQYjvP/gqppovKgot+B1
         zp8w==
X-Gm-Message-State: AOAM533uy1vdBNxCcI75cWPfY/3pMa1/6ez4JccZ+IMthpeT1R8hYrLs
        c+gYLXXZKBIaS2hW4eiWCXuAuAHi7ik1CA==
X-Google-Smtp-Source: ABdhPJyTZhAK3sI2j0DcuvCM/7qAFiMPqx5J/Vt1yHq+q8lmyFr3mUJyKTj0kYUdidpwYlj0M9hmnQ==
X-Received: by 2002:a05:600c:299:: with SMTP id 25mr9825571wmk.77.1639077578481;
        Thu, 09 Dec 2021 11:19:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x13sm562180wrr.47.2021.12.09.11.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:19:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 07/10] linear-assignment.c: convert a macro to a "static inline" function
Date:   Thu,  9 Dec 2021 20:19:24 +0100
Message-Id: <RFC-patch-07.10-a82771413f7-20211209T191653Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.930.g0f9292b224d
In-Reply-To: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the COST() macro to be a "static inline" function. On GCC this
makes no difference in performance, but this improves the readability
of the function. In a subsequent commit we'll make use of this to
extend this function with overflow detection.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 linear-assignment.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/linear-assignment.c b/linear-assignment.c
index 1f8329701a0..e9cec16132a 100644
--- a/linear-assignment.c
+++ b/linear-assignment.c
@@ -6,7 +6,16 @@
 #include "cache.h"
 #include "linear-assignment.h"
 
-#define COST(column, row) cost[(column) + column_count * (row)]
+static inline int cost_index(int *cost, int a, int b, int c)
+{
+	int r;
+
+	r = b + a * c;
+
+	return r;
+}
+
+#define COST(column, row) cost[cost_index(cost, column_count, column, row)]
 
 static void columns_reduction(size_t column_count, size_t row_count,
 			      int *cost,
-- 
2.34.1.930.g0f9292b224d

