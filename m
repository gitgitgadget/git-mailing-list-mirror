Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3485C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 02:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93EF76103E
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 02:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhIPCjI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 22:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbhIPCjI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 22:39:08 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D830C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 19:37:48 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id 2so4354931qtw.1
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 19:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F7SW/DWHLpm+ZbMctCqStDWFQteRsGPFQ3IKpThFiIY=;
        b=kg0zBKhymOyUGqgj4O7IVyY+CaQ0LjsPemvbOfOlhQbKuzA1zyGBjnUzWFRbg5IRM2
         A32fpfcMYXZQ+Myiz+j6J7AIqEoIhUnAyp9BMFMJURAliB1eX2Eo08hX8fjtHhZIFZt/
         JfENEZmWgnnfWvGgFdXByfiI0pxbKe3S0ZhP9B+ZNSD4MrZ/i7Fx8PpvUgfOzFZqmbXR
         PUUhjRFp9EsSsS4b07246D9o2Yg85hR6vJPl86VIEivL55OScpx14FMODxRX4dwIPpU+
         B7ez5UImYvwsK9iF4UHJigxCflBHBKVxyIO/MgqVh4Tgoh3BkDZHogyH8rPYeHjeNKY+
         pJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F7SW/DWHLpm+ZbMctCqStDWFQteRsGPFQ3IKpThFiIY=;
        b=IknwjZRU7hDQEFB6WS4O4fSJl33zlsU3CHGplwzZp5vbtNhJDzQ3hcYvPGfWK3IXPy
         zW6yiOX3aC9LhCK1bBgkUjGYLJMnRa/fmXK95F+XVFpNj2wYAPhXDc/HfEo9rXcp1cTO
         qvaMyx/fIPdD1PY6XCSVDXzkup9c5VUdtAvi4WlYo6Ofwpx30pStz/cvuPuLZ4EOVJI3
         HumLMmyHdKcStFPC4x7XoxF3Mqtsz9BS3WYecyDHKu4sJ5JQDZwhx220A9cwcOLlyrqA
         sp78PCD6EjRKb2N/F4pbWMSrdF/wWEyYsFJOkqjavWPqQrYy9Aj4EaZcNxzEu9ljp/Dz
         Czag==
X-Gm-Message-State: AOAM5337AuPflNgiGhLXS2mrq3Js7oYQS1M3Q0s8p3c5TVS1wWaUYxZh
        JEUfc8cqwRq/lZFqLWkpUE1ealfFFB8=
X-Google-Smtp-Source: ABdhPJx8Hqq5HIUhLOpPigTJbe8qSIkqJenl7VGwprlSGbpB5JKx0R0UB/7W/1oPEjALycCqsCgljA==
X-Received: by 2002:ac8:5805:: with SMTP id g5mr3092007qtg.360.1631759867209;
        Wed, 15 Sep 2021 19:37:47 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id w20sm1498753qkj.116.2021.09.15.19.37.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Sep 2021 19:37:46 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH 0/2] t0000: truly leak free
Date:   Wed, 15 Sep 2021 19:37:04 -0700
Message-Id: <20210916023706.55760-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While looking at the leaks reported by our new CI job, noticed there
was a hidden one when running t0000 in macOS.

The first patch fixex that leak, and the second one fixes the reason
why it was hidden.

  [PATCH 1/2] tree-diff: fix leak when not HAVE_ALLOCA
  [PATCH 2/2] t0000: avoid masking git exit value through pipes

Carlo

