Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB30C433EF
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 01:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350548AbiASBCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 20:02:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63088 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbiASBCg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 20:02:36 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 829F111BE59;
        Tue, 18 Jan 2022 20:02:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UJTUsGofhG/h
        hClL23REV3YAvJ5S/1ujQb1VRE/7HsM=; b=LnPrTUR7ipncGXfq0KCWFDJyZDiV
        lUy2YqSxbN8z7CU3mOAUZa4J0AklY9uVah3bpN9lmmtVk4kMgt6PeDnDMBslTNIG
        RZQ6lovtvxHu+p3Il6++r8SY1ztEaop7Alf4/s/HCFB6lNKj1/+6BzJfXER4ukKc
        bXSFOsbB5OwzXMw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7299E11BE58;
        Tue, 18 Jan 2022 20:02:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D5CFC11BE57;
        Tue, 18 Jan 2022 20:02:34 -0500 (EST)
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
Date:   Tue, 18 Jan 2022 17:02:33 -0800
In-Reply-To: <220119.86o848o8ao.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 19 Jan 2022 01:29:47 +0100")
Message-ID: <xmqq7dawpmfq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7CC5DFC2-78C3-11EC-88A1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Whereas the C11 warning is "just" recent FreeBSD && DEVELOPER=3D1.
>
> So I assumed if you weren't interested in the former before the final
> you probably wouldn't be in the latter, but wanted to provide a more
> narrow fix in case you were.

If we muck with the inclusion of libgen.h, it then becomes a problem
for everybody who builds on FreeBSD, not just the developer builds.
IOW, it is not even narrower to begin with.  Giving the same
potential breakage to everybody will make it easier to diagnose it,
but because I do not trust -std=3Dgnu99 on today's FreeBSD, I think it
is a problem we do not even have to solve.

> I.e. the point of doing it is to avoid the one-time pain of anyone
> building new releases of git on $OLD_OS/$OLD_DISTRO not having to run
> into the compilation error that's fixed with NO_UNCOMPRESS2=3DY.
> ...
> If we then get this into v2.36.0 there'll be someone somewhere that
> benefits, but I'd think the ship has sailed for most of those who'd
> avoid the needless flag twiddling (git-packagers@ et al).

I actually think it is a good thing.  It is what they brought onto
themselves.  They can follow David's example next time.
