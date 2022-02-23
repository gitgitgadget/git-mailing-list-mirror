Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B05C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 16:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242533AbiBWQDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 11:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240043AbiBWQDp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 11:03:45 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602CF7DE33
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 08:03:17 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m5so173296wrw.2
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 08:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=LCahnt0o0IbPhVXHzml+P8fDiq48GrMKwHBl1KysAYQ=;
        b=XVsEcIAXzlAKq3QfFXnp1fuoGO9z3PbzjqSCUGsYS+r1KuBHQPwZBVsW1NkfiD4kI4
         8wkKubwW+0xQgp5EBao44VnoXOl/11e8Em2sNnpdk1kSGplGDZLaulLcTMPNkrvSa0sA
         OTdFFx98NSA8f8NtWhxWnW2S1qgxUr4HiIYXCZIrzbh2kjYRx1CFGAYzLvsHiowsLODB
         KaNvJFWsNBG+dle2k8pXvQwAx9tVo2om/TjQAbQNu7SKPBvimSEMCmrO+SjsTXMtCqnc
         7ELK0qlXPvMhQuFTv/DKOH1KMclbFVowvPsduvndl4HJuFmEpaqO9rHeyDnzDH865Yj8
         RTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LCahnt0o0IbPhVXHzml+P8fDiq48GrMKwHBl1KysAYQ=;
        b=Sf/2iRWNq6Csh/X/K9B9S+EKYVJzwsNKpkJNVegqwEC7UG3Cyhyb4/zwFdrviuAujt
         yGuPbI5NuceMdvCTzB9/toONei30rEIg1OBOSJYHe+yqiJ6riw5QMI2Ti2VTIZydEe3i
         DcTLH/dbUQ4+oqqVbASonwLhy1wM2+PG5KRBYqnaEzLH1aAc32OqH//yzZOogQCnddr7
         gmK0AH3PT3eX5DqYNADlOWS2rqSNt/tisUwV+Fuh4GLuqjWwyGpH+hzOzLSgAvAb+fKa
         uQjN8gxFyTuLkZACVxsnqrntkN6H2LoQRLa5btOtEBW2EqDPnp6DH43JHTsENxjYJAV9
         K3/g==
X-Gm-Message-State: AOAM530wCTYjcjT/hrIFiCzHkBmH/PyWntHBg8cHJq2hEGmFZaReRjWM
        JxDMwTSlFH+vMbJsPuTCH843X9mT7bY=
X-Google-Smtp-Source: ABdhPJzePXuhalOAHtJwsr4loMF9ULDtj/ebd1iED6rtJVVPbEECUtl4J0CopoKtcUqWjENJH1cypQ==
X-Received: by 2002:adf:f94d:0:b0:1e5:5ca1:2b80 with SMTP id q13-20020adff94d000000b001e55ca12b80mr225241wrr.323.1645632195618;
        Wed, 23 Feb 2022 08:03:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z4sm99740wrr.82.2022.02.23.08.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 08:03:15 -0800 (PST)
Message-Id: <pull.1158.git.1645632193.gitgitgadget@gmail.com>
From:   "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 16:03:11 +0000
Subject: [PATCH 0/2] Specify the actual pack size limit which is breached
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, derrickstolee@github.com,
        Matt Cooper <vtbassmatt@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git allows configuring a maximum pack size. GitHub (like presumably other
Git hosts) configures this setting to a generous but finite limit. When a
user attempts to push an oversized pack, their connection is terminated with
a message that they've exceeded the limit. The user has to find the limit
value elsewhere, probably in the host's documentation. This change adds a
small convenience -- specifying the limit itself in the error message -- so
that users no longer have to search elsewhere to discover the limit.

Matt Cooper (2):
  index-pack: clarify the breached limit
  t5302: confirm that large packs mention limit

 builtin/index-pack.c  | 8 ++++++--
 t/t5302-pack-index.sh | 8 ++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)


base-commit: e6ebfd0e8cbbd10878070c8a356b5ad1b3ca464e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1158%2Fvtbassmatt%2Fmc%2Fhumanize-limit-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1158/vtbassmatt/mc/humanize-limit-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1158
-- 
gitgitgadget
