Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C768C433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 18:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD32422284
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 18:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORIe/fv1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390436AbgJIS3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 14:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390424AbgJIS3R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 14:29:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A815C0613D2
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 11:29:17 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k18so10736425wmj.5
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 11:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:reply-to:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MEwiQVHtGPk4cVEmSSyMdyqORhBSWCgGjRkM7baal30=;
        b=ORIe/fv1d7gqHyBHubhrFtrHYsEBIUpSZwdPHAYk/+5qsmN9VGKU7Xxza2Op9UpbOM
         Hz6sYZnUPuAgxXtkDA1llcumLKyu+NpkE5gbOZ7+vp0My8u/5ifMStcgQYfqOogW1ld2
         YVHKpPspH0xdk1Zj2ERk+NJf3UJIsp6CaFZqaDrQXmDEp0da1BAZ5NVUE6OuK378nR0O
         Lo+Of0d2UDv8GpmDhcAGAoe88Ly6hSvMCJusMRQJTAwNgce2Cf24NrsjJjFK8FaPqVLA
         lrvN0vhNoLI/tAPYthEZ2m113xuiQJAX8vhsZU+QZtpa5pO8ADXy1H+qlxJSObXBe7zt
         98EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:reply-to:to:cc:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MEwiQVHtGPk4cVEmSSyMdyqORhBSWCgGjRkM7baal30=;
        b=LHa5ufY/HcAJmghqcJNDlft3P6zKsFc21NyAN/q656wAUcDDUiI3/QTNqyomHCzbYB
         5DoSGgAeRQ7q6DdLUDGHzMOd9naerY6i9AaZWhP9MwM3pPXpuqCuCpi0viId1mRLpVXT
         jO+gpIEAxYmrsV/FEh87n+4dFsH8SuZRVOLkyMDuw7z2t+LOPtmzYr/Fc7W2D6052ZI0
         943SvO98+M+KXpmjxs3A3CXKhYGV3rwpqIHCAHyhjbNVskP1K2+/xAv2woWzelk0jDbW
         SR63wpNW6yd+/zEfgPLkDDxl/dWUL8Yz7a+lxYSCOWa7tULJwEVJWE4IWU4SGutuhgOC
         +A/Q==
X-Gm-Message-State: AOAM530SKyiJQfE89tJhjUtBPrWAJVtIAAiYu0pSy7SuXwyVsyCkucqX
        NsjexzXGrrHk9xWmtKPouee74IpluqU=
X-Google-Smtp-Source: ABdhPJxJk8kCeSMhvIw7e2HI5EgEiM3+SmwLmq/hW4sqVpSpUVNIYsC78taQRb0EewxkhTN0FgqrUg==
X-Received: by 2002:a1c:5f46:: with SMTP id t67mr15342645wmb.173.1602268155606;
        Fri, 09 Oct 2020 11:29:15 -0700 (PDT)
Received: from [192.168.1.201] (39.16.7.51.dyn.plus.net. [51.7.16.39])
        by smtp.googlemail.com with ESMTPSA id o3sm9209208wru.15.2020.10.09.11.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 11:29:14 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [Outreachy] Introduction
Reply-To: phillip.wood@dunelm.org.uk
To:     Sangeeta NB <sangunb09@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
References: <CAHjREB4gsyOrdnhp0_9rs0wv5q5H47-3RcB3fm5NY+L=3SYnMA@mail.gmail.com>
 <22e3d737-8621-9f20-307e-fc4c2a47ec0c@gmail.com>
 <CAHjREB59HjZAs98wMPtMANcHUaXGou7CYg9vAacc3m4uz1yUug@mail.gmail.com>
Message-ID: <7d691f37-b8b7-510d-ba46-51a4a7587226@gmail.com>
Date:   Fri, 9 Oct 2020 19:29:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHjREB59HjZAs98wMPtMANcHUaXGou7CYg9vAacc3m4uz1yUug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sangeeta

On 09/10/2020 08:41, Sangeeta NB wrote:
> Thanks for the explanation, Philips. I think there's a long road ahead
> to understand how everything is implemented and put together.
> 
> Coming to the microproject, it was said that there is an inconsistency
> in --dirty behavior shown by `git diff` and `git describe --dirty` for
> submodule state when the files are untracked.

I struggled to find the mircoprojects page - I must have missed the link 
on the outreachy site. In case anyone else is struggling to find it here 
is the project

     Unify the meaning of -dirty between diff and describe

     git diff reports a submodule directory, whose tracked
     contents match the commit at the HEAD in the submodule, as
     -dirty when there is an untracked file in the submodule
     directory. This is inconsistent with what git describe
     --dirty says when run in the submodule directory in that
     state. [1]

    [1] https://lore.kernel.org/git/xmqqo8m1k542.fsf@gitster.c.googlers.com/

>  From what I understood by looking at the code, the diff files states
> that we should ignore untracked submodule states. So is it that I have
> to make changes in the way git describe is implemented by ignoring the
> changes in the untracked submodule?

As I understand it if a submodule contains any untracked files (i.e. a 
file that has not been added with `git add` and is not ignored by any 
.gitignore or .git/info/exclude entries) then running `git diff` in the 
superproject will report that the submodule is dirty - there will be a 
line something like "+Subproject commit abcdef-dirty". However if we run 
`git describe --dirty` in the submodule directory then it will not 
append "-dirty" to it's output unless there are changes to tracked files.

> Also, I wasn't able to look for this inconsistency in my local
> machine. Any pointers on how to reproduce this might be helpful.

I'd start my trying to build git and running t4027-diff-submodule.sh.
If you look at the start of the test 'git diff HEAD with dirty submodule 
(untracked)' in t/t4027-diff-submodule.sh it sets up a submodule with an 
untracked file. If you add "test_pause &&" after the diff command in 
that test it will start a shell in the test directory and you can run 
`git diff HEAD` yourself  to see the output and also `git -C sub diff 
HEAD` which will run diff in the submodule directory. The latter command 
should show that there are no changes in the tracked files of the 
submodule. Just exit the shell to get the test to continue. (you can see 
in builtin/describe.c that when it is run with `--dirty` it runs `git 
diff-index HEAD` to determine if a repository is dirty). To change the 
output of diff I would look for the string "Subproject commit" in diff.c 
to find the code that adds '-dirty' and try working backwards from 
there. Let me know if you get stuck - it took we a while to work 
backwards to find where we check if the submodule is dirty.

Best Wishes

Phillip


> Thanks and regards,
> 
> Sangeeta
> 
> On Thu, Oct 8, 2020 at 2:37 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Sangeeta
>>
>> On 07/10/2020 21:10, Sangeeta NB wrote:
>>> Hello everyone,
>>
>> Welcome to the list
>>
>>> My name is Sangeeta and I’m one of the Outreachy applicants.  I would
>>> like to work on the microproject "Unify the meaning of dirty between
>>> diff and describe".
>>>
>>> While looking at the files for `describe` and `diff` commands I found
>>> that the `describe.c`  is present in builtin[1] folder whereas diff.c
>>> is found in the root[2] folder as well as builtin[3] folder. I could
>>> not find any implementation of --dirty in the diff.c present in
>>> builtin[3] folder. So is it that I have to compare the implementation
>>> of describe.c[1] and diff.c(of root folder)?
>>>
>>> Also, I was curious to know why is there a builtin folder when many
>>> commands described in that are described again in the root folder?
>>
>> The files in the root directory are (mostly) library code that ends up
>> in libgit.a. The builtin directory contains the individual git commands
>> that form the git binary that is linked with libgit.a. builtin/diff.c
>> contains cmd_diff() which will be called when the user runs `git diff`.
>> That function parses the command line options and sets up the necessary
>> data to pass to the diff implementation in /diff.c. The diff and log
>> family of commands are a bit different to most of the other commands in
>> that the option parsing is mostly done by calling setup_revisions() in
>> /revision.c rather than using the option parsing library routines in
>> /parse-options.c directly. I think the `--dirty` option for diff ends up
>> being handled by handle_ignore_submodules_arg() in submodule.c, I'll
>> leave it to you to see where that is called from (you can use `git grep`).
>>
>> I'm going to be off line for the rest of today, hopefully someone else
>> will be able to help if you get stuck or I'll try and answer any other
>> questions tomorrow.
>>
>> Best Wishes
>>
>> Phillip
>>
>>> Looking forward to working with you all.
>>>
>>> Sangeeta
>>> [1] https://github.com/git/git/blob/master/builtin/describe.c
>>> [2] https://github.com/git/git/blob/master/builtin/diff.c
>>> [3] https://github.com/git/git/blob/master/diff.c
>>>
