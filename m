Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5267CC38A2D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 15:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiJXPGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 11:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiJXPGO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 11:06:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1E0B2750
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 06:43:04 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 186-20020a1c02c3000000b003c6c154d528so9980089wmc.4
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 06:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTLoZaZ6n+Wz/7kdysCOtNZST9K2cELlvFYvnhYh5CM=;
        b=ZkUJrCIKvThAgKZGz5Nmk5tYp7f9bDPfsqQ9duzNt3+A1hF45mQJJjC2cDr+dqRtnB
         C4smfHnANACxUZB5hjiybJWgyPCH6aIqRbc0nMtQfvNMYakU/KD4aRNaFbqVb1NsKX74
         lNYKW6ajphcp6Ftiq0N5VrrxfGLgUTZHshZIIVfUYf+s9aKzg3cEQrAolqlzNXr5KF5f
         W7yZbxiS6Rqevf6zw1qRPpjIWDe5lDpqCRG0IXXIX/YbssJCnAqpT2pOIrabkF+47Ev5
         TWYiLjSMeCE43ohh9muWEKGexpFSoY7l+FatVOeiCaUid78G1ihsyrCed+HBb7RdNdDM
         rqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTLoZaZ6n+Wz/7kdysCOtNZST9K2cELlvFYvnhYh5CM=;
        b=PwVkE0n1QiEx8nGiBKQEc64hc/NDN+JrPWeleg5nwCYTgn6EGVHKtSrtkJtAUOrap/
         NpO0b5f5alVTwffilnGDBDu6aC/Td+qkcoNMYKNGDyxe0QoFrVXYDc6U/bl2hOUBaWLh
         mjHSTClABNxPQVOqM19LA4z1bTEy9ATdmcGkGoHgx9jrzoYOjqaydO1Ds7flZrV4N42F
         yg6EmAzFMkpgCzhtcptIm/Mbpiv6a0U21ab7EePUEHCtm94nRnKKHXjd7DGMEbVgP/fV
         Yh8rZ3d5Q0J/cDHzOoCaTXoJ74zLXIXcvmAHMq9hbJ285s8+c3rpy2mG6Ne8L8uVqrjl
         gkuw==
X-Gm-Message-State: ACrzQf2M7tIYNKvRnx+OKemHpLEuPZ+0VaBUYYFhXNUiR3Y/dcuJMzw9
        vBg5nOcVc2Q1B52ASpHNaS1wbilXTEE=
X-Google-Smtp-Source: AMsMyM7im5GoFoBIJdsiw8pShtTgSWYWgWQOWbMbRmeQxS8NnTCH8Ab2BOzlWJ/H2ZYS0fgl4TAyag==
X-Received: by 2002:a05:600c:224c:b0:3c6:ec76:89bd with SMTP id a12-20020a05600c224c00b003c6ec7689bdmr33869665wmm.74.1666618870976;
        Mon, 24 Oct 2022 06:41:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m64-20020a1c2643000000b003c5490ed8a6sm8329976wmm.8.2022.10.24.06.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:41:10 -0700 (PDT)
Message-Id: <6e7e4f3187e2fbbbb54bb1cf5793bf6e981a5a94.1666618868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.v4.git.1666618868.gitgitgadget@gmail.com>
References: <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
        <pull.1373.v4.git.1666618868.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 13:41:00 +0000
Subject: [PATCH v4 1/8] trace2: use size_t alloc,nr_open_regions in
 tr2tls_thread_ctx
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
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

