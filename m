Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FB5D211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 08:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeK3UGN (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 15:06:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56404 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbeK3UGN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 15:06:13 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 14B8F3627C;
        Fri, 30 Nov 2018 03:57:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=CyGv1wcioJfBfyyIeM/wct82IKs=; b=tF0+M2YjZp8n6UoUGNrb
        WY+pyOnEKQbLPubkN/cmtiWJmyFooO1PZCyclMggmKuIyWRB9VMPXNf4Ir2LpAmj
        airR0uf+6/VzpJkqGKAn5bNgcbtERw5rUejTQ8Z+VcTVY9VS9+6DxqKRCMV5J+dX
        OPgwYUImBhbp/Cw5FB4VKHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=Op+KjHDLXwCbYdewAIX885NYO3Npj5k1AxOtJL7+UtLyqE
        uHuuiWDtxBxdUa1kdmJplULxo5VSZnk1vRFqIlWGGc9nbidYYvBuMzTm7aF/XRzA
        2mMmo5KCaO37mg9kbv57wNnWpWRtV99F65Mnpp1sGDFafaBSUB6Tg4nt0tUu8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E7D83627B;
        Fri, 30 Nov 2018 03:57:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2191C3627A;
        Fri, 30 Nov 2018 03:57:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] format-patch: do not let its diff-options affect --range-diff (was Re: [PATCH 2/2] format-patch: allow for independent diff & range-diff options)
References: <xmqqk1l32jo2.fsf@gitster-ct.c.googlers.com>
        <20181128201852.9782-3-avarab@gmail.com>
        <nycvar.QRO.7.76.6.1811291103190.41@tvgsbejvaqbjf.bet>
        <8736rkyy4h.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.1811291307070.41@tvgsbejvaqbjf.bet>
        <871s74yms3.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.1811291641090.41@tvgsbejvaqbjf.bet>
        <87tvjzyiph.fsf@evledraar.gmail.com>
        <xmqq7egvmh54.fsf@gitster-ct.c.googlers.com>
        <xmqqwoovkx5s.fsf_-_@gitster-ct.c.googlers.com>
Date:   Fri, 30 Nov 2018 17:57:32 +0900
Message-ID: <xmqq36rjkkn7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA42237A-F47D-11E8-918B-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> I had to delay -rc2 to see these last minute tweaks come to some
>> reasonable place to stop at, and I do not think we want to delay the
>> final any longer or destablizing it further by piling last minute
>> undercooked changes on top.
>
> So how about doing this on top of 'master' instead?  As this leaks
> *no* information wrt how range-diff machinery should behave from the
> format-patch side by not passing any diffopt, as long as the new
> code I added to show_range_diff() comes up with a reasonable default
> diffopts (for which I really would appreciate extra sets of eyes to
> make sure), this change by definition cannot be wrong (famous last
> words).

As listed in today's "What's cooking" report, I've merged this to
'next' in today's pushout and planning to have it in the -rc2.  I am
not married to this exact implementation, and I'd welcome to have an
even simpler and less disruptive solution if exists, but I am hoping
that this is a good-enough interim measure for the upcoming release,
until we decide what to do with the customizability of range-diff
driven by format-patch.

In addition to this, I am planning the "rebase --stat" and "reflog
that does not say 'rebase -i' but 'rebase'" fixes merged to 'master'
before cutting -rc2.

