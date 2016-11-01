Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 842C020229
	for <e@80x24.org>; Tue,  1 Nov 2016 20:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752217AbcKAU7U (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 16:59:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:37202 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbcKAU7T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 16:59:19 -0400
Received: (qmail 24802 invoked by uid 109); 1 Nov 2016 20:59:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Nov 2016 20:59:19 +0000
Received: (qmail 29922 invoked by uid 111); 1 Nov 2016 20:59:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Nov 2016 16:59:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Nov 2016 16:59:16 -0400
Date:   Tue, 1 Nov 2016 16:59:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.11.0-rc0
Message-ID: <20161101205916.d74n6lhgp2hexpzr@sigill.intra.peff.net>
References: <xmqq1sywrxxl.fsf@gitster.mtv.corp.google.com>
 <20161101203637.3jr73wwpfal4brho@sigill.intra.peff.net>
 <xmqqlgx2or5p.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgx2or5p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2016 at 01:56:34PM -0700, Junio C Hamano wrote:

> > As of -rc0, we have both --indent-heuristic and --compaction-heuristic
> > (along with matching config), and they are mutually exclusive.
> >
> > In [1], Stefan suggested just replacing the compaction heuristic
> > entirely with the new one (and you seemed to agree). If we're going to
> > do that, it makes sense to do so before the release, so that we don't
> > get stuck supporting --indent-heuristic forever.
> 
> You meant "compaction" in the last part?  I think it is probably a
> good idea.

I thought the plan mentioned in the mail I linked was to keep the indent
heuristic, but simply _call_ it the compaction heuristic. IOW, to swap
out the implementation under the hood for something we know is better.

We've already released a version with --compaction-heuristic, so we are
stuck keeping it forever either way.

> I'd vote for just removing compaction-heuristic while keeping the
> indent-heuristic with experimental label and knobs and keeping it
> off by default for a while.

So the matching variant of that plan would be to drop the internals of
compaction-heuristic, swap in the new heuristic instead, and then drop
all of the --indent-heuristic. It remains off by default, but we may
flip that in a later release.

-Peff
