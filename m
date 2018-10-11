Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B589D1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 00:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeJKHnt (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 03:43:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:36416 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727419AbeJKHnr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 03:43:47 -0400
Received: (qmail 16888 invoked by uid 109); 11 Oct 2018 00:19:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Oct 2018 00:19:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24153 invoked by uid 111); 11 Oct 2018 00:18:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Oct 2018 20:18:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Oct 2018 20:19:11 -0400
Date:   Wed, 10 Oct 2018 20:19:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] push: add an advice on unqualified <dst> push
Message-ID: <20181011001910.GC13853@sigill.intra.peff.net>
References: <20181010104145.25610-1-avarab@gmail.com>
 <20181010104145.25610-3-avarab@gmail.com>
 <20181010205505.GB12949@sigill.intra.peff.net>
 <xmqqbm81lb7c.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbm81lb7c.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 06:54:15AM +0900, Junio C Hamano wrote:

> > I'm not sure about saying "branch or tag" in the first bullet. It's
> > friendlier to most users, but less technically correct (if you said
> > "notes/foo", I believe we'd match an existing "refs/notes/foo", because
> > it's really just using the normal lookup rules).
> 
> An alternative may be "looking for a ref that matches %s on the
> remote side".  I am no longer a total newbie, so I cannot tell how
> well that message would help one to connect notes/foo one just typed
> with refs/notes/foo that potentially exists on the remote side.

Yeah. Really, it would be nice to imply that it somehow does the same
DWIM lookup that we do for local refs. But I didn't know how to say
that. Possibly we could refer to the documentation, but it's buried in
git-rev-parse.

> > Also, as an aside, I wonder if we should allow "heads/foo" to work as
> > "refs/heads/foo" (even when no such ref already exists). But that is
> > totally orthogonal to changing the message.
> 
> I am neutral on this point but agree that it is better done outside
> this patch.

Yeah, definitely. I would almost call it a leftover bit, but I think the
subtlety is not in the code, but in whether it is a good thing to be
doing (i.e., too many false positives).

-Peff
