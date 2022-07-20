Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3985CCCA485
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 21:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiGTVWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 17:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiGTVWM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 17:22:12 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2235B58864
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a5so27831172wrx.12
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X/SDOUqR9jdo6CNewSonLC31+24fDTh4cKmUB2uv2ck=;
        b=XCVKDHLvALCx61zp5PZEg6yZZK9CQvX61SB+ot9a3+3Sn2nwC2PD8yLDjlEAurzuR5
         zKkTo6Ed6nor4NKkRzFOeeug2IuWSv9SVCxwkFn4aB3nz5C/z1t2USE3UR7egG//rZQk
         KZtfRCE4WDa0wI0xERme4RxOImsZ6rar2/ahTRJCs/EJMx/eAtMlcEeTmZPwsVWq9MoO
         1JywyxUMZflpg84v8EjkA8QoRsTL0im4J4trWJXBCOZ/0ZLFK66Adhfnd5406joF3Vdw
         8JorGikg3BQjLoc9UL7Zq9Nks09468v9loWuw5yn6QVGcw2OOHjYbTVydUiSIThIS+pe
         7sLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X/SDOUqR9jdo6CNewSonLC31+24fDTh4cKmUB2uv2ck=;
        b=jOQDXiGWWeY5UjGg0Q/IYVUmtmwQdASVjHbcWMO4ABjaK1hYUgMKot2DWLNAqcauXV
         AaYPD5mhqfXaV1Z76o4o3969uzyO8lkJZIUDsMCTTHiC674s90BRToWxPXeT3hqy5vlp
         IXOf7bDS3y9ZwkQSLaEnaWl+4BSBr3CZ3cVd1jzawlzkV8IZSVkudolglcepG4bJ94Q2
         1XnveaWzLFrI4BbDQv0GTlPtPYk4nud9KrbSRd/MERiKG9kxsuze1SV5nrOte4OjReza
         kSe+85QObGl5H6c+uTZV54AT5U+zTinsgFrFAlD2HJsO9MS/JyrrHbbINA9r8VVvi/Wt
         UtqA==
X-Gm-Message-State: AJIora+NROy7s7R4ddK5UazY9T9y/aVTaYppRfTFNxUs99K5P2Nq9RTD
        LpZgK/7q9KP/y4kgjIrmpzhoBkigZvIzvQ==
X-Google-Smtp-Source: AGRyM1tCJw9qMaUPTCe/fyHcCmolHvkps3xEEqVZ6LbhmYRAqibmHo3elSBGnPix7FF0T887T1pL7w==
X-Received: by 2002:a05:6000:601:b0:21d:7f3e:e231 with SMTP id bn1-20020a056000060100b0021d7f3ee231mr32292725wrb.219.1658352129345;
        Wed, 20 Jul 2022 14:22:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003a0375c4f73sm3605441wmj.44.2022.07.20.14.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:22:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/14] t/README: reword the "GIT_TEST_PASSING_SANITIZE_LEAK" description
Date:   Wed, 20 Jul 2022 23:21:43 +0200
Message-Id: <patch-v2-05.14-a26cb02db0a-20220720T211221Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1064.gc96144cf387
In-Reply-To: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reword the documentation added in 956d2e4639b (tests: add a test mode
for SANITIZE=leak, run it in CI, 2021-09-23) for brevity, and to avoid
a merge conflict with another topic, per [1].

1. https://lore.kernel.org/git/220719.86lespun6l.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/t/README b/t/README
index 4f9981cf5e3..7f409392537 100644
--- a/t/README
+++ b/t/README
@@ -366,12 +366,10 @@ excluded as so much relies on it, but this might change in the future.
 GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
 test suite. Accept any boolean values that are accepted by git-config.
 
-GIT_TEST_PASSING_SANITIZE_LEAK=<boolean> when compiled with
-SANITIZE=leak will run only those tests that have whitelisted
-themselves as passing with no memory leaks. Tests can be whitelisted
-by setting "TEST_PASSES_SANITIZE_LEAK=true" before sourcing
-"test-lib.sh" itself at the top of the test script. This test mode is
-used by the "linux-leaks" CI target.
+GIT_TEST_PASSING_SANITIZE_LEAK=true skips those tests that haven't
+declared themselves as leak-free by setting
+"TEST_PASSES_SANITIZE_LEAK=true" before sourcing "test-lib.sh". This
+test mode is used by the "linux-leaks" CI target.
 
 GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
 default to n.
-- 
2.37.1.1064.gc96144cf387

