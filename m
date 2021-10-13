Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2A4C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 12:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 031CA61056
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 12:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbhJMM5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 08:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbhJMM5y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 08:57:54 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71060C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 05:55:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r7so8052920wrc.10
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 05:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=98zMHlntEiraQ1UYv64U6YoBrZMgVKuxIXq6NpcICsU=;
        b=PgBXg8ocbvm/fo6OlUeWaN3v52zgaLySyGimuQRSBMHwoE2oJsVaXiQIR5m+PE8p7R
         5o59Rw/5MyIenGfU2h/PsmQpHhzuZGnoh9K84p4AbgRuF+InEYVgvwzH4OYvQsPwScnI
         E4kDHErgrSDasF33gOzCzCaFfsjTlvCgvJH5teM0bo5koh29kkVwnyHNA0FJLjNhjtIU
         i0l12/nUSCuTOJuvCgcKDvTGkCVF+FsxqKlQ3/xwsSYP8abuBDhxhSr5ZWsnEVKDKUmc
         KEcd93ZEZOSOgEAmCl/r9Tfb9f7vLv+bq6s44Ut6J+NgxDPxM6mk6lGM3G1I3Lc4w5bK
         /iCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=98zMHlntEiraQ1UYv64U6YoBrZMgVKuxIXq6NpcICsU=;
        b=5BYDlP5h4pJCkdFT0MDJr/yGWpDhBQd9K+n1IZNIF293aOeDQoKhCsgviFzr3SEQUK
         S9JXsI/6mjRPCV6W7QujGOdVc0drW36l0Z1h+a65G8pSERoUbwio1qSP4/AaeLfSAjFx
         hcpvNEfHlqnNYE4fKpQ0Lm75g0BX9fyrXkeFN5mHRQezZoPNyazyiPpgE4QY1xlPpQ9Y
         n3qMz5x4A97ZJbE3DDM+79MEpq+hMr8nX1Iw/2vQ6dXSlIte1JEeEwisqrc+yhXc570U
         VvaEq+57M2ipQh+n6fznH58BasjiCocMdhz60FrIAGH7CHjjhAeHn9yfkny22lmzJFh5
         q4Cg==
X-Gm-Message-State: AOAM531kDjZDKuPCHMBPNv7rR0UBZPzsAkDfJouOR/q4Vur3ibTYvWDc
        Gc5xp+MLjhzJW0NXkb0EX9d+9kErVEA=
X-Google-Smtp-Source: ABdhPJy63g9fkg05r11kmywI2wpk6umu5sr/HvRpoP5kHyZg2FiMHp2l5EXKxu517S70MffMNPb3Yg==
X-Received: by 2002:a5d:5589:: with SMTP id i9mr23133125wrv.55.1634129750021;
        Wed, 13 Oct 2021 05:55:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n66sm5410850wmn.2.2021.10.13.05.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 05:55:49 -0700 (PDT)
Message-Id: <pull.1057.git.1634129748874.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Oct 2021 12:55:48 +0000
Subject: [PATCH] ci(windows): ensure that we do not pick up random executables
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On the Windows build agents, a lot of programs are installed, and added
to the PATH automatically.

One such program is Git for Windows, and due to the way it is set up,
unfortunately its copy of `gpg.exe` is also reachable via the PATH.

This usually does not pose any problems. To the contrary, it even allows
us to test the GPG parts of Git's test suite even if `gpg.exe` is not
delivered as part of `git-sdk-64-minimal`, the minimal subset of Git for
Windows' SDK that we use in the CI builds to compile Git.

However, every once in a while we build a new MSYS2 runtime, which means
that there is a mismatch between the copy in `git-sdk-64-minimal` and
the copy in C:\Program Files\Git\usr\bin. When that happens we hit the
dreaded problem where only one `msys-2.0.dll` is expected to be in the
PATH, and things start to fail.

Let's avoid all of this by restricting the PATH to the minimal set. This
is actually done by `git-sdk-64-minimal`'s `/etc/profile`, and we just
have to source this file manually (one would expect that it is sourced
automatically, but the Bash steps in Azure Pipelines/GitHub workflows
are explicitly run using `--noprofile`, hence the need for doing this
explicitly).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci(windows): avoid using external gpg by mistake
    
    I stumbled over a CI failure this morning when I scrambled to tie up all
    the loose ends for an unexpected v2.33.1 release. Turns out that the CI
    picked up the installed Git for Windows' gpg.exe, and due to a (new, as
    of this morning) mismatch in the MSYS2 runtime between the installed Git
    for Windows and the subset of the Git for Windows SDK used for compiling
    in the CI runs, it worked just enough to pass the prereq, but then
    failed the tests.
    
    Seeing as essentially every single CI build will fail without this patch
    right up until the point in time when Git for Windows is upgraded in the
    build agents (to a version that does yet exist), it would be good to
    fast-track this to maint.
    
    Note: I based this on the earliest topic where it would apply without
    merge conflicts, js/ci-windows-update (which is unfortunately quite
    recent, it is not reachable from any version older than v2.33.0).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1057%2Fdscho%2Fwork-around-windows-ci-failures-with-gpg-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1057/dscho/work-around-windows-ci-failures-with-gpg-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1057

 .github/workflows/main.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 0f7516c9ef3..2a6d68718ae 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -88,7 +88,7 @@ jobs:
       env:
         HOME: ${{runner.workspace}}
         NO_PERL: 1
-      run: ci/make-test-artifacts.sh artifacts
+      run: . /etc/profile && ci/make-test-artifacts.sh artifacts
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
@@ -115,7 +115,7 @@ jobs:
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: test
       shell: bash
-      run: ci/run-test-slice.sh ${{matrix.nr}} 10
+      run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
     - name: ci/print-test-failures.sh
       if: failure()
       shell: bash
@@ -199,7 +199,7 @@ jobs:
       env:
         NO_SVN_TESTS: 1
         GIT_TEST_SKIP_REBASE_P: 1
-      run: ci/run-test-slice.sh ${{matrix.nr}} 10
+      run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
     - name: ci/print-test-failures.sh
       if: failure()
       shell: bash

base-commit: d681d0dc3a77016caa7e26abfe734afbdab44de5
-- 
gitgitgadget
