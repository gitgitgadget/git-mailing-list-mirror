Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F3EC43468
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF90520EDD
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFqdL812"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgITLWs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 07:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgITLWq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 07:22:46 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D936BC0613D2
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:43 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d19so5439254pld.0
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r5/Lz8XIOvfy4nO8p73fNkjlfMEhksE3Txea4yEMOls=;
        b=EFqdL8127I++8VB3GG3VPo3ZAMxp0R3O+xLo8VeT40+uN5HXvOQZcVRzlCcSvLUi7G
         Qr+DFaN+t4YXkBsjeGjEtPAWeX23BjKjwRDzknrNabMs6Xrf0efG9mW5K1CCLrkvPSB/
         EbFJVWQT/dXvFtB8Ho4WY+Ljpxaub4ePZGNoI51ioYd+HybN66Bb08DS4asIfIrnCotY
         knnL0FhDrmo5ipJ9gm6m1pYMteCnw7HGcqWWMcm1K4sXuC4pvAKEGaOVki/AgUYM0EtG
         D8/QQX9b4cDWGLZ30ilGiW9vm6dGU6CbSiFCU4YmLW6rl2iA16bKHrtdEi0GccoTcST2
         WHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r5/Lz8XIOvfy4nO8p73fNkjlfMEhksE3Txea4yEMOls=;
        b=FNyuEereLXEA11mqt4Q9l7Px9XBzVmAI0cGxX3xP75NWWLuLR0leXIGdkZAtpEIcMI
         skOz4XrX8aXK7+5CegexZW7NYxxGT8PucMaoQFmhlbPMTGPZ6rY4WGO2GUvUN2TzWvFF
         iXzD/cdU/AqlL4STW9cPmt4HZda0mt8DHca91sWxrWibRZe5IVSJvI6ckMX4ZUKMp+Hj
         2FcbXl8Z8cXoOSBq3noAhgHYM6quYuxqf1aJ7jRAi2BGSGGW1VeJva/mHPrllrLIATQK
         J0GWPVx6R8/DiSKI/QQgpKnjnhfKmpX5R7IC3hikTyEvhievTDxPEr1rk1QwpkJuS2y9
         JlsA==
X-Gm-Message-State: AOAM533hkGR3aM2hVPqPaPom9Dqo3uPZHRC8//u6W6xM8LCHMM6Dgzlj
        99J72ZMOgQflUZXyWt8/7KhlpP5Rv6A=
X-Google-Smtp-Source: ABdhPJynhtEXbHNyxq6LOMCuWQFR1qEnGr0K/TVb+AXdwEO7E/P/w1Z/z4a4CO+HmftD8n4RekCkZg==
X-Received: by 2002:a17:90b:1988:: with SMTP id mv8mr21142773pjb.23.1600600963225;
        Sun, 20 Sep 2020 04:22:43 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id y79sm9550737pfb.45.2020.09.20.04.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 04:22:42 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 07/10] t4068: add --merge-base tests
Date:   Sun, 20 Sep 2020 04:22:24 -0700
Message-Id: <27930d44769503103533c8c38212d7eaa2856a8e.1600600823.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.760.g8d73e04208
In-Reply-To: <cover.1600600823.git.liu.denton@gmail.com>
References: <cover.1600328335.git.liu.denton@gmail.com> <cover.1600600823.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we will be adding more --merge-base tests to this test
script. To prepare for that, rename the script accordingly and update
its description. Also, add two basic --merge-base tests that don't
require any functionality to be implemented yet.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 ...ymmetric.sh => t4068-diff-symmetric-merge-base.sh} | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)
 rename t/{t4068-diff-symmetric.sh => t4068-diff-symmetric-merge-base.sh} (86%)

diff --git a/t/t4068-diff-symmetric.sh b/t/t4068-diff-symmetric-merge-base.sh
similarity index 86%
rename from t/t4068-diff-symmetric.sh
rename to t/t4068-diff-symmetric-merge-base.sh
index 60c506c2b2..bd4cf254d9 100755
--- a/t/t4068-diff-symmetric.sh
+++ b/t/t4068-diff-symmetric-merge-base.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='behavior of diff with symmetric-diff setups'
+test_description='behavior of diff with symmetric-diff setups and --merge-base'
 
 . ./test-lib.sh
 
@@ -88,4 +88,13 @@ test_expect_success 'diff with ranges and extra arg' '
 	test_i18ngrep "usage" err
 '
 
+test_expect_success 'diff --merge-base with no commits' '
+	test_must_fail git diff --merge-base
+'
+
+test_expect_success 'diff --merge-base with three commits' '
+	test_must_fail git diff --merge-base br1 br2 master 2>err &&
+	test_i18ngrep "usage" err
+'
+
 test_done
-- 
2.28.0.760.g8d73e04208

