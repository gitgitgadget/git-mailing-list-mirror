Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E29E6FE3D
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 14:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjIVOjT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 10:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjIVOjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 10:39:16 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FD0C6
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 07:39:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401b393ddd2so23031765e9.0
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 07:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695393549; x=1695998349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Eh8JI+CPsYzj9UNXBz3VbLYx+oy968loyQJ+yqzZVd4=;
        b=Nfsfqo5fG4y6TzgBjeRGoEQcjQTqHFwoBLELODhDGmMBWd5WWoLBm54JMc9IHpl+br
         JcS0cTvOmCupPQ63qe+ZWiUNdNBIbX22C2uUr/moal8+w7qMBgLlloBw7NFbqRcRYaGa
         xOKY7C6F28LY6k4YxAxxbHiLFMt9PdVhWlv6ufyENS9GbOGstnbIhVh1wZPhczQeSjpW
         N4Vpy7ADLr20a6dIRV4ZiGG0xb4L2uk9du3bO8zROvkL8/0B+VFrrchr2SEFQ7tXYAWv
         9mySV1tuSUNTL3HCXDqgL3UshJ6hCPG77SIONqp1AU50PJ8pjoVwqlebGLddX1IfsQWf
         WRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695393549; x=1695998349;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eh8JI+CPsYzj9UNXBz3VbLYx+oy968loyQJ+yqzZVd4=;
        b=mvNSNTs4fam2tQLmt4Iv+rbomvOn5afoFvdqCPWD/rpQQA+Z0zU2T8bbFHC3gRmPQ+
         5AdDr1Nl4us6sfBuhOoc5/44hY4VZelGzhLOjqS7/h0w3o83Vso4T15DGEPUhv13/6Lh
         zA1mrd0qqWG6W6PPwRHuIGiHaxCXXS+HO0CVX06bn5qOt4YtnCer7FGSCB4mHyXTkpjs
         qyogFk4jzeRV149jCaG4VYo9wPCbv7wGqTd+JnE/1txV5h4QNy/ehgY6FcKLg3mGefzz
         h8Y4U0n+bUh1nuWyhhmQ8EqKCB2jDzRaw1x5F3OHsK9yAnlOSoPsacDJfiMkVQ8bYVqj
         FVrQ==
X-Gm-Message-State: AOJu0YzrljhveWm9PaKWLnflfClEKqlMlRAONdq54qSUEmmoTxtLhlyP
        83KE3aPR5Z6lsXfOGZagURg=
X-Google-Smtp-Source: AGHT+IFWLg3b2hNzRSTYoOIufzBXxS8h++Ln5ddb/yKGYHhM7Wg1+NjrLjEqWAFGbMe5LYOTbs8aKA==
X-Received: by 2002:a05:600c:20c1:b0:3fe:1679:ba7b with SMTP id y1-20020a05600c20c100b003fe1679ba7bmr8688655wmm.24.1695393548354;
        Fri, 22 Sep 2023 07:39:08 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id m14-20020a7bca4e000000b003fefb94ccc9sm4827495wml.11.2023.09.22.07.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 07:39:08 -0700 (PDT)
Message-ID: <81b8fda7-fa2e-4ccf-94cb-3fdd3995948b@gmail.com>
Date:   Fri, 22 Sep 2023 15:39:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 7/7] cmake: handle also unit tests
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
 <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
 <003d44e9f0d73efae887d6b61ebdffb3c4e0904f.1695070468.git.gitgitgadget@gmail.com>
In-Reply-To: <003d44e9f0d73efae887d6b61ebdffb3c4e0904f.1695070468.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

On 18/09/2023 21:54, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The unit tests should also be available e.g. in Visual Studio's Test
> Explorer when configuring Git's source code via CMake.
> 
> Suggested-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

This looks good to me, it is nice to see it being careful not to run 
t-basic with the other unit tests.

Best Wishes

Phillip

> ---
>   contrib/buildsystems/CMakeLists.txt | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index ff1a8cc348f..35d451856a0 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -981,6 +981,17 @@ foreach(unit_test ${unit_test_PROGRAMS})
>   			PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/t/unit-tests)
>   	endif()
>   	list(APPEND PROGRAMS_BUILT "${unit_test}")
> +
> +	# t-basic intentionally fails tests, to validate the unit-test infrastructure.
> +	# Therefore, it should only be run as part of t0080, which verifies that it
> +	# fails only in the expected ways.
> +	#
> +	# All other unit tests should be run.
> +	if(NOT ${unit_test} STREQUAL "t-basic")
> +		add_test(NAME "unit-tests.${unit_test}"
> +			COMMAND "./${unit_test}"
> +			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t/unit-tests)
> +	endif()
>   endforeach()
>   
>   #test-tool
