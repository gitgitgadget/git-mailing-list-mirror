Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41AEC433F5
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 10:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiDHK46 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 06:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiDHK4z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 06:56:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FDAF3A66
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 03:54:49 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d29so12220837wra.10
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 03:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7JsObW2TFPDVGO3lpMATclxMhCqQTBvKbbuasbCSk14=;
        b=Cgi22/EiukzXYgOKFo5RMoRGf8z2skShUknBakSW80SMNCdt1kHOrybxr04AIyq/dS
         +lJOXH50ajBOgqpdRI3shuwHkpNBWkqx8XCU2kcdeUjXWhAd+rNXnlyfUfDbgZnuDzl+
         lYv7swF2WnIeMffB4F1gq5I++8SFRCHxxvwFkymc/p7lLoQhmOoOj3sj5lEgS02lBf/u
         8iFffFShpcaBr4Dq33wemPwrFpBmZqhPvRGRmmXYAVH47WAPX+bM/MT8REVnJqUEKx1h
         /n+qI+qhTmkabz18GjWiuFgiYCdp7gSzlkqHKqenyp5NaCMooDBBpeq5TJzDRZUREMpV
         p9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7JsObW2TFPDVGO3lpMATclxMhCqQTBvKbbuasbCSk14=;
        b=WChUTUl1iV0HF5u/AkDgqr8R3UAKB/W7cCGJ4xXdGYv7bh64o0sLtM/ErKfGKUK3Bn
         Vw7lCCTMgVujx9bUBaSer7NmIsJcf6ZauYSR0npBQlK9/b8IQS4D9Ytw2RqSxfvlb7kU
         d3X94mE/sEJP4bCZF1qnlsDC0nZbElRSP4PJ8vKn09xtZUKgppScrNqN6IQmwD/M4XEz
         H/GxjUKSLcB6Iw2+0WiYIb+tRqwckPvsOgt/WYvt5BKY07GRiOVICWq1dxy2FMydO4dK
         ELkTc7aWLzDi3vLiVZM4QGJssdD4amtWaZEDigEoCz4LRWVtU0IbzyaoQu9oCXUAyEa3
         nlCQ==
X-Gm-Message-State: AOAM5319bltrgo7/qBEGbs4mFY20x3DOUtIpVXzPZ44yY8wolnSjkXic
        QG2UZNonFN9ovbTUn7mU1F/+pIsac6c=
X-Google-Smtp-Source: ABdhPJymPH1Ms5AA3wq4yK+xDkjekBT8rJufLZx51l7nvyXUXP1ea7acKRNmkVfTA/LCfWiOy3/8YQ==
X-Received: by 2002:a5d:59a1:0:b0:204:1777:fc08 with SMTP id p1-20020a5d59a1000000b002041777fc08mr14230255wrr.545.1649415287787;
        Fri, 08 Apr 2022 03:54:47 -0700 (PDT)
Received: from fedora35.example.com ([151.24.233.140])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d6488000000b002051f1028f6sm22819858wri.111.2022.04.08.03.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 03:54:47 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] Makefile: add a prerequisite to the coverage-report target
Date:   Fri,  8 Apr 2022 10:54:43 +0000
Message-Id: <20220408105443.192217-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Directly invoking make coverage-report as a target results in an error because
its prerequisites are missing,

The patch adds the necessary prerequisite.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e8aba291d7..d9e8dd331e 100644
--- a/Makefile
+++ b/Makefile
@@ -3409,7 +3409,7 @@ coverage-prove: coverage-clean-results coverage-compile
 		DEFAULT_TEST_TARGET=prove GIT_PROVE_OPTS="$(GIT_PROVE_OPTS) -j1" \
 		-j1 test
 
-coverage-report:
+coverage-report: coverage-test
 	$(QUIET_GCOV)for dir in $(object_dirs); do \
 		$(GCOV) $(GCOVFLAGS) --object-directory=$$dir $$dir*.c || exit; \
 	done
-- 
2.35.1

