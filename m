Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A73C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 18:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356017AbiALSGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 13:06:24 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65261 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356001AbiALSGU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 13:06:20 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 83EB216B1AB;
        Wed, 12 Jan 2022 13:06:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PaKKsK+36fwB
        SY8z+dgcoEHATB+6UG3GyMtYc0ck16k=; b=Of0s9rNmFORE+F+mXX+hhoBDhYhr
        XVLEN0NySv+CE43PfCzVfLMM5/5OwDZuCK8cBWtBn0cwOu0pn06U86o2qa0SCNB6
        TwR3WhOUMVOvssbFO8+AxeMv8w5fWQ/YNJMpk4tUkQ88ibILGZYokMnybkcWMZlG
        mYqvweKQ1yJx3x0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D34F16B1AA;
        Wed, 12 Jan 2022 13:06:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E3EFB16B1A9;
        Wed, 12 Jan 2022 13:06:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH 0/2] Introduce new merge-tree-ort command
References: <20220105163324.73369-1-chriscool@tuxfamily.org>
        <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com>
        <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com>
        <CABPp-BHpuLjCYycBwweMW_NdQrS_r3ECmvLb8XjNW-_Rau5NTw@mail.gmail.com>
        <nycvar.QRO.7.76.6.2201101427440.339@tvgsbejvaqbjf.bet>
        <xmqq8rvn1nkw.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2201111439190.1081@tvgsbejvaqbjf.bet>
        <220111.86mtk2xb1y.gmgdl@evledraar.gmail.com>
        <CABPp-BFei07srZBgyKs6HCm+G+hmPR-3_EkKjRK8WwGL1Uf2oA@mail.gmail.com>
Date:   Wed, 12 Jan 2022 10:06:13 -0800
In-Reply-To: <CABPp-BFei07srZBgyKs6HCm+G+hmPR-3_EkKjRK8WwGL1Uf2oA@mail.gmail.com>
        (Elijah Newren's message of "Tue, 11 Jan 2022 14:25:56 -0800")
Message-ID: <xmqqk0f4x20a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 551613DE-73D2-11EC-9FF4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> And isn't any doubt around that even more reason to just go with
>> Elijah's plan of introducing new plumbing? I.e. is it really costing u=
s
>> to just leave these "legacy merge" plumbing built-ins
>
> I definitely think it's worth guiding users away from the old `git
> merge-tree` behavior in documentation (i.e. deprecating it).  That may
> also lead towards its eventual removal, but I'm not as worried about
> that.

Yup, promising users that we will remove it and telling them that
they should migrate away from it is necessary.  Doing anything else
is simply irresponsible.

I however suspect that =C3=86var didn't mean by "legacy merge plumbing
built-in" the strategy backends.  IOW, I had an impression that what
is on the chopping block is merge-tree and not merge-recursive.

But since you brought up deprecation of recursive, let's spend a few
minutes on the topic.

> `git merge-recursive` was actively used in various places, including
> in `git cherry-pick`.  I had used it a few times myself in a script.
> I don't see a need to deprecate it currently, which naturally would
> push its removal (if anyone is pushing for it) even further away.

I suspect that we may be able to just invoke ort when recursive is
invoked, and such a wrapping may even be easier than wrapping "git
blame" to replace "git annotate" (where a command line option or two
needs to change behaviour).  I doubt there is -X<strategy-option>
that affects recursive that ORT does not understand, so it may be
quite simple to deprecate "merge -s recursive".

As you say, replacing the internal implementation is a different
matter.

>   * `merge-recursive.c` is still hard-coded in three places in the
> code; you can't even set a configuration option to choose merge-ort.c
> in those places: builtin/am, builtin/merge-recursive, and
> builtin/stash.
>
> More details on that second point: All three of these use
> merge_recursive_generic() and need that usage to be replaced.  It's on
> my TODO list.

Yes, I do recall mentioning that when we were reviewing the series
that added ort.
