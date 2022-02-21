Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF836C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378297AbiBUOrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:47:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378289AbiBUOrO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:14 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEBA1122
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:48 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n8so9656923wms.3
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6YiOwmMkq7rOBVr858JjiJTVCLFaSEmhKNkpnQX3QmY=;
        b=iowCqjb+dYCQPJP5TlOhZlRe5EpLtneGIU4RQRpO/KdK5CfQ8IaBALAAOZa/OiqPYt
         QKV3Uimy8DlEMbZQBIp2B/D4U0J2CEC0y47c0vXSNetgyO+7+RsZvP02dFrFeHa06sEO
         Sdzmhvk0sKfK5hvHo5lLQx3LjrAIAz7RFnATb4WXxUnWzc9N5oeX8NxEWGSb2gmD7OuH
         TqeLxiDHLWf2w0rPpLup97G6hP/6+yJznRXvhbYqqB+4h5UXS2/epdcMm7O2wb68EbHJ
         PTInpFve4GV5fpr9kLsT3xykhcoiLCqNGwz0BhsrDOb5sDTtTabU3jjipv5KIGLrfPOR
         KJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6YiOwmMkq7rOBVr858JjiJTVCLFaSEmhKNkpnQX3QmY=;
        b=dMR6N/c19+lOXhqWnFvRPoWdohQ7Gus/b69jUMvYw/8M6ftxRAvORC300G7jOKC2Up
         KsZmSSIf0GMvVD9ViTT31fldWeJQ/P1BCljwjrrXO2nZbCpC6qZTHkGoE81Ycu4ISQIu
         VnoCsi7Zk4xMNiHgU1h8p9LnND5ftXDmxdYdQdlhhsubq+LKvixlzZM5zgd2aOJslPaB
         TWHxJfQsLS13+qmr1YeaaZq9znhUKi6/m1VhuYWrrTB9YVb0dtp5WWAuVf8ejLTxVoTn
         J+6YJ0GxpsmA/RngVKvovYD+fmqu2ZR5et60GSFfKkN8CdqPboj83Jn51I65HhDFmjco
         i8Kg==
X-Gm-Message-State: AOAM532krK4HSTwf6P03vku0VOAlJY/yCFOMimTlULe84LAfUobSjuUd
        Cj3feUWyKC+JnjAFFSHgkX2E7Y27PoY=
X-Google-Smtp-Source: ABdhPJweZJ7GIJh1sfNRNyK7+nxOyCj3H7idorO1O/gB01pKBnzoPgTHXnoU/w6gJHacZnpNol6eYQ==
X-Received: by 2002:a1c:43c3:0:b0:37b:c663:156c with SMTP id q186-20020a1c43c3000000b0037bc663156cmr18079607wma.140.1645454806972;
        Mon, 21 Feb 2022 06:46:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:46:46 -0800 (PST)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/25] CI: run "make [test]" directly, use $GITHUB_ENV
Date:   Mon, 21 Feb 2022 15:46:12 +0100
Message-Id: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

== Applying this

Merging this has a trivial conflct with "seen"'s
js/use-builtin-add-i. The
s/GIT_TEST_ADD_I_USE_BUILTIN=1/GIT_TEST_ADD_I_USE_BUILTIN=0/g" there
needs to be correspondingly changed (using "setenv", no "export") in
ci/lib.sh

== Summary

This series makes the CI less of a special-case by getting rid of
wrapper scripts like "ci/run-build-and-tests.sh" in favor of simply
running "make" or "make test" directly.

It also has changes that make us do less special-ness in
CI. E.g. there's now a "make ci-static-analysis" target that can be
run locally to do what "ci/run-static-analysis.sh" did before. The CI
just invokes that new "make" target, and the
"ci/run-static-analysis.sh" script has been "git rm'd".

The 12/25 here has a more detailed summary[1], but basically the
"ci/lib.sh" is now a script run directly from an early CI step within
a given job. That script runs sets the environment variables needed in
$GITHUB_ENV (what GitHub CI uses to carry forward the environment
between steps).

== Details

This series conflicts with and is a proposed alternative to Johannes's
proposed changes to teach "ci/lib.sh" GitHub specific syntax to
"group" certain parts of the output[2]. That series proposes to keep
the "ci/run-build-and-tests.sh" and similar scripts, but to teach them
to emit markers indicating when the "build" part commences, then
"test" etc.

I think the approach offered here is better as elaborated on in
12/25[1], especially because as Johannes notes[3] we only have one
level of "grouping" within a "step" available to us. In his version
using it for "build" v.s. "test" precludes being able to group parts
of that "build" or "test" output in the future.

The following compares CI output between the three with a
change-on-top which caused a compilation error ("this" is this series,
"js" is Johannes's) when clicking on the "linux-gcc" failure:

  master: https://github.com/avar/git/runs/5274251909?check_suite_focus=true
  this: https://github.com/avar/git/runs/5274464670?check_suite_focus=true
  js: https://github.com/avar/git/runs/5272239403?check_suite_focus=true

  Here we went from 93 lines of output on "master" to 47 in "this"
  (107 in "js"). Note also how in "this" we can:

  - Expand the "Run make" to get the "MAKEFLAGS" and other variables
    used in the step. That's now a 3-line summary instead of the
    first 50 lines being the old "ci/lib.sh" "set -x" output.

  - Because "make" failed, we have an elided "make test" step that's
    not being run below. We can thus see what steps our failure caused
    us to skip.

  - Unlike the "js" version we'll show the compilation error by
    default (the "js" version is grouped and needs to be expanded),
    but our output is now brief enough that that's no longer
    surrounded by other irrelevant output.

  - Unlike the "js" version there is no "CI setup" group within each
    step. That work is in the earlier "ci/lib.sh --build" step
    instead, which sets the config for all subsequent steps.

For other output changes look at the difference between "master" and
"this" at:

  master: https://github.com/git/git/actions/runs/1866786595
  this: https://github.com/avar/git/actions/runs/1876270588

Not explicitly covered in the summary above is that various other
parts of ci/* were doing the same sort of within-step setup, but now
do so via cross-step passing of variables via $GITHUB_ENV. E.g. on
"master" the test slices for the Windows tests have a lot of verbosity
before they get to running the test itself:

    https://github.com/git/git/runs/5254267914?check_suite_focus=true#step:5:56

In the "js" version the test output is hidden ("grouped"), but we've
got the same amount of verbosity by default:

    https://github.com/gitgitgadget/git/runs/4937491771?check_suite_focus=true#step:5:67

Whereas in "this" version that verbosity is in the preceding "select
tests" step, with the "test" step showing only the relevant end-state
of the "$T" variable we'll use in the Makefile (hidden by default,
expanded in this link):

    https://github.com/avar/git/runs/5274558869?check_suite_focus=true#step:7:13

This series does not attempt to replace the use of the "group" output
used for the "ok" or "not ok" portion of tests in Johannes's
series. When a test fails the output in this series (sans config
discovery not being repeated, and now summarized in the $GITHUB_ENV
drop-down) is substantially the same as on "master".

My summary at [4] goes into other overlap & non-overlap between the
two. I think using the "group" output for those purposes might be
useful, although I left some feedback on [5] with problems in the
current "js" implementation.

I do think any such changes should follow behind this series, as doing
that sort of grouping once we can effectively free up an extra "group"
level (by peeling those off into "steps", as is done here) would be
much more useful.

1. https://lore.kernel.org/git/patch-12.25-dfd823f2e7d-20220221T122605Z-avarab@gmail.com
2. https://lore.kernel.org/git/pull.1117.git.1643050574.gitgitgadget@gmail.com/
3. https://lore.kernel.org/git/9333ba781b8240f704e739b00d274f8c3d887e39.1643050574.git.gitgitgadget@gmail.com/
4. https://lore.kernel.org/git/220127.86ilu5cdnf.gmgdl@evledraar.gmail.com/
5. https://lore.kernel.org/git/220126.86sftbfjl4.gmgdl@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (25):
  CI: run "set -ex" early in ci/lib.sh
  CI: make "$jobname" explicit, remove fallback
  CI: remove more dead Travis CI support
  CI: remove dead "tree skipping" code
  CI: remove unused Azure ci/* code
  CI: don't have "git grep" invoke a pager in tree content check
  CI: have "static-analysis" run a "make ci-static-analysis" target
  CI: have "static-analysis" run "check-builtins", not "documentation"
  CI: move p4 and git-lfs variables to ci/install-dependencies.sh
  CI: consistently use "export" in ci/lib.sh
  CI: export variables via a wrapper
  CI: remove "run-build-and-tests.sh", run "make [test]" directly
  CI: check ignored unignored build artifacts in "win[+VS] build" too
  CI: invoke "make artifacts-tar" directly in windows-build
  CI: split up and reduce "ci/test-documentation.sh"
  CI: combine ci/install{,-docker}-dependencies.sh
  CI: move "env" definitions into ci/lib.sh
  ci/run-test-slice.sh: replace shelling out with "echo"
  CI: pre-select test slice in Windows & VS tests
  CI: only invoke ci/lib.sh as "steps" in main.yml
  CI: narrow down variable definitions in --build and --test
  CI: add more variables to MAKEFLAGS, except under vs-build
  CI: stop over-setting the $CC variable
  CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
  CI: don't use "set -x" in "ci/lib.sh" output

 .github/workflows/main.yml            | 100 +++++---
 Makefile                              |  32 ++-
 ci/check-directional-formatting.bash  |   2 +-
 ci/check-unignored-build-artifacts.sh |  20 ++
 ci/install-dependencies.sh            |  53 ++++-
 ci/install-docker-dependencies.sh     |  22 --
 ci/lib-ci-type.sh                     |  10 +
 ci/lib-tput.sh                        |   2 +
 ci/lib.sh                             | 315 ++++++++++++--------------
 ci/make-test-artifacts.sh             |  12 -
 ci/mount-fileshare.sh                 |  25 --
 ci/print-test-failures.sh             |  16 +-
 ci/run-build-and-tests.sh             |  54 -----
 ci/run-docker-build.sh                |  66 ------
 ci/run-docker.sh                      |  47 ----
 ci/run-static-analysis.sh             |  32 ---
 ci/run-test-slice.sh                  |  17 --
 ci/select-test-slice.sh               |  10 +
 ci/test-documentation.sh              |  37 +--
 ci/util/extract-trash-dirs.sh         |  50 ----
 20 files changed, 345 insertions(+), 577 deletions(-)
 create mode 100755 ci/check-unignored-build-artifacts.sh
 delete mode 100755 ci/install-docker-dependencies.sh
 create mode 100644 ci/lib-ci-type.sh
 create mode 100644 ci/lib-tput.sh
 delete mode 100755 ci/make-test-artifacts.sh
 delete mode 100755 ci/mount-fileshare.sh
 delete mode 100755 ci/run-build-and-tests.sh
 delete mode 100755 ci/run-docker-build.sh
 delete mode 100755 ci/run-docker.sh
 delete mode 100755 ci/run-static-analysis.sh
 delete mode 100755 ci/run-test-slice.sh
 create mode 100755 ci/select-test-slice.sh
 delete mode 100755 ci/util/extract-trash-dirs.sh

-- 
2.35.1.1132.ga1fe46f8690

