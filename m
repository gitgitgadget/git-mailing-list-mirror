Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9257C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 19:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8BF661250
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 19:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345565AbhIXTj0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 15:39:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53925 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344259AbhIXTj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 15:39:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BCB051535CB;
        Fri, 24 Sep 2021 15:37:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HGN+zc+cEvrY
        /TyLM8Gp2VZRtAOI6oDxmltAfWQ/yw0=; b=cy+MDDeYmIJjWLFr/Bqhysyppqf9
        QayBvMYOA33KEax+tiqK2EvdzOtq3e+GOl76IDiAyjrcAVbazKOssdhCBAX5+ZCn
        HBc56gpehL4Xxq4+pqFnzpIV24+zRW5ai0b6BBHvxi7Bf++a9dLMSUmJ87Z4si10
        MCWjeYnfRvSOf7o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B5AAB1535CA;
        Fri, 24 Sep 2021 15:37:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 20EC51535C3;
        Fri, 24 Sep 2021 15:37:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] Makefile: make the "sparse" target non-.PHONY
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
        <patch-v2-1.1-059829f2195-20210923T000654Z-avarab@gmail.com>
        <YUyqIpOLFDqG/kEJ@coredump.intra.peff.net>
        <xmqqtuib199x.fsf@gitster.g> <875yuq4u4u.fsf@evledraar.gmail.com>
Date:   Fri, 24 Sep 2021 12:37:48 -0700
In-Reply-To: <875yuq4u4u.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 24 Sep 2021 03:30:10 +0200")
Message-ID: <xmqqwnn5sr1v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E70B4F62-1D6E-11EC-B2AA-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Would you be OK with just running something like this instead?:
>
>     make -j $(nproc) objects CC=3Dcgcc CFLAGS=3D"-no-compile -Wsparse-e=
rror -Wno-pointer-arith -Wno-memcpy-max-count"

Counting both machine and human time cost, I'd rather go with "make
foo.sp", even if it is much slower than before, than having to type
that, or having remember to run a custom script that encapsulates
the above, which is something different from just typing "make".

Of course, I'd be happier if "make sparse" did dependencies right
*and* did not involve real compilation, but if that is beyond our
capability, then so be it --- I do not that deeply care ;-)


