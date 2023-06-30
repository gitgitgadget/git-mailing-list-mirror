Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFE1EB64D7
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 14:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjF3OIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 10:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjF3OIG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 10:08:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F01D2D5B
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 07:08:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98e39784a85so332547766b.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 07:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688134083; x=1690726083;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=usYaPbW/PQ4/zQzoXXvQ6ice2LR5voRVA9h5NCJ94Fs=;
        b=ivcoIQ758LXIRNyhHtDpX7BHL3NXPV2RP0XabYiHhmCXiPDP7Bo0wMyqxuidpNHDAk
         4h1NCEyTDwTTMLuwbQfdC/03H3DkMs9ZdlcjG2mn4cWxKXcE8TIgvNnbJ1ZHB8ytgFwd
         aK25NU+pKlOcuVJq0f41HoIpBBNjYiUVADc27uS2u1e7J1uvEVMxF8NhxKvvKLALn/Jf
         KDe3+VQCoeWU7nTJJXMzvjmoK/Tx24lwt3ldSA/76QxNnUzPc6KLAREyMaCptcRDhTyh
         Cgah941IHma+V8KPZ6fy6CuT9AB7pXxxwaIihuOkPd/cFejxRzDsB1q7lSBglhUD1KzL
         JCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688134083; x=1690726083;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usYaPbW/PQ4/zQzoXXvQ6ice2LR5voRVA9h5NCJ94Fs=;
        b=itlkdWelUYEyqKYkHTFnEdRS2FfFcG5rDr3jn2guBMe54mDwFpInYRI+jYZL+PIVUC
         NeXd3fXg3ZlQV5BbuH3i69lXDA9lnk7Z1Hu0GS2CH8u2DfHgw9L+JFqpkbhXKMwz15gy
         SYXM1fz2MMvLd00Gs4R69NyrMG2nFJSfuhzED8Rmz6hC3DHcL9+FyJef7A6GtkCorRyv
         ho1kKYT9Y2SuqiRclksBkdVOFcuLt+2KMV9ETumwZtxDRIETnUqfIL1QVYNnVeJhozkm
         EVdZNVU6Q5jUHGc05TU8WZhW2O/fu4617UTxXPwWoFf/2k5NhHFLfdsw3fAG6rWuyWQK
         SuCQ==
X-Gm-Message-State: AC+VfDw47gAgIuGlP8f8wm1apyxkX3uIXgY07y3Wc2RuW0EmGH6d2xtf
        6OVQIBUiqg0pKTaxxHhwoDo=
X-Google-Smtp-Source: ACHHUZ5bORvRgpb++M60bnOYxwXeBYD1qeXdwq86SmE7Y9lg496FlqmSbW5BXFfOfzc1TAlAkSOwaA==
X-Received: by 2002:a17:906:478a:b0:966:1bf2:2af5 with SMTP id cw10-20020a170906478a00b009661bf22af5mr6831790ejc.22.1688134082463;
        Fri, 30 Jun 2023 07:08:02 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906250a00b0096a6be0b66dsm8070272ejb.208.2023.06.30.07.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 07:08:01 -0700 (PDT)
Message-ID: <a99a5134-3bac-64d4-b4e7-f02e8578090a@gmail.com>
Date:   Fri, 30 Jun 2023 15:07:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [RFC PATCH v3 1/1] unit tests: Add a project plan document
Reply-To: phillip.wood@dunelm.org.uk
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     calvinwan@gmail.com, szeder.dev@gmail.com, chooglen@google.com,
        avarab@gmail.com, gitster@pobox.com, sandals@crustytoothpaste.net
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
 <8afdb215d7e10ca16a2ce8226b4127b3d8a2d971.1686352386.git.steadmon@google.com>
Content-Language: en-US
In-Reply-To: <8afdb215d7e10ca16a2ce8226b4127b3d8a2d971.1686352386.git.steadmon@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Josh

Thanks for putting this together, I think it is really helpful to have a 
comparison of the various options. Sorry for the slow reply, I was off 
the list for a couple of weeks.

On 10/06/2023 00:25, Josh Steadmon wrote:
> diff --git a/Documentation/technical/unit-tests.txt b/Documentation/technical/unit-tests.txt
> new file mode 100644
> index 0000000000..dac8062a43
> --- /dev/null
> +++ b/Documentation/technical/unit-tests.txt
> @@ -0,0 +1,141 @@
> += Unit Testing

I've deleted the sections I agree with to avoid quoting parts that are 
not relevant to my comments.

> +== Definitions
> +
> +For the purposes of this document, we'll use *test framework* to refer to
> +projects that support writing test cases and running tests within the context
> +of a single executable. *Test harness* will refer to projects that manage
> +running multiple executables (each of which may contain multiple test cases) and
> +aggregating their results.

Thanks for adding this, it is really helpful to have definitions for 
what we mean by "test framework" and "test harness" within the git 
project. It might be worth mentioning somewhere that we already use 
prove as a test harness when running our integration tests.

> +In reality, these terms are not strictly defined, and many of the projects
> +discussed below contain features from both categories.

> +
> +== Choosing a framework & harness
> +
> +=== Desired features
> +
> [...]
> +==== Parallel execution
> +
> +Ideally, we will build up a significant collection of unit tests cases, most
> +likely split across multiple executables. It will be necessary to run these
> +tests in parallel to enable fast develop-test-debug cycles.

This is a good point, though I think it is really a property of the 
harness rather than the framework so we might want to indicate in the 
table whether a framework provides parallelism itself or relies on the 
harness providing it.

 > [...]
> +==== Major platform support
> +
> +At a bare minimum, unit-testing must work on Linux, MacOS, and Windows.

I think we'd want to be able to run unit tests on *BSD and NonStop as 
well, especially as I think some of the platform dependent code probably 
lends itself to being unit tested. I suspect a framework that covers 
Linux and MacOS would probably run on those platforms as well (I don't 
think NonStop has complete POSIX support but it is hard to imagine a 
test framework doing anything very exotic)

> [...]
> +==== Mock support
> +
> +Unit test authors may wish to test code that interacts with objects that may be
> +inconvenient to handle in a test (e.g. interacting with a network service).
> +Mocking allows test authors to provide a fake implementation of these objects
> +for more convenient tests.

Do we have any idea what sort of thing we're likely to want to mock and 
what we want that support to look like?

> +==== Signal & exception handling
> +
> +The test framework must fail gracefully when test cases are themselves buggy or
> +when they are interrupted by signals during runtime.

I had assumed that it would be enough for the test harness to detect if 
a test executable was killed by a signal or exited early due to a bug in 
the test script. That requires the framework to have robust support for 
lazy test plans but I'm not sure that we need it to catch and recover 
from things like SIGSEGV.

> +==== Coverage reports
> +
> +It may be convenient to generate coverage reports when running unit tests
> +(although it may be possible to accomplish this regardless of test framework /
> +harness support).

I agree this would be useful, though perhaps we should build it on our 
existing gcov usage.

Related to this do we want timing reports from the harness or the framework?

> +
> +=== Comparison
> +
> +[format="csv",options="header",width="75%"]
> +|=====
> +Framework,"TAP support","Diagnostic output","Parallel execution","Vendorable / ubiquitous","Maintainable / extensible","Major platform support","Lazy test planning","Runtime- skippable tests","Scheduling / re-running",Mocks,"Signal & exception handling","Coverage reports"
> +https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.com/[Custom Git impl.],[lime-background]#True#,[lime-background]#True#,?,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,?,?,[red-background]#False#,?,?
> +https://cmocka.org/[cmocka],[lime-background]#True#,[lime-background]#True#,?,[red-background]#False#,[yellow-background]#Partial#,[yellow-background]#Partial#,[yellow-background]#Partial#,?,?,[lime-background]#True#,?,?
> +https://libcheck.github.io/check/[Check],[lime-background]#True#,[lime-background]#True#,?,[red-background]#False#,[yellow-background]#Partial#,[lime-background]#True#,[yellow-background]#Partial#,?,?,[red-background]#False#,?,?
> +https://github.com/rra/c-tap-harness/[C TAP],[lime-background]#True#,[red-background]#False#,?,[lime-background]#True#,[yellow-background]#Partial#,[yellow-background]#Partial#,[yellow-background]#Partial#,?,?,[red-background]#False#,?,?
> +https://github.com/silentbicycle/greatest[Greatest],[yellow-background]#Partial#,?,?,[lime-background]#True#,[yellow-background]#Partial#,?,[yellow-background]#Partial#,?,?,[red-background]#False#,?,?
> +https://github.com/Snaipe/Criterion[Criterion],[lime-background]#True#,?,?,[red-background]#False#,?,[lime-background]#True#,?,?,?,[red-background]#False#,?,?
> +https://github.com/zorgnax/libtap[libtap],[lime-background]#True#,?,?,?,?,?,?,?,?,?,?,?
> +https://nemequ.github.io/munit/[µnit],?,?,?,?,?,?,?,?,?,?,?,?
> +https://github.com/google/cmockery[cmockery],?,?,?,?,?,?,?,?,?,[lime-background]#True#,?,?
> +https://github.com/lpabon/cmockery2[cmockery2],?,?,?,?,?,?,?,?,?,[lime-background]#True#,?,?
> +https://github.com/ThrowTheSwitch/Unity[Unity],?,?,?,?,?,?,?,?,?,?,?,?
> +https://github.com/siu/minunit[minunit],?,?,?,?,?,?,?,?,?,?,?,?
> +https://cunit.sourceforge.net/[CUnit],?,?,?,?,?,?,?,?,?,?,?,?
> +https://www.kindahl.net/mytap/doc/index.html[MyTAP],[lime-background]#True#,?,?,?,?,?,?,?,?,?,?,?
> +|=====

Thanks for going through these projects, hopefully we can use this 
information to make a decision on a framework soon.

Best Wishes

Phillip
