Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF215C433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 22:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiAaWGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 17:06:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63733 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiAaWGL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 17:06:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E9FC121FA3;
        Mon, 31 Jan 2022 17:06:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=87L+Jdh4fVgU
        KE1E9j667Vj/0pU7Nuk0X/thThCHzEo=; b=wr1gDImdATLID6ZDP+seNv7TMRln
        z2PsT7/44LwTPAT6MVaw+6BT8Y602H+clOhjxnFmp0MSNWmLOp6pcXQZq/Tua+Xi
        A9BA9j7OD/+YNkGINcqTtpgqqN/wOABGCQM9mXbjS6y1Bt0AYpVrntvSeARUQF8V
        v88ZbTRfMhv+kdU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9452E121FA2;
        Mon, 31 Jan 2022 17:06:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B6954121FA1;
        Mon, 31 Jan 2022 17:06:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] repo-settings: fix checking for
 fetch.negotiationAlgorithm=default
References: <pull.1131.git.1643334969216.gitgitgadget@gmail.com>
        <220128.86ee4scn2s.gmgdl@evledraar.gmail.com>
        <CABPp-BEehHHbDi_muWHCaT1GvRmPbPiMmvB-2O9+0w2A+yEM0Q@mail.gmail.com>
        <xmqqfsp3kfm0.fsf@gitster.g>
        <CABPp-BHcS3nwupJSORUuVeVhGzrL3VqPm4YQSr7G-JuyLaqBpQ@mail.gmail.com>
        <220131.864k5jbo5h.gmgdl@evledraar.gmail.com>
Date:   Mon, 31 Jan 2022 14:06:08 -0800
In-Reply-To: <220131.864k5jbo5h.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 31 Jan 2022 22:03:18 +0100")
Message-ID: <xmqq5ypzimr3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FEEA98DA-82E1-11EC-AF00-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Sounds good to me.  I'm not very creative, so I think I'd just use
>> "non-skipping" as the new name.
>
> I can't think of a better one either (aside from my already-suggested
> "exhaustive"), but that's naming it in terms of the only other
> negotiator.

Skipping and the other one are both commit graph walkers.  The
traditional one reports each and every commit without skipping, so
if the negation in "non-skipping" turns out to be problematic in
naming, perhaps we can say "consecutive" vs "skipping" as the
differentiator between the two?

> E.g. if we were to make one called "smart-topology" or something (would
> skip sending some OIDs by assuming things about branch/tag topology,
> i.e. if you have X that probably includes Y) having negotiators "A",
> "non-A", and "C" would be odd :)

It is good to anticipate that somebody cleverly invents negotiator
that is not based on "commit walker" concept ;-)

