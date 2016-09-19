Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FD122070F
	for <e@80x24.org>; Mon, 19 Sep 2016 21:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932484AbcISVBm (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 17:01:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62964 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932163AbcISVBk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 17:01:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A11640722;
        Mon, 19 Sep 2016 17:01:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=URTYeksC5I+QY5v+vyZ7zLuACUc=; b=QY9jfr
        JVG88pYyYsJxq8FMhz9uJ5QlEIOHj0aKs4kNgztIknqn0yw3vB3aB5GMDdBVSKvf
        Tp2Dknv7C/VfPT5yfiObDvqMccDOcGRZkvziwim6QPwTTP4GRneslQxqQrKyN3xW
        yUFfXI2u12asFmYnFaTCrbFFBkSmJyK2I/7rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OPat3FsvE0EBKYXOcjshz9RivuY+EmCi
        aJY1hXuyS4OdeuBxBGQa+U5k0rWZrxUX+Qkb/qaLlpYpGzIlHtAK9Prva9wiEiQX
        SZjW5uFnLB+qZFzIdxus000dYqZSx1rmwdu7NYmGqXHDHY1HEyhZjWTf2tujUJ63
        Hmed8qDIYPw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EE23840720;
        Mon, 19 Sep 2016 17:01:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 925574071A;
        Mon, 19 Sep 2016 17:01:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Michael J Gruber" <git@drmicha.warpmail.net>,
        "Git List" <git@vger.kernel.org>
Subject: Re: clarification of `rev-list --no-walk ^<rev>`?
References: <2AD952BD65034D25BF26C7F138D24F25@PhilipOakley>
        <3b06b9ee-3975-acf1-41d8-02b774a2dd3c@drmicha.warpmail.net>
        <xmqq8tunhns4.fsf@gitster.mtv.corp.google.com>
        <989F47918A374EEF8C7FECD3CFC6767E@PhilipOakley>
        <xmqqintrek64.fsf@gitster.mtv.corp.google.com>
        <DDC820F0373F4534B4A9D12E8B7B866B@PhilipOakley>
Date:   Mon, 19 Sep 2016 14:00:45 -0700
In-Reply-To: <DDC820F0373F4534B4A9D12E8B7B866B@PhilipOakley> (Philip Oakley's
        message of "Mon, 19 Sep 2016 21:12:51 +0100")
Message-ID: <xmqqa8f3ehaa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F7EF520-7EAC-11E6-BA94-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

>> The "--no-walk" tells the rev-list machinery "I have only positives;
>> do not traverse from them AT ALL but just use these positives".
>> Only under that condition, the order of the positive ends you list
>> on the command line matters.
>
> What does "--do-walk" do ("Overrides a previous --no-walk"), and when
> would it be applied?

Wouldn't 

    $ git cherry-pick --no-walk --do-walk A

end up walking the history behind A and reproducing the history
since the root commit?

