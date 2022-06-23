Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4398EC43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 14:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiFWOGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 10:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiFWOGj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 10:06:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F633DDCC
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 07:06:38 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so1601290wma.4
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 07:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UPrLYVA0ITrSkCwVVri3/sfBSNGq7/JRNa5X+An1PYI=;
        b=qyhE6s6N7FiPJKvDSe//qg6BpbOH/BXSS27xJO9VaRNYMwb4GWhMEDDOAlvFjOpXup
         JoQXPvGcb2zFqIZOYq04uFOWLCKFSu5pQcl7WLR6lZ+uibOC+xlaNeJrQmb3xTWUH/nn
         IFn7UYPnQOpaDTI2B48bSmdM54LWaYfcYfjVIS2MR/7ALXAILE7y2y9SzYRiam+bgW3Z
         UAwFWOjJG2hyLBFblZQtGqGUrhO4rEyjiosL0VoYaO4D0vU2gbrwjwrlWFmmDd4e4gXm
         7Vr2GkuvArPgtg0Ki4t7FqBJnwwr2OOKTMGyUBgLlDP66aumZbb4OkUkNzUMOo+8ty2F
         5mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UPrLYVA0ITrSkCwVVri3/sfBSNGq7/JRNa5X+An1PYI=;
        b=zECljynm981WafheHtIPrUc4AQmdOq799qVRFB5NZ4jHvsGii+tmKJTX3B9tPWyFmx
         qAJ39aV1Hg8KC82yUlDWenFZZPa5unP0jM/Hqw7m63dEjxub+kAr9FK8dpVF0iSYhLve
         2cBCfNEuDsibcVo+OBFSm7BDECifj1M5n7DNJK0IpBQZ8toSLZ3rhggi6s6walKwH1JH
         Ai1/1FztaWfY/GrBegh9+dXzcCw4cKMSS3pTt2epK8W1Q4TT1XsRTZeMxU2Uvjobi/1k
         i6ab4cQj2aCFVB3e3nuseKevE4ootRE/Dkd4kV5ni6fZ/N+YZK/pgmIQMRwbUBVGnRhu
         Jrlg==
X-Gm-Message-State: AJIora9njnA09QqnnyWm23WEUyDRPswqNMdPAW4y+sPJK6pHTIXFsNKv
        tS9yjvsR/IIUxlJIIw+lsHA7/jMHpJs=
X-Google-Smtp-Source: AGRyM1upKbk5slh8L49OjsahuThHO3jKcejZIK/+dSc7N7DPO4RK/jPtV+RTGmC+jv7EG1KSqdDiXQ==
X-Received: by 2002:a05:600c:4e07:b0:39e:dbf7:5813 with SMTP id b7-20020a05600c4e0700b0039edbf75813mr4417979wmq.56.1655993196277;
        Thu, 23 Jun 2022 07:06:36 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id o4-20020adfcf04000000b0020ff877cfbdsm19763677wrj.87.2022.06.23.07.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 07:06:35 -0700 (PDT)
Message-ID: <080f65b3-91f5-7b68-4235-4bfb956c8321@gmail.com>
Date:   Thu, 23 Jun 2022 15:06:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] ls-files: introduce "--format" option
Content-Language: en-GB-large
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.1262.v2.git.1655629990185.gitgitgadget@gmail.com>
 <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi ZheNing

On 21/06/2022 03:05, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>
> 
> Add a new option --format that output index enties
> informations with custom format, taking inspiration
> from the option with the same name in the `git ls-tree`
> command.
> 
> --format cannot used with -s, -o, -k, --resolve-undo,
> --deduplicate and --debug.
> 
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>      ls-files: introduce "--format" options
>      
>      v2->v3:
>      
>       1. remove %(tag) because -t is deprecated, suggested by Phillip.
>       2. fix some description of atoms in document, suggested by Phillip..

Thanks for re-rolling, having taken a look a closer look at the tests 
I'm concerned about the output format for some of the specifiers, see below.

> [...]  
> +It is possible to print in a custom format by using the `--format`
> +option, which is able to interpolate different fields using
> +a `%(fieldname)` notation. For example, if you only care about the
> +"objectname" and "path" fields, you can execute with a specific
> +"--format" like
> +
> +	git ls-files --format='%(objectname) %(path)'
> +
> +FIELD NAMES
> +-----------
> +Various values from structured fields can be used to interpolate
> +into the resulting output. For each outputting line, the following
> +names can be used:
> +
> +objectmode::
> +	The mode of the file which is in the index.
> +objectname::
> +	The name of the file which is in the index.
> +stage::
> +	The stage of the file which is in the index.
> +eol::
> +	The <eolinfo> and <eolattr> of files both in the
> +	index and the work-tree.

Looking at the test for this option I think it needs more work, why 
should --format arbitrarily append a tab to the end of the output? - the 
user should be able to specify a separator if they want one as part of 
the format string. Also I'm not sure why there is so much whitespace in 
the output.

> +path::
> +	The pathname of the file which is in the index.

I think that for all these it might be clearer to say "recorded in the 
index" rather than "of the file which is in the index"

> +ctime::
> +	The create time of file which is in the index.

This is printed with a prefix 'ctime:' (the same applies to the format 
specifiers below) I think we should omit that and just print the data so 
the user can choose the format they want.

> +mtime::
> +	The modified time of file which is in the index.
> +dev::
> +	The ID of device containing file which is in the index.
> +ino::
> +	The inode number of file which is in the index.
> +uid::
> +	The user id of file owner which is in the index.
> +gid::
> +	The group id of file owner which is in the index.
> +size::
> +	The size of the file which is in the index.
> +flags::
> +	The flags of the file in the index which include
> +	in-memory only flags and some extended on-disk flags.

If %(flags) is going to be useful then I think we need to think about 
how they are printed and document that. At the moment they are printed 
as a hexadecimal number which is fine for debugging but probably not 
going to be useful for something like --format. I think printing 
documented symbolic names with some kind of separator (a comma maybe) 
between them is probably more useful

 > [...]
> +test_expect_success 'git ls-files --format eol' '
> +	printf "i/lf    w/lf    attr/                 \t\n" >expect &&
> +	printf "i/lf    w/lf    attr/                 \t\n" >>expect &&
> +	git ls-files --format="%(eol)" --eol >actual &&

I'm not sure why this is passing --eol as well as --format='%(eol)' - 
shouldn't that combination of flags be an error?

Best Wishes

Phillip
