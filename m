Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DC2C433EF
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 19:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiAOTiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jan 2022 14:38:08 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55301 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiAOTiH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jan 2022 14:38:07 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 533F916D20B;
        Sat, 15 Jan 2022 14:38:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MpJ5Lh20y0rDEGLYmPDUsAIHc03z2GgbwcSBFL
        OnCD8=; b=Ev38PFPt1Pq6Uj0f+dJbQGe7PUSnRHcUlE63zj6+ANZog/fFMHoY5n
        HKb6f5bxPZNXwWnsMblBtA+1h+h9+q6lkIhKThBwd2YmxShCcMsJUgtbW09myPlc
        Tz2I0CZpXFy783B5hQoqUXnnxLfMngmQw/TSAmrfpMrg9jse4OUCo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4BAA016D20A;
        Sat, 15 Jan 2022 14:38:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BBBD616D209;
        Sat, 15 Jan 2022 14:38:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: Mistakes in the stalled category?
References: <xmqq35lrf8g4.fsf@gitster.g>
        <CABPp-BFj8NyXG6cQPJeDE46eicbfnP=TgEirRZVcnMM+YNG7OQ@mail.gmail.com>
        <xmqqlezh98uj.fsf@gitster.g>
Date:   Sat, 15 Jan 2022 11:38:03 -0800
In-Reply-To: <xmqqlezh98uj.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        14 Jan 2022 15:49:08 -0800")
Message-ID: <xmqqiluk4wo4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A871B49C-763A-11EC-9AB2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Elijah Newren <newren@gmail.com> writes:
>
>>> [Stalled]
>>>
>>> * ds/sparse-checkout-requires-per-worktree-config (2021-12-21) 5 commits
>
> [Stalled] being early in the report is primarily a way to remind us
> that an update is overdue.
>
> <1db0f601-4769-15c0-cd58-ecddfa1fc9d5@gmail.com> is what prompted me
> to consider that I can put it on backburner and spend my time on
> other topics.

The pushout of 'seen' I did after -rc1 last night included this
topic again; https://github.com/git/git/actions/runs/1700157728

The CI job triggered Leak Sanitizer in "git init" (the first thing
tests do is to prepare a test repository with working tree, so there
may be other new breakages, but we wouldn't know) and broke CI.

This morning, just to test, I ejected this topic from 'seen' and
pushed it out; https://github.com/git/git/actions/runs/1702373554

As the only difference between these two runs is this topic, it may
be worth looking into locating and fixing new leaks introduced by
it.

Thanks.
