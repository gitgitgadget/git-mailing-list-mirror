Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E6301F461
	for <e@80x24.org>; Mon,  1 Jul 2019 18:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfGASvD (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 14:51:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54603 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGASvD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 14:51:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 734BF6EED7;
        Mon,  1 Jul 2019 14:51:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3G1sxCHR2THVJvDA9g1C/tTK5O0=; b=gyzXOn
        GcVhrsuprX9ZvI3oeSw1xltEsN3hQ04Vtj7wY6YwhHwij2jLAbfm/pFCzr5RScoW
        b0ShNibigP4+mvz6q8pNWQi9mana44RDiGlD/9e9zdlv7AB05V25EQIr3Bzg+KJ3
        K21c1gjFTXzlYoO42GyNFqqrvQ7dIdSW4t7NQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FUNnNbH1hKjFzf4iGIii13QhF5lwqGf4
        ooppg77ffm/t+8kuwymyKtziSM18R1VcvQSoUAGqAcb5UlbnTKJHU5yox7MC5tXs
        Ir1A6aNMYd9TqUmBeqLylz/LozxnGmPqCm8oUj15SmkZNA4KSzOdqOS19oRcBTXm
        qON2+GnwMbw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C8C46EED6;
        Mon,  1 Jul 2019 14:51:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 922A26EED1;
        Mon,  1 Jul 2019 14:50:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
Subject: Re: [RFC/PATCH 1/2] rebuash - squash/rebase in a single step
References: <20190630051816.8814-1-eantoranz@gmail.com>
        <20190630065358.GB31264@sigill.intra.peff.net>
        <CAOc6etYMzOpEDs1GpLChAEhp2SbZcKjO82S=qm4P-t6SkUEWcw@mail.gmail.com>
        <20190630223951.GB21696@sigill.intra.peff.net>
        <CAOc6etZxHWQ24TNsYDf74zgn-VJzbwDsxWxO4-tMkvv92KRKkw@mail.gmail.com>
Date:   Mon, 01 Jul 2019 11:50:55 -0700
In-Reply-To: <CAOc6etZxHWQ24TNsYDf74zgn-VJzbwDsxWxO4-tMkvv92KRKkw@mail.gmail.com>
        (Edmundo Carmona Antoranz's message of "Sun, 30 Jun 2019 19:37:07
        -0600")
Message-ID: <xmqqy31h612o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A28962C-9C31-11E9-A628-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> Hmm... I as a gatekeeper would rather get either a straight line of
> revisions for a feature with no merges (even if a final merge takes
> care of solving conflicts with the upstream branch) or a single
> revision (if I thought that the change is not worth having more than a
> single revision). I'd ask the developer to rebase the whole thing and
> give a straight line (with rebase -i or cherry-picks) or to give me a
> single revision (where rebuash would come into the picture).

That part is understandable, but is "rebase-and-squash" a tool
intended to be used by the contributor to respond to that request?

Wouldn't the developer just do

	git checkout topic
	git fetch
	git rebase [-i] [@{upstream}]
	git push [publish +topic]

to update the topic and ask to be pulled again?  The two steps in
the middle may be "pull --rebase", but my point is I do not quite
see where the new squash/rebase-in-a-single-step thing comes into
this picture.  There may be a different picture that it fits, but
I do not think it is this one.





