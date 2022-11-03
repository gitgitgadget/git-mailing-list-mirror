Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC80EC4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 10:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiKCKDh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 06:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiKCKDe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 06:03:34 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D3D394
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 03:03:33 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so787570wmb.3
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 03:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tRL1xY8QULTQV/cXmOwJRlT8TqTZ0mcdyjRcrIMhFn8=;
        b=V3WJ3D8jMzStLgP07Nay3tWDwUt5usklN6BMoeDx3govqCk9GvsbodfR18XikHTXuB
         Y5pzBZnJUUJmzJLh1+VkfjxvHfeG5raWqsUQwocH83H8QDW/xPs9kfumb93X03WI7J6W
         FH5BS9klglRNICdnf01KLYc5jeioquK4hKrfCA3OjSknsqlsk8AB1zwNbheLQ++b2ACf
         JEcCpv9NVlYhCXDCNLfsd+yhC22MAOHdAY0ybRLQ01fwtSmm7k6w0poXOqw5pFtCg6Tk
         Gw3eannSc1jlouQueh8WJCx85N7oruMRazlmI3XR5o5idnm70dbuFjF1hDmWfjZpa3OK
         bZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRL1xY8QULTQV/cXmOwJRlT8TqTZ0mcdyjRcrIMhFn8=;
        b=HSLs4ENWW/OzOt2Qm77ewjrxdrPoO5JX4Ar/rKPGEZBiNUdZSNqJTmFFCvzYa9vKdu
         y8abEVdCgWbPlLftJBAnCtSE8YKKhJ22rQqkknFVrem9eWMaGqfRdRP1VD+/MpTnNqSp
         gLeG2ksjdUNUVBgWI0wGjdmOp6yImq+rMBXoGJo+fj0aD6ff+h1K+O7GTkIlv8VoKEGp
         RckVxcCGZlY9WHThJQQ9hMOafdfmDDN2sdSvZ0WgzuNqRonZy2YNO+MHysIO2lh8YTXf
         JgdYsrbawR+W51wKtUUJq3s5u3e678vJDDyRGmHMMxVwlXQSHpJszdBn5bjsZcV7H+fJ
         Enfw==
X-Gm-Message-State: ACrzQf0zvHr28TUttXOdwI0BC2FVMtV5R8Bwwx8ASL0gFABmqWRAO1/d
        //yJ41F1GlRpKeW0sHPTRe//VEO3Vuk=
X-Google-Smtp-Source: AMsMyM5igfl4maQF4epbILzhCxpLOTVAgWVnmfBkPK5rq75PtGRpTvuD2dW64IwT+qs40/t7qzJBuQ==
X-Received: by 2002:a05:600c:ad0:b0:3cf:692a:7f66 with SMTP id c16-20020a05600c0ad000b003cf692a7f66mr17542142wmr.200.1667469811443;
        Thu, 03 Nov 2022 03:03:31 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b003a83ca67f73sm910428wms.3.2022.11.03.03.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 03:03:31 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <4d6ff46f-afc1-62a6-923d-b793712a5276@dunelm.org.uk>
Date:   Thu, 3 Nov 2022 10:03:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 09/12] cmake: support GIT_TEST_OPTS, abstract away
 WIN32 defaults
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
References: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
 <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
 <patch-v3-09.12-8a660a2baa4-20221101T225022Z-avarab@gmail.com>
In-Reply-To: <patch-v3-09.12-8a660a2baa4-20221101T225022Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/11/2022 22:51, Ævar Arnfjörð Bjarmason wrote:
> The rationale for adding "--no-bin-wrappers" and "--no-chain-lint" in
> 2ea1d8b5563 (cmake: make it easier to diagnose regressions in CTest
> runs, 2022-10-18) was those options slowed down the tests considerably
> on Windows.
> 
> But since f31b6244950 (Merge branch 'yw/cmake-updates', 2022-06-07)
> and with the preceding commits cmake and ctest are not
> Windows-specific anymore.
> 
> So let's set those same options by default on Windows, but do so with
> the set() facility. As noted in cmake's documentation[1] this
> integrates nicely with e.g. cmake-gui.

Shouldn't there a documentation string for the variable if you want to 
support cmake-gui?

> 
> On *nix we don't set any custom options. The change in 2ea1d8b5563
> didn't discuss why Windows should have divergent defaults with "cmake"
> and "make", but such reasons presumably don't apply on *nix. I for one
> am happy with the same defaults as the tests have when running via the
> Makefile.
> 
> With the "message()" addition we'll emit this when running cmake:
> 
> 	Generating hook-list.h
> 	-- Using user-selected test options: -vixd
> 	-- Configuring done
> 	-- Generating done
> 	-- Build files have been written to: /home/avar/g/git/contrib/buildsystems/out
> 
> Unfortunately cmake doesn't support a non-hacky way to pass variables
> to ctest without re-running cmake itself, so when re-running tests via
> cmake and wanting to change the test defaults we'll need:
> 
> 	GIT_TEST_OPTS=-i cmake -S contrib/buildsystems -B contrib/buildsystems/out &&
> 	ctest --jobs=$(nproc) --test-dir contrib/buildsystems/out -R t0071 --verbose

Rather than having to rerun cmake I think it would be nicer to use the 
shell to pass the test options when the tests are run so the user can 
set their preferred defaults when running cmake but override them with 
GIT_TEST_OPTIONS when running ctest as I showed previously.

> 1. https://cmake.org/cmake/help/latest/command/set.html#set-cache-entry
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   contrib/buildsystems/CMakeLists.txt | 46 +++++++++++++++++++++++++++--
>   1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index f0de37b35a1..6a3240d4ffa 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -49,7 +49,7 @@ To use this in Visual Studio:
>   
>   Open the worktree as a folder. Visual Studio 2019 and later will detect
>   the CMake configuration automatically and set everything up for you,
> -ready to build. You can then run the tests in `t/` via a regular Git Bash.
> +ready to build. See "== Running the tests ==" below for running the tests.
>   
>   Note: Visual Studio also has the option of opening `CMakeLists.txt`
>   directly; Using this option, Visual Studio will not find the source code,
> @@ -74,6 +74,35 @@ empty(default) :
>   
>   NOTE: -DCMAKE_BUILD_TYPE is optional. For multi-config generators like Visual Studio
>   this option is ignored
> +
> +== Running the tests ==
> +
> +Once we've built in "contrib/buildsystems/out" the tests can be run at
> +the top-level (note: not the generated "contrib/buildsystems/out/t/"
> +drectory). If no top-level build is found (as created with the
> +Makefile) the t/test-lib.sh will discover the git in
> +"contrib/buildsystems/out" on e.g.:
> +
> +	(cd t && ./t0001-init.sh)
> +	setup: had no ../git, but found & used cmake built git in ../contrib/buildsystems/out/git
> +	[...]
> +
> +The tests can also be run with ctest, e.g. after building with "cmake"
> +and "make" or "msbuild" run, from the top-level e.g.:
> +
> +	ctest --test-dir contrib/buildsystems/out --jobs="$(nproc)"--output-on-failure

CmakeLists.txt claims we only require v3.14 which does not appear to 
support --test-dir (see 
https://cmake.org/cmake/help/v3.14/manual/ctest.1.html)

> +Options can be passed by setting GIT_TEST_OPTIONS before invoking
> +cmake. E.g. on a Linux system with systemd the tests can be sped up by
> +using a ramdisk for the scratch files:

Doesn't the systemd wiki warn against using /run for things like this as 
to avoid running out of space. I thought our usual recommendation was to 
use --root=/dev/shm

> +	GIT_TEST_OPTS="--root=/run/user/$(id -u)/ctest" cmake -S contrib/buildsystems -B contrib/buildsystems/out
> +	[...]
> +	-- Using user-selected test options: --root=/run/user/1001/ctest
> +
> +Then running the tests with "ctest" (here with --jobs="$(nproc)"):

I think it would be helpful to show setting --jobs at configure time as 
it makes running the tests simpler.

> +	ctest --jobs=$(nproc) --test-dir contrib/buildsystems/out
>   ]]
>   cmake_minimum_required(VERSION 3.14)
>   
> @@ -1110,10 +1139,23 @@ endif()
>   
>   file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
>   
> +string(COMPARE NOTEQUAL "$ENV{GIT_TEST_OPTS}" "" HAVE_USER_GIT_TEST_OPTS)
> +if(HAVE_USER_GIT_TEST_OPTS)

if (DEFINED ENV{GIT_TEST_OPTS}) ?

> +	set(GIT_TEST_OPTS "$ENV{GIT_TEST_OPTS}")
> +	message(STATUS "Using user-selected test options: ${GIT_TEST_OPTS}")
> +elseif(WIN32)
> +	set(GIT_TEST_OPTS "--no-bin-wrappers --no-chain-lint -vx")
> +	message(STATUS "Using Windowns-specific default test options: ${GIT_TEST_OPTS}")
> +else()
> +	set(GIT_TEST_OPTS "")

I'd like to see us setting -vx here so users get debugging logs

> +	message(STATUS "No custom test options selected, set e.g. GIT_TEST_OPTS=\"-vixd\"")
> +endif()
> +separate_arguments(GIT_TEST_OPTS)

What rules does this use for separating arguments?

Best Wishes

Phillip

>   #test
>   foreach(tsh ${test_scipts})
>   	add_test(NAME ${tsh}
> -		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
> +		COMMAND ${SH_EXE} ${tsh} ${GIT_TEST_OPTS}
>   		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
>   	set_property(TEST ${tsh} APPEND PROPERTY ENVIRONMENT
>   		GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR})
