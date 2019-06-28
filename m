Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B50811F461
	for <e@80x24.org>; Fri, 28 Jun 2019 23:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfF1X7F (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 19:59:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:54690 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726643AbfF1X7F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 19:59:05 -0400
Received: (qmail 15989 invoked by uid 109); 28 Jun 2019 23:59:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Jun 2019 23:59:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21987 invoked by uid 111); 28 Jun 2019 23:59:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Jun 2019 19:59:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2019 19:59:03 -0400
Date:   Fri, 28 Jun 2019 19:59:03 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (Thurs. June 27)
Message-ID: <20190628235903.GB2625@sigill.intra.peff.net>
References: <49d98293-9f0b-44e9-cb07-d6b7ac791eb6@gmail.com>
 <14689d27-eecd-2e0a-715d-796b20d573e5@gmail.com>
 <20190628064520.GB19777@sigill.intra.peff.net>
 <ddf13a6b-42f4-57ae-49f1-8cc758b1dc4b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ddf13a6b-42f4-57ae-49f1-8cc758b1dc4b@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 08:23:49AM -0400, Derrick Stolee wrote:

> On 6/28/2019 2:45 AM, Jeff King wrote:
> > On Thu, Jun 27, 2019 at 01:35:17PM -0400, Derrick Stolee wrote:
> > 
> >>> t/helper/test-example-decorate.c
> >>> 0ebbcf70 29) one = lookup_unknown_object(&one_oid);
> >>> 0ebbcf70 30) two = lookup_unknown_object(&two_oid);
> >>> 0ebbcf70 59) three = lookup_unknown_object(&three_oid);
> >>
> >> Peff: again interesting that these lines you refactored were not covered, especially
> >> because they are part of a test helper. Perhaps the tests they were intended for are
> >> now defunct?
> > 
> > They should be run by t9004 (and if I replace them with a `die`, they
> > clearly are). Are you sure your coverage script is not mistaken?
> 
> It looks like I'm missing the 9000+ tests. The following line was in the script
> I adapted from another CI job:
> 
> 	rm -f t/t9*.sh
> 
> This was probably because the job I adapted from needed to run quickly, but for
> this coverage report we should do the hard work of running whatever t9*.sh tests
> we can.

I suspect most of those _are_ low-value. The git-p4 tests, for instance,
are mostly exercising the p4 script and not our C code, and the same
with git-svn. However I wouldn't be surprised if there are a few dusty
corners they manage to hit that aren't covered elsewhere.

Still, if it's not too painful to add them in time-wise, it probably
makes sense for the coverage tests to be as exhaustive as possible.

-Peff
