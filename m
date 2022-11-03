Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A75EC43217
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 16:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiKCQCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiKCQBt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 12:01:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149AA1C420
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 08:59:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bj12so6405348ejb.13
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ePeXmDn7iB0EQXyzD/WJiCjsJyvcwlnGMwIiW+737XE=;
        b=bbp9Vlp1aMg5ZuZebQ5tPj52f19SPY6nrVvAtmuOEX3XvDL6YXwfDmJXKE1TleEDK5
         xrPVdCCurqBsSpNbJ5IR3Bl1lVFLOPFDzsvgrQt2mxvnp1vhOwlOC/6JD2wzj/KCMspT
         p0yCxaG7gNXCOLf4tx1wUwvlTj/5r0ibl1pllkxieyxj/WjN/43YZdqQqQFc8IpHQJI+
         UNrkGfS4cachUTThKAVZejl9agqSMEhesFa29HjnMpMZ2GmMI4JLhnvFdRdBYqo/BphQ
         0C8dAp1zvKZi777XT+OHt0SD4OCc3pDAMBNjhn7PXeW/3/Lkayn009AjrnQ5FZYXVmg7
         Cz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePeXmDn7iB0EQXyzD/WJiCjsJyvcwlnGMwIiW+737XE=;
        b=wH8DOmBX68SExJdamvBuKTj8ohAaW0Brvl78EH/4I50wtanjPMBOHRS+V5+j85yF44
         SJuxeNUiRpStjylkKq1oMs3pN7+euvZ65UQVOm3Qlwt5Q1JkP2iH7ochawECjp7/L9vF
         Q+1tZHQYJfNY89i4wz7bzKIepIyMNijGQkOpuprmhk4Til1IYWmxE7T6LLajBs1jfwM1
         bciE81+YyNe3iuileAECj5Q2gP/5iK2FURiYiRTK99P4E9C7e3KTaU+FhA1dvEWNreqs
         F5CFjNq49KcQ7+cda4car8p6G8HuyhmEnbBwKCI2cmkwNKbxc/tsWbpzequzvb9fIqt1
         yyxQ==
X-Gm-Message-State: ACrzQf0UtGi6OgBWKrDQ500Ak6Rx1T5lBjU8pVAE0Y0rYunU+J+0k2nr
        nnBmle8LkZD9qQ3usTZlAfA=
X-Google-Smtp-Source: AMsMyM4b8T2jeh7vLZJqu+1os0+TGjS4uqobDiNAp6ftltN/65dNnHyNe4WkWBE0YX2GXyJSgSCH8w==
X-Received: by 2002:a17:907:845:b0:731:2f6c:6dbd with SMTP id ww5-20020a170907084500b007312f6c6dbdmr29422578ejb.551.1667491168449;
        Thu, 03 Nov 2022 08:59:28 -0700 (PDT)
Received: from gmgdl (j84064.upc-j.chello.nl. [24.132.84.64])
        by smtp.gmail.com with ESMTPSA id r16-20020aa7cfd0000000b0046150ee13besm662086edy.65.2022.11.03.08.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 08:59:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqccp-00CjrT-07;
        Thu, 03 Nov 2022 16:59:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH v3 09/12] cmake: support GIT_TEST_OPTS, abstract away
 WIN32 defaults
Date:   Thu, 03 Nov 2022 16:43:35 +0100
References: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
 <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
 <patch-v3-09.12-8a660a2baa4-20221101T225022Z-avarab@gmail.com>
 <4d6ff46f-afc1-62a6-923d-b793712a5276@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <4d6ff46f-afc1-62a6-923d-b793712a5276@dunelm.org.uk>
Message-ID: <221103.86a6581129.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 03 2022, Phillip Wood wrote:

> On 01/11/2022 22:51, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> The rationale for adding "--no-bin-wrappers" and "--no-chain-lint" in
>> 2ea1d8b5563 (cmake: make it easier to diagnose regressions in CTest
>> runs, 2022-10-18) was those options slowed down the tests considerably
>> on Windows.
>> But since f31b6244950 (Merge branch 'yw/cmake-updates', 2022-06-07)
>> and with the preceding commits cmake and ctest are not
>> Windows-specific anymore.
>> So let's set those same options by default on Windows, but do so
>> with
>> the set() facility. As noted in cmake's documentation[1] this
>> integrates nicely with e.g. cmake-gui.
>
> Shouldn't there a documentation string for the variable if you want to
> support cmake-gui?

Yeah, I missed that. Now I've actually tested it locally with cmake-gui,
and it works.

>> On *nix we don't set any custom options. The change in 2ea1d8b5563
>> didn't discuss why Windows should have divergent defaults with "cmake"
>> and "make", but such reasons presumably don't apply on *nix. I for one
>> am happy with the same defaults as the tests have when running via the
>> Makefile.
>> With the "message()" addition we'll emit this when running cmake:
>> 	Generating hook-list.h
>> 	-- Using user-selected test options: -vixd
>> 	-- Configuring done
>> 	-- Generating done
>> 	-- Build files have been written to: /home/avar/g/git/contrib/buildsyst=
ems/out
>> Unfortunately cmake doesn't support a non-hacky way to pass
>> variables
>> to ctest without re-running cmake itself, so when re-running tests via
>> cmake and wanting to change the test defaults we'll need:
>> 	GIT_TEST_OPTS=3D-i cmake -S contrib/buildsystems -B
>> contrib/buildsystems/out &&
>> 	ctest --jobs=3D$(nproc) --test-dir contrib/buildsystems/out -R t0071 --=
verbose
>
> Rather than having to rerun cmake I think it would be nicer to use the
> shell to pass the test options when the tests are run so the user can=20
> set their preferred defaults when running cmake but override them with
> GIT_TEST_OPTIONS when running ctest as I showed previously.

Yeah, I saw that, sorry about not directly addressing it. I tried it,
but in the end I think I'd rather narrow down the scope in this series.

I.e. before it's hardcoded with no way to change it, after you can set
it at build time.

cmake's model of viewing the world seems to really dislike the notion of
dynamically setting test options for whatever reason, it's a FAQ about
cmake/ctest. Your sh -c workaround is clever, and there's similar
workarounds e.g. on stackoverflow.

But let's pursue that separately, and just go for the "way cmake likes
it" in this series.

>> 1. https://cmake.org/cmake/help/latest/command/set.html#set-cache-entry
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>   contrib/buildsystems/CMakeLists.txt | 46 +++++++++++++++++++++++++++--
>>   1 file changed, 44 insertions(+), 2 deletions(-)
>> diff --git a/contrib/buildsystems/CMakeLists.txt
>> b/contrib/buildsystems/CMakeLists.txt
>> index f0de37b35a1..6a3240d4ffa 100644
>> --- a/contrib/buildsystems/CMakeLists.txt
>> +++ b/contrib/buildsystems/CMakeLists.txt
>> @@ -49,7 +49,7 @@ To use this in Visual Studio:
>>     Open the worktree as a folder. Visual Studio 2019 and later will
>> detect
>>   the CMake configuration automatically and set everything up for you,
>> -ready to build. You can then run the tests in `t/` via a regular Git Ba=
sh.
>> +ready to build. See "=3D=3D Running the tests =3D=3D" below for running=
 the tests.
>>     Note: Visual Studio also has the option of opening
>> `CMakeLists.txt`
>>   directly; Using this option, Visual Studio will not find the source co=
de,
>> @@ -74,6 +74,35 @@ empty(default) :
>>     NOTE: -DCMAKE_BUILD_TYPE is optional. For multi-config
>> generators like Visual Studio
>>   this option is ignored
>> +
>> +=3D=3D Running the tests =3D=3D
>> +
>> +Once we've built in "contrib/buildsystems/out" the tests can be run at
>> +the top-level (note: not the generated "contrib/buildsystems/out/t/"
>> +drectory). If no top-level build is found (as created with the
>> +Makefile) the t/test-lib.sh will discover the git in
>> +"contrib/buildsystems/out" on e.g.:
>> +
>> +	(cd t && ./t0001-init.sh)
>> +	setup: had no ../git, but found & used cmake built git in ../contrib/b=
uildsystems/out/git
>> +	[...]
>> +
>> +The tests can also be run with ctest, e.g. after building with "cmake"
>> +and "make" or "msbuild" run, from the top-level e.g.:
>> +
>> +	ctest --test-dir contrib/buildsystems/out --jobs=3D"$(nproc)"--output-=
on-failure
>
> CmakeLists.txt claims we only require v3.14 which does not appear to
> support --test-dir (see=20
> https://cmake.org/cmake/help/v3.14/manual/ctest.1.html)

Thanks, I missed that, updated docs etc. as appropriate in the incoming
re-roll.

>> +Options can be passed by setting GIT_TEST_OPTIONS before invoking
>> +cmake. E.g. on a Linux system with systemd the tests can be sped up by
>> +using a ramdisk for the scratch files:
>
> Doesn't the systemd wiki warn against using /run for things like this
> as to avoid running out of space. I thought our usual recommendation
> was to use --root=3D/dev/shm

Used /dev/shm in the updated docs.

>> +	GIT_TEST_OPTS=3D"--root=3D/run/user/$(id -u)/ctest" cmake -S contrib/b=
uildsystems -B contrib/buildsystems/out
>> +	[...]
>> +	-- Using user-selected test options: --root=3D/run/user/1001/ctest
>> +
>> +Then running the tests with "ctest" (here with --jobs=3D"$(nproc)"):
>
> I think it would be helpful to show setting --jobs at configure time
> as it makes running the tests simpler.

mm, you mean turn it into a set(...) variable? Sounds useful, or ideally
grabbing some pre-set cmake idea of the parallelism.

But for now I'd like to just leave it as "maybe try running this",
rather than integrate it into the whole cmake/ctest chain.

>> +	ctest --jobs=3D$(nproc) --test-dir contrib/buildsystems/out
>>   ]]
>>   cmake_minimum_required(VERSION 3.14)
>>   @@ -1110,10 +1139,23 @@ endif()
>>     file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
>>   +string(COMPARE NOTEQUAL "$ENV{GIT_TEST_OPTS}" ""
>> HAVE_USER_GIT_TEST_OPTS)
>> +if(HAVE_USER_GIT_TEST_OPTS)
>
> if (DEFINED ENV{GIT_TEST_OPTS}) ?

Thanks! That's much better.

>> +	set(GIT_TEST_OPTS "$ENV{GIT_TEST_OPTS}")
>> +	message(STATUS "Using user-selected test options: ${GIT_TEST_OPTS}")
>> +elseif(WIN32)
>> +	set(GIT_TEST_OPTS "--no-bin-wrappers --no-chain-lint -vx")
>> +	message(STATUS "Using Windowns-specific default test options: ${GIT_TE=
ST_OPTS}")
>> +else()
>> +	set(GIT_TEST_OPTS "")
>
> I'd like to see us setting -vx here so users get debugging logs

I think it might make sense to do that by default, but let's consider
that separately, and if we're going to do that we should set that
default for the t/Makefile (or t/test-lib.h), not just cmake.

The reason it has these settings now is because of Windows-specific
trade-offs in the already landed topic.

But since the topic of this series is to port it to run nicely on *nix I
don't see why we'd have it as a goal to have "cmake" / "ctest" behave
differently than "make" or "make test".

Except of course cases where some inherent differente between the
toolchains suggests that we should.

But in this case I don't see why that's the case, if I run a full
"ctest" run and have failures, I might wish I've got logs, but the same
goes for:

     make test GIT_TEST_OPTS=3D"--verbose-log -vx"

>> +	message(STATUS "No custom test options selected, set e.g. GIT_TEST_OPT=
S=3D\"-vixd\"")
>> +endif()
>> +separate_arguments(GIT_TEST_OPTS)
>
> What rules does this use for separating arguments?

Bad ones :( I've updated the commit message accordingly, but kept this,
I couldn't find some non-crappy way to e.g. handle spaces in parameters
on the cmake version we require.
