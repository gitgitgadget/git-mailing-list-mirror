Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB587C433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC1032074B
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4sPM54f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgG3A1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 20:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgG3A1o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 20:27:44 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339FFC061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 17:27:44 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g26so24162670qka.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 17:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l04V7jprARTAZ9HPhd/PmhIHAI3lxcVJ23K7lRAgHp8=;
        b=s4sPM54fDHpUSqHWlCdSmuV4kU2gHNXAnOrp0gNtYyen20WKrQUxp463Y2i+wTZH2d
         oIoSOWiyWu5WpDoJIuI38n/MH1eocElKCgsEToTp/W+toGg13KfnyBlcneqKR638pTeD
         uQMWDFKpX4aEyo+3yPdUUMLpXbAGXgrJGSp5fgepD/gtcv8V/4ich5kBLyLOIm0NOewz
         xaKBAUffzCUly6BoDPGSiFVNdMKw11l9w9wKyKS+7VcE0paL+4KxaWEeivDH6zGwe2zz
         jH5jvhTYBXOC9duZhuiiaHlOVusG0Y7HL+ynBK2xvWwCo83SCrPEdg9BhbLbWCRK0SOv
         MNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l04V7jprARTAZ9HPhd/PmhIHAI3lxcVJ23K7lRAgHp8=;
        b=hLLNqQnW5KRmbybTZ5PFGmZwqiKUvw11vJWFM4x6XVbcHRiPrX/sIqw3HaebO6p30U
         O128ciZG/PnRUWU/A3dOTtmVyN0rvSB6d7VkApL1CQfMto7ukYxkTAwXM1Rllo2BhYJX
         KtjVIou9HfSMrS2hht9jMycPMC5xCkM1jbJIilLR5rJIDCXfP+FEaH17Qon24hY5PnLY
         z8aKI4zESsn/5mEvHw3j/+1dJ3WaNu/m+fbL+GGzBYAV36aUfYR2jgXaZpjxK+as7qFk
         3CVgkKOG7qNs31h1SRJwAJ+SWNVnleN2q7rx6osa8vFcxfelIxmcPDfJ3JsfVXlrwXS/
         kfSA==
X-Gm-Message-State: AOAM5311uJwAqFJFPakU7N8JsbIn2qiqzEhWDQzHBY6mgcfT0bGD7YF+
        yW7y4wZqb3rou614J5H0pQAL8tJg6YQ=
X-Google-Smtp-Source: ABdhPJxPz2WBYD28IA7IDKnkKHR1bGKFS3sR+7Q+7hsYnMa6795nP383cXUWsAcxDFyOv1vxJe+tFg==
X-Received: by 2002:a05:620a:1469:: with SMTP id j9mr35626723qkl.216.1596068863092;
        Wed, 29 Jul 2020 17:27:43 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id m32sm3239391qtd.94.2020.07.29.17.27.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2020 17:27:42 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH v2 0/3] Introduce --first-parent flag for git bisect
Date:   Wed, 29 Jul 2020 20:27:32 -0400
Message-Id: <20200730002735.87655-1-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <pull.686.git.1595951056.gitgitgadget@gmail.com>
References: <pull.686.git.1595951056.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio, thank you for the feedback and the explanation regarding
count_distance(). I've gone ahead and implemented all your suggestions.

> In chronological order, please.
I submitted my initial patch through GitGitGadget. I don't see a way to
control the order GitGitGadget sends emails, so I'm switching to
git send-email for this iteration. Please continue to let me know if I'm
missing a convention.

Aaron Lipman (3):
  rev-list: allow bisect and first-parent flags
  bisect: introduce first-parent flag
  bisect: combine args passed to find_bisection()

 Documentation/git-bisect.txt       | 13 +++++++-
 Documentation/rev-list-options.txt |  7 ++--
 bisect.c                           | 51 ++++++++++++++++++++++--------
 bisect.h                           |  7 +++-
 builtin/bisect--helper.c           | 16 +++++++---
 builtin/rev-list.c                 |  9 +++++-
 revision.c                         |  3 --
 t/t6000-rev-list-misc.sh           |  4 +--
 t/t6002-rev-list-bisect.sh         | 45 ++++++++++++++++++++++++++
 t/t6030-bisect-porcelain.sh        | 17 ++++++++++
 10 files changed, 142 insertions(+), 30 deletions(-)

-- 
2.24.3 (Apple Git-128)

