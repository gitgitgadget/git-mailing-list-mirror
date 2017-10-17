Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C07C3202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 01:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753618AbdJQBGc (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 21:06:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63843 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752214AbdJQBGb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 21:06:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D3FBCB61D3;
        Mon, 16 Oct 2017 21:06:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Dl4yNXFEDJpjb6FBKc3gqQ7nv4U=; b=fBRdtx
        T2D1Q7dpdJsc0CPkpX1oODcMHHyGMsIcpTyxlQPnLUvWAtVSuMbiKdI10iWdgs7O
        BVhiRvjtMwWuqoBImezqiV4LPwG9izIVRi4RXkhQVrgILgdTUdzhW1yHwMC7qdae
        4l9GFDt3nqMc5NwJsGEPYPmqZQOqbz1bYdXA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AVR9+S7TqBoj9pdfbQEdCvKbUGh8UZ13
        gNLXlpX/0WTdRUTUbe55fg6HqmsHRMg6GqD+UN2ArgMtFNV64YbNAcAvB2tWvNNQ
        G+RGGab3khl/3WmRdogcabbE9TXKHoQA4dz/yorCbGcfwkODQicSDpxLLf0P/HXo
        CwjAo2J/Rho=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CCFB5B61D1;
        Mon, 16 Oct 2017 21:06:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4DEE6B61D0;
        Mon, 16 Oct 2017 21:06:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] color: downgrade "always" to "auto" only for on-disk configuration
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
        <20171012021007.7441-1-gitster@pobox.com>
        <20171012021007.7441-2-gitster@pobox.com>
        <20171012123153.i265nun6pklw7kjg@sigill.intra.peff.net>
        <xmqqinfjykm2.fsf@gitster.mtv.corp.google.com>
        <20171013014721.d4vesqv4v5j7tmk2@sigill.intra.peff.net>
        <xmqqzi8vvht6.fsf@gitster.mtv.corp.google.com>
        <20171013130638.dgc6kawy5mvrbasz@sigill.intra.peff.net>
        <xmqqshemtoth.fsf@gitster.mtv.corp.google.com>
        <20171016215311.m72jarmqhjagy6o6@sigill.intra.peff.net>
Date:   Tue, 17 Oct 2017 10:06:29 +0900
In-Reply-To: <20171016215311.m72jarmqhjagy6o6@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 16 Oct 2017 17:53:11 -0400")
Message-ID: <xmqqo9p6r3ai.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68C20318-B2D7-11E7-A5D8-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Oct 14, 2017 at 12:01:46PM +0900, Junio C Hamano wrote:
>
>> > That takes us back to the pre-regression state. The ancient bug from
>> > 4c7f1819 still exists, but that would be OK for v2.15. We'd probably
>> > want to bump the -rc cycle a bit to give more confidence that (2) caught
>> > everything.
>> 
>> Yes, I think that is the approach I was pushing initially with the
>> jc/ref-filter-colors-fix topic that was later retracted; the result
>> of your 4-patch series more or less matches that one, modulo that I
>> didn't treat for-each-ref as a plumbing.
>
> Ah, right, I forgot about that one while I was putting it together. So
> many alternatives floating around.
>
>> I do share the worry that
>> it is hard to make sure that these post-revert adjustment caught
>> everything; after all, that was a major part of the reason why my
>> earlier attempt was retracted.  I still think this is the _right_
>> direction to go in, even though it is harder to get right.
>
> To be honest, I'm not actually very worried. I think missing a
> post-revert adjustment is the main risk, but my general sense is that
> there hasn't been a lot going on with color fixes outside of my recent
> work. Famous last words and all that, I'm sure. :)
>
>> True.  Let's see what others think.  I know Jonathan is running
>> the fork at $work with "downgrade always to auto" patches, and while
>> I think both approaches would probably work well in practice, I have
>> preference for this "harder but right" approach, so I'd want to see
>> different views discussed on the list before we decide.
>
> After pondering over it, I have a slight preference for that, too. But
> I'm also happy to hear more input.

OK, so it seems we both have slight preference for the "peel back"
approach.  Adding Jonathan to Cc:
