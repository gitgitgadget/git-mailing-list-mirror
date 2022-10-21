Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834E8C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 13:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiJUNpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 09:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJUNp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 09:45:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D722EC536
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 06:45:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 186-20020a1c02c3000000b003c6c154d528so5011399wmc.4
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 06:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PzZ+Xg9iZ3SXBMHv8G5vkMy8RFPn1m98TtCtJ1dhkqY=;
        b=dUn0I5416FkQ5cqp9bfZA/7gGyHHYVhHJB0qY4EEUvVjp28Mf8x9G8Hs8V+vWIGjpm
         joaq/ZKgzZtvZqyjrG+GaRa8Xz41/Z5DFhaaTwem3dsnemmvhRm9VlJPLFJGp6WQm9sK
         /m9z1Zhkil+bNnAIybsWdtosaagxtYMfad3FpDH1k9K/H7+M9GiCVrCth/+z3+T3eU6j
         nGDNLfAA+bJ/AitH0Q1h8INLxwY6ZDZOq2OZwF45KgxXYBps5w1Z46Qy0B9vDP3zliHu
         hbqkonrYsBebwtuooxw12uF9+IDPnXpo8Kfu8YDsYNREbEw/g2xA+KOKGfTbtmqsSeOH
         uPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzZ+Xg9iZ3SXBMHv8G5vkMy8RFPn1m98TtCtJ1dhkqY=;
        b=uMqG1cviTCxa2gFM+NNUpZl7mVTJDmoFD/5W2YjCi2gjXuojM+xhw7RZw8rrbOd8Ut
         7MtpkzQACuQz8ljRSXoHlPgPfyOo+itmAG/mSkylyuyfjMUF+ETGrXbqnx+VYUt2uaiS
         foTw0zJp/h+aQtd9Nf06oY4WlM+Z8FYmdfHD51CxF1OzTOrPaFfnwGpofkQnmvFBhA9p
         G2AZ/iNqxaoeEPMFXM1aaUm+h2p73IC6Ab3l7grqEEu5RprxOvepfPv9ubMpdAcVuA+C
         HZu/JzYu4X9HqjE5W8UPBBDFqlg4LKdLjTw4L45mGjco7tdhwLs/YIkFhWAYhRUyzahf
         eXqw==
X-Gm-Message-State: ACrzQf1r9tu+pBJWLtY+PVhKQIYxOTP8t3sQNJ2qgQcZMAwR3W7/ekWY
        z4m9aa9rrwTdYgAXEOno+RrLVTRzH+E=
X-Google-Smtp-Source: AMsMyM5JD1SBA2clm2BGFOdAnaTTxRK0ef6SX+g1YpyiwG1VxAc1F7TIvS664d1tzR7HWjSIYkNZVA==
X-Received: by 2002:a05:600c:538a:b0:3c6:c223:7ec5 with SMTP id hg10-20020a05600c538a00b003c6c2237ec5mr13428348wmb.37.1666359918371;
        Fri, 21 Oct 2022 06:45:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d6787000000b0023622d65d4bsm5198969wru.81.2022.10.21.06.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:45:15 -0700 (PDT)
Message-Id: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 13:45:11 +0000
Subject: [PATCH 0/3] a few config integer parsing fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes some issues I noticed when reading the integer parsing
code in config.c

 * git_parse_unsigned() does not reject negative values
 * git_parse_[un]signed() accept a units specifier without any digits
 * git_parse_signed() has in integer overflow when parsing MAXINT_MIN

Ideally we'd have a test tool to unit test functions like this, I haven't
found time to write that yet. cc'ing René for patch 3 as he was the last
person to touch that code.

Phillip Wood (3):
  git_parse_unsigned: reject negative values
  config: require at least one digit when parsing numbers
  git_parse_signed(): avoid integer overflow

 config.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)


base-commit: e85701b4af5b7c2a9f3a1b07858703318dce365d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1389%2Fphillipwood%2Fconfig-integer-parsing-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1389/phillipwood/config-integer-parsing-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1389
-- 
gitgitgadget
