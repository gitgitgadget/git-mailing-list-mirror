Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44298E6FE3D
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 14:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjIVOhd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 10:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjIVOhc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 10:37:32 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DD4100
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 07:37:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40535597f01so20045265e9.3
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695393444; x=1695998244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jJINGUU604SVvJMldYqA9Y3y7RDXOiH5t9YK5QXv/m8=;
        b=MxKTRdLklOVXVLydVjvvbC3yIgdRt9TSgB7hY+M0nGotFd/zFzNovTWB5ubNPfdfA0
         /YQZD0jRjN0SSFuUivwM8U/CutGtKrcEoqiRxiQ6PZEVlKN4O9L5l5Vlt4rsYjl/K1ux
         ePMfVihLJJEJ9oulRYZjM5Gfnxvm25vIe04fW9NfxSo6fhMeyJhd1bR0Jgz/tto5SdqY
         DCviG3OqYxa4k+d6N3AdHwu1a/VdXmJouKCJYbDDfHOj68hL4VJkxvAr2dkUDgQPSSgS
         zqIflSEpnPYBgry3BZS+LfJ68TZaxVYT05ysrbZuPSUUoKz6tuoK73Vtm1HQvSv6rVyH
         mV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695393444; x=1695998244;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJINGUU604SVvJMldYqA9Y3y7RDXOiH5t9YK5QXv/m8=;
        b=gwvycPyDTfzvItbAUXxR7XA4hE1HNF63TRBfFiEcNSaCTYtpFiy2NeojBsO8Hd8VKd
         IyaqrHhSJ5ZDMpTcMdJOr2yB159RVFbvcd9p8+e/zo+PCXeqjw2dtXLy2MXm0tdjxwYz
         X9fi0eOa5HLQuH/zeqRFZAuiBnfmmbQUVAQlPA3LH7tKL+XOdILFF1CDYnn8Tl4Nmyp/
         EV2QdS0dprcEPA9kN5WxrEzOrsnwY695IQfhJERjeTbW7ZRqPKSCR55yF+b/pdtbaORo
         dh09fMUzK8UzlUTldofIvXmP1uEd8AGc636xsFqeB6N/UyQWN9lMRennnBFnUySyji7S
         E/Gw==
X-Gm-Message-State: AOJu0YzV2V0/JIOOp3sWZxromg5i4Y7cIl6BtxUZUD0CvWCxSvM56v2r
        0+6ZkyAQbZAaclaUCjwzwNww9dUCLIeyjA==
X-Google-Smtp-Source: AGHT+IHw8TDPTSD9xoQ3abeUQL5VEfWRLYY7mpK+Lo8ZeTMMcN8shSWz8SJd3NFehBvgH8v6HvR5bg==
X-Received: by 2002:a7b:c416:0:b0:402:8c7b:ceea with SMTP id k22-20020a7bc416000000b004028c7bceeamr7607477wmi.30.1695393444185;
        Fri, 22 Sep 2023 07:37:24 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id 15-20020a05600c020f00b00401d8810c8bsm7642283wmi.15.2023.09.22.07.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 07:37:23 -0700 (PDT)
Message-ID: <7d1d78c5-5781-4f5e-90f3-c02e74af31b2@gmail.com>
Date:   Fri, 22 Sep 2023 15:37:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 6/7] cmake: use test names instead of full paths
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1579.git.1693462532.gitgitgadget@gmail.com>
 <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
 <41228df1b469d9a79f3278fe8c1ca37082600669.1695070468.git.gitgitgadget@gmail.com>
In-Reply-To: <41228df1b469d9a79f3278fe8c1ca37082600669.1695070468.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

On 18/09/2023 21:54, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The primary purpose of Git's CMake definition is to allow developing Git
> in Visual Studio. As part of that, the CTest feature allows running
> individual test scripts conveniently in Visual Studio's Test Explorer.
> 
> However, this Test Explorer's design targets object-oriented languages
> and therefore expects the test names in the form
> `<namespace>.<class>.<testname>`. And since we specify the full path
> of the test scripts instead, including the ugly `/.././t/` part, these
> dots confuse the Test Explorer and it uses a large part of the path as
> "namespace".
> 
> Let's just use `t.<name>` instead. This still adds an ugly "Empty
> Namespace" layer by default, but at least the ugly absolute path is now
> gone.

That does sound like a worthwhile improvement. If we used `git.t.<name>` 
would that fix the "Empty Namespace" problem? (probably not worth a 
re-roll on its own)

Best Wishes

Phillip

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   contrib/buildsystems/CMakeLists.txt | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index ad197ea433f..ff1a8cc348f 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -1106,13 +1106,14 @@ file(GLOB test_scripts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
>   
>   #test
>   foreach(tsh ${test_scripts})
> -	add_test(NAME ${tsh}
> +	string(REGEX REPLACE ".*/(.*)\\.sh" "\\1" test_name ${tsh})
> +	add_test(NAME "t.${test_name}"
>   		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
>   		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
>   endforeach()
>   
>   # This test script takes an extremely long time and is known to time out even
>   # on fast machines because it requires in excess of one hour to run
> -set_tests_properties("${CMAKE_SOURCE_DIR}/t/t7112-reset-submodule.sh" PROPERTIES TIMEOUT 4000)
> +set_tests_properties("t.t7112-reset-submodule" PROPERTIES TIMEOUT 4000)
>   
>   endif()#BUILD_TESTING
