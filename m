Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2778AECAAD3
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 13:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiIQNL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Sep 2022 09:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIQNLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2022 09:11:25 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFC51A05F
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 06:11:24 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d2so4599783wrq.2
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 06:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=7BqK9BUujyAF5LeaYOToXD0YAy8GPvLI1giFNP7NGes=;
        b=kG0C3+b3lIgC31ZPYKgIwnsG9iy6TCCMEtX4tOK8e2VSZBL65W3FmJubJqE2tAh3uH
         xZA05ChzpzmiFSE39QUwTj66l1rxscR3ugF6zBuXXrLcQf9I+Wag5/lSStlleZTdiXPn
         gUFOqGCkebKsCHZq9Kd3L3pUyr3w8EqdcvcH2/vzJjosYiUoX5z56s5Dr3StFeq+xmDc
         1BBsqXZ9k7/YcafmyXRLSdgDxQnYljURqt4KwXAVEd9XANx4QZWELsYpLmZdHImGiqbB
         UXKDy7/zXY9PlStLp/xJ5KzyeT4yg08sRv2v8u9N+ll8qUOCIfmmq9I06vdEmTFHa6Es
         W5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=7BqK9BUujyAF5LeaYOToXD0YAy8GPvLI1giFNP7NGes=;
        b=NlEHqZtpD5pR3er6Aria85h/ber38U9dPmoGCvr6qA7KFnbWHzb3AoN62ghP8jFaFy
         nZBnVpuLUFexlw5u7/Z7XJFg/s4cQ+M45N/ASHzPD0sW9w4i/db6Wbj41HfRmTTWKMg5
         sNyqTMVL5bo2bmCswu/KxnnY1hP+i79Kf8BqmMBgQGtGqzGgp/zW+NTFg9CV50NvEbbl
         CGfZzhTowGgkEOzSRo0B8Othz2qK9xAn5b5/42NOLqz4ppwUjrGeqc+rjtT4gN8X9J9Y
         9HkkF/9FZ64WKM2ZSxkp0wvXgTiClD9P1sNcVt70AQriSnVUpVh2LdkhXakuwaZPNsMw
         nsoQ==
X-Gm-Message-State: ACrzQf1RLAeGEjSqlpilzx83I28AI/slA5z0liJ4QvTbSX6c9b8afF7u
        VihGQGz4c6AXff53XaZ4GGRbreUF/eg=
X-Google-Smtp-Source: AMsMyM5/D3VFoH/baEnPPLo5uo8uxnDFYjCopeR739fTsO6x6X8FUnt+z9v3zemYQ9gtcNfkelShFQ==
X-Received: by 2002:a5d:6d85:0:b0:226:ffd5:5231 with SMTP id l5-20020a5d6d85000000b00226ffd55231mr5376967wrs.202.1663420282459;
        Sat, 17 Sep 2022 06:11:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o14-20020a056000010e00b002258235bda3sm7665804wrx.61.2022.09.17.06.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 06:11:21 -0700 (PDT)
Message-Id: <pull.1355.git.1663420281187.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Sep 2022 13:11:21 +0000
Subject: [PATCH] scalar: fix wrong shell hashbang
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

$SHELL_PATH_SQ haven't been set in scalar's Makefile,
bin-wrappers/scalar will begin with wrong hashbang "#!",
fix it by setting $SHELL_PATH and $SHELL_PATH_SQ in
scalar's Makefile.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    scalar: fix wrong shell hashbang
    
    The bin-wrappers/scalar seems like missing setting $SHELL_PATH_SQ which
    lead to I can't execute bin-wrappers/scalar correctly, which output
    error:
    
    zsh: exec format error: scalar
    
    (this bug will not turn out in bash)
    
    The bin-wrappers/scalar begin with wrong hashbang "#!", which cannot
    figure out by zsh. So this patch want to fix this problem.
    
    v1: Setting $SHELL_PATH and $SHELL_PATH_SQ in scalar/Makefile.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1355%2Fadlternative%2Fzh%2Fscalar-fix-hashbang-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1355/adlternative/zh/scalar-fix-hashbang-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1355

 contrib/scalar/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
index 37f283f35d7..b2a81d9eb45 100644
--- a/contrib/scalar/Makefile
+++ b/contrib/scalar/Makefile
@@ -8,6 +8,9 @@ include ../../config.mak.uname
 -include ../../config.mak.autogen
 -include ../../config.mak
 
+SHELL_PATH ?= $(SHELL)
+SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
+
 TARGETS = scalar$(X) scalar.o
 GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
 

base-commit: d3fa443f97e3a8d75b51341e2d5bac380b7422df
-- 
gitgitgadget
