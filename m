Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01118C433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 07:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEF6122581
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 07:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbhAYHJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 02:09:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50202 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbhAYHBT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 02:01:19 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 876CCAB1D3;
        Mon, 25 Jan 2021 02:00:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=jqav967zkLfAXmsLV6L19rt7BJw=; b=l3qGQsXYEfRdbGyXFdXw
        PjfwbCkw7J+gIrYd1afcD5hc2EkniUtVfOdcsjYV1qMrrV5ddGNtnl7duGDBZlQI
        E9juN42X1WwvtpsePhS1Ud4DTcdpocmdABQFmx+Rd6JArCT3++7e0Cakqe5RmBCI
        2BeX0rZEF/5CWHdtQP1e6L8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=gF8ngzQ2tND82QPaQEVkcGTsORFBaEwBRCVyEmSG+sn93l
        RP4VJRB/whv9vfspgS4BiK6F1rpCXdqwSSiXSwHJII8IfXJemdFRnrDmfncnv/GF
        hdAxgQYBzr/IJxBRB12NVqNCkGvGkOzrRW3DpUO0Dg88J5tjbxqa+KEmsxAKQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F803AB1D2;
        Mon, 25 Jan 2021 02:00:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F31B9AB1D1;
        Mon, 25 Jan 2021 02:00:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jason Pyeron" <jpyeron@pdinc.us>
Cc:     <git@vger.kernel.org>,
        "'Philippe Blain'" <levraiphilippeblain@gmail.com>,
        "'Kyle Marek'" <kmarek@pdinc.us>
Subject: Re: [PATCH 1/2] revision: Denote root commits with '#'
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>
        <20210117110337.429994-1-kmarek@pdinc.us>
        <20210117110337.429994-2-kmarek@pdinc.us>
        <xmqq7dobmfrq.fsf@gitster.c.googlers.com>
        <e0264a29-2112-f8c8-f066-2be445654d8e@pdinc.us>
        <xmqqwnwajbuj.fsf@gitster.c.googlers.com>
        <xmqqr1mij88k.fsf@gitster.c.googlers.com>
        <237aeef3-239f-bff4-fa17-5581092c8f51@pdinc.us>
        <xmqq1reginnq.fsf@gitster.c.googlers.com>
        <460257a2-478a-eb4c-f6fa-b1cc55384cd5@pdinc.us>
        <xmqqo8hkgl4h.fsf@gitster.c.googlers.com>
        <01fd01d6ef3e$92e43b10$b8acb130$@pdinc.us>
        <xmqq35yvff98.fsf@gitster.c.googlers.com>
        <009a01d6ef80$326572d0$97305870$@pdinc.us>
        <xmqqh7n74jdt.fsf@gitster.c.googlers.com>
        <057b01d6f1db$c46d7d50$4d4877f0$@pdinc.us>
        <xmqq7do32p6q.fsf@gitster.c.googlers.com>
        <00a801d6f1e4$2b693140$823b93c0$@pdinc.us>
Date:   Sun, 24 Jan 2021 23:00:20 -0800
Message-ID: <xmqqblddzekb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD4806B0-5EDA-11EB-B959-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jason Pyeron" <jpyeron@pdinc.us> writes:

>> It seems to me that Solution #2 is a special case of Solution #3 ;-)
>> They are both direct answers to the "graph drawn incorrectly can
>> imply ancestry that does not exist" problem.
>> 
>> Adding the "--decorate-roots" option that annotates the root commits
>> in the "git log" output can still be done, but that is an orthogonal
>> issue.  It does solve, together with any one of three options you
>> presented, the issue Kyle brought up, I would think.
>
> Yes, adding --decorate-roots to add more wide descriptive text
> before the message would do it, but it is the worst solution #4.

I said that "--decorate-roots" is a solution to an orthogonal issue.

Let's recall the C..Z example that shows A (non-root) and X (root)
in several messages back.  Either can be drawn with unrelated commit
immediately below them, depending on the topology of other commits
(imagine there is another commit M that is not related to any of the
commits connected to A or Z, and it is given to "git log C..Z M"; if
we draw C..Z part first and then draw O after it, M would most
likely come immediately after X.

(history: time flows left to right)

          C
         /
        O---A---B
                 \
          X---Y---Z

        M

(log --graph output: time flows bottom to top)

    *   0fbb0dc (HEAD -> z) Z
    |\
    | * 11be529 (master) B
    | * 8dd1b85 A
    * 851a915 Y
    * 27d3ed0 [root] X
    * 1111111 M

Now, the earlier C..Z example I happened to draw B and A first
before drawing Y and X, but if we swap the merge order of Z, it is
likely that the graph output would draw Y and X and then B and A.
"git log C..Z M" in such a history would likely to show M directly
below A (non-root).

    *   0fbb0dc (HEAD -> z) Z
    |\
    | * 851a915 Y
    | * 27d3ed0 [root] X
    * 11be529 (master) B
    * 8dd1b85 A
    * 1111111 M

In short, the [root] annotation does not, and it is not meant to,
solve the "misleading graph" issue.

It only solves "root is special, with or without --graph" issue
(such an issue may or may not exist).
