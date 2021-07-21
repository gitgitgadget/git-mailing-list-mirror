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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4240EC6377A
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27BF161241
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhGUWmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhGUWmi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:42:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F94C061757
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:23:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 14-20020a05600c028eb0290228f19cb433so484787wmk.0
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SYYNQVaJf+Dyb4ed+bE+B9leJBA3aKE2k3ni+pJiUmw=;
        b=pJiLEQWAL1Ac1x6Ux3nsAO9IYooBn+echjTuWApSwbGxkMcNFXY33CcBYMTOVBX3tk
         CaSt3A7PYImYN+t0cXmJH9h7ePfCleVFZjqOPQaYpm0gk00eL+6e40coKrg1p+L/SzAt
         KgcyliiE48m0A9U0Dtm2D0cPu078n2Rl/tENxvPevx4iuQ4L0aIlEGIospVxcIqX5hGc
         yU++TrsPd2c0n+PH7kxTYILhmpQsY9kQ668SJpBt/y+dkFphSfhp/OPMBWGKpVLQEhdt
         0MpxfdGLMfvWlNug3fQo13B7QU56v19SrFXx4BOpK4ahaAbnOxxPQEz6AYLe8vReVdpa
         GLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SYYNQVaJf+Dyb4ed+bE+B9leJBA3aKE2k3ni+pJiUmw=;
        b=bSBx4vm+g8XqSUvpbu25jVTGgbJV4JV2y0p28Xq7QaTRXE/nTbiqb41tWLZHNH2P/F
         cCajg60u/3OrHa+Txbz1Y/fZUU1rsHMkoHBF99xDk4WEy/WygK+ERhm/Adi/zE+NG2GB
         NxpetzV1i5F6tpUuRcUbtriM5y2GuX0IEpPyWrB5ALi0htE9zFrbL5VvamC4gjxmWy6O
         nUx0W7Gr1Zewf76ayU/lK9y5ixOXrfGP4t5tY27BudZ/mXSXO5cxkowkMvqvGnM2Mkbr
         DPzyJ8mrh3TjLEuwACImOJ5eD6HemFvdEHBTZ+ZpTt+9iryR/nr0ZCuNXg6s0BmAqQxo
         gUbw==
X-Gm-Message-State: AOAM533B6jq6f7PJiaaFD40rTWvwFIfkavuXUizFsi3bGKFO1hHFjLjr
        Ma8dq+8hGVVcqW3k1qAzoTZThgMZZOLZXA==
X-Google-Smtp-Source: ABdhPJxVdKbNj0hNZIQgGGC0vLSws0YY3SEBTSiR5tj/KScWlORNeNFp4UzSDEG3by0e9M9Exwh2Hg==
X-Received: by 2002:a05:600c:4f56:: with SMTP id m22mr4564385wmq.103.1626909791704;
        Wed, 21 Jul 2021 16:23:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v11sm27690260wrs.4.2021.07.21.16.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:23:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/5] Makefile: move ".PHONY: cscope" near its target
Date:   Thu, 22 Jul 2021 01:23:02 +0200
Message-Id: <patch-1.5-6b4ddc126d9-20210721T231900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
References: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com> <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the ".PHONY: cscope" rule to live alongside the "cscope" target
itself, not to be all the way near the bottom where we define the
"FORCE" rule.

That line was last modified in 2f76919517e (MinGW: avoid collisions
between "tags" and "TAGS", 2010-09-28).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c7c46c017d3..7dd93ef4c3e 100644
--- a/Makefile
+++ b/Makefile
@@ -2749,6 +2749,7 @@ tags: FORCE
 	$(FIND_SOURCE_FILES) | xargs ctags -a -o tags+ && \
 	mv tags+ tags
 
+.PHONY: cscope
 cscope:
 	$(RM) cscope*
 	$(FIND_SOURCE_FILES) | xargs cscope -b
@@ -3260,7 +3261,7 @@ endif
 
 .PHONY: all install profile-clean cocciclean clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-.PHONY: FORCE cscope
+.PHONY: FORCE
 
 ### Check documentation
 #
-- 
2.32.0.955.ge7c5360f7e7

