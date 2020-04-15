Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9759DC2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 14:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B0AB2076D
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 14:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZEj32eC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371009AbgDOOv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:51:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57598 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370969AbgDOOvW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 10:51:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E402A4901B;
        Wed, 15 Apr 2020 10:51:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yLw4RlNlgPk4zrTYBS+JegXDjxU=; b=ZEj32e
        C168/6hLNKA793oqQKRCzImMPuwDiDsfa+nrBRVc2SQIAlpowaY9HqTutLNOvFlF
        oXKuNGhNP10EiFdIMIwp/qtuFwmy+qw8tkyLqF2Kohd4fQhqFvur51Umdw6MkcT7
        fYsaOxu9Q3Cu6K3xdWm2Ay4vJRT5kV4jUyMXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HadCj2fNCaRpnoBOsMCN+TZiRXL/aNuW
        qTnOwAmjNn5XJ8zyGf4S+aHoCWLX8VugYkWBKCG8+dIZIreCO2BG5J5GQJ92rFaJ
        Q4vpi2l/qNGmI2MKGheuXgMJWrtGIYXmUvI9YY6iqGfb5OvOOg9+wRS0ggi2OpeW
        1frSzwZaQyI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA54249019;
        Wed, 15 Apr 2020 10:51:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66E5049017;
        Wed, 15 Apr 2020 10:51:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        James Ramsay <james@jramsay.com.au>
Subject: Re: [RFC PATCH v2 0/2] configuration-based hook management
References: <20191210023335.49987-1-emilyshaffer@google.com>
        <20200414005457.3505-1-emilyshaffer@google.com>
        <efad3927-1d8f-5545-48e9-9a58c2308273@gmail.com>
        <20200414203247.GE1879688@coredump.intra.peff.net>
        <0f661f31-ee75-15fb-0272-48d459176f29@gmail.com>
Date:   Wed, 15 Apr 2020 07:51:14 -0700
In-Reply-To: <0f661f31-ee75-15fb-0272-48d459176f29@gmail.com> (Phillip Wood's
        message of "Wed, 15 Apr 2020 11:01:15 +0100")
Message-ID: <xmqqd088950d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E7FE064-7F28-11EA-95D8-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> If you want to refer to commands in ordering options (like your
>> "before"), then you'd have to refer to their names. For "my-command"
>> that's not too bad. For the longer one, it's a bit awkward. You _could_
>> do:
>> 
>>   hookcmd.my-command.before = git diff --check --cached
>> 
>> which is the same number of lines as yours. But I'd probably give it a
>> name, like:
>> 
>>   hookcmd.check-whitespace.command = git diff --check --cached
>>   hookcmd.my-command.before = check-whitespace
>> 
>> That's one more line than yours, but I think it separates the concerns
>> more clearly. And it extends naturally to more options specific to
>> check-whitespace.
>
> I agree that using a name rather than the command line makes things
> clearer here

True.   

These ways call for a different attitude to deal with errors
compared to the approach to order them with numbers, though.  

If your approach is to order by number attached to each hook, only
possible errors you'd need to worry about are (1) what to do when
the user forgets to give a number to a hook and (2) what to do when
the user gives the same number by accident to multiple hooks, and
both can even be made non-errors by declaring that an unnumbered
hook has a default number, and that two hooks with the same number
execute in an unspecified and unstable order.

On the other hand, the approach to specify relative ordering among
hooks can break more easily.  E.g. when a hook that used to be
before "my-command" got removed.  It is harder to find a "sensible"
default behaviour for such situations.

I am perfectly fine with having more possible error cases than
allowing misconfigured system to silently do a wrong thing, so...



