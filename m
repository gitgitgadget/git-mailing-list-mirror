Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBDCC4332F
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 22:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhLOWRv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 17:17:51 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52567 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhLOWRp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 17:17:45 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DC04617023C;
        Wed, 15 Dec 2021 17:17:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H12A6+LtTMx39KoTf/RUpGqgDGnnph7fRz9Hve
        JFyqs=; b=PwBgwu+EQ8yZKOdNpsRBcpgKPFU5LAIKllPJzOny53KnHOmVeKUdVu
        yLLeJQeYeCOKYYcki4maJuNeNoWj7jINvzVWUmejC+oOVQKwf3v/icYvwmoM1uN7
        goOQbqJ6D91OSwbnLddpDZy6O+m7NAqvi+6osmetrlyFKaRiCM9UA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D5DB117023B;
        Wed, 15 Dec 2021 17:17:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 194EF17023A;
        Wed, 15 Dec 2021 17:17:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, stolee@gmail.com
Subject: Re: [PATCH v2 0/8] midx: prevent bitmap corruption when permuting
 pack order
References: <cover.1638991570.git.me@ttaylorr.com>
        <cover.1639446906.git.me@ttaylorr.com> <xmqqee6d648n.fsf@gitster.g>
        <YbpgHBcyq/2+nLJB@nand.local>
Date:   Wed, 15 Dec 2021 14:17:38 -0800
In-Reply-To: <YbpgHBcyq/2+nLJB@nand.local> (Taylor Blau's message of "Wed, 15
        Dec 2021 16:37:32 -0500")
Message-ID: <xmqqv8zp343h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0FB0B7E-5DF4-11EC-9446-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Dec 15, 2021 at 11:46:16AM -0800, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>> > Here is a reroll of my series which fixes a serious problem with MIDX bitmaps by
>> > which they can become corrupt when permuting their pack order.
>>
>> This seems to depend on tb/cruft-packs that is not yet in 'next', so
>> I'll redo this topic branch by forking it at 'master', merging the
>> other topic in, and then queuing these 8 patches.
>
> Hmm. They shouldn't depend on that topic. My local copy depends on
> abe6bb3905 (The first batch to start the current cycle, 2021-11-29), but
> I'm happy to rebase things if basing on abe6bb3905 was a mistake.

Not so fast.  Let me double check.  My attempt to apply on the tip
of 'master' (as of yesterday) did not work and because the only
topic in 'seen' that touched midx.c was that other topic, I tried to
merge it with 'master' before applying the patches on top and it
worked.  If the other topic has no relation to this topic, it would
work as well (but then it does not explain why patches from the list
did not apply for me).
