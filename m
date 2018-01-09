Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E491C1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 21:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbeAIVbR (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 16:31:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63684 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeAIVbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 16:31:16 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4AA79C0ABE;
        Tue,  9 Jan 2018 16:31:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M5QDQO3aiNQNNgttTKofwofEKHw=; b=U65DtB
        W6CG8dmMtSkcgJLAqAlRFcI4Q20rtlaCLK/lq5yFzCkkCFwAAHdMfbw2LUT5xWYz
        Uzpgo3C/mxgOGeeieQbODLWhcpXZpNIWZ8i7IzAoxueHPW6zyeA0gO7l1xo1/DG7
        +KgZYbmzRORulkkkePRa0a7s6O43jWYukVD4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=i7SYFanR5+1WUGYA4JEQtmblBBivv2H9
        nxgYawfTfAuLWGm9PjXauueOVJHzo0J7ZudfMwNZPFKvdzzOZtIs6sa0v2PkV+vL
        ELAG6Q8yd2ynetbjFVwXDD4udcHlr4CncoJ5CvAM3VRNz0DOBg3DO2u/kSBohnug
        G1c/8lAx/8k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 426AEC0ABD;
        Tue,  9 Jan 2018 16:31:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A8E47C0ABB;
        Tue,  9 Jan 2018 16:31:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 00/18] Multi-pack index (MIDX)
References: <20180107181459.222909-1-dstolee@microsoft.com>
        <87k1wtb8a4.fsf@evledraar.gmail.com>
        <c08416f1-bbec-2037-34a6-f454d85de439@gmail.com>
        <20180108102029.GA21232@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1801081438470.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <20180109065018.GA32257@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1801091357560.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CAGZ79kYdgD2h7QjjJe0aA4eMATCGkH62XYvziUNvAPsBJDXOCA@mail.gmail.com>
        <xmqqtvvu4wr2.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kajChFqJRxLAaFnUeikW28kJQXLj7JG6G3=Td4u-zxTwg@mail.gmail.com>
Date:   Tue, 09 Jan 2018 13:31:14 -0800
In-Reply-To: <CAGZ79kajChFqJRxLAaFnUeikW28kJQXLj7JG6G3=Td4u-zxTwg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 9 Jan 2018 12:16:41 -0800")
Message-ID: <xmqq373e4t3x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C30A8D4-F584-11E7-B1E2-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Johannes wrote:
>> I think a better alternative would be to introduce a new abbreviation mode
>> that is *intended* to stop caring about unique abbreviations.
>>
>> In web interfaces, for example, it makes tons of sense to show, say, 8
>> digits in link texts and have the full name in the actual link URL.
>
> And that is what (b) would solve, as it is shorter than the full hash and
> yet exact.

I still do not get it, even though I fully agree that in Web UI what
Dscho envisions makes tons of sense.  Use some short handle that
does not need to be unique inside repository to display, but have a
full information that can be used by machines.  The shortened ones
need to be unique _within_ a given todo list, to be displayed as
text to be "clicked", where the A element's href attribute that
surrounds that "clickable" text has fully unambiguous information.

And that fully unambiguous information, because it is for machine
consumption, can be a full object name without any shortening.

I do not see a need for REBASE_HEAD~$n to make it less robust
(i.e. we now need to worry about making sure it is not lost or moved
while we need it and clean it up when we are done, etc.)
