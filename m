Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53EB91F453
	for <e@80x24.org>; Wed, 26 Sep 2018 18:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbeI0BMf (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 21:12:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:60514 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726127AbeI0BMf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 21:12:35 -0400
Received: (qmail 19092 invoked by uid 109); 26 Sep 2018 18:58:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Sep 2018 18:58:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21203 invoked by uid 111); 26 Sep 2018 18:57:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 26 Sep 2018 14:57:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Sep 2018 14:58:13 -0400
Date:   Wed, 26 Sep 2018 14:58:13 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 1/8] sha1-array: provide oid_array_filter
Message-ID: <20180926185812.GD30680@sigill.intra.peff.net>
References: <20180921223558.65055-1-sbeller@google.com>
 <20180921223558.65055-2-sbeller@google.com>
 <87h8ihk7sl.fsf@evledraar.gmail.com>
 <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
 <20180926041517.GA2140@sigill.intra.peff.net>
 <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
 <87d0t0jghm.fsf@evledraar.gmail.com>
 <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
 <87a7o4je0t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a7o4je0t.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 08:43:14PM +0200, Ævar Arnfjörð Bjarmason wrote:

> While we're on that subject, I'd much prefer if these technical docs and
> other asciidoc-ish stuff we would be manpages build as part of our
> normal "make doc" target. So e.g. this one would be readable via
> something like "man 3 gitapi-oid-array".

I'm mildly negative on this, just because it introduces extra work on
people writing the documentation. Now it has to follow special
formatting rules, and sometimes the source is uglier (e.g., the horrible
+-continuation in lists). Are authors now responsible for formatting any
changes they make to make sure they look good in asciidoc? Or are people
who care about the formatted output going to come along afterwards and
submit fixup patches? Either way it seems like make-work.

Now I'll admit it seems like make-work to me because I would not plan to
ever look at the formatted output myself. But I guess I don't understand
the audience for this formatted output. These are APIs internal to Git
itself. We would not generally want to install gitapi-oid-array into
/usr/share/man, because only people actually working on Git would be
able to use it. So it sounds like a convenience for a handful of
developers (who like to look at this manpage versus the source). It
doesn't seem like the cost/benefit is there.

And if we were going to generate something external, would it make more
sense to write in a structured format like doxygen? I am not a big fan
of it myself, but at least from there you can generate a more richly
interconnected set of documentation.

-Peff
