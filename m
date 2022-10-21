Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD700C4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 14:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiJUOSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 10:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiJUOSb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 10:18:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B50427C979
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 07:18:27 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w18so5044941wro.7
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 07:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vJmxpjjv8kWqiLgt/iJuvgUAQUSmDewkDEQciGi0p/E=;
        b=lMALMYKCF5oQme8stmL8sNeb13JYh8nogHdHGK80PaGQS7ssDoBx2jtOtODRnSZGtH
         P1T429l6ky4LwLRXUmOQI6nyZ0PggXlFNszXObOCJ3FcJXoMIxcK0deaxXv9ulm8T95O
         nRmzw5HJXkO9KLGSbiSx8JbbEa5w/OuPkAB6z/G8u6t22GOZQTT9htcVg0EEUDiS+3+3
         c7dZcNHsa5IUfPGeybUiGdAI2HnZvpxCAZnlc8a/iVeD8oFc0sZdiTNCnAXtapcdz1bg
         ++IPF5TzAhhos+f3dMfEgm6ojAZg3PKQqdht6dvGRHGpxBlm4W+H/mvqxBl8J6uexjW6
         ApNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJmxpjjv8kWqiLgt/iJuvgUAQUSmDewkDEQciGi0p/E=;
        b=1OgRn8Vs55arXFsXsKtZSKLV9FOGJ+N5WFKC5sCIIeqkFNaW7Q03P3mhEyufo7TtV1
         XQm3HL3RiL3f18EsJb3nquLSajUJZskeIamqKLc1IhyUOU7feM0nuqPD09Bbmg6mjdBq
         8wZmEl7xgl86wS/ayV0uf3xYUCQMyDS43cQFw19obq7RWaPniD4ahs7/JifvZrb+b9wx
         1baWvNadspBbAKXzkjmUUWzfVy5H8JNyyZXdDlZRT0tjceqw99UVUn7stpNVc41LK7GP
         oa4CM8GIb0sWK+Di2XCuo+75lV46jw3CIqnXUo2PWIDFab1XwAh/KC7cwcnhdmIZEh+t
         6IKw==
X-Gm-Message-State: ACrzQf3UQTnMrnyF/5CNU6UM9kIfY6Zc+VsO3sq+QZg1leLalyr7bJOS
        8dAFxvzTV3SOPRAtmnHirPc=
X-Google-Smtp-Source: AMsMyM6iE9G+5WXGFNeG08bt9Ls1CRywzamqHEpVBQVnjQZQO6l4kPZc/zE91YFLSg54CI98+BYTqA==
X-Received: by 2002:a5d:5610:0:b0:236:50d5:e6ec with SMTP id l16-20020a5d5610000000b0023650d5e6ecmr3241077wrv.13.1666361905850;
        Fri, 21 Oct 2022 07:18:25 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id n32-20020a05600c502000b003c6d0f8c377sm2972320wmr.7.2022.10.21.07.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 07:18:25 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <d6e2baab-be26-66d1-f07c-134eb6fe06fd@dunelm.org.uk>
Date:   Fri, 21 Oct 2022 15:18:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 6/9] cmake: use GIT_TEST_BUILD_DIR instead of editing hack
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
 <patch-6.9-45f1a4e6f93-20221021T091013Z-avarab@gmail.com>
In-Reply-To: <patch-6.9-45f1a4e6f93-20221021T091013Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 21/10/2022 10:44, Ævar Arnfjörð Bjarmason wrote:
> When cmake builds git in "contrib/buildsystems/out" it will create a
> "t/" directory there containing only the "t/helper/test-tool", but for
> running the tests with "cmake" it cd's to the "real" t/ directory, and
> runs the tests from there.
> 
> To get the test-lib.sh to locate "git" and other binaries in
> "../contrib/buildsystems/out/" rather than "../" we have since [1]
> been editing the "GIT_BUILD_DIR" assignment in test-lib.sh in-place.
> 
> This has meant that when testing cmake we've had to "git reset --hard"
> before running "make" again.
> 
> What this build infrastructure really wanted was some feature like the
> "GIT_TEST_BUILD_DIR" variable added in the preceding commit, so let's
> make use of it.

Lets squash that commit into this one, so we can see how it is used when 
it is added.

> Even though "ctest" will work with this approach, one advantage of the
> previous arrangement was that we could:
> 
> 	A. Build with cmake
> 	B. cd t
> 	C. Run a test
> 
> And have the test itself know to locate and use the cmake binaries,
> this workflow was documented in [2]. The "t/test-lib".sh modification
> here is so that we can support this use-case.
> 
> As [3] notes "contrib/buildsystems/out" isn't just the directory that
> happens to be documented in "contrib/buildsystems/CMakeLists.txt", but
> the one that VS will use when building git.

That may be the directory that VS uses when building git, but it is 
possible to specify a different build directory when running cmake.

> To make it clear what's happening we emit a "setup: " from the
> test-lib.sh to note that we used this fallback method:
> 
> 	$ ./t0001-init.sh
> 	setup: had no ../git, but found & used cmake built git in ../contrib/buildsystems/out/git
> 	ok 1 - plain
> 	[...]
> 
> Note: the "On Windows[...]" part of this is lifted from [4].
> 
> 1. 7f5397a07c6 (cmake: support for testing git when building out of
>     the source tree, 2020-06-26)
> 2. f2f1250c47f (cmake (Windows): recommend using Visual Studio's
>     built-in CMake support, 2020-09-30)
> 3. 3eccc7b99d4 (cmake: ignore files generated by CMake as run in
>     Visual Studio, 2020-09-25)
> 4. https://lore.kernel.org/git/5b0c2a150e9fce1ca0284d65628b42ed5a7aad9a.1666090745.git.gitgitgadget@gmail.com/
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   contrib/buildsystems/CMakeLists.txt | 15 +--------------
>   t/test-lib.sh                       | 19 +++++++++++++++++++
>   2 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 725b3f2ac82..91b7009f4fd 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -1080,25 +1080,12 @@ if(USE_VCPKG)
>   	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
>   endif()
>   
> -#Make the tests work when building out of the source tree
> -get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMakeCache.txt ABSOLUTE)
> -if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
> -	file(RELATIVE_PATH BUILD_DIR_RELATIVE ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/CMakeCache.txt)
> -	string(REPLACE "/CMakeCache.txt" "" BUILD_DIR_RELATIVE ${BUILD_DIR_RELATIVE})
> -	#Setting the build directory in test-lib.sh before running tests
> -	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
> -		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh GIT_BUILD_DIR_REPL REGEX \"GIT_BUILD_DIR=(.*)\")\n"
> -		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh content NEWLINE_CONSUME)\n"
> -		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=\\\"$TEST_DIRECTORY/../${BUILD_DIR_RELATIVE}\\\"\" content \"\${content}\")\n"
> -		"file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
> -endif()
> -
>   file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
>   
>   #test
>   foreach(tsh ${test_scipts})
>   	add_test(NAME ${tsh}
> -		COMMAND ${SH_EXE} ${tsh}
> +		COMMAND env GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR} ${SH_EXE} ${tsh}

I'm not sure about using env on windows, can we use ${SH_EXE} -c instead 
to avoid creating an extra process?

	COMMAND ${SH_EXE} -c [[GIT_TEST_BUILD_DIR="$1"; . "$2"]] "${tsh}" 
"${CMAKE_BINARY_DIR}" "${tsh}"

>   		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
>   endforeach()
>   
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 41b1ddc96ff..284b619708a 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -47,9 +47,21 @@ fi
>   # its build directory.
>   GIT_SOURCE_DIR="${TEST_DIRECTORY%/t}"
>   GIT_BUILD_DIR="$GIT_SOURCE_DIR"
> +GIT_AUTO_CONTRIB_BUILDSYSTEMS_OUT=
>   if test -n "$GIT_TEST_BUILD_DIR"
>   then
>   	GIT_BUILD_DIR="$GIT_TEST_BUILD_DIR"
> +elif ! test -x "$GIT_BUILD_DIR/git" &&
> +     test -x "$GIT_BUILD_DIR/contrib/buildsystems/out/git"

I'm really not keen on hard coding the CMAKE_BINARY_DIR. One of the 
positive things about dscho's approach is that it does not hard code the 
build directory. I'm not convinced this approach is an improvement.

Best Wishes

Phillip

> +then
> +	GIT_BUILD_DIR="$GIT_SOURCE_DIR/contrib/buildsystems/out"
> +	GIT_AUTO_CONTRIB_BUILDSYSTEMS_OUT=t
> +	# On Windows, we must convert Windows paths lest they contain a colon
> +	case "$(uname -s)" in
> +	*MINGW*)
> +		GIT_BUILD_DIR="$(cygpath -au "$GIT_BUILD_DIR")"
> +		;;
> +	esac
>   fi
>   
>   if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
> @@ -1630,6 +1642,13 @@ remove_trash_directory "$TRASH_DIRECTORY" || {
>   	BAIL_OUT 'cannot prepare test area'
>   }
>   
> +# Emitting this now because earlier we didn't have "say", but not in
> +# anything using lib-subtest.sh
> +if test -n "$GIT_AUTO_CONTRIB_BUILDSYSTEMS_OUT" && test -t 1
> +then
> +	say "setup: had no ../git, but found & used cmake built git in ../contrib/buildsystems/out/git"
> +fi
> +
>   remove_trash=t
>   if test -z "$TEST_NO_CREATE_REPO"
>   then
