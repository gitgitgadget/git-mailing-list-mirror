Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CA0C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 09:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD5F3611F0
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 09:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239910AbhI1JMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 05:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239827AbhI1JMq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 05:12:46 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E1DC061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 02:11:07 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso28044018otv.12
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 02:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1MgEWOIHT4udSAtMxdte6TQXQh7XGGU640w3wMbxWzE=;
        b=TlhImCzK3b26biTYaj/xqY8qABAh7CKtsHcNNLn1KLKGAaxYcA1yVP+6+ViZHZI2o3
         5i5wPDlRfuOv5M41gWxSWy0+5y0dP2NpsSRhb/rwouGtpm0NTIzsiWqfOFSZ2/kLUKwg
         iuHGtc7/k+m91aQseDLXzk9hCwGXVWE+Bjem0nhC7whYmU5HSTx7RwsLMvcnWVAzlDs1
         0jzB17MmcQ8d4mROWLi95cPKgcVl2Kxjza+jIl/YJ6uBq5QKr4k0B9sLQBpy2zSPyqlC
         IkoSdWUyuyPokbCoUSWUGN96fK4n/S5hG2my5oA4bgemkWnVPI4CbZpxcLrBN2sCvYcE
         rqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1MgEWOIHT4udSAtMxdte6TQXQh7XGGU640w3wMbxWzE=;
        b=Ik1GjjEf2hqIPXa3vts7E37ZcSixuKBwFZ/yxmpf74LbUmJ2MUz8zl/YAeaOnQQxDF
         6qdfdM+UjWnoFYe2drWXGGzjPSIcaPYA0WKDVyHbh3n5x+cavCCnhJEAq7akNPSV6bNS
         dRN5053mVQRgLa4hxFS7omdo2gSZULGZ4ejRVt0JJC5+yaIZ1Ct15DQwz6ZBXoproTbC
         pMT1OBMIPCMfg6Io4grebRvbsQqwjLIJVAf8hwwW8f0tW7iQoMyBM5S4oUrHlwpyn5RK
         bmIsVaofwyeMrWuS42JuerTe1VEKA7bmlC4c6jFuBwEsw6XAzEv2xXFx8IH6dbBRJAD8
         if2g==
X-Gm-Message-State: AOAM530VCRlhLG4GEs4uUA3mqsoggRPmD5yzkROmTWAA/EWKsiCnpwW8
        Lbr2eeidylQd5DVNpEvv0CW6FvgviCHy1w==
X-Google-Smtp-Source: ABdhPJzbuwghTSX8TJSrLXzR7bCTy/K6eU2B0DZzEAvvKw/FnON5gHbav8W/MgwpWpdm55ty865dog==
X-Received: by 2002:a9d:6142:: with SMTP id c2mr4173215otk.118.1632820266446;
        Tue, 28 Sep 2021 02:11:06 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id r23sm4441250otu.54.2021.09.28.02.11.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 02:11:06 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, avarab@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 0/3] Makefile: tighten pedantic flag
Date:   Tue, 28 Sep 2021 02:10:51 -0700
Message-Id: <20210928091054.78895-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series uses the feedback provided so far to tighten the pedantic
flags that were added previously, which is mostly done in the first
patch.

It is based on js/win-lazyload-buildfix to avoid merge conflicts with
it, but could be also applied independently if needed (specially patches
2 and 3 that are somehow orthogonal cleanups).

Alternatively, patch 3 could be dropped and patch 1 refactor based on
the reviewer feedback.

Carlo Marcelo Arenas Belón (3):
  Makefile: restrict -Wpedantic and -Wno-pedantic-ms-format better
  Makefile: avoid multiple -Wall in CFLAGS
  config.mak.dev: simplify compiler check for multiple compilers

 Makefile         | 3 ++-
 config.mak.dev   | 9 ++++++---
 config.mak.uname | 3 +++
 3 files changed, 11 insertions(+), 4 deletions(-)


base-commit: 2d84c4ed571215f4cdd5ea05a46861974d10d123
-- 
2.33.0.955.gee03ddbf0e

