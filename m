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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF53C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4538F650FD
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbhCPQSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238601AbhCPQSH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:18:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55517C06175F
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:05 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id y124-20020a1c32820000b029010c93864955so1781807wmy.5
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aZXo0k/PeJc5QgNB2lSMf3sq1jDJDvbwkZfK9poiwd8=;
        b=uoe80b/GDZ9Du7v3jxPQQdpLWKUlzKbWqT0mPQSUJkUVMWjBR9aSbtLB0kBovPHTJ/
         HIgGuTbmo7F7y7SOxor8+5/fTGaPIzBcaYiiF1ely5trAc311PP7wDHJ/VbaDIp4Z06F
         RZWpYD0t5e85bOIi2ZIV0SHTmtGELPl7F86WtZUVS5hzvcVOItJ5jlDXrNUWqDpmzUaU
         GcXLGD9VX8odW0+EkzLBn92zZ/s10sIIVKK3Hjyoi/FtRmHtoe8Hfa5G8rEOZvOnxWmQ
         +8y5w3e+EgqLULtQDz7izLT4LT+E+tOLFbXUh9AhMpCVMc+LdQ5cI9vY0jzlxsJ5mAQr
         oCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aZXo0k/PeJc5QgNB2lSMf3sq1jDJDvbwkZfK9poiwd8=;
        b=OkA8UWcdnm33EN7+c/jzZvPaSIBHXmf49YHR3ut3M63Zk7EosckBbB0zDg1HMz9eH5
         C9nFRYK38G4m9hDwntZvv/bCeYd2u8dYkFvIuKcoG88y4o1V0AexxGCgzB9bp6mE0yBP
         2fvlXAABYBaz+QWsjOuypwnY6FcSXpWrNPpIPa/q58MKf+82g9HnyTDsVugarCxQCVuR
         DhVPLCf2ovOo5xxWfk9pSlGrHDsFfmqPyHAy3ZmNTM4HBcAovt+cGXvmw8gP6hPtHZNQ
         YjscGLazdORwOqGVQjkTpkg2VsugDT8LKDU6yPU5wWtZCkYri7SoNG0TtRc9S7qJ3Xg6
         kmzQ==
X-Gm-Message-State: AOAM530upgIt1PinRISJo/oB6grgRw1Fd0WpOd/dr+U4/ux5hEnqbMUk
        TBn01kxlhK1XYEpzgulF6sjH5nuEYOls8Q==
X-Google-Smtp-Source: ABdhPJzwEI9cpT/Xnybeo4yRGCfCrdtFrYZKvILkhnXq8Bpz7QWBlfUa8d82k/k37++WdKaSAlWUlw==
X-Received: by 2002:a7b:c083:: with SMTP id r3mr359989wmh.177.1615911483664;
        Tue, 16 Mar 2021 09:18:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:18:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 12/22] fsck.h: re-order and re-assign "enum fsck_msg_type"
Date:   Tue, 16 Mar 2021 17:17:28 +0100
Message-Id: <20210316161738.30254-13-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the values in the "enum fsck_msg_type" from being manually
assigned to using default C enum values.

This means we end up with a FSCK_IGNORE=0, which was previously
defined as "2".

I'm confident that nothing relies on these values, we always compare
them explicitly. Let's not omit "0" so it won't be assumed that we're
using these as a boolean somewhere.

This also allows us to re-structure the fields to mark which are
"private" v.s. "public". See the preceding commit for a rationale for
not simply splitting these into two enums, namely that this is used
for both the private and public fsck API.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fsck.h b/fsck.h
index 2ecc15eee7..fce9981a0c 100644
--- a/fsck.h
+++ b/fsck.h
@@ -4,11 +4,13 @@
 #include "oidset.h"
 
 enum fsck_msg_type {
-	FSCK_INFO  = -2,
-	FSCK_FATAL = -1,
-	FSCK_ERROR = 1,
+	/* for internal use only */
+	FSCK_IGNORE,
+	FSCK_INFO,
+	FSCK_FATAL,
+	/* "public", fed to e.g. error_func callbacks */
+	FSCK_ERROR,
 	FSCK_WARN,
-	FSCK_IGNORE
 };
 
 struct fsck_options;
-- 
2.31.0.260.g719c683c1d

