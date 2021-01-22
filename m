Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8854CC433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 18:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DACC23AAC
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 18:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbhAVSlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 13:41:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55310 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729673AbhAVSWh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 13:22:37 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 07C11A7079;
        Fri, 22 Jan 2021 13:21:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KHtrMaVDj2D1c5eQ+CKqtTGs+rs=; b=WM8752
        lM3X/pRenf+/3h67eEIOJFAsA5uhfYiAdtExFiVjyxQ5ukWsZTwAHA7ixmdlFmiN
        BHab9RqYs9iUnztU2J2Yi2SVzcQLKX3e88/GFOI96g3rtgJodPjgZQRzl3sG0HmZ
        e+SROAybN5RXeC2sIguKRfJHHEaCo0qv3hR/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cb+HqxWGQE2V45NPbyzPVTYwfhez5bjw
        q2NLEIMCImKwxw/Yn6XjHb0DiQWX3ZV2IyaxCvik9V5i730c5qjans/GndbNjb/t
        9rHz7wUuZDqAWqSzZ6a5hHzAWwMEHkWPIY/FXlC0W0YZl7BUptXUf75dIHsJ/P+v
        ZEdn9jp7wKo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F1168A7078;
        Fri, 22 Jan 2021 13:21:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 79FEAA7077;
        Fri, 22 Jan 2021 13:21:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/3] range-diff(docs): explain how to specify commit ranges
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
        <041456b6e73b3a88097d0cc06056eb43d35d42c6.1611267638.git.gitgitgadget@gmail.com>
        <xmqqwnw5am64.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2101221720200.52@tvgsbejvaqbjf.bet>
Date:   Fri, 22 Jan 2021 10:21:53 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2101221720200.52@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 22 Jan 2021 17:21:37 +0100 (CET)")
Message-ID: <xmqq1recal32.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B47762F8-5CDE-11EB-8ED5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +- `<rev1>...<rev2>`. This resembles the symmetric ranges mentioned in
>> > +  the `SPECIFYING RANGES` section of linkgit:gitrevisions[7], and is
>> > +  equivalent to `<base>..<rev1> <base>..<rev2>` where `<base>` is the
>> > +  merge base as obtained via `git merge-base <rev1> <rev2>`.

The above paragraph says A...B is turned into $(git merge-base A
B)..A and $(git merge-base A B)..B, but I wonder if we should be
rewriting it into A..B and B..A instead; that would make it
unnecessary to explain what should happen when there are more than
one merge bases.

>> Does this merely resemble?  Isn't it exactly what a symmetric range is?
>
> No, it is not exactly what a symmetric range is because `range-diff`
> treats both arms of the symmetric range independently, as two distinct
> non-symmetric ranges.

This however is an end-user documentation, isn't it?

The fact that range-diff internally translates A...B into something
else is an implementation detail of achieving something, and from
the end-users' point of view, isn't it "take A...B from the
end-user, and show the difference between the left and right
branches of the symmetric range" that range-diff achieves to do?

So it processes exactly the same two sets of commits as what is
given by "--left-right A...B", no?
