Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204A6C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 15:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiLSPAb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 10:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiLSPAK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 10:00:10 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB03F016
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 07:00:08 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w15so8895755wrl.9
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 07:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kI5zGq07QQ9KF7+ekJdATdZculCy+RbLgCek/r+z2dQ=;
        b=AjFJKHqiSv60dqZsG+YlvHxeCdFuoZura09jUAEwd00ZLsd6ojV08FZkqvgcO7ucM/
         1rfiMdc9Clo/FN6dBkeOAtY4J0cFtngCHpP8D97Y1sLNDg2ZaaxEYuM/vGpsFUfF9yoo
         Ap8t8imWn9yVptXKZ+wNeyuwoxjmmAWPKssqAHintf7MVKS8xUZ4fOYMnh4V3UUSVu5f
         HCCKNuLJXPMq7wrHp0z2uu/ENg3deBsuz4sVaksOCOWyL8ZW6IlUV7yKEwMQBVyFcR4q
         Va/oo7yGEhfeQFUxnTSsDEHK3I8BoahQ/bzdt8bGJ9K3IinIzt7lQrDcIT62ZiiEHIPI
         2C+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kI5zGq07QQ9KF7+ekJdATdZculCy+RbLgCek/r+z2dQ=;
        b=J4M7ZUQJb9K7FSebOfmya/OytldKLLtQzrz1P13HJb+LTuykISdT5q9oy9djFoSw6n
         OMOZKqXNBuG5gSGIyJ78wWjC57AbAMH9pETdLqswZEXizjqAaNuEkKRInluJ8TcbqjRI
         7v0m+iljEGsbG/Dg6QaQPxbs2BneQpZyIV7Jshv6mcVAAyhWGfP/k3EIzCqn1DQqJ2S1
         +R2ev7d8bU7zDYAiRJ3M9WWygSdunwSCMossRonNhdPJmrSfRHLMeWUjPIbRgfwTqSJ1
         oyDhiM6LPhjFrirP6vX8dZCw6wCKJr9BK9oWtLz642EHSDZpvJzHS13cNRYvidfaI1kk
         2Q2A==
X-Gm-Message-State: ANoB5pnVWmXgwZeWO2L06YEdZA/VFdEFIjrzsCZ7/IKKRlBYEEIVvDme
        s0tMYH2mtThe8PFeS71sZXo=
X-Google-Smtp-Source: AA0mqf4wW0BhznjUXcSDLAnCknmujqY9PEUdOLZq7BEjjPrGJOiLKoIworHV87a8x7MXmpWtGOe9kQ==
X-Received: by 2002:adf:ee4c:0:b0:242:879f:411b with SMTP id w12-20020adfee4c000000b00242879f411bmr25005004wro.41.1671462007389;
        Mon, 19 Dec 2022 07:00:07 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id i7-20020adffc07000000b00241d544c9b1sm11790493wrr.90.2022.12.19.07.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 07:00:07 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <45d8d9fc-ca68-5902-0aa7-70034f8383ff@dunelm.org.uk>
Date:   Mon, 19 Dec 2022 15:00:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] cmake: don't invoke msgfmt with --statistics
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
References: <patch-1.1-0fa41115261-20221219T102205Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-0fa41115261-20221219T102205Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 19/12/2022 10:26, Ævar Arnfjörð Bjarmason wrote:
> In [1] I made the same change to our Makefile, let's follow-up and do
> the same here.
> 
> For "cmake" this is particularly nice with "-G Ninja", as before we'd
> emit ~40 lines of overflowed progress bar output, but now it's only
> the one line of "ninja"'s progress bar.

I don't really have a strong opinion either way on this but if it 
matches what we do in the Makefile than it sounds sensible.

Best Wishes

Phillip


> 1. 2f12b31b746 (Makefile: don't invoke msgfmt with --statistics,
>     2021-12-17)
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> This trivial fix is extracted from the ab/cmake-nix-and-ci topic which
> was ejected around the time of the release for that previous
> submission see [1], the range-diff is to that topic.
> 
> I'm re-arranging and re-submitting topic more piecemeal. There were no
> outstanding issues or feedback with this part of it, so hopefully this
> can advance relatively quickly.
> 
> I'll also submit some of the other uncontroversial bits today
> independently, none of which conflict with one another. Then once
> those have landed try to find some acceptable way forward for the
> later bits, which at that point will be easier to review.
> 
> 1. https://lore.kernel.org/git/cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com/
> 
> Range-diff:
>   1:  fc190b379cd =  1:  0fa41115261 cmake: don't invoke msgfmt with --statistics
>   2:  1a11aa233a3 <  -:  ----------- cmake: use "-S" and "-B" to specify source and build directories
>   3:  b9ddb5db1d3 <  -:  ----------- cmake: update instructions for portable CMakeLists.txt
>   4:  7b7850c00ee <  -:  ----------- cmake: don't copy chainlint.pl to build directory
>   5:  82ecb797915 <  -:  ----------- cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
>   6:  1f326944a07 <  -:  ----------- cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
>   7:  973c8038f54 <  -:  ----------- cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
>   8:  b8448c7a8a6 <  -:  ----------- Makefile + test-lib.sh: don't prefer cmake-built to make-built git
>   9:  5135e40969e <  -:  ----------- test-lib.sh: support a "GIT_TEST_BUILD_DIR"
> 10:  65204463730 <  -:  ----------- cmake: optionally be able to run tests before "ctest"
> 11:  e25992b16f1 <  -:  ----------- cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
> 12:  4905ce5321d <  -:  ----------- cmake: increase test timeout on Windows only
> 13:  6c6b530965d <  -:  ----------- cmake: only look for "sh" in "C:/Program Files" on Windows
> 14:  563f1b9b045 <  -:  ----------- cmake: copy over git-p4.py for t983[56] perforce test
> 15:  917a884eb65 <  -:  ----------- CI: add a "linux-cmake-test" to run cmake & ctest on linux
> 
>   contrib/buildsystems/CMakeLists.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 2f6e0197ffa..8f8b6f375f7 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -897,7 +897,7 @@ if(MSGFMT_EXE)
>   	foreach(po ${po_files})
>   		file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES)
>   		add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo
> -				COMMAND ${MSGFMT_EXE} --check --statistics -o ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo ${CMAKE_SOURCE_DIR}/po/${po}.po)
> +				COMMAND ${MSGFMT_EXE} --check -o ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo ${CMAKE_SOURCE_DIR}/po/${po}.po)
>   		list(APPEND po_gen ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo)
>   	endforeach()
>   	add_custom_target(po-gen ALL DEPENDS ${po_gen})
