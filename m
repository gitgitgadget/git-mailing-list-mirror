Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35238C4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 15:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiLBPOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 10:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbiLBPOV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 10:14:21 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF75FBFCD6
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 07:14:19 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso6667921wme.5
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 07:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GRVNjqWIdOPh+xW1Kx3+N2X7Jb9WdyNKGGcKsL6izoA=;
        b=YILKjNp+eGDPP+Yw/ER007uQAJDR/rmZfJ5WoOFlLjOsmUKlwyh8RLTWWzopzoTaVh
         xUu971cCkcNJ9nlKT8tziqAye1YxVcZ750O1O+MAI27Y5xeqvYeGSsDawJNyl1evX4S/
         rSmZ3qDZOnF7q5gLcD1FZxzuCPj50c+cL1M/Ahi4SojTdD2ktTlWkrqeaV5jV+ogQxgR
         z+ZsYp6kedzSQxPOXkasNIO64NBxW0x4QMIq5jEVR+8YYqfMQFqga/v3DdX924g4kgQW
         am2AhMIy+tALwj0XYhBS9dlH1h9odXwGXh6hilp+yi+wWWjOhvw/EM2TBs/0/rGeifHU
         0zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRVNjqWIdOPh+xW1Kx3+N2X7Jb9WdyNKGGcKsL6izoA=;
        b=0eTyB6RLy3aU05Vfrxtt5KFkhYD1Q8hvFiLwcncWfiXeUVJ494q3+PxuEUYfozI40h
         A+467VEtWSTeG9Hrs/Pgr4adaQfDUXS9V/qog3x28nmNqbnVYUJE2N8PMi6GX5Z0lrmj
         bSwV8Qcs7kUuIDuRXFGS5OpukfVRshVvOLZEugViuR5p+ItDBaH/Kc1xKAoU/3V06exv
         VtF15SU+0VyL4mEYWDID3jciwA13Kghniuh5fLH+iblUI6n18N5TWg9tgfdrIoZfr41B
         D2ikVLECRMJgOeUxAdFh6cIK3ByWk8xfpKmEZxZvjeVjmnV6IcB+b/r71iUcrz5hTy47
         qV6Q==
X-Gm-Message-State: ANoB5pmGU3dA/WgurEN6dRUe6lcFbnNUo9wlIJ4lcba4ispo3HuRf6Ov
        Jd8zjpDbvbr+MVqzRhJuUj4=
X-Google-Smtp-Source: AA0mqf6yDCvcJyb0f23IirEb82YbX5ZkGuNHiLVNmbtteXLEDjcRmamqeVUPtTvhkVf+qBa7m8R6wA==
X-Received: by 2002:a1c:f003:0:b0:3cf:e87a:806a with SMTP id a3-20020a1cf003000000b003cfe87a806amr55123973wmb.58.1669994058154;
        Fri, 02 Dec 2022 07:14:18 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id t67-20020a1c4646000000b003cfa622a18asm12139210wma.3.2022.12.02.07.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 07:14:17 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk>
Date:   Fri, 2 Dec 2022 15:14:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] test-lib.sh: discover "git" in subdirs of
 "contrib/buildsystems/out"
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
 <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
 <xmqq5yeuspam.fsf@gitster.g>
In-Reply-To: <xmqq5yeuspam.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 01/12/2022 23:00, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
>>> Junio please drop this series when you rebuild next as it breaks
>>> manually running individual test scripts when building with Visual
>>> Studio.
>>
>> I think the issue you've spotted is easily fixed on top. See below.
> 
> Smells more like papering over than fixed, but let's see how folks
> who need cmake/ctest feel about it.

As MSVC uses different directories for debug and release builds there 
can be more than one build directory. I don't think selecting one of 
them at random using 'find' is a good idea.

> Let's mark the series never to graduate to 'master' for now,
> optionally revert it out of 'next'.
> 
>      Phillip, you asked about rebuilding 'next', which would not
>      happen until 2.39.0 final---did you mean reverting the topic out
>      of 'next'?  Do you need 'next' without this topic, not just
>      'master'?

I don't mind waiting but I'm not a Windows user. I only tested this 
topic under Windows because I knew Ævar had not and a quick web search 
for "MSVC CMake" made me worry it was broken.

I'm afraid I wont be spending anymore time on this topic. I had hoped 
that having the CMake build work under Linux would help developers avoid 
breaking it. However I'm concerned that if developers do not appreciate 
that there are differences between the Linux and Windows builds it will 
actually create a false sense of security and be used as an excuse not 
to properly test under Windows[1]. Recent events have confirmed my view 
that changes like this need the attention of someone with experience of 
Windows development and given that yesterday was the first time I'd used 
MSVC since about 1994 I do not fit that description.

In addition to the breakage I reported yesterday 623fde1438 (cmake: 
chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4, 2022-11-03) 
causes CMake older that 3.19 to error out when run from MSVC because 
chmod does not exist on Windows. Also when running 'ctest' on "next" I 
see tests failing because they cannot find 'test-tool' (I haven't tried 
running the failing tests manually)

Best Wishes

Phillip

[1] While our CI helps the MSVC job runs CMake manually, performs an 
in-tree build and does not use ctest. In contrast a user running the 
MSVC GUI does not run CMake themselves, ends up with an out-of-tree 
build and runs the tests with ctest.

> I'll then wait for something both camps (you and folks on Visual
> Studio?) can agree on to requeue.
> 
> Thanks.
