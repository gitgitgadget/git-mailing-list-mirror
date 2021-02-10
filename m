Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574F4C433E9
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A5C64E66
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 11:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhBJLmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 06:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhBJLkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 06:40:16 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649B4C06178B
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:38:15 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id j11so1038927plt.11
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 03:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QfRqLLBfa5FafOzIdyRirhoYL+y71Pq8hRwdx2VAx7A=;
        b=Ht1NJ7FKzyFX5Igg5qrmdYWm2QVkVZXYcxx/8QONfekNybABWxTInSkqo0x8vJPnnN
         0VDkDdW6eEuGT3khQzLxgXP0IuRq9EgZm7FimPVYwvZFQ9lZ7uyCSb4thruPWCjwms86
         KowdO2dYjFOmb6LOJ0DSsvxw1ssP3GrXgNl3L9bWcvhw43oEQnbglR9ceedSC+AYwGn2
         464ZmLtOldnRfad4BUP2AsS/y6vu2zQtuYw9Ec6iaj0HFdy/WNRqJXQhmsNU/iAdlFjA
         uJznpclqH5GrzilXK6RmJ4LkO54Ayx4ZjD5MSrwMy8E70k2PfUcVIFwOkR/MqQVRoKEo
         46uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QfRqLLBfa5FafOzIdyRirhoYL+y71Pq8hRwdx2VAx7A=;
        b=WuRBXKTGVHDp5aYccqGyRBY8b7v1+VkDIZz0KU2qt+2HtyB3mk9zN3UuROs1w5cKd6
         hbjhQXdUKprpqDPi6Mols7sTWFWYS69wB+pL+Oyl/kcBTeM5olS4RhWqcz2/iKFuna6c
         ebWWv7TAzvIMmDEdy6jlYlpBCK9MlETir7VsuM195fugFSa86V2RwTWkDx4QE+9sBygn
         dtqvqWzb6MMlvtJCyfH/D8Css1+mnD+qoN67Y8G0v0aOnvCUWjuc8Xt43r6xlNlDslMc
         ux6+iOrjPl0t/WkcmYXQ2u4AVKGFwirsZfSVCQvlDxP8vxIUtVQlo9vNF28yKRS9K82b
         b0Aw==
X-Gm-Message-State: AOAM531gczWTWJWcjc8rME1wndpWMCLEsIRiBRZT1YiHtXok1yt5dvLB
        m6a8YpIsVl5fY4GpMoRjzkHOrlql12YMOA==
X-Google-Smtp-Source: ABdhPJxxDzkf+Mw2OtL4P6rYJE9e2nCgzr+WUBpYTCA81Vsd984aVW0e9rBeFu883E3OOB1XVzQRGg==
X-Received: by 2002:a17:902:b40b:b029:df:cf31:2849 with SMTP id x11-20020a170902b40bb02900dfcf312849mr2757474plr.33.1612957094777;
        Wed, 10 Feb 2021 03:38:14 -0800 (PST)
Received: from localhost.localdomain ([171.76.0.223])
        by smtp.googlemail.com with ESMTPSA id y3sm2123731pfr.125.2021.02.10.03.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 03:38:14 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 04/11] t/lib-rebase: update the documentation of FAKE_LINES
Date:   Wed, 10 Feb 2021 17:06:44 +0530
Message-Id: <20210210113650.19715-5-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210207181439.1178-1-charvi077@gmail.com>
References: <20210207181439.1178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

FAKE_LINES helper function use underscore to embed a space in a single
command. Let's document it and also update the list of commands.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/lib-rebase.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index e10e38060b..57cee517b2 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -15,10 +15,11 @@
 #       specified line.
 #
 #   "<cmd> <lineno>" -- add a line with the specified command
-#       ("pick", "squash", "fixup", "edit", "reword" or "drop") and the
-#       SHA1 taken from the specified line.
+#       ("pick", "squash", "fixup"|"fixup_-C"|"fixup_-c", "edit", "reword" or "drop")
+#       and the SHA1 taken from the specified line.
 #
-#   "exec_cmd_with_args" -- add an "exec cmd with args" line.
+#   "_" -- add a space, like "fixup_-C" implies "fixup -C" and
+#       "exec_cmd_with_args" add an "exec cmd with args" line.
 #
 #   "#" -- Add a comment line.
 #
-- 
2.29.0.rc1

