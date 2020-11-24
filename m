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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF7EC64E75
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 13:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECFEC2076E
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 13:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mxg8LepX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbgKXNav (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 08:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388270AbgKXNat (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 08:30:49 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0E4C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 05:30:49 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id k3so19300815otp.12
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 05:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YopPR/AjoLdffRlPvbN/TqwcUlY1u4pjOYs6LnV/vDw=;
        b=Mxg8LepXH26rRBgsbxT0CsUqGRZAFS1ozbnkt6LYh2UCW0V8b8ZsyRKvPnXJtmpk+G
         w4BTSGjeLor38dLz9RxFlwmqCCfz2oOegDC6gU0DcCCRO7Kl/T1k4AWfsyC5n+lGMzXJ
         cM3GgLfcjNkR35hAn+6tVl9UcsiqLVi4LvK5gfFMfjQ7AvFManqK+ucCpW9kLPbZH/2q
         qsrOfpMhI5d5QKgIjPZibwdfAfmNI558t2N/84ArO3N0s1mQCkpI0cNpB+ufi7YIOTx1
         OEAP6ztMSs5WpBgtmBfLZ6IG89ZRbPTTlq7/gKXm013rWhF3sY1x/nUSo9/Y23/WPGsB
         /56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YopPR/AjoLdffRlPvbN/TqwcUlY1u4pjOYs6LnV/vDw=;
        b=g+wEcqDn9AAUB39hQzNn2czrVQk2Aom3Pys1zt4QOd9r5WACqRrdU1SiBpOcfYlx7d
         ATcIGY40Q3s51lESkMv33CYlJpaYzemUCdpvvoSqydv3e5UFiDNIMWO2XmUQK4nc7D92
         j74gpc/mLQ0vHoTLG823TsTPJ3cw9udNAU0T1FHDcOnUqquyZSjNSWrLMzqk8XO2j0L/
         IE0eB13kxgaF5KllAA7BDKlBR9X2CJx0a8PcMQ8i5xZm+QpstbypnTkF06GfrLBBSOVT
         VKALMh8yJkRFBHDL1eZGtUh28OcPRkgHUFjcip4xhhpn3dcxBi9aJWQsOa9d3MOk+eb1
         zgTQ==
X-Gm-Message-State: AOAM533XA62DA7kpuNOY725ebuStsMpNKlhystwK/F8jk+/wjiuPTKvE
        iPA9d+sV5lJArQbmioj9coYS3kPcEDuK8g==
X-Google-Smtp-Source: ABdhPJyUQtBu3nuliW3QBgEln/UXi6aKh8V8xZJ87tr5j3JoDK2cOfS8tsKQcfFmF4ExrAfA3XZIGg==
X-Received: by 2002:a9d:6c99:: with SMTP id c25mr3473866otr.327.1606224648792;
        Tue, 24 Nov 2020 05:30:48 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id j46sm3702983oof.36.2020.11.24.05.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 05:30:48 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/6] pull: display default warning only when non-ff
Date:   Tue, 24 Nov 2020 07:30:36 -0600
Message-Id: <20201124133037.89949-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124133037.89949-1-felipe.contreras@gmail.com>
References: <20201124133037.89949-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to display the annoying warning on every pull... only
the ones that are not fast-forward.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c               | 2 +-
 t/t7601-merge-pull-config.sh | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 9a0f7937c2..479bdaf0ee 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1013,7 +1013,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (default_mode && opt_verbosity >= 0 && !opt_ff) {
+	if (default_mode && !can_ff && opt_verbosity >= 0 && !opt_ff) {
 		warning(_("Pulling without specifying how to reconcile divergent branches is\n"
 			"discouraged. You can squelch this message by running one of the following\n"
 			"commands sometime before your next pull:\n"
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index c5c4ea5fc0..d79723877b 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -28,11 +28,17 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'pull.rebase not set' '
-	git reset --hard c0 &&
+	git reset --hard c2 &&
 	git pull . c1 2>err &&
 	test_i18ngrep "Pulling without specifying how to reconcile" err
 '
 
+test_expect_success 'pull.rebase not set (fast-forward)' '
+	git reset --hard c0 &&
+	git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
 test_expect_success 'pull.rebase not set and pull.ff=true' '
 	git reset --hard c0 &&
 	test_config pull.ff true &&
-- 
2.29.2

