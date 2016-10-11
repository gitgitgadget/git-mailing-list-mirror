Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B85C1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 19:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbcJKTBO (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 15:01:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:55968 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751288AbcJKTBF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 15:01:05 -0400
Received: (qmail 575 invoked by uid 109); 11 Oct 2016 19:01:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Oct 2016 19:01:05 +0000
Received: (qmail 11959 invoked by uid 111); 11 Oct 2016 19:01:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Oct 2016 15:01:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Oct 2016 15:01:03 -0400
Date:   Tue, 11 Oct 2016 15:01:03 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Allow "git shortlog" to group by committer information
Message-ID: <20161011190103.fovcwsze77hkew4t@sigill.intra.peff.net>
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 11:45:58AM -0700, Linus Torvalds wrote:

> In some situations you may want to group the commits not by author,
> but by committer instead.
> 
> For example, when I just wanted to look up what I'm still missing from
> linux-next in the current merge window, I don't care so much about who
> wrote a patch, as what git tree it came from, which generally boils
> down to "who committed it".
> 
> So make git shortlog take a "-c" or "--committer" option to switch
> grouping to that.

I made a very similar patch as part of a larger series:

  http://public-inbox.org/git/20151229073515.GK8842@sigill.intra.peff.net/

but never followed through with it because it wasn't clear that grouping
by anything besides author was actually useful to anybody.

My implementation is a little more complicated because it's also setting
things up for grouping by trailers (so you can group by "signed-off-by",
for example). I don't know if that's useful to your or not.

I'm fine with this less invasive version, but a few suggestions:

 - do you want to call it --group-by=committer (with --group-by=author
   as the default), which could later extend naturally to other forms of
   grouping?

 - you might want to steal the tests and documentation from my patch
   (though obviously they would need tweaked to match your interface)

-Peff
