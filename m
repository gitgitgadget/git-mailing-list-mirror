Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234DFC54EAA
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 20:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjA0UIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 15:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbjA0UHe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 15:07:34 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA39519F09
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 12:06:08 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h12so5942669wrv.10
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 12:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybyG4yr7Hp3pvfK4uIlWp5IwyZK1wDJt0gkq+X8sedQ=;
        b=HbNogUgOv5UVyJGRZX8Yf0Rh7GxQ4B1vMf8iHAQFcm3jGYWvXG8oxTy5e6qkeRKAcf
         pLTnnfsjPQQTDqJa/WUv6b8g8oHPfz/SMQmuXISIZDeMbZ8DSFZQxS/lmyBaQuumC31F
         aaN7wdlPvKWoU9Ua+uEfSNqbNNe5IMIggLO5UnF6cQBVmKxceiMhzAlMXReMNATe0oH3
         cmVloq6yWo9U62au2/juuxRRcK3sRfItpX0cO/rWU2BKdUc8RQN3z+Ce9MimjTVWafi4
         a5gTIrlyyLhCULjJeBZPbVEgjEw5iPjJrCV671yi7nZ1ot2HblL4xEN6qojInp0Odb6f
         NCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybyG4yr7Hp3pvfK4uIlWp5IwyZK1wDJt0gkq+X8sedQ=;
        b=BdbhlZP9+/w3NwG3c7qGoOs1qWDnZbeS5FBErziZ2LUTMqqdaF97WJkepnmIpxYBJc
         u0xchM0q2/m+0EY2FBjFKdEMfkJ+tvfWLQ5R1jnPqFcuXd4Mv1kjC9eEAewjvszYfET6
         sSBIcT9pmaFRoPkjgfNIeTCryRPYOEkIWVpQv/rEUuaOwV+MzQu97iSvJABD7bQ1itQY
         +Q7h+WPCVB8vKzu00D5PuT0jqKLTYEA69GjJ0GHLOUzs6QYz6HtJaau3u8XzC2yljcWf
         hzdWjDR9qzX0Ey5s7D/9tO1PZdbydwj0zjwiRPnyDqluDKnZ6L0YKUjlEmmF3NbFPaWJ
         2mQA==
X-Gm-Message-State: AFqh2krp+mL8CLCvnv/YZlmqfVTzwDHcojHfUKIgLB/lM1SQDrojYcI5
        D5/eEXjH7EuQbHT+/3bw7r5aJZX2YWY=
X-Google-Smtp-Source: AMrXdXtaaFDqOwn6GLxY3Q9CdK1xsfVuu4RAIdDJ4a6HRAW89hG9SGIN7bLSEOOE7nU4kXfq0s0CLg==
X-Received: by 2002:a5d:6a46:0:b0:2bd:c856:6de0 with SMTP id t6-20020a5d6a46000000b002bdc8566de0mr38260600wrw.21.1674849965041;
        Fri, 27 Jan 2023 12:06:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d67cf000000b002bdef155868sm4654033wrw.106.2023.01.27.12.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 12:06:04 -0800 (PST)
Message-Id: <94630bc3bc7f4f236c28e791e0faba6590c735e8.1674849963.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1473.git.1674849963.gitgitgadget@gmail.com>
References: <pull.1473.git.1674849963.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Jan 2023 20:06:01 +0000
Subject: [PATCH 1/3] t: allow 'scalar' in test_must_fail
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This will enable scalar tests to use the test_must_fail helper, when
necessary.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 79922227030..75b8ee95e7f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1016,7 +1016,7 @@ test_must_fail_acceptable () {
 	fi
 
 	case "$1" in
-	git|__git*|test-tool|test_terminal)
+	git|__git*|scalar|test-tool|test_terminal)
 		return 0
 		;;
 	*)
-- 
gitgitgadget

