Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A87C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 16:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E788D2522E
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 16:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EMcB084R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbgJMQAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 12:00:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56225 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731302AbgJMQAO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 12:00:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22393945AC;
        Tue, 13 Oct 2020 12:00:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LmEiHl1Ne/VQuYXez2dCK+QC/7U=; b=EMcB08
        4Rq9z/2h0Uic+swvZryyks70tES7JlWJhc54gicx55AVluy0CFtEuJTOkTYJw+9T
        W7F9vcHhjaMAcApnTBIIJnxR8eXsIOdG7B8K2DYYfl3TWs9Z3WIDiNqiD/MbQ2Y0
        iJaEBGY1EE3UArepH5n7hACK40Oshbtkprplw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jGAPCRZk4n+trm0PyepIIrA7220Gm8Cq
        Qm1DC4M2zBrM7RaMsx53HYOCNN4WEADPa/6dUowMw4iBuLNNecT+HbNLaEtZ1caR
        gb6cjqxht1+3rXPOo9gbeE6ob1rPORcjtIUEXC+YT50RBwt7TJvLfCihR0wFUcZg
        +vHoizS1Fkw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CBD4F945A9;
        Tue, 13 Oct 2020 12:00:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E411945A8;
        Tue, 13 Oct 2020 12:00:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] t: add -I<regex> tests
References: <20201001120606.25773-1-michal@isc.org>
        <20201012091751.19594-1-michal@isc.org>
        <20201012091751.19594-4-michal@isc.org>
        <nycvar.QRO.7.76.6.2010121320190.50@tvgsbejvaqbjf.bet>
        <20201013063846.GF3278@larwa.hq.kempniu.pl>
        <nycvar.QRO.7.76.6.2010131337320.50@tvgsbejvaqbjf.bet>
Date:   Tue, 13 Oct 2020 09:00:09 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010131337320.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 13 Oct 2020 14:00:31 +0200 (CEST)")
Message-ID: <xmqqblh6ktfa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C0E6E36-0D6D-11EB-902B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>   - diffstat with -I<regex>,
>
> I am not worried about that, either, as `diffstat` consumes `xdiff`'s
> output, therefore if one consumer works, another consumer will work, too.

Careful.  Such a "we know what happens in the code" transparent-box
testing attitude is laying a minefield for later our selves.

As we learned in a recent bug in sequencer, some corners of
implementation do the same thing in different codepaths as
optimization.  The really bad part of the story is that such an
implementation detail can and will change over time, since that is
the kind of thing we do when optimizing code.

In other words, we only know what happens in the current code.  And
automated tests protect us from the future, when done right.  If
written with too intimate knowledge of how the current code works,
well, what are we really testing?  It's a balancing act and there is
no single "right" answer, but I'd draw the line on a bit more
careful side than you are drawing here.

Thanks.

