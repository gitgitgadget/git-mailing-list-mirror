Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E4BC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 08:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA5461BF5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 08:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhKQIwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 03:52:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58362 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbhKQIwN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 03:52:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7719715845D;
        Wed, 17 Nov 2021 03:49:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=V3/QKpwu1zA4oa71/MEYIW1Nv
        dH0CNYni0XQoK5joB4=; b=H7sYUjFOcLmXbcVQTNksK0UyjxzU+lQCpAx65oDmz
        xQCAcpHyOyoLQXIJZt1bNm/8oE5t8Sgqn/R06VfzwDFEOX0p8LxtJwtuvq9WrhsE
        X8IMwJtRlUsOdA+/r9nTh0X5AY8SMlKT51PinlnjlqZZ0TJK0YjLyJbwnTtfB146
        uE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6FEAB15845C;
        Wed, 17 Nov 2021 03:49:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C196915845A;
        Wed, 17 Nov 2021 03:49:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Carlo Arenas <carenas@gmail.com>
Subject: Re: [PATCH v2 1/1] git-compat-util: add a test balloon for C99 support
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
        <20211116021241.1565740-1-sandals@crustytoothpaste.net>
        <20211116021241.1565740-2-sandals@crustytoothpaste.net>
        <YZOh370ZMMqSADUE@coredump.intra.peff.net>
        <211116.86pmr0p82k.gmgdl@evledraar.gmail.com>
        <YZPGKHYE/9km1rH5@coredump.intra.peff.net>
Date:   Wed, 17 Nov 2021 00:49:10 -0800
Message-ID: <xmqqwnl72mm1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3C36046C-4783-11EC-B1D5-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Nov 16, 2021 at 01:54:27PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> But IMO this whole thing of trying to make this work on every compiler
>> etc. just isn't worth it.
>>=20
>> Let's just start using C99 features, and if anyone's compiler breaks o=
n
>> something like CentOS 6 document that they'll need to tweak a flag
>> somewhere. We already know that works for all the other C99 features w=
e
>> have, there seems to just be this one exception of the ancient GCC
>> version in this particular case.
>
> Yeah, I definitely agree with this sentiment.

+1, provided that we are not saying that "we will start using any
random C99 features" without limit.  I do appreciate the way the
previous efforts were conducted, to start with small test balloons
that can easily be backed out and leaving it there for sufficiently
long time.
