Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 348621F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 18:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753376AbcH3S7F (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 14:59:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60775 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751970AbcH3S7E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 14:59:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA544385DC;
        Tue, 30 Aug 2016 14:59:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FDUoyK3RmkS0XeY6xD1h4f3BaL8=; b=iKEKZ9
        Q8iW2zMdmvQ2W0URwrkqEhppLX3FIgh1GMWx6Uu7a+o1hE2qXtOvTP73vQ4YMjSa
        Rx/UCdk9UffUFFq8WoiCAff+mLMruPKFqkPWKHbnEdIvf2ThzUG+wfJsZOIeHEdB
        O7sQhyGEEHsv8DszAgHJ43LWeP9hMUyCQrni4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WETzRVtTg7sqHJHx3TTWLnmKHziVbc3P
        DOxBovLNeDjJY8Gcdrk9G5FJOe58CLycBDae50zGPQhBVzJdVGLiSVUCcb/vwLz4
        8zOfaZOb2B+gzdaYRGutSKrP1+b547iUcQVGoEPtBcpfSG7Le6dsSa0lbSR5bfWr
        x7LaxCGyDaE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2867385DB;
        Tue, 30 Aug 2016 14:59:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3196D385D9;
        Tue, 30 Aug 2016 14:59:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Subject: Re: [PATCH v6 12/13] convert: add filter.<driver>.process option
References: <20160825110752.31581-1-larsxschneider@gmail.com>
        <20160825110752.31581-13-larsxschneider@gmail.com>
        <xmqqzinv6wtg.fsf@gitster.mtv.corp.google.com>
        <7A378528-58DE-4C17-9F00-9708947716DD@gmail.com>
Date:   Tue, 30 Aug 2016 11:59:00 -0700
In-Reply-To: <7A378528-58DE-4C17-9F00-9708947716DD@gmail.com> (Lars
        Schneider's message of "Tue, 30 Aug 2016 18:27:17 +0200")
Message-ID: <xmqqbn0a3wy3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0E6A234-6EE3-11E6-8601-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> This part of the document is well-written to help filter-writers.
>
> Thanks!

Don't thank me; thank yourself and reviewers of the previous rounds.


> The filter can exit right after the "error-all". If the filter does
> not exit then Git will kill the filter. I'll add this to the docs.

OK.

> "abort" could be ambiguous because it could be read as "abort only
> this file". "abort-all" would work, though. Would you prefer to see
> "error" replaced by "abort" and "error-all" by "abort-all"?

No.

I was primarily reacting to "-all" part, so anything that ends with
"-all" is equally ugly from my point of view and not an improvement.

As I said, "error-all" as long as other reviewers are happy with is
OK by me, too.

> A filter that dies during communication or does not adhere to the protocol
> is a faulty filter. Feeding the faulty filter after restart with the same 
> blob would likely cause the same error. 

Why does Git restart it and continue with the rest of the blobs
then?  Is there a reason to believe it may produce correct results
for other blobs if you run it again?

> B) If we communicate "shutdown" to the filter then we need to give the
>    filter some time to perform the exit before the filter is killed on
>    Git exit. I wasn't able to come up with a good answer how long Git 
>    should wait for the exit.

Would that be an issue?  A filter is buggy if told to shutdown,
ignores the request and hangs around forever.  I do not think we
even need to kill it.  It is not Git's problem.

I personally would be reluctant to become a filter process writer if
the system it will be talking to can kill it without giving it a
chance to do a graceful exit, but perhaps that is just me.  I don't
know if closing the pipe going there where you are having Git to
kill the process on the other end is any more involved than what you
have without extra patches.

>>> +Please note that you cannot use an existing `filter.<driver>.clean`
>>> +or `filter.<driver>.smudge` command with `filter.<driver>.process`
>>> +because the former two use a different inter process communication
>>> +protocol than the latter one.
>> 
>> Would it be a useful sample program we can ship in contrib/ if you
>> created a "filter adapter" that reads these two configuration
>> variables and act as a filter.<driver>.process?
>
> You mean a v2 filter that would use v1 filters under the hood?
> If we would drop v1, then this would be useful. Otherwise I don't
> see any need for such a thing.

I meant it as primarily an example people can learn from when they
want to write their own.
