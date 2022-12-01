Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91ECBC4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 16:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiLAQs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 11:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiLAQsl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 11:48:41 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E2F1CFCE
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 08:48:40 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id h4-20020a1c2104000000b003d0760654d3so2960618wmh.4
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 08:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72byoEvLzti9PgusAYrtDaiItKSC52xrvDvwDqY8Wuk=;
        b=DZzsnMvsT2QjSab5R/OMl0izrUQgvxGxSq3+8LJSxqf01QYmJb2vzkwwv8Wfkd0lxk
         tawj76pV+tSQAApVV5K0dtbngzESPXvHAt5LTvycXdmdgVn+qWgdcvYsPHCgjdCipNLc
         EmyKtBkuGUcGkjDrkZ0GA9EziqSTNR4URUjBj3E/PAAi9Yc4On5r3F7Lysu47xbRtVsW
         lqL2qutjmL4s/mA1gTEt0y/7HGrZHippZnuIynfRYs36sw43qpnH+0AsPIT0myOtlLM8
         xpgz04a4DlPA3d90z+LB1jPSlRER6c++T+kfuwMCFVC6ByKdi+GdCyHZN6zqqk5vzXBD
         8cDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72byoEvLzti9PgusAYrtDaiItKSC52xrvDvwDqY8Wuk=;
        b=Y+zpaWgvpdb4yUXArcw0HcDz+E4XSZLDtNzAOF5SnP6m6kDJmvYNLrL9OrvQJ8LQz2
         p/EvT+DDALzpOAhEg85puM/cKRqB9h1FMWqeJvQ3qY0Co7t1Ua6BoUTLldiV2sA+1+Vb
         AhbEUCJRc0FTTiYuPDvqZIR5+flQZOMhsyOiyAyhwSyJ7qHLrGL9sViICQyiLkxu4JFq
         NF1FZyI5Rf8f40em45TYSvxWK9tr27aTu4B73XQZb+iKXXAyG3HTDoBYTyUz+v+hFcpD
         Pbmq+OiKLaRFQh1fbiIO/zKIf81seCjg/wwyEKzGChjsmfmnaBDKpcsS63g4dBnc4dUZ
         BNYQ==
X-Gm-Message-State: ANoB5pmZI8zzgS+tb3/18rNIf4130Fx8QnlST61P+wojAvpyuMpgU7hv
        bwbvUHIAL9jM98w2VDgveoI=
X-Google-Smtp-Source: AA0mqf7HvvpE2bTPv13E2OCHvSUCPQ8FbZtZlBx19gJO5YMqvwtESyJWQ08YiqluOskBdWU6afwoHw==
X-Received: by 2002:a1c:f015:0:b0:3cf:7818:b123 with SMTP id a21-20020a1cf015000000b003cf7818b123mr52944931wmb.8.1669913318739;
        Thu, 01 Dec 2022 08:48:38 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id j33-20020a05600c1c2100b003b4ff30e566sm10861601wms.3.2022.12.01.08.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 08:48:38 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <9c6400ce-6f71-6f1c-dd7e-719c7181fe83@dunelm.org.uk>
Date:   Thu, 1 Dec 2022 16:48:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] test-lib.sh: discover "git" in subdirs of
 "contrib/buildsystems/out"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
 <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
Content-Language: en-US
In-Reply-To: <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/12/2022 16:39, Ævar Arnfjörð Bjarmason wrote:
> Fix a regression in [1] and discover git built by cmake in subdirs of
> "contrib/buildsystems/out", in addition to the "out" directory itself.

How do you propose to find the most recent build? There are different 
directories for different architectures and different directories for 
debug and release builds.

Hard coding the build directory is a bad idea and should be dropped.

Best Wishes

Phillip


> As noted in [2] the default for Visual Studio is to use
> "out/build/<config>", where "<config>" is a default configuration
> name. We might be able to make this deterministic in the future with a
> "CMakePresets.json", but that facility is newer than our oldest
> supported CMake and VS version.
> 
> 1. 16a5421a654 (Makefile + cmake: use environment, not GIT-BUILD-DIR,
>     2022-11-03)
> 2. https://learn.microsoft.com/en-us/cpp/build/cmake-projects-in-visual-studio?view=msvc-170
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> On Thu, Dec 01 2022, Phillip Wood wrote:
> 
>> On 30/11/2022 10:16, Ævar Arnfjörð Bjarmason wrote:
>>> On Wed, Nov 30 2022, Phillip Wood wrote:
>>>
>>>> Hi Junio
>>> Hi, and thanks for your review of this series.
>>>
>>>> On 29/11/2022 09:40, Junio C Hamano wrote:
>>>>> * ab/cmake-nix-and-ci (2022-11-04) 14 commits
>>>>>      (merged to 'next' on 2022-11-08 at 6ef4e93b36)
>>>>>     + CI: add a "linux-cmake-test" to run cmake & ctest on linux
>>>>>     + cmake: copy over git-p4.py for t983[56] perforce test
>>>>>     + cmake: only look for "sh" in "C:/Program Files" on Windows
>>>>>     + cmake: increase test timeout on Windows only
>>>>>     + cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
>>>>>     + Makefile + cmake: use environment, not GIT-BUILD-DIR
>>>>>     + test-lib.sh: support a "GIT_TEST_BUILD_DIR"
>>>>>     + cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
>>>>>     + cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
>>>>>     + cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
>>>>>     + cmake: don't copy chainlint.pl to build directory
>>>>>     + cmake: update instructions for portable CMakeLists.txt
>>>>>     + cmake: use "-S" and "-B" to specify source and build directories
>>>>>     + cmake: don't invoke msgfmt with --statistics
>>>>>     Fix assorted issues with CTest on *nix machines.
>>
>> Junio please drop this series when you rebuild next as it breaks
>> manually running individual test scripts when building with Visual
>> Studio.
> 
> I think the issue you've spotted is easily fixed on top. See below.
> 
>>>> If that's all this series did then I think it would be fine. However
>>>> it also makes changes to test-lib.sh to hard code the build directory
>>>> in an attempt to remove GIT-BUILD-DIR. I'm not convinced that is an
>>>> improvement on the status quo.
>>> I think the series as it stands addresses those concerns. In
>>> particular
>>> building outside of contrib/buildsystems/out works, just as before:
>>> 	cmake -S contrib/buildsystems -B /tmp/git-build
>>> -DCMAKE_BUILD_TYPE=Debug &&
>>>           make -C /tmp/git-build &&
>>>           ctest --test-dir /tmp/git-build -R t0001
>>> Per [1] and [2] which added the "ctest" support that's the use-case
>>> for
>>> this part of the build: running the tests with ctest, which works as
>>> before with the default or custom directories.
>>> Perhaps the reason this has been a sticking point for you is that in
>>> summarizing this, Johannes's [3] didn't make that distinction between
>>> running the tests with "ctest" and running them manually by entering the
>>> "t/" directory after the build. I.e.:
>>
>> In other words Johannes thinks both are equally important. The windows
>> build has always supported running the tests manually from /t and he
>> quite reasonable wants that to continue working.
> 
> Yes, that should work. Now, clearly I missed that VS doesn't use "out"
> by default, but a subdirectory, which the below patch fixes.
> 
> But I think we can still draw a distinction between anything under
> "out" and arbitrary user-supplied directories, which can possibly be
> located outside of the source tree.
> 
>>> 	(cd t && ./t0001-init.sh)
>>> It's only that part which acts differently in this series. I.e. if
>>> you
>>> were to build in /tmp/git-build this would no longer find your built
>>> assets:
>>> 	$ ./t0001-init.sh
>>> 	error: GIT-BUILD-OPTIONS missing (has Git been built?).
>>> If you just leave it at the default of "contrib/buildsystems/out"
>>> it'll
>>> work:
>>> 	(cd t && ./t0001-init.sh)
>>> 	ok 1 [...]
>>> I think my [4] convincingly makes the case that nobody will
>>> care. I.e. as the [5] it links to the use-case for running the test
>>> after the build without ctest was ("[...]" insert is mine):
>>> 	[To build and test with VS] open the worktree as a folder, and
>>> 	Visual Studio will find the `CMakeLists.txt` file and
>>> 	automatically generate the project files.
>>> I.e. we want to support the user who builds with that method, and
>>> runs
>>> the tests manually. I think you're worrying about an edge case that
>>> nobody's using in practice.
>>
>> You seem to be assuming that Visual Studio creates its build artifacts
>> in contrib/buildsystems/out based on a gitignore rule. Given the rule
>> ignores _all_ subdirectories below contrib/buildsystems/out that is a
>> big assumption. Despite me repeatedly raising concerns about the hard
>> coded build directory you do not seem to have checked exactly where
>> Visual Studio creates its build artifacts.
> 
> I did check, but I got it wrong from reading the docs & commit message.
> 
> I don't have a local Windows or VS setup. Thanks for testing it.
> 
>> This morning I installed
>> Visual Studio to check this and discovered the build is in a
>> subdirectory below contrib/buildsystems/out so this series will break
>> manual test runs for anyone building git using the recommend method. I
>> find it rather frustrating that you argue below that Windows specific
>> knowledge and testing are not required when you're altering the
>> Windows build.
> 
> I was saying that you could round-trip test the auto-discovery of the
> build directory on *nix.
> 
> Now, clearly I missed the "in a subdir of out" case. But that's
> separate from whether you can test that case cross-platform. With the
> below patch this works:
> 
> 	cmake -S contrib/buildsystems -B contrib/buildsystems/out/a/b/c -DCMAKE_BUILD_TYPE=Debug &&
> 	make -C contrib/buildsystems/out/a/b/c &&
> 	(cd t && ./t0071-sort.sh)
> 
> But did this work for you before, and does it work on "master"? I
> think this never worked out of the box until my series. I.e. if you do
> that on v2.38.0 (before "js/cmake-updates") you'll get:
> 
> 	$ ./t0071-sort.sh
> 	error: GIT-BUILD-OPTIONS missing (has Git been built?).
> 
> The reason is that before "js/cmake-updates" the part of the cmake
> recipe that established the ling between the test-lib.sh and the
> cmake-built tree was contingent on running ctest. E.g.:
> 
> 	ctest --test-dir contrib/buildsystems/out/a/b/c -R t0071
> 
> Once you did that it would patch your t/test-lib.sh:
> 	
> 	diff --git a/t/test-lib.sh b/t/test-lib.sh
> 	index a65df2fd220..70b0a633e4c 100644
> 	--- a/t/test-lib.sh
> 	+++ b/t/test-lib.sh
> 	@@ -44,1 +44,1 @@ fi
> 	-GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
> 	+GIT_BUILD_DIR="$TEST_DIRECTORY/../contrib/buildsystems/out/a/b/c"
> 
> Likewise, with "js/cmake-updates" it also doesn't work after you
> *build*. I. with it it would create a "GIT-BUILD-DIR" file, but only
> once ctest is run. I.e.:
> 
> 	(cd t && ./t0071-sort.sh);
> 	file GIT-BUILD-DIR;
> 	ctest --test-dir contrib/buildsystems/out/a/b/c -R t0071
> 	file GIT-BUILD-DIR;
> 	(cd t && ./t0071-sort.sh)
> 
> Would emit:
> 
> 	error: GIT-BUILD-OPTIONS missing (has Git been built?).
> 	GIT-BUILD-DIR: cannot open `GIT-BUILD-DIR' (No such file or directory)
> 	<ctest output>
> 	GIT-BUILD-DIR: ASCII text, with no line terminators
> 	<test output>
> 
> It's only with my series that it started working wihout having to run
> "ctest". With the below the test-lib.sh will optimistically find the
> "git" in "contrib/buildsystems/out".
> 
> Does the VS integration run the equivalent of "ctest" by default?
> 
>   t/test-lib.sh | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index ce319c9963e..9c63ee428f2 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -57,9 +57,11 @@ if test -n "$GIT_TEST_BUILD_DIR"
>   then
>   	GIT_BUILD_DIR="$GIT_TEST_BUILD_DIR"
>   elif ! test -x "$GIT_BUILD_DIR/git" &&
> -     test -x "$GIT_BUILD_DIR/contrib/buildsystems/out/git"
> +     test -d "$GIT_BUILD_DIR/contrib/buildsystems/out"
>   then
> -	GIT_BUILD_DIR="$GIT_SOURCE_DIR/contrib/buildsystems/out"
> +	GIT_BUILD_OPTIONS="$(find "$GIT_BUILD_DIR/contrib/buildsystems/out" \
> +		-type f -name 'GIT-BUILD-OPTIONS')"
> +	GIT_BUILD_DIR="${GIT_BUILD_OPTIONS%/GIT-BUILD-OPTIONS}"
>   	GIT_AUTO_CONTRIB_BUILDSYSTEMS_OUT=t
>   
>   	# On Windows, we must convert Windows paths lest they contain a colon
> @@ -1646,7 +1648,7 @@ remove_trash_directory "$TRASH_DIRECTORY" || {
>   # anything using lib-subtest.sh
>   if test -n "$GIT_AUTO_CONTRIB_BUILDSYSTEMS_OUT" && test -t 1
>   then
> -	say "setup: had no ../git, but found & used cmake built git in ../contrib/buildsystems/out/git"
> +	say "setup: had no ../git, but found & used cmake built git in '$GIT_BUILD_DIR/git'"
>   fi
>   
>   remove_trash=t
