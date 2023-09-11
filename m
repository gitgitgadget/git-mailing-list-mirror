Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2ECCA0EC2
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349440AbjIKVdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237947AbjIKNXv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 09:23:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595CF193
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 06:23:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401da71b83cso50529695e9.2
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 06:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694438625; x=1695043425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JWqR4nzxXmklQNrzILtnfe1en18bMIVzArqHc8dt000=;
        b=foAX2aj0NmyhaMcFAey4KKeQ1rmYCNAIUPvyydU75ODE6wkOxy9iJI7BmD7aPjDwrX
         9ymMLmeQK4nbv049W9AuwDRNUxiyiW0uXFag5FYihF7UyniVltP5R1KmjjM8cMaqL0zq
         SYS+gTR1i+UChgXRFI2s8LhkfsN4G8hvQW/avQpbAhpzpp4/Xyj8UIwOMA8LNCfAFFSB
         glQHTyJvuSLIEGLDqdpYmNpa4Odm3QYIelasIeAxmWQo8GepIQOmshJoZJn7mc4fctnB
         2NDrlnQA5bn2TDM82JpUx/6dzof8loKLTZUodecDjZXlb1OSvUPvhVaFwNZSKdnlYDy7
         hjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438625; x=1695043425;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWqR4nzxXmklQNrzILtnfe1en18bMIVzArqHc8dt000=;
        b=cJd5Ij65ZxZBg+gtL2w0MHaD+OrU7+YFPQDqiNZn8OFpJ4TLA7FbewhqxPhcsE+mJP
         pSs0z7oFYFhWUSTfV1ujXOUViXW5WUVUXFZhUPuJoucH/sI6waBFEl0YEN23vvEnGOt1
         +O8w2fuD4kr1SwxMwyQQiis8HBWUzV83eddlg239ADv68sTAl4DABX3uXOnUhUbzcRyD
         Va4H1DaCtyWmwPxHw15U1hSVL75tcqg0Plu+32/GFoMMjWiwln33pzGwQAPy9A2nNJ8f
         qPKfJ6wALDHosX/inB6KVAMyu1j4HPJvAcnciLD12uuawn8LcY0wMRrxVX9KncLFcR38
         /fjg==
X-Gm-Message-State: AOJu0YzM8LDmGuV+/rvaZ2qZux8FkYe/WxWRQARGU5tvKBYW24P3jw3P
        TDB/7UcotfHJ5kV6mtTwXKA=
X-Google-Smtp-Source: AGHT+IFcxdkQOhcok63asK9aeVCiGF0djWGB498fkHF08hnLgoE1iboE4swDK6AIWHYmQSQnIxRm2w==
X-Received: by 2002:a7b:c01a:0:b0:401:d3dd:c3c with SMTP id c26-20020a7bc01a000000b00401d3dd0c3cmr8161323wmb.39.1694438624603;
        Mon, 11 Sep 2023 06:23:44 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id c10-20020a7bc84a000000b003fee0741b8csm13303558wml.23.2023.09.11.06.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 06:23:44 -0700 (PDT)
Message-ID: <d7d1505c-8d65-4b64-8814-3e3b1e46f8ac@gmail.com>
Date:   Mon, 11 Sep 2023 14:23:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/4] cmake: also build unit tests
Reply-To: phillip.wood@dunelm.org.uk
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
 <2cc1c03d85153356edd55fc0747a957db3c94ab0.1693462532.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <2cc1c03d85153356edd55fc0747a957db3c94ab0.1693462532.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

On 31/08/2023 07:15, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> A new, better way to run unit tests was just added to Git. This adds
> support for building those unit tests via CMake.

This patch builds the unit tests but does not add them to the list of 
tests run by CTest - how are the tests typically run on the CMake build?

Best Wishes

Phillip

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   contrib/buildsystems/CMakeLists.txt | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 2f6e0197ffa..45016213358 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -965,6 +965,24 @@ target_link_libraries(test-fake-ssh common-main)
>   parse_makefile_for_sources(test-reftable_SOURCES "REFTABLE_TEST_OBJS")
>   list(TRANSFORM test-reftable_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
>   
> +#unit-tests
> +add_library(unit-test-lib OBJECT ${CMAKE_SOURCE_DIR}/t/unit-tests/test-lib.c)
> +
> +parse_makefile_for_scripts(unit_test_PROGRAMS "UNIT_TEST_PROGRAMS" "")
> +foreach(unit_test ${unit_test_PROGRAMS})
> +	add_executable("${unit_test}" "${CMAKE_SOURCE_DIR}/t/unit-tests/${unit_test}.c")
> +	target_link_libraries("${unit_test}" unit-test-lib common-main)
> +	set_target_properties("${unit_test}"
> +		PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/t/unit-tests)
> +	if(MSVC)
> +		set_target_properties("${unit_test}"
> +			PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/t/unit-tests)
> +		set_target_properties("${unit_test}"
> +			PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/t/unit-tests)
> +	endif()
> +	list(APPEND PROGRAMS_BUILT "${unit_test}")
> +endforeach()
> +
>   #test-tool
>   parse_makefile_for_sources(test-tool_SOURCES "TEST_BUILTINS_OBJS")
>   
