Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEB7E1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 12:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeAZMhp (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 07:37:45 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37543 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751565AbeAZMh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 07:37:27 -0500
Received: by mail-wr0-f194.google.com with SMTP id f11so410906wre.4
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 04:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b5Q++QOxFy7nEHePkQZGojiZZu6JxRX5dPLI/it+3lY=;
        b=ftXb44iwLBt8LGnnT/QI+VYXPaZEldQMq3wxJ2XlweG8aEeZuS+DYn2k0Cx65GLlGo
         Lq9xkS1bCXISUVMf4xNOXIqFGEOciQ879Sfh3bEyKJ2EstHRS5jKdQW9T2mScU5E9sgu
         jWIWDdCt7ExwaG7GDF0JBHzSTOmGrptxqujVoRC44/6xzoww4PPPW75PGJ5EjZSP12IB
         YvRsmHyqllgoj85Qy4XASvmp9Iegs62XtlrnWOKgdhJlljX6B7ycXedac9irCCcmiJnm
         YE+MBI2iH3lDUiF4Mc1FZQbCmYfDAVLplCor0rKRM7K2MwS5k4W3oIAL75FbEA1toKxi
         fADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b5Q++QOxFy7nEHePkQZGojiZZu6JxRX5dPLI/it+3lY=;
        b=fto1FH167mIcpU0E8gQlTUVeoh4C9aIy3066ujvAfwYDUmuOjsQ18ZSFUrBEjjqKff
         NQAE30TFmoF5/DnP4+iDS0hi4kwDwSbTQL4ECm9c7ICh1ONFdJuPk3fQXA4Q7jQHJGXn
         9tcSDbauOFvqICCp8dau4FSxF8kdv+u+gYYQBOCTCKAkTefAoFkSjC+9FojyDQKcnZfQ
         8PJgPKT18sWMkIW+fVn1lzWYgVgeV718puZC90MXev7r3qXmTFUjriVoesBfwii2kjFe
         mCxL9AelEbJ/fhcpf7tliQf1g0YVjv/8bu7Pm854S309Ni0U8jr8qgF4R7MxUTFQ//CE
         daAg==
X-Gm-Message-State: AKwxytc0UhcBHdePHYj2lBe2q/6v6p5DsczlZ60H/o81Qb9OxdLp5kTn
        6hFwFTfPChpBDuaWn8ADXUfCPw==
X-Google-Smtp-Source: AH8x226ymkmEp+S4T/2aGvX1KyLJpTeTeqqMdSg/zrRqc/dsK/QBc/S8sOtzLwPCCf6PPfOBUe7umg==
X-Received: by 10.223.142.56 with SMTP id n53mr11025285wrb.54.1516970245865;
        Fri, 26 Jan 2018 04:37:25 -0800 (PST)
Received: from localhost.localdomain (x590dab0e.dyn.telefonica.de. [89.13.171.14])
        by smtp.gmail.com with ESMTPSA id d17sm4756626wrd.50.2018.01.26.04.37.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 04:37:25 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 05/10] t5510: consolidate 'grep' and 'test_i18ngrep' patterns
Date:   Fri, 26 Jan 2018 13:37:03 +0100
Message-Id: <20180126123708.21722-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.155.g5159265b1
In-Reply-To: <20180126123708.21722-1-szeder.dev@gmail.com>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the tests in 't5510-fetch.sh' checks the output of 'git fetch'
using 'test_i18ngrep', and while doing so it prefilters the output
with 'grep' before piping the result into 'test_i18ngrep'.

This prefiltering is unnecessary, with the appropriate pattern
'test_i18ngrep' can do it all by itself.  Furthermore, piping data
into 'test_i18ngrep' will interfere with the linting that will be
added in a later patch.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5510-fetch.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 668c54be4..3debc87d4 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -222,12 +222,9 @@ test_expect_success 'fetch uses remote ref names to describe new refs' '
 	(
 		cd descriptive &&
 		git fetch o 2>actual &&
-		grep " -> refs/crazyheads/descriptive-branch$" actual |
-		test_i18ngrep "new branch" &&
-		grep " -> descriptive-tag$" actual |
-		test_i18ngrep "new tag" &&
-		grep " -> crazy$" actual |
-		test_i18ngrep "new ref"
+		test_i18ngrep "new branch.* -> refs/crazyheads/descriptive-branch$" actual &&
+		test_i18ngrep "new tag.* -> descriptive-tag$" actual &&
+		test_i18ngrep "new ref.* -> crazy$" actual
 	) &&
 	git checkout master
 '
-- 
2.16.1.155.g5159265b1

