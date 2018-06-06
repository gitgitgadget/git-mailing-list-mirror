Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958E01F517
	for <e@80x24.org>; Wed,  6 Jun 2018 21:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752451AbeFFVDD (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 17:03:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:36852 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752026AbeFFVDD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 17:03:03 -0400
Received: (qmail 32327 invoked by uid 109); 6 Jun 2018 21:03:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Jun 2018 21:03:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9519 invoked by uid 111); 6 Jun 2018 21:03:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Jun 2018 17:03:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jun 2018 17:03:00 -0400
Date:   Wed, 6 Jun 2018 17:03:00 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 2/2] json-writer: t0019: add Python unit test
Message-ID: <20180606210300.GA1879@sigill.intra.peff.net>
References: <20180605163358.119080-1-git@jeffhostetler.com>
 <20180605163358.119080-3-git@jeffhostetler.com>
 <20180606171052.GI3094@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180606171052.GI3094@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 06, 2018 at 01:10:52PM -0400, Todd Zullinger wrote:

> git@jeffhostetler.com wrote:
> > +# As a sanity check, ask Python to parse our generated JSON.  Let Python
> > +# recursively dump the resulting dictionary in sorted order.  Confirm that
> > +# that matches our expectations.
> > +test_expect_success PYTHON 'parse JSON using Python' '
> [...]
> > +	python "$TEST_DIRECTORY"/t0019/parse_json_1.py <output.json >actual &&
> 
> Would this be better using $PYTHON_PATH rather than
> hard-coding python as the command?

Probably. We may want to go the same route as we did for perl in 
a0e0ec9f7d (t: provide a perl() function which uses $PERL_PATH,
2013-10-28) so that test writers don't have to remember this.

That said, I wonder if it would be hard to simply do the python bits
here in perl. This is the first use of python in our test scripts (and
really the only user in the whole code base outside of a few fringe
commands). Leaving aside any perl vs python flame-war, I think there's
value in keeping the number of languages limited when there's not a
compelling reason to do otherwise.

-Peff
