Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496E1ECAAD8
	for <git@archiver.kernel.org>; Sun, 18 Sep 2022 23:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiIRXIX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Sep 2022 19:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiIRXIW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2022 19:08:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8339A13E88
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 16:08:18 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id g3so23927935wrq.13
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 16:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=Wo+QroY1rufYL6sk89R5jqle/u5sS6IdYinUbF9cwA0=;
        b=Kuz2iuWngyVr1bXI28yUwuEhEhhD4QctdXNf51K/ifqXJRv4BZFixuDP4rwhKyD4iX
         PBFPh/5Fy8A23bj5iHWzJkZIpN2hNF5HTyU0V49ok4vIuHeF0v3rCBgUWNXeYKl//1Sf
         OfoZ77cyvu7RIjMhyN5tj7G/rVzgF3UglWlz3o/D/ggW6sS4PzWQCT2B4hDizjo2xPfJ
         G/4pLOulvJA+FQKcrq051KWYuki5qeE7F/OBU06evDYF4OOuvp22shAlUHmFf6CMEhRP
         S/Xh4wvv652UqejwGYfrCY79tjrkYf6UHc6hQX2GOmutj9SG+/qCN2NQhYlvEvtBqOwI
         5eeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Wo+QroY1rufYL6sk89R5jqle/u5sS6IdYinUbF9cwA0=;
        b=3/CVWK7jX+ylSJWRoD0LWqDLGxFh0SePLzYvwx0Z+LiVKHWWzjRfBqpUwHe34+NqGu
         eWiVcCOTjMohzQlLCtSAceU6F4ccfmUmPVMawKDVSXKBmEn6vFNKfz5ssvT6jcOzE5/m
         8nIZcZG3qJmYvf2B0Dfip8l/k94o9VRcVSXEefNVsG3AxkHZBcnAlZMp9l1RuPNndzzr
         KqLdHOJrPiQkRghZyINmDnhNoFWXuG01WUvlB9VlHL/K9IZ1DOl1OlswvAs2QefnCA+g
         iIsGbJfATUQFcgsQG5kWrYeI/fCkrvlUcxX7/Wx31fppTbh0nxTWmlOeFwmEY+T4yl+x
         dEpQ==
X-Gm-Message-State: ACrzQf2e3YH3Bg9tc8xCS2y97P0wXMjsJYKNz4Iz+yEQWa+yDIo4VUfn
        Qu6T9xfDF64SyLTHuIZgPJyfa5x+03c=
X-Google-Smtp-Source: AMsMyM4RE9lJv7PhpFlHXArbXxQWnb51m2kj9vq3so41xxrAM3gAXOIf9r7tlgKrCAuXaNKVOoWwpQ==
X-Received: by 2002:a05:6000:1251:b0:22a:e60f:c080 with SMTP id j17-20020a056000125100b0022ae60fc080mr5730433wrx.95.1663542496640;
        Sun, 18 Sep 2022 16:08:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9-20020adfcc89000000b0022af70874a1sm4730788wrj.36.2022.09.18.16.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 16:08:15 -0700 (PDT)
Message-Id: <pull.1353.v3.git.1663542495094.gitgitgadget@gmail.com>
In-Reply-To: <pull.1353.v2.git.1663457311149.gitgitgadget@gmail.com>
References: <pull.1353.v2.git.1663457311149.gitgitgadget@gmail.com>
From:   "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 18 Sep 2022 23:08:14 +0000
Subject: [PATCH v3] fuzz: reorganise the path for existing oss-fuzz fuzzers
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
    
    Fix wrong push for v2
    
    CC: Josh Steadmon steadmon@google.com CC: David Korczynski
    david@adalogics.com Signed-off-by: Arthur Chan arthur.chan@adalogics.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1353%2Farthurscchan%2Frelocate-fuzzer-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1353/arthurscchan/relocate-fuzzer-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1353

Range-diff vs v2:

 1:  c056429897a ! 1:  21714e583aa fuzz: reorganise the path for existing oss-fuzz fuzzers
     @@ Commit message
       ## .gitignore ##
      @@
      -/fuzz-commit-graph
     --/fuzz_corpora
     --/fuzz-pack-headers
      +/oss-fuzz/fuzz-commit-graph
     -+/oss-fuzz/fuzz_corpora
     + /fuzz_corpora
     +-/fuzz-pack-headers
     +-/fuzz-pack-idx
      +/oss-fuzz/fuzz-pack-headers
     - /fuzz-pack-idx
     ++/oss-fuzz/fuzz-pack-idx
       /GIT-BUILD-OPTIONS
       /GIT-CFLAGS
     + /GIT-LDFLAGS
      
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
index 80b530bbed2..d11fa8297d2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,7 +1,7 @@
-/fuzz-commit-graph
+/oss-fuzz/fuzz-commit-graph
 /fuzz_corpora
-/fuzz-pack-headers
-/fuzz-pack-idx
+/oss-fuzz/fuzz-pack-headers
+/oss-fuzz/fuzz-pack-idx
 /GIT-BUILD-OPTIONS
 /GIT-CFLAGS
 /GIT-LDFLAGS
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
