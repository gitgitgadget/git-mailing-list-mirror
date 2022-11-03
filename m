Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F60C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 09:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiKCJh4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 05:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKCJhx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 05:37:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87727EE37
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 02:37:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso745709wmo.1
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 02:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n5x01suvPNp6AH4MQ0Vi6rJG9zgLEurxtpKxSfx209Y=;
        b=PNPioyOJ+QAttdRkXfz707LWNaykpbGmuLk5IIbLeRj39NtDCTsdcSvMd9VFzfu7d5
         evHdjVCaaY+aJ9q6zFo9R16RUD/0dC/t4dlvV7JNZDfRac6gOXuwSa9Qtc6s71Hbjknx
         Zjzr7XLpraFBW3904+NZBhw/Qqw3o+z1uMRFxioF7kelauR27caEqonaT8QKL0fCcb0b
         UxRLIutwrNFEpDyiaAFw4EQA0Ys4EyGwn/+Mi/7PoKVowjzDvT94th0dHdP4VgQB5iOv
         fe5P73BXBF7lI+hHeFtJGZezoExAb6NNUhd/t2XtwR35PV5FmBUbWFQIMIeDNNzRvx/l
         u9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5x01suvPNp6AH4MQ0Vi6rJG9zgLEurxtpKxSfx209Y=;
        b=NiwZ6LcVX5LfLo1IDpTaa1ZHX2s+rrOynXQfV+96WAMd7GJ9g3Jh2uOCmK/5nd9qI4
         Mb9A2UgHw29YCch25Hj4eFjij99HbRKwX0F5ESJqxSsy+LrRCJrd18aBQ/lfCVGxFVhQ
         dMJYR7QBSI4FS8ErZpfX6TIzu1UP0fBGMH5sz5P0Efe75gQvuulUHxHLk/E78vEDHZqN
         ZoUJ2PGm+e+e1aBbkTlHyssosyFLCVfxRHJ7sPzXtjOeSeNcuJzXkhxJy15DAOlb25+n
         BNCBNkFRJZdDDlMMkmhzm0k1zuK+o68r85pit4p8S0buhC8ByhmRcAJmys9qOFKqeD9L
         8tuQ==
X-Gm-Message-State: ACrzQf2mGHWSwDXykpf0TVaG7zuWMqdt8tv/qL6eQjPPxtsGgH5ekhri
        X7sMbPVhKEhF9JiQxQWjZ1c=
X-Google-Smtp-Source: AMsMyM4l8FHPg7YIyQkvw0kixoNQN5fo5m49BDpI6tQ8bumPz10MbJ8qb0e+ZFDErUpEXHqmGdSOWA==
X-Received: by 2002:a05:600c:2194:b0:3cf:7065:99e5 with SMTP id e20-20020a05600c219400b003cf706599e5mr13767681wme.174.1667468271118;
        Thu, 03 Nov 2022 02:37:51 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id k25-20020a5d5259000000b00225307f43fbsm356439wrc.44.2022.11.03.02.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 02:37:50 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <0999e43a-8f6e-bcc1-9f7d-f55b642b5ef4@dunelm.org.uk>
Date:   Thu, 3 Nov 2022 09:37:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 01/12] cmake: don't "mkdir -p" and "cd" in build
 instructions
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
References: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
 <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
 <patch-v3-01.12-028fa1436d8-20221101T225022Z-avarab@gmail.com>
In-Reply-To: <patch-v3-01.12-028fa1436d8-20221101T225022Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/11/2022 22:51, Ævar Arnfjörð Bjarmason wrote:
> Use the "-S" and -B" flags instead of "mkdir -p" and "cd". The "-p"
> flag to "mkdir" wasn't needed as "contrib/buildsystems" is tracked,
> and the rest of this is now easier to copy/paste into a shell without
> having one's directory changed.

When was "-B" added? This feels like a personal preference rather than 
an objective improvement. Arguably changing into the build directory is 
actually better as ctest has to be run from there. It also appears that 
these instructions have not been tested as the make invocation in wrong.

Best Wishes

Phillip

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   contrib/buildsystems/CMakeLists.txt | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 3957e4cf8cd..494da807c53 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -16,9 +16,7 @@ though, therefore the `File>Open>Folder...` option is preferred.
>   
>   Instructions to run CMake manually:
>   
> -    mkdir -p contrib/buildsystems/out
> -    cd contrib/buildsystems/out
> -    cmake ../ -DCMAKE_BUILD_TYPE=Release
> +    cmake -S contrib/buildsystems -B contrib/buildsystems/out -DCMAKE_BUILD_TYPE=Release
>   
>   This will build the git binaries in contrib/buildsystems/out
>   directory (our top-level .gitignore file knows to ignore contents of
> @@ -36,8 +34,8 @@ NOTE: -DCMAKE_BUILD_TYPE is optional. For multi-config generators like Visual St
>   this option is ignored
>   
>   This process generates a Makefile(Linux/*BSD/MacOS) , Visual Studio solution(Windows) by default.
> -Run `make` to build Git on Linux/*BSD/MacOS.
> -Open git.sln on Windows and build Git.
> +Run `make -C contrib/buildsystems` to build Git on Linux/*BSD/MacOS.
> +Open contrib/buildsystems/git.sln on Windows and build Git.
>   
>   NOTE: By default CMake uses Makefile as the build tool on Linux and Visual Studio in Windows,
>   to use another tool say `ninja` add this to the command line when configuring.
