Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4B0C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 23:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiKCXFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 19:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiKCXFN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 19:05:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1801F2FA
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 16:05:06 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id cl5so4825553wrb.9
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 16:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqS3P2hMx5OGT369nE6Yevhwy/bc0bvFdSzfLAB2Joc=;
        b=GzcRdtBTV0SuXRojq3E5OLngZv3F/2VXru39UhpfCm7MCCkZVkOZl4buglOrnLiBd8
         pE9uiLTs7mHrk7DGWAoZkXvwAThJycXzIPjfCuzHzM6P7i4f0yyeeLUpXffBB1UJDTpz
         R1N2rBwgt8wC7MEY8vHIkI7NlgwKf/N/7d1Zv7doaExD8V6HOnLMvoqvM2I7kaLG6U7Y
         zEgqSw+lJ0r4AU5lljr7P0l2B2gy63NDFFfKLreoC5f02ObzTpPjAQu85uD3rFss4MYE
         tzh+7aGEFuhTqv7aE6/RmUW4Dnub91hlJeZP4cISDcJX78LiGJb4+jVGGdzPbUr9ebBx
         Gukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqS3P2hMx5OGT369nE6Yevhwy/bc0bvFdSzfLAB2Joc=;
        b=G7JQU1VXlC0ntrrsxjJ8FEZjEFUhEpEZk6d7mSS/XhRGsBeJBVItcpugUbJ8AiRydW
         xHXH82b8vQbHpyYWFW+wBrU1+O0juQ0DScCwmDodCNPBa8smPhAa/ZP14jRaA7T3q9wJ
         y15JwwEdwV6+3EIrQJCbEfyS2OSupzm36oByniBQdI9JvshZ44D55dvvKEkpu1a/IOfw
         mWkbTs6rVtN1UfqiG1cpKdvR4YoUXcyt6gyN/eUc6dLxAFoWPWzJI2MhBZMhiKIwmNFM
         SsTdLfkbqJ6XIxNkbTbQi0ms0rxEizej6M20W1CPi/PW+Eu8duJ92jK6YKseN237fBc0
         goBA==
X-Gm-Message-State: ACrzQf0TnmpAzx3JCMfdrTbB1BRIlxcs3e1tQNkWF6K8X12G1CE2bNhD
        wRFAdC/JCaeTxWRzpiGzjttoce6n0GY=
X-Google-Smtp-Source: AMsMyM6NX5EYk7PwQwDo55u9gL1NULSUikfoYcA+X7ZNjDNCsd8qWZeF24ddb7ZHguIZQNPX10AwSA==
X-Received: by 2002:a05:6000:719:b0:236:73ff:9ca3 with SMTP id bs25-20020a056000071900b0023673ff9ca3mr20260778wrb.603.1667516705112;
        Thu, 03 Nov 2022 16:05:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b21-20020a05600c06d500b003b95ed78275sm1070302wmn.20.2022.11.03.16.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 16:05:04 -0700 (PDT)
Message-Id: <91ad797330731e48907767d13213c8d8f899d996.1667516701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1368.v4.git.git.1667516701.gitgitgadget@gmail.com>
References: <pull.1368.v3.git.git.1667177791591.gitgitgadget@gmail.com>
        <pull.1368.v4.git.git.1667516701.gitgitgadget@gmail.com>
From:   "Anh Le via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Nov 2022 23:05:01 +0000
Subject: [PATCH v4 2/2] index: raise a bug if the index is materialised more
 than once
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Timothy Jones <timothy@canva.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>, Anh Le <anh@canva.com>,
        Anh Le <anh@canva.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Anh Le <anh@canva.com>

If clear_skip_worktree_from_present_files() encounter a sparse directory,
it fully materialise the index which should expand any sparse directories
and start going through each entries again. If this happens more than once,
raise it with a BUG.

Signed-off-by: Anh Le <anh@canva.com>
---
 sparse-index.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sparse-index.c b/sparse-index.c
index 8713a15611d..8c269dab803 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -510,6 +510,8 @@ restart:
 			path_count[restarted]++;
 			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
 				if (S_ISSPARSEDIR(ce->ce_mode)) {
+					if (restarted)
+						BUG("ensure-full-index did not fully flatten?");
 					ensure_full_index(istate);
 					restarted = 1;
 					goto restart;
-- 
gitgitgadget
