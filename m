Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF47FC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 14:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiJUOSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 10:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiJUOSe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 10:18:34 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C98127C974
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 07:18:33 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bk15so4991965wrb.13
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 07:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kGo/jsDSzL5EBNcxV51LhJPJ6DaFqCHHhcTZzObmAQY=;
        b=jRhKZow1CBxHqUNs6JhAKgd96hYZxGRuBAJ/ImFJHL0Uvi6TiPv8U2KWc98RIhFyE2
         GmV5v6Siohj8f9HryiPtJQoNaqVbxgVmuiGy2V19CmKydqsfDVBKVieh0j26Um/qHZsw
         4SEvjOX/10yeFFOT+oQEGMpSyyZdbTYZNOnvPcX/Z+ql3cYPnJJBs4T97tEI7mDr1ihc
         9bKhztHAXkzXDGL/WTN/j7N+ghhRbBbhocxV+PXvAZpGbg1Iqf+CAol8fVdyfCmAj3CW
         a+KpJvI3kndVxjmqOE4hgQzNF2JH/haFVIPqGcVwlDpuLe/1Oed4uWsCQqGKnkqXiECh
         MBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGo/jsDSzL5EBNcxV51LhJPJ6DaFqCHHhcTZzObmAQY=;
        b=6qTvFTrkUA28uwLODcrg4jLMLo2P0YNypdw7KtVn9an9RZK9VSc815V6q5GIfYpIvV
         zIm7qcaCjcIA46lobrg70PWL1wt8IkRioXyAL5nkOIYPoG2UQJ5FvKu4nX9btj0ZZGvE
         ORqFmcHRR8JssuH5/7DsV+pe75Dgr1dS0297270aTo6HPTr+WBQKhIX4UX09abgj8XHr
         UFy9txq7pfAwRlzzun4cWMv7EYGcgnwNJbFvGqMTjHaiSiIRqh1L/xqgitS/1WLlGRzU
         NDozDdbB3WC/j9iGnhBRuzaS4K5SLCNFXiVWNqlzGweFDhH1zdzIvhoQStNUtVf6bPMs
         okIg==
X-Gm-Message-State: ACrzQf0uz37QotmtuzcJ+z0VfJjQ+KQTVD2X2ivzRucNSOFez2TWrRqA
        gGiD2fHJftNVsHPosBWWRmQ=
X-Google-Smtp-Source: AMsMyM62KIicSR6sq//lBwf0HTTr7+fn0TXfZYfUiPjuDiPx4N97qFyT7S4P06SZjiF/OIkSDecCCg==
X-Received: by 2002:a5d:688f:0:b0:22c:df1c:92cd with SMTP id h15-20020a5d688f000000b0022cdf1c92cdmr12755437wru.52.1666361911830;
        Fri, 21 Oct 2022 07:18:31 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id g10-20020a5d554a000000b002364c77bcacsm3098911wrw.38.2022.10.21.07.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 07:18:31 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <830905ef-fb90-9b2a-c40a-67cf24f7a24b@dunelm.org.uk>
Date:   Fri, 21 Oct 2022 15:18:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 7/9] cmake: support using GIT_TEST_OPTS from the
 environment
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
 <patch-7.9-fc9f036695f-20221021T091013Z-avarab@gmail.com>
In-Reply-To: <patch-7.9-fc9f036695f-20221021T091013Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 21/10/2022 10:44, Ævar Arnfjörð Bjarmason wrote:
> Get "GIT_TEST_OPTS" from the environment, and use it to pass arguments
> to tests. This allows for passing arguments to tests with e.g.:
> 
> 	GIT_TEST_OPTS="--verbose --debug" cmake .; ctest -R t0001 --verbose
> 
> There's some overlap with this and what was suggested in [1], but as
> noted there we're not passing "--verbose" and friends unconditionally,
> so a plain "ctest" invocation without a "cmake" re-build won't pick up
> the options.

The aim of dscho's patch was to make debugging information available in 
the test logs without the user having to do anything, now to get that 
information every user has to set GIT_TEST_OPTS="--no-bin-wrappers 
--no-chain-lint -vx" when running cmake.

I think it would be helpful to have some default options set if the user 
does not pass GIT_TEST_OPTS. Ideally one would be able to do

	GIT_TEST_OPTS=... ctest

and have the tests pick up the options at runtime. Following on from my 
previous comment, if we used "sh -c" to launch the tests we could have 
something like

	COMMAND ${SH_EXE} -c [[GIT_TEST_BUILD_DIR="$1"; . "$2" 
${GIT_TEST_OPTS:---no-bin-wrappers --no-chain-lint -vx}]] "${tsh}" 
"${CMAKE_BINARY_DIR}" "${tsh}"

Best Wishes

Phillip


> 1. https://lore.kernel.org/git/356b2e9a1007bcd1382f26f333926ff0d5b9abe2.1666090745.git.gitgitgadget@gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   contrib/buildsystems/CMakeLists.txt | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 91b7009f4fd..8e29e3f514b 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -1083,9 +1083,11 @@ endif()
>   file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
>   
>   #test
> +set(GIT_TEST_OPTS "$ENV{GIT_TEST_OPTS}")
> +separate_arguments(GIT_TEST_OPTS)
>   foreach(tsh ${test_scipts})
>   	add_test(NAME ${tsh}
> -		COMMAND env GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR} ${SH_EXE} ${tsh}
> +		COMMAND env GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR} ${SH_EXE} ${tsh} ${GIT_TEST_OPTS}
>   		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
>   endforeach()
>   
