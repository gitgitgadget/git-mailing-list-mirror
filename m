Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C7BC433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 027E82080C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zw3IKey0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHLTxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:53:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64253 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLTxp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 15:53:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8171AD3197;
        Wed, 12 Aug 2020 15:53:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4fUZrhK4MSG1Qfofn9a7qQgxpp0=; b=Zw3IKe
        y0KLCJSrx6j+5/ZPiGUscosKD581RM9zAthO1py8GIwW6qHOt2HNczxxWXjOgzb+
        xRHzJ4dtCwdaEacw9Nf+2Tl573TW4FARFdvA7LtFQLQSU1Vtl1tSY6Upr0qsK7BX
        D2zfqIvrgktFGiCIyCSSp2KcovB26RhreFmIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M2NM/XbygnpPRxPxxRAWyBFFb0KmJCzH
        Ov1hbnoAlMCZjjwWTUg1cWbDNxh6PABz/MDyvUnt2pUAIIur9GdcM4zzeKJ3XhpU
        mfRj0DFkS4THdVpG0DcqoCAE9hsuwqoSbFgCewkem6L5m/XvFIsHIsrBA93fskqt
        96ar6jHlTFc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B14AD3196;
        Wed, 12 Aug 2020 15:53:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C624FD3195;
        Wed, 12 Aug 2020 15:53:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #01; Mon, 3)
References: <xmqq8sevt1lf.fsf@gitster.c.googlers.com>
        <20200804185057.GA1400256@coredump.intra.peff.net>
        <xmqqr1sms0f0.fsf@gitster.c.googlers.com>
        <20200804192053.GA1400936@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2008121516560.50@tvgsbejvaqbjf.bet>
        <20200812141958.GA32453@coredump.intra.peff.net>
        <CAKw82xxOZFcsMw47TSrD7-pXpqO7O0_m84o96iH6+ZVeN9j1uw@mail.gmail.com>
        <20200812160653.GA42443@coredump.intra.peff.net>
Date:   Wed, 12 Aug 2020 12:53:39 -0700
In-Reply-To: <20200812160653.GA42443@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 12 Aug 2020 12:06:53 -0400")
Message-ID: <xmqqlfij63p8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85265358-DCD5-11EA-8643-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, I know. My main beef was that because it fails CI, the urgency of
> doing that fix gets pushed onto people working on their individual
> topics (in fact there is nothing for you to fix yet because I haven't
> even sent these topics upstream). I don't know how to solve that without
> stopping its use in the vsbuild CI job, though.

What I am not getting is in what way it blocks you (or others who do
not deeply care about Windows) to leave vsbuild CI job broken.  Do
you have some automation that is gated by all the CI jobs to pass,
or do you just dislike failing CI jobs out of principle?

I pretty much got used to seeing occasional failures and learned to
ignore it (e.g. https://travis-ci.org/github/git/git/jobs/716661598
that ends with

    Makefile:2467: *** unterminated variable reference.  Stop.
    make: *** Waiting for unfinished jobs....

).

