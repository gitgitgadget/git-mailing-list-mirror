Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 898D21F403
	for <e@80x24.org>; Sat,  9 Jun 2018 09:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbeFIJVi (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 05:21:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:39988 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753178AbeFIJVi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 05:21:38 -0400
Received: (qmail 27298 invoked by uid 109); 9 Jun 2018 09:21:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Jun 2018 09:21:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2275 invoked by uid 111); 9 Jun 2018 09:21:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 09 Jun 2018 05:21:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Jun 2018 05:21:36 -0400
Date:   Sat, 9 Jun 2018 05:21:36 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] fsck: avoid looking at NULL blob->object
Message-ID: <20180609092135.GC6817@sigill.intra.peff.net>
References: <20180609083159.GA6158@sigill.intra.peff.net>
 <CAN0heSqHRpOerHV8tgA-ntU6QvYQMxgrXPCPsrVcHLKUSwANXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqHRpOerHV8tgA-ntU6QvYQMxgrXPCPsrVcHLKUSwANXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 09, 2018 at 10:50:36AM +0200, Martin Ågren wrote:

> On 9 June 2018 at 10:32, Jeff King <peff@peff.net> wrote:
> > Except it _does_ do one non-trivial thing, which is call the
> > report() function, which wants us to pass a pointer to a
> > "struct object". Which we don't have (we have only a "struct
> > object_id"). So we erroneously passed the NULL object, which
> 
> s/passed/dereferenced/? Probably doesn't affect the fix though.

Well, we passed it, and then that function dereferenced it. :)

I'm going to re-roll for the minor bits that Eric pointed out, so I'll
try to word this better.

-Peff
