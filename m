Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1587C2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 18:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 941F820791
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 18:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJpHodCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgIWSXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 14:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIWSXX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 14:23:23 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051B6C0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 11:23:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g4so1066564wrs.5
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 11:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VC4HrMafp2JWlloWesOE5zlaT7GdHl5wTH6tn8FlBm0=;
        b=vJpHodCGm9H4SI6rA28L33R8du8v9N/zkqkpul/axm3Q6+FRQpZnJmzD2sNRDbHhZN
         P+0bUFhg9mJL8WQVjV8q1AbnNd1f6MicLJFauVCqeIqOXlwwB/9H+v0SZ0+MD64UiC3a
         CcI8jZ7BuTWVi2qnPwwLsAAHqHbNSY2SjuF1S2uCG3kjwiV6E7Z7D+W+Lsjc7v2fA9VL
         8Pr6sHyCTiUKl93CCzd5X6E9ukdoMEHKy7Ujc8xnXAqxwP/+SxXiGnM2BbHjnlsNNT2w
         k7QKPU8BPB4E/YmFR6xp9c9Uxg5q3G+jN0krG20AFvex0A3gR/PXDPnDFa3vsYpZTaiJ
         CZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VC4HrMafp2JWlloWesOE5zlaT7GdHl5wTH6tn8FlBm0=;
        b=NPZOdRc8b/wG9hIeIpLjColPmZM8ES2v1d/TxPdcGr56U8ZRzkTeFmCkhTmYC1zJe1
         KxqlPgIdKaUyWSiOAmJZvGaL+FcZwbSTHG9qnruPt1htv+88Ky6xdOTm/IIF+o7yk5eV
         yjzB7fljXl6qJrKepku2CBpvdzDn9nL4e5h/oLUCYA4UYjQv/DazA4bvfjfaw8qdyPRl
         bJgcJEp3a47aXQwSsyfHhBC2WH23d2hCxSDPZAiJITZHKxbjIrXKdki7V2y8OqxzWgvj
         gMof6MEN22UwM+8bE+MUFjLqdJEl5yPtJGTq53Sa9fqFWc5sSbJGU3lZf1KMrfaxwAjt
         RoiQ==
X-Gm-Message-State: AOAM533TKFvkcEwcBvHKq5gyFGykPj4iwPtWXreesavxsVq3zib+JtGu
        wzAlDCjcg4Xdym59PiSxKgq+2BtNtwI=
X-Google-Smtp-Source: ABdhPJxSHMupvDbMcB27v1xKhJOTtkwMLdS9bkfmadY4EYBWrAnVjwa7wKInr4c1ZDxH2Nt+9DP4vg==
X-Received: by 2002:a5d:4c88:: with SMTP id z8mr978818wrs.218.1600885401651;
        Wed, 23 Sep 2020 11:23:21 -0700 (PDT)
Received: from [192.168.1.201] (79.35.7.51.dyn.plus.net. [51.7.35.79])
        by smtp.googlemail.com with ESMTPSA id 70sm655316wmb.41.2020.09.23.11.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 11:23:21 -0700 (PDT)
Subject: Re: [PATCH 3/3] commit: add an option the reword HEAD
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.736.git.1600695050.gitgitgadget@gmail.com>
 <7f851e7c20aafdae5d5ae46ee1083b32ecc82c84.1600695050.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2009231206290.5061@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <41dcb8cb-8e43-04ce-2ddd-d69c765ee327@gmail.com>
Date:   Wed, 23 Sep 2020 19:23:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2009231206290.5061@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 23/09/2020 11:22, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Mon, 21 Sep 2020, Phillip Wood via GitGitGadget wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> If one notices a typo in the last commit after starting to stage
>> changes for the next commit it is useful to be able to reword the last
>> commit without changing its contents. Currently the way to do that is
>> by specifying --amend --only with no pathspec which is not that
>> obvious to new users (so much so that before beb635ca9c ("commit:
>> remove 'Clever' message for --only --amend", 2016-12-09) commit
>> printed a message to congratulate the user on figuring out how to do
>> it). If the last commit is empty one has to pass --allow-empty as well
>> even though the contents are not being changed. This commits adds a
>> --reword option for commit that rewords the last commit without
>> changing its contents.
> 
> I would like to explain the idea I tried to get across when I proposed to
> implement support for `reword!` (and `--reword`) because I feel that it
> will change the design of this patch in a rather big way.
> 
> First of all, let me explain the scenario in which I long for the
> `--reword` option: I maintain several patch thickets, the most obvious one
> being Git for Windows' patch thicket that is merge-rebased [*1*] onto
> every new Git version.
> 
> At times, I need to adjust a commit message in that patch thicket. It
> would be quite wasteful to perform a full merge-rebase, therefore I
> typically call `git commit --squash <commit> -c <commit>`, copy the
> oneline, paste it after the `squash!` line (surrounded by empty lines), and
> then reword the commit message. When the next Git version comes out, I do
> a merging-rebase, and when the editor pops up because of that `squash!`
> oneline, I remove the now-obsolete version(s) of the commit message.
> 
> Obviously, I have to be careful to either also pass `--only` (which I
> somehow managed to learn about only today) or I have to make sure that I
> have no staged changes. In practice, I actually specify a bogus path,
> which has the same effect as `--only`.
> 
> What I would actually rather have is the `--reword` option: `git commit
> --reword <commit>`. In my mind, this would _add_ a new, "empty" commit,
> letting me edit the commit message of the specified commit, and using that
> as commit message, prefixed with the line `reword! <oneline>`.
> 
> This, in turn, would need to be accompanied by support in the interactive
> rebase, to perform the desired reword (which is admittedly quite a bit
> different from what the way the todo command `reword` works).
> 
> With that in mind, I would like to caution against the design of your
> current patch, because it would slam the door shut on the way I would like
> `--reword` to work.

I'm keen to have an easy way to reword HEAD and a way to implement your 
reword! idea.

I posted a comment on your gitgitgadget issue about reword! and drop![1] 
pointing to some patches[2] that implement the reword! idea as amend!. I 
think we want to be able to  fixup a commit and reword it at the same 
time which is way I chose the name amend! rather than reword! The 
implementation currently changes `git commit --amend` to take an 
optional commit which isn't ideal. I wonder if calling it revise! would 
be better then we could have `git commit --reword` to reword HEAD and 
`git commit --revise <commit>` to create a commit that will reword and 
fixup <commit> when the user runs `git rebase -i --autostash`. fold! is 
another possibility.

I don't think this patch series stops us implementing something for 
rebase but it would mean we couldn't use the name reword! unless we 
allow `git commit --reword` to take an optional commit which I'm not 
that keen on.

What do you think to an alternative name?

Best Wishes

Phillip

[1] https://github.com/gitgitgadget/git/issues/259
[2] https://github.com/phillipwood/git/commits/wip/rebase-amend

> Ciao,
> Dscho
> 
> Footnote *1*: In Git for Windows, I want to not only rebase the patches
> (so that they are as ready to be submitted to the Git mailing list as they
> can be) but I also want the commit history to fast-forward. The strategy I
> settled on is the "merging rebase": it is a rebase that starts with a fake
> merge of the previous commit history, i.e. merging it in using `-s ours`
> so that only the commit history comes in, but not the changes. This allows
> contributors to pull without problems, but also provides the benefits of
> having a rebased version of the patches. The price is a rather big commit
> history on top of Git's main branch, as Git for Windows' main branch
> contains not only the newest iteration of its patches, but _all_
> iterations (at least since the first merging-rebase).
> 

