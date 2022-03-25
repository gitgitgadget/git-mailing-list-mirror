Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3055C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 20:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiCYUpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 16:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiCYUpc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 16:45:32 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100B22E087
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 13:43:57 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t13so6104779pgn.8
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+ZKM16PBjlonhRKv+/cMwmethnqFmeeXARo+j0XfINU=;
        b=OWQmwvKrvgdsykStf+VSqtrjg88o4bM4R1KVpZBz+BBUHZMXZaJsmx/JNqhTeVMuzI
         UK0AKulylYODhX7ubtidwXvzb4h5I6+SWkdJy+ms9no/f7n6qXchg1Ofnac0GpHVp8Q6
         X6ZnaAw5YDRzXr9JWE2L0M4ftk66z/JPsOMbts3o1KLJfhc7Jx2j0gyJbeARrdJUcx79
         fgtzf0qX2kZeGxK2fuTQPHQuZSLhmaHmWtQaILUCdsnIByBI0F3weaGPr209IWOQKTUn
         luNaKROxB6RPoeJrv76Io2xg2C3cxyjgD8HbpsZlerpNIsh5EjzjCZ5Ac1YlzEhVu+n6
         eQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+ZKM16PBjlonhRKv+/cMwmethnqFmeeXARo+j0XfINU=;
        b=El0ddGqoTUSds30sXnkJZQOFlu04LsJnR1J/omWTEecN+ZNUPwceOVn6ENXI4lqd9x
         JMym1wvWPdoUDW9S5LxK1NQpzhQTXx+/ly0qcPwwyb0r7fcIeDeWVhWbZJ/ivRzbRU5L
         cRjOMzbR2954kAu3yM6+hNswTKu9BuOfCI4c4AORmYUY/kCPmrbxF0GPVdFbrwf7yIg6
         TZr0z9m6PkH+tT6Vdd9ptOXFJaBikZcXMv/ZN+95H51KIe/nV+89+XTfnO4P97Mw4ElE
         zhMhm8JG3sCop/9N6SlKSgBSfM2MzWMqUJZG4oS8RpCSNma26jJ838HWCJfyLPyPQxS8
         4Y3g==
X-Gm-Message-State: AOAM532Gb3C4wGD65RztTTGA87muVyBth7qeXVrIQnjAz+1pWHJnEDBT
        ZJe9rGRre07+EvvupU3K9DYA
X-Google-Smtp-Source: ABdhPJztL9oZviStUAd5vCtF59ZK1MD/cXmYD97Rgn6sNznj3KOFGcE+gM3Mk8zcq+PJoVd5Y+B/Jg==
X-Received: by 2002:a63:1457:0:b0:382:3e2d:83fa with SMTP id 23-20020a631457000000b003823e2d83famr1049420pgu.201.1648241036419;
        Fri, 25 Mar 2022 13:43:56 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id d11-20020a056a00198b00b004fa7da68465sm7603337pfl.60.2022.03.25.13.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 13:43:56 -0700 (PDT)
Message-ID: <320b3dde-a84e-0074-bed8-57061293b2b0@github.com>
Date:   Fri, 25 Mar 2022 13:43:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2 00/25] CI: run "make [test]" directly, use $GITHUB_ENV
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
 <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> A re-roll of my improvements my series to simplify the CI setup a lot
> (see diffstat), much of it was dealing with constraints that went away
> with Travis et al. CI for this series (OSX runners failing for
> unrelated reasons):
> 
>     https://github.com/avar/git/actions/runs/2040223909
> 
> For a much more detailed summary of how the output looks before/after
> see v1[].
> 
> This series heavily conflicts with Johannes's
> js/ci-github-workflow-markup in "seen", but in the v1 I suggested
> basing that series on top of this one, because it can benefit a lot
> from these simplifications.
> 
> I'll reply to this series with a proposed rebasing of that series on
> top of this one, which allows for removing almost all of its changes
> to "ci/" with no harm to its end-goals, i.e. the splitting up of
> "make" and "make test" output is something it'll get for free from
> this series.
> 
> Junio: Since that series has been stalled on still-outstanding
> performance issues for a couple of months I was hoping we could queue
> this instead, and perhaps in addition if Johannes approves of the
> proposed re-roll on top of his.
> 
> There's some forward progress on the performance issues (this[2] reply
> of Victoria Dye's from yesterday), but fully resolving those will
> probably take a bit...
> 
> Whereas even though this one is relatively large I don't think there's
> anything controversial here. The one concern that's been raised has
> been Johannes's objection to removing some of the dead Azure code
> (which was needed to move forward here). I asked how he'd prefer to
> move forward with that in [3], but there hasn't been a reply to that
> in >1 month.
> 

While the largeness of a series shouldn't necessarily block it, the lack of
overarching structure or purpose in this one makes it really difficult for
me to review with much confidence (I can't speak for everyone, but it may be
one of the reasons for the general lack of feedback). If you believe all of
these patches as thematically-related enough to warrant being in a single
series, then it would help a lot if you could:

1. Clearly describe the purpose of the series (yes they're all CI
   improvements, but *why* these particular improvements, and why do they
   all need to go together?) 
2. Outline the "path" these commits take to accomplishing that purpose ("The
   first 3 commits do X because Y. Then, the next 4 commits do A because B."
   etc. or whatever format fits your writing style, as long as the
   information is there).
3. Reorganize commits as necessary to keep the above outline from jumping
   back and forth between topics. 

Personally, I think this could (should?) be split into at least two series:
one that breaks up 'run-build-and-tests.sh' (and is more directly relevant
to dscho's series), and one that does the cleanup/flag change/other work.
The two appear to be independent, and the resulting two series would be a
much more manageable 10-15 commits each. 

> I think just removing it is OK, we can always bring it back if needed,
> and doing so is actually going to be simpler on top of this since the
> CI is now less special, and leans more heavily on the logic of our
> normal build process.
> 
> 1. https://lore.kernel.org/git/cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com
> 2. https://lore.kernel.org/git/6b83bb83-32b9-20c9-fa02-c1c3170351c3@github.com/
> 3. https://lore.kernel.org/git/220222.86y2236ndp.gmgdl@evledraar.gmail.com/
> 
> Ævar Arnfjörð Bjarmason (25):
>   CI: run "set -ex" early in ci/lib.sh
>   CI: make "$jobname" explicit, remove fallback
>   CI: remove more dead Travis CI support
>   CI: remove dead "tree skipping" code
>   CI: remove unused Azure ci/* code
>   CI: don't have "git grep" invoke a pager in tree content check
>   CI: have "static-analysis" run a "make ci-static-analysis" target
>   CI: have "static-analysis" run "check-builtins", not "documentation"
>   CI: move p4 and git-lfs variables to ci/install-dependencies.sh
>   CI: consistently use "export" in ci/lib.sh
>   CI: export variables via a wrapper
>   CI: remove "run-build-and-tests.sh", run "make [test]" directly
>   CI: check ignored unignored build artifacts in "win[+VS] build" too
>   CI: invoke "make artifacts-tar" directly in windows-build
>   CI: split up and reduce "ci/test-documentation.sh"
>   CI: combine ci/install{,-docker}-dependencies.sh
>   CI: move "env" definitions into ci/lib.sh
>   ci/run-test-slice.sh: replace shelling out with "echo"
>   CI: pre-select test slice in Windows & VS tests
>   CI: only invoke ci/lib.sh as "steps" in main.yml
>   CI: narrow down variable definitions in --build and --test
>   CI: add more variables to MAKEFLAGS, except under vs-build
>   CI: set CC in MAKEFLAGS directly, don't add it to the environment
>   CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
>   CI: don't use "set -x" in "ci/lib.sh" output
> 
>  .github/workflows/main.yml            | 100 +++++---
>  Makefile                              |  31 ++-
>  ci/check-directional-formatting.bash  |   2 +-
>  ci/check-unignored-build-artifacts.sh |  20 ++
>  ci/install-dependencies.sh            |  53 ++++-
>  ci/install-docker-dependencies.sh     |  22 --
>  ci/lib-ci-type.sh                     |  10 +
>  ci/lib-tput.sh                        |   2 +
>  ci/lib.sh                             | 316 +++++++++++++-------------
>  ci/make-test-artifacts.sh             |  12 -
>  ci/mount-fileshare.sh                 |  25 --
>  ci/print-test-failures.sh             |  16 +-
>  ci/run-build-and-tests.sh             |  54 -----
>  ci/run-docker-build.sh                |  66 ------
>  ci/run-docker.sh                      |  47 ----
>  ci/run-static-analysis.sh             |  32 ---
>  ci/run-test-slice.sh                  |  17 --
>  ci/select-test-slice.sh               |  10 +
>  ci/test-documentation.sh              |  37 +--
>  ci/util/extract-trash-dirs.sh         |  50 ----
>  shared.mak                            |   1 +
>  21 files changed, 346 insertions(+), 577 deletions(-)
>  create mode 100755 ci/check-unignored-build-artifacts.sh
>  delete mode 100755 ci/install-docker-dependencies.sh
>  create mode 100644 ci/lib-ci-type.sh
>  create mode 100644 ci/lib-tput.sh
>  delete mode 100755 ci/make-test-artifacts.sh
>  delete mode 100755 ci/mount-fileshare.sh
>  delete mode 100755 ci/run-build-and-tests.sh
>  delete mode 100755 ci/run-docker-build.sh
>  delete mode 100755 ci/run-docker.sh
>  delete mode 100755 ci/run-static-analysis.sh
>  delete mode 100755 ci/run-test-slice.sh
>  create mode 100755 ci/select-test-slice.sh
>  delete mode 100755 ci/util/extract-trash-dirs.sh
> 
> Range-diff against v1:
>  1:  970849a227f =  1:  4addbd70213 CI: run "set -ex" early in ci/lib.sh
>  2:  eda7fb18064 =  2:  b23aa99fd37 CI: make "$jobname" explicit, remove fallback
>  3:  3ee32815cf3 =  3:  eec15a95879 CI: remove more dead Travis CI support
>  4:  c81c1b3f504 =  4:  73c894f1665 CI: remove dead "tree skipping" code
>  5:  4738a22a36d =  5:  b5e6d538554 CI: remove unused Azure ci/* code
>  6:  59e4f41e86c =  6:  a4b9febbdca CI: don't have "git grep" invoke a pager in tree content check
>  7:  836ef20fdcc !  7:  5d46d5b34c9 CI: have "static-analysis" run a "make ci-static-analysis" target
>     @@ .github/workflows/main.yml: jobs:
>           if: needs.ci-config.outputs.enabled == 'yes'
>      
>       ## Makefile ##
>     -@@ Makefile: ifndef V
>     - 	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
>     - 	QUIET_RC       = @echo '   ' RC $@;
>     - 	QUIET_SPATCH   = @echo '   ' SPATCH $<;
>     -+	QUIET_CHECK    = @echo '   ' CHECK $@;
>     - 	QUIET_SUBDIR0  = +@subdir=
>     - 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
>     - 			 $(MAKE) $(PRINT_DIR) -C $$subdir
>      @@ Makefile: coccicheck: $(addsuffix .patch,$(filter-out %.pending.cocci,$(wildcard contrib/c
>       # See contrib/coccinelle/README
>       coccicheck-pending: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.pending.cocci))
>     @@ ci/run-static-analysis.sh (deleted)
>      -
>      -make hdr-check ||
>      -exit 1
>     +
>     + ## shared.mak ##
>     +@@ shared.mak: ifndef V
>     + 	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
>     + 	QUIET_RC       = @echo '   ' RC $@;
>     + 	QUIET_SPATCH   = @echo '   ' SPATCH $<;
>     ++	QUIET_CHECK    = @echo '   ' CHECK $@;
>     + 
>     + ## Used in "Documentation/Makefile"
>     + 	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
>  8:  95cd496868e =  8:  81e06f13d84 CI: have "static-analysis" run "check-builtins", not "documentation"
>  9:  a1d0796259e =  9:  3be91c26d44 CI: move p4 and git-lfs variables to ci/install-dependencies.sh
> 10:  b6a61a786c5 = 10:  9dc148341ba CI: consistently use "export" in ci/lib.sh
> 11:  f2fcee5d6e4 = 11:  e9c7ba492e8 CI: export variables via a wrapper
> 12:  dfd823f2e7d = 12:  86d5a48d59a CI: remove "run-build-and-tests.sh", run "make [test]" directly
> 13:  46459fff296 = 13:  649ad1ae249 CI: check ignored unignored build artifacts in "win[+VS] build" too
> 14:  aecd3ebaafe = 14:  b1b5b083389 CI: invoke "make artifacts-tar" directly in windows-build
> 15:  4f1564af70f = 15:  dfa91ac8938 CI: split up and reduce "ci/test-documentation.sh"
> 16:  868613a5b06 = 16:  ba4ed216769 CI: combine ci/install{,-docker}-dependencies.sh
> 17:  5d854e8ff36 = 17:  b5e89a33340 CI: move "env" definitions into ci/lib.sh
> 18:  a6106525b7f = 18:  571f4d0f441 ci/run-test-slice.sh: replace shelling out with "echo"
> 19:  e9c6c4dd293 = 19:  2edea06ee4d CI: pre-select test slice in Windows & VS tests
> 20:  40d86e8c1dc = 20:  ef9daa6882f CI: only invoke ci/lib.sh as "steps" in main.yml
> 21:  abf9c504740 = 21:  44e3ace5fbe CI: narrow down variable definitions in --build and --test
> 22:  9f4c2798a82 = 22:  5f56b922e08 CI: add more variables to MAKEFLAGS, except under vs-build
> 23:  8a8b7ecf16b ! 23:  b45b7cec94e CI: stop over-setting the $CC variable
>     @@ Metadata
>      Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>      
>       ## Commit message ##
>     -    CI: stop over-setting the $CC variable
>     +    CI: set CC in MAKEFLAGS directly, don't add it to the environment
>      
>     -    As detailed in 2c8921db2b8 (travis-ci: build with the right compiler,
>     -    2019-01-17) the reason we started using $CC in $MAKEFLAGS as opposed
>     -    to setting it in the environment was due to Travis CI clobbering $CC
>     -    in the environment.
>     +    Rather than pass a "$CC" and "$CC_PACKAGE" in the environment to be
>     +    picked up in ci/lib.sh let's instead have ci/lib.sh itself add it
>     +    directly to MAKEFLAGS.
>      
>     -    We don't need to set it unconditionally to accomplish that, but rather
>     -    just have it set for those jobs that need them. E.g. the "win+VS
>     -    build" job confusingly has CC=gcc set, even though it builds with
>     -    MSVC.
>     +    Setting CC=gcc by default made for confusing trace output, and since a
>     +    preceding change to carry it and others over across "steps" in the
>     +    GitHub CI it's been even more misleading.  E.g. the "win+VS build" job
>     +    confusingly has CC=gcc set, even though it builds with MSVC.
>     +
>     +    Let's instead reply on the Makefile default of CC=cc, and only
>     +    override it for those jobs where it's needed. This does mean that
>     +    we'll need to set it for the "pedantic" job, which previously relied
>     +    on the default CC=gcc in case "clang" become the default on that
>     +    platform.
>      
>          This partially reverts my 707d2f2fe86 (CI: use "$runs_on_pool", not
>          "$jobname" to select packages & config, 2021-11-23), i.e. we're now
>     @@ ci/lib.sh: linux-TEST-vars)
>       	setenv --test GIT_TEST_DEFAULT_HASH sha256
>       	;;
>       pedantic)
>     ++	CC=gcc
>     + 	# Don't run the tests; we only care about whether Git can be
>     + 	# built.
>     + 	setenv --build DEVOPTS pedantic
>      @@ ci/lib.sh: linux-musl)
>       	MAKEFLAGS="$MAKEFLAGS GIT_TEST_UTF8_LOCALE=C.UTF-8"
>       	;;
> 24:  d7b472b4a52 = 24:  06bf8d9f61b CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
> 25:  08a9776c259 = 25:  6dc96ba8b82 CI: don't use "set -x" in "ci/lib.sh" output

