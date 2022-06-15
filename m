Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C0DC433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 10:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347361AbiFOKxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 06:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346496AbiFOKxl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 06:53:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5FC50B24
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:53:39 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i81-20020a1c3b54000000b0039c76434147so914495wma.1
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=emBhEpvWlEQsOUu/N8nLaPfEIXOnRdqe/CuuQ5lT1Us=;
        b=dWLiOHAG3S1Q8JLSgvQ+GcgSuvVXzia8r8JTdhRPA0xTmjrgkUOtlRrNMl3JQ+bs7k
         NgK2AEnomXRg/hEzkSqrPIlCaHHk0Fu1DIqPh80j2Ee0uiu8X1kShhuQbMBrVRFmLVoY
         E58Xkk5hbEE4LTt1gpAldY0ynD+NVXRAOP4jUffDDlry6+XJJVwO9ATNCXcIRLoGkpXk
         nDkqlEL/GXE7yHSID8tKjIFrNPDdNtQ4hZ2+gyxvXL7Pg52VPriC/zEWINF7M1b0Vtdt
         hs0U0q/FpEd7HdPNxQvLAyHcGz8u11cdCYs95t+URMm9XdqHMRS0LtBQlk26KivaRLeH
         X7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=emBhEpvWlEQsOUu/N8nLaPfEIXOnRdqe/CuuQ5lT1Us=;
        b=k5dwrpZ55OYDQFoffK5hXHAzMphbmnPJ9+udtp8CV4ktrvN5xhhsL0FkPC+UhPIjOh
         iLfeJdEYuvFTdfrWhXtEMJBEGqhHDaMHN4MO2o9fRB5AFlHRycTvEI5/k00lz+KkgZlP
         tZCvz8MGhEYQDGb2Q2yZIzddSiXRo/JP4iZA5kcomAr5eVbd9v9IY4H1qMtMOMiDa64b
         5sBjtsEgd2FjBeRTNNHgPhmlLegwg5qmVOSyucWoajRzKrOmwwtIMaqQKKNAXRUohS/V
         RuFWKpqoVqZ96RnJSSDdb/tgs6kPeUnFyMO33vNMCEML/AmxhOi6wI3YGWyW/qDxatiS
         xaXw==
X-Gm-Message-State: AOAM533fUyTrqRBTfFwb0Tu5Xm6dyom8My/P9czmVcpBwRn6Gkpx5y0x
        A9one6SivY2Q87DeLfaDpm+14ZdIL+TRlQ==
X-Google-Smtp-Source: ABdhPJwGeSgJ4ozzlL1Fg3xjrt23mTIpw3FU/gnlEEaKH8dqnO3zotiA/ZTh0YEKs4WF6CjFPASwHA==
X-Received: by 2002:a05:600c:4f96:b0:39c:7bd0:d4c8 with SMTP id n22-20020a05600c4f9600b0039c7bd0d4c8mr9115455wmq.16.1655290417492;
        Wed, 15 Jun 2022 03:53:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g12-20020a7bc4cc000000b0039bc95cf4b2sm1786747wmk.11.2022.06.15.03.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:53:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 1/5] push tests: add a missing "test_line_count"
Date:   Wed, 15 Jun 2022 12:53:28 +0200
Message-Id: <RFC-patch-1.5-a1245bd3139-20220615T104503Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <RFC-cover-0.5-00000000000-20220615T104503Z-avarab@gmail.com>
References: <RFC-cover-0.5-00000000000-20220615T104503Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "test_line_count" missing from 6dcbdc0d661, we'd clobber
"warnings" here, but never test its contents.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5516-fetch-push.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 79d8a7b3675..4b32ae39a39 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1860,6 +1860,8 @@ test_expect_success 'push warns or fails when using username:password' '
 
 	test_must_fail git -c transfer.credentialsInUrl=warn push https://username:password@localhost 2>err &&
 	grep "warning: $message" err >warnings &&
+	test_line_count = 1 warnings &&
+
 	test_must_fail git -c transfer.credentialsInUrl=die push https://username:password@localhost 2>err &&
 	grep "fatal: $message" err >warnings &&
 	test_line_count = 1 warnings
-- 
2.36.1.1239.gfba91521d90

