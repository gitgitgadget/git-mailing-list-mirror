Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE1EC43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 21:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiGTVWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 17:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiGTVWI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 17:22:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3BD4D4EB
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h8so5144018wrw.1
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=prvPQRb3Tv2TH9M2rYBcS742nmrChXwTjjOeobhQ/+w=;
        b=mTDKAhZP5UHzw3i2s5dJITHCZNXy11sRsQo23sttsOZyfuwbKvP6GkG9iukr3QORTm
         bHwItVFdTiIuKSIgpUWfqlRB2GajU64srfHOgPT9Yqq3zpWTHrpeFbajNjz8u+tpLPLJ
         NjwQNTcgD8IWUy4O4uIfVLKu7ispit3Dgcovx59QcTw+4bPVzI5PAZIB9TJYTKQaexUH
         MqqS26u9aTjImzCfNYTLKF3fNTH1pubeqbyKGAf0YN46zDMla5BuHHInx7nS8gsd4B92
         P4mb5tPwo5IcusGRWFPktu28gcuJg4JiLSSZYYObS2r8pSl8jI3SPJGPX5szHnzfzf6z
         e0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=prvPQRb3Tv2TH9M2rYBcS742nmrChXwTjjOeobhQ/+w=;
        b=Fg5sFFZ0Wwo781E6pPVjy2lEM4JXCbEoM9Tw90nmKkkgbQrrB9Aj7Ucv7uLVxJTKFB
         ProbgbuLPf3NZXO+B87gWM6ywKAzPWJglpG0hf7xj7mmsNmt/HYQl/yGgJ7ADgoAcEjr
         55B5vdd+5Ka8TdQYdSywpQN/EvnTFTg19hiv8kgC8s0FrdYyy5IxTtl5BvO/7jTB3k1d
         cK1aSmPAdzbhym4NLJ7vu/DOKvrtl1zznJq5y0OfSG3j0xXbdDIFTVj2SVj1+PepcWkj
         ngWnnGMdSpB6aYzYBJruDjGYMo79Pd1Exng1nTIr9LIoZ9AoE/ynEUN83BvXGeN2u1tX
         LCFA==
X-Gm-Message-State: AJIora/9C+DU13yu7iqZ1s6MenbatddFa9TqnNVR6P/e8K16zDa0cM06
        K4s9gUFB49pQAKaVfk0BHlAeh5hJXO+Ong==
X-Google-Smtp-Source: AGRyM1vEXvCnIJt2n9cSlI+lF0i9zslpkF+J0t+24HZnlnoAAbGKDiV9g4aGRJuEqLWCKRacBUVvZQ==
X-Received: by 2002:adf:dd01:0:b0:21d:6df2:be30 with SMTP id a1-20020adfdd01000000b0021d6df2be30mr32396053wrm.255.1658352125357;
        Wed, 20 Jul 2022 14:22:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003a0375c4f73sm3605441wmj.44.2022.07.20.14.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:22:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/14] test-lib: don't set GIT_EXIT_OK before calling test_atexit_handler
Date:   Wed, 20 Jul 2022 23:21:40 +0200
Message-Id: <patch-v2-02.14-00af775bd0d-20220720T211221Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1064.gc96144cf387
In-Reply-To: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the control flow in test_done so that we'll set GIT_EXIT_OK=t
after we call test_atexit_handler(). This seems to have been a mistake
in 900721e15c4 (test-lib: introduce 'test_atexit', 2019-03-13). It
doesn't make sense to allow our "atexit" handling to call "exit"
without us emitting the errors we'll emit without GIT_EXIT_OK=t being
set.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3f11ce35112..c8c84ef9b14 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1169,12 +1169,12 @@ test_atexit_handler () {
 }
 
 test_done () {
-	GIT_EXIT_OK=t
-
 	# Run the atexit commands _before_ the trash directory is
 	# removed, so the commands can access pidfiles and socket files.
 	test_atexit_handler
 
+	GIT_EXIT_OK=t
+
 	finalize_test_output
 
 	if test -z "$HARNESS_ACTIVE"
-- 
2.37.1.1064.gc96144cf387

