Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A21B1F405
	for <e@80x24.org>; Tue, 18 Dec 2018 18:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbeLRSCB (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 13:02:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:45194 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726611AbeLRSCA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 13:02:00 -0500
Received: (qmail 3176 invoked by uid 109); 18 Dec 2018 18:02:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Dec 2018 18:02:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15285 invoked by uid 111); 18 Dec 2018 18:01:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Dec 2018 13:01:33 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Dec 2018 13:01:59 -0500
Date:   Tue, 18 Dec 2018 13:01:59 -0500
From:   Jeff King <peff@peff.net>
To:     Adilson de Almeida Junior <adilson.smem@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Merge behavior with merge.conflictStyle diff3
Message-ID: <20181218180158.GC31070@sigill.intra.peff.net>
References: <CAKmxmfosaExDYNyoaNg2teHMzsu3JJ3bqiLhrAaUt0Jt473Phw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKmxmfosaExDYNyoaNg2teHMzsu3JJ3bqiLhrAaUt0Jt473Phw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 18, 2018 at 03:34:20PM -0200, Adilson de Almeida Junior wrote:

> I guess, most times the second behavior is the expected: two conflict
> hunks, not only the divvergent pieces (this case, the second line) of
> them. By the doc:
> 
> merge.conflictStyle
> 
>     Specify the style in which conflicted hunks are written out to
> working tree files upon merge. The default is "merge", which shows a
> [[[[[[[ conflict marker, changes made by one side, a ======= marker,
> changes made by the other side, and then a ]]]]]]] marker. An
> alternate style, "diff3", adds a ||||||| marker and the original text
> before the ======= marker.
> 
> I replaced the 'lower than' and 'greater than' symbols by 'open n
> close square brackets' to avoid antivirus.
> 
> Is this a bug, or something I missunderstood from git docs?

This is the expected behavior. There's some philosophical discussion
about the correct thing to do here in this thread (that message and its
replies, but the whole thread is an interesting read):

  https://public-inbox.org/git/7vvc94p8hb.fsf@alter.siamese.dyndns.org/

Note that there is a patch in that thread to implement "zdiff3", which
does what you want. I've been rebasing it and running with it for
several years now. You can get my rebased version by fetching:

  https://github.com/peff/git ukk/zdiff3

But note that I think it may have a subtle bug, as I have once or twice
over the years seen it cause a segfault.

-Peff
