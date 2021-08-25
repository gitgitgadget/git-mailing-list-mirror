Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD015C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97BD761075
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhHYXYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 19:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhHYXYY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 19:24:24 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65695C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:23:38 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id z19-20020a631913000000b00252ede336caso98665pgl.4
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=24xY3kZV/QhGGsXUQbJ9rnmHdGyRTvWh8vHQ17KkRDQ=;
        b=U9MqEFoK2tOQWqDMP7+0vm0Vx/cDLt+w0M4nxqfi560U/4mMzroiC7Hu31cf6C4PwZ
         BEOCnWJxhRPiyoQUUtzS8rtLC4AbKPfBw3t9Cp/CpQi1HIf8Inve8+Q+IIAyc427Gmiz
         lFPXu4OpjYmS/jAisdEyTjVJPGtYxM3uBPVH26y/Ukr9HAP3SOXrghwTQzbHP7YBTfVi
         JF2IZ9kU/6kvtk+947WhHw7HI71uhQTkmf6GC5HbbpIRq6OeMo2SIBv782UShiHMlooz
         7tbWQPAVcS/YwuIsMos2xm4Lx933JYnBRbGymZe+jVVqz5B8bKOeRTUoGqOoV2Ot25Ia
         Adcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=24xY3kZV/QhGGsXUQbJ9rnmHdGyRTvWh8vHQ17KkRDQ=;
        b=Znv3pb53+vMZYSIpuhn7Xa67AVp4lgajHHYJxmsMpz3XhXdBnUSgrP/1q80uP507x1
         ZloMvxRTK6YUoQoGseRIAIbKw8QWzkxStcgCOCCiZH8ZYPJj31/i7KdXAn/Ag4RSmk87
         S0/VYH7dR6ee03mmT1a5NYiEUSYFppOWgeSnBQJSLsCmQVM7DjpQah6GSU9wCujA8b7u
         Xa7KCaDHG5X4RaipgKI0NQCRUsNaiiKD52TG5ND7MjOC3xqeUOdHiR4QPFsN0U5d6GSB
         +FyY03DVfztpgvPARNrdzCtBL5HOivfB/33x0QSh46ZR4vc6h9T3bJ9jiavwqWxtfGyq
         OBgA==
X-Gm-Message-State: AOAM5301kmGvB25Aw0GYS8g+yzDC8golVyP1gb5eCS6AFgIQZevisD+a
        xupUvAbFCQC2QA4LGbVQi9dmmeY0AJLyky5nuxYzuWBeA9oyHNPISWRxWvUEzIl2DEfhvBDiS0L
        s2ayCsmBuffHn0mWDmEvbtfHJVw83GTm8YZWYk8Po97luAD/7Mh+FRImpnO6dDmKkeHjjkXnLo5
        hH
X-Google-Smtp-Source: ABdhPJyR/FUIIaWWu97a8PO7pbT2N8gmvJTJg9LeMUko1hbTuJDWftA26Vdw/nuEpn+crOziX9rwaZHClFtmHJPyEd7s
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:520e:0:b0:3e2:1c21:f1ba with
 SMTP id g14-20020a62520e000000b003e21c21f1bamr812980pfb.78.1629933817682;
 Wed, 25 Aug 2021 16:23:37 -0700 (PDT)
Date:   Wed, 25 Aug 2021 16:23:29 -0700
Message-Id: <cover.1629933380.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [RFC PATCH 0/2] First steps towards iterating over submodule refs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, hanwen@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are more results from my submodule partial clone work - teaching
ref iteration to work with submodules by introducing struct repo
parameters at different points. I'm sending this out early as RFC
(before implementing the part that actually adds support for other
repositories) because there might be a better way to do this that I
haven't thought of. (This patch set contains my best idea for how this
could be implemented, but admittedly it is a bit unelegant that the repo
parameter is injected differently into each iterator function.)

This will break any existing topic that introduces new ref store
backends (Han-Wen cc-ed for reftable), although I think that the changes
introduced here are not too significant.

Jonathan Tan (2):
  refs: make _advance() check struct repo, not flag
  refs: add repo paramater to _iterator_peel()

 refs.c                | 50 +++++++++++++++++++++++-------------------
 refs/debug.c          | 13 ++++++-----
 refs/files-backend.c  | 31 ++++++++++++++++++--------
 refs/iterator.c       | 38 ++++++++++++++++++++++++--------
 refs/packed-backend.c | 30 ++++++++++++++++---------
 refs/ref-cache.c      |  7 +++---
 refs/refs-internal.h  | 51 +++++++++++++++++++++++++++++--------------
 7 files changed, 144 insertions(+), 76 deletions(-)

-- 
2.33.0.rc2.250.ged5fa647cd-goog

