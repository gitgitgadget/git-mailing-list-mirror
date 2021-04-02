Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B87C433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 13:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4442C610A0
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 13:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbhDBNKV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 09:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBNKV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 09:10:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3939C0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 06:10:19 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id f8so1382894edd.11
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 06:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s//WqQEIJGsyTTGrGTsvqk2dbFg8cPRvy5YIyFdh1Lk=;
        b=pTuILbBkUzY2L6Exg4HXTxO7OdH97H2TwUdSAeB4RSj/zeNr9mqDRjdURka3EhEs+L
         qLK24q9F6jynA6tEO+etvsG+VJC1DlFCzRtYV6VOotSvJH4AWWhNhIoWJlgFd7Vmpxfr
         BxZhTDrQP1aypfOPrGs2RZge/LkcQnRzONcGakuSXWXpPVZbfj0q4Mdtj49eH1iiAOlM
         jIFzo8AYbCnPMf9xG1os1mt/fZ5Xs7P/DrKtj+4WnnUL39+33AbSyT1nYNXmzHlZATaQ
         mcD295NmajqsY+NGdG8lWNIaFfcqgAtFK5VuxCFOVPDa2M0qSl4dPuUWwFD6FQ8Jktq6
         RrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s//WqQEIJGsyTTGrGTsvqk2dbFg8cPRvy5YIyFdh1Lk=;
        b=iJS0dOid8gdMFKY+NcFMItArjGdd4O8gVvtapoOIaYtb0549bIXRB8rv2QOkGUB02J
         m2zNyAQn/J5G/3s/cnGqeyEKvX4Nmxfc6ho324Hp09eJkqpb9jjKJRmmh/jqbAAa3/cF
         eUNwPvNnH2UNkgP8UsDBXiJGzDNQaurAAHirx2wzm99E9RJIDXgKNFdZKW6z1vjoA6NX
         Kg7OOpGH5zPGlpwnQpvHhg8ba2rOsShZJTmYynQYL3BK7PNlZ3FpZ9twsnRikzvtHf66
         avWN7UNezVvQEcB21Jb0vzaXRRJAHnTi5zDxg3xCR5Z3vlLA6eDSsLMpGv3iAopAo+zD
         VzsQ==
X-Gm-Message-State: AOAM533OwKIolvciI2WdGzDwe9LhSON43J68a3Pdr7s72H6WK3htnz2C
        iph0KR/CS/c96jy+4uprYwE=
X-Google-Smtp-Source: ABdhPJw9PT3VIExAWaWTi3YxVyuPGQQUPykC9wkjKU+buKxxe5c0Srs4fkE5tJya836bX/6q8PwsIQ==
X-Received: by 2002:a05:6402:3495:: with SMTP id v21mr15138017edc.117.1617369018558;
        Fri, 02 Apr 2021 06:10:18 -0700 (PDT)
Received: from [192.168.1.201] (243.20.198.146.dyn.plus.net. [146.198.20.243])
        by smtp.googlemail.com with ESMTPSA id d1sm4191142eje.26.2021.04.02.06.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 06:10:17 -0700 (PDT)
Subject: Re: unifying sequencer's options persisting, was Re: [PATCH v2]
 sequencer: fix edit handling for cherry-pick and revert messages
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com>
 <pull.988.v2.git.git.1617070174458.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2103301200020.52@tvgsbejvaqbjf.bet>
 <CABPp-BGwAtpsQJ8U5N1q21PMkideptY2MB2PNgbPqvya+XuyHg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2103311533340.52@tvgsbejvaqbjf.bet>
 <3b117e65-bf9f-af13-b093-28bbbd6f9bb3@gmail.com>
Message-ID: <b0375013-e287-06b1-2718-3736fc1b73e7@gmail.com>
Date:   Fri, 2 Apr 2021 14:10:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <3b117e65-bf9f-af13-b093-28bbbd6f9bb3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

one more thought below...

On 02/04/2021 12:28, Phillip Wood wrote:
> Hi Dscho and Elijah
> 
> On 31/03/2021 14:48, Johannes Schindelin wrote:
>> Hi,
>>
>> On Tue, 30 Mar 2021, Elijah Newren wrote:
>>
>>> On Tue, Mar 30, 2021 at 3:13 AM Johannes Schindelin
>>> <Johannes.Schindelin@gmx.de> wrote:
>>>
>>>> I'll allow myself one tangent: the subject of the sequencer's Unix
>>>> shell script heritage seems to come up with an increasing frequency,
>>>> in particular the awful "let's write out one file per setting"
>>>> strategy.
>>>>
>>>> I would _love_ for `save_opts()` to write a JSON instead (or an INI
>>>> via the `git_config_*()` family of functions, as is done already by
>>>> the cherry-pick/revert stuff), now that we no longer have any shell
>>>> script backend (apart from `--preserve-merges`, but that one is on its
>>>> way out anyway).
>>>>
>>>> The one thing that concerns me with this idea is that I know for a
>>>> fact that some enterprisey users play games with those files inside
>>>> `<GIT_DIR>/rebase-merge` that should be considered internal
>>>> implementation details. Not sure how to deprecate that properly, I
>>>> don't think we have a sane way to detect whether users rely on these
>>>> implementation details other than breaking their expectations, which
>>>> is not really a gentle way to ask them to update their scripts.
> 
> I think it depends if users are just reading the files or writing to 
> them. If they are reading them (which my scripts do) then we could 
> continue to write the important files along side the new single-file 
> that git actually reads. I think there is a distinction between the 
> files such as git-rebase-todo which hold state and the one-line files 
> which hold the options passed by the user. For example I have scripts 
> that read git-rebase-todo, rewritten-pending, rewritten-list, amend-head 
> and check that author-script exists. If a script starts a rebase then it 
> should know what options are in effect without reading them from 
> .git/rebase-merge.
> 
>>> Ooh, I'm glad you took this tangent.  May I follow it for a second?
>>> I'd really, really like this too, for three reasons:
>>>
>>> 1) I constantly get confused about the massive duplication and
>>> difference in control structures and which ones affect which type of
>>> operations in sequencer.c.  Having them both use an ini-file would
>>> allow us to remove lots of that duplication.  I'm sure there'll still
>>> be some rebase-specific or cherry-pick-specific options, but we don't
>>> need a separate parallel structure for every piece of config.

One thing to bear in mind is that you can cherry-pick or revert a 
sequence of commits while rebasing - I think that means we need to store 
the state for rebase in a separate location to that for cherry-pick/revert

Best Wishes

Phillip

>>> 2) In my merge-ort optimization work, rebasing 35 commits in linux.git
>>> across a massive set of 26K upstream renames has dropped rename
>>> detection time from the top spot.  And it also dropped several other
>>> things in the merge machinery from their spots as well.  Do you know
>>> what's the slowest now?  Wasted time from sequencer.c: the unnecessary
>>> process forking and all the useless disk writing (which I suspect is
>>> mostly updating the index and working directory but also writing all
>>> the individual control files under .git/rebase-merge/).  And this
>>> stuff from sequencer.c is not just barely the slowest part, it's the
>>> slowest by a wide margin.
> 
> I think we do a lot of needless writing which is unrelated to whether we 
> write to one file or may files. For example from memory picking a commit 
> involves writing the 'message', 'author-script', 'rewritten-pending' 
> (which is often immediately deleted), 'rewritten-list' (we append to 
> that one) 'CHERRY_PICK_HEAD' (which is immediately deleted unless the 
> pick has become empty), 'git-rebase-todo' is completely rewritten, and 
> 'done' is appended to. None of this is necessary. For rewording and 
> merges the only thing that needs to be written is the commit message for 
> the external process to use. Fixup and squash add a couple more files 
> into the mix.
> 
> I think we would save a lot by only syncing the state to disk when we 
> stop or run an exec command (the state needs to be synced so exec 
> commands can alter the todo list). In those cases we need to write the 
> index and possibly run an external process so writing a couple of files 
> is probably insignificant.
> 
> Where I think we can usefully consolidate is the one-line files which 
> store the options rather than state - these are read an written much 
> less frequently so I don't think they have much of a performance hit but 
> it would be much nicer to just serialize the options to a single file.
> 
>>>
>>> 3) I also want to allow cherry-picking or rebasing branches that
>>> aren't even checked out (assuming no conflicts are triggered;
>>> otherwise an error can be shown with the user asked to repeat with the
>>> operation connected to an active working directory).
> 
> Exciting!
> 
>>>  For such an
>>> operation, the difference between "cherry-pick" and "rebase" is nearly
>>> irrelevant so you'd expect the code to be the same; every time I look
>>> at the code, though, it seems that the control structures are
>>> separating these two types of operations in more areas than just the
>>> reading and writing of the config.
> 
> Yes this can be confusing, for example rebase and cherry-pick handle the 
> todo list differently. Rebase removes the command before trying to pick 
> the commit and adds it back if the pick fails for a non-conflict reason, 
> cherry-pick only removes the command if the pick is successful.
> 
> Best Wishes
> 
> Phillip
> 
>> Excellent, we're in agreement, then.
>>
>> The remaining question is: how do we want to go about it? Do we just want
>> to codify the notion that these are internal details that are nobody's
>> business, and if they are using the exact file system layout of the
>> current sequencer, then it's their responsibility to adapt?
>>
>> Ciao,
>> Dscho
>>
> 

