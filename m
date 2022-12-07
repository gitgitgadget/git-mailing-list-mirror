Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3826AC4708E
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 15:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiLGPJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 10:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLGPJW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 10:09:22 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7DC5BD44
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 07:09:20 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so1254795wmh.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 07:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KbBdZUHu5sxaUZx7mLz0+A1ir/9kIU5Z7m1ScLUduoc=;
        b=K+TqIDy8+dE6+5NYGrsIhR33MMgZ1dAMGQWlxdaBXMu3lcHZKi82wqq+A/H0j9kNaV
         54m/mDiV5UU9aPbOR2m2+QZuaM4P0YVAR9RPT5Bvm4Cl8G3BtO/TJoJAazAMeweo/19n
         P/Qzp5VyqK4noGWvBy8LBHUC/cfxExk/wVymuWCAMh1dGTcJCrJLfTymdGN5YLMW9fpA
         J4uTDvNR+CYHAQen/A9DILYJexWG4Zewm5imephdbcr5X8U2W/NyFA5sY7Kc2909dI+7
         oXgpL++yvR5J6kKMsahiWTau9psyCLOan/HSKlG0gJDoaC97V35f5Ep4KYPlAaRPP7C6
         6uAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbBdZUHu5sxaUZx7mLz0+A1ir/9kIU5Z7m1ScLUduoc=;
        b=iNkt2gUf7G36ottRZeFyB5/GDytsIAXGEQhvjTTOKtAMb7sLj3PqpgITFqpee3SlJD
         2dHCvJfoPa9lZNgQcthpY571MSdMUdsYfbG2S0uXsp15Ci7/xwwJnLOpNaC1S1oUxiT5
         SpL3q8zC5kc75n5xItyUabt+v4g/c/PeFNUUIeRvggYtuB97taQPHL4vRF5LTb5AUufZ
         leOc7R4L6vao21mNW9FfuzXOR0q2QbiSfhOMzNpJ81qTq1V71LF3BzLN7BXcmqhaWdn7
         HnIIWB2zjMH+11MOaifeXSr4Z5jn2oIkDa3uk4hZ7Xj/ajWjlQ8Qfa50kctnT1KVtBdR
         bsOg==
X-Gm-Message-State: ANoB5pn+ZDSICQf/CJoXVrqlwr21mvGFx4mcaCVGVxkjND6MpSRSCARV
        ZyWoGAB7l+r1Mc4Eh9DrD90=
X-Google-Smtp-Source: AA0mqf4HL0TywSpQmwfQUG40pko7I/MK13Z2U56rU02Q0mql3Qzc12TMQtH1lP+YqaALkotQBHv8yA==
X-Received: by 2002:a7b:c3d2:0:b0:3d0:475f:d390 with SMTP id t18-20020a7bc3d2000000b003d0475fd390mr39645918wmj.149.1670425758563;
        Wed, 07 Dec 2022 07:09:18 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id e14-20020adff34e000000b0024228b0b932sm24246705wrp.27.2022.12.07.07.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 07:09:18 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <b56d6f29-b22f-f64a-82b3-e7217c0e720d@dunelm.org.uk>
Date:   Wed, 7 Dec 2022 15:09:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 00/15] cmake: document, fix on *nix, add CI
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
References: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
 <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
In-Reply-To: <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 06/12/2022 02:08, Ævar Arnfjörð Bjarmason wrote:
> This topic gets our tests from passing ~80% with ctest on *nix to
> passing 100%.
> 
> See passing CI job for "cmake + ctest" on Ubuntu at:
> https://github.com/avar/git/actions/runs/3625189647
> 
> See
> https://lore.kernel.org/git/cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com/
> for the v5.
> 
> Changes since v5:
> 
> * Typo/grammar etc. fixes noted by Eric.
> * Phillip reported the "chmod" fallback no working on Windows. I
>    couldn't reproduce that, but running it was always redundant there
>    we'll now skip doing that on Windows.

I suspect the issue is that "chmod" is not in %path% (i.e. $PATH in 
posix shell speak) when CMake is run from visual studio (the mingw stuff 
is only available when running "sh" by default to prevent name clashes 
with the windows find command etc.) but is added to $PATH in the CI 
after installing the git-for-windows sdk.

> * Adjust 15/15 to fold into an existing "case" statement, rather than
>    adding a new "if" statement.
> 
> For this v6 I experimented with changing the "win+VS build|test" job
> build in "contrib/buildsystems/out" rather than at the top-level[1]. I
> left those changes out here, but doing so makes that a lot simpler, as
> it no longer needs to rely on the Makefile to tell it what cmake might
> have built.

Long term I think that is a good direction for the CI job. The CI job is 
not a good simulation of running CMake from Visual Studio. That does not 
normally matter but has been a problem for this series. Ideally it would 
run the test with CTest as well, I'm not sure how much work that would be.

> But even without including that here, those changes should give more
> confidence in these changes, i.e. they show that our CI's "msbuild"
> doesn't require the "cmake" to build things at the top-level.
> 
> 1. https://github.com/avar/git/tree/avar/cmake-test-path-no-make-for-windows-ci
> 
> Ævar Arnfjörð Bjarmason (15):
>    cmake: don't invoke msgfmt with --statistics
>    cmake: use "-S" and "-B" to specify source and build directories
>    cmake: update instructions for portable CMakeLists.txt
>    cmake: don't copy chainlint.pl to build directory
>    cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
>    cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
>    cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
>    Makefile + test-lib.sh: don't prefer cmake-built to make-built git

As far as I can see this changes test-lib.sh to prefer the make-built 
git if it exists even after running cmake and ctest. Ideally we'd test 
the most recent build.

Best Wishes

Phillip

>    test-lib.sh: support a "GIT_TEST_BUILD_DIR"
>    cmake: optionally be able to run tests before "ctest"
>    cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
>    cmake: increase test timeout on Windows only
>    cmake: only look for "sh" in "C:/Program Files" on Windows
>    cmake: copy over git-p4.py for t983[56] perforce test
>    CI: add a "linux-cmake-test" to run cmake & ctest on linux
> 
>   .github/workflows/main.yml          |   3 +
>   Makefile                            |   1 -
>   ci/run-build-and-tests.sh           |  11 +-
>   contrib/buildsystems/CMakeLists.txt | 213 ++++++++++++++++++++++------
>   t/README                            |   3 +
>   t/lib-gettext.sh                    |   2 +-
>   t/lib-gitweb.sh                     |   2 +-
>   t/t7609-mergetool--lib.sh           |   2 +-
>   t/t9902-completion.sh               |  14 +-
>   t/t9903-bash-prompt.sh              |   2 +-
>   t/test-lib.sh                       |  19 ++-
>   11 files changed, 211 insertions(+), 61 deletions(-)
> 
> Range-diff against v5:
>   1:  7d83ff44c61 !  1:  fc190b379cd cmake: don't invoke msgfmt with --statistics
>      @@ Metadata
>        ## Commit message ##
>           cmake: don't invoke msgfmt with --statistics
>       
>      -    In 2f12b31b746 (Makefile: don't invoke msgfmt with --statistics,
>      -    2021-12-17) I made the same change to our Makefile, let's follow-up
>      -    and do the same here.
>      +    In [1] I made the same change to our Makefile, let's follow-up and do
>      +    the same here.
>       
>           For "cmake" this is particularly nice with "-G Ninja", as before we'd
>           emit ~40 lines of overflowed progress bar output, but now it's only
>           the one line of "ninja"'s progress bar.
>       
>      +    1. 2f12b31b746 (Makefile: don't invoke msgfmt with --statistics,
>      +       2021-12-17)
>      +
>           Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>       
>        ## contrib/buildsystems/CMakeLists.txt ##
>   2:  314c5e40cff !  2:  1a11aa233a3 cmake: use "-S" and "-B" to specify source and build directories
>      @@ Commit message
>           The "-S" and "-B" options were added in cmake v3.13.0, which is older
>           than the version we have a hard dependency on[1].
>       
>      -    As an aside The "-p" flag to "mkdir" in the pre-image wasn't needed,
>      +    As an aside, the "-p" flag to "mkdir" in the pre-image wasn't needed,
>           as "contrib/buildsystems" is tracked
>       
>           1. 061c2240b1b (Introduce CMake support for configuring Git, 2020-06-12)
>   3:  5c4ba2425b6 =  3:  b9ddb5db1d3 cmake: update instructions for portable CMakeLists.txt
>   4:  e86245ffbab =  4:  7b7850c00ee cmake: don't copy chainlint.pl to build directory
>   5:  435452314fa !  5:  82ecb797915 cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
>      @@ Commit message
>       
>           The remaining failures will be addressed in subsequent commits.
>       
>      +    As this isn't needed on Windows let's skip this there. There's also an
>      +    unconfirmed (it works in CI) report[5] that invoking the "chmod"
>      +    command fails in some scenarios.
>      +
>           1. f31b6244950 (Merge branch 'yw/cmake-updates', 2022-06-07)
>           2. e4597aae659 (run test suite without dashed git-commands in PATH, 2009-12-02)
>           3. 2ea1d8b5563 (cmake: make it easier to diagnose regressions in CTest
>              runs, 2022-10-18)
>           4. https://cmake.org/cmake/help/latest/command/file.html#chmod
>      +    5. https://lore.kernel.org/git/87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk/
>       
>           Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>       
>      @@ contrib/buildsystems/CMakeLists.txt: add_custom_command(OUTPUT ${git_links} ${gi
>       +function(write_script path content)
>       +	file(WRITE ${path} ${content})
>       +
>      -+	if("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" VERSION_GREATER_EQUAL "3.19")
>      ++	if(WIN32)
>      ++		message(TRACE "skipping chmod +x '${path}' on Windows")
>      ++	elseif("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" VERSION_GREATER_EQUAL "3.19")
>       +		file(CHMOD ${path} FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE)
>       +	else()
>       +		execute_process(COMMAND chmod +x ${path}
>   6:  7ee341245a8 =  6:  1f326944a07 cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
>   7:  49645cb1643 =  7:  973c8038f54 cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
>   8:  9e10cd5bd8a =  8:  b8448c7a8a6 Makefile + test-lib.sh: don't prefer cmake-built to make-built git
>   9:  df5aea35bbd !  9:  5135e40969e test-lib.sh: support a "GIT_TEST_BUILD_DIR"
>      @@ Metadata
>        ## Commit message ##
>           test-lib.sh: support a "GIT_TEST_BUILD_DIR"
>       
>      -    Compliment the existing GIT_TEST_INSTALLED variable added in [1] with
>      +    Complement the existing GIT_TEST_INSTALLED variable added in [1] with
>           one that allows for testing a git built in a directory that's not
>           "../".
>       
> 10:  529e18f7f72 ! 10:  65204463730 cmake: optionally be able to run tests before "ctest"
>      @@ contrib/buildsystems/CMakeLists.txt: if(USE_VCPKG)
>       +	set(GIT_CTEST_SETS_BUILD_DIR "OFF" CACHE BOOL GIT_CTEST_SETS_BUILD_DIR_DOC)
>       +endif()
>       +if(GIT_CTEST_SETS_BUILD_DIR)
>      -+	message(STATUS "Enabling manual runs of t/* tests once ctest writes CMAKE-BUILD-DIR")
>      ++	message(STATUS "Have GIT_CTEST_SETS_BUILD_DIR=ON. Need a 'ctest' run to write GIT-BUILD-DIR")
>       +else()
>      -+	message(STATUS "Enabling manual runs of t/* tests via cmake build dir discovery")
>      ++	message(STATUS "Have GIT_CTEST_SETS_BUILD_DIR=OFF. Wrote out a GIT-BUILD-DIR, no 'ctest' required")
>       +endif()
>       +
>       +# When using GIT_CTEST_SETS_BUILD_DIR, running the tests from the "t/"
> 11:  a5dd4fa1d00 ! 11:  e25992b16f1 cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
>      @@ contrib/buildsystems/CMakeLists.txt: endif()
>       +elseif(WIN32)
>       +	set(GIT_TEST_OPTS "--no-bin-wrappers --no-chain-lint -vx"
>       +		CACHE STRING "test options, see t/README")
>      -+	message(STATUS "Using Windowns-specific default test options: ${GIT_TEST_OPTS}")
>      ++	message(STATUS "Using Windows-specific default test options: ${GIT_TEST_OPTS}")
>       +else()
>       +	set(GIT_TEST_OPTS ""
>       +		CACHE STRING "test options, see t/README")
> 12:  c9d550b8558 = 12:  4905ce5321d cmake: increase test timeout on Windows only
> 13:  7a5dd684d40 = 13:  6c6b530965d cmake: only look for "sh" in "C:/Program Files" on Windows
> 14:  c9c895bb794 = 14:  563f1b9b045 cmake: copy over git-p4.py for t983[56] perforce test
> 15:  a6f343b6221 ! 15:  917a884eb65 CI: add a "linux-cmake-test" to run cmake & ctest on linux
>      @@ Commit message
>           To ensure that it doesn't break again let's add a "linux-cmake-ctest"
>           target to build and test "cmake" on Linux, in addition to that we'll
>           also run the tests with "ctest" instead of "make" or "prove", so we
>      -    can assert that testing with that method works..
>      +    can assert that testing with that method works.
>       
>           This also stress tests running "cmake" (and "ctest") out of a build
>           directory that isn't the top-level. The "vs-build" job uses "cmake"
>      @@ Commit message
>           "$GIT_SOURCE_DIR" in a preceding commit.
>       
>           Since the "ci/lib.sh" already creates and exports a
>      -    GIT_TEST_OPTS="..." we'll pick that up in our CI, see the preceding
>      +    GIT_TEST_OPTS="..." we'll pick that up in our CI; see the preceding
>           commit. Because we pass the "--verbose-log -x
>           --github-workflow-markup" in the GitHub CI as a result the interaction
>           with "handle_failed_tests" here works correctly. I.e. on failure we'll
>      @@ .github/workflows/main.yml: jobs:
>                    pool: macos-latest
>       
>        ## ci/run-build-and-tests.sh ##
>      -@@ ci/run-build-and-tests.sh: pedantic)
>      - 	;;
>      - esac
>      +@@ ci/run-build-and-tests.sh: esac
>      +
>      + run_tests=t
>        
>      --group Build make
>       +mc=
>      -+if test "$jobname" = "linux-cmake-ctest"
>      -+then
>      + case "$jobname" in
>      + linux-gcc)
>      + 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>      +@@ ci/run-build-and-tests.sh: pedantic)
>      + 	export DEVOPTS=pedantic
>      + 	run_tests=
>      + 	;;
>      ++linux-cmake-ctest)
>       +	cb=contrib/buildsystems
>       +	group CMake cmake -S "$cb" -B "$cb/out"
>       +	mc="-C $cb/out"
>      -+fi
>      -+
>      ++	;;
>      + esac
>      +
>      +-group Build make
>       +group Build make $mc
>       +
>        if test -n "$run_tests"
