Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85F8320193
	for <e@80x24.org>; Mon, 24 Oct 2016 20:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965067AbcJXUQp (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 16:16:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65345 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752848AbcJXUQo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 16:16:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B92A45947;
        Mon, 24 Oct 2016 16:16:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HdE9vd8d+S4G/LsFOcbOu7fTqiE=; b=YkKweI
        HohRHkNPC4xkCzYZn0L3DufPRF04dPu7oY9LQEqPbqc9NHbJ8475n+FV1ZPfqAln
        Fo+0J+9UE4PFd4qLmjn/ZQ/slJ2pslnNRHO4rQfXc0W60ts4+rnMrA2naG/cPfAT
        nFDnbmVAwV7DoLQc61CQAFJ4yxJ/jaYbf9k28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jLZAPUa1MqQmhyZWYWljGBVZJzY/kgRc
        pp3Agwv5PzLrljewuecBtGs6Juo8IDfKd2AuvC7TXyoCiJlKIEHR63eZmM/3vDDi
        vs12bRjA9e2FMd5mF1+31HnrGTilqnPPiGHIVrhcnpTpFfV6q5fbiwp3d70DDLOK
        HSv82m6Ryzc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72B6F45946;
        Mon, 24 Oct 2016 16:16:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E338345945;
        Mon, 24 Oct 2016 16:16:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 00/27] Prepare the sequencer for the upcoming rebase -i patches
References: <cover.1476450940.git.johannes.schindelin@gmx.de>
        <cover.1477052405.git.johannes.schindelin@gmx.de>
        <xmqqinsk8g1b.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaq85c1Gk1aRSrdQGp1Nm9p6tN0jXbFvTN0v+9ehooxYg@mail.gmail.com>
Date:   Mon, 24 Oct 2016 13:16:41 -0700
In-Reply-To: <CAGZ79kaq85c1Gk1aRSrdQGp1Nm9p6tN0jXbFvTN0v+9ehooxYg@mail.gmail.com>
        (Stefan Beller's message of "Mon, 24 Oct 2016 12:36:50 -0700")
Message-ID: <xmqqpomp33km.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7A1DC70-9A26-11E6-93AE-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> Speaking of what to and not to include in the upcoming release, we
>> do want to include Stefan's off-by-one fix to the submodule-helper,
>> but that is blocked on Windows end due to the test.
>
> I'd be happy either way, i.e. we could revert that fix and make a release?
> AFAICT, Windows only has broken tests, not broken functionality with that
> submodule bug fix.

If you are referring the "trailing /. should not make difference
when resolving ../relative/path" change with "rever that fix", I
think that may be a reasonable way to proceed.  Even though that
change is a bugfix (at least from the point of view by me and j6t in
the recent discussion), it is a behaviour change that we would want
to see feedback from existing submodule users and deserves a longer
gestation period.  And that part is not yet in 'next' yet ;-)

> If we want a longer gestation period, we'd ideally merge it to master
> just after a release, such that we "cook" it in master without having
> it in any release (we had a similar discussion for the diff heuristics IIRC).

Yes.  

It would mean that we would need a separate patch that adds the
!MINGW prerequisite to some tests to what is on 'next', as the early
patches on sb/submodule-ignore-trailing-slash~ that fixes off-by-one
is the right thing to do either way.  It of course needs help from
Windows folks to validate the results.
