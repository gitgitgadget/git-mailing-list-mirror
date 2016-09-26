Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8972E1F4F8
	for <e@80x24.org>; Mon, 26 Sep 2016 03:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034686AbcIZDqq (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 23:46:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50120 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S941394AbcIZDqo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 23:46:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 139D6412AE;
        Sun, 25 Sep 2016 23:46:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WQcTovAin32hHEKK/UW2y1Y9SSU=; b=Ynr5RQ
        hSiMpAx9vwRBtyU7K0ohQOPa0LcApnJIL0XQk1CbwZ0uFVyYdISYLoupbiFpl0gX
        QcgUQQ9KVaDhciQRE6bZkOCkY0+pRb1waV0lFyAcXLu/mxMAIP3cs36u1VTPA/9z
        j0ooNejhB5q2fCF9dKZLzPPvGZW1SxKfkLsGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MLzcX5pAqkEOfGWchSPxFOouDPiTBEXk
        yZGUit+34PjsVl9V8yT5BctnwsvJ/NOqCKp9rpmoD4oKtjAo1Uo8RGV8/9fpqRC1
        AizyYbkS5wv58ZTL7qMwy3G/+FwOSUAbN8OoWvQBA6Tpvvja3UIVG52cH/WXsnZt
        fJC8f1R4kno=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B200412AD;
        Sun, 25 Sep 2016 23:46:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8709D412AC;
        Sun, 25 Sep 2016 23:46:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Changing the default for "core.abbrev"?
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
Date:   Sun, 25 Sep 2016 20:46:39 -0700
In-Reply-To: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
        (Linus Torvalds's message of "Sun, 25 Sep 2016 18:39:35 -0700")
Message-ID: <xmqq37knwcf4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D60BF45E-839B-11E6-9040-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I can just keep reminding kernel maintainers and developers to update
> their git config, but maybe it would be a good idea to just admit that
> the defaults picked in 2005 weren't necessarily the best ones
> possible, and those could be bumped up a bit?
>
> I think I mentioned this some time ago, and it's not a huge deal, but
> I thought I'd just mention it again because it came up again today for
> me..

I am not quite sure how good any new default would be, though.  Just
like any timeout is not long enough for somebody, growing projects
will eventually hit whatever abbreviation length they start with.

Even if we bump it to 12 for everybody, majority of projects at
GitHub would probably be just wasting 5 more hexdigits in addition
to whatever they are already wasting.  The kernel folks will keep
having the problem of having harder time looking up objects referred
to by ancient commits no matter what the new default is anyway, and
then they will again regret we didn't bump it to 16 in year 2016 in
several decades; by that time both of us are probably retired so it
may no longer be our problems, though ;-)

I am not opposed to bump the default to 12 or whatever, but I
suspect any lengthening today may need to be accompanied by a tool
support that finds the set of objects that are reachable from a
commit whose names begin with non-unique abbreviations that appear
in the commit log message. Assuming that it is very hard to refer to
future objects in the log message you write today, such a tool may
find a single object that used to be the unique instance of that
abbreviation back then, and with reachability bitmap support, it may
not be too expensive to run.

