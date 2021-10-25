Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F50DC433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14CD66105A
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhJYWfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 18:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbhJYWfB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 18:35:01 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE7AC061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 15:32:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s19so15398042wra.2
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 15:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=EmF4LqLgiYhisk6aGzRm5FpnbzuOm0RculJI5iBgQZA=;
        b=Y5qu9Anr7Q4oaqq2HiXwV/tS1cXZGfEOUvHOs9H72WTu1hLflwjD4BBonoIbdEmene
         twH4Zv1fbBRTbQhcvu3vZkrxFA8JyfJB9ivhlKXlTaTDtQFrGEXcK9/kcVUzsGiPSPQ8
         YNBJbOaswGkzRtrUj2GH58tSTQuKCyaI7lcS9ae0Z6udiRf/ZyeRr+WfKNAlEIXxEkKP
         pOfO5BkqFr8+MhNmvh/QwrdtwLTGDiRDV6U3IfTWHLLjFKtTVOAnNgNXmRJYm62xh25g
         aFH4Q+3lR41qznvtGkzd/cDJoFU57BzDZifz42q4tAq4tLLRHFlgnq02zxm6RwQcqt4U
         Ey0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EmF4LqLgiYhisk6aGzRm5FpnbzuOm0RculJI5iBgQZA=;
        b=2SsCpMjYOptx8Ff2iVAM6IqgC+k3RUBhOSjyHsrsOkPfiHQRvp5jBOHrDIWjxTNTAc
         tN+WphjVoCPy500sbSf2wpONzFTaIsp+q4IAoMZdFt4z9wfdZlz9bEhLAVc09tU5fiW2
         ATfm0r1xf/DqTtyiMPfGdamY8ridvilqkl1orhflh7sZU9g9ZZbUW4LZ1MMTuaJbjM5t
         Y5yJrBtaWu0zWI3McJiffL23iNvEqYod/Slb1/iOSz35agk1DpKrdhm3df7IL+wrD/57
         UxcvY9bX5JvuXCthtjAnYDF/80aGEinN26MwXqPx00CgouPKVKy7bEWCAVp6tDVxE+xY
         G4fg==
X-Gm-Message-State: AOAM533lngHJX8V71e6ciGN1+fftTHFi7EOwKP7oyVyP2X0VoWw3t/fv
        i94Ii/VSziIItYdNrCs9QjW9UjHac6o=
X-Google-Smtp-Source: ABdhPJwLM5D9reyjyQgHkhC27bsD8dTjf185jimzwPpB0AI9wW1CwDSEieEsRDnYEuMzphc0AXnhRg==
X-Received: by 2002:adf:ed84:: with SMTP id c4mr27125906wro.316.1635201157092;
        Mon, 25 Oct 2021 15:32:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm20377752wre.32.2021.10.25.15.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:32:36 -0700 (PDT)
Message-Id: <pull.1116.git.git.1635201156.gitgitgadget@gmail.com>
From:   "Robert Estelle via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Oct 2021 22:32:34 +0000
Subject: [PATCH 0/2] color: support "default" to restore fg/bg color
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Robert Estelle <robert.estelle@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The name "default" can now be used in foreground or background colors, and
means to use the terminal's default color, discarding any explicitly-set
color without affecting the other attributes. On many modern terminals, this
is not the same as specifying "white" or "black".

Although attributes could previously be cleared like "no-bold", there had
not been a similar mechanism available for colors, other than a full
"reset", which cannot currently be combined with post-reset settings.

Note that this is not the same as the existing name "normal", which is a
no-op placeholder to permit setting the background without changing the
foreground. (i.e. what is currently called "normal" might have been more
descriptively named "inherit", "none", "pass" or similar).

Robert Estelle (2):
  color: add missing GIT_COLOR_* white/black constants
  color: support "default" to restore fg/bg color

 Documentation/config.txt | 18 +++++++++++++-----
 color.c                  | 23 ++++++++++++++++++++++-
 color.h                  | 12 ++++++++++++
 t/t4026-color.sh         | 12 ++++++++++++
 4 files changed, 59 insertions(+), 6 deletions(-)


base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1116%2Frwe%2Fansi-default-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1116/rwe/ansi-default-v1
Pull-Request: https://github.com/git/git/pull/1116
-- 
gitgitgadget
