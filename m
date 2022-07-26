Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E35C433EF
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 04:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiGZEsj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 00:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiGZEsi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 00:48:38 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816EA248CD
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 21:48:35 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D63C144029;
        Tue, 26 Jul 2022 00:48:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qn1eINUskyDI/ZTFUkz3Bz3Mm5ABd0otFmebBI
        1XI6k=; b=JU8AvKkeSLd0Mo1yzGlqFWJL7VvPvxvQtEzmevgLriniXS73eLTEtJ
        xjqhzcI4wHq6jERsUksf9Tc1MEXYKYOCtFY0HH778a834QGLR6ocC1Y+bPPiqAYa
        WrVAeuFIzPjIyZihMi8X1WLCYohxin13EorbzSC6ONAEYDM39B//8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64943144028;
        Tue, 26 Jul 2022 00:48:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 96EF6144027;
        Tue, 26 Jul 2022 00:48:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: C99 "for (int ..." form on "master"
References: <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
        <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
        <d3eac3d0bf6539d81751813d89ec5158dcb57338.1656653000.git.gitgitgadget@gmail.com>
        <220701.86o7y9b2ys.gmgdl@evledraar.gmail.com>
        <220725.86zggxpfed.gmgdl@evledraar.gmail.com>
        <CABPp-BHvQwct2WRRYGyzm=YVkjmwBqoe1DUtCicuQW=jrQ2hdA@mail.gmail.com>
Date:   Mon, 25 Jul 2022 21:48:32 -0700
In-Reply-To: <CABPp-BHvQwct2WRRYGyzm=YVkjmwBqoe1DUtCicuQW=jrQ2hdA@mail.gmail.com>
        (Elijah Newren's message of "Mon, 25 Jul 2022 19:14:12 -0700")
Message-ID: <xmqqy1wgwkbj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3413079A-0C9E-11ED-94A5-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Thanks for catching this and bringing it up; sorry for missing it earlier.
>
> 6563706568b says we should "revisit this *around* November 2022"
> (emphasis added).  2.38 will be released in October 2022.  So, maybe
> it's fine as-is.
>
> But if others prefer these be fixed over moving up the deadline, I'll
> go ahead and submit a patch.
>
> I guess we just need a call.  Junio?

I do not see a need to do anything special at this moment.

When somebody reports that their favorite compiler does not yet grok
the syntax, we can ask them to ensure that there are only two places
that need "fixing" for them to compile.  It would have been ideal if
we kept the "weather balloon" to the only one known place, but the
second one would not be a disaster.

We would re-evaluate the situation when such a report comes, but
even if we decide to stay away from the syntax a bit longer, we know
exactly where the only two places we need to revert are.

One thing we should absolutely avoid is to open the floodgate and
deliberately add more of them, just for the sake of adding more of
them.

Thanks.

P.S. Tomorrow is that "gitster goes offline every other Tuesday"
day.
