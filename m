Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABB6ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 14:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiISOhD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 10:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiISOg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 10:36:59 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0012D1D9
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 07:36:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c11so47828237wrp.11
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 07:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=t6/zfeHuxxXHucRjAhOni7a5yHO1ToT1TfPlCqxbZnk=;
        b=mNMhNrF33LTGTdzJhLQhzT3vAOulJ7HXSup6/ECdmH1mkEJZjbvQsXE1ax8IMhI2lJ
         gJGikulM6j97xyJp2+mzD5s+8M9FuNKTK5i8AZXE2xpykhuDwkTliqS9GrCsH+noZeS2
         +wOh7AC2qz+B5pcgRbQcm5FSIlUwHh/kwgF47lhDHIAwQ1qCZvIy/T9blk9MaYRV8LYp
         JgA8MiRBzCUbGHGf1O7Lk1eMeQ4eW3ZdxVfqra8LQvzEa5YZKH0XqtzXIvDBeRjMDnpn
         RlJTgTX2PxnTO+dHolnDiaDTpEj6gZPvwu7YzKvqUkKJvmkoVaCTuOzUnxB84Xc1QQ+T
         c2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=t6/zfeHuxxXHucRjAhOni7a5yHO1ToT1TfPlCqxbZnk=;
        b=paQZ8dAXLvMF9t+tt9hgQlFL0UL1Sc+l4ZoLCu2vS74wIZBvo+LMTqoH1jjHjy0NJ8
         qie/Ia1wk6d5z/McWCCa/k9uer6E/2wAlq3m5trs3GdbPl9xuwc/KF0OfXLwhCOcJkwK
         9w6I6WuGK0/iGa/OEOsW8Kcn68YoNcHGC+lqXx+eURhXM/pLlF3NLqMNJo3GGEw1uG5u
         yh+pIu5CbLX7pGGs8Es2mAp8gXUa89p3JKMnffMCt1hyUqQ8FfqgLmL4Sc3O6MQ1ivaU
         X+atv3HpGngdqhXn2lcBb2geLXBVXv7DsLEYr94PYik5I4cJ+n4xR1LPTNpkBEUneHcp
         zxUw==
X-Gm-Message-State: ACrzQf28iYI27IEQcWgUigpv6f/1VpHylBXiEHco1fD532LebvTNOIjn
        VYPMheqBFSTjsHitn73RjhkumaOFbmo=
X-Google-Smtp-Source: AMsMyM7LGW2HQhnOGcgJ6Hc3qgY0WVKsqFFG0IZ8PkoJEsK/yelYshXVQRe8+uMxtnkdTR4s4kFV4Q==
X-Received: by 2002:a5d:4487:0:b0:22a:e803:927b with SMTP id j7-20020a5d4487000000b0022ae803927bmr7976641wrq.353.1663598216334;
        Mon, 19 Sep 2022 07:36:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y2-20020a5d6142000000b002285f73f11dsm16986001wrt.81.2022.09.19.07.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:36:55 -0700 (PDT)
Message-Id: <pull.1353.v4.git.1663598215154.gitgitgadget@gmail.com>
In-Reply-To: <pull.1353.v3.git.1663542495094.gitgitgadget@gmail.com>
References: <pull.1353.v3.git.1663542495094.gitgitgadget@gmail.com>
From:   "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Sep 2022 14:36:54 +0000
Subject: [PATCH v4] fuzz: reorganise the path for existing oss-fuzz fuzzers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Arthur Chan <arthur.chan@adalogics.com>,
        Arthur Chan <arthur.chan@adalogics.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Arthur Chan <arthur.chan@adalogics.com>

This patch is aimed to provide a better organisation for oss-fuzz
fuzzers and to avoid top-level clustters in the git repository when
more fuzzers are introduced. In addition, grouping the fuzzers into
their own directory separate their application on fuzz-testing from
the core functionalities of the git code. It also provide better
and tidier structure the oss-fuzz fuzzing library to manage, locate,
build and execute those fuzzers for fuzz-testing purposes in future
development.

A new direrctory oss-fuzz has been created and existing fuzzers are
moved into the new directory. Makefile and .gitignore have been
fixed accordingly.

CC: Josh Steadmon <steadmon@google.com>
CC: David Korczynski <david@adalogics.com>
Signed-off-by: Arthur Chan <arthur.chan@adalogics.com>
---
    fuzz: reorganise the path for existing oss-fuzz fuzzers
    
    This patch is aimed to provide a better organisation for oss-fuzz
    fuzzers and to avoid top-level clustters in the git repository when more
    fuzzers are introduced. In addition, grouping the fuzzers into their own
    directory separate their application on fuzz-testing from the core
    functionalities of the git code. It also provide better and tidier
    structure the oss-fuzz fuzzing library to manage, locate, build and
    execute those fuzzers for fuzz-testing purposes in future development.
    
    A new direrctory oss-fuzz has been created and existing fuzzers are
    moved into the new directory. Makefile and .gitignore have been fixed
    accordingly.
    
    Create new .gitignore file for the new directory in v4 and fix the
    commit message.
    
    CC: Josh Steadmon steadmon@google.com CC: David Korczynski
    david@adalogics.com Signed-off-by: Arthur Chan arthur.chan@adalogics.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1353%2Farthurscchan%2Frelocate-fuzzer-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1353/arthurscchan/relocate-fuzzer-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1353

Range-diff vs v3:

 1:  21714e583aa ! 1:  82d9568ea65 fuzz: reorganise the path for existing oss-fuzz fuzzers
     @@ Commit message
          fuzz: reorganise the path for existing oss-fuzz fuzzers
      
          This patch is aimed to provide a better organisation for oss-fuzz
     -    fuzzers, allowing more fuzzers for the git project to be added
     -    in later development.
     +    fuzzers and to avoid top-level clustters in the git repository when
     +    more fuzzers are introduced. In addition, grouping the fuzzers into
     +    their own directory separate their application on fuzz-testing from
     +    the core functionalities of the git code. It also provide better
     +    and tidier structure the oss-fuzz fuzzing library to manage, locate,
     +    build and execute those fuzzers for fuzz-testing purposes in future
     +    development.
      
          A new direrctory oss-fuzz has been created and existing fuzzers are
          moved into the new directory. Makefile and .gitignore have been
     @@ Commit message
       ## .gitignore ##
      @@
      -/fuzz-commit-graph
     -+/oss-fuzz/fuzz-commit-graph
       /fuzz_corpora
      -/fuzz-pack-headers
      -/fuzz-pack-idx
     -+/oss-fuzz/fuzz-pack-headers
     -+/oss-fuzz/fuzz-pack-idx
       /GIT-BUILD-OPTIONS
       /GIT-CFLAGS
       /GIT-LDFLAGS
     @@ Makefile: SCRIPTS = $(SCRIPT_SH_GEN) \
       fuzz-objs: $(FUZZ_OBJS)
       
      
     + ## oss-fuzz/.gitignore (new) ##
     +@@
     ++fuzz-commit-graph
     ++fuzz-pack-headers
     ++fuzz-pack-idx
     +
       ## fuzz-commit-graph.c => oss-fuzz/fuzz-commit-graph.c ##
      
       ## fuzz-pack-headers.c => oss-fuzz/fuzz-pack-headers.c ##


 .gitignore                                          | 3 ---
 Makefile                                            | 6 +++---
 oss-fuzz/.gitignore                                 | 3 +++
 fuzz-commit-graph.c => oss-fuzz/fuzz-commit-graph.c | 0
 fuzz-pack-headers.c => oss-fuzz/fuzz-pack-headers.c | 0
 fuzz-pack-idx.c => oss-fuzz/fuzz-pack-idx.c         | 0
 6 files changed, 6 insertions(+), 6 deletions(-)
 create mode 100644 oss-fuzz/.gitignore
 rename fuzz-commit-graph.c => oss-fuzz/fuzz-commit-graph.c (100%)
 rename fuzz-pack-headers.c => oss-fuzz/fuzz-pack-headers.c (100%)
 rename fuzz-pack-idx.c => oss-fuzz/fuzz-pack-idx.c (100%)

diff --git a/.gitignore b/.gitignore
index 80b530bbed2..ed8b9f04e5c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,7 +1,4 @@
-/fuzz-commit-graph
 /fuzz_corpora
-/fuzz-pack-headers
-/fuzz-pack-idx
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
 
diff --git a/oss-fuzz/.gitignore b/oss-fuzz/.gitignore
new file mode 100644
index 00000000000..9acb74412ef
--- /dev/null
+++ b/oss-fuzz/.gitignore
@@ -0,0 +1,3 @@
+fuzz-commit-graph
+fuzz-pack-headers
+fuzz-pack-idx
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
