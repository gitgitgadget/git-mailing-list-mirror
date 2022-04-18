Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D18C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 18:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347375AbiDRSgU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 14:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiDRSgT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 14:36:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E00124BDC
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 11:33:38 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id p18so18660219wru.5
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 11:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ftiH/ndwhNgH0ddiaGdS7hLN2yXZae4B7/XhPwn101s=;
        b=cnphu8JZi0APnoy3AV+fw7niFjkuPBQWnEB0CgaoGaKathHVzBXDdN5xsGlfX4vflb
         Rz2LghuJizFc9XIc3+/JksBG1t4UMzisDtTL9tXnGXUoth1UcLCqtwzhoHBOVpUz4fuf
         G9/nAvJ50mokivl6Axw5O1CVRekfi2MXhcI0IBHn4AVpup1hn4lKeP5RtaDl+fWZKI1x
         jmb9EqJO88cxqomxOQOAJzaZZKcnPMCQADEjwoVITnC9foLzk3Y1NQNti5EH4ITVaij9
         8UfpdmAmYpyMWIi3ccGfl98dgApOQhVVJ1etKbLwtQgvDBMf6OocNXoPO950miuF7zoF
         VJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ftiH/ndwhNgH0ddiaGdS7hLN2yXZae4B7/XhPwn101s=;
        b=0LqCwyl1hJxk/1PqTYaWJX7iWGA/BSIaQgSodeDJTNRBgbld8jmnXhbOx2BTS2B+1l
         zd78+UaEKiCKV4ZeIZ9YGqwwCmihWkP33N+Ybh8v7wYtifMonrkOTtJxod9nBSj0fovV
         mP0lsCoJ3xiZ15mrifp/b6MV7oFzTxAhvzVUiTetLlPhjLuSI7GNfdhNeLHp0S1awLza
         WpXA7eMwolYkTM/ywy4RfNIG1xRa9a9WyFilR6ff01L1ba0jUPhtrckaHyRV8RnwqDrz
         etXsPEvueF+yPA2P0slxoY1VYf3i5TT29hzkDE+4ri14o9XtUgc0OAvlIS3GSK6qOxMt
         BRTw==
X-Gm-Message-State: AOAM533UXjtTznaa6JB74asCo7Wgc2fs0bMTCCRjrf3wr7/e8Z1pKbo5
        2y6as+E+XF90XTtBdvJLi98=
X-Google-Smtp-Source: ABdhPJzEyzHhl34OLUeL2nt4yL/HrMZZ09YRknou0xb46MzB/mswyh4psEhLcBm5VFQjixanpfSCAQ==
X-Received: by 2002:a05:6000:1887:b0:20a:904f:e9f5 with SMTP id a7-20020a056000188700b0020a904fe9f5mr6594105wri.522.1650306816241;
        Mon, 18 Apr 2022 11:33:36 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id m4-20020a7bcb84000000b00389efb7a5b4sm17298472wmi.17.2022.04.18.11.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 11:33:35 -0700 (PDT)
Message-ID: <e303769f-c008-8187-c20f-01a950657fed@gmail.com>
Date:   Mon, 18 Apr 2022 19:33:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 00/25] CI: run "make [test]" directly, use $GITHUB_ENV
Content-Language: en-GB-large
To:     Victoria Dye <vdye@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
 <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
 <320b3dde-a84e-0074-bed8-57061293b2b0@github.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <320b3dde-a84e-0074-bed8-57061293b2b0@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 25/03/2022 20:43, Victoria Dye wrote:
> Ævar Arnfjörð Bjarmason wrote:
>> A re-roll of my improvements my series to simplify the CI setup a lot
>> (see diffstat), much of it was dealing with constraints that went away
>> with Travis et al. CI for this series (OSX runners failing for
>> unrelated reasons):
>>
>>      https://github.com/avar/git/actions/runs/2040223909
>>
>> For a much more detailed summary of how the output looks before/after
>> see v1[].
>>
>> This series heavily conflicts with Johannes's
>> js/ci-github-workflow-markup in "seen", but in the v1 I suggested
>> basing that series on top of this one, because it can benefit a lot
>> from these simplifications.
>>
>> I'll reply to this series with a proposed rebasing of that series on
>> top of this one, which allows for removing almost all of its changes
>> to "ci/" with no harm to its end-goals, i.e. the splitting up of
>> "make" and "make test" output is something it'll get for free from
>> this series.
>>
>> Junio: Since that series has been stalled on still-outstanding
>> performance issues for a couple of months I was hoping we could queue
>> this instead, and perhaps in addition if Johannes approves of the
>> proposed re-roll on top of his.
>>
>> There's some forward progress on the performance issues (this[2] reply
>> of Victoria Dye's from yesterday), but fully resolving those will
>> probably take a bit...
>>
>> Whereas even though this one is relatively large I don't think there's
>> anything controversial here. The one concern that's been raised has
>> been Johannes's objection to removing some of the dead Azure code
>> (which was needed to move forward here). I asked how he'd prefer to
>> move forward with that in [3], but there hasn't been a reply to that
>> in >1 month.
>>
> 
> While the largeness of a series shouldn't necessarily block it, the lack of
> overarching structure or purpose in this one makes it really difficult for
> me to review with much confidence (I can't speak for everyone, but it may be
> one of the reasons for the general lack of feedback).

That applies to me, I think this would be easier to follow if it was 
split up. As far as I can tell there are several groups of changes and I 
think it would be easier for reviewers if they were split into separate 
shorter series.

1. Split building git and running the tests into separate steps. This is
    I think the only user facing change. I think it is worthwhile and
    could be done in a single patch that just moved make test into a
    separate script without a lot of refactoring. In particular I do not
    see the need for separate steps that setup the environment for the
    build and tests (especially as the build environment variables are
    still present when the tests are run).
    Without the refactoring anyone resurrecting the azure pipelines for
    testing security fixes would easily be able to update those build
    definitions.

2. Moving the static analysis ci job into the Makefile. I'm not sure
    what the practical benefit of this is but it could be a self
    contained series.

3. Being able to run the ci scripts locally. Does this have a use beyond
    debugging them locally? Could this be implemented with a wrapper
    script rather than a large refactoring?

4. Cleanups. To be honest I think we could happily live without a some
    of these, especially patches 24-26 of v3 that rework code introduced
    in this series.

I see v4 has been posted while I was writing this and is even longer 
than v3.

Best Wishes

Phillip

> If you believe all of
> these patches as thematically-related enough to warrant being in a single
> series, then it would help a lot if you could:
> 
> 1. Clearly describe the purpose of the series (yes they're all CI
>     improvements, but *why* these particular improvements, and why do they
>     all need to go together?)
> 2. Outline the "path" these commits take to accomplishing that purpose ("The
>     first 3 commits do X because Y. Then, the next 4 commits do A because B."
>     etc. or whatever format fits your writing style, as long as the
>     information is there).
> 3. Reorganize commits as necessary to keep the above outline from jumping
>     back and forth between topics.
> 
> Personally, I think this could (should?) be split into at least two series:
> one that breaks up 'run-build-and-tests.sh' (and is more directly relevant
> to dscho's series), and one that does the cleanup/flag change/other work.
> The two appear to be independent, and the resulting two series would be a
> much more manageable 10-15 commits each.
> 
>> I think just removing it is OK, we can always bring it back if needed,
>> and doing so is actually going to be simpler on top of this since the
>> CI is now less special, and leans more heavily on the logic of our
>> normal build process.
>>
>> 1. https://lore.kernel.org/git/cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com
>> 2. https://lore.kernel.org/git/6b83bb83-32b9-20c9-fa02-c1c3170351c3@github.com/
>> 3. https://lore.kernel.org/git/220222.86y2236ndp.gmgdl@evledraar.gmail.com/
>>
>> Ævar Arnfjörð Bjarmason (25):
>>    CI: run "set -ex" early in ci/lib.sh
>>    CI: make "$jobname" explicit, remove fallback
>>    CI: remove more dead Travis CI support
>>    CI: remove dead "tree skipping" code
>>    CI: remove unused Azure ci/* code
>>    CI: don't have "git grep" invoke a pager in tree content check
>>    CI: have "static-analysis" run a "make ci-static-analysis" target
>>    CI: have "static-analysis" run "check-builtins", not "documentation"
>>    CI: move p4 and git-lfs variables to ci/install-dependencies.sh
>>    CI: consistently use "export" in ci/lib.sh
>>    CI: export variables via a wrapper
>>    CI: remove "run-build-and-tests.sh", run "make [test]" directly
>>    CI: check ignored unignored build artifacts in "win[+VS] build" too
>>    CI: invoke "make artifacts-tar" directly in windows-build
>>    CI: split up and reduce "ci/test-documentation.sh"
>>    CI: combine ci/install{,-docker}-dependencies.sh
>>    CI: move "env" definitions into ci/lib.sh
>>    ci/run-test-slice.sh: replace shelling out with "echo"
>>    CI: pre-select test slice in Windows & VS tests
>>    CI: only invoke ci/lib.sh as "steps" in main.yml
>>    CI: narrow down variable definitions in --build and --test
>>    CI: add more variables to MAKEFLAGS, except under vs-build
>>    CI: set CC in MAKEFLAGS directly, don't add it to the environment
>>    CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
>>    CI: don't use "set -x" in "ci/lib.sh" output
>>
>>   .github/workflows/main.yml            | 100 +++++---
>>   Makefile                              |  31 ++-
>>   ci/check-directional-formatting.bash  |   2 +-
>>   ci/check-unignored-build-artifacts.sh |  20 ++
>>   ci/install-dependencies.sh            |  53 ++++-
>>   ci/install-docker-dependencies.sh     |  22 --
>>   ci/lib-ci-type.sh                     |  10 +
>>   ci/lib-tput.sh                        |   2 +
>>   ci/lib.sh                             | 316 +++++++++++++-------------
>>   ci/make-test-artifacts.sh             |  12 -
>>   ci/mount-fileshare.sh                 |  25 --
>>   ci/print-test-failures.sh             |  16 +-
>>   ci/run-build-and-tests.sh             |  54 -----
>>   ci/run-docker-build.sh                |  66 ------
>>   ci/run-docker.sh                      |  47 ----
>>   ci/run-static-analysis.sh             |  32 ---
>>   ci/run-test-slice.sh                  |  17 --
>>   ci/select-test-slice.sh               |  10 +
>>   ci/test-documentation.sh              |  37 +--
>>   ci/util/extract-trash-dirs.sh         |  50 ----
>>   shared.mak                            |   1 +
>>   21 files changed, 346 insertions(+), 577 deletions(-)
>>   create mode 100755 ci/check-unignored-build-artifacts.sh
>>   delete mode 100755 ci/install-docker-dependencies.sh
>>   create mode 100644 ci/lib-ci-type.sh
>>   create mode 100644 ci/lib-tput.sh
>>   delete mode 100755 ci/make-test-artifacts.sh
>>   delete mode 100755 ci/mount-fileshare.sh
>>   delete mode 100755 ci/run-build-and-tests.sh
>>   delete mode 100755 ci/run-docker-build.sh
>>   delete mode 100755 ci/run-docker.sh
>>   delete mode 100755 ci/run-static-analysis.sh
>>   delete mode 100755 ci/run-test-slice.sh
>>   create mode 100755 ci/select-test-slice.sh
>>   delete mode 100755 ci/util/extract-trash-dirs.sh
>>
>> Range-diff against v1:
>>   1:  970849a227f =  1:  4addbd70213 CI: run "set -ex" early in ci/lib.sh
>>   2:  eda7fb18064 =  2:  b23aa99fd37 CI: make "$jobname" explicit, remove fallback
>>   3:  3ee32815cf3 =  3:  eec15a95879 CI: remove more dead Travis CI support
>>   4:  c81c1b3f504 =  4:  73c894f1665 CI: remove dead "tree skipping" code
>>   5:  4738a22a36d =  5:  b5e6d538554 CI: remove unused Azure ci/* code
>>   6:  59e4f41e86c =  6:  a4b9febbdca CI: don't have "git grep" invoke a pager in tree content check
>>   7:  836ef20fdcc !  7:  5d46d5b34c9 CI: have "static-analysis" run a "make ci-static-analysis" target
>>      @@ .github/workflows/main.yml: jobs:
>>            if: needs.ci-config.outputs.enabled == 'yes'
>>       
>>        ## Makefile ##
>>      -@@ Makefile: ifndef V
>>      - 	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
>>      - 	QUIET_RC       = @echo '   ' RC $@;
>>      - 	QUIET_SPATCH   = @echo '   ' SPATCH $<;
>>      -+	QUIET_CHECK    = @echo '   ' CHECK $@;
>>      - 	QUIET_SUBDIR0  = +@subdir=
>>      - 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
>>      - 			 $(MAKE) $(PRINT_DIR) -C $$subdir
>>       @@ Makefile: coccicheck: $(addsuffix .patch,$(filter-out %.pending.cocci,$(wildcard contrib/c
>>        # See contrib/coccinelle/README
>>        coccicheck-pending: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.pending.cocci))
>>      @@ ci/run-static-analysis.sh (deleted)
>>       -
>>       -make hdr-check ||
>>       -exit 1
>>      +
>>      + ## shared.mak ##
>>      +@@ shared.mak: ifndef V
>>      + 	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
>>      + 	QUIET_RC       = @echo '   ' RC $@;
>>      + 	QUIET_SPATCH   = @echo '   ' SPATCH $<;
>>      ++	QUIET_CHECK    = @echo '   ' CHECK $@;
>>      +
>>      + ## Used in "Documentation/Makefile"
>>      + 	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
>>   8:  95cd496868e =  8:  81e06f13d84 CI: have "static-analysis" run "check-builtins", not "documentation"
>>   9:  a1d0796259e =  9:  3be91c26d44 CI: move p4 and git-lfs variables to ci/install-dependencies.sh
>> 10:  b6a61a786c5 = 10:  9dc148341ba CI: consistently use "export" in ci/lib.sh
>> 11:  f2fcee5d6e4 = 11:  e9c7ba492e8 CI: export variables via a wrapper
>> 12:  dfd823f2e7d = 12:  86d5a48d59a CI: remove "run-build-and-tests.sh", run "make [test]" directly
>> 13:  46459fff296 = 13:  649ad1ae249 CI: check ignored unignored build artifacts in "win[+VS] build" too
>> 14:  aecd3ebaafe = 14:  b1b5b083389 CI: invoke "make artifacts-tar" directly in windows-build
>> 15:  4f1564af70f = 15:  dfa91ac8938 CI: split up and reduce "ci/test-documentation.sh"
>> 16:  868613a5b06 = 16:  ba4ed216769 CI: combine ci/install{,-docker}-dependencies.sh
>> 17:  5d854e8ff36 = 17:  b5e89a33340 CI: move "env" definitions into ci/lib.sh
>> 18:  a6106525b7f = 18:  571f4d0f441 ci/run-test-slice.sh: replace shelling out with "echo"
>> 19:  e9c6c4dd293 = 19:  2edea06ee4d CI: pre-select test slice in Windows & VS tests
>> 20:  40d86e8c1dc = 20:  ef9daa6882f CI: only invoke ci/lib.sh as "steps" in main.yml
>> 21:  abf9c504740 = 21:  44e3ace5fbe CI: narrow down variable definitions in --build and --test
>> 22:  9f4c2798a82 = 22:  5f56b922e08 CI: add more variables to MAKEFLAGS, except under vs-build
>> 23:  8a8b7ecf16b ! 23:  b45b7cec94e CI: stop over-setting the $CC variable
>>      @@ Metadata
>>       Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>       
>>        ## Commit message ##
>>      -    CI: stop over-setting the $CC variable
>>      +    CI: set CC in MAKEFLAGS directly, don't add it to the environment
>>       
>>      -    As detailed in 2c8921db2b8 (travis-ci: build with the right compiler,
>>      -    2019-01-17) the reason we started using $CC in $MAKEFLAGS as opposed
>>      -    to setting it in the environment was due to Travis CI clobbering $CC
>>      -    in the environment.
>>      +    Rather than pass a "$CC" and "$CC_PACKAGE" in the environment to be
>>      +    picked up in ci/lib.sh let's instead have ci/lib.sh itself add it
>>      +    directly to MAKEFLAGS.
>>       
>>      -    We don't need to set it unconditionally to accomplish that, but rather
>>      -    just have it set for those jobs that need them. E.g. the "win+VS
>>      -    build" job confusingly has CC=gcc set, even though it builds with
>>      -    MSVC.
>>      +    Setting CC=gcc by default made for confusing trace output, and since a
>>      +    preceding change to carry it and others over across "steps" in the
>>      +    GitHub CI it's been even more misleading.  E.g. the "win+VS build" job
>>      +    confusingly has CC=gcc set, even though it builds with MSVC.
>>      +
>>      +    Let's instead reply on the Makefile default of CC=cc, and only
>>      +    override it for those jobs where it's needed. This does mean that
>>      +    we'll need to set it for the "pedantic" job, which previously relied
>>      +    on the default CC=gcc in case "clang" become the default on that
>>      +    platform.
>>       
>>           This partially reverts my 707d2f2fe86 (CI: use "$runs_on_pool", not
>>           "$jobname" to select packages & config, 2021-11-23), i.e. we're now
>>      @@ ci/lib.sh: linux-TEST-vars)
>>        	setenv --test GIT_TEST_DEFAULT_HASH sha256
>>        	;;
>>        pedantic)
>>      ++	CC=gcc
>>      + 	# Don't run the tests; we only care about whether Git can be
>>      + 	# built.
>>      + 	setenv --build DEVOPTS pedantic
>>       @@ ci/lib.sh: linux-musl)
>>        	MAKEFLAGS="$MAKEFLAGS GIT_TEST_UTF8_LOCALE=C.UTF-8"
>>        	;;
>> 24:  d7b472b4a52 = 24:  06bf8d9f61b CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
>> 25:  08a9776c259 = 25:  6dc96ba8b82 CI: don't use "set -x" in "ci/lib.sh" output
> 
