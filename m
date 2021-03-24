Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4C7C433E5
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F0F0619EF
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbhCXBtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 21:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbhCXBtT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 21:49:19 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9A0C061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:19 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso338621wmi.0
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6PFl0iDxkj7zVlpuhq9V6NKTYKrJyJcPq1OwIosD244=;
        b=tkTZSFk+wIeXTfgW6ok6IK57p0m9TmOlRt0bv3lywFVVbS60F70fbYGVUG6wVKw3Ja
         t7YyuHUuQNGe0PvALxK44VD3x4z62TKiDqD/BM2cs2qd6DEaEC8FtMEX52oux+HcI6vB
         pyO0qJprzfqr4YR4gPpPIjKgB/xP6TVSrScI1PDVuhz5hFy8lqA+8fn8uRQkrZAyrf2C
         5zEivLsw9V4xhPnaxPxC/9LZ3XreUuk+cTDw/wBoeKPcXIEGpioec9IE5az0e2gcqKxt
         wHiwI0ngPsDkFl/LClWX+4gS0lldiXIbfx3m8FKkWS0G+yC7q2EV9URAjbMO4vBNVAjc
         b6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6PFl0iDxkj7zVlpuhq9V6NKTYKrJyJcPq1OwIosD244=;
        b=J1yipEIwXx7U0Xv2Qc/y69llsi8Y93xjSiLLMokb1KhPYPDnLRgrL4wlQW3DLZ6npx
         9MxdRQtT0TxQq5RbHfFPamyv96zXhvgLvjWtLWkHMAJhIcTPLEYBv6FaaELNa+ZCpRkI
         Qj1R4KQnY29uoQEtbezAp+ZslI8ijc8YsHfEs+RSoc8hwxq9wgF9Bp8j3Q6dV7dFek7L
         k5kW0eZFJrylhvayg3+0AR8Yn5TE2VuP7CrEBJLosvAk6+uvTTLh8CgkTC7OnapUpGMH
         X9JFBRk9yI71oBEa255zlBbMP6AOU6a0LvpS+7NRFUQaahqLBz/HPXdkd79bYvm+dWpy
         3bUw==
X-Gm-Message-State: AOAM530crTUg+QctUJjrKB/MBPS3Lv9UrVu6D/6py2MlKIZ76ZrQ3fte
        +gAA8Yj8pjBpnEY/DjGfIARn5ptr5BClWw==
X-Google-Smtp-Source: ABdhPJxtRb0wJx6o8iepJE9NcY/peHSWpX6IyPv3mSXXc5mv1l9qT98bGTn5xVSOQJGuTZgWOpDVjw==
X-Received: by 2002:a1c:a745:: with SMTP id q66mr587587wme.21.1616550557652;
        Tue, 23 Mar 2021 18:49:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y205sm598177wmc.18.2021.03.23.18.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 18:49:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 04/10] userdiff style: normalize pascal regex declaration
Date:   Wed, 24 Mar 2021 02:48:46 +0100
Message-Id: <patch-04.11-1e9ddcd1a9a-20210324T014604Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.366.ga80606b22c1
In-Reply-To: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
References: <20210224195129.4004-1-avarab@gmail.com> <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Declare the pascal pattern consistently with how we declare the
others, not having "\n" on one line by itself, but as part of the
pattern, and when there are alterations have the "|" at the start, not
end of the line.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 userdiff.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index c7aaf7094f8..10a02d36209 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -175,9 +175,8 @@ PATTERNS("objc",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
 PATTERNS("pascal",
-	 "^(((class[ \t]+)?(procedure|function)|constructor|destructor|interface|"
-		"implementation|initialization|finalization)[ \t]*.*)$"
-	 "\n"
+	 "^(((class[ \t]+)?(procedure|function)|constructor|destructor|interface"
+	 "|implementation|initialization|finalization)[ \t]*.*)$\n"
 	 "^(.*=[ \t]*(class|record).*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
-- 
2.31.0.366.ga80606b22c1

