Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3BBC77B7A
	for <git@archiver.kernel.org>; Sat, 20 May 2023 16:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjETQOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 12:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjETQOF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 12:14:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDB3124
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:04 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-309550d4f73so1188736f8f.1
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684599243; x=1687191243;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1nYytEFp0cKqGOQAO2UhL2U1e5wHcXRkcg3rOj1KQk=;
        b=l5mFP01Pk9s6/SaEnTLeCPMyK8HsDzPDKYMQIRYySM6UB3o2UPlpZ2nw1nzaBOVviY
         91Y0UMlKdk04bWZXAE2Ip1u0BsRTNXqOTSBcQ20V3xyhXA6PA9+onnmGRwzdYr5sSdzK
         iUYmlw9C614GXPgum9B3QImdfdNJGXCN2mORNowvWwQDEfma8iOwHWpcEaQSxtMeMPk4
         8AG0zHQ4Cptm5l1Fx+XtrwQaErIViVQaWAXVvw1d+t0Sz+Zir3kjptCot/sVrrDEcjPn
         hvv7vvAz1x1YJky9IP1VTfYg5+IrkldB4uMSaN+6WBcCL+L9inn4R/5q4ddBrzuCNWuo
         nJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684599243; x=1687191243;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1nYytEFp0cKqGOQAO2UhL2U1e5wHcXRkcg3rOj1KQk=;
        b=On5n2TcdSrH0lQ42Gow07lXavVoA04GeICO0s5+VvjdelXN8Z1er3P0T0qYUQkSRAS
         lNAx1C1yR+j2yBgPrPuXpkLMX/zpHvbRQv4P6WF/nkZUJm55RkqRWBWOThlTPIHKgdJO
         QbsxzeGv1A5cPeqlfzIssKiBRbXvBEaXc1GRTgF6NhQT69S/DcP8CZOooymNXubo0kV4
         24/5ODEldHbS5kfcpJjwNfolPNIS2LiKYUi6d3k3bGzIklNBSkNK0f4jQvYdriHyiOqe
         j+vmq601axkRMXyZ+7C/ttfOXaEdG/xOGPtMdEHpS/d9vcBWHNnHpgCfItk/5etyq3xD
         UguA==
X-Gm-Message-State: AC+VfDz9nJT+eayagGGTFdR/Lq4FI/eIiPfNByYu+kZdklaOD5JvjKLR
        T2XXEUNqcYhA2GL1jyUmEeFpXQ6YSXs=
X-Google-Smtp-Source: ACHHUZ6HaoZ3zenRfn2xsJk0WjCGYjK3UbbTCYumYIsGJ2u2lL1W06QmkLfe9i+7F4D0+FEwjKuUZg==
X-Received: by 2002:a5d:63c2:0:b0:306:2d81:341d with SMTP id c2-20020a5d63c2000000b003062d81341dmr6026233wrw.24.1684599243034;
        Sat, 20 May 2023 09:14:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w16-20020a5d5450000000b00306415ac69asm2362763wrv.15.2023.05.20.09.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 09:14:02 -0700 (PDT)
Message-Id: <5c953b3d1055522e29ac40dfffe21a48dbaa1900.1684599239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>
References: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 May 2023 16:13:52 +0000
Subject: [PATCH 04/10] t7508-status: modernize test format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Some tests still use the old format with four spaces indentation.
Standardize the tests to the new format with tab indentation.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t7508-status.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index aed07c5b622..a3050adfd07 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1519,8 +1519,8 @@ test_expect_success '"status.branch=true" weaker than "--no-branch"' '
 '
 
 test_expect_success '"status.branch=true" weaker than "--porcelain"' '
-       git -c status.branch=true status --porcelain >actual &&
-       test_cmp expected_nobranch actual
+	git -c status.branch=true status --porcelain >actual &&
+	test_cmp expected_nobranch actual
 '
 
 test_expect_success '"status.branch=false" same as "--no-branch"' '
-- 
gitgitgadget

