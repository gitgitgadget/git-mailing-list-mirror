Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FE7C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8D320661
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/r/Np1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfK0T4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:56:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50943 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfK0T4P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:56:15 -0500
Received: by mail-wm1-f66.google.com with SMTP id l17so8461065wmh.0
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g0e3iGPSRI7xKHRuf3tSf3Wdfp2uAMG9FEJV0sYAmbA=;
        b=f/r/Np1Sw/Au/6sMZj7a73YuxMQI2RnFnv4D6IB5fL5QM8yjAPrh4qFQ/J9ujnQ7rO
         TDhNv65qd6K9/NlI2OLTJXH0PwZyCAEvd255f3DgsEBasJEPWlw7jVUuPWqEkr1mO8aK
         E30saemek/q/NNUloN7W7FXxi57nV6H3f7AHo7zNlA0D5y1xgKjmP4owcYzEpHPkRj/g
         SEl5Bvt3vNwt/aIIQ+YYxEBIKEBKr+dpnDtEZZwRqLdAYRkTValDLvjsbT0pt8X2gbT0
         HYy7KYeX37vJ21rY/4APWbtzA2uusrjOo416glQ0+XcPvBZg4mu7fShS0xRyb1t27mCQ
         nBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g0e3iGPSRI7xKHRuf3tSf3Wdfp2uAMG9FEJV0sYAmbA=;
        b=ci+hbhCX1ZTGvx5eJjGNhMWfg7odJilTVyx8uITemfRw88jLI1zAUPaTlhDtad0CBh
         zyrY53IqCiZ20LiXpplRXU6EAYdWrLJXuXiO+rusf2kwGd5noY1Ce04OdB8siYzxEbYx
         1Ms+lATERxklXPFKDG5SUQua2Wad3IbolnN6WTrDogwQ5Shm/8znupLD7X3sRzDBau1j
         /aBrKSI8OLskMjPr6M8FAJLmdS3K8PnDwdcNlAkjIbkzgvTinIMBTjkyQuwxAk1rZ8wY
         MMm15RK94z/dVt+iYEotf4hEUilbn8/UmqC7IZ7M8sFoCWPavUHONNym3TXy14ft6PJf
         pYHA==
X-Gm-Message-State: APjAAAVq0X7RAySkC/+CjsICg002RRHtcUbKO32TBBniillrOezMnwX6
        NsbyPjpmFHvqSlbaawo3qbY=
X-Google-Smtp-Source: APXvYqyJaYJVcY2EhEYuqFE+DcCsnzQzUIy8b0uYAfqe1go4/UvpFF2vthrq4CmGbN9lMYgUhKjMnQ==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr6416392wmi.124.1574884573459;
        Wed, 27 Nov 2019 11:56:13 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-110-106.w86-199.abo.wanadoo.fr. [86.199.33.106])
        by smtp.gmail.com with ESMTPSA id a24sm5776358wmb.29.2019.11.27.11.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 11:56:12 -0800 (PST)
Subject: Re: [PATCH v4 5/5] sequencer: directly call pick_commits() from
 complete_action()
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        phillip.wood@dunelm.org.uk, gitster@pobox.com
References: <20191124174332.30887-6-alban.gruin@gmail.com>
 <20191126184103.146421-1-jonathantanmy@google.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <aa162f9c-9ae8-9844-6829-7fc0d9c50f9c@gmail.com>
Date:   Wed, 27 Nov 2019 20:56:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20191126184103.146421-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

Le 26/11/2019 à 19:41, Jonathan Tan a écrit :
>> Currently, complete_action(), used by builtin/rebase.c to start a new
>> rebase, calls sequencer_continue() to do it.  Before the former calls
>> pick_commits(), it
>>
>>  - calls read_and_refresh_cache() -- this is unnecessary here as we've
>>    just called require_clean_work_tree() in complete_action()
> 
> require_clean_work_tree() and read_and_refresh_cache() seem to be
> different functions - can you explain why running the former is a good
> substitute for running the latter?
> 

They both refresh the index.

require_clean_work_tree(), called when starting a new rebase, will also
check if there are any unstaged or uncommitted changes, in which case we
do not want to start a rebase.

This is not what we want when resuming a rebase (with `rebase
--continue'), because the changes might be the result of a conflict
resolution.  In this case, the last commit is amended, and the rebase is
resumed.

>>  - calls read_populate_opts() -- this is unnecessary as we're starting a
>>    new rebase, so `opts' is fully populated
> 
> My comment from [1] has not been addressed. Quoting it here:
> 
>> So complete_action() (the function modified in this commit) is called
>> only by do_interactive_rebase() (in builtin/rebase.c), which is only
>> called by run_rebase_interactive() (in builtin/rebase.c) when command is
>> ACTION_NONE, so indeed, we're starting a new rebase. But where the
>> options fully populated? I see that in do_interactive_rebase(), it is
>> initialized with get_replay_opts(), but that seems different from
>> read_populate_opts().
> 
> [1] https://lore.kernel.org/git/20191119204146.168001-1-jonathantanmy@google.com/
> 

Sorry.

For the first part of your comment, I added a comment at the beginning
of the message, although I did _not_ include an analysis on when
complete_action() is used.

get_replay_opts() converts a `struct rebase_options' (which contains the
arguments passed to `git rebase') into a `struct replay_opts' which can
be used by the sequencer, whereas read_populate_opts() loads the options
from the disk.

So, when are they written to the disk?  In do_interactive_rebase()
(builtin/rebase.c), after using get_replay_opts() to convert `opts' to
`replay', init_basic_state() is called, which calls write_basic_state(),
which write the options to the disk.

Then, until complete_action() is called, `opts' is not modified.

>>  - loads the todo list -- this is unnecessary as we've just populated
>>    the todo list in complete_action()
> 
> Both functions indeed have their own todo lists that they pass to
> pick_commits(), but I don't see (at least, by glancing at the code) that
> both these todo lists are identical.
> 

Near the end of complete_action(), the todo list is written to the disk.
 The destination is obtained with rebase_path_todo().

read_populate_todo() will read a file and parse it.  In the case of
`rebase -i', the location is obtained with rebase_path_todo(), and only
`total_nr' will be modified to contain the number of commands done and todo.

In the case of a new rebase, the done list might not be empty after
tajjimh skip_unnecessary_picks() from complete_action().  Skipped
commands are moved from the todo list to the done list.  As `total_nr'
is not changed by skip_unnecessary_picks(), it is also equal to the
number of commands remaining in the todo list and in the done list.  So,
when read_populate_todo() reads the list and the done list from the
disk, as they should not have been modified, `total_nr' should remain
the same, too.

The only thing that can change is the internal buffer (`buf'), because
skip_unnecessary_picks() don’t change it.  Since
ag/sequencer-reduce-rewriting-todo, it is no longer a textual
representation of the todo list.  Each command contains a pointer to a
location in the buffer and a length to represent its argument.

>>  - commits any staged changes -- this is unnecessary as we're starting a
>>    new rebase, so there are no staged changes
>>  - calls record_in_rewritten() -- this is unnecessary as we're starting
>>    a new rebase.
> 
> OK - I don't know enough about the rebase mechanism to verify these, but
> these seem reasonable to me.
> 

Cheers,
Alban

