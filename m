Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5D1C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 00:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiEXAXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 20:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiEXAXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 20:23:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CCE880E1
        for <git@vger.kernel.org>; Mon, 23 May 2022 17:23:09 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id p10so4857834wrg.12
        for <git@vger.kernel.org>; Mon, 23 May 2022 17:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=6xMSmo6M30HSPzFcK3W7Y/bHJDNC9xksuq4h7tWXPws=;
        b=jA+UvkUU+Qzm8GGp+AL2T6jsnx5KIg72FZq2cVTQMyEbjOdlbfpTnfhR55Z0veOd+B
         bQEDXUjjvKFHV8jSsl5CInx9H4VAsyeycm+mxFqzf/XC3LCAVyAe0yZPJN43kMAdHsSm
         k7JHGBgragO2NY73akqhXlPNfzQrgL6pH6siX3yg4yfCHPggTHWdd+pSEdOHsWvXmr+j
         jUGJvcNYU6sz9Xk1/r05Rr/b4OT6/kNUUoPFExLK4MzrKiK4aiHmN++h0msbXwZztO7m
         2HR2zLQ7g2jpNf1acsICUbgnuW7+3aRxTJY86EwCb5YsnFbbkpBicfs13RjlDGFKcZSp
         j5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6xMSmo6M30HSPzFcK3W7Y/bHJDNC9xksuq4h7tWXPws=;
        b=Sbgs82Y3GjD+qRqjjNVwJqlkIuWdFHAkEiAGB5AZd5T45pg5RJeUak+e0WUr3yoEBW
         Is89G7Q9NCEXKJmJ0d4Kc34btRguNWpqYQD4PU1oHQrLPELV9GjmpCyurVmhwqwVy8eK
         FnpvHQkoPlTgsajjNW9/1641VXr0inI6+1F6wNzsHIuWTtIDgZ1zniRxZTo24u6pr4FC
         Ev7XhZRWduo4loNDddRwT67NjevvMusJOwv2kzTxj6T/36RNtFEfxH3noP26sZi3REWK
         w9bkmv7PydN9yfX3DU9QW0ayXaV0+RnPUcrhSumHMxTmBj/j3kQCznapuW79BpP8acRn
         g8qQ==
X-Gm-Message-State: AOAM531HNYXG88CVATydlT6EkkG15ZhshZ8w8HqyJWdhX+feINjyi0I4
        eoUcTOzeiyTrd51uXz2ZMee6p3gzWQY=
X-Google-Smtp-Source: ABdhPJw9TGa3roWFlRE+GU1mWOYm+5GlIj/ZtclSUuktItdFkIcdS0w+46El+G97L3jJXqJuEGXlcg==
X-Received: by 2002:adf:9d83:0:b0:20d:129f:6544 with SMTP id p3-20020adf9d83000000b0020d129f6544mr20752810wre.568.1653351787582;
        Mon, 23 May 2022 17:23:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b003942a244ee6sm535974wmb.43.2022.05.23.17.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 17:23:07 -0700 (PDT)
Message-Id: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 May 2022 00:23:02 +0000
Subject: [PATCH 0/4] ci: fix windows-build with GCC v12.x
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A recent update of GCC in Git for Windows' SDK (a subset of which is used in
Git's CI/PR builds) broke the build.

These patches address that, and they are based on maint-2.34 (earlier
maintenance tracks would have a trivial merge conflict due to 013c7e2b070
(http: drop support for curl < 7.16.0, 2021-07-30) removing support for
USE_CURL_MULTI).

Johannes Schindelin (4):
  compat/win32/syslog: fix use-after-realloc
  nedmalloc: avoid new compile error
  http.c: avoid danging pointer to local variable `finished`
  dir.c: avoid "exceeds maximum object size" error with GCC v12.x

 compat/nedmalloc/nedmalloc.c |  1 -
 compat/win32/syslog.c        |  2 ++
 dir.c                        |  9 +++++++++
 http-walker.c                |  4 ----
 http.c                       | 15 +++++++--------
 http.h                       |  2 +-
 6 files changed, 19 insertions(+), 14 deletions(-)


base-commit: 2f0dde7852b7866bb044926f73334ff3fc30654b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1238%2Fdscho%2Ffix-win-build-with-gcc-12-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1238/dscho/fix-win-build-with-gcc-12-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1238
-- 
gitgitgadget
