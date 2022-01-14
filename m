Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EF5C433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 19:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244179AbiANTra (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 14:47:30 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51817 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbiANTra (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 14:47:30 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE880168A3D;
        Fri, 14 Jan 2022 14:47:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N2qdYr3T94vPSpYrF/RyvrSQP4TMvrt0Z1EMy5
        +6acU=; b=HDimVyWKJKAWlI5U2HmzUM87sAW3TZmnt8wL3UzjbpyCOsFPLfpUBU
        iXHpUh8I6GImb5J1UfSQqDLhgOOw5bQxKcGfza/QZZcmp3Z1E4YE08MB5TSUpSs/
        3funk4f354rbNM367F4XCuvvqAej/ZWsn6boSgOeOBXh4FPrnbCmk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E6CC3168A3A;
        Fri, 14 Jan 2022 14:47:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4FAA5168A39;
        Fri, 14 Jan 2022 14:47:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2022, #03; Thu, 13)
References: <xmqq35lrf8g4.fsf@gitster.g> <xmqqk0f3dk5o.fsf@gitster.g>
        <CABPp-BFGxKBzi5RYDuiJv6Vz7yyGYTOdJC9cL_EkPGNJ5BksYQ@mail.gmail.com>
Date:   Fri, 14 Jan 2022 11:47:26 -0800
In-Reply-To: <CABPp-BFGxKBzi5RYDuiJv6Vz7yyGYTOdJC9cL_EkPGNJ5BksYQ@mail.gmail.com>
        (Elijah Newren's message of "Fri, 14 Jan 2022 08:27:54 -0800")
Message-ID: <xmqqmtjyaylt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD574150-7572-11EC-901B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> It's apparently the latter, because there have been no test script
> changes in the relevant tests.
>
>> Somebody with too much time on their hand should go in and check to
>> help, before CI testing on 'seen' becomes useful again.
>
> This "fixes" seen:
> https://lore.kernel.org/git/pull.1192.git.git.1642176433017.gitgitgadget@gmail.com/
>
> I briefly looked at a couple leak traces and thought they looked ref
> related, but I don't have time to go hunt down memory leaks right now.
> I figure this thread has reported them, so let's just get "seen" back
> to green.

If it were "we added a use of known-to-leak command in an otherwise
clean test, without adding a new leak", I would wholeheartedly
support such a change, but if it is the other way around, it may
make sense to leave it broken as an incentive for people who care
about leaks to go in and fix them up.

If we toggle it off any time leak-checker CI job starts complaining
on a test script, the leak-checker CI job serves no useful purpose,
no?

An obvious alternative, based on the same attitude, is to rip out
the whole fragile leak-checker thing from the CI.  I've mentioned
an ideal alternative (disregarding feasibility) already elsewhere
so I won't repeat it.

Thanks.

