Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 589011F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 03:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbeKNNlM (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 08:41:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54258 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeKNNlM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 08:41:12 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F0FC117359;
        Tue, 13 Nov 2018 22:39:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wms9VgjUH+q/
        QVrP01gS0Ah5nKA=; b=uxFdwZwDNGjHZ2sACqWsm/rDrdCQF7xlsFSjAdNpbFAX
        bPKmhEmO6p8NyhOEHRNtPknTL2sFH6Twnk5C1IT4ZVTvFFbqK1Gocl+BzTGwReCN
        7uWdT8J8pcQsmZvujDk7o3JhoAqP4rZlLco9pC/LY0egpdn1xH3Xux7ZAL2J03M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=o13nJw
        sOkbPeskD0xxbkQQmHJ5Ql0VymZb4OksvDHZKVKnzkJONXAojk+ozcSNtO7ea+qD
        QQZ6fcmxNKtDNCx8zCBCnI+TAR4Fq5xOyGGyEfRRV/XXcnVkwlY65vo5FIE6yNXZ
        Q1lrSDqu6QmsdahZS0NrMcqAmLL+erHruh0fc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 253DE117357;
        Tue, 13 Nov 2018 22:39:50 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 99E52117355;
        Tue, 13 Nov 2018 22:39:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Pratik Karki <predatoramigo@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Subject: Re: rebase-in-C stability for 2.20
References: <pull.76.git.gitgitgadget@gmail.com>
        <dc36a450680b1854abbb9bb06180001ce68c3f3b.1542112703.git.gitgitgadget@gmail.com>
        <00d9b0e4-dde5-c96d-76d7-42fb9ac393f8@talktalk.net>
        <nycvar.QRO.7.76.6.1811132019440.39@tvgsbejvaqbjf.bet>
        <1b8461d1-6cb7-6622-94d2-44c27623236d@talktalk.net>
        <87y39w1wc2.fsf@evledraar.gmail.com>
Date:   Wed, 14 Nov 2018 12:39:48 +0900
In-Reply-To: <87y39w1wc2.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 13 Nov 2018 22:50:05 +0100")
Message-ID: <xmqq8t1wqqd7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F05081CA-E7BE-11E8-BD1C-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> According to Junio's calendar we're now 2 days from 2.20-rc0. We have
> the js/rebase-autostash-detach-fix bug I reported sitting in "pu" still=
,
> and then this.
>
> I see we still have rebase.useBuiltin in the code as an escape hatch,
> but it's undocumented.
>
> Given that we're still finding regressions bugs in the rebase-in-C
> version should we be considering reverting 5541bd5b8f ("rebase: default
> to using the builtin rebase", 2018-08-08)?
>
> I love the feature, but fear that the current list of known regressions
> serve as a canary for a larger list which we'd discover if we held off
> for another major release (and would re-enable rebase.useBuiltin=3Dtrue=
 in
> master right after 2.20 is out the door).
>
> But maybe I'm being overly paranoid. What do those more familiar with
> this think?

I was hoping that having it early in GfW 2.19 would have smoked out
all the remaining issues, but it seems that those building from the
source and testing have usage patterns different enough to find more
issues.  This is a normal part of the development process, and
hopefully the remaining bugs are minor and can be flushed out in the
-rc testing period---this kind of thing is the whole reason why we
code-freeze and test rcs.

It unfortunately is too late to depend on the rebase.useBuiltin as
an escape hatch, as 'master', 'next', or anywhere else had the
"rebase and rebase -i in C" series merged without it set to false
and used in any seriousness.  Quite honestly, I think we can trust
the rest of the "rebase and rebase -i in C" series much more than
its "use the scripted one even though we have built-in one" part.

So if we have to seriously consider holding back, we may be better
off ripping the whole thing out.  I do not offhand know how involved
such a reversion would be, though, and I am *NOT* looking forward to
having do such a major surgery right before the release.
