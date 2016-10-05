Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32A781F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 21:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbcJEVYr (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 17:24:47 -0400
Received: from mail.javad.com ([54.86.164.124]:45319 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbcJEVYq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 17:24:46 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 4BF1560BD1;
        Wed,  5 Oct 2016 21:24:45 +0000 (UTC)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1brtgB-0001sf-M1; Thu, 06 Oct 2016 00:24:43 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] Documentation/git-merge.txt: improve short description in DESCRIPTION
References: <cover.1475678515.git.sorganov@gmail.com>
        <e74ae8afc1bfc4cd9161ccaa56d926a89439551e.1475678515.git.sorganov@gmail.com>
        <xmqq60p6pt4k.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 06 Oct 2016 00:24:43 +0300
In-Reply-To: <xmqq60p6pt4k.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 05 Oct 2016 11:07:07 -0700")
Message-ID: <871szuqyjo.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> sorganov@gmail.com writes:
>
>> From: Sergey Organov <sorganov@gmail.com>
>>
>> Old description had a few problems:
>>
>> - sounded as if commits have changes
>>
>> - stated that changes are taken since some "divergence point"
>>   that was not defined.
>>
>> New description rather uses "common ancestor" and "merge base",
>> definitions of which are easily discoverable in the rest of GIT
>> documentation.
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  Documentation/git-merge.txt | 25 +++++++++++++++----------
>>  1 file changed, 15 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
>> index cc0329d..351b8fc 100644
>> --- a/Documentation/git-merge.txt
>> +++ b/Documentation/git-merge.txt
>> @@ -16,11 +16,16 @@ SYNOPSIS
>>  
>>  DESCRIPTION
>>  -----------
>> -Incorporates changes from the named commits (since the time their
>> -histories diverged from the current branch) into the current
>> -branch.  This command is used by 'git pull' to incorporate changes
>> -from another repository and can be used by hand to merge changes
>> -from one branch into another.
>> +
>> +Incorporates changes that lead to the named commits into the current
>> +branch, and joins corresponding histories. The best common ancestor of
>> +named commits and the current branch, called "merge base", is
>> +calculated, and then net changes taken from the merge base to
>> +the named commits are applied.
>> +
>> +This command is used by 'git pull' to incorporate changes from another
>> +repository, and can be used by hand to merge changes from one branch
>> +into another.
>
> Content change together with re-flowing the text makes it more
> costly than necessary to review a change like this.  Please avoid
> doing so in your future patches.

OK, I see. So, what is the best way to handle this? Immediately follow
content change patch with another patch that only re-flows?

> I like what the updated description says very much.  I however
> wonder if "and can be used by hand..." is still appropriate, or
> needs a bit of modernizing.  It feels a bit awkward by making it
> sound as if 'git merge' is primarily an implementation detail of
> 'git pull' but it can also be used as the first-class command, which
> used to be the case in the old days back when "git pull . other" was
> also perfectly good way to merge the 'other' branch from your own
> repository, but I think your update is meant to clarify that we no
> longer live in that old world ;-)

Yes, exactly, but 6/6 removes most of the mentions of git-pull from the
manual anyway, so I felt it better belongs there.

>
>> @@ -31,11 +36,11 @@ Assume the following history exists and the current branch is
>>      D---E---F---G master
>>  ------------
>>  
>> -Then "`git merge topic`" will replay the changes made on the
>> -`topic` branch since it diverged from `master` (i.e., `E`) until
>> -its current commit (`C`) on top of `master`, and record the result
>> -in a new commit along with the names of the two parent commits and
>> -a log message from the user describing the changes.
>
>> -Then "`git merge topic`" will replay the changes made on the `topic`
>> -branch since it diverged from `master` (i.e., `E`) until its current
>> -commit (`C`) on top of `master`, and record the result in a new commit
>> -along with the names of the two parent commits and a log message from
>> -the user describing the changes.
>
>> +Then "`git merge topic`" will replay the changes made on the `topic`
>> +branch since it diverged from `master` (i.e., `E`) until its current
>> +commit (`C`) on top of `master`, and record the result in a new commit
>> +along with references to the two parent commits and a log message from
>> +the user describing the changes.
>
> Content change together with re-flowing the text makes it more
> costly than necessary to review a change like this.  Please avoid
> doing so in your future patches.

Yeah, got it.

> I had to re-flow the original you removed to match how you flowed in
> the updated one and stare at it for a while to spot that the only
> change was to rephrase "the names of the parents" to "references to
> the parents".  I do not know if the updated phrasing is better.  The
> "name" in the original was meant to be a short-hand for "object name",
> and I would support a change to spell it out to clarify; "reference"
> can be a vague word that can mean different things in Git, and when
> the word is given without context, most Git people would think that
> the word refers to "refs", but that is definitely not what the new
> commit records, so...

I won't insist on the change, but "name" sounded wrong to me, and
"reference" was most general term I was able to come up with in this
context.

First, "name" somehow suggested that it could be the case that

$ git branch
* master
$ git merge topic

will store strings "master" and "topic" in the resulting commit.

Next, should one really be aware of "10.2 Git Internals - Git Objects"
to grok this part of the manual if it actually meant to be "object
name"? 

Last, if "reference" is not good enough and we get to internals anyway,
why not say SHA1 then?

-- Sergey
