Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD2B1202A0
	for <e@80x24.org>; Tue, 31 Oct 2017 07:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753024AbdJaHUK (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 03:20:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51786 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752992AbdJaHUI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 03:20:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74400AA19A;
        Tue, 31 Oct 2017 03:20:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DjHe4ZtaH+Yi4F+XtaxYlpwQz6c=; b=gIA539
        C4BfVnwqqaLn9gFNnuoR9awm225oSp2w0K+KPnZyCYyUOusyOFM2h5YkAGCZVY/E
        aYpBv8ycul/Hhe4fOo+bHu+durGAnuYejcy92ZTuWupnbHpvgMpT6N4vmpASGH7V
        vb8ZWfwa2l/q56HXZ++BmlwUNxkxuL0qUNte8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IjvGVHTCV+txZs54h0SnIjeubI8vF00x
        U2LpgMv9TNJixm/mJI9HFH4TnNBHAL4B7A5cjTB/hFFgvGggLuy4vF+ifq+UDevV
        o5uFyLTuxwlTz0q2j6Eg3F9GzbH0L+sIHV/GxtkSLpowrHT1wNm8Mgaf/uC/SLan
        0r9ANnerfo8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BC0CAA199;
        Tue, 31 Oct 2017 03:20:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D4D46AA198;
        Tue, 31 Oct 2017 03:20:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrey Okoshkin <a.okoshkin@samsung.com>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        vmiklos@frugalware.org
Subject: Re: [PATCH v4] merge-recursive: check GIT_MERGE_VERBOSITY only once
References: <CGME20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5@epcas2p4.samsung.com>
        <3aed764b-388c-d163-08fc-32b294c6b9d3@samsung.com>
        <CAGZ79kaSZG9WriqX0SLbTnEDRr-4YdFRuK17+9wnxyrftfnMmg@mail.gmail.com>
        <CAPig+cRTL2amjsgdp1=T3GMZLa=favugOfnQw9XjWzC+U=v5Sw@mail.gmail.com>
        <CAN0heSp7b_6n3y=s4++oWhkPUuM=s9L7LWVx5vn8o=5aH6DKKw@mail.gmail.com>
        <20171024195221.gqgtibwjaztgeel6@sigill.intra.peff.net>
        <xmqq8tg0j8vb.fsf@gitster.mtv.corp.google.com>
        <CAPig+cSjQd=p1CdizU5oUaz91z=j02UnWLtTguWzvkjS+v6ETA@mail.gmail.com>
        <20171025072717.7svdq4kqlfxlwszi@sigill.intra.peff.net>
        <38a80069-abdb-0646-a20c-eca39dd4f519@samsung.com>
        <CAPig+cRq1AEOgDoXeH-hDMvhEMnfiNK5CuSBbbio-mbHros=QQ@mail.gmail.com>
        <bd7eb593-75f9-0dd1-9dff-9dc420532217@samsung.com>
        <CAGZ79kZ9EV=qaYyuA3kfuQ04EhLWax52MhtkmGJto2Lommc_SQ@mail.gmail.com>
        <2b507ce0-0d18-d9d6-11ba-6fb0d4f4a473@samsung.com>
        <xmqqd1543xfc.fsf@gitster.mtv.corp.google.com>
        <xmqq37603vek.fsf@gitster.mtv.corp.google.com>
        <ecb12f21-f26f-6905-1fdc-60d7c282cfe3@samsung.com>
Date:   Tue, 31 Oct 2017 16:20:05 +0900
In-Reply-To: <ecb12f21-f26f-6905-1fdc-60d7c282cfe3@samsung.com> (Andrey
        Okoshkin's message of "Tue, 31 Oct 2017 10:13:00 +0300")
Message-ID: <xmqqwp3byeai.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EBE2367A-BE0B-11E7-8BE1-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrey Okoshkin <a.okoshkin@samsung.com> writes:

> I think, the main benefits are:
> * Code is more readable, no duplicated calls with the same constant string
> argument.
> * Code is potentially safer, the second getenv() call may return another
> pointer value which could be NULL (and yes, this is an arguable point as it
> can be done only artificially).
>
>> For the sake of fairness, I would say that the resulting code may be
>> easier to follow and has one less instance of a constant string that
>> the compiler cannot statically check if we made a typo.  That's the
>> only benefit in this patch as far as I can see.
>> 
>> The original makes a call to see if the result is NULL, and then
>> makes the same call, expecting that we get the same result (not just
>> that it is not NULL, but it is the same verbosity request the end
>> user made via the environment as the one we checked earlier), and I
>> can understand that it feels a bit redundant and ugly.
>
> Yes, you absolutely right.

I am absolutely right when I say your "code is potentially safer" is
total BS.  The result from first getenv() call may be pointing at an
invalid piece of memory by the time it is used, if you are in a
situation in which not having the second getenv() matters
(i.e. somebody else is also mucking with getenv() at the same time).

So please update the log message so that the patch is not sold on
that basis.

Thanks.
