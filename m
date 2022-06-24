Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890E0C43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 10:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiFXKQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 06:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiFXKQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 06:16:57 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7B47B346
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 03:16:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q9so2479534wrd.8
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 03:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N875zPVFlHcJPHw1hbiFGnVWscs4AixgaFUs72spocM=;
        b=dsYBkPIB9C144immOLMvvsEVFdtv+a9DLasu+OyeSXr1hJ7CAyh3XPUCFccrh/L7gz
         de3s9KIX8aJaudxa7w/LTB04HTsKPfp+cg4MZs8K9UrqmsK3r6GlJuxBjtRGrL1PatCs
         ECIViyXNEtNC8g//2koP5mJ1wZVLyRQl8FZhtcBCC64fpmYePfMJ3ivlS7WzceGAhg/I
         bYocDhw18ybraN1WLj2KVlZdHMJOPQ01YxMsWsCKDEyHnokOTQNBm8ViNqO9+YH9FB12
         DmzSmNdFMryOwluQ/24wJYxuK5qa8FkP26IPlHlSL5nw0zK5590zmtwb1FoEFVlF1DAP
         ixeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N875zPVFlHcJPHw1hbiFGnVWscs4AixgaFUs72spocM=;
        b=hucwzX/jjb5Wo+QAN003SMnXZNmddwUK2KtSEVhHhDibJGz/jKaeJC7egJQyLcBSwX
         fUaVuyvOJdbcrs4OZRmeQ+C9PcpKoO+cdCJHzMYSFyElDK49O8VcMx6O+VXhEpufvqHX
         7cUFpSvra30H9StPP7bYu0qBpbU2OCIFA8nv6VYfMkp/JQE6saXO+Q7rUA3a/rQCI5q6
         LowDfSsMXmTDTpr5TGC5Cj5Yr9ohjuZUbvaWOMdcD9Hzs4YxUocPA/Ls0PpKYe5zm7qs
         RlBuiG/n8Tz9DTTv8JT9Ufnh/ybOvj6Be61OK2QAFJq/lrETC1Qn9PTxwmKHbgGqNRjf
         IWEw==
X-Gm-Message-State: AJIora9g2JyZbsrICfJHIM0/jN3TWV6ZXxcXOOE1TiQNCq5QiaKWMVVC
        ttCbF5PcnRQlec4LfN4DvUY=
X-Google-Smtp-Source: AGRyM1v7/JJP9suMVu84zNkM/pnbbZfNNtJuV69td47h/Z9cewW1vqPS5M7YrP6XyrVYW/yvcYhS2A==
X-Received: by 2002:adf:f84b:0:b0:21b:8e43:b8ba with SMTP id d11-20020adff84b000000b0021b8e43b8bamr12295899wrq.155.1656065814512;
        Fri, 24 Jun 2022 03:16:54 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id x11-20020adff0cb000000b0021b92171d28sm2267799wro.54.2022.06.24.03.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 03:16:54 -0700 (PDT)
Message-ID: <db23bf2a-e661-906f-f8ed-fc2ab3d3ce41@gmail.com>
Date:   Fri, 24 Jun 2022 11:16:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] ls-files: introduce "--format" option
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.1262.v2.git.1655629990185.gitgitgadget@gmail.com>
 <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com>
 <080f65b3-91f5-7b68-4235-4bfb956c8321@gmail.com> <xmqqv8sr1iex.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqv8sr1iex.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/06/2022 16:57, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Thanks for re-rolling, having taken a look a closer look at the tests
>> I'm concerned about the output format for some of the specifiers, see
>> below.
> 
> Thanks for raising these issues.  I agree with you on many of them.
> In addition to what you covered ....
> 
>>> +path::
>>> +	The pathname of the file which is in the index.
>> I think that for all these it might be clearer to say "recorded in the
>> index" rather than "of the file which is in the index"
> 
> I think we would call this "name".  The name of the existing option
> that controls how they are shown is "--full-name", not "--full-path",
> for example.

That's a good point, also I've just noticed that this is another case 
where there is a separator character is printed automatically when the 
format string is expanded. I think it is probably right to format the 
name based on whether or not -z was passed but we should leave it up to 
the user to supply a delimiter in the format string.

>>> +ctime::
>>> +	The create time of file which is in the index.
>>
>> This is printed with a prefix 'ctime:' (the same applies to the format
>> specifiers below) I think we should omit that and just print the data
>> so the user can choose the format they want.
>>
>>> +mtime::
>>> +	The modified time of file which is in the index.
> 
> These are only the low-bits of the full timestamp, not ctime/mtime
> themselves.
> 
> But stepping back a bit, why do we need to include them in the
> output?  What workflow and use case are we trying to help?  Dump
> output from "stat <path>" equivalent from ls-files and compare with
> "stat ." output to see which ones are stale?  Or is there any value
> to see the value of, say, ctime as an individual data item?
> 
>>> +dev::
>>> +	The ID of device containing file which is in the index.
>>> +ino::
>>> +	The inode number of file which is in the index.
>>> +uid::
>>> +	The user id of file owner which is in the index.
>>> +gid::
>>> +	The group id of file owner which is in the index.
> 
> Again, why do we need to include these in the output?
> 
> Wouldn't it be sufficient, as well as a lot more useful, to show a
> single bit "the cached stat info matches what is in the working tree
> (yes/no)"?

That does sound useful

>>> +flags::
>>> +	The flags of the file in the index which include
>>> +	in-memory only flags and some extended on-disk flags.
>>
>> If %(flags) is going to be useful then I think we need to think about
>> how they are printed and document that. At the moment they are printed
>> as a hexadecimal number which is fine for debugging but probably not
>> going to be useful for something like --format. I think printing
>> documented symbolic names with some kind of separator (a comma maybe)
>> between them is probably more useful
> 
> I am guessing that most of the above are only useful for curious
> geeks and those who are debugging their new tweak to the code that
> touches the index, i.e. a debugging feature.  But these folks can
> run "git" under a debugger, and they probably have to do so when
> they are seeing an unexpected value in the flags member of a cache
> entry anyway.  So I am not sure whom this field is intended to help.

I wondered about that as well, but thought there might be a plausible 
use if someone wants to check if an entry is marked intent-to-add, or 
has the skip-worktree/spare-index bits set (are there other ways to 
inspect those?)

Best Wishes

Phillip
