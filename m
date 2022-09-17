Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8285ECAAA1
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 23:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiIQX2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Sep 2022 19:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIQX2f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2022 19:28:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7CC275E5
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 16:28:34 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id e18so12127757wmq.3
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 16:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=Z3nmJlg39ANgxALe4aOKDGA/37ioKc5g3nNhlJ07U9w=;
        b=L+BTtOKgY7biYeGUAchTWB6WjfEmTsvxq/+ip99r+4S9cu5n1XW6VphwjvsIZbyuZU
         Pz/qHHcOZ47OoZMGNBDsfLxQFFLz+JmZ0lCkoxOyNaiqZxb16KE1zil3B9pnc9y0w4rU
         FXhE1OTgPyAB7lLl3cQmjtUYF/q1PJd3Hk/jUzZBtIBDEs0lhZouflWtXv1BqbayIhQJ
         zXvKAcuD8ryUvs1LrHxsOIs2DaO8IyFc60h4nvwq59agCAkxoPTLctiErQkuIFLVgr72
         ClIuK9wLh7BEVOpDAC7FpBjhljzOBb036EOaPl1Vw/VdK78aCB+Y47z0LFcpOb/aoF2e
         d7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Z3nmJlg39ANgxALe4aOKDGA/37ioKc5g3nNhlJ07U9w=;
        b=Qzc8FS08ABfo3oMexM9IdQE///974IceIkcidccnqewuMkX55/esXO/LnX0jmkG1pL
         E3B/wGd1wE9vQudty8gvonjJSZLXvPba52KJvsS03s0lsgbRN/G/zPOjqW2SzebXHgI7
         N/sFnHPdfwMorkmO5v1uZKikdoAXb87Jt2XqWEP7PiYuY+VxxgEMsa7vutoS/p1IK1FB
         TQxrI7xeYzPrbYtaR1ScENmri+9ZIblX7ieFn/9suzJy8rL0ATGkeYoObL496mEKj1Op
         rHw2BpGvMQx9Y+5NtCXKfv8NSYyL081iU4lf95cDOsvtxxifILA7Y6dLQW5L6hsA5xVX
         fXLQ==
X-Gm-Message-State: ACgBeo3zfaS2Df/TvsoZc6Np/X51tsH73RNFQf2JiH4kTb6C41/y6wfu
        mw/jIl4Pmu5D/BF4+jEsp7hlotlpTDI=
X-Google-Smtp-Source: AA6agR4sy8NUiNW7opc7uyHFjcu8v4QRKV91sQfZwBkE9vXgCFVVEXBgdLzxlLFQF5ZHNB19nGDiDg==
X-Received: by 2002:a05:600c:1e13:b0:3b4:74c3:620b with SMTP id ay19-20020a05600c1e1300b003b474c3620bmr15019124wmb.168.1663457312751;
        Sat, 17 Sep 2022 16:28:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16-20020a5d6e90000000b0022ac38fb20asm9008868wrz.111.2022.09.17.16.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 16:28:32 -0700 (PDT)
Message-Id: <pull.1353.v2.git.1663457311149.gitgitgadget@gmail.com>
In-Reply-To: <pull.1353.git.1663355009333.gitgitgadget@gmail.com>
References: <pull.1353.git.1663355009333.gitgitgadget@gmail.com>
From:   "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Sep 2022 23:28:30 +0000
Subject: [PATCH v2] fuzz: reorganise the path for existing oss-fuzz fuzzers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Arthur Chan <arthur.chan@adalogics.com>,
        Arthur Chan <arthur.chan@adalogics.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Arthur Chan <arthur.chan@adalogics.com>

This patch is aimed to provide a better organisation for oss-fuzz
fuzzers, allowing more fuzzers for the git project to be added
in later development.

A new direrctory oss-fuzz has been created and existing fuzzers are
moved into the new directory. Makefile and .gitignore have been
fixed accordingly.

CC: Josh Steadmon <steadmon@google.com>
CC: David Korczynski <david@adalogics.com>
Signed-off-by: Arthur Chan <arthur.chan@adalogics.com>
---
    fuzz: reorganise the path for existing oss-fuzz fuzzers
    
    This patch is aimed to provide a better organisation for oss-fuzz
    fuzzers, allowing more fuzzers for the git project to be added in later
    development.
    
    A new directory oss-fuzz has been created and existing fuzzers are moved
    into the new directory. Makefile and .gitignore have been fixed
    accordingly.
    
    CC: Josh Steadmon steadmon@google.com CC: David Korczynski
    david@adalogics.com Signed-off-by: Arthur Chan arthur.chan@adalogics.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1353%2Farthurscchan%2Frelocate-fuzzer-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1353/arthurscchan/relocate-fuzzer-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1353

Range-diff vs v1:

 1:  1cc90522b7b ! 1:  c056429897a fuzz: reorganise the path for existing oss-fuzz fuzzers
     @@ Commit message
      
          This patch is aimed to provide a better organisation for oss-fuzz
          fuzzers, allowing more fuzzers for the git project to be added
     -    in a later development.
     +    in later development.
      
     -    A new folder oss-fuzz has been created and existing fuzzers are
     -    moved into the new folders. Makefile has been fixed accordingly.
     +    A new direrctory oss-fuzz has been created and existing fuzzers are
     +    moved into the new directory. Makefile and .gitignore have been
     +    fixed accordingly.
      
          CC: Josh Steadmon <steadmon@google.com>
          CC: David Korczynski <david@adalogics.com>
          Signed-off-by: Arthur Chan <arthur.chan@adalogics.com>
      
     + ## .gitignore ##
     +@@
     +-/fuzz-commit-graph
     +-/fuzz_corpora
     +-/fuzz-pack-headers
     ++/oss-fuzz/fuzz-commit-graph
     ++/oss-fuzz/fuzz_corpora
     ++/oss-fuzz/fuzz-pack-headers
     + /fuzz-pack-idx
     + /GIT-BUILD-OPTIONS
     + /GIT-CFLAGS
     +
       ## Makefile ##
      @@ Makefile: SCRIPTS = $(SCRIPT_SH_GEN) \
       


 .gitignore                                          | 6 +++---
 Makefile                                            | 6 +++---
 fuzz-commit-graph.c => oss-fuzz/fuzz-commit-graph.c | 0
 fuzz-pack-headers.c => oss-fuzz/fuzz-pack-headers.c | 0
 fuzz-pack-idx.c => oss-fuzz/fuzz-pack-idx.c         | 0
 5 files changed, 6 insertions(+), 6 deletions(-)
 rename fuzz-commit-graph.c => oss-fuzz/fuzz-commit-graph.c (100%)
 rename fuzz-pack-headers.c => oss-fuzz/fuzz-pack-headers.c (100%)
 rename fuzz-pack-idx.c => oss-fuzz/fuzz-pack-idx.c (100%)

diff --git a/.gitignore b/.gitignore
index 80b530bbed2..9e810c07ba9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,6 +1,6 @@
-/fuzz-commit-graph
-/fuzz_corpora
-/fuzz-pack-headers
+/oss-fuzz/fuzz-commit-graph
+/oss-fuzz/fuzz_corpora
+/oss-fuzz/fuzz-pack-headers
 /fuzz-pack-idx
 /GIT-BUILD-OPTIONS
 /GIT-CFLAGS
diff --git a/Makefile b/Makefile
index d9247ead45b..2d56aae7a1d 100644
--- a/Makefile
+++ b/Makefile
@@ -686,9 +686,9 @@ SCRIPTS = $(SCRIPT_SH_GEN) \
 
 ETAGS_TARGET = TAGS
 
-FUZZ_OBJS += fuzz-commit-graph.o
-FUZZ_OBJS += fuzz-pack-headers.o
-FUZZ_OBJS += fuzz-pack-idx.o
+FUZZ_OBJS += oss-fuzz/fuzz-commit-graph.o
+FUZZ_OBJS += oss-fuzz/fuzz-pack-headers.o
+FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o
 .PHONY: fuzz-objs
 fuzz-objs: $(FUZZ_OBJS)
 
diff --git a/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
similarity index 100%
rename from fuzz-commit-graph.c
rename to oss-fuzz/fuzz-commit-graph.c
diff --git a/fuzz-pack-headers.c b/oss-fuzz/fuzz-pack-headers.c
similarity index 100%
rename from fuzz-pack-headers.c
rename to oss-fuzz/fuzz-pack-headers.c
diff --git a/fuzz-pack-idx.c b/oss-fuzz/fuzz-pack-idx.c
similarity index 100%
rename from fuzz-pack-idx.c
rename to oss-fuzz/fuzz-pack-idx.c

base-commit: d3fa443f97e3a8d75b51341e2d5bac380b7422df
-- 
gitgitgadget
