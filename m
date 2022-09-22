Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA276C54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 16:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiIVQ7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 12:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiIVQ7m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 12:59:42 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0714811C11
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 09:59:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bq9so16556369wrb.4
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 09:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=6BrPt06sAu07VGC+0aVF6r+WRpdsi+kZQUBR422BF5w=;
        b=Fm5zA8gHXv3gwSdEedQgbxV44Paqq8h6lFbcpJ8tiV49zlH0UhfqtT901f4uunkqh0
         mS5PXgnbPsKW1ao5PbI9G/j8d4btizeWZNWuEJhthxT3P4ixR/xAiVJwZRHl6Lx34LnP
         +VMLSnYH1H9IS9uiSp3GzSTKk1CHEcpfH4GchGbjW7r/Yv5Nz0t++Uuyq9BHdni06k09
         X/2NQYDypNx+r6qx88A5WvcuFLjlscxvnkAThDyDf1qClq+vyMwSEP/lm0Pm9wR5cV6s
         h2iZXU0ckNqbfjoRm2miQFFQSYGCZNRtboH6btuzpi7sNU94iJdMXyfNzJOiYf3sFW+2
         cpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=6BrPt06sAu07VGC+0aVF6r+WRpdsi+kZQUBR422BF5w=;
        b=2FFG5g9/uccHJQ0qke1Zi637ye5cUfMm/WtFYEEFqikXSxN83rB44zIhbo2/Zsodqe
         Hb8HUHJvrgSsqJ9z7o+DpV3JOJFY2PIPjmskVh5n8Qr4jEVqKWaWheug8qW7drcrEY/E
         mYiv/KDWj3WtU032FjyM9VRUSmGj2uae45GrZVlR5oOEXh9kSjYGVJkR2unkS2L9h1aM
         K0xCi9wyp+Tl+mhuxs6buO9Dm3LdaerPXqMqymdLokkDVtpSv0lp1T72pHLOjdum5VS5
         jiUZgB9Sb5uPmBoaE7hLcxd8xY5SA1Y6XzwFr6SGBUmwkV5AXrx8c8We1NoqM85OeARx
         n4Mw==
X-Gm-Message-State: ACrzQf2WDrNm9B1IfcTBLjXXZlzM2aZyF57AzD8AAGl4hA8cI2N9rTy4
        OZTITLCo6DWGsC3ITRk1QnUVPK/Z4y8=
X-Google-Smtp-Source: AMsMyM5jZmpTLCUSf4xAPCM5eVYT0iW1sMe7p7Gi2unM5eKpBuZzs2kzX8TDpJMI5HDrGw/ORoA5qQ==
X-Received: by 2002:a05:6000:81e:b0:228:a17f:92f0 with SMTP id bt30-20020a056000081e00b00228a17f92f0mr2765552wrb.31.1663865977056;
        Thu, 22 Sep 2022 09:59:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11-20020adfe34b000000b002252ec781f7sm5515486wrj.8.2022.09.22.09.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 09:59:35 -0700 (PDT)
Message-Id: <pull.1363.git.1663865974.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Sep 2022 16:59:31 +0000
Subject: [PATCH 0/3] Correct credential helper discrepancies handling input
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, mjcheetham@outlook.com,
        Matthew John Cheetham <mjcheetham@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whilst working in the credential helper and auth space I happened to notice
that the behaviour of some of the credential helpers in contrib/credential/
is not consistent.

Specifically both the git-credential-wincred and git-credential-netrc
helpers die when they receive unknown credential property keys, which is
contrary to the behaviour of all the other in-tree helpers including:
git-credential-cache, -store, -libsecret, -gnome-keyring, -osxkeychain.

Also update the git-credential-osxkeychain helper to include a comment
making it's behaviour explicit in ignoring unknown keys, as per other
helpers.

Matthew John Cheetham (3):
  wincred: ignore unknown lines (do not die)
  netrc: ignore unknown lines (do not die)
  osxkeychain: clarify that we ignore unknown lines

 contrib/credential/netrc/git-credential-netrc.perl         | 5 ++++-
 .../credential/osxkeychain/git-credential-osxkeychain.c    | 5 +++++
 contrib/credential/wincred/git-credential-wincred.c        | 7 +++++--
 3 files changed, 14 insertions(+), 3 deletions(-)


base-commit: dd3f6c4cae7e3b15ce984dce8593ff7569650e24
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1363%2Fmjcheetham%2Fcredhelper-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1363/mjcheetham/credhelper-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1363
-- 
gitgitgadget
