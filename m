Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01609C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 01:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350612AbiASBT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 20:19:29 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50064 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbiASBT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 20:19:27 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C3D717FD46;
        Tue, 18 Jan 2022 20:19:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PkSRz3S226DL
        txZzFGV44lYuzsPPzRivpvcDIH2Z1XY=; b=cbFBcqIgrmfERZf5lVQP4L03I46+
        WNwFGOS341p9LKD8gKrAo26sOHqG826zb5UPPOyFJYLCRaCaz4MgBxuQaJ8k3BVS
        cGP/h1Umv/BVG5sqK45kQZ2esnwcstumHohyYMOACD7cRpkXXbH0W3QJdblpP2o1
        +tqLM+Ohj6pnZCM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2480D17FD45;
        Tue, 18 Jan 2022 20:19:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9071A17FD44;
        Tue, 18 Jan 2022 20:19:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: v2.35.0 DEVELOPER=1 regression
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
        <xmqqlf0w5bbc.fsf@gitster.g>
        <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net>
        <xmqq4k7j68eg.fsf@gitster.g>
        <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>
        <211209.867dcekm9h.gmgdl@evledraar.gmail.com>
        <YbMWNZCpy578Qu+l@coredump.intra.peff.net>
        <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
        <YeDUA6NhHuCUkqXf@camp.crustytoothpaste.net>
        <xmqqilumayfh.fsf@gitster.g> <xmqqzgny7xo7.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2201181308540.2121@tvgsbejvaqbjf.bet>
        <220118.86iluhoyio.gmgdl@evledraar.gmail.com>
        <xmqqh7a0ssuh.fsf@gitster.g>
        <220119.86o848o8ao.gmgdl@evledraar.gmail.com>
        <xmqq7dawpmfq.fsf@gitster.g>
        <220119.86fspko7fo.gmgdl@evledraar.gmail.com>
Date:   Tue, 18 Jan 2022 17:19:23 -0800
In-Reply-To: <220119.86fspko7fo.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 19 Jan 2022 02:05:25 +0100")
Message-ID: <xmqqwniwo738.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D69C80C6-78C5-11EC-8E3D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> As noted I'm a bit "meh" on my own patch if it's not in the release. I'=
m
> just trying to see where you stand, since you seemed to want a re-roll
> of it post-release....

I was hoping to see a quick reroll that would be in time for the
release, but it seems it was overly optimistic back when I gave my
initial review.  I do not see it happening given that I'd be tagging
the -rc2 tomorrow.

I do think in the longer term, we should aim to retire the current
mechanism and depend more on ZLIB_VERSION_NUM.  I am not optimistic
that we can have a reasonable version before the final.
