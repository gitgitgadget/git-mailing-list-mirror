Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D39C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE606208A9
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN0/yyA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgIYO0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 10:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgIYO0C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 10:26:02 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EDFC0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:26:02 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id b79so3508045wmb.4
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3k5m9PQ7L/77aINddkA5Z2TxUOJhOOJ4Py1PQRnLh8o=;
        b=eN0/yyA0EpMUoBziN2sSYiCe+Sk4LXr/BhZTJdAWsvZWnxReV5+MMBLY5yPrloqZmX
         OlBurBQLkk4lwBMM79w+FbcE2lzSM5Xwtba1O3fDhNa/04Ub9QkrvWSQS6FCYDQx9ziP
         cwYk90z/pL0idBxK/TCM6mWqpoCD0OxnT30+r6bGL6GBX7j3ctCtV/N6twFydu+frNjd
         fJA5atD7WMbytcST3HmCCWLr+dskUs45X8PMX0BfJr68DtGhEfar9zYBzsBhB7yb4CNa
         C8kRIUGGaZ4gCtBb2bVQ0Q191IY5UssSmvXNGKy+L2sejpGiF2NXpwdAIKzCv2BYYFFk
         ZQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3k5m9PQ7L/77aINddkA5Z2TxUOJhOOJ4Py1PQRnLh8o=;
        b=hjbloT7mTuPRQ5Tyaw8gkl1Omxg9vvuWNuL+KpvazuOE7qzfsWEx7zKoHnRcbyFLJT
         L2vV3nceaEfwV9o8oWP9v/B8RlqkyIi213kclkhoJgV0yyD6xHiQIqbWAckkMNqfbszY
         IfhYB7aEm30eK6ZF6qB4qXI67Lg31/w5Y3S2VC9aKaLSO4S8mTz6zDiotuVgob902xF1
         0cB0W8ZBY91rtaAb1Rb0K1fTDTj+zzryUka7+wHF4AOXUP//MVOADgl9RC5KTgTZ+TnR
         bWIeQdvf0QIVTQCmnJJ/q2X2ZIcEjptNdQFQPLtsH8mxGRUM/37cbi8cw3wI+kKQz+YR
         Z8Wg==
X-Gm-Message-State: AOAM532SV0yIrLY/wzh5UEabSZ3SNiwlkQFLf91WzGhjdxgZl0FlJa6b
        KA/JDgfmFHdKX1q/y566Wp/HwmUfImQXxQ==
X-Google-Smtp-Source: ABdhPJz/3KBlZQUPUdDu6VpMtMJq/0j4RvcHGFbqyjxLBUpV9rNHeL6Zf/fus0FZdCciUQ8f1H9a5A==
X-Received: by 2002:a05:600c:216:: with SMTP id 22mr3263814wmi.149.1601043960679;
        Fri, 25 Sep 2020 07:26:00 -0700 (PDT)
Received: from localhost.localdomain (91EC7F95.dsl.pool.telekom.hu. [145.236.127.149])
        by smtp.gmail.com with ESMTPSA id t124sm3211312wmg.31.2020.09.25.07.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 07:26:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=81kos=20Uzonyi?= <uzonyi.akos@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Uzonyi=20=C3=81kos?= <uzonyi.akos@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] completion: complete refs after 'git restore -s'
Date:   Fri, 25 Sep 2020 16:25:52 +0200
Message-Id: <20200925142552.1656596-1-uzonyi.akos@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Uzonyi Ákos <uzonyi.akos@gmail.com>

Currently only the long version (--source=) supports completion.

Add completion support to the short (-s) option too.

Signed-off-by: Ákos Uzonyi <uzonyi.akos@gmail.com>
---
 contrib/completion/git-completion.bash | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8be4a0316e..50e6e82157 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2853,6 +2853,18 @@ _git_restore ()
 	--*)
 		__gitcomp_builtin restore
 		;;
+	*)
+		local prevword prevword="${words[cword-1]}"
+
+		case "$prevword" in
+			-s)
+				__git_complete_refs
+				return
+				;;
+			*)
+				;;
+		esac
+		;;
 	esac
 }
 
-- 
2.28.0

