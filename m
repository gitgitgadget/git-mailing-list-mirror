Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F57EC433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 11:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbhLNLsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 06:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbhLNLsG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 06:48:06 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429CEC0613F8
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:48:05 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id y196so14020186wmc.3
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7hrVqwDEsCy4jvGx2ygf2ufkTVUbjR+/cx/GyTSeOVg=;
        b=b/jrt20dUAWuvvXQFf1zfZyTXbfZzuJ0Wh+fWLJLz6R6TjOoFsiT5UR5FFk52msd3y
         ULxY4L2bigvdolUDbZQ9XiUIMm7MvvH9CMEG6ALcmhvNwk+O1mLKKvYR9GnL420d5VOh
         8e9jwKiUy8C8shBZoQMho6iAFvbMbhM8CAjEb3Y1FWQmpn9otLrMmvIDm6NVV/QnQ+Er
         Hn3qWPrr//dP11oZ9IG4grRZVFTXRDckMe1zjf4C04M/aTA6hh6MVuHb0xTm2wi6BJRS
         beIpkMhGjNj67jZR+MOUTuqNr6hGYPHgDsNQHcnHx4PTDESJG0UUfEOrHwptFIlvyibf
         m+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7hrVqwDEsCy4jvGx2ygf2ufkTVUbjR+/cx/GyTSeOVg=;
        b=WQwTT2mm4LbTwu9N9n1698EGjcBC82TAsAdIwUiyETVJQgpaYOaKsLu6OdQE3ypdUN
         Cav6w5A2dz3tMaHaIkCMxdiNtkJR4BoBeI/v4fQct3LhdBkR6n9iI1IAHg26k5k+U3aR
         c87LmYb0hC0L4Yvos7Ivm5xxRHPQmGO8zbZ82oYPkLv32NP/QJHk5YyHNlnnLdTRpfze
         71PHZ5272gX0Bi2YYvp9eKtLRLqRbXZxT8eLT2vANaxkJvc1o3g4fgLzM0TdFIO5J/eq
         WX/AUQybVgtWRjUfjSPGXDjrXYlbxvIfj7dxjvqIayFmjTBx0h9YcykbqjJMsvfCqIXy
         nyRw==
X-Gm-Message-State: AOAM5321jyg+AmLVp71fdlT8fHLBYkXUDDC6nBoS1WlJD5CmsJ0186kP
        3qsjvJhvWdmKRcJMzoixP/6DBVWQx/k=
X-Google-Smtp-Source: ABdhPJzOueV2pnWeUZbXwxL7IYD1/yTcaIMqbT5FuJ7ElezulT5OoadMIALZU6XgkxY9MygHS9ICPg==
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr6286829wmj.190.1639482483763;
        Tue, 14 Dec 2021 03:48:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm13618140wro.33.2021.12.14.03.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 03:48:03 -0800 (PST)
Message-Id: <aba8b8113ad100156a60c3334d8e867f28f97420.1639482477.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
References: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
        <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Dec 2021 11:47:53 +0000
Subject: [PATCH v4 08/11] reftable: order unittests by complexity
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This is a more practical ordering when working on refactorings of the reftable
code.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-reftable.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 26b03d7b789..1f0a28cbb64 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -3,15 +3,16 @@
 
 int cmd__reftable(int argc, const char **argv)
 {
+	/* test from simple to complex. */
 	basics_test_main(argc, argv);
+	record_test_main(argc, argv);
 	block_test_main(argc, argv);
-	merged_test_main(argc, argv);
+	tree_test_main(argc, argv);
 	pq_test_main(argc, argv);
-	record_test_main(argc, argv);
-	refname_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
+	merged_test_main(argc, argv);
 	stack_test_main(argc, argv);
-	tree_test_main(argc, argv);
+	refname_test_main(argc, argv);
 	return 0;
 }
 
-- 
gitgitgadget

