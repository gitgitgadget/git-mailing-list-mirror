Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4486DC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 07:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 172B564F0E
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 07:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhCLHKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 02:10:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65162 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhCLHKW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 02:10:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F4C412EF8F;
        Fri, 12 Mar 2021 02:10:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FkO0yEM1n/acWJHaKO+bbKxlGGQ=; b=kvp1Ns
        9QmRo8ptpSpGtvkEXLH8bbM439xrLog7AviIlfYUx0FlTCF6GxhwyCrGSN6qmrap
        vB2MzEtKo1OVc3XPox8VoPef6eCg8tqI1fC5vOVo6R5hNE0msQtqsUGVh8lsvKQp
        xiDbv88K8Q+o1H1rGyvPcHWwg7LvYnMrUsR9I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pkzzFNGXcElmxEt6Cod8L4sIo9ibyYOR
        IvqgLlVlwvJy0WJCujj4ADuH8oNrNgNVzArk+zg/WkWADy8+rMWwlgw/ZjY8tr57
        e8cp+NtrthtZWo3ZdzHkOyF02rpIqK62N5KiDmlotQFouIjTHSUr3r6YefOGE8NS
        +CFWPOB8lVQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B84712EF8E;
        Fri, 12 Mar 2021 02:10:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B5BA912EF8D;
        Fri, 12 Mar 2021 02:10:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: What's cooking in git.git (Mar 2021, #03; Wed, 10)
References: <xmqqmtvafl62.fsf@gitster.g> <87r1klhq3y.fsf@evledraar.gmail.com>
        <xmqqy2etczqi.fsf@gitster.g>
Date:   Thu, 11 Mar 2021 23:10:17 -0800
In-Reply-To: <xmqqy2etczqi.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        11 Mar 2021 10:27:33 -0800")
Message-ID: <xmqqwnucaluu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01290784-8302-11EB-82EB-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> * ab/make-cocci-dedup (2021-03-05) 4 commits
>>>  - Makefile/coccicheck: set SPATCH_BATCH_SIZE to 8
>>>  - Makefile/coccicheck: allow for setting xargs concurrency
>>>  - Makefile/coccicheck: speed up and fix bug with duplicate hunks
>>>  - Makefile/coccicheck: add comment heading for all SPATCH flags
>>>
>>>  An attempt to speed up the coccicheck target with incorrect
>>>  results.
>>>
>>>  A reroll exists to address correctness issue, but not picked up.
>>
>> Any reason for not picked up other than "rc period etc...".
>
> As I always say, please don't read anything more than "I happen to
> have seen it" in being in 'seen'.  And that does not even mean
> everything I saw would be on 'seen'.  Especially during the
> pre-release freeze.  I may have time to pick up a replacement for a
> topic that is already in 'seen', to make sure there aren't unexpected
> new conflicts I'll later have to resolve, and if it is too bad, I may
> even drop the old iteration (because it is stale and a new one exists)
> and the new iteration (because it may be fresher but does not work
> well with others).
>
>> I'm
>> confident the patch at
>> https://lore.kernel.org/git/20210306192525.15197-1-avarab@gmail.com/
>> addresses the intra-series bug, and the whole thing solves outstanding
>> bugs on master.
>
> I recall seeing you use a new option to coccinelle that I did not
> get any hit on my search engine in the updated series.  Is the world
> ready for the thing?

So, I had a chance to go back to the list discussion to double check
the details of what I vaguely recalled when I wrote it.

In [v2 5/4] we revert an earlier change to use "--no-includes" in
[v2 2/4] (which got "This part still doesn't make any sense to me."
by Peff) back to use "--all-includes".  If we were fixing an earlier
regression in a hurry, such a messy history may have to be accepted,
but because we are not in a hurry, I'd rather see the series
straightened up.

We start using "--include-headers-for-types" on SPATCH_FLAGS while
doing so, which I didn't find any hits, but a fresh search found
this http://lira.epac.to:8080/doc/coccinelle-doc/manual.pdf and it
seems that at least at release 1.0.4 (Jan 6, 2019) the option is
available.  I couldn't find a reference for the oldest version that
we can safely use, though.

For now, I'll drop the one listed in the "What's cooking" report you
cited above (because it is stale and a new one is coming), and will
wait for a new iteration in a cleaned-up form (because we do not
want to see "ok, let's do no-includes" followed by "ah, that was a
mistake, let's use all-includes like before").

Thanks.
