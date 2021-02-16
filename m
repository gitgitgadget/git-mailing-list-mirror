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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694F9C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 192E464DA8
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhBPL7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 06:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhBPL65 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 06:58:57 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFA6C061786
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:17 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v15so12587583wrx.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bIw2279LRaHtf9NZSvBiSplYQBrRSjMc6njd0ja+D5c=;
        b=QcTcJgF1BhAknzTjnA9WIHPgyN5H0lwEf0u7ry76wow9iUCT/5QjUUxflsqcM9yGXd
         C7ikoUGViYMjVAG2xAr5dF7xyL4/JpjpHoFKhu65VfGDC0vP8IxSn5gK+mfWABsRWmEx
         KMMxYrAGcMgpmK6nIXNLVgfAudC8jIl7gqtFrdbJ6RDzOhaYdnEBp4jj5tHUsxOy8icc
         yF4AcyeECcx5uFzJHWae7uhspYOulYLmH6uZ1LVzR7TxaFNgPoj5SViCJjIp+QOQj37g
         iVlgwe0X1u5oh4tTP4C8gevIxv0Lq7P9M2TMT9HHWFBMzVEYSucxaMxv4qZHTBoHbXo9
         KLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bIw2279LRaHtf9NZSvBiSplYQBrRSjMc6njd0ja+D5c=;
        b=UroR0tBBeY5PjoCyJeOeL7gnW46ZQQdaOp51IAngoZFQOhp8aYkIEGEUupk2O9Rcop
         O+zAyjW/UGHN84KbGxmytJX3W6Rsl8mWAx4XTEgMJwrsKjUV6Y03zRkROQE4j7T1R9gG
         tOt7xbY2S1ZHH4nL1+BD4oyz4LIUqvgBZvCdMQcKS+zL7dTxJLjptWny2O1wVrV2L9oH
         eIa8Ta1vuEEiMe9daRoeL/mYtIS/MYMnLhE1JFFo9tzI2LGPphN4g9d9hrfATLepl7Bl
         mejsMsHVgMFfT0oOixXEtJGZ4q89F9XUakbH4TXE6hYVHotFa2fYK3BkdiZIZPwcUwpJ
         yHMw==
X-Gm-Message-State: AOAM532JyRa7TdamsfL1R98XCzQGJlZWNFwRRnAwsPw1jHZz/hlc7nAi
        TRiPOXiuXdxUyD2GyZgXFv0fGrb5v9aIPA==
X-Google-Smtp-Source: ABdhPJxF3L5ZVXo5zrK6Dta25EBJLLDFaFsPr7ZoOY1oVHSryqsxDl3ts1oRSrpE0x7tkA8stlAQqg==
X-Received: by 2002:a5d:4850:: with SMTP id n16mr23797387wrs.296.1613476695699;
        Tue, 16 Feb 2021 03:58:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/22] test-lib-functions: reword "test_commit --append" docs
Date:   Tue, 16 Feb 2021 12:57:42 +0100
Message-Id: <20210216115801.4773-4-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reword the documentation for "test_commit --append" added in my
3373518cc8 (test-lib functions: add an --append option to test_commit,
2021-01-12).

A follow-up commit will make the "echo" part of this configurable, and
in any case saying "echo >>" rather than ">>" was redundant.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 1eb75d0d733..5af92347123 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -172,8 +172,7 @@ debug () {
 #   --notick
 #	Do not call test_tick before making a commit
 #   --append
-#	Use "echo >>" instead of "echo >" when writing "<contents>" to
-#	"<file>"
+#	Use ">>" instead of ">" when writing "<contents>" to "<file>"
 #   --signoff
 #	Invoke "git commit" with --signoff
 #   --author <author>
-- 
2.30.0.284.gd98b1dd5eaa7

