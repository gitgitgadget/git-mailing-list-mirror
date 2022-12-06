Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A39C352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 10:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiLFKiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 05:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiLFKh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 05:37:56 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048BC279
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 02:37:53 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id n21so5090039ejb.9
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 02:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UyW8ZHLzy5YX32Si+hrfI8L3KbdPgNvqH+L3VMCsrhw=;
        b=PP50+VfeEXj2dmLJReBT0frKhvQNeBmpwV5Ic3vtBE/FJHDzLO1mwphx2DjtdN8ZoC
         X1x0lyC189fjbjfkvGz1IHBN6UNUTVQ9EgNjBBbNlKTR0JvAumdzZjTawaJZuXDLyN9z
         ui4oTVJFVnxOLXQU0lGmgV5cfFLrZlyfTTBZqAVHeKxGBdXWxwSGPpzsf1oQqL1046SJ
         GlT2fEBQvqSsPt/l1YiG1oQOoJwDOEt050w8J+ahu9NGS48TtEpQ2lTFDFt3IvmVg8zH
         F/B6m9+Ct4hVL6IZd1FoiPOzThphl8jlbXhYkK1cNi6SmestJvX/UCObj8El/XNOHzYm
         WkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UyW8ZHLzy5YX32Si+hrfI8L3KbdPgNvqH+L3VMCsrhw=;
        b=MBEFzUR3fWWqxdIf2QtvmcE1HBRe4K6MZUW2xtBfDndmpnegPVMdk+5uTyaRcKjCBS
         ASFsPyNXMnnAhlZ6uS+IppHNJ59wzVhJ7CvNVVIlAzOSb11TP+xhQnlUNlAsgYpyvcWR
         0VwL+xmXzyxvM7/QYfE3mYqnldlRnN1u6sRGThlxNT5eyWaivmJ3d5kvyre16omp1myg
         kR/NpT9e6bD3xR5YyHhGACF4vM/XMe7FJEMnCR/eSBpz5PSMzd1DSWghypFCQ3bUOx/p
         bBjxJtO9oCIfgvmMLPJ6jGlGnh8+xoMXHtMLqEmGRu1wpaNWiLVrS2enY8A9avUE8XWX
         XRSg==
X-Gm-Message-State: ANoB5pnP/PlBYSXA4tFf+/jqRLZYea8yeZdYvSThttI3U3WxYEOuiC5e
        om2byZC2RVh6DOhGYCeRvx3rX5+xYYCdOQ==
X-Google-Smtp-Source: AA0mqf6AXcOSXRAfjUsdF2ph9bMngVo5M+DDf9nXO+tb3kBR1c2Q58EwQWzQAhxiNdQdv/mpu48Log==
X-Received: by 2002:a17:906:60d0:b0:78d:3f87:1725 with SMTP id f16-20020a17090660d000b0078d3f871725mr21702687ejk.492.1670323071204;
        Tue, 06 Dec 2022 02:37:51 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2454:574:5100:bfcd:791:c83b:983c])
        by smtp.gmail.com with ESMTPSA id i9-20020a170906698900b007bff9fb211fsm7221035ejr.57.2022.12.06.02.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 02:37:50 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     toon@iotcl.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/2] check-attr: add support to work with revisions
Date:   Tue,  6 Dec 2022 11:37:34 +0100
Message-Id: <20221206103736.53909-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Given a pathname, git-check-attr(1) will list the attributes which apply to that
pathname by reading all relevant gitattributes files. Currently there is no way
to specify a revision to read the gitattributes from.

This is specifically useful in bare repositories wherein the gitattributes are
only present in the git working tree but not available directly on the
filesystem.

This series aims to add a new flag `-r|--revisions` to git-check-attr(1) which
allows us to read gitattributes from the specified revision.

Karthik Nayak (2):
  t0003: move setup for `--all` into new block
  attr: add flag `-r|--revisions` to work with revisions

 archive.c              |   2 +-
 attr.c                 | 120 ++++++++++++++++++++++++++++-------------
 attr.h                 |   7 ++-
 builtin/check-attr.c   |  25 ++++-----
 builtin/pack-objects.c |   2 +-
 convert.c              |   2 +-
 ll-merge.c             |   4 +-
 pathspec.c             |   2 +-
 t/t0003-attributes.sh  |  63 ++++++++++++++++++++--
 userdiff.c             |   2 +-
 ws.c                   |   2 +-
 11 files changed, 170 insertions(+), 61 deletions(-)

-- 
2.38.1

