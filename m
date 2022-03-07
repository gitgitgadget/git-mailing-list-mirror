Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7CFC433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 17:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242891AbiCGRhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 12:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240673AbiCGRhV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 12:37:21 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183AF8F9BB
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 09:36:27 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9F9B9179938;
        Mon,  7 Mar 2022 12:36:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SWvUMS7Lif6Y
        ASnsmUYPD6sSRo0k0/7nOtuJR6RMDj4=; b=fp6qBRkA2225hdMSRze112+CGzKY
        HVaQ0I9NTWup403jjR3eih1E2C1/zdacVJwmA6zE0ghQxRHVNt9ajmrv01JCihk3
        Ij8lCo29YTGpljtJ64dw0hkX0Jr4Gom2cwiGLGednokWkjmK/v53Rn751ZrpULQC
        AYBQd++hfcjwhTU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 97E8A179937;
        Mon,  7 Mar 2022 12:36:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 18B91179936;
        Mon,  7 Mar 2022 12:36:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
        <220302.86mti87cj2.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2203071655070.11118@tvgsbejvaqbjf.bet>
        <220307.86tuc9yc4b.gmgdl@evledraar.gmail.com>
Date:   Mon, 07 Mar 2022 09:36:22 -0800
In-Reply-To: <220307.86tuc9yc4b.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 07 Mar 2022 17:05:54 +0100")
Message-ID: <xmqqtuc9sm09.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1BF9521A-9E3D-11EC-A7A2-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think that's a rather strange conclusion given that I've submitted a
> parallel series that makes some of those failures easier to diagnose
> than the same changes in this series. I.e. the failures in build
> v.s. test phases, not the individual test format output (but those are
> orthagonal).

If you have a counter-proposal that you feel is solid enough, I do
not mind dropping the topic in question and replacing it with the
counter-proposal to let people see how it fares for a few days.  If
it allows others to view the output easily if you revert the merge
of this topic into 'seen' and replace with the counter-proposal and
push it to your own repository, that would be an even better way to
highlight the differences of two approaches, as that would allow us
to see the same failures side-by-side.

Am I correct to understand that one of the the common goals here is
to eliminate the need to discover how to get to the first failure
output without turning it slow by 10x to load the output?

> I think it's clear that we're going to disagree on this point, but I'd
> still think that:
>
>  * In a re-roll, you should amend these patches to clearly note that's =
a
>    UX trade-off you're making, perhaps with rough before/after timings
>    similar to the ones I've posted.
>
>    I.e. now those patches say nothing about the UX change resulting in
>    UX that's *much* slower than before. Clearly noting that trade-off
>    for reviewers is not the same as saying the trade-off can't be made.

Whether we perform counter-proposal comparison or not, the above is
a reasonable thing to ask.

>  * I don't see why the changes here can't be made configurable (and
>    perhaps you'd argue they should be on by default) via the ci-config
>    phase.

I do not know if such a knob is feasible, though.

Thanks.
