Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C0CC433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 19:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbiAMTCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 14:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237805AbiAMTCj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 14:02:39 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270E1C061574
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 11:02:39 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id i30so669976pgl.0
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 11:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T5jFjepakdxKRum5dqzTHHPgvS6d1lGrBEOWuK/hxKc=;
        b=RrREZLUQ6UW9zgs88fMrQCAGqQR4yfHIRV9PPxJFpEsrfrKVbe2Ia7+m2UWRZAeK6T
         LG0Jn2q/J8QLFdSDBPpXqbvyxrCAdlkSl2CadUmRgzci+Jhd6/2qw7YganY4qKHqGveQ
         fXp8eXpyfUX0yhVahy9PRUjH9FIs9OOZBemZn9Qwcrut/kKyR2X4ZzWoG2rE0ZXj2DKX
         t/DP7E5AUuPSuUB+3DYZgZO3MU9EtgbmqIGir5gxhmOhHwmkSumafcJnNCMPbin6bQm+
         KKO0pb0KTS3kKMiUZx5uNLU24UxcHmgXhfxhL/nK00CHrN3VkMpaDVt+LOaR8cDhJMkV
         9z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T5jFjepakdxKRum5dqzTHHPgvS6d1lGrBEOWuK/hxKc=;
        b=QKNTX2VqCmyLwbiCTucOQJPbSrt5AQTfnyQ1+SA6U7lkwEE96GPGxiN05z0Oh+j2ZL
         9Akzqh/wcOtFyFfP/z2aQJux6kAXnGtSSfHa1ex815YFE8iQs8Xl8pnzxH/3aXiFhPEG
         6fwH8NUnoOCCUCN7bG78CsOR3MrHHr8pvWzoG2wy0XrsL+wYSTrMARP4MOADprd1ACDo
         LdlK2NkZ7dh94YFjvOEjF7lFTiXMN3J7cqrnMpX3ueDApDI/J1ymk34LDkYAPBzW3AFf
         NIwK4iZfOOiXVvSHv0YHjuDGebvFXPNie9EDkBbPoJifez2AiTbrKaOO2DgMiQqWH7vB
         RyRw==
X-Gm-Message-State: AOAM532TWnuQowsoFiUiGonoHXmL5i2gVcAJk/34mLRB3FQtLJPbqF84
        9fKJau2OUOBEh8YHvGB6PYY=
X-Google-Smtp-Source: ABdhPJzsqXKorfdzuPyv6+DRzOeVvcdEtbtVKUr0RZP3vpq1gYNIPvEH/PfyPuj73QwNm6s6eSul1A==
X-Received: by 2002:a63:6d89:: with SMTP id i131mr5040055pgc.318.1642100558577;
        Thu, 13 Jan 2022 11:02:38 -0800 (PST)
Received: from ?IPV6:2601:602:9e81:12c0:29c0:e427:4ddf:b329? ([2601:602:9e81:12c0:29c0:e427:4ddf:b329])
        by smtp.gmail.com with ESMTPSA id s8sm3417310pfu.58.2022.01.13.11.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 11:02:38 -0800 (PST)
Message-ID: <92368b84-1d82-b594-9232-e67abcffe18a@gmail.com>
Date:   Thu, 13 Jan 2022 11:02:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v3 3/3] sparse-checkout: limit tab completion to a single
 level
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
 <aa9ea67180dd10ef8bdf17e8c23694da15828b21.1641841193.git.gitgitgadget@gmail.com>
 <0e4bb6f1-337e-38b3-75b2-fe11ff8d68b2@gmail.com>
 <CABPp-BEvUCPzcWhuVP==Rk=2pJXxRSGZVjdEzPuzbwTcw7kMRQ@mail.gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <CABPp-BEvUCPzcWhuVP==Rk=2pJXxRSGZVjdEzPuzbwTcw7kMRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/12/22 6:38 PM, Elijah Newren wrote:
> On Wed, Jan 12, 2022 at 3:43 PM Lessley Dennington
> <lessleydennington@gmail.com> wrote:
>>
>>> +__gitcomp_directories ()
>>> +{
>>> +     local _tmp_dir _tmp_completions
>>> +
>>> +     # Get the directory of the current token; this differs from dirname
>>> +     # in that it keeps up to the final trailing slash.  If no slash found
>>> +     # that's fine too.
>>> +     [[ "$cur" =~ .*/ ]]
>>> +     _tmp_dir=$BASH_REMATCH
>>> +
>>> +     # Find possible directory completions, adding trailing '/' characters
>>> +     _tmp_completions="$(git ls-tree -d --name-only HEAD $_tmp_dir |
>>> +         sed -e s%$%/%)"
>>> +
>> I am admittedly unfamiliar with the use of this format in sed expressions
>> (I'm generally more accustomed to '/' instead of '%'). It's definitely
>> working as it should, I'm just not quite sure of how.
> 
> These are the same in sed:
>     sed -e s/apple/banana/
>     sed -e s@apple@banana@
>     sed -e s%apple%banana%
> 
> You can pick any character you like, but '/' is what people most often
> use.  My expression involved a '/', though, so I changed the delimiter
> to avoid ugly backslash escapes.
> 
Got it, thanks!
>>> +     if [[ -n "$_tmp_completions" ]]; then
>>> +         # There were some directory completions, so find ones that
>>> +         # start with "$cur", the current token, and put those in COMPREPLY
>>> +         local i=0 c IFS=$' \t\n'
>> Does c need to be declared before the loop?
> 
> It was, but it's super easy to miss.  Look at the "local" line just
> before your comment; it almost reads like line noise, but basically
> there are three variables declared with two of them given initial
> values.  c is in the middle, without an initial value.
> 
Sorry, I should have made my question clearer - I saw that c is declared
before the loop but was wondering if that was actually necessary. I
removed it locally and ran the tests, which seemed to work without it.
>>> +         for c in $_tmp_completions; do
>>> +             if [[ $c == "$cur"* ]]; then
>>> +                 COMPREPLY+=("$c")
>>> +             fi
>>> +         done
>>> +     elif [[ "$cur" =~ /$ ]]; then
>>> +         # No possible further completions any deeper, so assume we're at
>>> +         # a leaf directory and just consider it complete
>> Thank you so much for the detailed comments on this change - it made it
>> really easy to parse.
>>> +         __gitcomp_direct_append "$cur "
>> What's the reason for the trailing space here?
> 
> The space was related to the "just consider it complete" aspect of the
> comment above.  Anyway, to understand why the space character signals
> the completion being final for this token, let's use some comparisons
> with bash-completion of just a plain 'ls' command...
> 
> In git.git, at the toplevel, if I type
>    ls README.md <TAB>
> (note the space after README.md before pressing <TAB>), then
> completion assumes I'm trying to get another term besides just
> README.md, and can complete on anything in the directory.  In
> contrast, if I type
>     ls README.md<TAB>
> (with no space between README.md and <TAB>), then completion figures
> I'm trying to find filenames that start with "README.md", finds only
> one, and returns "README.md " (note the trailing space).  That
> trailing space makes my command line become "ls README.md " (again,
> with a trailing space), so that if I try to do any more tab
> completions, it's for adding another argument to the ls command, not
> extending the README.md one.
> 
> You can see similar things with ls and directories.  For example, if you type
>    ls Doc<TAB>tec<TAB>m<TAB>
> 
> then you'll note after the first <TAB> you'll see
>    ls Documentation/
> with no trailing space; after the second <TAB> you'll see
>    ls Documentation/technical/
> with no trailing space; and after the third <TAB> you'll see
>    ls Documentation/technical/multi-pack-index.txt
> WITH a trailing space.  In the first two cases, further completions
> were possible so they didn't add a trailing space to signify the
> completion was final, but in the third case it is final and needed the
> trailing space to denote that.
> 
> Does that help?
> 
Yes, very much! Thank you.
>>> +     fi
>>> +}
>>
>> Added my review as mentioned in [1].
>>
>> [1]:
>> https://lore.kernel.org/git/pull.1108.v2.git.1640892413.gitgitgadget@gmail.com/T/#md3da435452988b0366ab4c2ee4bc06df2d17cb36
