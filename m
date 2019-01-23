Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 589781F453
	for <e@80x24.org>; Wed, 23 Jan 2019 07:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfAWHEk (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 02:04:40 -0500
Received: from rrzmta2.uni-regensburg.de ([194.94.155.52]:46270 "EHLO
        rrzmta2.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfAWHEj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 02:04:39 -0500
Received: from rrzmta2.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id EBD9B7BC20
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 08:04:36 +0100 (CET)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta2.uni-regensburg.de (Postfix) with ESMTP id C2CB97B466
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 08:04:36 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Wed, 23 Jan 2019 08:04:36 +0100
Message-Id: <5C481202020000A10002F4AE@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Wed, 23 Jan 2019 08:04:34 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     "Elijah Newren" <newren@gmail.com>
Cc:     <git@vger.kernel.org>
Subject: Antw: Re: Q: What happened to "--no-commit" merges?
References: <5C47833C020000A10002F499@gwsmtp1.uni-regensburg.de>
 <CABPp-BFGfWPAwKLMMMLdLu856UvrrSMYjYWXeVUxEqpspBxbsA@mail.gmail.com>
In-Reply-To: <CABPp-BFGfWPAwKLMMMLdLu856UvrrSMYjYWXeVUxEqpspBxbsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Elijah Newren <newren@gmail.com> schrieb am 22.01.2019 um 22:29 in
Nachricht
<CABPp-BFGfWPAwKLMMMLdLu856UvrrSMYjYWXeVUxEqpspBxbsA@mail.gmail.com>:
> Hello,
> 
> On Tue, Jan 22, 2019 at 1:05 PM Ulrich Windl
> <Ulrich.Windl@rz.uni-regensburg.de> wrote:
>>
>> Hi!
>>
>> Using git version 2.16.4 on OpenSUSE Leap 15.0, it seems that "--no-commit"

> no
>> longer does what it did before (AFAIR, but I mostly did --no-ff merges in
>> SLES11):
>> Like this (sorry German):
>>
>> > git merge --no-commit local/f-linux-firefox
>> Aktualisiere 520aaae..c11e3da
>> Fast-forward
> 
> Ah, a fast foward, so there was nothing to commit; it could simply
> update the branch to include commits that already existed.
> 
>>  bin/fval.xsl | 133 
> +++++++++++++++++++++++++----------------------------------
>>  1 file changed, 57 insertions(+), 76 deletions(-)
>>
>> > git status
>> Auf Branch f-linux-firefox
>> nichts zu committen, Arbeitsverzeichnis unverändert
>>
>> ### "nothing to commit"
>> git log indicates the changes were committed already
> 
> Indeed; the changes were committed before you ran "git merge"; they
> were all part of the local/f-linux-firefox branch.

Actually no: The changes were on a different local "remote" branch; otherwise
I wouldn't need the merge, I guess

> 
>> Reading
>> https://stackoverflow.com/questions/8640887/git-merge-without-auto-commit
it
>> seems that without "--no-ff" this ioption is effectively ignored.

Note: If you see the number of upvotes to the answer there, it seems I'm not
the only one who got confused. ;-)

>> If so, I suggest to tell the user that --no-commit is useless in this case,

> and
>> let him confirm that he/she wants the changes (merge) to be committed 
> (despite
>> of --no-commit).
> 
> --no-commit, to me, means don't create any new commits.  But you had a
> case where there was no need to create a any new commits: your branch
> (f-linux-firefox, I think?) had no commits that the other branch
> (local/f-linux-firefox) lacked, but the other branch had at least one
> you lacked.  So, merging could be done by just moving your branch
> pointer to include all those existing commits.

Is moving commits from one branch to to another done without any new commit?
Just updating the refs, or what? I didn't know that.

> 
> If you want the branch to not get updated, then yes you'd need both
> --no-ff and --no-commit in some cases.  But that's always been true.
> It's possible in the past that you just didn't run into those cases.

So it seems a commit is something other than I'd expected: To me anything that
changes what "git log" outputs is a commit ;-) Or anything that chenges the
reflog...

> 
> Now, if you're suggesting that --no-commit should imply --no-ff,
> that's interesting.  However, you are fundamentally changing the
> operation at that point by making it so that a merge commit will be
> created when the user runs `git commit` at the end -- it's not clear
> to me that users will see a merge commit as wanted or needed and
> having --no-commit imply that option might break expectations.  I'd be
> more inclined to tell users who want --no-ff behavor to use that flag
> and/or set the merge.ff config setting to false.

No, it seems I didn't realize that a fast-forward actually is without a
commit.


> 
> Alternatively, we could update the documentation to point out this
> special case under --no-commit to point out that when an ff-update
> occurs no commit creation is involved and thus --no-commit has no
> effect.  Would that help?

Maybe (I'm unsure where the concepts are described best to check the current
version(s)) try to explain the concepts of "commit" and "fast forward" in some
greater detail. Maybe I was just expecting the wrong things to happen behind
the scenes. Maybe add a statement like "fast-forwards never create a new
commit, so --no-commit doesn't make sense when fast-forwarding."

Thanks for the explanations.

Regards,
Ulrich


