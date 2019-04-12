Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F058920248
	for <e@80x24.org>; Fri, 12 Apr 2019 23:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfDLXEl (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 19:04:41 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43715 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfDLXEl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 19:04:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id w3so9735624edu.10
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 16:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=DieokqbN3tKO3WuLRvWz4/ZnajKu5DHl9xuuNNKG2Yc=;
        b=MzawMACh/GkoAEG3+360+1+R02rw9Rt1IWsoIfjnGnhz9f0Vjr1s1T2XG73Ipob+fq
         fLslHFhO6Xovg8Dkw47A/Y31eJWttSaII0JdbNqrkV/lA2uAQ1T7Hv7vUG53PznWjkYK
         k5HMocLB9a6ZCBt5URrrilQsv0Dw4FJdDHIRJw1N51hhEX6ynCGkKQlJWJM39i3IjGw2
         5HIjK8+7T05H95uC1wlVNwBeLreDEVx+CT0eYEJrtMyuYFx7TdGoJ845s0ffhQb6rpf6
         BbOWOGWGDcSE/m6VamKM8VWXewr4fKDLWlFPZeet1bHB7/akCjOS3g4Se56B7HUz5x+T
         +enA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DieokqbN3tKO3WuLRvWz4/ZnajKu5DHl9xuuNNKG2Yc=;
        b=g7e+WFiQUp8MvMh3A3oNpVgoF7apJP/xXKJdn0kbHrsSxFSBD/weW17xy1s5Awallq
         Ii5Ocy9s9aDqC/oPL6oAgMT5SR56kQ9vwdV1WBwEIYgkltKoDpQK5DxipxB6ppZDSEJ+
         ET1dZmqbXY9997ysvbV3Ojaw4hSLziobJ199bdFOGLuXkXffEimz0TSoji0xChbnqILb
         9wFcEE8vQPcTwc3pR9GLp0nvrBgpPpNRmZRrEBxW+6K6QFs/VQn2IKgQqm0uspPlAHHz
         LNBUABIERYSnhm1cHWMUVV/gAVLJ3odEalaDEii2aRhvQVRW7wpSefSzUiRCF49iONBL
         sYxg==
X-Gm-Message-State: APjAAAXBcsGK6eBHATzdmTloV5f4N9GKyaR5ssed/kGvrJd9qHcO9ECX
        PDv6O2j8auiSGFpms2yK+4k7uSYz
X-Google-Smtp-Source: APXvYqzIFK9xvrkv6YB9l7GsQ4Ll1uVtibBbgTNG63OoT149CEKy+ilZFICycTYqH64C/E/sYMVgyQ==
X-Received: by 2002:a50:92a6:: with SMTP id k35mr7751319eda.100.1555110279298;
        Fri, 12 Apr 2019 16:04:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18sm12021461edc.17.2019.04.12.16.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 16:04:38 -0700 (PDT)
Date:   Fri, 12 Apr 2019 16:04:38 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 23:04:36 GMT
Message-Id: <pull.145.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] Avoid spawning gzip in git archive
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When creating .tar.gz archives with git archive, we let gzip handle the
compression part. But that is not even necessary, as we already require zlib
(to compress our loose objects). It is also unfortunate, as it requires gzip 
to be in the PATH (which is not the case e.g. with MinGit for Windows, which
tries to bundle just the bare minimum of files to make Git work
non-interactively, for use with 3rd-party applications requiring Git).

This patch series resolves this conundrum by teaching git archive the trick
to gzip-compress in-process.

Rohit Ashiwal (2):
  archive: replace write_or_die() calls with write_block_or_die()
  archive: avoid spawning `gzip`

 archive-tar.c | 54 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 13 deletions(-)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-145%2Fdscho%2Fdont-spawn-gzip-in-archive-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-145/dscho/dont-spawn-gzip-in-archive-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/145
-- 
gitgitgadget
