Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E7FC433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 15:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E6561405
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 15:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhD2Pc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 11:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbhD2Pc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 11:32:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D931C06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 08:32:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x7so67322638wrw.10
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 08:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=S46ejOd6w8RE0rEYNxAISF+M6J/EBeSflzqO6ge0Ig4=;
        b=i6fJ+5rDNv260Hxbu7A8FIoND/oY8AGHhTY3PDRkrYhMRqRNx1iTv+Pvt2KWmuIL2p
         aoDoxOyt4xwTH1mrn4PP2oRYrNrJGpLsC9ing5A8mbs/QC2TnxGVNoXf2ggPn4qc2/RH
         g8SgOUBSAj0p9tUy/eLhC5UpP/vNL5AOIK3zNdnQHOnHeZmgnbuVEtTIJaefb5MpRqyE
         Ghp1obXKseIcDPhQXBldlMHyiNGkmpMjV5Rud7K+v1E8B20aMmdA+ogmIdMefD272PHT
         rhCWLSEDcVvjXjwO3z1kq88VdFfmNDYX5ux+JDkd74WhVE7YZ37K19nv6u/SKHpgilcY
         4XhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=S46ejOd6w8RE0rEYNxAISF+M6J/EBeSflzqO6ge0Ig4=;
        b=IKdwwixbX0n2XRKofnsk52Cfh9Fn9LqxAr2S1CMRbWNC1hkcu/+rkmPeO3vZFr20DT
         XfmTyMGK2iAzx5UG9QW20i/TzNNstd5AJy60KDNuC58jRAdfD7ovNZwa7IeLYl26fUnn
         vC79ayjTophDVr3EomTglM1aPHh6zerJiRw9t1W9tqfX9Ld+6Z9Iu4kojnEm0vDt+Efx
         fVgEoip87TfdY/iSSv96CxAe1Ofx4sKSVnNmZYeSUNoMZOogafVsYKWW/FtXXjZkQYor
         10p8bb8MjeLHek/9JMmm7hOeDtOF8G4Db8WbAa+FwIjrAL6czE2tkjQ0YWnUoczHOi19
         T2HA==
X-Gm-Message-State: AOAM530pEGUAeEw3mZICno6syOUS0bIT66lsD9A+T+hJ1VZJA+3qMmNi
        +998cVwjLLRsUzKQ5Uc2BoB70w9W768=
X-Google-Smtp-Source: ABdhPJwgb4NLIy/25wxGPImplcF+iYS6JgVAd2TUlxUc6J7hDACSx2KdRmflNkd6pFBdfnfRhLWPbA==
X-Received: by 2002:a05:6000:50:: with SMTP id k16mr408432wrx.418.1619710330412;
        Thu, 29 Apr 2021 08:32:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11sm5298764wri.59.2021.04.29.08.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:32:10 -0700 (PDT)
Message-Id: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Apr 2021 15:32:00 +0000
Subject: [PATCH 0/8] refs: cleanup errno sideband ref related functions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3

 * remove errno as an implicit communication mechanism from refs support
   completely.

Han-Wen Nienhuys (8):
  refs: remove EINVAL specification from the errno sideband in
    read_raw_ref_fn
  refs/files-backend: stop setting errno from lock_ref_oid_basic
  refs: make errno output explicit for read_raw_ref_fn
  refs: make errno output explicit for refs_resolve_ref_unsafe
  refs: add failure_errno to refs_read_raw_ref() signature
  refs: clear errno return in refs_resolve_ref_unsafe()
  refs: stop setting EINVAL and ELOOP in symref resolution
  refs: explicitly propagate errno from refs_read_raw_ref

 refs.c                | 46 ++++++++++++++++++++--------------
 refs.h                |  1 +
 refs/debug.c          |  4 +--
 refs/files-backend.c  | 58 +++++++++++++++++++------------------------
 refs/packed-backend.c | 16 ++++++------
 refs/refs-internal.h  | 31 +++++++++++++++--------
 6 files changed, 86 insertions(+), 70 deletions(-)


base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1012%2Fhanwen%2Feinval-sideband-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1012/hanwen/einval-sideband-v1
Pull-Request: https://github.com/git/git/pull/1012
-- 
gitgitgadget
