Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EF851F731
	for <e@80x24.org>; Wed,  7 Aug 2019 20:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388801AbfHGUh2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 16:37:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64107 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387957AbfHGUh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 16:37:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 971C41715D8;
        Wed,  7 Aug 2019 16:37:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mpnERmS27b9OJncVWcpeSVekFYQ=; b=Zc1wc9
        Ti6l6aMV87LF3ABdWNztv5BS7FjYpxVVxz0KntOf/TLIa3OaZvk4o03DIRjBRXqY
        035jbAnxW35vPtcqhImOPbGJobl+Q6JotbThX36pYeKj9rIiIHjRbM35alvG7mWy
        FLBw7xliNmarQ5PCDd1FuS6dsBySqQH23bX7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=knqLochIrHK/RsJWomhg6SXRCJHsG7Q0
        VJkGjjI39nYGJEiOJfvxRUcyVZ1rkyP2zkDyrmGRO0tbqlR2OycCRuodMVzPXpIJ
        7IxF2bbYLIsac/DiNYIPNIjE1ZmYFFQWCPR6ZaeBb8lTEsjMqnEq6/lZo8Nf+Uvy
        N6VYAevWTLU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8ECF41715D7;
        Wed,  7 Aug 2019 16:37:26 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F385C1715D6;
        Wed,  7 Aug 2019 16:37:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/3] trace2: trim whitespace in start message in perf target format
References: <pull.298.git.gitgitgadget@gmail.com>
        <834ee95cd2fe919c7a5a2d3cc3d647cfdeebe9e6.1564603467.git.gitgitgadget@gmail.com>
        <xmqqef24muxe.fsf@gitster-ct.c.googlers.com>
        <827ed342-1079-8145-ed78-1b955264226e@jeffhostetler.com>
Date:   Wed, 07 Aug 2019 13:37:24 -0700
In-Reply-To: <827ed342-1079-8145-ed78-1b955264226e@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 7 Aug 2019 16:25:24 -0400")
Message-ID: <xmqqef1whfuj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AA0FFB0-B953-11E9-A3F9-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 8/1/2019 5:34 PM, Junio C Hamano wrote:
>> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> Trim leading/trailing whitespace from the command line
>>> printed in the "start" message in the perf target format.
>>>
>>> We use `sq_quote_argv_pretty()` to format the message
>>> and it adds a leading space to the output.  Trim that.
>>
>> strbuf_trim() not just drops a single leading space, but removes
>> consecutive spaces from both ends.  But the first char after the SP
>> comes from the first arg, and it can never be a whitespace (as a
>> payload that begins with a whitespace will be quoted, so it will be
>> a single quote), and the last char in the buffer would also be
>> either a closing single quote (if the last argument ends with a
>> whitespace) or a non whitespace "safe" character, so it is safe to
>> use strbuf_trim() here.
>>
>> I wonder if we want to lose the prepending of SP from
>> sq_quote_argv_pretty(), though:
>
> I was wondering about that too, but I didn't want to presume
> to know what all of the callers wanted.  And didn't want to
> slip in such a change last-minute.

I do not think this topic/discussion is a place to do so, either.
And compensating on the caller's side, like your patch did, is
perfectly fine.

I was more disturbed by potential double quoting in some codepaths
when I did a cursory audit of users of sq_quote_argv_pretty(), and
would think that would be of more importance, though.
