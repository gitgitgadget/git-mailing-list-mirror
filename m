Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21B2C4320E
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D842360E77
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbhH3VWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:22:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52527 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhH3VWt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:22:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D78C0138165;
        Mon, 30 Aug 2021 17:21:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yyw8gJIyIydvnQjRYnvGRPrMykw+vMv0sTS0MT
        sUXnY=; b=bGR0CzZ7+JQDzcii2O1w6rtHmFktufAYsTAy/QEM6yvsXcTMaf+gdL
        ViYN2wtyYV6b4TqfmE1tuDg8seNOdzCJzhnhksaVymNbo9YbMuHE10mTZjxSr/Nl
        IMjbmXHujAruT8lGZ5h5do0+REO69vXyrYTqJKdke70bPB6WW2S+I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D0C89138163;
        Mon, 30 Aug 2021 17:21:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 12942138162;
        Mon, 30 Aug 2021 17:21:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stef Bon <stefbon@gmail.com>, Git Users <git@vger.kernel.org>
Subject: Re: Exec upload-pack on remote with what parameters to get direntries.
References: <CANXojcyWnFY60bXG6MDS9WAYkcFQHf+Oef0VREBkvgsuX9e=Kg@mail.gmail.com>
        <YS0tNoAa/0VQe1OW@coredump.intra.peff.net>
        <xmqq35qq4t1x.fsf@gitster.g>
        <YS1DnGTDo5ZG8Iw4@coredump.intra.peff.net>
Date:   Mon, 30 Aug 2021 14:21:50 -0700
In-Reply-To: <YS1DnGTDo5ZG8Iw4@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 30 Aug 2021 16:46:20 -0400")
Message-ID: <xmqq4kb639xt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B34162C-09D8-11EC-89D7-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yes. At GitHub we actually have a custom endpoint which hooks up
> "cat-file --batch" with a format of the client's choosing. That's what
> (indirectly) feeds things like raw.github.com.
>
> I've been tempted to send it upstream, but it's pretty ugly, and does
> give the client a lot of power (for now, the placeholders you can use
> with cat-file are not that powerful, but if we start to unify with
> ref-filter, etc, then we run into situations like we had with
> %(describe) recently). Likewise, the v2 object-info endpoint _could_
> accept arbitrary format strings (it's the same idea, just with
> --batch-check instead of --batch).

Yeah, the object-info actually was from folks who are interested in
doing something similar, and it would be nice if we can share the
protocol endpoint that is more suitable for interactive tree and
history traversal to help those who want to do virtual filesystem.

Thanks.

