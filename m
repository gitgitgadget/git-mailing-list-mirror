Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA56EB64D9
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 11:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbjFNLXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 07:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjFNLXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 07:23:09 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B9FE69
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 04:23:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f8d86db375so6569555e9.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 04:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686741787; x=1689333787;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c4Jyyr8G26bF8RH4ded0ag6ntQjb8w3ed7yjMKaFyM0=;
        b=eIBcbjpYtxpHgXV0oZ+0Gz0bd9pVCyahpF/ZT6vcs5DQYEQ5H1fTFc2c5C/+Hdx1sD
         vXIuzM3DjHuldwAJSlsIbHNcO2e0Tq3K/vOVsiX65L2V9C0Y/Bgg6P6VT4CY7OYf5XAj
         akregQxfDDBlBtZPctOGwsbWZHAc6pn4w9ImdrenL4ArUH4p+mhZqn4em5qoGo4ub4UC
         +nDxfStzmk/0HP9zuxjgxGRti+ttP4FaiCifN9wnyvQA/mTGQ1dQJ6XUUs4AvlQZ5p3G
         UgXiTtDQDk/yWVJ0e9QX17n+lS4P78G1A3vhRtlu7IhEwWN7jdHHtuhA7KUb5m1rGWLk
         dknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686741787; x=1689333787;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4Jyyr8G26bF8RH4ded0ag6ntQjb8w3ed7yjMKaFyM0=;
        b=ZTJMZBnL4QnZIXBipy1STDEE/frQH6cgdqKGb5RgHw/CCf7qtEkqZuwFFds35Rtv3r
         vBOj2T4JEdRE+X23ZbgQGAFDySGB8/1pn6P7B8EEeeIwKcSB7FQtU0HD5A6ViH4mn0Az
         FzWCqCQKw/wgAkS2JPf156kRiSK3ovq8CvXheAhLJpYwoXqG1kJlYJuQz6D1klQWPBd9
         GS4dImkPw5/EpYnrKY53+TZI6qfE1ZAo+6bCl6Dpde867FI9JPEhFlQrGbkFpfkN4mqR
         6bVrmCaWllpiJUCJtr4Vq2Oyt81OyH7VTMdGyzBViOi1A7oW7O3EZeH6kFc1CAUUx7PW
         cbww==
X-Gm-Message-State: AC+VfDzPNvGtV+UeRPzsF+hy3jkLco/EfNBt0B9JTw1BjoP2+qeMf1NI
        uPyg9uO7YTL5yedv4mv8qrbDwb8gAkM=
X-Google-Smtp-Source: ACHHUZ7re7fze0nJ3tZdjqYV0VL4dMFLLD+gNSB8gHSJ5rYl0BV7WFayJhYJZIarm6o2f4Y37KsBpg==
X-Received: by 2002:adf:fa02:0:b0:30f:bc8f:4e76 with SMTP id m2-20020adffa02000000b0030fbc8f4e76mr8166612wrr.7.1686741786465;
        Wed, 14 Jun 2023 04:23:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b002c71b4d476asm17894936wrv.106.2023.06.14.04.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 04:23:05 -0700 (PDT)
Message-Id: <pull.1525.git.git.1686741785.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jun 2023 11:23:03 +0000
Subject: [PATCH 0/2] credential: improvements to erase in helpers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cc. Jeff King peff@peff.net cc: Matthew John Cheetham mjcheetham@outlook.com

M Hickford (2):
  credential: avoid erasing distinct password
  credential: erase all matching credentials

 Documentation/git-credential.txt   |  4 +-
 Documentation/gitcredentials.txt   |  2 +-
 builtin/credential-cache--daemon.c | 11 ++++--
 builtin/credential-store.c         | 21 ++++++-----
 credential.c                       | 11 +++---
 credential.h                       |  2 +-
 t/lib-credential.sh                | 59 ++++++++++++++++++++++++++++++
 7 files changed, 88 insertions(+), 22 deletions(-)


base-commit: fe86abd7511a9a6862d5706c6fa1d9b57a63ba09
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1525%2Fhickford%2Ferase-test-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1525/hickford/erase-test-v1
Pull-Request: https://github.com/git/git/pull/1525
-- 
gitgitgadget
