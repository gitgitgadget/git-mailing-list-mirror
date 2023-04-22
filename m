Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7549CC7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 22:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjDVWKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 18:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDVWKq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 18:10:46 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E09268E
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 15:10:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-2f40b891420so2925753f8f.0
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 15:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682201444; x=1684793444;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBqbG1Maz1jcF5ItXBuT3qLdpVQndOiSXtuv4YSt/tE=;
        b=f4MxQ+RVi232cIQkfu06l2BWfGjdEQ/vlpnMZ+hr0ODNxdYNJdkK99dadYrUYc773l
         i65Vws1N8nGjYEJhdxsz5Od72f/pi40U4TdiZu2byBVDRF0LVNXufvbXRHyEegfiW3Cb
         Zi0C8eNy4iMWpUgMmRjXghUq16W/lH7Rn52ZifrqUCOeD7hYzahpFd2KjCFVgLq+Msjw
         k+XdrzS7VFqzMlOITotp0hI8xMaiZsZMjMEI7izgudlcS8LI5c7bZGh1yR11yY0+L8qg
         Hsng2rk/ELF+e2OCM3LXhtOdCTZ/XfVY2QhXvy5gQIvO7Gb4VlKZTCPHCilHIoIQAfvE
         7bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682201444; x=1684793444;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBqbG1Maz1jcF5ItXBuT3qLdpVQndOiSXtuv4YSt/tE=;
        b=hiG3PNBrCYJ+NuqW7lYj1w6ys/VeLTZH748aCK7d+XH8N/h60KesGxHuvkUf9iE4Qe
         N58d4v3edLPNhK0gAKNFnBJpTSU18rpp30DvGKsv6G+veFrDW1AXIuxu7POxPTL7p3Gf
         KHAe4QEIW2+N+5L7W0UoUL+I3wDscH7NmbOtJLFx2Xo5K2+TBHjT6c6BLErRvcJkUqpn
         rVCkWnzyYkco3HLxBfbamwuONLfp27UFSN+0LSWvo6sylsN7rGGdHhteaP50hYKliODl
         YjfFH36LUJj7Sv320ron2SSQGS6H1qs6RjBAZtVvMrHdBBz3stsJ/ys9zDmXFOk8JdR3
         ApvQ==
X-Gm-Message-State: AAQBX9f242zn/bBxtCyMFyvJIHzApoQB4zJwvbRgFEQ8pxhcTw0N/IfY
        r4ZOqsshGjiUm+RJZqrl0qE=
X-Google-Smtp-Source: AKy350Z672sWI6Ec11hJXLzqkQMrFSoZgEeoop846xnEZsXHHJLnHlk//jMhQ3utFFsoflS0TKbaZA==
X-Received: by 2002:a5d:5965:0:b0:2fe:e605:a8cc with SMTP id e37-20020a5d5965000000b002fee605a8ccmr6374668wri.31.1682201443680;
        Sat, 22 Apr 2023 15:10:43 -0700 (PDT)
Received: from [192.168.2.52] (32.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.32])
        by smtp.gmail.com with ESMTPSA id x24-20020a1c7c18000000b003f183127434sm8228032wmc.30.2023.04.22.15.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Apr 2023 15:10:43 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH 0/3] warn when unreachable commits are left behind
Message-ID: <f702476a-543a-da9b-ccd9-4431c80471e1@gmail.com>
Date:   Sun, 23 Apr 2023 00:10:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Warn the user when unreachable commits are being left behind.

Rubén Justo (3):
  checkout: move orphaned_commit_warning()
  worktree: warn when removing a worktree with orphan commits
  checkout: warn when unreachable commits after using --orphan

 builtin/checkout.c         | 132 ++-----------------------------------
 builtin/worktree.c         |   8 +++
 checkout.c                 | 132 +++++++++++++++++++++++++++++++++++++
 checkout.h                 |  10 +++
 t/t2020-checkout-detach.sh |   9 +++
 t/t2403-worktree-move.sh   |  10 +++
 6 files changed, 175 insertions(+), 126 deletions(-)


base-commit: b28a910c4c1e6d7cbdc0663e75c2f5bc6b11eb20
-- 
2.39.2
