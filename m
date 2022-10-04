Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5649EC433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 16:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJDQUV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 12:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiJDQUO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 12:20:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA92039B98
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 09:20:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso7851069wms.5
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 09:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=cTLoZaZ6n+Wz/7kdysCOtNZST9K2cELlvFYvnhYh5CM=;
        b=LYq0eRkPslL1DEq8nRE/qK0V3HPizLXAwQPceq0Zkz5eZrQuIEfFYDrDNsfes8BziY
         S1n0/Z7gXrIe7RDZlDw28/rsBhwBcGrt7ob5AThMed4by3J142gv7+0dPit+50rhlNiZ
         y30FoRj9fg1W/DqKjwiYjls6WJUziNRKtQ8k99MkT3yls2Pd+JmJUQTQZNDhdW9bgFI8
         NOd95iYmSXwoL9ylNmZOXO3AxgWSGaoY8B7hurLnQTQekgXbtRXn+5Vpgdv6gW3hpwkp
         BbikAhdSeJt4kr8G/4LAsB4YvpRLbGnw/TAHCFss6PuoXM7r7AtmFaOOondzw549AnJv
         RiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cTLoZaZ6n+Wz/7kdysCOtNZST9K2cELlvFYvnhYh5CM=;
        b=7n2ufiLyFJq1QO+C9H7GQ4gkvmJ7goewGy3HmVxsMm3Rx0Cb6G2fUqBcyx+TgKgIBS
         a0wZNdwFww6bZ67HCdOH06vnPC4mXLSIuIWOIe1iMZDgtpOrMBd03WKca0zPzriJQx0V
         N3N9lYTqY3kM4W/vbHL62fLhupypeKTZqRJ/hGR22b+gPgQC2ZMSpNCLSLhMTXxs0jwF
         ixUODSpwlMwMjKQUPrBXbokRfKlm2zgZDZuvnn1RTt19xH8r3m9rTWTja1NdPvFPO6Xe
         yDiFk39Py1Qvyhm0SZcRfEeK5JAZ05IPQrB4/OM7DQzYCByLpUngG5ov6/U39bG9CKRy
         iEhw==
X-Gm-Message-State: ACrzQf3/pgk0f8NB6VowWwb3WlsfZSXCb7VDdfhNy2WY0Ml3SK5qsniH
        WBX2wQT03DoTLUoGL+81wTGV6pwbiBc=
X-Google-Smtp-Source: AMsMyM7iADQVLv0izopCNftr8GHKPOWDUSvsHx6YLaAHnM888P/8Gk0qa5WoO4NGWk/kEm7nihJIfA==
X-Received: by 2002:a05:600c:4352:b0:3b4:84c0:2006 with SMTP id r18-20020a05600c435200b003b484c02006mr372730wme.205.1664900411240;
        Tue, 04 Oct 2022 09:20:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n41-20020a05600c3ba900b003b3401f1e24sm2247326wms.28.2022.10.04.09.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:20:10 -0700 (PDT)
Message-Id: <73704b6f66055fbaf8c11696be9f579c06b471dd.1664900407.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 16:20:01 +0000
Subject: [PATCH 3/9] trace2: use size_t alloc,nr_open_regions in
 tr2tls_thread_ctx
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Use "size_t" rather than "int" for the "alloc" and "nr_open_regions"
fields in the "tr2tls_thread_ctx".  These are used by ALLOC_GROW().

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tls.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index b1e327a928e..a90bd639d48 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -11,8 +11,8 @@
 struct tr2tls_thread_ctx {
 	struct strbuf thread_name;
 	uint64_t *array_us_start;
-	int alloc;
-	int nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
+	size_t alloc;
+	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
 	int thread_id;
 };
 
-- 
gitgitgadget

