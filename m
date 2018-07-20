Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 186D01F597
	for <e@80x24.org>; Fri, 20 Jul 2018 00:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbeGTBl2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 21:41:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:53542 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727743AbeGTBl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 21:41:28 -0400
Received: (qmail 18218 invoked by uid 109); 20 Jul 2018 00:55:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Jul 2018 00:55:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18602 invoked by uid 111); 20 Jul 2018 00:55:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 19 Jul 2018 20:55:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2018 20:55:45 -0400
Date:   Thu, 19 Jul 2018 20:55:45 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] introduce "banned function" list
Message-ID: <20180720005545.GB2179@sigill.intra.peff.net>
References: <20180719203259.GA7869@sigill.intra.peff.net>
 <20180719203901.GA8079@sigill.intra.peff.net>
 <CAPig+cSErDoZ5XFjfJsqfEKZ6PSKfOos=9HW-7FDXU1XEtuktA@mail.gmail.com>
 <20180719212700.GA13151@sigill.intra.peff.net>
 <CAPig+cTbvKZ6Ui_ib2g2Xqbv8zFwJp9idocbWaZLxj0Lpe+YBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTbvKZ6Ui_ib2g2Xqbv8zFwJp9idocbWaZLxj0Lpe+YBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 05:59:47PM -0400, Eric Sunshine wrote:

> > The one I brainstormed (but forgot to mention) is that it might be
> > possible for a platform to have strcpy as a macro already? In which case
> > we'd need to #undef it or risk a compilation error (even if the macro
> > isn't actually used).
> 
> I have some recollection (perhaps long outdated or just wrong) of
> Microsoft headers spewing deprecation warnings about "unsafe"
> functions. I don't know whether they did that by covering functions
> with macros or by decorating the function with a deprecation attribute
> or by some other mechanism, but such concern seems well-founded.
> #undef'ing them might indeed be a very good preventative tactic.

Yeah, these functions are definitely on their "SDL banned list". I don't
know how they implement that. At that level, I'd really expect it to be
done with a deprecated attribute next to the declaration (I also
considered trying to add deprecation attributes, too, but I think it's
hard to do without re-declaring the function, and anyway it's "just" a
warning).

-Peff
