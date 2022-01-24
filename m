Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC11C433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353915AbiAXTjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352471AbiAXTac (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 14:30:32 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A07AC029831
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:54 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id s18so15475113wrv.7
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pMYa0dfQa1Y/HGAo4moCXBwMLCmicYjMXhnW/sy5Md0=;
        b=flqUX0JJ/zsFXKm0Hr5VEKIRZKVVIZnkbA5mXVvB9USAUt0OfvF5tU0nktr7RwJdR2
         ZExVZw/upwIPckTgwpSCZ4mlf1RVBxLs0r6QB+94Uy1oz2nOsb8zpo1I42lc17lcIh3b
         YyHxcElORhkln7O3LOmDMy4fSKoWsSPXwHhtkhw96ifeZvZfG/33CtHWdi7kpTllTynB
         4RPmUgL6hBHLpOc6pYUAznbfaT51Nl2gWuL64GOtw0Rh6O/KJ8lQVB7VN2E0F6bDN1K3
         toQ5OzciL/1OJx/yYgraSWoS/R4h51VPvfiemc+yqNycpKJUuK8nSQV6AcU7wao35FTA
         yLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pMYa0dfQa1Y/HGAo4moCXBwMLCmicYjMXhnW/sy5Md0=;
        b=OIma378o4hJW8vrHrke14ndX3C5NSecKMKWta0rWXjZlfBX/Llcc1NI0qQ7gGy4j8n
         r2HMwbbyftECn33T0mv+POBgILvJ+FNKIxXkRECq3CNiMie6ndOLYAzmXh+FKvLtxfYB
         HoTVWKADjlKvi+GXuHeVdTuv8+xDqSEShnBAf8MFTQn22m38hfukX3p5eAo/da+Tlczn
         Gbl4E85ATJYy3X1qaliqLXxLGXpY37miDnZq1QF8T4MnH99lYhkmORwJ+kRkJG9pzLFP
         GsEImQ61dgsnqmPjoJPl2splX+5hlZrXhbiw7tBl8BUtlPVaZahI5LNnxCNl+1lIX5Ez
         3W5w==
X-Gm-Message-State: AOAM532BclSW85AbCyJ6eVnVJqOBqRHHFlYPBjNBqJ4BiejE+PTTjyzI
        TxLNxSHhkaBGo8lNMFTJjLuPX2vfjTQ3vQ==
X-Google-Smtp-Source: ABdhPJwe3LRl8nX4gREMPIuq6IjBb2PK8dqy4kDB90g9/SDQzVnusv9IElZvRG0gSw5HwHeUm2JQeQ==
X-Received: by 2002:a05:6000:1ac8:: with SMTP id i8mr904224wry.34.1643051632987;
        Mon, 24 Jan 2022 11:13:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm14219925wry.46.2022.01.24.11.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:13:51 -0800 (PST)
Message-Id: <7a1f32a2ff0926179066f09659f990d4a3f99566.1643051624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
        <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 19:13:36 +0000
Subject: [PATCH v7 08/16] reftable: order unittests by complexity
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This is a more practical ordering when working on refactorings of the
reftable code.

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

