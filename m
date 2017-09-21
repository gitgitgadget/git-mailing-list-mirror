Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEE7620281
	for <e@80x24.org>; Thu, 21 Sep 2017 02:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751462AbdIUCce (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 22:32:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62664 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751283AbdIUCcd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 22:32:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C570A72F5;
        Wed, 20 Sep 2017 22:32:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y9oKlrRXdWbswyMuBPfIjyS9pMY=; b=dk16EC
        1qYe4LpjDsxbGS01ZLySOfGsAEmObwTdHjDr1pRNKafvW/ozOCI3G4PX81KiDYZO
        kRZuSfee9pH8i54wz0wKDjH9dlm/eHWvYAkimoNzQl3o9z1LWM/GbfIvItmxS6j6
        9cC9lpr++d/+Tkaa+xpi1DfoA3ALTQGjO9Ze0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C7Ax5F3QnTyHnF7mSgLznq/jy0Sz0xcY
        H6e6p5TJRtFui6kD3omsYdJ+pZxIOSGRvXRSjLo7gr3w/ZckbcGhmFybctjLX8yf
        Gzdz07I83yEWXenMKhB55LxvsZq51CH+J2+uFd6yjTnMn3x2rUOSDpNfL94bhmB7
        CawU9N2+L5U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 40F6BA72F4;
        Wed, 20 Sep 2017 22:32:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7A995A72F2;
        Wed, 20 Sep 2017 22:32:27 -0400 (EDT)
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
        <xmqqy3p8lrpp.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 21 Sep 2017 11:32:25 +0900
In-Reply-To: <xmqqy3p8lrpp.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 21 Sep 2017 11:18:26 +0900")
Message-ID: <xmqqr2v0lr2e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1BFB307A-9E75-11E7-AA78-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ben Peart <peartben@gmail.com> writes:
>
>> On 9/20/2017 9:46 PM, Junio C Hamano wrote:
>>> Ben Peart <peartben@gmail.com> writes:
>>>
>>>> Lets see how my ascii art skills do at describing this:
>>>
>>> Your ascii art is fine.  If you said upfront that the capital
>>> letters signify points in time, lower letters are file-touching
>>> events, and time flows from left to right, it would have been
>>> perfect ;-)
>>
>> Rats, so close and yet... ;-)
>
> Nah, sorry for forgetting to add "... but I could guess that was the
> case after reading a few paragraphs, at which point I rewound and
> started reading from the beginning, and it was crystal clear."
>
>> Yes, I suppose we _could_ add a 2nd bit (and then add the logic to set
>> that bit every time a fsmonitor change was made) but I don't see that
>> it really buys us anything useful.  The force write flag in
>> update-index is off by default and the only scenario we have that
>> someone would set it is for test cases where the perf of writing out
>> the index when it is not needed just doesn't matter.
>
> I tend to agree now.  
>
> My reaction primarily came from ...

oops. please ignore the last paragraph, or transplant it to the
other thread X-<.
