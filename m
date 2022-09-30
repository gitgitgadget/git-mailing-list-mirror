Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE79DC433F5
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 14:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiI3OKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 10:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiI3OKY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 10:10:24 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E120B79EFB
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 07:10:18 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso5124585wma.1
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 07:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=J2XwckYFLwo1JTxOEnkRphT5PvM2ANPLOt+Nhp/b3J8=;
        b=jxB9avI3IXFX+FHTx0nNMBiwcWg6VF0TQgd5y9lvla+HBC/RxQLRXqBb49C66zAhic
         xTilyUJx/jBuAmxJktQVFHjY91M/0pPGPQR0JssY69/uUO/v7M4Zy7JrxJZPEyi+27eK
         RDuB82Ul/UmpRFjKOBidWZgWodhmtS54IhU3DHruC13iUtPF3D1vw4V7ievccbUYFq6m
         x8vDpRHY9n2la9Utm9+5W01OpnZUcTnKGhtgl1BMGEa6p0yKa1UzLdud4H2iRyz2u+0P
         3uTNEqY69ftmrR8vKEN4kjRWwDZ5xSK332vnUDb7M6/GKd+XFS8TUhHmoqO2Tz2xs7VN
         kBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=J2XwckYFLwo1JTxOEnkRphT5PvM2ANPLOt+Nhp/b3J8=;
        b=sVS7mF2tFNqDd4Va+PKs/0qc7u4SyoDEAdLQGUAKF9tjXGTxevUxO2Wztvr/pP2oAM
         UQv8mltgUiZaWOK0uUiF5Pb0p/5xW6WWoj1vq+ymglnukD6bhyi5VvwUZ3klpsgz9mDz
         ncfJwtM2hG9q+Gn/kEqGpluTF+UmJAAq2YoklYDcPLdUA7ULKmtrNeCz4zEboSJqy4C9
         vSOvmLKMmz1TE5e/8sQXbrDURXudrZviSLq4i+EulaSbsVIyQhEtztL3s/pXz+AhHwou
         W92phQpYEAHmtdNFSN2x9ZV5OCH8sebu/RCk/wWdfk7934LmwXp3GLDlwYLDfWFkOwWz
         wndQ==
X-Gm-Message-State: ACrzQf1k0ngD92bVtDPDKgC897w3Y3qxkoABAF3X/zu7Np2HKfJVXM/B
        xgCfjRJ/w1hHCUpfGpUJBhw2LJwIeiw=
X-Google-Smtp-Source: AMsMyM5o6nSh1kV89+plEOjs6N42HrWKkJIJWNiyPkqCV6uW92jH37R8WZEFsSrUuRRynlDFglAlPg==
X-Received: by 2002:a7b:c392:0:b0:3b4:acef:3523 with SMTP id s18-20020a7bc392000000b003b4acef3523mr6129332wmj.37.1664547017312;
        Fri, 30 Sep 2022 07:10:17 -0700 (PDT)
Received: from localhost (94-21-37-194.pool.digikabel.hu. [94.21.37.194])
        by smtp.gmail.com with ESMTPSA id x16-20020adfdd90000000b0022cd27bc8c1sm2738816wrl.9.2022.09.30.07.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 07:10:16 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/6] t3404-rebase-interactive: mark a test with REFFILES prereq
Date:   Fri, 30 Sep 2022 16:09:44 +0200
Message-Id: <20220930140948.80367-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.542.g9b62912f7f
In-Reply-To: <20220930140948.80367-1-szeder.dev@gmail.com>
References: <20220930140948.80367-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test '--update-refs: check failed ref update' added in b3b1a21d1a
(sequencer: rewrite update-refs as user edits todo list, 2022-07-19)
directly modifies the contents of a ref file, so mark this test with
the REFFILES prereq.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t3404-rebase-interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 688b01e3eb..7f0df58628 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1964,7 +1964,7 @@ test_expect_success 'respect user edits to update-ref steps' '
 	test_cmp_rev HEAD refs/heads/no-conflict-branch
 '
 
-test_expect_success '--update-refs: check failed ref update' '
+test_expect_success REFFILES '--update-refs: check failed ref update' '
 	git checkout -B update-refs-error no-conflict-branch &&
 	git branch -f base HEAD~4 &&
 	git branch -f first HEAD~3 &&
-- 
2.38.0.rc2.542.g9b62912f7f

