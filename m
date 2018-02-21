Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C34D61F404
	for <e@80x24.org>; Wed, 21 Feb 2018 22:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbeBUWuF (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 17:50:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:60028 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751104AbeBUWuE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 17:50:04 -0500
Received: (qmail 19516 invoked by uid 109); 21 Feb 2018 22:50:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Feb 2018 22:50:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28475 invoked by uid 111); 21 Feb 2018 22:50:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Feb 2018 17:50:51 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Feb 2018 17:50:02 -0500
Date:   Wed, 21 Feb 2018 17:50:02 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: Question about get_cached_commit_buffer()
Message-ID: <20180221225002.GB7944@sigill.intra.peff.net>
References: <ecbbe515-b7a8-3dc8-7d14-32412e7b12c3@gmail.com>
 <20180220225726.GA17496@sigill.intra.peff.net>
 <22169205-8020-c816-0968-f6293e8d40bc@gmail.com>
 <20180221184811.GD4333@sigill.intra.peff.net>
 <xmqqtvuax9te.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtvuax9te.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 02:22:05PM -0800, Junio C Hamano wrote:

> > I think that repeating the oid is intentional; the point is to dump how
> > the traversal code is hitting the endpoints, even if we do so multiple
> > times.
> >
> > The --oneline behavior just looks like a bug. I think --format is broken
> > with --show-all, too (it does not show anything!).
> 
> I do not know about the --format thing,[...]

Hmm, maybe it is fine. I thought before that I got funny output out of
"git log --show-all --format", but I can't seem to reproduce it now.

> being a bug is correct.  I've known about the oneline that does not
> show anything other than the oid (not even end-of-line) for unparsed
> commits for a long time---I just didn't bother looking into fixing
> it exactly because this is only a debugging aid ;-)

Out of curiosity, do you actually use --show-all for anything? I didn't
even know it existed until this thread, and AFAICT nobody but Linus has
ever recommended its use. And it does not even seem that useful as a
general debugging aid.

So what I'm wondering is whether we should consider just ripping it out
(but I'm OK with keeping it, as once the commit-buffer stuff is fixed,
it's probably not hurting anybody).

-Peff
