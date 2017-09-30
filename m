Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 041CB20281
	for <e@80x24.org>; Sat, 30 Sep 2017 00:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbdI3AH6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 20:07:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60834 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752505AbdI3AH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 20:07:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A9D3A8CC5;
        Fri, 29 Sep 2017 20:07:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eHUc2iDz67UhpyH8cJSj22jVDmQ=; b=Rsol28
        24rHfuyuj5ecV3dTdfcmNolLDGg5epgAc4MbVeCZUX8+QbTzZuq3Dw+CpxiKB3tw
        XLWJtKXiiR3rkjhL4KZtmXsA0XYrH7WTV2U6M9ZeLJsUBkwFbFvFGyV6+PAvWBk9
        OM53f3f5GVyxTGliuuxkqO1VCULZlH1amGnY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xLUpPYXOWfZVjGfAKj3in0+nuiyN1I0s
        SK5+FeKxFbYf6C2fYkKiNYQlmUoza8ceDZwI5E9Cb1LBoAdUMjOb2OUTpVoBsCPU
        DltatPlC/zm0HG0KbbI2gADX1Tdrx694OJbsWcXG6dfNyeEE5ecWF+lHpCJkiKVE
        WdYpMQ30V9o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3239FA8CC4;
        Fri, 29 Sep 2017 20:07:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A587AA8CC3;
        Fri, 29 Sep 2017 20:07:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH Outreachy] mru: use double-linked list from list.h
References: <CAP8UFD24A8rxMfLMFmSStWnBMMeB58SqUdNoo3niQuc7LqRMMg@mail.gmail.com>
        <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
        <20170928224244.pi34zwifnornssqk@sigill.intra.peff.net>
        <CAP8UFD13obkLWyuCGUpFxryr8DWfQ8W4JNn04ajO50PvF0SnXQ@mail.gmail.com>
        <20170929072354.fw4eclt56dmfj4a5@sigill.intra.peff.net>
        <CAP8UFD1-9dYSX-VKZSPN9Ei75V8mGC-wusieL45ArxxJ08tO9Q@mail.gmail.com>
        <CAL21BmkcVSEhEK+tAE-RNVabb0pnokYwbagueUrp9giZ3zqT8A@mail.gmail.com>
        <20170929233723.c7ixg5fb3flbgaom@sigill.intra.peff.net>
Date:   Sat, 30 Sep 2017 09:07:53 +0900
In-Reply-To: <20170929233723.c7ixg5fb3flbgaom@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 29 Sep 2017 19:37:23 -0400")
Message-ID: <xmqq7ewhvyjq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 683FFB3C-A573-11E7-85C9-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yes, I think we could just call this "list_move_to_front()" or
> something. The fact that it's operating on a list called
> "packed_git_mru" is probably sufficient to make it clear that the
> purpose is managing recentness.

I earlier said I wasn't sure, but I fully agree with your envisioned
endgame state, my understanding of which is that we will not have an
API that is only to be used to manage a MRU list (hence there will
be no mru.[ch] in that future), as there is very small MRU-specific
operation to be offered anyway.  Namely, mru_mark() that is to be
used to "mark the fact that the item was used---do whatever necessary
to maintain the MRU list".

Instead, everybody understands how the list API works, and the fact
that one instance of list_head is called MRU is sufficient to see
that use of "move this to the front of the list" function means we
are marking the item as most-recently-used.

Thanks.
