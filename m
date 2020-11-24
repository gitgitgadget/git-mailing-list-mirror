Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5288CC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 23:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C73E020872
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 23:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uAQrCgkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732561AbgKXXOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 18:14:49 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56319 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732462AbgKXXOs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 18:14:48 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4BA8B9CFC1;
        Tue, 24 Nov 2020 18:14:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zjrbh8UGqiMIza4+cCWKYeIiJzQ=; b=uAQrCg
        kQdRldPJDda64XXQtpZwAkfO0SjdLbCZ6YC250ILTTuVrYNnd25+xdi0uEuzM6q5
        29CYR8esI1Ju87IP8sUwInzFuf1WFYlTg6vDukAAlLAwi2CLrJbNcXGAcKA2eema
        T0KtxvLHmkWgA9EjGmSzc3UmFIcqXKg0KYoFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dZlI2gIfcoBXj0+0TE1TFSD6OZfvMYAl
        ymspXDuOm1fYPMusbIR8z+yLYxHj2Jyk/ARdlAAPjLbnoUiTx1HbV+gsdodpswxr
        h2dGj2O3IwKs6yAM9xFl/XjLCBV8M2v4w0E4OtS6wtFd9FlRf1wvIRc//37w6ItY
        fFk/ZG20aWo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 441409CFC0;
        Tue, 24 Nov 2020 18:14:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD06E9CFBF;
        Tue, 24 Nov 2020 18:14:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>, Git <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>
Subject: Re: [PATCH] refspec: make @ a valid refspec
References: <20201122164641.2091160-1-felipe.contreras@gmail.com>
        <X7y5Wxu1eY4k6753@coredump.intra.peff.net>
        <xmqqlfeqjzi1.fsf@gitster.c.googlers.com>
        <CAMP44s0PwJ8qEuCCpavshpm0GqV8p37rF8McR2=gdCk2kj+JiQ@mail.gmail.com>
        <xmqqo8jmgyrd.fsf@gitster.c.googlers.com>
        <CA+P7+xr8_s0Fq_TGjDjHEPpGJ8Br5x7omY1fsg0HjcXjutyRkg@mail.gmail.com>
Date:   Tue, 24 Nov 2020 15:14:45 -0800
In-Reply-To: <CA+P7+xr8_s0Fq_TGjDjHEPpGJ8Br5x7omY1fsg0HjcXjutyRkg@mail.gmail.com>
        (Jacob Keller's message of "Tue, 24 Nov 2020 14:52:19 -0800")
Message-ID: <xmqqk0uagxei.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7649C48-2EAA-11EB-BBD0-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

>> Worse yet, @{4} does not refer to HEAD@{4} but refers to the 4-th
>> previous commit the current branch pointed at, so a mnemonic for the
>> end user to remember the distinction between the two is that a bare
>> "@" is different from HEAD, which is a total opposite X-<.
>>
>
> However, @{0} *does* refer to what is currently checked out, which
> would be head.. So in a sense @ meaning "the current branch" and
> applying @{0} would always be HEAD, no?

Not really.  

It happens to hold true for @{0}, because by definition you couldn't
have been on a different branch than the current one when you made
the topmost commit on the current branch.  For @{1} and higher, it
is always "where was the current branch at N commits ago?" which is
different from "where was the HEAD at N commits ago?", unless you
always use a single branch and never switch away.

