Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6925D20281
	for <e@80x24.org>; Thu, 21 Sep 2017 02:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbdIUCSa (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 22:18:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52691 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751283AbdIUCS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 22:18:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED61A936FF;
        Wed, 20 Sep 2017 22:18:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j2EH3S1im8wXnGDjNDeaFBM4uOQ=; b=UJprxa
        0FO07myF/gTLEEDFWnhxxlhgdAE5Pe0gtv0etuPMkeSQ7nHXyjpCD/XQL8/+nO6l
        GlXeoO/0/Ha+WM57HHzVsvS7jzM+/VvFSnVPkPwA8eRalhgnSsUGwCAf1fHy4/+e
        Y7A9oPctPSpOqvog72QNc/KfyZH5miIdZYeLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VLA5UQiUVirBD/k2dFzwBbFDnSL6W/mh
        9oXMFM+eeYjB6lWs91GzDPPYYNqjqxz3cWxoRfwza4VFDqQSllcz9WiToRcGt73X
        cLDmp5dEsJC3+1LgoEBr7hR7BC6kBpCp2Xby9cNOTNk4iXtvsxz0StrnbK84Mig9
        RhOiizLJx1Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E05C0936FE;
        Wed, 20 Sep 2017 22:18:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 356B1936FB;
        Wed, 20 Sep 2017 22:18:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>, David.Turner@twosigma.com,
        avarab@gmail.com, christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: Re: [PATCH v7 03/12] update-index: add a new --force-write-index option
References: <20170915192043.4516-1-benpeart@microsoft.com>
        <20170919192744.19224-1-benpeart@microsoft.com>
        <20170919192744.19224-4-benpeart@microsoft.com>
        <xmqq7ewtor9u.fsf@gitster.mtv.corp.google.com>
        <682237f1-4747-5712-e95b-285379eb1b69@gmail.com>
        <xmqq8th8n7rf.fsf@gitster.mtv.corp.google.com>
        <28891f82-32e5-dc46-961c-a44e86e84989@gmail.com>
Date:   Thu, 21 Sep 2017 11:18:26 +0900
In-Reply-To: <28891f82-32e5-dc46-961c-a44e86e84989@gmail.com> (Ben Peart's
        message of "Wed, 20 Sep 2017 22:06:00 -0400")
Message-ID: <xmqqy3p8lrpp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27B9E91C-9E73-11E7-8E75-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> On 9/20/2017 9:46 PM, Junio C Hamano wrote:
>> Ben Peart <peartben@gmail.com> writes:
>>
>>> Lets see how my ascii art skills do at describing this:
>>
>> Your ascii art is fine.  If you said upfront that the capital
>> letters signify points in time, lower letters are file-touching
>> events, and time flows from left to right, it would have been
>> perfect ;-)
>
> Rats, so close and yet... ;-)

Nah, sorry for forgetting to add "... but I could guess that was the
case after reading a few paragraphs, at which point I rewound and
started reading from the beginning, and it was crystal clear."

> Yes, I suppose we _could_ add a 2nd bit (and then add the logic to set
> that bit every time a fsmonitor change was made) but I don't see that
> it really buys us anything useful.  The force write flag in
> update-index is off by default and the only scenario we have that
> someone would set it is for test cases where the perf of writing out
> the index when it is not needed just doesn't matter.

I tend to agree now.  

My reaction primarily came from that I couldn't quite tell what the
IGNORE_* bit was ment to do and assumed that it meant pretty much
the same thing as existing ones like "valid bit is untrustworthy, so
do not pay attention to it".  It turns out that this one has quite a
different meaning, that is not connected to how much we should trust
state maintained by the fsmonitor, which force me off-track.

Thanks.
