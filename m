Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58640C4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 14:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbiLAOXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 09:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiLAOXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 09:23:09 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189E2A473
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 06:23:04 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id bs21so2948614wrb.4
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 06:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=abxHIUtSIzIi+H4XQ3DHB8LKP/LbDVwVXOqd3YGnCXE=;
        b=MqWM7b4fhNhSDjcce5mqJCxv6wTPPKusvFwj9cC7P2+qseSrI6A2nUhf0v/XX/XDiA
         16+Z7ix027/Zpoe1Er5raBtoPGj41XW1ehfHxal1tBvCVay4oXrmDxRVpjTGaHXbwhVH
         kMZtkefRhHb9uZOFhidVFX+Fma0XYVxfGHQj9TYPma+uZiDyh1u6g4iT7u2aq9LzONC3
         9/MIPStnhPNIMfG2EjSCZ3LR5NMYHV9SGIHpL1nKAO4Wj1OLnjEDfTSr49yfjWNtfnPI
         ydSzxWJGMwqi4xDz6sgwiNlBfpGPsQU25s0jI1nZi5KXe/WvDrql3ZmuIND4gSn2lTN/
         iKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abxHIUtSIzIi+H4XQ3DHB8LKP/LbDVwVXOqd3YGnCXE=;
        b=TvWeAoixGHspd+FT9I37f3oAbJ1sDKlAWpfXhbPB3B+5wT6TmlTuHQq9Zw45VvOjEa
         pVcI2o83Odm72hw2ZxkWklw13seemBMxD8SQFzOjiyOPcFDybqbOVOs9H72f8TV5QOUM
         e5qr20Cz9WWm8KEjMNfTqJX+fe/RlRVblvYtNf1qv0ST9zvVZFWoXLnzI2WSlNjTJ0St
         urZGproDtUorpNIakIv0qQIlJzghcPBitmyyyZUcv/68bfXvnTypNKz8gmino7pBElIz
         ZyFZiGb3Zwce/uLRuKpQ2SrrEowyeW4w8KVVX85NPkhfNzx37a8pjEnZVH8XtHvOD5co
         dfhw==
X-Gm-Message-State: ANoB5pkRNEBs8lnGGLFJcMKv2r+0jO5ViMxTtDDjqNHTTPO+U70hfRUu
        8QdG8rPYnxVVpYyuzq8HbxM=
X-Google-Smtp-Source: AA0mqf6le55BGKxIXQ/xC5SRrFpUcZVe+j8r5dG/sFTyop+uij6Zbb1gpR3qhINRrvR+j2mlsrjxdA==
X-Received: by 2002:adf:b352:0:b0:242:153c:186e with SMTP id k18-20020adfb352000000b00242153c186emr10815966wrd.289.1669904582406;
        Thu, 01 Dec 2022 06:23:02 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id j1-20020a05600c1c0100b003cfd4e6400csm6469432wms.19.2022.12.01.06.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 06:23:01 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
Date:   Thu, 1 Dec 2022 14:23:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: ab/cmake-nix-and-ci (was Re: What's cooking in git.git (Nov 2022,
 #07; Tue, 29))
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <xmqqsfi22j67.fsf@gitster.g>
 <544fff8a-7d56-57a1-00a3-d1a9302e227c@dunelm.org.uk>
 <221130.86h6ygiuc0.gmgdl@evledraar.gmail.com>
In-Reply-To: <221130.86h6ygiuc0.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/11/2022 10:16, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Nov 30 2022, Phillip Wood wrote:
> 
>> Hi Junio
> 
> Hi, and thanks for your review of this series.
> 
>> On 29/11/2022 09:40, Junio C Hamano wrote:
>>> * ab/cmake-nix-and-ci (2022-11-04) 14 commits
>>>     (merged to 'next' on 2022-11-08 at 6ef4e93b36)
>>>    + CI: add a "linux-cmake-test" to run cmake & ctest on linux
>>>    + cmake: copy over git-p4.py for t983[56] perforce test
>>>    + cmake: only look for "sh" in "C:/Program Files" on Windows
>>>    + cmake: increase test timeout on Windows only
>>>    + cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
>>>    + Makefile + cmake: use environment, not GIT-BUILD-DIR
>>>    + test-lib.sh: support a "GIT_TEST_BUILD_DIR"
>>>    + cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
>>>    + cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
>>>    + cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
>>>    + cmake: don't copy chainlint.pl to build directory
>>>    + cmake: update instructions for portable CMakeLists.txt
>>>    + cmake: use "-S" and "-B" to specify source and build directories
>>>    + cmake: don't invoke msgfmt with --statistics
>>>    Fix assorted issues with CTest on *nix machines.

Junio please drop this series when you rebuild next as it breaks 
manually running individual test scripts when building with Visual Studio.

>> If that's all this series did then I think it would be fine. However
>> it also makes changes to test-lib.sh to hard code the build directory
>> in an attempt to remove GIT-BUILD-DIR. I'm not convinced that is an
>> improvement on the status quo.
> 
> I think the series as it stands addresses those concerns. In particular
> building outside of contrib/buildsystems/out works, just as before:
> 
> 	cmake -S contrib/buildsystems -B /tmp/git-build -DCMAKE_BUILD_TYPE=Debug &&
>          make -C /tmp/git-build &&
>          ctest --test-dir /tmp/git-build -R t0001
> 
> Per [1] and [2] which added the "ctest" support that's the use-case for
> this part of the build: running the tests with ctest, which works as
> before with the default or custom directories.
> 
> Perhaps the reason this has been a sticking point for you is that in
> summarizing this, Johannes's [3] didn't make that distinction between
> running the tests with "ctest" and running them manually by entering the
> "t/" directory after the build. I.e.:

In other words Johannes thinks both are equally important. The windows 
build has always supported running the tests manually from /t and he 
quite reasonable wants that to continue working.

> 	(cd t && ./t0001-init.sh)
> 
> It's only that part which acts differently in this series. I.e. if you
> were to build in /tmp/git-build this would no longer find your built
> assets:
> 
> 	$ ./t0001-init.sh
> 	error: GIT-BUILD-OPTIONS missing (has Git been built?).
> 
> If you just leave it at the default of "contrib/buildsystems/out" it'll
> work:
> 
> 	(cd t && ./t0001-init.sh)
> 	ok 1 [...]
> 
> I think my [4] convincingly makes the case that nobody will
> care. I.e. as the [5] it links to the use-case for running the test
> after the build without ctest was ("[...]" insert is mine):
> 
> 	[To build and test with VS] open the worktree as a folder, and
> 	Visual Studio will find the `CMakeLists.txt` file and
> 	automatically generate the project files.
> 
> I.e. we want to support the user who builds with that method, and runs
> the tests manually. I think you're worrying about an edge case that
> nobody's using in practice.

You seem to be assuming that Visual Studio creates its build artifacts 
in contrib/buildsystems/out based on a gitignore rule. Given the rule 
ignores _all_ subdirectories below contrib/buildsystems/out that is a 
big assumption. Despite me repeatedly raising concerns about the hard 
coded build directory you do not seem to have checked exactly where 
Visual Studio creates its build artifacts. This morning I installed 
Visual Studio to check this and discovered the build is in a 
subdirectory below contrib/buildsystems/out so this series will break 
manual test runs for anyone building git using the recommend method. I 
find it rather frustrating that you argue below that Windows specific 
knowledge and testing are not required when you're altering the Windows 
build.

Best Wishes

Phillip

>> As I mentioned previously [1] I think
>> the non-*nix related patches could do with a review from the windows
>> folks before this hits master.
> 
> I'd welcome another review of it, but at this point it's not for lack of
> waiting for interest from the CC'd Windows people.
> 
> Per the above I don't think any special Windows knowledge is really
> needed, just a reading of the above history & use-cases.
> 
> All of which I've been careful not to break, and which you can now
> simply test on *nix with this series, so no Windows-specific testing is
> needed anymore for this concern you're raising.
> 
> *If* we have someone that's been using this on Windows and e.g. building
> this in /tmp/git-build (or whatever the Windows equivalent) with a
> custom recipe all they'll need to have it work as before is:
> 
> 	GIT_TEST_BUILD_DIR=/tmp/git-build ./t0001-init.sh
> 
> I think nobody's straying off the golden path to do that, but if they
> are doing so and building in some custom directory they're already
> tweaking, just setting an environment variable doesn't seem like a big
> imposition.
> 
> The flip-side of that trade-off is (on both Windows and *nix) that the
> existing way to support the use-case has unintended side-effects, which
> the series improves:
> 
> * When we pick up the not-a-Makefile tree implicitly like this we'll
>    now emit a message telling you what git we're implicitly using.
> 
> * We no longer have edge cases where you can e.g. build with make, then
>    cmake, then run some "make" target that won't go through the path to
>    remove GIT-BUILD-DIR (e.g. changing "git.c" and "make git").
> 
>    Then when you run the tests you'll end up with a different git running
>    it than what you'd expect, i.e. the old stale cmake one.
> 
> Even that hypothetical user who's going to need to set
> "GIT_TEST_BUILD_DIR" would benefit from that, as they'd no longer
> accidentally flip-flop between the two if they ran "make" and wiped away
> the rather fragile link between the source directory & the linked-to
> cmake build directory.
> 
>> [1]
>> https://lore.kernel.org/git/64b91b29-bbcd-e946-1f20-c0a5be63d9b7@dunelm.org.uk/
>>
>>>    Will cook in 'next'.
>>>    source: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
> 
> 1. c4b2f41b5f5 (cmake: support for testing git with ctest, 2020-06-26)
> 2. 7f5397a07c6 (cmake: support for testing git when building out of the
>     source tree, 2020-06-26)
> 3. ee9e66e4e76 (cmake: avoid editing t/test-lib.sh, 2022-10-18)
> 4. 16a5421a654 (Makefile + cmake: use environment, not GIT-BUILD-DIR,
>     2022-11-03)
> 5. 3eccc7b99d4 (cmake: ignore files generated by CMake as run in Visual
>     Studio, 2020-09-25)
