Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ED3C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 11:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbhLGLNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 06:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbhLGLNr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 06:13:47 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78588C061746
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 03:10:17 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t18so4776932wrg.11
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 03:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0lpv/zEcbPjsD/82Tt1Ph/jq0C1DSbFLpJdVBFKalns=;
        b=ojJFXT/EzARiIam4l1XHQ8Na6zwr1hMgU9ibcHXnG7z94lpDwyB6dazi/8PNIJ3Cqe
         boA6K+LcngYPgzS9hAue8GzYAU6RL/jFuI3+5E/XdPSv43KYm2QIfZhfYDvMzT9j0rQA
         Ho/ZmH5ArlEEr12eM8hOUD4gKMUnEgAzUTeYZsVXurYv+w/5mSrrS3ElniPmDBiYFclN
         w1i1qZ2PIOBBhYLMMhymfMlxRvHPei3Fj5G5cV9OMozBsf1L/Yr7caXZbnfNR8vjkAeJ
         mtxznSU7eVPmSVUU5Rts5WmnlQj5ZdZKAM0+H1m1q2jXBhu5uV82m9Y0DnHhPmUqNHGH
         agCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0lpv/zEcbPjsD/82Tt1Ph/jq0C1DSbFLpJdVBFKalns=;
        b=61rLypCqzZ3trlR+q4DBD7auK4hmsWbPu7ahHCWihAKKOkd5Ym8SjE6x7B2OLc6KmR
         yUDxEy/LIegAN4Kxgf/OPu1R/Z+mFit6kldUUawcbjIao/xBCEx/SiNRtLNcndX/EQ0g
         wsXQFC8R+pmQ9NCAv4pwQ3ErUrysRi98FPv41VdqW4qtp2HmVgDMegKLOUtKeVWlNwIC
         w2jwEajVTr4BQESm9x5oSe/p0GvbPHI2qXOfw85HUq4CnhuKxiARIgvULDeat9KG5Esh
         oSQ4pAn7B82I1QmoPpbbX+MMoxYlsZP/GFduI7sRXzILy9nKlic/zbgc2R7yQm/ObG/V
         c7KA==
X-Gm-Message-State: AOAM530RefJocKdRZFmdfXoeZbmtZLw/hnrnV0eAGb+BmcrbyxaOn+bR
        AI5j5vlsMfjDH2piQU7Ieyw=
X-Google-Smtp-Source: ABdhPJxrmYg9E7PlNU6S/NcVRHhbhYgUmcTnABY3EFdfRr2qVe/DnZVfZQr9mtJb8OZ/E5GFLuMm9Q==
X-Received: by 2002:a5d:548f:: with SMTP id h15mr49416529wrv.99.1638875416097;
        Tue, 07 Dec 2021 03:10:16 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id i17sm2481440wmq.48.2021.12.07.03.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 03:10:15 -0800 (PST)
Message-ID: <836296d0-6eee-7c6b-04d0-d93909948611@gmail.com>
Date:   Tue, 7 Dec 2021 11:10:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] revision: use C99 declaration of variable in for() loop
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20211113122833.174330-1-gotlouemail@gmail.com>
 <20211113130508.zziheannky6dcilj@gmail.com>
 <2b2386b9-045d-a0b8-6dbc-8a9d0c446bea@gmail.com> <xmqq7ddbme7q.fsf@gitster.g>
 <211114.868rxqu7hr.gmgdl@evledraar.gmail.com> <xmqqilwulims.fsf@gitster.g>
 <xmqqpmr2j5lq.fsf_-_@gitster.g>
 <61518213-9ce8-00d2-efd9-7f2091c574c4@gmail.com> <xmqq1r3eym7f.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq1r3eym7f.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/11/2021 07:09, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I like the idea of using a specific test balloon for the features that
>> we want to use but wont this one break the build for anyone doing
>> 'make DEVELOPER=1' because -Wdeclaration-after-statement will error
>> out.
> 
> I think you are missing '?' at the end of the sentence,

sorry yes I am

> but the
> answer is "no, at least not for me".
> 
>      # pardon my "make" wrapper; it is to pass DEVELOPER=1 etc. to
>      # the underlying "make" command.
>      $ Meta/Make V=1 revision.o
>      cc -o revision.o -c -MF ./.depend/revision.o.d -MQ revision.o -MMD -MP  -Werror -Wall -pedantic -Wpedantic -Wdeclaration-after-statement -Wformat-security -Wold-style-definition -Woverflow -Wpointer-arith -Wstrict-prototypes -Wunused -Wvla -fno-common -Wextra -Wmissing-prototypes -Wno-empty-body -Wno-missing-field-initializers -Wno-sign-compare -Wno-unused-parameter  -g -O2 -Wall -I. -DHAVE_SYSINFO -DGIT_HOST_CPU="\"x86_64\"" -DUSE_LIBPCRE2 -DHAVE_ALLOCA_H  -DUSE_CURL_FOR_IMAP_SEND -DSUPPORTS_SIMPLE_IPC -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\"" -DSHA256_BLK  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_SYNC_FILE_RANGE -DHAVE_GETDELIM '-DPROCFS_EXECUTABLE_PATH="/proc/self/exe"' -DFREAD_READS_DIRECTORIES -DNO_STRLCPY -DSHELL_PATH='"/bin/sh"' -DPAGER_ENV='"LESS=FRX LV=-c"'  revision.c
>      $ cc --version
>      cc (Debian 10.3.0-11) 10.3.0
>      Copyright (C) 2020 Free Software Foundation, Inc.
>      This is free software; see the source for copying conditions.  There is NO
>      warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> 
> It would be quite sad if we had to allow decl-after-stmt, only to
> allow
> 
> 	stmt;
> 	for (type var = init; ...; ...) {
> 		...;
> 	}
> 
> because it should merely be a short-hand for
> 
> 	stmt;
> 	{
> 	    type var;
> 	    for (var = init; ...; ...) {
> 		...;
> 	    }
> 	}
> 
> that does not need to allow decl-after-stmt.
> 
> Different compilers may behave differently, so it might be an issue
> for somebody else, but I am hoping any reasonable compiler would
> behave sensibly.
> 
> Thanks for raising a potential issue, as others can try it out in
> their environment and see if their compilers behave well.

Oh it seems I misunderstood exactly what decl-after-stmt does, thinking 
about it your explanation makes sense. I guess that means we have not 
had any warning flags set (because no such flags exist?)  to protect 
against the accidental introduction of the construct that this patch is 
testing compiler support for.

Best Wishes

Phillip


