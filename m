Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FDCC433F5
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 01:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiAOBIJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 20:08:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65348 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiAOBII (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 20:08:08 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4781A114ABA;
        Fri, 14 Jan 2022 20:08:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lbCy2ERU0s0f
        9OvKC7rJebS1qmgcTHkq3Hh89+5li4s=; b=Dn9zjZFJX+okKO4kGvQFnRp+igiD
        AOpm0qyfH6qPrAAkfvWcyaH8E5jaZoNHVRiofK3k0Gkv/on403JM6vop0AbU1DGX
        jIp4BVxbdwxi2T6IXe24IECX+NkBNGudGB/1UqsLVzGen1xCBughfrfC3jMU2MuY
        bUp9QA5X14Sbf44=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34725114AB9;
        Fri, 14 Jan 2022 20:08:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8410B114AB8;
        Fri, 14 Jan 2022 20:08:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
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
        <220115.86tue5rhlf.gmgdl@evledraar.gmail.com>
        <xmqqsftp7sca.fsf@gitster.g>
        <220115.86h7a5rfdu.gmgdl@evledraar.gmail.com>
Date:   Fri, 14 Jan 2022 17:08:05 -0800
In-Reply-To: <220115.86h7a5rfdu.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 15 Jan 2022 01:41:48 +0100")
Message-ID: <xmqqfspp6c22.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 98CF7A06-759F-11EC-B10A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I'm just suggesting that perhaps a more practical solution is to
> side-step those portability issues by checking this in CI, which I thin=
k
> would be Good Enough on this case.

Use of GitHub PR + GGG is required to take advantage of that, no?  I
do not think I want to see a change that makes it _more_ likely that
a patch I pick up from the list will have problems that my local
integration work will not catch (because DEVELOPER=3DYesPlease build
is castrated at the original contributor side, and also on my box)
and will only be caught after I push out 'seen'.


