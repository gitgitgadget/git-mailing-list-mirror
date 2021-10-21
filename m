Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A3CC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 20:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D47761251
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 20:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhJUUCf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 16:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJUUCe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 16:02:34 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE33C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 13:00:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 84-20020a1c0457000000b003232b0f78f8so949187wme.0
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 13:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M5o65CH2LO9Fhmmd+0Y11FgI0qcsYlGM2px7sxGAzdw=;
        b=O0CthDjb70g9xqTOoZWGrD8G8b90ezBJegPmr7O0iYSm5d0Rm72uF51JlyJ2qM/j5Q
         benFBbBe50EWdqWYkeojMFrtoTJaqjrT/Ar6jA1NtgvJJpVOd8V+zaNUgktwB1XvELuN
         Kt+6vTjqtPt/nyV82aROe0LNVZHB+U0Apzc1iW2lPWwqcrFo3gR+TSD98u3nxT/yTiEZ
         okZsCmpDEDdolOUgkARJMdejb+BDtO0opN4Ko00gNxm/1R11NbUUkIdSw86D0XnPt+0W
         BXJv0dlSLZjsg6927lpLAlplez3sgRKuVudKMx8sPF9oJJiJEUFFdhBukrSkfSJlfwem
         vo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M5o65CH2LO9Fhmmd+0Y11FgI0qcsYlGM2px7sxGAzdw=;
        b=8H+1tg7cYtsgrB78mley9RIhlMw7foD2Ft4EsDxWliJA19JYWKcbIGKTOvldGsUH01
         zTdcosONtpI1znfvbD5hKyTERHlTZzHF6kIHN8BLXqvsOr1app50JfZRlH9/ABKmf2d7
         CE8MhWDXnZ3HYiI5zKaxMhz1i2JOCvRHpxcjQKsaPZ7YcE1vnobmNIbZ9S7wkbxLaV8C
         MtZIkrRQ086oCHjVejgD+MrJ2u1d/59Anuc513p7TLxk4sK8tF9tntG3Dk7kgspdTNyu
         wHaRnumOokccPrfK772QKz8IcMbh8QmOhkxGpey31R/1ltmqLf9hYg6R1rQIrDJLNoBj
         GQ4g==
X-Gm-Message-State: AOAM533V7tph4UNSjikKEgEUs6R5e7uD+A5gz0q06//iBGoKZs6CTjD4
        GBaz5n7LXqyv6MjtxAzYvh5NxnRXXdxUJw==
X-Google-Smtp-Source: ABdhPJyfgPgaToTga3CQIsY0VR1T9G5vplLkry6OfGq1LZo4YzORXa7jeWNvSL7Oa51pc16tpR7WHQ==
X-Received: by 2002:a7b:c3d8:: with SMTP id t24mr23657893wmj.102.1634846416237;
        Thu, 21 Oct 2021 13:00:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g10sm7074014wmq.13.2021.10.21.13.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 13:00:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] Makefile: remove redundant GIT-CFLAGS dependency from "sparse"
Date:   Thu, 21 Oct 2021 22:00:14 +0200
Message-Id: <patch-1.1-207f1019e70-20211021T195940Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "sparse" target needed the GIT-CFLAGS dependency before my
c234e8a0ecf (Makefile: make the "sparse" target non-.PHONY,
2021-09-23), but since then it depends on the corresponding *.o files,
which in turn depend on the correct header files, as well as on
GIT-CFLAGS. There's no need to re-state this dependency here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
A tiny redundancy fix for an already-in-master topic.

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 381bed2c1d2..12be39ac497 100644
--- a/Makefile
+++ b/Makefile
@@ -2901,7 +2901,7 @@ check-sha1:: t/helper/test-tool$X
 
 SP_OBJ = $(patsubst %.o,%.sp,$(C_OBJ))
 
-$(SP_OBJ): %.sp: %.c %.o GIT-CFLAGS
+$(SP_OBJ): %.sp: %.c %.o
 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
 		-Wsparse-error \
 		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $< && \
-- 
2.33.1.1494.g88b39a443e1

