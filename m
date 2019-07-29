Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E2EB1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 09:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfG2JiL (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 05:38:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36489 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfG2JiK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 05:38:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so48703963wme.1
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 02:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AHnG+vxlkm5VCQh5SxwUanqaY1om5kgdxraMImpGWyA=;
        b=CZuFNzFB6G7rONBXREIkjzYdP8ExzxJfRaUD/zrJw8kyDf1dsRmvpYCSa/+zcrrRef
         9/yTvW0/K+bOR4VvKIVfwYMOmf6+Y9BcSH928NT8Bc7uFUf2VRx/xhXDTuOb+kbfsWpb
         sDXM3UaQTVE9EAiw3sU1gIoiLkq9Z11E6JYQQ+CZ0HlMgr+Z3Df1dmlGobL5W/Wfpqrj
         tgpXDPqHbti49vrLDUahnKRBZ3u5CahIykA9ixBNvhxTcLLrF1vtu3mRWWfPR6Le1MiW
         TRIWLK7pyRS0gMtkLbl+dj4h9nGX24umqvI95tNtZwS+OHgqYqKFU9KZZyyV68FI4fhS
         v4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AHnG+vxlkm5VCQh5SxwUanqaY1om5kgdxraMImpGWyA=;
        b=jxbaJWPJuKxMitKkgaW1lxJzTtwfyF87U40j1ZbSSgdM2H1V5mud7D4QWZRoSi4JvD
         82MSXRueQaVaOK7ns3Ld5DfGQammb/xDONmu6yJCk0RG0IrAE3WeI3UlwWQwmpxDcuXy
         JRDEaJt1VUiKfR6qAGzzEA3rpNuB7qR3q0PRf7MHd1wQfFzuzgXm/sOrXKiVUe02RL4N
         5yc/qz7c6o1l8e/5aI4gylpPE3OSsmh3x/5J4AfAox21BG4xmP9p0ZUQhRzmCsZhnyzI
         tB6gR2atS/vZ2jmAc7yMyisAhLH4khFPXBjrRjgjX71jYwKl3AhTquZSgp0+GyNff4jt
         7DkQ==
X-Gm-Message-State: APjAAAW3hKoY8kXTztNXke5U+xBDnMpDFca7r3tkNs8VM65HoRqTRcUP
        N5RJukgkReJp9MbgxGJ07so=
X-Google-Smtp-Source: APXvYqzMlO5f+yCeSa5zF4T8IY3BmBBp93ZPCQvHjNANd0zoFfU69OyrtTYJAeMjnQ9QXse9n0HcyQ==
X-Received: by 2002:a1c:cf0b:: with SMTP id f11mr101781388wmg.138.1564393089030;
        Mon, 29 Jul 2019 02:38:09 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-23-226.as13285.net. [92.22.23.226])
        by smtp.gmail.com with ESMTPSA id x8sm50764639wmc.5.2019.07.29.02.38.08
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 02:38:08 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 0/9] rebase -i: extend rebase.missingCommitsCheck to
 `--edit-todo' and co.
To:     Alban Gruin <alban.gruin@gmail.com>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20190717143918.7406-1-alban.gruin@gmail.com>
 <ce6bdffd-0a04-803c-4a1e-0959342db01f@gmail.com>
 <69ceed35-ced4-51e7-d724-1818ae45e9a6@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8214207e-fa35-44c4-4135-45bd90209e18@gmail.com>
Date:   Mon, 29 Jul 2019 10:38:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <69ceed35-ced4-51e7-d724-1818ae45e9a6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 25/07/2019 21:26, Alban Gruin wrote:
> Hi Phillip,
> 
> Le 24/07/2019 à 15:29, Phillip Wood a écrit :
>> Hi Alban
>>
>> Thanks for working on this, it's great to see you back on the list and I
>> think it would be a useful addition to rebase. Unfortunately I'm not
>> sure about this implementation though (although the early bug fix
>> patches are useful in their own right)
>>
>> On 17/07/2019 15:39, Alban Gruin wrote:
>>> To prevent mistakes when editing a branch, rebase features a knob,
>>> rebase.missingCommitsCheck, to warn the user if a commit was dropped.
>>> Unfortunately, this check is only effective for the initial edit, which
>>> means that if you edit the todo list at a later point of the rebase and
>>> dropped a commit, no warnings or errors would be issued.
>>>
>>> This adds the ability to check if commits were dropped when resuming a
>>> rebase (with `rebase --continue'), when editing the todo list (with
>>> `rebase --edit-todo'), or when reloading the todo list after an `exec'
>>> command.
>>
>> I'm not sure if we really need to check the todo list when continuing or
>> after an exec command.
> 
> In which case I don’t really understand why there is an `error' mode if
> one can completely bypass it with `--continue'.

That's an interesting point about `--continue`. Perhaps if `--edit-todo` 
detects deleted lines in error mode it should write a file to stop 
`--continue` continuing rather than having to validate the entire list 
each time we continue a rebase. Alternatively we could annotate the todo 
list with a message the dropped commits commented out and reopen the 
editor for the user to fix the problem, but that would cause scripted 
editors to enter a infinite loop as they're unlikely to fix the problem 
the second time round. A third possibility is to keep your code 
validating the list each time we run continue, but update the backup 
file with each edit so it detects added commits that are deleted in a 
later edit. This would also provide some protection for users who edit 
git-rebase-todo directly, though if they are using a script that deletes 
lines in git-rebase-todo directly it will suddenly stop working with 
this change if they have rebase.missingCommitsCheck set to error.

Having said all that we could decide that the existing error message is 
enough and allow the user to skip re-editing the list if they really did 
mean to remove those lines. It would be annoying to have to re-edit the 
list when one had intended to delete those lines.

>> The official way to edit the todo list is to run
>> 'git rebase --edit-todo' and I'm not sure if we support scripts writing
>> to .git/rebase-merge/git-rebase-todo directly. If we only support the
>> check after --edit-todo then I think the implementation can be
>> simplified as we can just write a copy of the file before it is edited
>> and don't need to check .git/rebase-merge/done. Additionally that would
>> catch commits that are added by the user and then deleted in a later
>> edit. They wont be in the original list so I don't think this series
>> will detect their deletion.
>>
> 
> True -- but with this solution, if a bad command is introduced, there
> will be false negatives.  Given the pitfall of my solution, this should
> be an acceptable trade-off.

We could detect a bad commit by checking the oid and not complaining if 
it is not valid. That's slightly complicated by labels, but we could 
fairly easily keep of list of the labels defined so far as we scan the 
list. That would also open the possibility of detecting errors where the 
user references an undefined label in `merge` or `reset` commands but 
that's a separate problem.

Best Wishes

Phillip

>> At the extreme I have a script around rebase that runs 'rebase -i HEAD'
>> and then fills in the todo list with a fake editor that adds 'reset ...'
>> as the first line to set the starting point of the rebase. I think
>> dscho's garden-shears script does something similar. Under the proposed
>> scheme if I subsequently edit the todo list it will not catch any
>> deleted commits as the original list is empty.
>>
>> Best Wishes
>>
>> Phillip
>>
> 
> Cheers,
> Alban
> 
