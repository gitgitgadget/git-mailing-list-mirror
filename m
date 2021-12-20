Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9D2C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 20:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhLTUwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 15:52:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56513 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLTUwq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 15:52:46 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E12310FAB1;
        Mon, 20 Dec 2021 15:52:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WxJFYmb0fQh1
        mx6GiyjJrSoLX58/qCm4fSkyPVr2FLE=; b=LkmlcL6dA9XhtVRBENNPxTLp5afi
        aaTquiFzvB+NN6Gh5DemnoEBCf1PkoX3eY0RmE1tb/K3zafZlJbPDQ2dMg5sa1ih
        QBOLy/KGdhsdQsLLrWZeLz9f9vCFpNABZnyflEQj6aHbumxKxTgjjFL9Jnjmmn+3
        CVaIpWsdxcQCUJw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 940AB10FAB0;
        Mon, 20 Dec 2021 15:52:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0592A10FAAF;
        Mon, 20 Dec 2021 15:52:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Be?= =?utf-8?Q?l=C3=B3n?= 
        <carenas@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 2/2] grep/pcre2: factor out literal variable
References: <5fa6962e-3c1c-6dbc-f6d7-589151a9baec@web.de>
        <ba503995-866d-fc80-4e38-b4dfd0e5c5bc@web.de>
        <211219.86o85cwfje.gmgdl@evledraar.gmail.com>
Date:   Mon, 20 Dec 2021 12:52:43 -0800
In-Reply-To: <211219.86o85cwfje.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 19 Dec 2021 20:37:37 +0100")
Message-ID: <xmqqr1a7uhgk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C82507B2-61D6-11EC-876E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think for this and 1/2 it would be really nice to pick up a version o=
f
> Hamza's CI changes:
> https://lore.kernel.org/git/20211118084143.279174-2-someguy@effective-l=
ight.com/

Are there so many incompatible versions of pcre2 library whose usage
are subtly different that we need to protect ourselves with multiple
variants in CI from breakages?

I doubt pcre2 library was _that_ bad.

Adding a special task that builds with the minimum version we
support may not be too bad, but the library should be stable enough
to allow us to declare it sufficient to test the most common version
with the most common build options in our ordinary build job(s).
