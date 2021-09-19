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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40D9C433F5
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 01:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B748E610F7
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 01:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbhISBuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 21:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhISBuX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 21:50:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E7EC061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 18:48:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i23so21937043wrb.2
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 18:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=GxU301d4KhUByJ72grG2s0hvWteH8174ohUmRiByvYk=;
        b=R4S9WWLD4CvchdJCUTRStq2QKjoKfbZgtsO0H5aE/nUwgWSB7j4lvy5XvnJaMgsjjG
         5BPTYL82JIZFFCojoCpf9cknQivDPj57e6LiDQGuzTldw5hHaNBKRpeMifTKi1mri8Bt
         zQHBmZEbiSyeSI2X0106s2S3qYQ+xn1+btkn3eLy0qy4CaYRFtOjVEbTVTI+kFhvdANs
         hCXjKxkGatkmOFZW/EqAIyUNxRh0N9IcATs+7wd/iZE6m7Bf4MDCHxKhH06qPZdQ4dAb
         UV+ckpxidKvOqkI9UnAIKZE2HLYgM+O1+5f3iztnrbtIG+gPdDZ/oqdOCtER53du2OIz
         mnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GxU301d4KhUByJ72grG2s0hvWteH8174ohUmRiByvYk=;
        b=R9ZmVWjwZ+1kpPEujQsjUKGch1PnmevYMJ5DzN5Shc0JwH/bqO834tvURywCyTjGVn
         /79SVckf/muDhx4+qR6qi4ev6u8RD1op4kh5CH+O0VJgavMZKIrhHA8dEKqWPi0v2ELi
         oB8rdwdauPepMZ/AipDRlMn0KkRgfAtgEA6rF92JcjiC9jVeswNbvb+p8v1ZmFh/8J9S
         xpnKriw6aU19fWEyHoQ3jjHgQVwNMoL0R2O4en45qHayXDqXULx2SeFQQwED3R1FEwwJ
         yFmk6ysybAc/mgWCTSW9OdBbAAYJtNl0oXsYah5R7fuSzpMSjztILzPLv6uO74J68Bwq
         emQg==
X-Gm-Message-State: AOAM532B+qEaW+5EqFhJfb6PevhtT9kcUdrZWJA95NzbLhR3DdtK7vv6
        aSfqoL/AZan0YnOkZIR1tF+CVTemnG4=
X-Google-Smtp-Source: ABdhPJwK+ZqsfdIKy4v9yurM8lL3rWPYKUK8OJnlkARIckrahJJ1g8SJ9tWC4KTk+aWIfMT+3BXCrw==
X-Received: by 2002:adf:ea90:: with SMTP id s16mr20519080wrm.235.1632016136960;
        Sat, 18 Sep 2021 18:48:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r9sm3689798wru.2.2021.09.18.18.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 18:48:56 -0700 (PDT)
Message-Id: <pull.1093.git.git.1632016135.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Sep 2021 01:48:53 +0000
Subject: [PATCH 0/2] Fix a few comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a couple trivial comment fixes sitting in random branches that I'm
finally sending upstream.

Elijah Newren (2):
  trace2.h: fix trivial comment typo
  merge-ort: fix completely wrong comment

 merge-ort.c | 2 +-
 trace2.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: 4c719308ce59dc70e606f910f40801f2c6051b24
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1093%2Fnewren%2Ffix-comments-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1093/newren/fix-comments-v1
Pull-Request: https://github.com/git/git/pull/1093
-- 
gitgitgadget
