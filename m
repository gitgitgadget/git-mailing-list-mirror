Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148B5C001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 19:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjHHTpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjHHTpP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 15:45:15 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5182411C867
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 09:49:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe4a89e7efso34748425e9.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 09:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691513385; x=1692118185;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=luzHLb3Z0j6V1gJDGFw7hs3FIs3ziOTnbcM5xPdgeXE=;
        b=lsiCXTxPM7NWuQR710AHidqbhIX5wnUqyKN/G9t7JtkZMTCu9kGH8JQpKHHunBGGGu
         GwIpBG8wIxu7SBbXhQrdozkeBtb0Iub+wcp6ZeIjyrGiej3Du/XZaeOMl/k2wEPYeEe7
         nQqwMklh44W7mb+ZaKXcPa3kW0dEWp2inCeoiDiBb8x4jmihrCtMrNOrwe00A/SsrFZm
         mdsONwdfA3EmZ96/3KrJZfXAZZD6EkxFLy79deVNuBjnGMcFjRTw0+S6T+CDDvT9Ykvh
         bucaeMxBU3Nj4sLgflprEOWTaNaMB+8XMOz2KYIAgYpYHjOT9Inwp+HG5snyW9HNGfIn
         hEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513385; x=1692118185;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=luzHLb3Z0j6V1gJDGFw7hs3FIs3ziOTnbcM5xPdgeXE=;
        b=GqO7mgjDEczQFdOOTbTor9FmG8X4plnsMGLoTuP8c/HjO/Mj2o+HLLm3gJUxMBiEio
         IKZiCQgeuoO2YNdgYSkIoQqXJuoPfESv7SgUk4MLAvb++gLemBeZB+V/16wRHzZKSzHp
         9F9VqUm8YKnyv8Swg0EEdHIflCRmtNu1FlPc1euGtkB8dNzwlyzAK3vjWRLck5bHKaMh
         8L4UqbEQJj4mNM343AAcz97xEK82DHYrGzYHQchmNv5dBpciMjGELAHAq+74kgOkTh4R
         ezVzQ1Ke+XrjXlFdrVy0MjwPc0o2fJoeqZbguAX/UjHGBjS/+n1HChioxdFBvLmupXF1
         CtNw==
X-Gm-Message-State: AOJu0YxGzQ78MuxEIuLHWnevAnTFr0Wc+k//u3TzSPE5aWU4MNzalS38
        UhP5ZEM4H6ROq0sIk0Xf/2gVciIcRjo=
X-Google-Smtp-Source: AGHT+IGJ7W56T/1PpJIBfY+venMvZPg8NN3To5o/fSfVzY5FQg6JJNDL4ECdWuJ5wEgqXfwP6UKbeA==
X-Received: by 2002:a7b:ce0f:0:b0:3fc:114:c015 with SMTP id m15-20020a7bce0f000000b003fc0114c015mr7248342wmc.39.1691491055717;
        Tue, 08 Aug 2023 03:37:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g17-20020a7bc4d1000000b003fe26bf65e7sm13325201wmk.13.2023.08.08.03.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 03:37:35 -0700 (PDT)
Message-ID: <pull.1568.git.1691491054706.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Aug 2023 10:37:34 +0000
Subject: [PATCH] t0040: declare non-tab indentation to be okay in this script
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

By necessity, this script needs to verify that certain Git output
matches expectations, including text indented with spaces instead of
tabs.

Most recently, such a check was introduced in 448abbba6347 (short help:
allow multi-line opthelp, 2023-07-18) which is reported by `git diff
--check 448abbba6347^!` as having whitespace issues.

Let's not complain about this because it is intentional.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    t0040: declare non-tab indentation to be okay in this script
    
    When preparing Git for Windows v2.42.0-rc0, I ran into this issue: the
    Pull Request's check-whitespace run failed. Let's prevent having future
    contributors from also running into this type of issue when modifying
    t0040.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1568%2Fdscho%2Fsuppress-t0040-whitespace-error-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1568/dscho/suppress-t0040-whitespace-error-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1568

 t/.gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/.gitattributes b/t/.gitattributes
index 9930e283512..b9cea1795d8 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -22,3 +22,4 @@ t[0-9][0-9][0-9][0-9]/* -whitespace
 /t7500/* eol=lf
 /t8005/*.txt eol=lf
 /t9*/*.dump eol=lf
+/t0040*.sh whitespace=-indent-with-non-tab

base-commit: 448abbba63471153df6ba520a5621595557ce3c8
-- 
gitgitgadget
