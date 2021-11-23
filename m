Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C83BC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 12:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbhKWMc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 07:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbhKWMc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 07:32:56 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF49CC061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:29:48 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so1962676pjb.5
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 04:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8L69bMpQ3vho1BEzMxkPFfRm5jtaNGfJ25sYJR3q19Y=;
        b=X7slZxM4f5X6+XEGXgI1Na6DQy94t1ym7gtZ1opHy5Ht8X93y9XBV6TZpkO3uBCrSd
         YpgWiI9xtK7N6cufSTVaZfgh1NypF3fX8m9fq0dOhVVaIjyCQOPRB1aMeqrAlXxoRoNC
         CByCe90AQUsqwvx561NsyIEFVgsf16KUuqWJ4bl0pREzVNZMFzByxLna2srb6IpvWuxK
         /sujfNGfEYj7qXdl2n9lg8GJDGBDivfmvtT3Gf+JjQk3fLrzfDEn0bQEpEx+4lGUUhCV
         bgJcYdA2WbQ6UV2fGZb8AG+4BZ61hSWeFuymueN3xnijTXtn4qL/jbypBMcuLeHgnonq
         XB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8L69bMpQ3vho1BEzMxkPFfRm5jtaNGfJ25sYJR3q19Y=;
        b=c77Df5zdWyLlxQzyu3yHb/pSmrgIfwPmsFvJilgGWj4vrVlOZizoMuNchvQnZHOqiA
         zo57uQsnEy/9Ioy1jZmsgafb6w9FMA8c3SpJaAg07ndXHvEC0f4aawJfWNTqWsJ1df8y
         ryk8Z42M98rM6/z3IgJ4ZLrWwHYV2rhkvU2zcfjnQGkP3yTP9tPbGGz9b++XM/q+zdLn
         m79Q0e9Jq/O+OJaMx30cc5tj/l4E/RDo4Gr8FwQmoRVW+1jbqYwEmUERa4B94743tzYF
         +zg+8zo1nfhjywVFRkcCeJq86JMF76MijseqGnl7WeUQCud9Jgrw5LdlmKELbLD95zyr
         +sIQ==
X-Gm-Message-State: AOAM532PRGPBL1jvpj4OCmiZSCCkMf2ARhEAxvYmCsQ9X9oAZXG+LITw
        Ql7Rlji5r1AVDk4tuNZIFrWYqcXBCEI=
X-Google-Smtp-Source: ABdhPJxPzmt4gpOQ/izrr06XCLQOVocNgrTxgZ1ymn51Uiny+wt9cbiQ8ZpJyZ0a2hD2zMfkcG6xTw==
X-Received: by 2002:a17:902:7005:b0:142:4452:25de with SMTP id y5-20020a170902700500b00142445225demr6344188plk.3.1637670588275;
        Tue, 23 Nov 2021 04:29:48 -0800 (PST)
Received: from ubuntu.mate (subs32-116-206-28-30.three.co.id. [116.206.28.30])
        by smtp.gmail.com with ESMTPSA id a23sm8947036pgl.37.2021.11.23.04.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 04:29:48 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [RFC PATCH] Makefile: add deprecation message for strip target
Date:   Tue, 23 Nov 2021 19:29:33 +0700
Message-Id: <20211123122934.639428-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that $INSTALL_STRIP variable can be defined since 3231f41009 (make:
add INSTALL_STRIP option variable, 2021-09-05), deprecate 'strip' target
to encourage users to move to $INSTALL_STRIP. The target will eventually
be removed in Git 2.35+1.

Only deprecation message is printed.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 12be39ac49..ee83860f7d 100644
--- a/Makefile
+++ b/Makefile
@@ -2159,6 +2159,8 @@ please_set_SHELL_PATH_to_a_more_modern_shell:
 shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
 
 strip: $(PROGRAMS) git$X
+	@echo "The 'strip' target is deprecated, define INSTALL_STRIP if you want to"
+	@echo "install Git with stripped binaries."
 	$(STRIP) $(STRIP_OPTS) $^
 
 ### Flags affecting all rules

base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
-- 
An old man doll... just what I always wanted! - Clara

