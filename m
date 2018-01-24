Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E56B1F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933157AbeAXLMQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:12:16 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45590 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932891AbeAXLMM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 06:12:12 -0500
Received: by mail-lf0-f65.google.com with SMTP id x196so4700466lfd.12
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 03:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=f9apXCOlCV5qT/u4pH0lVdktRN5bCPOC167+zbSLUkk=;
        b=i4CuOIkvTh7Vc6KZ9Bar2LYC6nnGzG7O4eHpJCIePIbKQpj4TB0piNbDAazIxNnqP0
         cyUOkjs99oBtm0LGP7Q9RPbKzgcsCMjr1Q4IBVHXz+I+WCStXvD6gQxipVkrNRzni6Ww
         cuSeJVGw0/go3jLvhn9/riRwo6dcWeVdQAHpjOJ0jMzBSIZg+qY232cXBV8059ndBg1d
         1FipfF7O1BJmJHS5Tn8OjgyPEgjeFwoVXopOKQ+si5xAXEUgiUjDlo7v0/aWqlyKdV7P
         53y4vnoHj8vk5UXRyj+eAo+JP28XZs8uRpEFHYhjFRvL0+K1ZiNuCazjDdy2OndZjaMu
         gu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=f9apXCOlCV5qT/u4pH0lVdktRN5bCPOC167+zbSLUkk=;
        b=jWdIOdhPsridYNS9+4tOAHoMi/KfrRQSeVi+1MHW0pRYAw0Hx5rSrJJFIuEikKgveu
         IJU5zK1laTee3A6L2JuuoBrTfrLfP40Z5q3Tw/KHMseTR8uTEiWc5qk6vArl/Q3oOT/p
         UbYYvpluVdDFnM3kDJQRPjSWNK9oVlLVY9/io0D5MwHpabCBP7GJcyJS4n8RoX9VwfZd
         SMCR4iBq1tIz89JNwwCABT2bNg/y9LsmRRj77QuieuJpi1dTxiAUB22znuNAjgeon8JJ
         zKWEMyADDcZU3c6fhLeX1k4Fp+kGb/C1pfa+r9jBC+NdHZwZ44kiOE2a3aSAMDLpcFsI
         Ogsw==
X-Gm-Message-State: AKwxytddr9Ft4N9RrFonbb425w6xaIZacP73NW01TR5rxqLsAgXHTH94
        Z/eN89uSRr0FykTlMoLWnDRLRfdV
X-Google-Smtp-Source: AH8x226zj6SG3/V3j9Ca4fXIhHxqafxia5riCBiy5WKClfsIWMcqvZPNT29bzItaab4nfxLFhWqrnA==
X-Received: by 10.46.124.11 with SMTP id x11mr3495999ljc.99.1516792331135;
        Wed, 24 Jan 2018 03:12:11 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id i18sm14426ljd.27.2018.01.24.03.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 03:12:10 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3 02/14] clang-format: adjust penalty for return type line break
Date:   Wed, 24 Jan 2018 12:11:54 +0100
Message-Id: <f51831abcd349706390f4e8e7cd960ca61b109d9.1516790478.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
 <cover.1516790478.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The penalty of 5 makes clang-format very eager to put even short type
declarations (e.g. "extern int") into a separate line, even when
breaking parameters list is sufficient.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 .clang-format | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index 611ab4750b..12a89f95f9 100644
--- a/.clang-format
+++ b/.clang-format
@@ -163,7 +163,7 @@ PenaltyBreakComment: 10
 PenaltyBreakFirstLessLess: 0
 PenaltyBreakString: 10
 PenaltyExcessCharacter: 100
-PenaltyReturnTypeOnItsOwnLine: 5
+PenaltyReturnTypeOnItsOwnLine: 60
 
 # Don't sort #include's
 SortIncludes: false
-- 
2.14.3

