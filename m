Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE25FC433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346305AbiDRQdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346203AbiDRQcO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413233055D
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:35 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t1so19146894wra.4
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9xSIsa2nOLFCR9DiRUC/r7g/BHfteuiRb+7J09Q575g=;
        b=QEdXw2slNOAeqHGQUOE665BSVKTnijC8MgdrSmisM8adUqo21+afMLTxqZCupabH/e
         YEJpLF87jA02eyN7Giw3DYsK80cwJNHcDh43bmHQUJjvs9OlIP932wLa30cGp0eADyNn
         N/tNgH8ips9tE1k9Tajf0Aq02HZIBExmOzejpCdzhBvB40WTjjdSUdcf7y5HHrF4sk99
         zES77E2ve4y3Kk6KZw7o6PJP/sB5md6K5YYMntHE6oCpIks1dxZVdHiuIfKEwxhFpvNc
         mlU6KBk6YIGJ/zIPAO1Wk4ks1Fskz54fAk0ctKR+nulplCC/czELYcHjCfHHb7w7Z1as
         MRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9xSIsa2nOLFCR9DiRUC/r7g/BHfteuiRb+7J09Q575g=;
        b=SvPnwWsyZOM12QMXFu27aY9bYtXP/mG2AdvKD4MCuEyFAdrXzsjXXAvUjw1SmZcEr4
         g3JZNAwE/4BPNZ49FM1odQKwGUrqtNREy5G5hXFA9ioXR+xGuwUqLBzoPhOLeSkm+Wfi
         jzw6wLsgEjielu11Bx+Fk1LTuDLDJPx3LNrre+Vh7dGHIMuuGBaYMKFzLxzeBd0yYTj1
         /4UrMXyYux+CNhUMLwQCET6PwOuQD3Mmax8YAkU3Z8yVTMuDkIKe/vdTF3nnAfjxGzhp
         BO/zlE4GbUBVPFJap5kv/HN+a7ASMLoh7mtlQdA3Oq8O6JeSQEXudpaYY7r1BPqhmeYu
         wPNg==
X-Gm-Message-State: AOAM531cHux5CV/6q4R8LKm9lgtqBiQjiYAH8dq2aed4V34P0RS3V07X
        1MPwaXQFtEd5A71FFMBQyLNew9fmpgeqlw==
X-Google-Smtp-Source: ABdhPJw10KxfYkdIyFJigTglLp2FTk9wwL6DaWCXks8yTp1Wy1INXjEdrKHsyCmXxyCPb4HjXkxylg==
X-Received: by 2002:a5d:468b:0:b0:207:a1c9:391c with SMTP id u11-20020a5d468b000000b00207a1c9391cmr8983345wrq.331.1650299373513;
        Mon, 18 Apr 2022 09:29:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 22/31] CI: pre-select test slice in Windows & VS tests
Date:   Mon, 18 Apr 2022 18:28:59 +0200
Message-Id: <patch-v4-22.31-f257ab59971-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preceding commits the tests have been changed to do their setup via
$GITHUB_ENV in one step, and to then have subsequent steps that re-use
that environment.

Let's change the "test slice" tests added in b819f1d2cec (ci:
parallelize testing on Windows, 2019-01-29) to do the same. These
tests select 10% of the tests to run in 10 "test slices". Now we'll
select those in a step that immediately precedes the testing step, and
then simply invoke "make -C t -e".

This has the advantage that the tests to be run are now listed in the
standard "Run" drop-down at the start of the "test" step.

Since the "T" variable in "t/Makefile" doesn't normally accept
overrides from the environment we need to invoke "make" with the "-e"
option (a.k.a. "--environment-overrides"). We could also make $(T) in
t/Makefile be a "?=" assigned variable, but this way works, and is
arguably clearer as it's more obvious that we're injecting a special
list of tests that override the normal behavior of that Makefile.

Note that we cannot run the top-level "make test" here, because of how
the Windows CI builds git, i.e. either via CMake or some option that
would cause "make test" to recompile git itself. Instead we run "make
-C t [...]".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml                     | 10 ++++++++--
 ci/{run-test-slice.sh => select-test-slice.sh} |  4 ++--
 2 files changed, 10 insertions(+), 4 deletions(-)
 rename ci/{run-test-slice.sh => select-test-slice.sh} (57%)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index fe37e0f1b36..1e13718b989 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -124,9 +124,12 @@ jobs:
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - run: ci/lib.sh
       shell: bash
+    - name: select tests
+      run: . /etc/profile && ci/select-test-slice.sh ${{matrix.nr}} 10
+      shell: bash
     - name: test
       shell: bash
-      run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
+      run: . /etc/profile && make -C t -e
     - name: ci/print-test-failures.sh
       if: failure()
       shell: bash
@@ -210,9 +213,12 @@ jobs:
       run: tar xf artifacts.tar.gz && tar xf tracked.tar.gz
     - run: ci/lib.sh
       shell: bash
+    - name: select tests
+      run: . /etc/profile && ci/select-test-slice.sh ${{matrix.nr}} 10
+      shell: bash
     - name: test
       shell: bash
-      run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
+      run: . /etc/profile && make -C t -e
     - name: ci/print-test-failures.sh
       if: failure()
       shell: bash
diff --git a/ci/run-test-slice.sh b/ci/select-test-slice.sh
similarity index 57%
rename from ci/run-test-slice.sh
rename to ci/select-test-slice.sh
index 1de6a18ca47..ec602f8a053 100755
--- a/ci/run-test-slice.sh
+++ b/ci/select-test-slice.sh
@@ -1,10 +1,10 @@
 #!/bin/sh
 #
-# Test Git in parallel
+# Select a portion of the tests for testing Git in parallel
 #
 
 . ${0%/*}/lib.sh
 
 tests=$(echo $(cd t && ./helper/test-tool path-utils slice-tests "$1" "$2" \
 	t[0-9]*.sh))
-make --quiet -C t T="$tests"
+echo T="$tests" >>$GITHUB_ENV
-- 
2.36.0.rc2.898.gdf6bbac50ff

