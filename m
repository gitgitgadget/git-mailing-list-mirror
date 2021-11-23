Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3611C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 16:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbhKWQcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbhKWQcs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 11:32:48 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE832C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 08:29:39 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l16so2002573wrp.11
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 08:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p0AZtYYcmA9zHCJOuuf99m3eNgUjUnp25nXilSdjD7I=;
        b=Wp4TzSpHkCJCSuZFTlN6fSAJNIN3PK3vrSTUciHdBUymPoMN7gCZlJg0sB4Slr3C4I
         I+J5/r5+Pr+bCTfz6LHv744T40KWxWHw3+yiA6GhDqaHAKGzfksLtnXVlnsvL/9U8S4V
         28nM8Fi0tQSScyqb71q4z3WVguSMmlgB51vNj7VRi8XrSZ+Zae7KSba3f4SBwzV7Jubt
         0PqFOSUx781z7HxKTbPcZGOl85jgcjMHCHq6UR6+5rsfFYmQBov8mQGxjy7mxRHDKH3Y
         44FGaY+in5pc1f/NjtYsQiFnnwNuODwZp252znEs4F5ZysTTiyb4pQ60UlpADnz+1sgl
         cNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p0AZtYYcmA9zHCJOuuf99m3eNgUjUnp25nXilSdjD7I=;
        b=CqOf0Pbn3Tg8UCHeqecNYYMZXO2yPAp0b+zTPls5pWYcx63OB60mGwI6XSeZzcAStI
         J6d5gWLQtwkgkFpVk0WVK+xGVpnNWuySnXCAGJVuv4264up7oBmiZ/k9beuWZ6Fi7W6X
         /qV8wCdTCqMuTS0AKSiHOguRDd+eBc3Ewe+Tdf46auZ0iG4SAgCYROum+exAI3/9fBgO
         V9KSHsWzc7Vad4Jwxtga+wc2YYvNQ23H5pkxpV2oPQmVRmb4OGTxZPbp3nm/rL5+xuT0
         whaSTB7I8vs4E1a6MjBC+zBo1nTDpSxjbcHr7wzCwGIHA6XFJ1CCZ46MLDiiCCAOa6Ky
         966w==
X-Gm-Message-State: AOAM533yLazFJcSNQ/yIvyI7OhdEcSler8fuE0lLSAQOBiJoiGYQCFUV
        BHIW3A5IQaWeq7YKInz2s/l+v4uelR4L7Q==
X-Google-Smtp-Source: ABdhPJwkAphJonTm9SIcUlkSUrRuglBHOe+y5hF66lr5tLxDjE25wmU8l7wzg1dWrBN+YYTud9OvwQ==
X-Received: by 2002:a5d:4ece:: with SMTP id s14mr8457667wrv.371.1637684978238;
        Tue, 23 Nov 2021 08:29:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h22sm2059940wmq.14.2021.11.23.08.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 08:29:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/5] CI: rename the "Linux32" job to lower-case "linux32"
Date:   Tue, 23 Nov 2021 17:29:10 +0100
Message-Id: <patch-v4-3.5-37b97fc6c3a-20211123T134300Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.830.g6387a5d107e
In-Reply-To: <cover-v4-0.5-00000000000-20211123T134300Z-avarab@gmail.com>
References: <cover-v3-0.5-00000000000-20211120T115414Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20211123T134300Z-avarab@gmail.com>
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
2.34.0.830.gb9cdc59c8af

