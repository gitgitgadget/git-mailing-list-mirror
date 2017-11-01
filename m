Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 750F920450
	for <e@80x24.org>; Wed,  1 Nov 2017 05:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750990AbdKAE6O (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 00:58:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57897 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750716AbdKAE6O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 00:58:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AF42BB4F8;
        Wed,  1 Nov 2017 00:58:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VR66hMw15lkgEBE0YaUS2ZAaj1c=; b=Fy148c
        7KM7wrg4wMM674GScDBNFx74ynvDGsCPO/1eKU16qOcks3Ere6DJuhWV0vTu6l2/
        2crp+zfz4yp0YzzGwX7jzjKRp8uDC9BgIuH/eMw6G0Q6Fp9LoOvFXZ7ikbLhzSDf
        b+5EFiYTUbtZK4UQ6moCX/gssR0jfO4aX3pho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wMIJ7T2cWxUd1Qqw7JgCC/tReOYD1iqx
        5R2iAGBS3DXFhfKKNRAzSwO78iVwaM7hNKPM/i185zZkRUrW7wevmc3R3oHe66/K
        1tGosvpCF/KmmQz/1BZKg09Zd5p6VX22vQ4Qk/9fRsZb78iPiRF9O97btnapOPeA
        XCEXlFsJFv4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63D94BB4F7;
        Wed,  1 Nov 2017 00:58:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D39B6BB4F6;
        Wed,  1 Nov 2017 00:58:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] mingw: document the experimental standard handle redirection
References: <cover.1509382976.git.johannes.schindelin@gmx.de>
        <436f0fb010709fe0d90460dc7bc1b3482237b192.1509382976.git.johannes.schindelin@gmx.de>
        <CAPig+cQs+6xCn=OR_Mw8vbEwEJ0c=sqnaEChOxuVw=kV4PQwsw@mail.gmail.com>
        <alpine.DEB.2.21.1.1710311807420.6482@virtualbox>
Date:   Wed, 01 Nov 2017 13:58:11 +0900
In-Reply-To: <alpine.DEB.2.21.1.1710311807420.6482@virtualbox> (Johannes
        Schindelin's message of "Tue, 31 Oct 2017 18:08:57 +0100 (CET)")
Message-ID: <xmqq4lqevbmk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4384A448-BEC1-11E7-9001-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +Two special values are supported: `off` will simply close the
>> > +corresponding standard handle, and if `GIT_REDIRECT_STDERR` is
>> > +`2>&1`, standard error will be redirected to the same handle as
>> > +standard output.
>> 
>> Consistent with the Unixy special-case for '2>&1', I wonder if the
>> 'off' case would be more intuitively stated as '>/dev/null' or just
>> '/dev/null'...
>
> I feel this is the wrong way round. `>/dev/null` may sound very intuitive
> to you, but this feature is Windows only. Guess three times how intuitive
> it sounds to Windows developers to write `>/dev/null` if you want to
> suppress output...

It would be just as intuitive to write '2>&1' for dup-redirection,
so I tend to agree with both of you in that perhaps '2>&1' may have
to become less Unix-y (or more Windows-y) to make these special
cases more consistent.  Perhaps "dup-to-stdout" or even just "stdout".

	Side note: if we really wanted to go in the other direction
	Eric suggests, "off" probably should be spelled as ">&-" ;-)

By the way, the description talks about "special values", but it
leaves it completely unclear what their normal values mean.  Are
they filenames, or integers that denote file descriptors, or
something else?  To those who read, wrote, or reviewed the code in
these patches, the answer is obvious (and I do *not* want you to
give your answer to *me* in your response for that reason).  But
we'd want to give the answer to future readers by clarifying this
documentation.
