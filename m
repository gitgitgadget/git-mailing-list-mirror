Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A8B71F803
	for <e@80x24.org>; Thu, 10 Jan 2019 21:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfAJVmU (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 16:42:20 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:43940 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfAJVmU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 16:42:20 -0500
Received: from [192.168.1.12] ([92.29.14.220])
        by smtp.talktalk.net with SMTP
        id hi5hg5fwXdJAehi5hgwhfi; Thu, 10 Jan 2019 21:42:17 +0000
X-Originating-IP: [92.29.14.220]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=iGBlNkCVnKJDjRvOkgwXUw==:117
 a=iGBlNkCVnKJDjRvOkgwXUw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=JqX4rjNRU0dmwoFySkIA:9 a=QEXdDO2ut3YA:10 a=rWPamnK5WogA:10
 a=0c0_gXobmWUsdo3nzwP-:22
Subject: Re: [PATCH v5 2/3] branch: Mark and color a branch differently if it
 is checked out in a linked worktree
To:     Junio C Hamano <gitster@pobox.com>, nbelakovski@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, rafa.almas@gmail.com,
        avarab@gmail.com
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190106002619.54741-1-nbelakovski@gmail.com>
 <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190106002619.54741-3-nbelakovski@gmail.com>
 <xmqqzhsc8f32.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <e313d0b1-54b1-9fe2-6c75-d2ae7b57fe3a@iee.org>
Date:   Thu, 10 Jan 2019 21:42:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqzhsc8f32.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfPV/0SNHfGK6ySaLegxEk7Z5qbuo4XASQ/lVXn9ZS3B8r7pltkOcUfbuDtDd87bRdXmDf9WTdHoLAqqo4NBdLAywrolc9Om9TBlWWGRhQyJjBh1117e1
 o7lWrHxRL3brqfwWjEK13RUk/kmuMx/o+ovP4MCI8ZqqIoDLTmoKx0+ih9QWar3NKmuVAkAScWmA9G8Dse8o4kJ99lTeEUR4Hy2P/BIsz/JVBbneYCbeutwT
 hZ1Hc36GXawUx8b0YqL9QxvPcpGxCzIm7DaI7qME2mTgzHy7QIUfyI75lum8Ui8VJM2ZQmOtgWnIVTl+lz2Y1w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/01/2019 19:04, Junio C Hamano wrote:
> nbelakovski@gmail.com writes:
>
>> From: Nickolai Belakovski <nbelakovski@gmail.com>
>>
>> In order to more clearly display which branches are active, the output
>> of git branch is modified to mark branches checkout out in a linked
>> worktree with a "+" and color them in cyan (in contrast to the current
>> branch, which will still be denoted with a "*" and colored in green)
>>
>> This is meant to simplify workflows related to worktree, particularly
>> due to the limitations of not being able to check out the same branch in
>> two worktrees and the inability to delete a branch checked out in a
>> worktree. When performing branch operations like checkout and delete, it
>> would be useful to know more readily if the branches in which the user
>> is interested are already checked out in a worktree.
> I do not think it is warranted to paint the safety features as
> "limitations".

Is this not just a case of needing to clarify that this is 'safety' 
related to the _users_ mental model (or lack of) relative to the limited 
information that was previously given by the branch command's list.

You are right that there is no data safety issue, but users make 
mistakes when they misunderstand the situation.

>
> A branch that is checked out in another worktree cannot be checked
> out to be worked on, as that will make the checkout of the other
> worktree out of sync.  If you want to work on that branch, you can
> either (1) go to that worktree that has a checkout of that branch
> and work there, or (2) go to that worktree that has a checkout of
> that branch, check out a different branch there, come back to the
> worktree you want to work in and check out that branch.  Knowing
> where that other worktree is is the first step in either case.
>
> And a branch that is checked out in a worktree cannot be removed, as
> it is a sign that it is still being worked on for a branch to have
> been checked out somewhere.

I'm not sure that all users will recognise the signs, which I think is 
one reason for the value of the patch.


>    If you do want to remove that branch,
> you need to go to that worktree that has a checkout of that branch,
> check out a different branch there, and then remove it.  Again,
> knowing where that other worktree is is the fist thing you need to
> know.
>
> But then I am not sure if the feature being added by these patches
> is a good match for that justification.
I'd agree that the justification needs clarified.
>
> For one thing, it would be more direct and helpful way for
>
> 	git checkout one-branch
> 	git branch -d one-branch
>
> to say "The branch `one-branch` is checked out in a worktree at
> $DIRECTORY" when they refused to go ahead.  And that would eliminate
> the need for this new feature to help these two use cases.
>
> In fact, these two command already behave that way, so the paragraph
> I just commented on is not a good justification for this new feature
> at all.
>
> Besides, showing "That branch is checked out somewhere" would not
> help user to decide "ah, if I want to work on that branch, I need to
> chdir to that directory" with the patch in question, as it only
> shows "It is checked out _somewhere_" without saying where.
>
>> The git worktree list command contains the relevant information, however
>> this is a much less frquently used command than git branch.
> It is not a good justification.  If the "relevant information" given
> by the command is necessary one, the user can run that command.  If
> the situation where that "relevant information" becomes necessary is
> rare, the command is run much less frequently is not a problem---it
> is expected.  And overloading a more frequently used command with
> information that is less frequently wanted is actually not a great
> design.
But leaving the older command unaware of the newer developments and the 
user unwise as to its missing info is equally a poor situation.
>
> A more relevant justification may be that even though the
> information can already be found in "worktree list" output, it would
> give us flexibility in presentation to allow the custom format in
> for-each-ref to show it.
>
> So, I am between moderately Meh to fairly negative on this step; Meh
> in the sense that "thanks to the previous step, we _could_ do this,
> it does not give incorrect information, and it makes the output more
> cheerful, but it does not add that much useful and actionable piece
> of information".

The patch did appear to me as being a proper update to the branch 
command to include the information about the branches in the other worktrees

Philip

