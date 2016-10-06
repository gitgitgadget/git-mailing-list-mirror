Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6630C207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 13:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933351AbcJFNV2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 09:21:28 -0400
Received: from mail.javad.com ([54.86.164.124]:50583 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752387AbcJFNV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 09:21:26 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 07354613EF;
        Thu,  6 Oct 2016 13:21:25 +0000 (UTC)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1bs8bz-0003Uh-1C; Thu, 06 Oct 2016 16:21:23 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] Documentation/git-merge.txt: improve short description in DESCRIPTION
References: <cover.1475678515.git.sorganov@gmail.com>
        <e74ae8afc1bfc4cd9161ccaa56d926a89439551e.1475678515.git.sorganov@gmail.com>
        <e03a84ad-9aa6-8ada-5828-7b28f76baaaf@gmail.com>
Date:   Thu, 06 Oct 2016 16:21:23 +0300
In-Reply-To: <e03a84ad-9aa6-8ada-5828-7b28f76baaaf@gmail.com> ("Jakub
        \=\?utf-8\?Q\?Nar\=C4\=99bski\=22's\?\= message of "Wed, 5 Oct 2016 18:58:10 +0200")
Message-ID: <87a8ehpq98.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narębski <jnareb@gmail.com> writes:

> W dniu 05.10.2016 o 16:46, sorganov@gmail.com pisze:
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
>
> This is a step in a good direction, but it has a few issues.
>
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
>
> The first sentence is all right; it reads better than the original
> without the introduced part in parentheses.  The only minor issue
> is with "joins corresponding histories" - it is a good description,
> but may imply that the branch we are merging vanishes: it doesn't.
> But all in all, it is a good change.

I've got "joins corresponding histories" from original NAME section, so
it's likely to be good enough.

>
> Second sentence has some problems.  First, while it is a good idea
> to use well defined term "merge base", I think writing "since the
> time their histories diverged" or "(which is the point where histories
> diverged)" would be a good plain language description; it was removed
> entirely in the proposal.

I was not sure about it myself, but it sounded as if it could be the
case that I might need to resolve the same conflicts again and again, as
changes are taken from some "divergence point" that is apparently fixed.

OTOH, "merge base" not only is well-defined term, but it also doesn't
sound as some fixed point in history.

>
> Second, while "common ancestor" and "least common ancestor" are well
> defined in mathematics of graphs, "best common ancestor" isn't...
> but this is what git-merge-base(1) documentation uses.

That's were I took it from indeed, git-merge-base manual page. I wanted
things we mention to be discoverable.

> Also, the "best common ancestor" doesn't need to be only one.  There
> might be many such ancestors... though Git would generate then a
> virtual best common ancestor thanks to recursive merge strategy.
> And usually there is only one "best common ancestor", that is a single
> merge base.  So this may need clarification, but it is not much of
> a problem.
>
> Third, and most important, is that "net changes taken from the merge
> base to the named commits are applied" is simply not true.  The
> `git merge` command does not reapply changes - that is what rebase
> and cherry-pick do.

"are applied" meant to be generic enough in this context to cover, say,
"-s ours" as well. Perhaps "are integrated" you suggest below, or "are
incorporated" that is already used in the beginning of DESCRIPTION, is
better indeed.

As for merge vs rebase (or cherry-pick), the only essential difference
for me is that merge applies net (cumulative, integrated) changes, while
rebase applies each change sequentially, one commit to another. Please
correct me if I'm wrong.

BTW, one can imagine "rebase" merge strategy: make a new chain of
commits on top of destination, then squash all that to get a new single
merge commit.

> The merge operation uses 3-way merge strategy (diff3) between
> merge-base, current branch, and merged commit. That is, it finds
> differences between differences, and "applies" that.

The problem is that at this point we need to cover other merge
strategies as well, so we can't writ the description as if 3-way merge
is the only strategy.

> See
> "A Formal Investigation of Diff3" paper by Sanjeev Khanna, Keshav
> Kunal, and Benjamin C. Pierce:
> http://www.cis.upenn.edu/~bcpierce/papers/diff3-short.pdf
>
> I'm not sure how to explain it succintly.  Perhaps
>
>   net changes between merge base to the current (merged into)
>   branch and named commits are integrated
>
> There is description of trivial 3-way merge somewhere in Git docs,
> though in very unobvious place; we can link it.

As it's "TRUE MERGE" section that mentions 3-way merge for the first
time, it'd be the natural place for the link, I think.

>> +
>> +This command is used by 'git pull' to incorporate changes from another
>> +repository, and can be used by hand to merge changes from one branch
>> +into another.
>
> Rather "can be used by 'git pull'", or "is used by 'git pull' (unless
> configured otherwise)"...
>
> Separating this information makes a very good sense.  Thanks.

Yeah, but I've rather deleted it entirely in 6/6.

-- Sergey.
