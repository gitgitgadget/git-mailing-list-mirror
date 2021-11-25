Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57695C433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 12:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351827AbhKYMbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 07:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241622AbhKYM3k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 07:29:40 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12800C061757
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 04:26:29 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 200so5131911pga.1
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 04:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gX0UZQ4pMzBDmzjK0FycRV13WSC5VVRs6IDRB7uyUg0=;
        b=Mr0yTi6ThUy2TySt0HLGU0mbnCTPBYtzw8bdlt0ZhjGESiLGzlTqwvVGDeuYLcfyYs
         5xqQQrUc7olU0suYVgwXfNiF3AQDrNVkey5J+3ufEaCQtJ0lFBxI5VlXVoWrrLO6wpF2
         wXwJRmzNpa1RKBQBDDn3RGqRsRlkggTY7SIUaxpLnQ5v+oJY9hTxtYyVZll+H1mbnNG3
         DaFdVmpHv5ogydlxK94E1hrIGY0F4IBIJIMWmatxHKddcE4zvrRZRd7wJpN8MR6NO2ci
         l16z/8fymJuuLAdOONqGs49dAcpnwdDBjAg2PrOp3JKYnSCRJhrcwkTnMvbcORIrrp4d
         dtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gX0UZQ4pMzBDmzjK0FycRV13WSC5VVRs6IDRB7uyUg0=;
        b=cpCjbv3vV36OXes4RczmtEWwMBVXLd7pdnrj9fac9YB80Ebe5i9iCkFw4CSjfV6ega
         J50XsVSorQF0fvMFnJOrAxET/RrRe2PL1L3oGKs8nrldTkgu5Nt+EdFc7QxSDHvF5n1c
         9qbJNQApbigsFK40/kp/0NvN2zqboYqTVwfa1qFFXtdjZOWV03JiJCouyCRnVtCZrGKG
         3KO40VvhLIj6OgUFn5EfKpnLlVtCIkQom5uJXVfMRIJMHi/d4emZ4lC0ezHjm9hBAnEf
         e1oppnHae8U9fqlJzOgWVlt9ja76seD4HR00f30t2Ts+T0CBjV5daS+aRwEIaYb67+Z1
         eE1g==
X-Gm-Message-State: AOAM5315RiBacz7/MtkIRGiVSCuF2TkNgjUpBJh9bSw462FTDz57kyjS
        O/ZkFwTGdaiPJhkfSkmXFzYxqbKG8DU=
X-Google-Smtp-Source: ABdhPJyYYR/Dk8aIG/yXrP0VBkJ91G1qpYXOzn/TvQx5jiXFVyWftv+/1LNp3G59wSgjiTyvjYhgog==
X-Received: by 2002:a63:1b5c:: with SMTP id b28mr15965031pgm.316.1637843188372;
        Thu, 25 Nov 2021 04:26:28 -0800 (PST)
Received: from ubuntu.mate (subs28-116-206-12-38.three.co.id. [116.206.12.38])
        by smtp.gmail.com with ESMTPSA id p3sm2846934pjd.45.2021.11.25.04.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 04:26:28 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] Makefile: error out invoking strip target
Date:   Thu, 25 Nov 2021 19:26:08 +0700
Message-Id: <20211125122607.26602-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that $INSTALL_STRIP variable can be defined since 3231f41009 (make:
add INSTALL_STRIP option variable, 2021-09-05), it is redundant to have
'strip' target when $INSTALL_STRIP does the job. Error out when invoking
the target so that users are forced to define the variable instead.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Changes since v1 [1]:
   - use $(error) function (suggested by Ævar)
   - message rewording (suggested by Ævar)

 [1]:
https://lore.kernel.org/git/211123.86a6hvuikj.gmgdl@evledraar.gmail.com/T/#u

 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 12be39ac49..d569b5cba8 100644
--- a/Makefile
+++ b/Makefile
@@ -2159,6 +2159,9 @@ please_set_SHELL_PATH_to_a_more_modern_shell:
 shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
 
 strip: $(PROGRAMS) git$X
+	$(error You are about to install stripped Git binaries using 'strip' \
+target, but it is deprecated and will be removed in future version of Git, \
+define INSTALL_STRIP instead)
 	$(STRIP) $(STRIP_OPTS) $^
 
 ### Flags affecting all rules

base-commit: 35151cf0720460a897cde9b8039af364743240e7
-- 
An old man doll... just what I always wanted! - Clara

