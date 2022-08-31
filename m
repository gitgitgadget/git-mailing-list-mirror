Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE491ECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 16:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiHaQDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiHaQCm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 12:02:42 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684D6B72AB
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:02:31 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b5so18876864wrr.5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=RK6M6vNaCuXmD05IIM118P3ecENeGQ6PIeoWjahGIWo=;
        b=NIMvk7K4p4KfVx9tySOeWkvlT8ZYaQR6tBqy4ylgHtQY8IeE+/UzEy0Aiq+iBN8y3m
         kBwTlmWNgDyheWc28Esp3QdI91pDHIdUAeBw6L2ibzeL9m9yPpWxR+kgnnabMspbkfI4
         r0QckCvgzdygYKIGuwXJGnzy5ZemPjtu1RT7CHL8uvlIBxCXsDCd/73p5T8b/rQfbfXb
         gqsKw/q69v+6MRPhzHU9UdhfdKVpFMWJV5HMt1/KlAZjdsHoPLqXfCfM4+iQYZxaZhkz
         oa/5NXfYec7rtW1tpoOiSq8C3DQCxxP3MxdOxhZ4fi0M23i5VAxS1QbBToegpQdpwvaV
         np1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=RK6M6vNaCuXmD05IIM118P3ecENeGQ6PIeoWjahGIWo=;
        b=vHDKTfq6sHpvD2ywwJ1gyrrvo35OXB3s3Zaw0pqG+qSxiFQTc30ubKPQUbyDl/w/1S
         tRXCKB7ONHX9g+Ytgh5UQUI9PEZJoIyBc2siQgA8B01TdMSu82F8PQQgRGYTOdRRAID5
         YE6FhBoEHl9wiE6mQVD4Faj2qUb4TkwnulnRp/tLme781R2K3mnVyMQ3NX6F21P2Fkla
         jpJl1SE4/khUcdWYnWYqu8ME1D9eQqLD8Wv8BgcZ2y4KbzptaYMmUv6haj3G628xC4nc
         X13Vkfzq5JFh/AF7hY/QVNXzqY7I0RpzcPG8p2041dJU3SxaLC7q76cm/OXHIRYb0lof
         LHYA==
X-Gm-Message-State: ACgBeo1T+v26idXERR+GS4nqolyhPYkdyxjHaWg8pmhmUSHpvrN3KWeP
        +gfc0vZRDN62HlDR4cj1w+v0q1tj+gg=
X-Google-Smtp-Source: AA6agR590roVJdw30UZmfP9lHWOqMl/Zxrdbt1X6ysG/AVfCPFvYCv8e9uEAM2/mzgTToqojdSUXrQ==
X-Received: by 2002:a05:6000:381:b0:221:7542:61bb with SMTP id u1-20020a056000038100b00221754261bbmr12168014wrf.305.1661961749030;
        Wed, 31 Aug 2022 09:02:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k36-20020a05600c1ca400b003a5f3de6fddsm3146384wms.25.2022.08.31.09.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:02:27 -0700 (PDT)
Message-Id: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 16:02:17 +0000
Subject: [PATCH 0/8] scalar: integrate into core Git
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        gitster@pobox.com, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series completes the initial implementation of the Scalar command as a
core component of Git. For readers new to the topic of Scalar, the
roadmap/design doc [1] provides some background information including how
the project started & evolved, as well as its current intent & high-level
design.


Goals
=====

The goal of this series is, as noted in the roadmap linked earlier, to
integrate Scalar as a core user-facing component of Git. There's no
individual existing precedent that the integration is 100% based on; it's
more of an amalgam of the approaches used with builtins installed directly
to the bindir (e.g. 'git-upload-pack'), contributed tools (e.g. 'gitk'), and
the 'git' executable itself. The resulting behavior is:

 * Scalar is built & installed unconditionally (like a builtin).
 * Scalar is included in 'bin-wrappers/' and is installed into the 'bin/'
   directory (like 'git-upload-pack').
 * Scalar's documentation is installed as 'man1' docs (like 'gitk').
 * Scalar is not invoked via the 'git' executable (it's called directly,
   like 'git' itself).

The move out of 'contrib/' is also intended to mean that the relationship
between Git and Scalar should no longer be a strict one-way dependency. In
this series, this architectural change is what permits making a change to
'help.c' specifically for the sake of Scalar. Future contributions can and
should (where appropriate!) share code between Scalar and non-Scalar parts
of Git.


Organization
============

The series is broken up as follows:

 1. Fix a CI-breaking documentation error in 'scalar.txt' (patch 1).
 2. Move Scalar code out of 'contrib/' and into core Git, including changes
    in build definition(s) to build & install Scalar and its resources
    (patch 2).
 3. Make 'git help scalar' open the 'scalar' command documentation,
    introduce 'scalar help' as an alias. This is done after moving out of
    'contrib/' due to it involving Scalar-related changes to the non-Scalar
    file 'help.c' (patches 3-4).
 4. Expand test coverage, including perf testing (patches 5-6)
 5. Add a perf test configuration allowing users to register standard perf
    test repos with Scalar (patch 7).
 6. Remove the internally-focused Scalar roadmap from
    'Documentation/technical/scalar.txt', include it as one of the HTML
    technical docs (patch 8).


Prior series
============

 * Add 'scalar' command in 'contrib/':
   https://lore.kernel.org/git/pull.1005.v10.git.1638538470.gitgitgadget@gmail.com/
 * Introduce 'scalar diagnose':
   https://lore.kernel.org/git/pull.1128.v6.git.1653145696.gitgitgadget@gmail.com/
 * Add '-c/-C' compatibility:
   https://lore.kernel.org/git/pull.1130.v2.git.1643380317358.gitgitgadget@gmail.com/
 * [DROPPED] Integrate Scalar into CI builds:
   https://lore.kernel.org/git/pull.1129.git.1654160735.gitgitgadget@gmail.com/
 * Document Scalar's role in Git & plan remaining work:
   https://lore.kernel.org/git/pull.1275.v2.git.1657584367.gitgitgadget@gmail.com/
 * Generalize 'scalar diagnose' into 'git diagnose' builtin & 'git bugreport
   --diagnose':
   https://lore.kernel.org/git/pull.1310.v4.git.1660335019.gitgitgadget@gmail.com/
 * Add FSMonitor support to Scalar, refactor enlistment search:
   https://lore.kernel.org/git/pull.1324.v3.git.1660858853.gitgitgadget@gmail.com/

Thanks!

 * Victoria

[1]
https://lore.kernel.org/git/65eda9755d2a29e222bf7e6cc719921b24377cc6.1657584367.git.gitgitgadget@gmail.com/

Johannes Schindelin (2):
  git help: special-case `scalar`
  scalar: implement the `help` subcommand

Victoria Dye (6):
  scalar: fix command documentation section header
  scalar: include in standard Git build & installation
  scalar-clone: add test coverage
  t/perf: add Scalar performance tests
  t/perf: add 'GIT_PERF_USE_SCALAR' run option
  Documentation/technical: include Scalar technical doc

 .gitignore                                    |   1 +
 Documentation/Makefile                        |   2 +
 {contrib/scalar => Documentation}/scalar.txt  |   2 +-
 Documentation/technical/scalar.txt            |  61 --------
 Makefile                                      |  30 ++--
 builtin/help.c                                |   2 +
 contrib/buildsystems/CMakeLists.txt           |   9 +-
 contrib/scalar/.gitignore                     |   2 -
 contrib/scalar/Makefile                       |  35 -----
 contrib/scalar/t/Makefile                     |  81 -----------
 contrib/scalar/scalar.c => scalar.c           |  20 +++
 t/perf/README                                 |   4 +
 t/perf/p9210-scalar.sh                        |  43 ++++++
 t/perf/perf-lib.sh                            |  13 +-
 t/perf/run                                    |   3 +
 .../t/t9099-scalar.sh => t/t9210-scalar.sh    |  10 +-
 t/t9211-scalar-clone.sh                       | 135 ++++++++++++++++++
 17 files changed, 249 insertions(+), 204 deletions(-)
 rename {contrib/scalar => Documentation}/scalar.txt (99%)
 delete mode 100644 contrib/scalar/.gitignore
 delete mode 100644 contrib/scalar/Makefile
 delete mode 100644 contrib/scalar/t/Makefile
 rename contrib/scalar/scalar.c => scalar.c (98%)
 create mode 100755 t/perf/p9210-scalar.sh
 rename contrib/scalar/t/t9099-scalar.sh => t/t9210-scalar.sh (96%)
 create mode 100755 t/t9211-scalar-clone.sh


base-commit: d42b38dfb5edf1a7fddd9542d722f91038407819
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1341%2Fvdye%2Ffeature%2Fscalar-toplevel-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1341/vdye/feature/scalar-toplevel-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1341
-- 
gitgitgadget
