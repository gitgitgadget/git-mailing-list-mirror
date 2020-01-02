Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727C1C2D0DE
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 03:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C19215A4
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 03:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8YAuuLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgABDEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jan 2020 22:04:04 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36340 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgABDEE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jan 2020 22:04:04 -0500
Received: by mail-ed1-f68.google.com with SMTP id j17so38022193edp.3
        for <git@vger.kernel.org>; Wed, 01 Jan 2020 19:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=VItL4a6wf/olOLnfBa5x3unUISn3zqdbfVdq06ZTzy0=;
        b=R8YAuuLRp3aU9IV3KX0mV7Yxz9wTzOvU8ASDXC1wMPop9/SmBb7GZs3IT86wFn5fx1
         fRzlIQshOsuKzgalo3SfMG5DgAT1fqhV+ItefFzu/qk7cmsxqeifvKI1Rqx3b7NMAUw3
         xp9Vyk4yp2C9VtSbs7fxSCA8l2+4G4iGEf/LdNKvjrbsD2rADXtZRAEBBdqMotZGLMrJ
         5K3BFGqEgXqLrXsd0xTPAKv9++CUT8abzxpGCUnlOb7utbKKc9/E2ZBZXS2R5U6DAAEl
         arZXOTmD0/caEXnL5W6L8jFT81AeFN2X1KpFH/TUZhhUdAB5ODCj7e2OSbAz0Rz9iVmr
         F/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VItL4a6wf/olOLnfBa5x3unUISn3zqdbfVdq06ZTzy0=;
        b=swH8TbfsxaMmcar1XXA54vHHWYcS37t9aloh/RNaS3ooUZ8EsZixIbypDPT8+FIAtZ
         5Xw0ZlmZiuwV88Tb2qh2NYPYa5krM5E6tymAdRBCZpGJmcUd7PDQIzgq8T+U6JUCu10h
         xGWpMjne2UARqnS0fvRkojsqFrGlnwTenYp4CQdIaFN2X3Bhsn5nWlCdMcenCQkWHhkv
         /krzx8BQ6YUn834AUjdgUqGamaJG3UptP1rUWydVxaKbo2XJ7ERaEWPNE7HvGxO+ZdLO
         O+8TNeYkSm8KQeqQAS89FYUWXMUWeLoS6ZaSbBLcMLUL+ktMilSysKhtxWYuI4KWkPrp
         spew==
X-Gm-Message-State: APjAAAUx4lNVjBsA5W5NpEsDBmL+uSfFljlkC0D9gte5XPq9QT5ns4uE
        f1ouBmKcYU8GxR/fYGBBTJVxOytK
X-Google-Smtp-Source: APXvYqzNJSuIaicM2QmrY1SrerHVEEvclTiQ9OxOHO6vNpDXxwVLZt2grIeaBbdTNGxYNwWra7jzgg==
X-Received: by 2002:aa7:da42:: with SMTP id w2mr84572983eds.3.1577934242541;
        Wed, 01 Jan 2020 19:04:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t19sm7097378eju.10.2020.01.01.19.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 19:04:02 -0800 (PST)
Message-Id: <pull.508.git.1577934241.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Jan 2020 03:04:00 +0000
Subject: [PATCH 0/1] [Outreachy] [RFC] add: use advise function to display hints
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The advise function in advice.c provides a neat and a standard format for
hint messages, i.e: the text is colored in yellow and the line starts by the
word "hint:".

This patch suggests using this advise function whenever displaying hints to
improve the user experience, as the user's eyes will get used to the format
and will scan the screen for the yellow hints whenever confused instead of
reading all the output lines looking for advice.

Heba Waly (1):
  add: use advise function to display hints

 builtin/add.c  | 4 ++--
 t/t3700-add.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)


base-commit: 0a76bd7381ec0dbb7c43776eb6d1ac906bca29e6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-508%2FHebaWaly%2Fformatting_hints-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-508/HebaWaly/formatting_hints-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/508
-- 
gitgitgadget
