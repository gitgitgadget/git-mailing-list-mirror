Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CB9C4332F
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 12:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbhKTMN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 07:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbhKTMNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 07:13:25 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5A8C061574
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 04:10:22 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so4683275wmj.5
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 04:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DLBTr19r7VpVp+uPl7yL3AwKr0D0zwR/ioGlEDnWNNs=;
        b=eOWDK/SQBj/CrwfhqXSO5ki8dhiZwthYhjUshuUSdFUn6U3keDMrTirkux1KTvmc64
         1fpi7nfH9igImtgZ/4Hi2faZFM8NxIRPHrpCX9dL5LfA6owjGDNgghChV4lb2CYS8ID/
         9DRu3p3NRBXS9srYUXiwzWcT9lg/OsuAmV+OS16bvSWpQltWuqnSZzS7ofZceQ3pJl1o
         p3Kl9fuXeBhaLreXoD81EdRjp7OVMSBuzFSEdVIwyYIhGKK2fMTO+fr8jAOS+/ihQay/
         UbbWwEpTAncLxPDPfokhLWjZgjdiiEHT+Z4Msx2h3H8Eknt7VToK1SpoFlsQfjZkLDtf
         5Vkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DLBTr19r7VpVp+uPl7yL3AwKr0D0zwR/ioGlEDnWNNs=;
        b=SepthFfJGZcaxW15zLz18NLR3yrg3twZUCsoveu8xLvUoCHESzqgj4BJ30grIpRy52
         SwKmad1+iDUtP+fQ2BCrBdgCIkNaq5bmMaLm2+i7PPYXqqM2tUeyUAzjezocWaQo/vQt
         Vy8cL9IXaQpC+Et2K6FRec0BcxzymijK04Shcn7KlrdoicdbzJXyCc3Lyea30iluDDuS
         VvjA3aG247oMUq0L4cUDMQbSx+avPCNRjf9oTKAugnPxsvboXq75K24Vaqp1OYaTIVJn
         5kI27+kLYsdtang0bN6mxkPBP6QUV/bfSbVi+TtI4TblF5MJg6CAzrwnkZv+XryBuduX
         qjHw==
X-Gm-Message-State: AOAM532hLgxaFVCipfmUT02RSp4IUUCVC4ofDNqt9qlYP0y8VWllmNX8
        pVvd9uatd6KrnedakT0oXSF8OSF5dCE74tue
X-Google-Smtp-Source: ABdhPJymLane1ZIhLH4z60Rt4Q8Z1D0hAeE712dtwbEGOIPHrhx5NmBlRDJhQ0R4O7S3eWai0rvTow==
X-Received: by 2002:a1c:9a16:: with SMTP id c22mr9533478wme.160.1637410220218;
        Sat, 20 Nov 2021 04:10:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m36sm3128221wms.25.2021.11.20.04.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 04:10:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/5] CI: rename the "Linux32" job to lower-case "linux32"
Date:   Sat, 20 Nov 2021 13:10:09 +0100
Message-Id: <patch-v3-3.5-fb1b0ecbadd-20211120T115414Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.818.g0f23a581583
In-Reply-To: <cover-v3-0.5-00000000000-20211120T115414Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com> <cover-v3-0.5-00000000000-20211120T115414Z-avarab@gmail.com>
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
index c7c10456572..91b565f75bb 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -266,7 +266,8 @@ jobs:
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
2.34.0.818.g0f23a581583

