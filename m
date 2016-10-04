Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B327F20986
	for <e@80x24.org>; Tue,  4 Oct 2016 19:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbcJDTBS (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 15:01:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57014 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751795AbcJDTBR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 15:01:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D05541C2A;
        Tue,  4 Oct 2016 15:01:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IU0LM2P2n/OEyR0vaXKf2vwIIdU=; b=k/RXwT
        dBrkNA5PaGxwTA2cuS00rLCvae/e+ARo1NQ4GTgWQI/6Rx1kyqb+qWtZ0s6xStQt
        0gHD+6zI9h+B9p8YizP227jjwokcYGlxB6WYzutoWxHlVyE1m8CBgefw333YCNY1
        /Ve2cli71Sw60R/+79ttk6/H1ay76JCjrCKvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lM3lCf8F5lLeuzxnC6W+3e4jW2O8CsOR
        +xYNP6SjSyn3I607jjcBwxqJYzVkODi0Pi7Y7j1DTSz9sq4YazICYDRGBP9rWUWP
        1VPtYKZfrXKHWVOoHUnMwKp4Y1W2M5MgoUTuQ2xW4c7rz9X+Q2bjpEYhqj6hjiAD
        69x3n8gS6UI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53EDD41C29;
        Tue,  4 Oct 2016 15:01:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC69541C27;
        Tue,  4 Oct 2016 15:01:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Jeremy Morton <admin@game-point.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Reference a submodule branch instead of a commit
References: <57F29FEF.30700@game-point.net>
        <xmqqfuod6yw2.fsf@gitster.mtv.corp.google.com>
        <20161004113625.GB20309@book.hvoigt.net>
        <CAGZ79kZWtAU6YG4Qz9_Gwk2db5L2kPCCKrN+64hMYDovRjiLRw@mail.gmail.com>
        <xmqqshscuilh.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 04 Oct 2016 12:01:13 -0700
In-Reply-To: <xmqqshscuilh.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 04 Oct 2016 10:31:06 -0700")
Message-ID: <xmqqlgy4szuu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECEF9F8E-8A64-11E6-92CA-15497B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> I wonder if we could make that convenient for users by not tracking
>> the submodule,
>> i.e.
>> * we have the information in the .gitmodules file
>> * the path itself is in the .gitignore
>> * no tree entry
>>
>> Then you can update to the remote latest branch, without Git reporting
>> a dirty submodule locally, in fact it reports nothing for the submodule.
>>
>> It sounds like a hack, but maybe it's worth looking into that when
>> people want to see that workflow.
>
> It IS a hack.  
>
> But if you do not touch .git<anything> file and instead say "clone
> this other project at that path yourself" in README, that would
> probably be sufficient.

eh,... hit send too early.

It IS a hack, but having this information in .git<something> would
mean that it can be forced to be in machine readable form, unlike a
mention in README.  I do not know if the .gitmodules/.gitignore
combination is a sensible thing to use, but it does smell like a
potentially useful hack.
