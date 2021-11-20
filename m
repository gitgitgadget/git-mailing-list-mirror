Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B958C433EF
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 03:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbhKTDbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 22:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbhKTDbt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 22:31:49 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25F7C06173E
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 19:28:46 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t30so21324831wra.10
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 19:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y08Sh5nA95/ypazWZ5tm3JzUCINC5MvgyGoZGe1HicI=;
        b=LP6nI4HfXQTq9ROb5FhlGzRbzB2zF/bhKyGvX0Ck2iF8zjGYop3lbQROzc9OiIGjFn
         YP9pbxdMe77jgS+HjPKhmJHT8U4/LPN4Xx9I0mTTV+2O6cyhzRHa+P16dOBSzh03CL3v
         hdQoyIT+NhqkbdNyKCP3/ScQzi6VyeVqf+NTyN2u1NbdM7r4iA6BJ1Vdr6aZ2rliPHZg
         2O2CVZ+SJjKZNWO1rV/cFsip2Of0hWdTZUix4isifOISjIMCeT8Duu7N90e9piVGUO4k
         m4ozVcYMRr8XiG+EAmiKZYsR9rj86oTMQ+SlTR1XchoJG6YW/xvDrM9+caiS8HItdxDn
         NPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y08Sh5nA95/ypazWZ5tm3JzUCINC5MvgyGoZGe1HicI=;
        b=AnA1Sq3gAxsf/MDmg/m19nq4oB9fsXXryLWwVAugJhG81ySgEUSvCiOfCKb8tXIKcg
         1pzMpw2LavQ39m2YRw9SYn9SSUpmObmObJEA2ow5sboeAhX8yGR0UZs9vnhDS2BJ64s6
         zr00TatYBJEmaRfkZYTlAjCvrKX8m7SYl03+lHPZnpfCKUrAewihTARqSODWyhi2u851
         KYrsVjqz2KT+3zDZRH81viU5Em5kHVUvyYeFiJKbRvKQcSYfXtISoxBuCCCJ89fEUD0l
         Pv8QhLgxXfGejQFp9R8b+7lqTsH8v500PdKdf5P1N2gqB1epku+sr4wD587LbH9wQgdn
         6vDQ==
X-Gm-Message-State: AOAM531VjN7+1UMoc0e6DU2amVIOBjhsuHBa+25AGrcMqLSd887+E1NF
        PPoEa8djd6UjQ8kfm2FqavbUNZq/o5un0A==
X-Google-Smtp-Source: ABdhPJxNzXmLfTyCZu59+pYBHQH41SmchR7S+fv1slaFJg139DuVchy7RvbqX0tuo4zyXKa73hC+tQ==
X-Received: by 2002:adf:d852:: with SMTP id k18mr13062480wrl.391.1637378925240;
        Fri, 19 Nov 2021 19:28:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12sm1560623wmq.12.2021.11.19.19.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 19:28:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/6] CI: rename the "Linux32" job to lower-case "linux32"
Date:   Sat, 20 Nov 2021 04:28:33 +0100
Message-Id: <patch-v2-3.6-002c183fff4-20211120T030848Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.823.gcc3243ae16c
In-Reply-To: <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a follow-up to the preceding commit's shortening of CI job names,
rename the only job that starts with an upper-case letter to be
consistent with the rest. It was added in 88dedd5e72c (Travis: also
test on 32-bit Linux, 2017-03-05).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml        | 3 ++-
 ci/install-docker-dependencies.sh | 2 +-
 ci/lib.sh                         | 2 +-
 ci/run-docker-build.sh            | 2 +-
 ci/run-docker.sh                  | 2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 612b475fd0b..a91edec46d8 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -272,7 +272,8 @@ jobs:
         vector:
         - jobname: linux-musl
           image: alpine
-        - jobname: Linux32
+        - jobname: linux32
+          os: ubuntu32
           image: daald/ubuntu32:xenial
         - jobname: pedantic
           image: fedora
diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependencies.sh
index 07a8c6b199d..78b7e326da6 100755
--- a/ci/install-docker-dependencies.sh
+++ b/ci/install-docker-dependencies.sh
@@ -4,7 +4,7 @@
 #
 
 case "$jobname" in
-Linux32)
+linux32)
 	linux32 --32bit i386 sh -c '
 		apt update >/dev/null &&
 		apt install -y build-essential libcurl4-openssl-dev \
diff --git a/ci/lib.sh b/ci/lib.sh
index 73d959e87f7..0b3b0144882 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -191,7 +191,7 @@ osx-clang|osx-gcc)
 	;;
 linux-gcc-default)
 	;;
-Linux32)
+linux32)
 	CC=gcc
 	;;
 linux-musl)
diff --git a/ci/run-docker-build.sh b/ci/run-docker-build.sh
index 5d2764ad3a3..6cd832efb9c 100755
--- a/ci/run-docker-build.sh
+++ b/ci/run-docker-build.sh
@@ -15,7 +15,7 @@ then
 fi
 
 case "$jobname" in
-Linux32)
+linux32)
 	switch_cmd="linux32 --32bit i386"
 	;;
 linux-musl)
diff --git a/ci/run-docker.sh b/ci/run-docker.sh
index b610dd4db84..af89d1624a4 100755
--- a/ci/run-docker.sh
+++ b/ci/run-docker.sh
@@ -6,7 +6,7 @@
 . ${0%/*}/lib.sh
 
 case "$jobname" in
-Linux32)
+linux32)
 	CI_CONTAINER="daald/ubuntu32:xenial"
 	;;
 linux-musl)
-- 
2.34.0.823.gcc3243ae16c

