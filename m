Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2BDC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 13:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241171AbiBWN4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 08:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiBWN4M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 08:56:12 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6874B0A6E
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 05:55:42 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id x15so5381392wrg.8
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 05:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e8NDh6wGLwrnYVFoJ84NkbbQTbojPcAQYiYHa2ka/w0=;
        b=KORYA6XQdkeWer0TZesTsYldKGtHjmU4o87SORX+GDLVG81Zz74XDC56dKMl7+ZOVF
         AehA5DUZ+EgGwOs/Wzzsap/RgKprEozfw/G3pYdhl18YVDil8H9kfF0AOS1lF7t6SXHj
         1nBL9FqgBLOmqAbgay6fwiomVHxCIe3WRzwbaUJtrXJDriMV0L/c/YF6hOSdqdjsWCBC
         Kq974VkeWhgeunrWyqpH1NmtXz/4P1NgTzyRPv/ZAxql1YVn54EefkQ0rMikWmEFmMQr
         /D6VYv8qftMTM9oETgXpOecmybNnTLXTusITmpQ8L6Vgro+W7C0ou7a5Lf0UkdIfjES+
         Wi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e8NDh6wGLwrnYVFoJ84NkbbQTbojPcAQYiYHa2ka/w0=;
        b=YybxtacBJc/jATc6bPTVDv82cCYynRINP2fWmfo4uTfNiOX1gaBY8jYLOD4daJmZM1
         N8o0bMk+jvqEtNinKmuFu+CHxmhGUS9/PfCukJY4PsTcryOizbA6bHRcPW2+2tVrjtfo
         NQlxR3dXxNytne//FSoZDJGL7/soub5ELsi5vmZzr1bKvTsU7Fbz2kxIP3Ih4V4GQFhc
         YPfYhdKIVUcfUE6cyXccZ8VloEpxmQL02Jj8X2Ouv3xabgQFnqk9PxnDxuH5qDQENhlO
         JhxUylrGJIr8c1otkWZjhHt8WAjnY6/re0mqzmRbmWEI9uu2IH6pzXVCvIxX220YMHH1
         i7ug==
X-Gm-Message-State: AOAM533onWs/mhFtN/uQM1WijlTBHV29U54sAxp4m3mmgGgkUA6wpZMM
        dU9UI9xLMr4iKkNSQUhEqmo=
X-Google-Smtp-Source: ABdhPJzkK/lQX7CYorucKzyj9X0ie8igfe8uJWJunxiQjkZyy20GJu+m0Rk2cFZG52EV0OLkj7cPzw==
X-Received: by 2002:adf:ef44:0:b0:1e4:99e8:a65e with SMTP id c4-20020adfef44000000b001e499e8a65emr24451610wrp.365.1645624541100;
        Wed, 23 Feb 2022 05:55:41 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id k4-20020a05600c0b4400b0034a0cb4332csm5433842wmr.10.2022.02.23.05.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 05:55:40 -0800 (PST)
Message-ID: <4d3fecbf-23f9-f6b6-414e-8eaca620aced@gmail.com>
Date:   Wed, 23 Feb 2022 13:55:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/25] CI: run "make [test]" directly, use $GITHUB_ENV
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 21/02/2022 14:46, Ævar Arnfjörð Bjarmason wrote:
 > [...]
> == Details
> 
> This series conflicts with and is a proposed alternative to Johannes's
> proposed changes to teach "ci/lib.sh" GitHub specific syntax to
> "group" certain parts of the output[2]. That series proposes to keep
> the "ci/run-build-and-tests.sh" and similar scripts, but to teach them
> to emit markers indicating when the "build" part commences, then
> "test" etc.
> 
> I think the approach offered here is better as elaborated on in
> 12/25[1], especially because as Johannes notes[3] we only have one
> level of "grouping" within a "step" available to us. In his version
> using it for "build" v.s. "test" precludes being able to group parts
> of that "build" or "test" output in the future.
> 
> The following compares CI output between the three with a
> change-on-top which caused a compilation error ("this" is this series,
> "js" is Johannes's) when clicking on the "linux-gcc" failure:
> 
>    master: https://github.com/avar/git/runs/5274251909?check_suite_focus=true
>    this: https://github.com/avar/git/runs/5274464670?check_suite_focus=true
>    js: https://github.com/avar/git/runs/5272239403?check_suite_focus=true
> 
>    Here we went from 93 lines of output on "master" to 47 in "this"
>    (107 in "js"). Note also how in "this" we can:
> 
>    - Expand the "Run make" to get the "MAKEFLAGS" and other variables
>      used in the step. That's now a 3-line summary instead of the
>      first 50 lines being the old "ci/lib.sh" "set -x" output.
> 
>    - Because "make" failed, we have an elided "make test" step that's
>      not being run below. We can thus see what steps our failure caused
>      us to skip.
> 
>    - Unlike the "js" version we'll show the compilation error by
>      default (the "js" version is grouped and needs to be expanded),
>      but our output is now brief enough that that's no longer
>      surrounded by other irrelevant output.
> 
>    - Unlike the "js" version there is no "CI setup" group within each
>      step. That work is in the earlier "ci/lib.sh --build" step
>      instead, which sets the config for all subsequent steps.

I can see that showing compilation errors without having to expand 
anything is useful but in my experience they are relatively rare 
compared to test failures. If I understand the rest of the message 
correctly we're left with having to expand print-test-failures and 
searching for "not ok" to find out what went wrong with this series.

> For other output changes look at the difference between "master" and
> "this" at:
> 
>    master: https://github.com/git/git/actions/runs/1866786595
>    this: https://github.com/avar/git/actions/runs/1876270588
> 
> Not explicitly covered in the summary above is that various other
> parts of ci/* were doing the same sort of within-step setup, but now
> do so via cross-step passing of variables via $GITHUB_ENV. E.g. on
> "master" the test slices for the Windows tests have a lot of verbosity
> before they get to running the test itself:
> 
>      https://github.com/git/git/runs/5254267914?check_suite_focus=true#step:5:56
> 
> In the "js" version the test output is hidden ("grouped"), but we've
> got the same amount of verbosity by default:
> 
>      https://github.com/gitgitgadget/git/runs/4937491771?check_suite_focus=true#step:5:67
> 
> Whereas in "this" version that verbosity is in the preceding "select
> tests" step, with the "test" step showing only the relevant end-state
> of the "$T" variable we'll use in the Makefile (hidden by default,
> expanded in this link):
> 
>      https://github.com/avar/git/runs/5274558869?check_suite_focus=true#step:7:13

All I can see in the "$T" variable I have to scroll to get the prove 
output on screen


> This series does not attempt to replace the use of the "group" output
> used for the "ok" or "not ok" portion of tests in Johannes's
> series. When a test fails the output in this series (sans config
> discovery not being repeated, and now summarized in the $GITHUB_ENV
> drop-down) is substantially the same as on "master".
> 
> My summary at [4] goes into other overlap & non-overlap between the
> two. I think using the "group" output for those purposes might be
> useful, although I left some feedback on [5] with problems in the
> current "js" implementation.
> 
> I do think any such changes should follow behind this series, as doing
> that sort of grouping once we can effectively free up an extra "group"
> level (by peeling those off into "steps", as is done here) would be
> much more useful.

I can see the attraction of being able to use make directly in the ci 
from an implementation point of view but from the point of view of 
someone trying to investigate a test failure then unless I've 
misunderstood I don't think this series improves the current situation. 
Why can't you build on top of Dscho's series that makes it easier to see 
the output of the failed tests?

Best Wishes

Phillip

> 1. https://lore.kernel.org/git/patch-12.25-dfd823f2e7d-20220221T122605Z-avarab@gmail.com
> 2. https://lore.kernel.org/git/pull.1117.git.1643050574.gitgitgadget@gmail.com/
> 3. https://lore.kernel.org/git/9333ba781b8240f704e739b00d274f8c3d887e39.1643050574.git.gitgitgadget@gmail.com/
> 4. https://lore.kernel.org/git/220127.86ilu5cdnf.gmgdl@evledraar.gmail.com/
> 5. https://lore.kernel.org/git/220126.86sftbfjl4.gmgdl@evledraar.gmail.com/
> 
> Ævar Arnfjörð Bjarmason (25):
>    CI: run "set -ex" early in ci/lib.sh
>    CI: make "$jobname" explicit, remove fallback
>    CI: remove more dead Travis CI support
>    CI: remove dead "tree skipping" code
>    CI: remove unused Azure ci/* code
>    CI: don't have "git grep" invoke a pager in tree content check
>    CI: have "static-analysis" run a "make ci-static-analysis" target
>    CI: have "static-analysis" run "check-builtins", not "documentation"
>    CI: move p4 and git-lfs variables to ci/install-dependencies.sh
>    CI: consistently use "export" in ci/lib.sh
>    CI: export variables via a wrapper
>    CI: remove "run-build-and-tests.sh", run "make [test]" directly
>    CI: check ignored unignored build artifacts in "win[+VS] build" too
>    CI: invoke "make artifacts-tar" directly in windows-build
>    CI: split up and reduce "ci/test-documentation.sh"
>    CI: combine ci/install{,-docker}-dependencies.sh
>    CI: move "env" definitions into ci/lib.sh
>    ci/run-test-slice.sh: replace shelling out with "echo"
>    CI: pre-select test slice in Windows & VS tests
>    CI: only invoke ci/lib.sh as "steps" in main.yml
>    CI: narrow down variable definitions in --build and --test
>    CI: add more variables to MAKEFLAGS, except under vs-build
>    CI: stop over-setting the $CC variable
>    CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
>    CI: don't use "set -x" in "ci/lib.sh" output
> 
>   .github/workflows/main.yml            | 100 +++++---
>   Makefile                              |  32 ++-
>   ci/check-directional-formatting.bash  |   2 +-
>   ci/check-unignored-build-artifacts.sh |  20 ++
>   ci/install-dependencies.sh            |  53 ++++-
>   ci/install-docker-dependencies.sh     |  22 --
>   ci/lib-ci-type.sh                     |  10 +
>   ci/lib-tput.sh                        |   2 +
>   ci/lib.sh                             | 315 ++++++++++++--------------
>   ci/make-test-artifacts.sh             |  12 -
>   ci/mount-fileshare.sh                 |  25 --
>   ci/print-test-failures.sh             |  16 +-
>   ci/run-build-and-tests.sh             |  54 -----
>   ci/run-docker-build.sh                |  66 ------
>   ci/run-docker.sh                      |  47 ----
>   ci/run-static-analysis.sh             |  32 ---
>   ci/run-test-slice.sh                  |  17 --
>   ci/select-test-slice.sh               |  10 +
>   ci/test-documentation.sh              |  37 +--
>   ci/util/extract-trash-dirs.sh         |  50 ----
>   20 files changed, 345 insertions(+), 577 deletions(-)
>   create mode 100755 ci/check-unignored-build-artifacts.sh
>   delete mode 100755 ci/install-docker-dependencies.sh
>   create mode 100644 ci/lib-ci-type.sh
>   create mode 100644 ci/lib-tput.sh
>   delete mode 100755 ci/make-test-artifacts.sh
>   delete mode 100755 ci/mount-fileshare.sh
>   delete mode 100755 ci/run-build-and-tests.sh
>   delete mode 100755 ci/run-docker-build.sh
>   delete mode 100755 ci/run-docker.sh
>   delete mode 100755 ci/run-static-analysis.sh
>   delete mode 100755 ci/run-test-slice.sh
>   create mode 100755 ci/select-test-slice.sh
>   delete mode 100755 ci/util/extract-trash-dirs.sh
> 

