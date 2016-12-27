Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75D66200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 19:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933095AbcL0TgX (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 14:36:23 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34438 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933079AbcL0TgV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 14:36:21 -0500
Received: by mail-pg0-f43.google.com with SMTP id y62so95665502pgy.1
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 11:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I9FzD+7738NaiGQAeYN9gQOnbxvFqd6klXwiQpTDWy0=;
        b=Aoinh9VbvBEGReorHjKQZsl9Izjgm6vyHp6SmjGcScT8WJ9Rw0s/xop1lFo+9TznEn
         iyb4yvvZ0fA3UEDcSy6EzBJ6+q793aKn/T7QXbndB83P4tfHp69LNWn8HhW6ujRTDFVD
         2D7XirFscoY5AXwtiTL1aWFfhAwazZcWq80+A+p24YlRk6BCSko5if83WqLR6Kh3MbPE
         03RND+6HnCxoFEcUrTzFA+qsIwnHAIRWe2hYqzVZsd2zK647/oBKfjx3bgmMmeawj8A8
         7FtJx5CNoVSl2xODKRZgGqiZmHRPD/CWNjhsMiuyh21otAZ/Kh+JuNIOR0P3wzJbRCP4
         2mFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I9FzD+7738NaiGQAeYN9gQOnbxvFqd6klXwiQpTDWy0=;
        b=PutSxfs0FdzIg7fUKf0B98eBdP88DbTa19lWsI0arjCGW0wcyGvcfIw6kH67n7s/1u
         6kqu/+Mzz3OSbvp3e3mraexwdz81vSOTWtNkxH7XaWcmDvvay7ZLiWyQBdO83qZkGp69
         RacEbF1WSboGf3tFfRhdTZUMCWMT4cvb47m84mBb0hD0WPpMv8hNinVuLGk7fLKPqRqQ
         zxMK8bhErkqej+X13S2qFkrN/zN8T+Z2ITUS6GS0DOqAamcHT00Szsjwyw+H3tg6TzSD
         LqUX8J1b/rfg/tBqg6gE7S6+3Cw8cuUaaCX19Wz68pq81vRfaXkBxblcRyYL9YPHp45c
         +jkg==
X-Gm-Message-State: AIkVDXJBMT2IR24rYGb4lbvSm7QefgtB1IRlt7bflWqdIorTaNkpBIsj0d/HdY3hpzLsQrN7
X-Received: by 10.84.164.162 with SMTP id w31mr69883233pla.9.1482867380278;
        Tue, 27 Dec 2016 11:36:20 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1aa:810:98b9:be05])
        by smtp.gmail.com with ESMTPSA id c8sm91466069pfe.15.2016.12.27.11.36.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Dec 2016 11:36:19 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] t7411: quote URLs
Date:   Tue, 27 Dec 2016 11:36:04 -0800
Message-Id: <20161227193605.12413-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.50.g8bda6b2.dirty
In-Reply-To: <20161227193605.12413-1-sbeller@google.com>
References: <20161227193605.12413-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variables may contain white spaces, so we need to quote them.
By not quoting the variables we'd end up passing multiple arguments to
git config, which doesn't fail for two arguments as value.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7411-submodule-config.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index 47562ce465..3646f28b40 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -120,8 +120,8 @@ test_expect_success 'reading of local configuration' '
 			"" submodule \
 				>actual &&
 		test_cmp expect_local_path actual &&
-		git config submodule.a.url $old_a &&
-		git config submodule.submodule.url $old_submodule &&
+		git config submodule.a.url "$old_a" &&
+		git config submodule.submodule.url "$old_submodule" &&
 		git config --unset submodule.a.path c
 	)
 '
-- 
2.11.0.rc2.50.g8bda6b2.dirty

