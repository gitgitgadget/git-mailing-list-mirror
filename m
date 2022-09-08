Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97579C38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 03:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiIHDwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 23:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiIHDv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 23:51:59 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71484C275D
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 20:51:58 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d82so2998382pfd.10
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 20:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Silbx+9XYXIIs/Bn3tXEQooKGgkP3yaoYtiMWG2kZb4=;
        b=bsG/pCfuxHrjS2f6Pg/7k4mHixaYh95Ihn4w4vefvqCPc5E6rEmnl61SKuXYmjmXXC
         I/u0+ugYIdWvlFhDxTJqfbNZDPZ4AYcf9cG9AKPKjPisZxREHehpz9rRzMe+Prtq0fCK
         QmJ+Zv8cEikyA5sf5TVc1aNOgog3ktAhw66FcRZR/IKbo6Uhw7Mur+7xxRDcfVj4Zzt/
         BnmSN4iKkFJgG5zLpUI6Us1AciudaZjU+1C6aoci2nMIPXzX/d/ZADmiKB5Ii7ZhBaWC
         IINqbsFMTxq7u2iBiH+EiRrk8VCnBhVu1Cq1loJAKyWlkXFdsj1k9zvFCTKWW/Nkxgl4
         xVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Silbx+9XYXIIs/Bn3tXEQooKGgkP3yaoYtiMWG2kZb4=;
        b=syB6uzUseMdoTYl+x4uR0S2O9OsOezJpGOvGW645EWJDq0mofCGngOHknMKZa8+7cs
         VBKFshtjtkgcCgRjfbGKMKVVNPDi156t5Ab22L+NxTg7/Zu8tKTJa8eIK9aCP/4afCKy
         lyaPSnLYlNFj6V679fm9NJYGwIbZI9p+lnr1MXwOtlY2lt/RPshMjm052oEJDAes95t4
         j+0NnFvwksdyRGDZwW7Aev0fUGzaqi5C/imlucwXS7oaacr0SM+8sezG/TK5AIB3Ty5t
         vaF+5RQ4IUfI8zBjqx9NHTe1MWl4jURnt50Kicl/oOi++4vFiadx3KMxMvD4Cpp9w/6N
         ZI7Q==
X-Gm-Message-State: ACgBeo0dptNWssGaH/SWCarS+6AgueIO1VdLgrThhJv5v+rj//7hm7qO
        reBL5LGGl2/p4T+X26V9598U5ZfyQ7eA
X-Google-Smtp-Source: AA6agR5UYKzndMPjp7qUyHs1e/Vz+HrJTL+2YopBB1R4b5Hv9aF8BCNyrw8GSN7f/qk+mRExIe5lYQ==
X-Received: by 2002:a05:6a00:1350:b0:53a:c314:73d9 with SMTP id k16-20020a056a00135000b0053ac31473d9mr7089877pfu.45.1662609117822;
        Wed, 07 Sep 2022 20:51:57 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id z22-20020a634c16000000b00431912e7526sm11041171pga.7.2022.09.07.20.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 20:51:57 -0700 (PDT)
Message-ID: <2313a3ee-8baf-3589-a90b-cd7ee3bf5dfa@github.com>
Date:   Wed, 7 Sep 2022 20:51:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v2 0/5] Some fixes and an improvement for using CTest on
 Windows
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
 <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin via GitGitGadget wrote:
> Visual Studio users enjoy support for running the test suite via CTest,
> thanks to Git's CMake definition.
> 
> In https://github.com/git-for-windows/git/issues/3966, it has been reported
> that this does not work out of the box, though, but causes a couple of test
> failures instead. These problems are not caught by Git's CI runs because the
> vs-tests jobs actually use prove to run the test suite, not CTest.
> 
> In addition to fixing these problems, this patch series also addresses a
> long-standing gripe I have with the way Git's CMake definition supports
> CTest: It edits t/test-lib.sh, which leaves this file eternally modified
> (but these modification should never be committed, they refer to a
> local-only, configuration-dependent directory).
> 
> Note: The signed/unsigned comparison bug in git add -p that is fixed in this
> here patch series is a relatively big one, and it merits further
> investigation whether there are similar bugs lurking in Git's code base.
> However, this is a much bigger project than can be addressed as part of this
> patch series, in particular because the analysis would require tools other
> than GCC's -Wsign-compare option (which totally misses the instance that is
> fixed in this here patch series).
> 
> Changes since v1:
> 
>  * Clarified why it is a good idea to pass --no-bin-wrappers and
>    --no-chain-lint when running on Windows.
>  * Clarified why the add -p bug has not been caught earlier.
>  * Clarified the scope of this patch series to fix running Git's tests
>    within Visual Studio.
>  * Increased the time-out for the very slow t7112 test script.
>  * The test_chmod was determined to be not only faulty, but unneeded, and
>    was dropped.
> 
> Johannes Schindelin (5):
>   cmake: make it easier to diagnose regressions in CTest runs
>   cmake: copy the merge tools for testing
>   add -p: avoid ambiguous signed/unsigned comparison
>   cmake: avoid editing t/test-lib.sh
>   cmake: increase time-out for a long-running test

I've reviewed patches 1-3 & 5 and started looking over 4, but I'd like to
spend a bit more time on it (mostly to understand pros/cons of the
'GIT-BUILD-DIR' vs. any alternatives). I'm planning to finish that up
tomorrow.

Thanks for your patience!

> 
>  .gitignore                          |  1 +
>  Makefile                            |  1 +
>  add-patch.c                         |  2 +-
>  contrib/buildsystems/CMakeLists.txt | 16 ++++++++--------
>  t/test-lib.sh                       | 11 ++++++++++-
>  5 files changed, 21 insertions(+), 10 deletions(-)
> 
> 
> base-commit: bbea4dcf42b28eb7ce64a6306cdde875ae5d09ca
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1320%2Fdscho%2Fctest-on-windows-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1320/dscho/ctest-on-windows-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1320
> 
> Range-diff vs v1:
> 
>  1:  9cf14984c0a ! 1:  e00cb37b98a cmake: align CTest definition with Git's CI runs
>      @@ Metadata
>       Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>       
>        ## Commit message ##
>      -    cmake: align CTest definition with Git's CI runs
>      +    cmake: make it easier to diagnose regressions in CTest runs
>       
>      -    In Git's CI runs, the Windows tests are run with `--no-bin-wrappers` and
>      -    `--no-chain-lint`, mainly to win back some time caused by the serious
>      -    performance penalty paid for the tests relying so heavily on POSIX shell
>      -    scripting, which only works by using a POSIX emulation layer.
>      +    When a test script fails in Git's test suite, the usual course of action
>      +    is to re-run it using options to increase the verbosity of the output,
>      +    e.g. `-v` and `-x`.
>       
>      -    Let's do the same when running the tests, say, in Visual Studio.
>      +    Like in Git's CI runs, when running the tests in Visual Studio via the
>      +    CTest route, it is cumbersome or at least requires a very unintuitive
>      +    approach to pass options to the test scripts.
>       
>      -    While at it, enable the command trace via `-x` and verbose output via
>      -    `-v`, otherwise it would be near impossible to diagnose any problems.
>      +    So let's just pass those options by default: This will not clutter any
>      +    output window but the log that is written to a log file will have
>      +    information necessary to figure out test failures.
>      +
>      +    While at it, also imitate what the Windows jobs in Git's CI runs do to
>      +    accelerate running the test scripts: pass the `--no-bin-wrappers` and
>      +    `--no-chain-lint` options. This makes the test runs noticeably faster
>      +    because the `bin-wrappers/` scripts as well as the `chain-lint` code
>      +    make heavy use of POSIX shell scripting, which is really, really slow on
>      +    Windows due to the need to emulate POSIX behavior via the MSYS2 runtime.
>       
>           Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>       
>  2:  86ab58b6508 = 2:  de7b47a9aa7 cmake: copy the merge tools for testing
>  3:  79abfa82c32 < -:  ----------- tests: explicitly skip `chmod` calls on Windows
>  4:  4d24a4345ba ! 3:  f96d5ab484c add -p: avoid ambiguous signed/unsigned comparison
>      @@ Commit message
>           Let's avoid that by converting the unsigned bit explicitly to a signed
>           integer.
>       
>      +    Note: This is a long-standing bug in the Visual C build of Git, but it
>      +    has never been caught because t3701 is skipped when `NO_PERL` is set,
>      +    which is the case in the `vs-test` jobs of Git's CI runs.
>      +
>           Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>       
>        ## add-patch.c ##
>  5:  c7fc5a4ee4c = 4:  22473d6b8f3 cmake: avoid editing t/test-lib.sh
>  -:  ----------- > 5:  6aaa675301c cmake: increase time-out for a long-running test
> 

