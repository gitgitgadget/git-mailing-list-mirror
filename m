Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 810412021E
	for <e@80x24.org>; Wed,  9 Nov 2016 23:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754259AbcKIXfj (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 18:35:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55277 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752427AbcKIXfi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 18:35:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 094A24DB76;
        Wed,  9 Nov 2016 18:35:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=fvSVkp6gNWJ4IDcYBaVgfhESTjc=; b=XFNLszssNkE7AG7AHrH2
        b5olwl9Zuu16Z/S/f/d7sON3iqEZBZqd/yYIXcOLSeWGWKjxnV6dXzqFYPoDXqRc
        BXpHbOvSh3WF2gvnDe+CQwJ5lqsx4ZWDyE2p+Wp/dRKbw42ohoNPJf7CT9Xpy7cS
        bEaeaYJjWRWo6TMKSGeo3tc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=StfoPYAT9dzGa56vFDFpIzxFohXKhagLe2UMDX2HvfHYbk
        59L9K7Z8fxiRe8EAQ0kQa7I6t5ZzwwWv742+w15VC3WmPBWTh8a9S5DRZn8Iq+kk
        ol03iW1tEuEc+f1LAuAUI7PQpanGDzHQpTemzIX9AKfhLYSd5VJeMqUzEeSsk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0095F4DB75;
        Wed,  9 Nov 2016 18:35:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 551174DB73;
        Wed,  9 Nov 2016 18:35:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: 2.11.0-rc1 will not be tagged for a few days
References: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com>
        <20161108004038.a7gyoe6wpucxjmvz@sigill.intra.peff.net>
        <65a1bb6d-e924-21aa-70d3-303ebdc499f1@kdbg.org>
        <20161108214825.yo37kvoqkeucuqgg@sigill.intra.peff.net>
        <xmqqoa1p9nf0.fsf@gitster.mtv.corp.google.com>
        <20161109165125.t4x2w7u5uxe57xm2@sigill.intra.peff.net>
Date:   Wed, 09 Nov 2016 15:35:35 -0800
Message-ID: <xmqq1syk8bw8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 371396A6-A6D5-11E6-968E-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It's just that I found myself writing up notes like "this should be
> merged", and it occurred to me that I could communicate the same things
> by sending you a proposed history. So I'm curious if you find dissecting
> it via "git log" more or less convenient than a list of notes. :)

Yes, I think this is a very readable form of communication.

What's especially nice in what you did is that comparing outputs of
these two commands

    $ git log --no-merges --oneline master..peff/for-junio/master
    $ git log --no-merges --oneline ^pu master..peff/for-junio/master

clearly shows that you reused what I already had in 'pu' and the
ones missing from 'pu' are the ones I need to check and possibly
may want to sign-off myself.

I also need to note that while this is very handy format for the
recipient, hence a very good way to do "pass the pumpkin" between
maintainers, it is a less "open" way of communication than laying
out everything on the list (cf. http://youtu.be/L8OOzaqS37s), but
it is the most appropriate method in this case, I would think.

> It looks like Johannes prefers replacements for some of the fixes from
> yesterday.

As to that change, I agree with you that I do not care too deeply
about the shape of an interim step as long as the finished product
uses the better one between the alternatives, but at the same time,
because we are including it as a hot-fix in a released product, even
though it is an interim step in the bigger picture, I want it to be
using the better one, too.  So I am leaning towards taking what you
queued for me for the reasons you stated in the other thread [*1*].

That would probably mean Dscho needs a bit of rebase in the
remaining parts of his series that adds new elements to the enum,
but I am hoping that he can afford that time now in the feature
freeze period.  If we take the _INVALID thing instead now, the
remaining series from Dscho that we would review and queue for the
next cycle would need to begin with a "fixup" patch that stops doing
the _INVALID thing and instead using the "compare after casting to
size_t", so it is just the matter of doing the adjustment before or
after the remainder of the series are posted on the list for the
next release, and the smaller number of "oops that was not nice,
let's fix it" patches in the published history, the better the long
term health of the project, I would think.

The other fixes in your collection looked all sensible.  Thanks.


[Footnote]

*1* The convention of keeping _INVALID at the end can be arguably
    made safe from future programmer screw-ups, as long as it is
    guarded by a good comment nearby.  But the solution to cast
    would avoid having to have that potential brittleness in the
    first place.  I find the other merit of taking care of negative
    enum automatically quite attractive, too.
