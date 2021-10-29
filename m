Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C736BC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A992760F02
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhJ2Uru (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:47:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54661 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhJ2Urp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 16:47:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 761E515E2D8;
        Fri, 29 Oct 2021 16:45:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SIJvL8Spk87jEt5OSSud6oi8LxrUTwbfDh60Rk
        ZNgG0=; b=HdQOfkEIu/A4SeBeF0H6jl2rNy6PPS3L5IXwHzYZlBlBWU4iu5BZzZ
        /17gFfEo34vu+V+BzU1T9OivQm/AUWqcLZfTEpBa/yVjiTRBIke2G7YV/P8+UDAg
        8RgNMGIVvWKQy6vyvQiQdu9D3fDdIsTzSyuUz7wo/sMkr2JLtZo8I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F40415E2D7;
        Fri, 29 Oct 2021 16:45:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1127615E2D2;
        Fri, 29 Oct 2021 16:45:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Krzysztof =?utf-8?Q?=C5=BBelechowski?= <giecrilj@stegny.2a.pl>,
        git@vger.kernel.org, Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: *Really* noisy encoding warnings post-v2.33.0
References: <9896630.2IqcCWsCYL@localhost.localdomain>
        <YSWVi8uLHZCTtG0l@coredump.intra.peff.net>
        <xmqqeeahjxj4.fsf@gitster.g>
        <YSkvNyR4uT52de13@coredump.intra.peff.net>
        <87ily7m1mv.fsf@evledraar.gmail.com>
        <YWEAEjIN0HVHbIpg@coredump.intra.peff.net>
        <YWEBmJk0aENR5Yeo@coredump.intra.peff.net>
        <871r4umfnm.fsf@evledraar.gmail.com>
        <YXkx6WzoF+B1id5T@coredump.intra.peff.net>
        <211029.86bl38w124.gmgdl@evledraar.gmail.com>
        <YXxcIQQS7GQzRwUa@coredump.intra.peff.net>
Date:   Fri, 29 Oct 2021 13:45:11 -0700
In-Reply-To: <YXxcIQQS7GQzRwUa@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 29 Oct 2021 16:40:01 -0400")
Message-ID: <xmqqk0hvk1bc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D473438-38F9-11EC-8926-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> TBH I am not even sure it is worth spending a lot of brain cells on the
> "and then consider..." part. Over all these years, we've had one report,
> and it simply misunderstand what "--encoding" was for. I thought it was
> something we could fix up easily by checking a return value, but IMHO
> doing it right is quite tricky because of iconv()'s limited interface,
> and the risk of regression outweighs the potential benefit.

I tend to agree with the above.  Let's not over-engineer things.
