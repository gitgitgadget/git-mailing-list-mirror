Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 315AF20357
	for <e@80x24.org>; Sun,  9 Jul 2017 09:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbdGIJ2n (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 05:28:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:34684 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751763AbdGIJ2m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 05:28:42 -0400
Received: (qmail 1085 invoked by uid 109); 9 Jul 2017 09:28:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 09 Jul 2017 09:28:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31918 invoked by uid 111); 9 Jul 2017 09:28:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 09 Jul 2017 05:28:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jul 2017 05:28:34 -0400
Date:   Sun, 9 Jul 2017 05:28:34 -0400
From:   Jeff King <peff@peff.net>
To:     Leo Razoumov <slonik.az@gmail.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git-2.13.2: color.branch.local problem
Message-ID: <20170709092834.nxfmqsxieg6boujh@sigill.intra.peff.net>
References: <CADsUFkTuRK7wgtvZ16Dw-5y2CFXZByTBzNky6cQb0RzT58C5WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADsUFkTuRK7wgtvZ16Dw-5y2CFXZByTBzNky6cQb0RzT58C5WQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 08, 2017 at 03:13:04PM -0400, Leo Razoumov wrote:

> When I updated from git-2.10.2 to git-2.13.2 my 'color.branch.local'
> config setting gets ignored. Corresponding 'remote' or 'current'
> settings are honored and work as expected

Looks like this is a regression from the switch to ref-filter in
v2.13.0; it bisects to 949af0684 (branch: use ref-filter printing APIs,
2017-01-10). It looks like we don't ever use BRANCH_COLOR_LOCAL. The fix
is a little tricky because of another nearby issue. I'll send out a
patch in a moment.

-Peff
