Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B7C2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 16:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751543AbcISQF6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 12:05:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61485 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751003AbcISQF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 12:05:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B78DB3FBD5;
        Mon, 19 Sep 2016 12:05:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h889sFJFu3kx0Ug25cvyzMEU+eI=; b=Imd71e
        sBsalPqeoQZjHuwr80CiUrXBY2vtM1mQ64ZeggHo9af3ucMTB9CBvsjQmciVK0tB
        7mtuLVzT+9iJIPvHON834SVczHiFRbiC8DNSUVN7bcwkVy27cZx0bachKzbgJAmT
        1ykIdY0GfAmoYSiFIi8xbZ5wxDhsDN0kuMFiY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tirE3voONzdmXaZ0BXG/IuP3WUBpEWcp
        PCipmDk/TNf/mNQchIHD5mNkSyL5HgxH5xh7RywyhrS1AKKYMGXwwHcRDXjHXK+M
        aywcQHtRB4XZC44m0s656+iDfD5njkDnO/t/4nMoBCkOnuPK/b7xsBNgKoMXfJ8F
        VCICLXeq+lU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF1103FBD4;
        Mon, 19 Sep 2016 12:05:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B4F43FBCF;
        Mon, 19 Sep 2016 12:05:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Jakub =?utf-8?Q?Nar?= =?utf-8?Q?=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 0/8] Better heuristics make prettier diffs
References: <cover.1473068229.git.mhagger@alum.mit.edu>
        <xmqqr38vjns0.fsf@gitster.mtv.corp.google.com>
        <c381d458-4c81-f46c-592a-98957b3a177c@alum.mit.edu>
Date:   Mon, 19 Sep 2016 09:05:54 -0700
In-Reply-To: <c381d458-4c81-f46c-592a-98957b3a177c@alum.mit.edu> (Michael
        Haggerty's message of "Mon, 19 Sep 2016 08:35:38 +0200")
Message-ID: <xmqqd1jzho2l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F292537A-7E82-11E6-BB7F-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 09/08/2016 01:25 AM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>>>   * Add test t4059 as part of this commit, not as part of its
>>>     successor.
>> 
>> Which needs to be moved to somewhere else, as another topics that
>> has already been in 'next' uses t4059.
>> 
>> I'd move it temporarily to t4061 with a separate SQUASH??? at the
>> tip for now, as I am running out of time today.
>
> I didn't realize you were waiting for an ACK. Yes, it's totally OK to
> rename the test.

I actually wasn't asking for an Ack.

As the issue was in the one that is buried a few commits from the
tip, and there is a later one that adds more tests to it, I didn't
find enough energy to rename the new file in a buried commit and
then adjust the patch later updates it, I was hoping that you'd
reroll to save me effort, rather than forcing me to do the rebase
myself ;-).

