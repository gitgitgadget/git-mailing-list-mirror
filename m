Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0C9C04A95
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 13:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiJYNiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 09:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbiJYNiN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 09:38:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7F9192B9C
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 06:38:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j15so10524473wrq.3
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 06:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zOCtwU49OGhrZlkpCsLxkzfes8TRLTBcLsIXL9O97kA=;
        b=CGr1o3OSKxNYdn12nqCV8I8Jc970+k8hU0et2681/zgPcWa5uEbJEmrXJFXrvp42fQ
         Iy5mrOO0qVBGL7tGqdAz9mB4Nzdal7v4VATpk5sHPhFdKx11D4cP/bSRh73Lsi6S6nCD
         O9jIOQ0PPFwc+TrkDvvyxElpklLjaAlbt2fxaWt+UJB3wzG1Hjl03Jn29N3u0nXpjJii
         tzrf/KGjvnxA/MTUQm5cgV1DpLgXS39WkV4Pt2eEyXh1lGKX7bKWm8vDO6Lj7DxRACbH
         Qkc6uZYc9sBTFzaMbxU68rS273zUvv7GyKtSVJmil69CKN39+2DmYkzJouKjj9TrZtHz
         TqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOCtwU49OGhrZlkpCsLxkzfes8TRLTBcLsIXL9O97kA=;
        b=xAdrk/iD8Mupsl6WASPvJinVAgBveDSacDieRhGNprnBi5yZuS9QBv2adbyKga2Zh7
         NexepwZayIfKIuG5uF+JeY2srAtTOZWyE7nyl1LhwXub4qom36VwlZ3dIPofla+iOYRm
         tCxTDdd/c4iggw3JjS1MDjmh4UDjJ90Hzbl5n96Vdye1lWGVgadLv5xxTIdzPwZ1hRAh
         LPsV9nOXXMuc1YTAbU9paxpkh5fC4qN1Z7zX7SX6XwndRRVJhK0zIONlPeRH0Filfg3c
         u7XIbRu5iqZgEssboQUTvLx7C2hGa/53hoNSue69I0EkIOuJ16Ee2jeEgBkptLfEozHu
         I/Yg==
X-Gm-Message-State: ACrzQf2zDOzQwcxb97ik8rh0jM6aeE1cW5CJjZ70Ncdrezu9wGUscxeq
        uvI+Lp7Ej+wirBZRCjgUD9U=
X-Google-Smtp-Source: AMsMyM5NibLqVxE7jStK+NkNJVdxNl4QEs6+5hKxd+19zNweMVdIdDh6HJjDfsxUiGQOZVn8JoBZQw==
X-Received: by 2002:a05:600c:3b99:b0:3c6:8b8e:a624 with SMTP id n25-20020a05600c3b9900b003c68b8ea624mr26313672wms.113.1666705090676;
        Tue, 25 Oct 2022 06:38:10 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id bg37-20020a05600c3ca500b003b477532e66sm2706016wmb.2.2022.10.25.06.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 06:38:10 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <494668dc-9df0-ee20-1cc1-bd5f01d1dc19@dunelm.org.uk>
Date:   Tue, 25 Oct 2022 14:38:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 7/9] cmake: support using GIT_TEST_OPTS from the
 environment
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
 <patch-7.9-fc9f036695f-20221021T091013Z-avarab@gmail.com>
 <830905ef-fb90-9b2a-c40a-67cf24f7a24b@dunelm.org.uk>
 <221021.864jvxfa3c.gmgdl@evledraar.gmail.com>
In-Reply-To: <221021.864jvxfa3c.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/10/2022 16:45, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Oct 21 2022, Phillip Wood wrote:
> 
>> Hi Ævar
>>
>> On 21/10/2022 10:44, Ævar Arnfjörð Bjarmason wrote:
>>> Get "GIT_TEST_OPTS" from the environment, and use it to pass arguments
>>> to tests. This allows for passing arguments to tests with e.g.:
>>> 	GIT_TEST_OPTS="--verbose --debug" cmake .; ctest -R t0001
>>> --verbose
>>> There's some overlap with this and what was suggested in [1], but as
>>> noted there we're not passing "--verbose" and friends unconditionally,
>>> so a plain "ctest" invocation without a "cmake" re-build won't pick up
>>> the options.
>>
>> The aim of dscho's patch was to make debugging information available
>> in the test logs without the user having to do anything, now to get
>> that information every user has to set
>> GIT_TEST_OPTS="--no-bin-wrappers --no-chain-lint -vx" when running
>> cmake.
>>
>> I think it would be helpful to have some default options set if the
>> user does not pass GIT_TEST_OPTS. Ideally one would be able to do
>>
>> 	GIT_TEST_OPTS=... ctest
>>
>> and have the tests pick up the options at runtime. Following on from
>> my previous comment, if we used "sh -c" to launch the tests we could
>> have something like
>>
>> 	COMMAND ${SH_EXE} -c [[GIT_TEST_BUILD_DIR="$1"; . "$2"
>> 	${GIT_TEST_OPTS:---no-bin-wrappers --no-chain-lint -vx}]]
>> 	"${tsh}" "${CMAKE_BINARY_DIR}" "${tsh}"
> 
> That sounds reasonable to me. FWIW I looked into
> $CTEST_INTERACTIVE_DEBUG_MODE for this purpose, i.e. to stick something
> like this in test-lib.sh:
> 
> 	if test -n "$CTEST_INTERACTIVE_DEBUG_MODE"
> 	then
> 		verbose=t
> 		trace=t
> 	fi

I think it is useful to have -vx set even if we're not passing --verbose 
to ctest as if a test fails we've got the information to debug it stored 
in ctest's log without having to re-run the test.

> But I was hoping for some way to tell that "ctest" was in "--verbose"
> mode, but AFAICT there's no way to get at that without something like
> compat/linux/procinfo.c (basically a fancier way of parsing "ps auxf").
> 
> Anyway, as noted in my review of dscho's series I thought this part of
> it was odd/outdated given that this thing runs on Linux (mostly, but
> entirely after this series).
> 
> I.e. why would we hardcode Windows-specific trade-offs into a portable
> build-system, and if you do want e.g. "--no-bin-wrappers" why would you
> want that just when you run "cmake", not "make"? Surely if we're pushing
> for a new default it should be agnostic to the user's build system.
> 
> But in any case I think if we're pushing for new (or cmake-specific)
> opinionated defaults it makes sense to split those up & justify them
> separately from bug fixes or workarounds.
> 
> E.g. 2/9 in this series makes much of the tests pass on *nix, but so
> does "--no-bin-wrappers", but just because it happens to bypass the
> broken-on-master bin-wrappers/* made by cmake.

I agree that --no-chain-lint --no-bin-wrappers are there just for 
windows. We could quite easily add those just for windows builds but the 
cmake build is basically only there for windows and the linux support is 
just there to allow testing the cmake build without having to run the ci.

Best Wishes

Phillip
