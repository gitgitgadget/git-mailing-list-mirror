Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE094C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 17:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240197AbhLGRtG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240178AbhLGRtD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 12:49:03 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3B4C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 09:45:33 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id o13so31031698wrs.12
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 09:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MXMomjRC/fb24dxRgX+qEsh4KebnnV6VgDOcUfwXPBo=;
        b=DmRDM8/jnDMOmgmzG34dNlvlXujeJOtifaEQaQceWfHEKgu6KMxHsiCIp3axHva9MZ
         XxqLWpmM1bJLnDeaXhFU8HSkWH1e1saYELkLgfeBg8Fv+9ScLiK25oYW26Eb2tVFEd4q
         lKlZSWwlaw3DeWPGiJ6BvPRvTiHQ74qPd3CR7kiyD1QEceabkHN1Z3YtjzTqDfMEWTy4
         xbvljZxxDAphl+RDDdlaYQWDwLjUdJI8BoHkaYtlSzyfqXJ91c4av0s7DkSVRhGlXNv7
         OgJAhon/X5OYfwtcexUYqQSsWQCvVw6B6giPshHV/wCpLoJgdEHb4KAXi5k7tCCS3mRP
         C7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MXMomjRC/fb24dxRgX+qEsh4KebnnV6VgDOcUfwXPBo=;
        b=M08Teodig2mNchaw5CTZ4hn3qVYzTlfmRp8kGMa0Q4WUe7DDAcIf4eqmG45m3wco3Z
         QAAgZ0sFjIUwqPjdp5G14q9iipd5oMGgNb6ArtA0PSkyX2s0HTxxezQqqBNTk0AndcyQ
         DPL8pRLjDvm0xWr0QIFZ5slgAAm0DyTpwGHKb4zRuF9zpO6pRzoGaigNKxpeOrbH4dZ3
         EWwc0qMaqyP2mz6Oj4Jv1m2t/z4j0ObCE8JiPyTQnCe3S20wkTGlLw8e3RoXXZ741m9J
         jsIlEB5T3dKHh3vzo1iipb6OwvNWUEPmSeQCgxk0ISG9luI5A8NYj7LxXIQF3Zk75xWi
         rf8g==
X-Gm-Message-State: AOAM533IABI9WmxI2AQMbyqWsKK2vYP/vQ921JZNHA9Z6vrr1c+mufTJ
        ByHUk0SIxtBqHpJLwVsJRa5hjeIhe+U=
X-Google-Smtp-Source: ABdhPJwJmPTNiVL5jyoO8h8d6tBKyzekzys9Qj16fPVifIycwIR/KMqV3tCAfVBw+3W17tlOpxhwDg==
X-Received: by 2002:adf:f602:: with SMTP id t2mr53641418wrp.539.1638899131750;
        Tue, 07 Dec 2021 09:45:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4sm324747wrs.88.2021.12.07.09.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 09:45:31 -0800 (PST)
Message-Id: <458adf0fa9b90dae831da7aa8cdb67fa9a064ab5.1638899124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 17:45:22 +0000
Subject: [PATCH 08/10] reftable: order unittests by complexity
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This is a more pratical ordering when working on refactorings of the reftable
code.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-reftable.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 26b03d7b789..f08d66df949 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -3,15 +3,16 @@
 
 int cmd__reftable(int argc, const char **argv)
 {
+	// test from simple to complex.
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

