Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59AFC43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 22:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E42421D7F
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 22:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn2UWWc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIRWAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 18:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgIRWAX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 18:00:23 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204ACC0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 15:00:23 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id di5so3742404qvb.13
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 15:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aNU/wvu6X5Ez4icyJ/h71f7kRqTeZJ9HNmgx3k3+okw=;
        b=Tn2UWWc1OzqfGlydmzArsdkvaE5JSuuvSpB8cTWemEaZf4KyJek360Dy4uUK6dV6xx
         pbiszY6R4anN4CcKVJTSWFDQTg/kFYUUT63KP4Y2NlkI4oM4qrKbFpby6zMp2uM7llUE
         ica9pNuhxK4CJWgEyd+odfGBMHfgCetCbEiQk4nod8FX9waKOgf4dD3qntNqjxO3wfiU
         MJyHssz7uCJ0fxmkBnRCPiNY9CSyoM4BqW7PonGy/aOh2m6B2UedWifWyNdF2lRlLbLI
         L2IwBcwpf6Qm9mnUJJ4CPmHr13KBbBhsO3XFLkDN5VfIlJV0NxAr27tyiTPGl1YyhFU0
         IO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aNU/wvu6X5Ez4icyJ/h71f7kRqTeZJ9HNmgx3k3+okw=;
        b=pg3iouw1eweL8LluXuEHTXPVxXCGBGIa/PG8HmPmk8ZOt+//Oyg+swt5uj35sozUmb
         Rq3imYoqFe3RQIyDD2sj2gs9HxBHwWW2qg5hcbDHJXDdamk09V512QnxXxebGmV2BL6h
         QhWd/1jEIOJczBwRSIMmNANFZa0V+XKb0LwnFlKc9/ZFMb93IfBKHBD+hrESXXLafLyV
         p7kxdC8UHFgjR4IOTfKOhXfOgApuFX6T2Bq5xeADEcLAJ8NZqfvQVYl5IL+nkgrjpuaP
         rK+KIM2/pfOdRwR6+tbpQsx8zfbBSjLgh7CPi+I+U9V7MgDo786qdS0wKJ1lQnvu9B9r
         /xpg==
X-Gm-Message-State: AOAM531zaEZ3sd2NTc0Zo3tBnsUwwwg3FwbQLMGi4f5Bp5TMQ3V2XDqM
        q7jU50RoTysxHDgA+1Ef2Ol0FPviMlyzrdRI
X-Google-Smtp-Source: ABdhPJwWIlNO+wDbrDbjqT8zQc7lDJXoIx/p81YFW5uaNDwBtGLca/97GSXahOfFO8kbwy4XWCcF8g==
X-Received: by 2002:a0c:8e07:: with SMTP id v7mr12986611qvb.16.1600466421932;
        Fri, 18 Sep 2020 15:00:21 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id n144sm2994477qkn.69.2020.09.18.15.00.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2020 15:00:21 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] ref-filter: merged & no-merged touch-ups
Date:   Fri, 18 Sep 2020 17:58:40 -0400
Message-Id: <20200918215842.62232-1-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200918004909.32474-1-alipman88@gmail.com>
References: <20200918004909.32474-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Sounds good.  Aaron?

Sounds excellent! Rebased using Eric's wording.

Aaron Lipman (2):
  ref-filter: make internal reachable-filter API more precise
  Doc: prefer more specific file name

 Documentation/git-branch.txt                  |  2 +-
 Documentation/git-for-each-ref.txt            |  2 +-
 Documentation/git-tag.txt                     |  2 +-
 ...lters.txt => ref-reachability-filters.txt} |  0
 ref-filter.c                                  | 29 +++++++++----------
 ref-filter.h                                  |  3 --
 6 files changed, 17 insertions(+), 21 deletions(-)
 rename Documentation/{filters.txt => ref-reachability-filters.txt} (100%)

-- 
2.24.3 (Apple Git-128)

