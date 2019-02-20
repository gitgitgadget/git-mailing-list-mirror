Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E7821F453
	for <e@80x24.org>; Wed, 20 Feb 2019 07:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfBTH3Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 02:29:16 -0500
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:43798 "EHLO
        rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfBTH3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 02:29:16 -0500
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 6CF4D674F9
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 08:29:12 +0100 (CET)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id 16B345F8A1
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 08:29:12 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Wed, 20 Feb 2019 08:29:11 +0100
Message-Id: <5C6D01C6020000A10002FC4C@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Wed, 20 Feb 2019 08:29:10 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     "Elijah Newren" <newren@gmail.com>, <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
Subject: Antw: Re: [PATCH v2] merge-options.txt: correct wording of
 --no-commit option
References: <5C6BAA4E020000A10002FBFF@gwsmtp1.uni-regensburg.de>
 <20190219170709.25463-1-newren@gmail.com><20190219170709.25463-1-newren@gmail.com>
 (Elijah Newren's message of "Tue, 19 Feb 2019 09:07:09 -0800")
 <xmqqk1hv1sms.fsf@gitster-ct.c.googlers.com>
 <5C6BAA4E020000A10002FBFF@gwsmtp1.uni-regensburg.de>
 <07106FB4020000CD824A10E1@gwsmtp1.uni-regensburg.de>
 <AC7679FC02000011B9FD70CF@gwsmtp1.uni-regensburg.de>
In-Reply-To: <AC7679FC02000011B9FD70CF@gwsmtp1.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Junio C Hamano <gitster@pobox.com> schrieb am 19.02.2019 um 20:32 in
Nachricht
<xmqqk1hv1sms.fsf@gitster-ct.c.googlers.com>:
> Elijah Newren <newren@gmail.com> writes:
> 
>> +With ‑‑no‑commit perform the merge and stop just before creating
>> +a merge commit, to give the user a chance to inspect and further
>> +tweak the merge result before committing.
>> ++
>> +Note that fast‑forward updates do not need to create a merge
>> +commit and therefore there is no way to stop those merges with
>> +‑‑no‑commit.  Thus, if you want to ensure your branch is not
>> +changed or updated by the merge command, use ‑‑no‑ff with
>> +‑‑no‑commit.
> 
> While the above is an improvement (so I'll queue it on 'pu' not to
> lose sight of it), I find the use of "do not need to" above somewhat
> misleading.  It solicits a reaction "ok, we know it does not need
> to, but it could prepare to create one to allow us to further muck
> with it, no?".
> 
> IOW, a fast‑forward by definition does not create a merge by itself,
> so there is nowhere to stop during a creation of a merge.  So at
> least:
> 
> 	s/do not need to/do not/

Agree.

> 
> It also may be a good idea to consider detecting this case and be a
> bit more helpful, perhaps with end‑user experience looking like...
> 
>   $ git checkout master^0
>   $ git merge ‑‑no‑commit next
>   Updating 0d0ac3826a..ee538a81fe
>   Fast‑forward
>     ...diffstat follows here...
>   hint: merge completed without creating a commit.
>   hint: if you wanted to prepare for a manually tweaked merge,
>   hint: do "git reset ‑‑keep ORIG_HEAD" followed by
>   hint: "git merge ‑‑no‑ff ‑‑no‑commit next".
> 
> or even
> 
>   $ git checkout master^0
>   $ git merge ‑‑no‑commit next
>   warning: defaulting to ‑‑no‑ff, given a ‑‑no‑commit request
>   Automatic merge went well; stopped before committing as requested
>   hint: if you'd rather have a fast‑forward without creating a commit,
>   hint: do "git reset ‑‑keep next" now.
> 
> I do not have a strong preference among three (the third option
> being not doing anything), but if pressed, I'd say that the last one
> might be the most user‑friendly, even though it feels a bit too
> magical and trying to be smarter than its own good.
> 
> In any case, the hint for the "recovery" procedure needs to be
> carefully written.

Actually I think if the user specified "--no-commit" and the merge turns out
to be fast-forward, the user could be asked whether to continue or not (instead
of undoinf afterwards); maybe when entering a response is not possible (batch
processing) the merge should be aborted due to "--no-commit" not being possible
(well actually there would never be a commit, even without that option). The
problem is that without prior inspection of the tree you cannot know whether
the merge will be fast-forward or not: fast-forward being an optimization (taht
is enabled by default) makes life more complicated here.

Regards,
Ulrich Windl

