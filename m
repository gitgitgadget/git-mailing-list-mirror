Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A80DC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 16:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhKWQco (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhKWQco (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 11:32:44 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A583CC061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 08:29:35 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d24so40021964wra.0
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 08:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h6uyYnaJq3jLvGtybO8WxvRdjeJHNOVAwMS0Fj+ortM=;
        b=U/fHOOxprpH6S/Ahj+HjQfDjkhNOzLkVm8mY9LrVW6GANK3+U+xGSM1D2HwBWaSIRH
         ZiFWEmv7h2GIcp2YQlUHoc/dkn68PyKG6QqK/Jv6sr9C68fjYQlzfxEDxOHn+dXmWIDC
         mGAY5wMXlfECGQpq1DuKioySoK6ZfLkimurPOonqZg4BYm20aJncI6Ve/ihFaVRTm6eG
         vpD0GaLQO/IfQq0fUioeEyqm7oM4H2R1Pl+EU/UOqjMU6FvzoKxfN4V79TulHl5iOKVX
         ubK57rVSaCq4P7ZbtIIe2rwoZE+HR3pMd3MeorT/oN9w92jIUNpg9AzRfVVWKK6v0sFw
         0X6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h6uyYnaJq3jLvGtybO8WxvRdjeJHNOVAwMS0Fj+ortM=;
        b=Uf7QtZGjiXKu9G91HeRATDeTtYlHxoeDMoHLHv7vfEgtbp8TiQUhK2TDIJw5EZ59iE
         tQWPV/FJ+Anu+KwfEm9LUdHao1Xkqi4Kt+B45AkUE2JGSgl2oR3wT9mjhlxRnJT992iG
         MTApP89tBp4OsQnR1FcFchpPn81zZaGTozq3yQ7o7K97ymNU+qJIhXMmAywDlLf+p4P2
         bvRT7ukk5eaenuVUEpkG1c4rNATyD72diRc3uyDBOljQtmioiOrOTPbK1toJ1yvglv/x
         UKHprf2XRS+lQAFrfKihcvxjshcPGNbjUVK8sr6Uo2ehinFDqqwe8Zv3JAzAL8ytGy9L
         voyw==
X-Gm-Message-State: AOAM530/rAHJs8HXD9ShDQS7fL4EGwFPVpb7y7MePO2anGPJ9ZFzNGHt
        1N4wHUy5eci7OdYS+zEGBOxyyMdTxMipxQ==
X-Google-Smtp-Source: ABdhPJz7t50Q1No7Y2+k3S+n99+zoCDUg+ur8T5+c5QDyO1oz9s/gsM/m3nZu7MYAcMg/PqegoTpHA==
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr8624180wrn.349.1637684973542;
        Tue, 23 Nov 2021 08:29:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h22sm2059940wmq.14.2021.11.23.08.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 08:29:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/5] CI: Remove Travis CI, shorten names for GH tooltips, split jobs
Date:   Tue, 23 Nov 2021 17:29:07 +0100
Message-Id: <cover-v4-0.5-00000000000-20211123T134300Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.830.g6387a5d107e
In-Reply-To: <cover-v3-0.5-00000000000-20211120T115414Z-avarab@gmail.com>
References: <cover-v3-0.5-00000000000-20211120T115414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A small update to the v3[1] of this series of CI UX improvements. A CI
run can be seen at:

    https://github.com/avar/git/runs/4299892497

And the improvement to tooltips by shortening them at (click on the CI
status symbol next to the commit subject):

    https://github.com/avar/git/tree/avar/ci-rm-travis-cleanup-ci-names-4

For comparison, the same for "master":

    https://github.com/git/git/runs/4289544907
    https://github.com/git/git/tree/master

Changes:

 * In removing Travis support I omitted the removal of now-dead
   linux-gcc-4.8 supporting code. Remove it too.

 * Clarify with a comment where new test targets in
   ci/run-build-and-tests.sh need to be added, to avoid a repeat of
   running new tests in the compilation-only "pedantic" job.

1. https://lore.kernel.org/git/cover-v3-0.5-00000000000-20211120T115414Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (5):
  CI: remove Travis CI support
  CI: use shorter names that fit in UX tooltips
  CI: rename the "Linux32" job to lower-case "linux32"
  CI: use "$runs_on_pool", not "$jobname" to select packages & config
  CI: don't run "make test" twice in one job

 .github/workflows/main.yml        | 26 ++++++++++++--
 .travis.yml                       | 60 -------------------------------
 README.md                         |  2 +-
 ci/install-dependencies.sh        | 35 ++++++++----------
 ci/install-docker-dependencies.sh |  2 +-
 ci/lib.sh                         | 60 ++++++++-----------------------
 ci/print-test-failures.sh         | 10 ------
 ci/run-build-and-tests.sh         | 27 +++++++-------
 ci/run-docker-build.sh            | 11 +-----
 ci/run-docker.sh                  |  4 +--
 10 files changed, 72 insertions(+), 165 deletions(-)
 delete mode 100644 .travis.yml

Range-diff against v3:
1:  96433bcc02f ! 1:  6a4f1961cd2 CI: remove Travis CI support
    @@ Commit message
         into more general code. See 0f0c51181df (travis-ci: install packages
         in 'ci/install-dependencies.sh', 2018-11-01).
     
    +    Remove the "linux-gcc-4.8" job added in fb9d7431cf4 (travis-ci: build
    +    with GCC 4.8 as well, 2019-07-18), it only ran in Travis CI.
    +
         1. https://travis-ci.org/github/git/git/builds
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ ci/install-dependencies.sh: UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl
      	sudo apt-get -q update
      	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
      		$UBUNTU_COMMON_PKGS
    +@@ ci/install-dependencies.sh: Documentation)
    + 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
    + 	sudo gem install --version 1.5.8 asciidoctor
    + 	;;
    +-linux-gcc-default|linux-gcc-4.8)
    ++linux-gcc-default)
    + 	sudo apt-get -q update
    + 	sudo apt-get -q -y install $UBUNTU_COMMON_PKGS
    + 	;;
     
      ## ci/lib.sh ##
     @@ ci/lib.sh: save_good_tree () {
    @@ ci/print-test-failures.sh: do
     -	echo "  curl https://api.travis-ci.org/v3/job/$TRAVIS_JOB_ID/log.txt |./ci/util/extract-trash-dirs.sh"
     -fi
     
    + ## ci/run-build-and-tests.sh ##
    +@@ ci/run-build-and-tests.sh: linux-clang)
    + 	export GIT_TEST_DEFAULT_HASH=sha256
    + 	make test
    + 	;;
    +-linux-gcc-4.8|pedantic)
    ++pedantic)
    + 	# Don't run the tests; we only care about whether Git can be
    +-	# built with GCC 4.8 or with pedantic
    ++	# built.
    + 	;;
    + *)
    + 	make test
    +
      ## ci/run-docker-build.sh ##
     @@ ci/run-docker-build.sh: else
      	else
2:  b09cd076aeb = 2:  5d53b79347f CI: use shorter names that fit in UX tooltips
3:  fb1b0ecbadd = 3:  37b97fc6c3a CI: rename the "Linux32" job to lower-case "linux32"
4:  54913e775c1 = 4:  614a99f7b64 CI: use "$runs_on_pool", not "$jobname" to select packages & config
5:  877f27d847c ! 5:  ee2f9254fc7 CI: don't run "make test" twice in one job
    @@ Commit message
         the variables, and then override it to just "all" for the compile-only
         tests.
     
    +    Add a comment to clarify that new "test" targets should adjust
    +    $MAKE_TARGETS rather than being added after the "case/esac". This
    +    should avoid future confusion where e.g. the compilation-only
    +    "pedantic" target will unexpectedly start running tests. See [1] and
    +    [2].
    +
    +    1. https://lore.kernel.org/git/211122.86ee78yxts.gmgdl@evledraar.gmail.com/
    +    2. https://lore.kernel.org/git/211123.86ilwjujmd.gmgdl@evledraar.gmail.com/
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## .github/workflows/main.yml ##
    @@ ci/run-build-and-tests.sh: linux-gcc)
      	export GIT_TEST_DEFAULT_HASH=sha256
     -	make test
      	;;
    --linux-gcc-4.8|pedantic)
    --	# Don't run the tests; we only care about whether Git can be
    --	# built with GCC 4.8 or with pedantic
    -+pedantic)
    -+	export DEVOPTS=pedantic
    -+	export MAKE_TARGETS=all
    - 	;;
    + pedantic)
    + 	# Don't run the tests; we only care about whether Git can be
    + 	# built.
    +-	;;
     -*)
     -	make test
    -+linux-gcc-4.8)
    ++	export DEVOPTS=pedantic
     +	export MAKE_TARGETS=all
      	;;
      esac
      
    ++# Any new "test" targets should not go after this "make", but should
    ++# adjust $MAKE_TARGETS. Otherwise compilation-only targets above will
    ++# start running tests.
     +make $MAKE_TARGETS
    -+
      check_unignored_build_artifacts
      
      save_good_tree
-- 
2.34.0.830.gb9cdc59c8af

