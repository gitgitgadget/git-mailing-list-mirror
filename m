Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678A6C433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 22:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444722AbiEFW2W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 18:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351131AbiEFW2U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 18:28:20 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DA347548
        for <git@vger.kernel.org>; Fri,  6 May 2022 15:24:36 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t11so7036131qto.11
        for <git@vger.kernel.org>; Fri, 06 May 2022 15:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rHsKqkwmc+jxsW6UqIJe7+wamPrRlVExUeedGOw4tvw=;
        b=X0SMfdVziayOE541jewRYpDOY8gMVFnx5e01wfyfBpOmb5ux7f/V4oHiS7Karm12Mt
         3uJsC3dER4la12f102jnKimLYeZptKk/bJk+AHfXgdSWKIOr2bU3RGliFjFTx/k5qvTO
         Rcgw4pe2/h8AaWkfMzrOFeijXePHjmY3UqBvyUkyVncOWJ9N1ZnlDRtDsZl1X36K4kHM
         9yGq7xYgm75c4PpqMb4oGIPsCswqCs10M2IOXZZliAGmA5jLVTLdjQqjvICOcK3INPfd
         qGap0tIALMb7d9H+lfnkleTwecSCuPo4byU7tupxaPOZFa9UkWNO3EohyoIFmZWQTZ8I
         +a8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rHsKqkwmc+jxsW6UqIJe7+wamPrRlVExUeedGOw4tvw=;
        b=HjiGEEmFcvCGY44Z5fxq31+TWFN+qgKKcoruSb3sQZLuiDrGZp+S3xGdl4+urHS9Eo
         uiyJdk3SrNj3WM35LlcIf80SKDlkMv8x19wLtc/mPMjXK0uws/xrAc9HQAR66jqELf19
         iv5/5qRdJ/9vr74eP47yey4iy3oF1JJTWx5eZNvDX0Ra5edvfiUkIpMK3uxRQxu/DxV2
         22SUx9z+5wFShFBPkAdN/ZBNN+s/niKapcFWaDiPna7hUA9F1Jv5IHYnHrVgH3lVzchD
         UzcNVt2hhgi0MpjRkWv64VAfSTb4cnnI9maNv1jbXQbUbFv9u8k69bJX4dmyQGx8+b4F
         dSSw==
X-Gm-Message-State: AOAM530792rNimkHL7hunS/oC8B9UVQHRPstqAwrXCY3RGU/aXgt3TMR
        EsPjxYxmRr6eil9Kc6imbeadJmdxrgo=
X-Google-Smtp-Source: ABdhPJxy+su4rQ6Iqtsi8o5ClWAqCxhuma8EKX1QseK+e4vZMMZl3IqfufLFhnc3LhfsG3UnV0XwVA==
X-Received: by 2002:a05:622a:1984:b0:2f3:b9bf:64b2 with SMTP id u4-20020a05622a198400b002f3b9bf64b2mr5022054qtc.472.1651875874825;
        Fri, 06 May 2022 15:24:34 -0700 (PDT)
Received: from [192.168.50.110] (modemcable064.93-201-24.mc.videotron.ca. [24.201.93.64])
        by smtp.gmail.com with ESMTPSA id 16-20020a05620a06d000b0069fc13ce1dbsm3018099qky.12.2022.05.06.15.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 15:24:34 -0700 (PDT)
Subject: Re: Bug Report: fetch.recurseSubmodules doesn't affect git pull as
 otherwise stated in the git config docs
To:     Glen Choo <chooglen@google.com>,
        Huang Zou <huang.zou@schrodinger.com>, git@vger.kernel.org
References: <CAFnZ=JNE_Sa3TsKghBPj1d0cz3kc6o91Ogj-op8o6qK8t9hPgg@mail.gmail.com>
 <fc492627-c552-10ec-b30c-820299241278@gmail.com>
 <kl6lbkwa8h5n.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <b4d7600e-ed4e-b4b3-262a-a69818c25365@gmail.com>
Date:   Fri, 6 May 2022 18:24:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <kl6lbkwa8h5n.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen!

Le 2022-05-06 à 17:50, Glen Choo a écrit :
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
> 
>> Hi Huang,
>>
>> Le 2022-05-02 à 10:42, Huang Zou a écrit :
>>> Thank you for filling out a Git bug report!
>>> Please answer the following questions to help us understand your issue.
>>>
>>> What did you do before the bug happened? (Steps to reproduce your issue)
>>> 1) Set the following configs:
>>>  git config submodule.recurse true
>>>  git config fetch.recurseSubmodules false
>>> 2) On a repo with submodules, run:
>>> git pull
>>>
>>> What did you expect to happen? (Expected behavior)
>>> git pull doesn't recursively fetch submodules
>>>
>>> What happened instead? (Actual behavior)
>>> Submodules are fetched recursively
>>>
>>> What's different between what you expected and what actually happened?
>>> Submodules are fetched recursively
>>>
>>> Anything else you want to add:
>>> git fetch works as intended. The documentation for fetch.recurseSubmodules
>>> states that "This option controls whether git fetch (and the underlying
>>> fetch in git pull)" so I would naturally expect git pull to behave the same
>>> as git fetch
>>
>> I did not try to reproduce, but I took a look at the code and I think I understand
>> what happens. 
>>
>> When 'git pull' invokes 'git fetch', it does so by specifically using the '--recurse-submodules'
>> flag, see [1]. It sends either 'yes', 'no' or 'on-demand' as value, depending on the value
>> of the local variable 'recurse_submodules'. This variable is initialized to the config value
>> of 'submodule.recurse' in 'git_pull_config' [2], called at [3], and then overwritten by the value given
>> explicitely on the command line [4], parsed at [5].
>>
>> So when 'git fetch' runs when called by 'git pull', it always receive the 
>> '--recurse-submodules' flag, and thus any config for fetch.recurseSubmodules is ignored
>> (since explicit command line flags always have precedence over config values).
> 
> Thanks for looking into this! This seems to agree with my reading of the
> code. I haven't tried to reproduce it either, but the code looks
> obviously incorrect.
> 
>> So one way to fix this would be to also parse 'fetch.recurseSubmodules' in 'git_pull_config',
>> and send the correct value to the 'git fetch' invocation... Or simpler, call 'git fetch' with
>> '--recurse-submodules-default' [9] instead...
> 
> Despite having touched this code fairly recently, I had to do quite a
> rereading to refresh myself on how this works. If I _am_ reading this
> correctly, then I think we actually want to set `--recurse-submodules`
> and not `--recurse-submodules-default`.
> 
> The short story is that the two are not equivalent - when figuring out
> _which_ submodules to fetch (we determine on a submodule-by-submodule
> basis; we don't just say "should we fetch all submodules?"),
> `--recurse-submodules-default` gets overrided by config values, but
> `--recurse-submodules` does not.
> 
> The longer story (which I think is quite difficult to explain, I am also
> a little confused) is that in a recursive fetch,
> `--recurse-submodules-default` is the value of the parent's (we'll call
> it P) `--recurse-submodules`. This only matters when a process, C1, has
> to pass a value for `--recurse-submodules` to its child, C2. The
> precedence order is:
> 
> - C1's --recurse-submodules | fetch.recurseSubmodules |
>   submodule.recurse
> - C2's submodule entry in C1's .git/config
> - C2's entry in C1's .gitmodules
> - C1's --recurse-submodules-default (aka P's --recurse-submodules)
> 
> Specifically, in code:
> 
>   static int get_fetch_recurse_config(const struct submodule *submodule,
>               struct submodule_parallel_fetch *spf)
>   {
>     // Glen: passed in from builtin/fetch, which parses
>     //  --recurse-submodules, fetch.recurseSubmodules, submodule.recurse
>     if (spf->command_line_option != RECURSE_SUBMODULES_DEFAULT)
>       return spf->command_line_option;
> 
>     if (submodule) {
>       // ...
>       // Glen: fetch configuration from .gitmodules
>       int fetch_recurse = submodule->fetch_recurse;
> 
>       key = xstrfmt("submodule.%s.fetchRecurseSubmodules", submodule->name);
>       if (!repo_config_get_string_tmp(spf->r, key, &value)) {
>         // Glen: fetch configuration from .git/config
>         fetch_recurse = parse_fetch_recurse_submodules_arg(key, value);
>       }
>       // ...
>     }
> 
>     // Glen: --recurse-submodules-default
>     return spf->default_option;
>   }
> 
> So `--recurse-submodules-default` really wasn't meant for anything other
> than "fetch" invoking itself in a superproject-submodule setting.
> 
> Of course, I could be entirely wrong and I should just write up a test
> case :). I hope to send one soon.

OK so it's more complicated than I thought (I'm not surprised :P). Thanks for 
the details.

The other thing I thought about, is that even if '--recurse-submodules-default'
worked as I thought it did when I wrote this, it would still not be the right
thing to change builtin/pull to invoke 'git fetch' with it instead, since then
a user invoking e.g. 'git pull --recurse-submodules=false', who has 'fetch.recurseSubmodules=true',
would not get a recursive fetch, since the internal fetch would prioritise 'fetch.recurseSubmodules=true',
but that's contrary to user expectation that command-line flags override config, always...
So whatever is done to fix this, we might need to keep track of where 'recurse_submodules'
was set from, either the command-line or the config.

> 
>> [sidenote]
>> I'm thought for a while that it was maybe not a good idea to change the behaviour
>> in your specific situation. If you have 'submodule.recurse'
>> set to true and 'fetch.recurseSubmodules' set to false, and if the code is changed so that indeed
>> 'git pull' does not fetch recursively, then the code will still try to update the submodule working
>> trees after the end of the operation (merge or rebase), see the end of 'cmd_pull' [6], [7]. This  is
>> OK, because if there are new submodule commits referenced by the superproject and they were not fetched because the 
>> fetch was not recursive, then the call to 'git submodule update' in update_submodules/rebase_submodule
>> should fetch them, so no problem there.
>> [/sidenote]
> 
> I think the bigger question to ask is "what is the intended effect of
> 'submodule.recurse = true' and 'fetch.recurseSubmodules = false'?".

Yes, I agree that it would be nice if Huang clarified that as I'm not sure
either of the use case.

> I
> think it is not surprising to think that recursive worktree operations
> might fail if the submodule commits weren't fetched.

Yes, if ever 'merge' and 'rebase' are taught to obey 'submodule.recurse'
(if only I had time to work on that!), then all hell would break loose
if submodule commits were not fetched when these operations start.

> 
> Perhaps this is just a performance optimization? i.e. after fetching in
> the superproject, the user wants to skip the rev walk that discovers new
> submodule commits.
> 


Cheers,
Philippe.
