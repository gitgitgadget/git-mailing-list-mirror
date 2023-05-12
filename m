Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9E9C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 21:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbjELVfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 17:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbjELVer (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 17:34:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E689F3598
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:34:45 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3090408e09bso547960f8f.2
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683927284; x=1686519284;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xUISIx4ekp2oQ3wL8vDtYL0iZ8p4SCENhKmnI+TaHw=;
        b=nuYebL6MxtMeeTj0f32wLZM7PmZfPhcBcD7/lc9gXbHmTIXl7FIDBba3DtrwIXMs2O
         Q/lIWU64E/Cjv8RkQX88hgL+VFiXRLMP7Mj1zpr6gYSQ8dV6ZI31Dep69UOsm84ieQ/w
         cRHesatkCJ/45ZT/ONt0dBLDxP9FeYkJUo8LosFvpX5ZgfI0fNNx5HBtb/xmkfyHVbTp
         CcrDzFN09D9nKXe9AH5k//Jnl4/G8/r7mwoWqlfYHXw1WDhT2aa7u515ZHeFP0bhXSxU
         ragoH2FL+FeBxE6yOH8PmHwTyvUsMOByKr1JeLhfX3dQhvALq8lUSALf6jeYoxY6gw+H
         WKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683927284; x=1686519284;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xUISIx4ekp2oQ3wL8vDtYL0iZ8p4SCENhKmnI+TaHw=;
        b=E7ZcDY1v21kKMM3yPRXO9CYlcTpX7/KwzM6J+H2A5uYvaEvchtQts1MMzHb/kEp8hl
         2DZNKDUEUeW6in9KtBxrXSh5aZRx1accaNvQ0jRxHfBaFLNNxhVnp71Ykv69ZzFB5VP4
         D1/YWUKTiLnQRw4Nq6T3BEguqRETleB2lCBbZS0a8ER5p19hAqG832U7iJF4L9Jj945e
         6JHStDqs8T7GehNJTHE8KL5Q3CiTde+clVSZ75PzA9tpujClk+MasBHzubCzvCQnwdTg
         aDQJy/iyE0/z2Z2a/dAkIJtiMiCRzjo1bUWGJvLKfrkIZ4V4x4lHIKmB8a4Jh26UAFa2
         okhg==
X-Gm-Message-State: AC+VfDxUGWE7DPjFuCS+z+MvqawM69kB0CI3xRQTzqhXJWU4+9kytiG/
        CgY29iDSTr2clFhTdv+beMfIuShy3Yo=
X-Google-Smtp-Source: ACHHUZ7QgFFPkkl3wwy+bM0dKCa4OYTBJ5gd627J9mJes1hdBjeXkUIJIrEeGiOmomi6wfOJ8TU7pg==
X-Received: by 2002:a5d:4d4f:0:b0:306:3da7:f33c with SMTP id a15-20020a5d4d4f000000b003063da7f33cmr16034051wru.63.1683927283987;
        Fri, 12 May 2023 14:34:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k25-20020a05600c0b5900b003f4272c2d10sm14970698wmr.1.2023.05.12.14.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 14:34:43 -0700 (PDT)
Message-Id: <554da1dc705f437c4822b9bc5c8b604abf1e6144.1683927282.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1501.v4.git.git.1683927282.gitgitgadget@gmail.com>
References: <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
        <pull.1501.v4.git.git.1683927282.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 21:34:40 +0000
Subject: [PATCH v4 1/3] docs: clarify git-pack-refs --all will pack all refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, John Cai <johncai86@gmail.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

--all packs not just branch tips but anything under refs/ with the
exception of hidden refs and broken refs. Clarify this in the
documentation.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/git-pack-refs.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index 154081f2de2..22f00665006 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -51,8 +51,9 @@ The command by default packs all tags and refs that are already
 packed, and leaves other refs
 alone.  This is because branches are expected to be actively
 developed and packing their tips does not help performance.
-This option causes branch tips to be packed as well.  Useful for
-a repository with many branches of historical interests.
+This option causes all refs to be packed as well, with the exception
+of hidden refs, broken refs, and symbolic refs. Useful for a repository
+with many branches of historical interests.
 
 --no-prune::
 
-- 
gitgitgadget

