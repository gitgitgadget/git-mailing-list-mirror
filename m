Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF766C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 14:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97DC9613B7
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 14:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhGIOcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 10:32:35 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.104]:18447 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhGIOcf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 10:32:35 -0400
Received: from [84.163.73.96] (helo=[192.168.2.202])
        by smtprelay07.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m1rUh-0003hS-Jl; Fri, 09 Jul 2021 16:28:43 +0200
Subject: Re: PATCH: improve git switch documentation
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru> <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru> <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
From:   Martin <git@mfriebe.de>
Message-ID: <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
Date:   Fri, 9 Jul 2021 16:29:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60e79c31aaa72_30b8a4208c1@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/07/2021 02:45, Felipe Contreras wrote:
> I believe we have all the semantic tools needed to write something that
> is understandable by most people regardless of their conception of what a
> branch is.
> 

So returning to the original topic.


While writing this, I thought maybe there is a need for a
"Guideline on writing documentation" ?



On 01/07/2021 16:58, Junio C Hamano proposed a patch that had an 
interesting point.
The patch was for the docs of "git switch" and "git branch"

1)

      <start-point> versus <commit[-ish]>

I am not sure that this will help much with the original issue, which is 
my concern that a (new) user will be aware of why "switch -C" is a force 
(i.e. what the dangers are).
But it is an interesting point.

 From the synopsis of various commands (just a sample, I did not check all).
   git switch (-c|-C) <new-branch> [<start-point>]
   git branch <branchname> [<start-point>]
   git checkout [--detach] <commit>
   git checkout [[-b|-B|--orphan] <new_branch>] [<start_point>]
   git reset [--soft | --mixed | --hard ] [<commit>]

With the exception for "git reset" they all use <start-point> when it 
comes to branches.

The general question here is, should the synopsis say
a) this parameter should be a "commit".
And then the doc explains the commit will be used as startpoint
b) this parameter should be a "start point"
And then the doc explains the startpoint has to be given as commit.

In terms of checkout, this is especially interesting.
The 2nd form does create a new branch.
But both forms check-out the commit.
IMHO it is somewhat strange that you "check out a start-point to your 
worktree".

So probably <commit> (or even <commit-ish>) may indeed be the better option.
This is however an issue that goes well beyond "git switch".

This may also affect other words used in synopsises. So this is a 
general rule that needs to be decided for all of the documentation.
The issue is, that some commands take several commits.
    git rebase [--onto <newbase>] [<upstream> [<branch>]]
In that case some distinguishing is needed.

There also is the option of "<base-commit[-ish]>".
This tells the user that a commit-ish is needed. But distinguishes it 
from other <commit> that may be given as argument.
This may lead to rather long names (e.g. in rebase).
Though in checkout, I would use only <commit[-ish]> in both variants, as 
the main action is to check out that commit.


2)

      <branch> versus <branch-name>

    git switch [--no-guess] <branch>
    git switch (-c|-C) <new-branch> [<start-point>]
    git branch <branchname> [<start-point>]
    git checkout [[-b|-B|--orphan] <new_branch>] [<start_point>]
    git rebase [--onto <newbase>] [<upstream> [<branch>]]

First of all "git rebase" is simply wrong. I can give a commit for all 3 
arguments. So the last one does not have to be a branch. (or <branch-name>)

Then I think <branch-name> (or <branch-ish> /see other mail) should be 
preferred over <branch>.

As for "git switch -C"
This should IMHO change to (the 2nd arg, actually depends on the point 
"1" above)
    git switch (-c|-C) <branch-name> [<base-commit>]

I suggest to not call it "new-branch-name" because, it might be an 
existing name.


3)

    newbbranch  versus new-branch  versus  new_branch

That is something that just needs to be decided.
"new_branch" is in git checkout.


4)

    Extend of explanation for why a command is classified as "force".

This one is the one I still lobby for support.
This is also on issue across all docs. (or most)

Currently "git switch -C" is simply stated to be --force-create.

- There is no mention what is "forced". All it says is:
>  if <new-branch> already exists, it will be reset to <start-point>.
I guess this is the English verb reset. Because, if the user goes to 
"git reset" then the user would not know what kind of reset.
So the term "reset" is ambiguous, as it could be the verb, or the command.

Of course the "git branch" doc has the same
> Reset <branchname> to <startpoint>, even if <branchname> exists already. 


There is also no word, that this does not include overwriting a dirty 
work tree.

   git switch --force -c unused-name origin/branch
means "forcefully overwrite a dirty work tree"

   git switch --force-create unused-name origin/branch
fails on the dirty work tree.


Btw similar on "git checkout"
   git checkout -B unused-name origin/branch
Only difference, -B has no misleading long option.


But my point is less, the not applying danger.
My point is what danger is there, so that this was made a force command?

Look at
   git checkout --force
> --force
>     When switching branches, proceed even if the index or the working tree differs from HEAD. This is used to throw away local changes.

   git switch --force
> --force
>     An alias for --discard-changes.
and then eventually
> This is used to throw away local changes.

So --force clearly says: You will loose local changes (if you have any).

The same clarity is missing for "force create branch".

Yes, sure any commits that where in the branch, may be hold by other 
branches or the ref-log.
But neither is guaranteed. A branch does not need to have a reflog.

Even if we say a user must know about certain concepts (such as a 
branchname is a reference, and non referenced objects may be lost), even 
then the user is left to connect the dots themself.

I think it should be included in the docs (git switch/checkout/branch 
and reset)

The current wording
    Reset <branchname> to <startpoint>, even if
    <branchname> exists already.

should be amended
Avoid "reset"
    Create a new branch at <startpoint> with the name
    <branchname>, even if <branchname> is already used.

Add clarity
    Create a new branch at <startpoint> with the name
    <branchname>.
    If <branchname> already existed, then the old branch
    will be removed.

If the user perceives "the old branch" as container for a "chain of 
commits", then it is still up to the user to know, that any of those 
commits can be part of other branches. And that "removing the branch", 
may or may not include removing the commits.

However, a user not yet knowing what exactly "removing a branch" means, 
does at least have the word "remove" to make him wary that they should 
look up more details.


