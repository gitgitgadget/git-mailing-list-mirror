Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA44C4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 10:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbiLFKDM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 05:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbiLFKCE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 05:02:04 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF5727DF5
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 01:55:07 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so12249991wmi.3
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 01:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=85G8X2HRfR/saHJz5RlsIx+AHt3kVkEhzuUbq33L40k=;
        b=VrrRdlZrJ99dVofb9XWJYa0VE14GG2bAQ/gvh4NcQPtGlSxaiR+hXdcNI0TyoTWT7P
         cyitZRwDra4iTC+anxx/29Vx1roRpfgotXkHgH9ZTWpOW6RRmPAIWMN6Ix/t4ETniUMz
         q5Tgyy7Ds4xJVOZUQFGJGv8a2H8VzFteFXBA3s1OW7QoyLqIrEP3Q5IGtpNb1EKo+6Cz
         Wn9is3UjJuyRjQrqRJbEBUYRZ1JcP2Ic8aUUVM5KydMBdT+IW9ytBQsgs5HvlRTGVHFB
         q3UmQDiR2SktlRlhYZ6c6KjZjwHTvIcTvRvxhZZZGFlC8meZpXR7suGDOSSB7uOYxWcB
         OtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85G8X2HRfR/saHJz5RlsIx+AHt3kVkEhzuUbq33L40k=;
        b=qINx8Kpo9VckH+d8HEscPdbBYaCLX4GWcYYQ9OgJsAHfPPhP4upra71EOvtUMJW3dm
         udjeWpBGgO4nEobdcVLhwzunF7xjcpvnQE0FncGU0qP/Ws9vwPwG7hIZVOcy0CyTg0DZ
         GLwugs+9h+chBY3lnCMx5/v9eLN0qZN6/K8DNKML6DYIfwKxoIwpdjR9zB5J51OKqH7I
         QpiiUO/nUF975M+IiUBIVlvOiKXkI4MMFibGGv/LuAPKe4FHEKHxYtNppxD4DtJtIfo0
         sIQ0uPYNzhwt29zeXg363bcFCQ6kiY+0NCukBuVcFvqltTLONjh3J8j4UCz01b/53d1d
         kwXQ==
X-Gm-Message-State: ANoB5plGyzfdGU8h1Aoluky11J94MAX/7WlSCELn69ylIdKqD4dUBeqZ
        okpXHFlm6L8yleM8lxkJiCIHkT2ouPQ=
X-Google-Smtp-Source: AA0mqf6BeCw+iLVxc1vmEJRNMyCOqH6o/T/8q1DtM5hpBiXgvfcI25aXhoFTD3uBcIIjZqGe4+D7Bg==
X-Received: by 2002:a05:600c:1554:b0:3d0:e725:8ab8 with SMTP id f20-20020a05600c155400b003d0e7258ab8mr8036001wmg.122.1670320465937;
        Tue, 06 Dec 2022 01:54:25 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b003c70191f267sm28045065wmp.39.2022.12.06.01.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 01:54:25 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <30360f4c-91a5-177b-133f-eb7036ed676a@dunelm.org.uk>
Date:   Tue, 6 Dec 2022 09:54:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] test-lib.sh: discover "git" in subdirs of
 "contrib/buildsystems/out"
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
 <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
 <xmqq5yeuspam.fsf@gitster.g>
 <87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk>
 <221202.86sfhxg2ng.gmgdl@evledraar.gmail.com>
 <Y4qF3iHW2s+I0yNe@coredump.intra.peff.net>
 <221203.86pmd1dyqn.gmgdl@evledraar.gmail.com> <Y45/8WnuUnP9gOMo@nand.local>
 <Y46clyoKk9KzFiqj@coredump.intra.peff.net>
 <221206.86zgc1cnc3.gmgdl@evledraar.gmail.com>
 <Y46jT0i/7DhxHzfS@coredump.intra.peff.net>
 <221206.86mt81claa.gmgdl@evledraar.gmail.com> <xmqqilipnq8j.fsf@gitster.g>
In-Reply-To: <xmqqilipnq8j.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/12/2022 03:52, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
>> Just to add my own digression: I asked in some past thread (which I'm
>> too lazy to dig up) why it was the cmake file couldn't just dispatch to
>> "make" for most things.

Because make is not installed by default on Windows. Our CI job uses 
msbuild (whatever that is) and when I was playing with Visual Studio 
last week it was using ninja.

>> I.e. it needs to at some level be aware of what it's building for the
>> IDE integration, but for say making a "grep.o" there's no reason it
>> couldn't be running:
>>
>> 	make grep.o
>>
>> Instead of:
>>
>>          cc <args> -o grep grep.c [...]
>>
>> which requires duplicating much of the Makefile logic (possibly with
>> some Makefile shim to not consider any dependencies in that case).
> 
> That leads to a question at the other extreme.  Why does any logic
> in CMakeLists.txt even have to exist at all?  Whenever it is asked
> to make foo, it can be running "make foo" instead of having its own
> logic at all.  ;-)

Yes, if make was available then we wouldn't need to use CMake.

Best Wishes

Phillip
