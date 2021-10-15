Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD788C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 12:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8554D610E5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 12:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbhJOMl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 08:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbhJOMlY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 08:41:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75254C061762
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 05:39:18 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r7so26301110wrc.10
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 05:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9CPJWe14zkBDDVUoDpgR2/BLC1QeQkmv6jTiHAzbc/s=;
        b=C/C5DrpOzaXi3TwDUa+A4GJQyn/HYBhvdIOKvGyBAnJrMtvHJeu2SvTgQRNA1A8u9H
         D3MJKNPnpVtydWpmRdw49y4kCzBobMjl7A+Cj10Yqxh7aOF65SJBfE99iFJID9TMXvE4
         F7HyVbkLjsUHIfbL1bHFqKeRZSg/7z89fZGJa4ak9R8C15yK4xD2brTu9tBeGPfY3Xel
         OSWIdFzXR+Iz2b6WAOKttJJ3fpDutAbm0MQ09vHx7HChlnCnUupCUA2wgTxQS4HmHiqt
         ZLQUBuQp8yr0R0MRxn6DORdMEpPtPJWsvwzy6/hAtlJT//uwUoPTt9pWWA+1JvmgGKkq
         2knA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9CPJWe14zkBDDVUoDpgR2/BLC1QeQkmv6jTiHAzbc/s=;
        b=e79rliu0MGBc54P3tyqnNPZMBT9sK9ZwMqBkckPP/0awTAY4WLUdJg+idJR+K2hzI4
         otGabNBPasLz7CVs6rVKs/dFLqQ454LkUwAs300ar38VFCvxdERZfW3hA+5WIfbHCZjj
         RYoTQkv1qyrMBwGdyAUzFuU/38gsay98R6Vue22g9HHBB5WiCW9t7Upx+C1TbTz6Pimw
         kzXsW/OgaOuQj6u+g8En5dWJWnw8iQhecGtmF75SsJiGnhxAULmljACzIStQE2w3ebh9
         vbtAVd46Zno71lBR+e2vkbfXkrhrbA/vvcJviWPdudno6DALGIbGzpabuQsceyln/1NP
         3R6w==
X-Gm-Message-State: AOAM5300YcLrbMERHij7YvmQ+aG2gLbEDhkAalQXG7SGzmKWLDyuBi5Y
        vB/vYJQCx0S4RhcRsJ6Ge773Gc0tNIdcMQ==
X-Google-Smtp-Source: ABdhPJxKPoEKV3LOWSVh0g9OCE5EEGRDloYsu88e6YFyCulZlDzSNN7FiB4pQZlbdNeHuKc7SCoAeg==
X-Received: by 2002:adf:9b97:: with SMTP id d23mr13866470wrc.135.1634301556577;
        Fri, 15 Oct 2021 05:39:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d1sm5388824wrr.72.2021.10.15.05.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 05:39:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] doc lint: fix recent regression, make non-.PHONY
Date:   Fri, 15 Oct 2021 14:39:10 +0200
Message-Id: <cover-0.4-00000000000-20211015T123619Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recent patches of mine broke the "check-docs" target by using
;-chaining instead of &&-chaining, d'oh! That's currently hiding a
breakage in "seen"[1], sorry!

In 1/4 that's fixed, 2/4 emits errors to STDERR instead of STDOUT, 3/4
speeds up the target by ~2x by skipping unnecessary work, and 4/4
makes it non-.PHONY.

The technique in 4/4 of exhaustively generating a dependency graph
per-file is something I'm also using in some yet-to-be-submitted
series of other Makefile fixes, that similarly speed things up.

1. https://lore.kernel.org/git/87lf2ueafl.fsf@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (4):
  doc lint: fix error-hiding regression
  doc lint: emit errors on STDERR
  doc build: speed up "make lint-docs"
  doc lint: make "lint-docs" non-.PHONY

 Documentation/.gitignore                  |  1 +
 Documentation/Makefile                    | 67 ++++++++++++++++++++---
 Documentation/lint-gitlink.perl           | 10 ++--
 Documentation/lint-man-end-blurb.perl     |  2 +-
 Documentation/lint-man-section-order.perl |  2 +-
 5 files changed, 69 insertions(+), 13 deletions(-)

-- 
2.33.1.1338.g20da966911a

