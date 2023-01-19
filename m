Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C827C004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 16:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjASQTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 11:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjASQSy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 11:18:54 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C8784560
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 08:18:44 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w14so3498389edi.5
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 08:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E5SYMT3+jM+Ux7x3FpMlQPgz1DavVaVJGe7oEKR4WLY=;
        b=gbo59ePnrDZUJLVR6c479zlJHNCXgGitTfdaVkvvR8hAMm+bAtIHsHOQB/j42LCEWr
         EAixWKAPcx9cQy6cDCuxL3xPZLpaixi1l+ThPMltbVjL67Zu6dVhdyHRZ0IH1idh0JIl
         6tE9rGokD78hvu9BwB5LO7Ri5gGh9of6ssBTj5dUvTD8HHS0BhG1XZVNMevgARhrEgDF
         NzGvKuRwB5bAoxLovgBi72QjdtQeNvs+MSY88wNiDSexbk7ksjUz5H1sobtaYNmHGgj5
         K44AKw6Puet8gdfomubQWEVTJgUcsmeq2Di3p+UFRa/5jWGq3SMhChI/9OH+GDjJ5nGk
         GgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5SYMT3+jM+Ux7x3FpMlQPgz1DavVaVJGe7oEKR4WLY=;
        b=ll4HmsACQxl+iVKwVCHwbVmmuutZZkXbYEJTTu+lk5YrAmOJu0wxdPsvp5n3vLndkp
         oX9rY07S+yIqzSLVuSu88nKKgGzN7g12XXgQSERL8bLoP/JwAJUVln0XPiYdnrEPSsAr
         /Gyi07MP58wHy3vdhHmPwote42IiBXeXA1raUXAP+kjkvuNA4GFNkiiQTFJBQfZr29bg
         FNVpjeY2EJ7EnmNp+Lkmip7Ld6S9YUfpxp/7eKogDWkS55kNj2aB0AFN8/0LDm1mEJu4
         A9TN6OFVJJQyJi0snLqB2j6LGkKWBtzoVUQsZkr1gKVTg1EJUX7FVzv0RvsEa3j7+B/1
         UT6g==
X-Gm-Message-State: AFqh2kqWQLkrdmxwHIzgXnrflr58gcfUAaZQYB/6XcEGpA6mf2bSRoF2
        M48+qc4J1JV8WzwnBMoPuTw=
X-Google-Smtp-Source: AMrXdXsm9XqlSHtxHAdFnhBe55umpzB8T62C4WTIX1YyCy+RSUB3lBfwez2mLkxoJJ7myUfhzibEfQ==
X-Received: by 2002:a05:6402:3224:b0:45c:834b:f287 with SMTP id g36-20020a056402322400b0045c834bf287mr13340892eda.4.1674145123448;
        Thu, 19 Jan 2023 08:18:43 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id d26-20020a056402401a00b0046c7c3755a7sm2465771eda.17.2023.01.19.08.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 08:18:43 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <df2c0ae0-0654-a3e1-cc02-be2d970ea287@dunelm.org.uk>
Date:   Thu, 19 Jan 2023 16:18:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 3/4] worktree add: add --orphan flag
Content-Language: en-US
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221220023637.29042-1-jacobabel@nullpo.dev>
 <20221228061539.13740-1-jacobabel@nullpo.dev>
 <20230107045757.30037-1-jacobabel@nullpo.dev>
 <20230109173227.29264-1-jacobabel@nullpo.dev>
 <20230109173227.29264-4-jacobabel@nullpo.dev>
 <e5aadd5d-9b85-4dc9-e9f7-117892b4b283@dunelm.org.uk>
 <20230114224715.ewec6sz5h3q3iijs@phi>
 <70a01a52-f16c-e85f-297e-c42a23f95a9a@dunelm.org.uk>
 <20230118224020.vrytmeyt3vbanoh2@phi>
In-Reply-To: <20230118224020.vrytmeyt3vbanoh2@phi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/01/2023 22:40, Jacob Abel wrote:
> On 23/01/16 10:47AM, Phillip Wood wrote:
>> Hi Jacob
>>
>> On 14/01/2023 22:47, Jacob Abel wrote:
>>> On 23/01/13 10:20AM, Phillip Wood wrote:
>>>> Hi Jacob
>>>>
>>> [...]
>>>
>>> I'll reply to this message with the one-off patch to get feedback. Since this is
>>> essentially a discrete change on top of v8, I can either keep it as a separate
>>> patch or reroll depending on how much needs to be changed (and what would be
>>> easier for everyone).
>>>
>>>> 	git worktree add --orphan -b topic main
>>>> 	git worktree add --orphan -B topic main
>>>
>>> I am hesitant to add these as they break away from the syntax used in
>>> `git switch` and `git checkout`.
>>
>> When I wrote my original email I wrongly though that --orphan did not
>> take an argument for "git checkout". While I think it is a mistake for
>> checkout and switch to have --orphan take an argument they do at least
>> always need a branch name with that option. "git worktree" add already
>> has the branch name in the form of the worktree directory in the common
>> case.
> 
> Understood.
> 
> I'm not entirely opposed to making this change to OPT_BOOL but I have to wonder
> how often `--orphan` will actually be used by a given user and whether the
> slightly shorter invocation will be used regularly.
> 
> With the base `git worktree add $path`, the shorthand/DWYM makes sense as it's
> used regularly but I don't see users working with `--orphan` outside of trying
> to create the first branch in a repository.

Your example use in the commit message shows the user using the same 
name for the branch and worktree. If that really is the likely use than 
I think we should make --orphan OPT_BOOL. If it is not the likely use 
perhaps you could update the commit message to show how you think it 
will be used.

> And I'd like that operation of creating the first branch in a repo to eventually
> "just work" with the base command, i.e. `git worktree add main/`. The reason I
> hadn't yet added that is because I've yet to figure out how to get it to work
> without accidentally introducing potentially confusing situations and I didn't
> want to hold up introducing the core functionality itself.
> 
> Once that main use-case "just works", I don't see users utilising `--orphan`
> except in very rare circumstances. Doubly so since the average user likely
> shouldn't be using `--orphan` in most cases.

This brings us back to the question that we discussed earlier of whether 
we need --orphan at all. If we can get the main use-case working without 
it we'd perhaps be better doing that rather than adding an option no one 
ends up using.

Best Wishes

Phillip

> Hence the question of whether this change would be worth it vs the existing
> `--orphan $branchname $path` which is (for better or worse) consistent with `-b`
> and `-B`.
> 
>>
>>> Also apologies for the tangent but while researching this path, I noticed that
>>> --orphan behaves unexpectedly on both `git switch` and `git checkout` when mixed
>>> with `-c` and `-b` respectively.
>>>
>>>       % git switch --orphan -c foobar
>>>       fatal: invalid reference: foobar
>>>
>>>       % git switch -c --orphan foobar
>>>       fatal: invalid reference: foobar
>>>       % git checkout -b --orphan foobar
>>>       fatal: 'foobar' is not a commit and a branch '--orphan' cannot be created from it
>>>
>>>       % git checkout --orphan -b foobar
>>>       fatal: 'foobar' is not a commit and a branch '-b' cannot be created from it
>>
>> The messages for checkout look better than the switch ones to me as they
>> show the branch name which makes it clearer that we're treating what
>> looks like an option as an argument. What in particular is unexpected
>> here - --orphan and -b take an argument so they'll hoover up the next
>> thing on the commandline whatever it is.
>>
>> Best Wishes
>>
>> Phillip
>>
>>> [...]
> 
> Agreed. I wasn't sure if this would be something worth addressing in a patch but
> at the very least I can work on putting together a small patch for `git switch`
> since it doesn't seem to be hoovering the flags like `git checkout` does.
> 
