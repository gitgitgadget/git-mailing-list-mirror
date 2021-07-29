Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707C2C4320A
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 09:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC1460C3F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 09:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbhG2J6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 05:58:21 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:25351 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235197AbhG2J6U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 05:58:20 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1m92nv-0009OS-Do; Thu, 29 Jul 2021 10:58:16 +0100
Subject: Re: Using two-dot range notation in `git rebase`?
To:     Daniel Knittl-Frank <knittl89@googlemail.com>
Cc:     Git List <git@vger.kernel.org>
References: <b3b5f044-8c76-ec71-45d6-1c7fea93c519@iee.email>
 <CACx-yZ1Je+tnZdJ21gDPeuQa-QTuY2t9mDujNr7wqJWFMwwzxA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <dc7668ff-37ad-1d9e-fc92-df432549b4e2@iee.email>
Date:   Thu, 29 Jul 2021 10:58:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACx-yZ1Je+tnZdJ21gDPeuQa-QTuY2t9mDujNr7wqJWFMwwzxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/07/2021 17:33, Daniel Knittl-Frank wrote:
> Hi Philip,
>
>     git log upstream..HEAD
>
> gives you all commits reachable from "HEAD", but not reachable from
> "upstream". 

My comment was: why do we need this convenient explanation in the
description, yet 'disallow' it as a method of actually indicating that
very range?

Also log will list all those commits, while the command just wants the
`^start end` commits (equiv: `start..end`), even if rebase (as I'd
understand it) wouldn't want the (^)not notation.

> If you want to rebase this range and copy it onto newbase,
> you'd run
>
>     git rebase --onto newbase upstream

Here `newbase` would be my 'upstream', while `upstream` is the
'oldstream' (much hilarity and confusion...). I already have an
`upstream` set for the branch, but it's not where it needs transplanting
to in this case [That's because the Git for Windows branches are moving
targets as Git itself moves beneath it and dependent patches could be
anywhere! I have a choice of about 5 'onto' locations depending on where
the precursor patches are located..] .

>
> This will take the commits upstream..HEAD (the HEAD argument is
> implicit), and you end up with
>
>     newbase-.....-HEAD
>
> containing all commits from (the previous) "HEAD" up to (but
> excluding) "upstream". If "newbase" and "upstream" are identical, the
> command can be simplified to `git rebase newbase`.
>
> Maybe I'm misunderstanding the problem? Can you give an example of
> `git rebase --onto newbase upstream branch` not working as expected?

In summary, there are two aspect:
- first, being able to use a common short-form within the command, and
- second, that the documentation's description includes rather too many
tricky concepts to properly understand all the ramifications, leaving me
to think "why can't I just say `git rebase --onto here old..end` or `git
rebase --onto here start^..end` ? "

In some-ways it feels the same as the current `git pull` discussion
where historical workflow practices are baked in to the otherwise
workflow-agnostic git command structure.

regards

Philip
>
> Regards
> Daniel
>
> On Wed, Jul 28, 2021 at 5:38 PM Philip Oakley <philipoakley@iee.email> wrote:
>> Is there a reasonable way to use the two-dot range notation in git
>> rebase, particularly in an  --onto situation?
>>
>> In my case I have a short series that depends on both some existing Git
>> for Windows (GfW) patches (`main` branch), and some patches now in
>> `git/master`. I'm now able to rebase it onto the GfW `shears/master`
>> branch which contains both sets of patches (and one that was in the last
>> git release).
>>
>> It felt that it ought to be possible to use a simple two dot range to
>> extract my series, rather than identifying the individual end points in
>> a similar manner to that used in the description"set of commits .. shown
>> by `git log <upstream>..HEAD`".
>>
>> Or is this something that could be a project?
>> --
>>
>> Philip
>>
>>
>

